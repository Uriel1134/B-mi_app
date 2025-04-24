# Instructions de Collaboration - Bemi App

## Configuration Initiale

1. **Cloner le dépôt**
```bash
git clone https://github.com/Uriel1134/B-mi_app.git
cd B-mi_app
```

2. **Créer sa branche de travail**
```bash
# Pour le développeur de l'authentification
git checkout -b feature/auth-flow

# Pour le développeur de la HomePage
git checkout -b feature/home-flow
```

## Workflow de Travail Quotidien

1. **Avant de commencer à travailler**
```bash
# Se mettre à jour avec la branche master
git checkout master
git pull origin master

# Revenir sur sa branche de travail
git checkout feature/[votre-branche]
git merge master
```

2. **Pendant le développement**
```bash
# Ajouter les modifications
git add .

# Commiter les changements
git commit -m "Description claire des modifications"

# Pousser les changements
git push origin feature/[votre-branche]
```

## Bonnes Pratiques

1. **Messages de commit**
- Soyez clair et concis
- Utilisez le présent de l'indicatif
- Exemple : "Ajoute l'écran de connexion" au lieu de "J'ai ajouté l'écran de connexion"

2. **Fréquence des commits**
- Commitez régulièrement (au moins une fois par jour)
- Un commit par fonctionnalité
- Ne pas accumuler trop de changements dans un seul commit

3. **Structure du code**
- Respecter la structure des dossiers existante
- Pour l'authentification : utiliser le dossier `lib/auth/`
- Pour la HomePage : utiliser le dossier `lib/home/`

## Résolution des Conflits

Si vous rencontrez un conflit :
1. Ne pas paniquer
2. Communiquer avec l'autre développeur
3. Résoudre le conflit ensemble
4. Tester les modifications après résolution

## Pull Requests

1. **Avant de créer une PR**
- Vérifier que tout fonctionne
- S'assurer que les tests passent
- Vérifier qu'il n'y a pas de conflits

2. **Création d'une PR**
- Aller sur GitHub
- Cliquer sur "New Pull Request"
- Sélectionner la branche à merger
- Ajouter une description claire
- Assigner un reviewer

## Communication

- Utiliser les issues GitHub pour le suivi des tâches
- Commenter le code pour expliquer les parties complexes
- Documenter les nouvelles fonctionnalités

## En Cas de Problème

1. **Si vous perdez vos modifications locales**
```bash
git stash
git pull origin master
git stash pop
```

2. **Si vous voulez annuler des modifications non commitées**
```bash
git checkout -- .
```

3. **Si vous voulez annuler le dernier commit**
```bash
git reset HEAD~1
```

## Contacts

## Ressources Utiles

- Documentation Flutter : https://flutter.dev/docs
- Documentation Git : https://git-scm.com/doc
- Repository GitHub : https://github.com/Uriel1134/B-mi_app
