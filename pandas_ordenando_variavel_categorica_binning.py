# Ordenando dados categóricos

import numpy as np
import pandas as pd

df3 = pd.DataFrame(
    {
        "id": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        "idade": [1, 2, 2, 3, 1, 5, 24, 14, 16, 8]
        
    }
)

#Feature binning
cats = ['Até 2 meses','3 ~ 5 meses', '6 ~ 8 meses', '9 ~ 12 meses', '13 ~ 16 meses', '17 ~ 24 meses', 'acima de 24 meses']
bins = [0, 2, 5, 8, 12, 16, 24, np.inf]
df3['bucket_idade_operacao'] = pd.cut(df3.idade, bins, labels=cats)

#Transforma em campo do tipo "categórico"
df3['bucket_idade_operacao'] = pd.Categorical(df3.bucket_idade_operacao, cats)

df3.sort_values(by=['bucket_idade_operacao'], ascending=True)
