# akcie
Tento projekt se zaměřuje na analýzu vývoje pěti vybraných akcií v průběhu času, konkrétně akcií firem META, Tesla, Apple a Microsoft, s datovým rozsahem od 8. února 2020 až po současnost. V rámci projektu byla využita technologie Python pro stažení historických dat o akciích, jejich následné uložení do databáze PostgreSQL a provedení pokročilých analýz. Python je také využíván pro výpočet klouzavých průměrů, což umožňuje zobrazení trendů v cenách akcií, jejich vzájemné porovnání a tvorbu predikcí.

Analýza ukázala, že akcie firem Microsoft a Apple mají vysokou korelaci 0,75, což naznačuje jejich vzájemnou závislost. Další zjištění ukazují, že všechny zkoumané akcie vykazují spíše rostoucí trend. Největší průměrnou zavírací cenu mají akcie firmy Lockheed Martin, a to 425 USD. Nejvíce volatilními akciemi jsou pak akcie firmy Meta, s volatilitou 133.

PostgreSQL byla využita k analýze kumulativního objemu akcií za rok 2020, jak je uvedeno v souboru kumulativní objem.csv, a k určení počtu dní v roce 2020, kdy zavírací cena překročila průměrnou cenu. Akcie firmy Lockheed Martin překročily průměrnou cenu nejvíce, a to v 227 dnech, což je podrobně analyzováno v souboru dny nad průměrem.csv.

Pro vizualizaci dat byl použit Power BI, který umožňuje detailní porovnání grafů a analýzu trendů vývoje akcií mezi sebou. Tento projekt tak poskytuje komplexní nástroje pro sledování a analýzu akciových trhů, stejně jako pro tvorbu obchodních strategií
