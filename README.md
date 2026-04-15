# Azure Deploy App

This folder is a standalone Flask app for Azure App Service.

It is intentionally separate from the main portfolio app. The purpose is:

- serve the card analysis viewer directly from Azure
- optionally serve the `/play` playground
- keep Azure deployment files isolated from the main site

## Repo Boundary

`azure-deploy` has its own Git repository and its own GitHub remote.

That means:

- commit Azure app changes from inside `azure-deploy`
- push Azure app changes from inside `azure-deploy`
- do not expect root-level `git status` or `git push` to manage this folder

Current remote:

- `https://github.com/Nik85-png/Cards-Azure-App.git`

## Main Files

- `app.py`: Flask backend and API routes
- `templates/index.html`: main analysis page
- `templates/play.html`: playground page
- `static/js/app.js`: analysis viewer logic
- `static/js/play.js`: playground logic
- `static/css/styles.css`: analysis page styles
- `static/css/play.css`: playground styles
- `data/card_analysis_data.json`: source dataset used by the Azure app

## Local Run

Use Python 3.12.

```powershell
cd N:\website\auto-annotated-portfolio-9bdeb\azure-deploy
py -3.12 -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
python app.py
```

Open:

- `http://127.0.0.1:8000/`
- `http://127.0.0.1:8000/health`

## Azure App Settings

Recommended environment variables:

- `CARD_DATA_PATH`
- `PLAY_DB_PATH`
- `PARENT_ORIGIN`
- `ALLOWED_ORIGINS`
- `ENABLE_PLAYGROUND`
- `ENABLE_GIF_EXPORT`
- `ENABLE_HISTORY_TAB`

See `app_settings.example.txt`.

## Important Rules

- Do not commit `play_sessions.db`
- Do not commit `__pycache__`
- Do not copy runtime-generated files into this repo
- Treat this as the Azure source of truth, not as a scratch folder

## Commit Flow

```powershell
cd N:\website\auto-annotated-portfolio-9bdeb\azure-deploy
git status
git add .
git commit -m "Describe the Azure app change"
git push origin main
```

If Git says there is an `index.lock` file, close any editor/process using the repo and delete:

- `.git/index.lock`

before retrying the commit.
