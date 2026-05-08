import os

SECRET_KEY = os.getenv("SUPERSET_SECRET_KEY", "your-dev-secret-key")

FEATURE_FLAGS = {
    "EMBEDDED_SUPERSET": True,
    "EMBEDDABLE_CHARTS": True,
    "ENABLE_TEMPLATE_PROCESSING":True,
}

EMBEDDED_SUPERSET = True

GUEST_TOKEN_JWT_SECRET = os.getenv("GUEST_TOKEN_JWT_SECRET")
GUEST_TOKEN_JWT_EXP_SECONDS = 3600
GUEST_TOKEN_JWT_AUDIENCE = os.getenv("GUEST_TOKEN_JWT_AUDIENCE")
# GUEST_TOKEN_JWT_AUDIENCE=None
# GUEST_TOKEN_JWT_AUDIENCE="https://health-outcomes-h2o-superset.vhir.org"
GUEST_ROLE_NAME = "embed_dashboard"

WTF_CSRF_ENABLED = False

# SESSION_COOKIE_SAMESITE = "Lax"
# SESSION_COOKIE_SECURE = False
SESSION_COOKIE_SAMESITE = None
SESSION_COOKIE_SECURE = True

TALISMAN_ENABLED = False

ENABLE_CORS = True
CORS_OPTIONS = {
    "supports_credentials": True,
    "allow_headers": ["*"],
    "allow_methods": ["*"],
    "resources": [r"/api/.*"],
    "origins": ["*"],
}
SQLALCHEMY_DATABASE_URI = os.getenv("DATABASE_URL")

EXTRA_CATEGORICAL_COLOR_SCHEMES = [
    {
        "id": "pair_rgy_primary",
        "label": "Trio: FF3131 + 00BF63 + FFDE59",
        "description": "",
        "isDefault": False,
        "colors": ["#FF3131", "#00BF63", "#FFDE59"],
    },
    {
        "id": "customBlues",
        "label": "Custom Corporate Blues",
        "description": "",
        "isDefault": True,
        "colors": [
            "#00B5D9",
            "#0597C8",
            "#0276B6",
            "#08408B",
        ],
    },
    {
        "id": "pair_c1_c2",
        "label": "Pair: 00B5D9 + 0597C8",
        "description": "",
        "isDefault": False,
        "colors": ["#00B5D9", "#0597C8"],
    },
    {
        "id": "pair_c1_c3",
        "label": "Pair: 00B5D9 + 0276B6",
        "description": "",
        "isDefault": False,
        "colors": ["#00B5D9", "#0276B6"],
    },
    {
        "id": "pair_c1_c4",
        "label": "Pair: 00B5D9 + 08408B",
        "description": "",
        "isDefault": False,
        "colors": ["#00B5D9", "#08408B"],
    },
    {
        "id": "pair_c2_c3",
        "label": "Pair: 0597C8 + 0276B6",
        "description": "",
        "isDefault": False,
        "colors": ["#0597C8", "#0276B6"],
    },
    {
        "id": "pair_c2_c4",
        "label": "Pair: 0597C8 + 08408B",
        "description": "",
        "isDefault": False,
        "colors": ["#0597C8", "#08408B"],
    },
    {
        "id": "pair_c3_c4",
        "label": "Pair: 0276B6 + 08408B",
        "description": "",
        "isDefault": False,
        "colors": ["#0276B6", "#08408B"],
    },
    {
        "id": "pair_rgy_primary",
        "label": "Trio: FF3131 + 00BF63 + FFDE59",
        "description": "",
        "isDefault": False,
        "colors": ["#FF3131", "#00BF63", "#FFDE59"],
    }
]

print("✅ Superset Config Loaded")
print(f" - CSRF: {WTF_CSRF_ENABLED}")
print(f" - DB URI: {SQLALCHEMY_DATABASE_URI}")
print(f" - Guest Role: {GUEST_ROLE_NAME}")
print(f" - Audience: {GUEST_TOKEN_JWT_AUDIENCE}")

