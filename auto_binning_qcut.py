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
cats = ['Categoria1', 'Categoria2', 'Categoria3']

df3['bucket_idade_operacao'] = pd.qcut(df3['idade'], q=3, labels = cats)

df3.sort_values(by=['bucket_idade_operacao'], ascending=True)

df3.head(10)