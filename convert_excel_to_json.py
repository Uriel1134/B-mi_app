import pandas as pd
import json

# Lire le fichier Excel
df = pd.read_excel('worldcities.xlsx')

# Afficher les informations sur le fichier
print("\nInformations sur le fichier :")
print("--------------------------------")
print(f"Nombre de lignes : {len(df)}")
print(f"Colonnes présentes : {list(df.columns)}")
print("\nPremières lignes du fichier :")
print("--------------------------------")
print(df.head())

# Convertir les données en format JSON
cities_json = df.to_json(orient='records', force_ascii=False)

# Écrire dans un fichier JSON
with open('assets/data/worldcities.json', 'w', encoding='utf-8') as f:
    f.write(cities_json)

print("\nConversion terminée ! Le fichier JSON a été créé dans assets/data/worldcities.json") 