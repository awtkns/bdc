import pandas as pd
import numpy as np
import os
import inflection


class TableCombiner:
    def __init__(self, initial):
        master = pd.read_csv(initial)
        master['year'] = master['year'].astype(str)
        master = master.set_index(['country', 'year'])
        master = master.iloc[:, 3:]

        self.df: pd.DataFrame = master

    def export(self, file_name):
        self.df.index.levels[1].astype(int)
        self.df.sort_index(ascending=[True, False], inplace=True)
        self.df.to_csv(file_name)

    def combine_years(self):
        df = self.df
        self.df.to_csv('checkup.csv')
        df = df.replace({np.nan: None})

        d = {}
        for row in list(df.iterrows()):
            country = row[0][0]
            sr = row[1]

            if country not in d.keys():
                d[country] = {}

                for key, value in sr.iteritems():
                    d[country][key] = value

            else:
                for key, value in sr.iteritems():
                    if not d[country][key]:
                        d[country][key] = value

        for index, row in d.items():
            d[index] = list(d[index].values())

        df = pd.DataFrame.from_dict(d, orient='index', columns=df.columns)
        df.to_csv('grouped_master.csv')

    def join(self, title, file_path):
        df = pd.read_csv(file_path, index_col='country')
        df = df.stack().to_frame()
        df.columns = [title]
        df.index = df.index.set_names('year', level=1)

        self.df = self.df.join(df)


if __name__ == '__main__':
    tc = TableCombiner('initial.csv')

    os.chdir('to_join')
    for f in os.listdir(os.getcwd()):
        tc.join(title=inflection.humanize(f.strip('.csv')), file_path=f)
    os.chdir(os.path.pardir)

    tc.export('joined.csv')
    tc.combine_years()


