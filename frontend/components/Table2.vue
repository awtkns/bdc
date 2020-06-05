<template>
  <v-row justify="center">
    <v-col>
      <v-hover v-slot:default="{ hover }" open-delay="100">
        <v-card :elevation="hover ? 10 : 0" outlined>
          <v-data-table :headers="headers" :items="rows" hide-default-footer dense>
            <template v-slot:header>
              <thead class="v-data-table-header">
                <tr>
                  <th
                    :colspan="1"
                    class="text-center parent-header ma-0 pa-0"
                  />
                  <th
                    :colspan="4"
                    v-text="'Breast cancer per 100k women'"
                    class="text-center parent-header ma-0 pa-0"
                  />
                  <th
                    :colspan="4"
                    v-text="'Prostate cancer per 100k men'"
                    class="text-center parent-header ma-0 pa-0"
                  />
                </tr>
              </thead>
            </template>
          </v-data-table>
        </v-card>
      </v-hover>
    </v-col>
  </v-row>
</template>

<script>
export default {
  name: "Table1",
  data: () => ({
    headers: [
      { text: 'Modality', align: 'center', value: 'modality', divider: true, sortable: false, },
      { text: '1st', value: 'b1' },
      { text: '2nd', value: 'b2' },
      { text: '3rd', value: 'b3' },
      { text: '4th', value: 'b4',  divider: true, },
      { text: '1st', value: 'p1' },
      { text: '2nd', value: 'p2' },
      { text: '3rd', value: 'p3' },
      { text: '4th', value: 'p4' },
    ],
    rows: [
      {
        modality: 'CT',
        b1: 0.075, b2: 0.17, b3: 0.045, b4: 0.25,
        p1: 0.017, p2: 0.17, p3: 0.015, p4: 0.16
      },
      {
        modality: 'MRI',
        b1: 0.079, b2: 0.12, b3: 0.016, b4: 0.38,
        p1: 0.028, p2: 0.13, p3: 0.065, p4: 0.16
      },
      {
        modality: 'PET',
        b1: 0.14, b2: 0.077, b3: 0.19, b4: 0.14,
        p1: 0.32, p2: 0.094, p3: 0.00052, p4: 0.13
      },
      {
        modality: 'Gamma',
        b1: 0.029, b2: 0.14, b3: 0.11, b4: 0.31,
        p1: 0.0028, p2: 0.13, p3: 0.065, p4: 0.16
      },
      {
        modality: 'Diagnostic',
        b1: 0.061, b2: 0.21, b3: 0.038, b4: 0.4,
        p1: 0.03, p2: 0.19, p3: 0.00032, p4: 0.27
      },
      {
        modality: 'LINAC',
        b1: 0.025, b2: 0.075, b3: 0.05, b4: 0.45,
        p1: 0.012, p2: 0.082, p3: 0.014, p4: 0.37
      },
      {
        modality: 'Cobalt',
        b1: 0.074, b2: 0.14, b3: 0.059, b4: 0.038,
        p1: 0.048, p2: 0.16, p3: 0.07, p4: 0.0024
      },
      {
        modality: 'Treatment',
        b1: 0.086, b2: 0.14, b3: 0.097, b4: 0.44,
        p1: 0.043, p2: 0.16, p3: 0.076, p4: 0.42
      },
    ]
  })
}
</script>

<style scoped>

</style>
