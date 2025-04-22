import subprocess
import re

def run_cmd(cmd):
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout.strip()

# 1. Obtenir le dernier tag
last_tag = run_cmd("git describe --tags --abbrev=0 2>NUL")

if not last_tag:
    new_version = "v0.01"
else:
    match = re.match(r"v(\d+)\.(\d+)", last_tag)
    if match:
        major, minor = int(match.group(1)), int(match.group(2)) + 1
        new_version = f"v{major}.{minor:02d}"
    else:
        raise ValueError("Format de tag Git non reconnu (attendu: vX.XX)")

# 2. Demander le commentaire de commit
comment = input(f"💬 Entrez le message de commit pour {new_version} : ").strip()

# 3. Lancer les commandes Git
print("🚀 En cours de commit...")
subprocess.run("git status", shell=True)
subprocess.run("git add .", shell=True)
subprocess.run(f'git commit -m "{new_version} {comment}"', shell=True)
subprocess.run(f"git tag {new_version}", shell=True)
subprocess.run("git push origin main", shell=True)
subprocess.run(f"git push origin tag {new_version}", shell=True)

print(f"✅ Version {new_version} poussée avec succès !")