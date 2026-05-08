#!/bin/bash
set -e

echo "▶️ Iniciando Superset setup..."

superset db upgrade
superset init

# Crear usuario admin si no existe
if ! superset fab list-users | grep -q admin@example.com; then
  echo "👤 Creando usuario administrador..."
  superset fab create-admin \
    --username admin \
    --firstname Admin \
    --lastname User \
    --email admin@example.com \
    --password admin
else
  echo "✅ Usuario admin ya existe, omitiendo creación."
fi

# Crear rol embed_dashboard y asignar permisos
ROLE_NAME="embed_dashboard"
echo "🔐 Creando rol '$ROLE_NAME' con permisos específicos..."

flask shell << END
from superset import security_manager
from flask_appbuilder.security.sqla.models import PermissionView

# Crear el rol si no existe
role = security_manager.find_role("$ROLE_NAME")
if not role:
    role = security_manager.add_role("$ROLE_NAME")
    print(f"✅ Rol '$ROLE_NAME' creado.")
else:
    print(f"ℹ️ Rol '$ROLE_NAME' ya existe.")

# Lista de permisos a asignar (perm_name, view_menu_name)
permissions_to_add = [
    ("can_read", "Chart"),
    ("can_read", "Dashboard"),
    ("can_read", "Row level Security"),
    ("can_read", "RowLevelSecurity"),
    ("can_dashboard", "Superset"),
    ("can_read", "SecurityRestApi"),
    ("can_grant_guest_token", "SecurityRestApi"),
    ("all_datasource_access", "all_datasource_access"),
    ("all_database_access", "all_database_access"),
    ("all_query_access", "all_query_access"),
]

for perm_name, view_menu_name in permissions_to_add:
    pv = security_manager.find_permission_view_menu(perm_name, view_menu_name)
    if pv:
        if pv not in role.permissions:
            role.permissions.append(pv)
            print(f"🔗 Permiso '{perm_name}' sobre '{view_menu_name}' asignado a '{role.name}'.")
        else:
            print(f"✔️ Permiso '{perm_name}' sobre '{view_menu_name}' ya está asignado.")
    else:
        print(f"⚠️ PermisoView '{perm_name}' sobre '{view_menu_name}' no encontrado. Puede que no exista aún.")

security_manager.get_session.commit()
END

echo "🚀 Iniciando Superset en HTTP en http://0.0.0.0:8088"

exec gunicorn \
  -w 2 \
  -b 0.0.0.0:8088 \
  --timeout 120 \
  "superset.app:create_app()"

