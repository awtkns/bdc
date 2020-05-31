<template>
  <v-app>

    <v-content>
      <v-container>
        <nuxt />
      </v-container>
    </v-content>

    <v-speed-dial  v-model="fab" fixed bottom right>
      <template v-slot:activator>
        <v-btn v-model="fab" dark fab>
          <v-icon v-if="fab">mdi-close</v-icon>
          <v-icon v-else>mdi-menu</v-icon>
        </v-btn>
      </template>

        <!-- Home -->
        <v-tooltip v-if="$route.path !== '/'" left >
          <template v-slot:activator="{ on }">
            <v-btn fab dark v-on="on" to="/">
              <v-icon>mdi-home</v-icon>
            </v-btn>
          </template>
          <span>Report</span>
        </v-tooltip>

        <!-- Raw Data -->
        <v-tooltip v-if="$route.path !== '/data'" left>
          <template v-slot:activator="{ on }">
            <v-btn fab dark v-on="on" to="data">
              <v-icon>mdi-file-table</v-icon>
            </v-btn>
          </template>
          <span>Raw Data</span>
        </v-tooltip>

        <!-- Sources -->
        <v-tooltip v-if="$route.path !== '/sources'" left>
          <template v-slot:activator="{ on }">
            <v-btn fab dark v-on="on" to="sources">
              <v-icon>mdi-book-open-page-variant</v-icon>
            </v-btn>
          </template>
          <span>Sources</span>
        </v-tooltip>

        <!-- Sources -->
        <v-tooltip left>
          <template v-slot:activator="{ on }">
            <v-btn fab dark v-on="on" @click="toggleDarkMode">
              <v-icon>mdi-lightbulb</v-icon>
            </v-btn>
          </template>
          <span>Toggle Dark Mode</span>
        </v-tooltip>
    </v-speed-dial>
  </v-app>
</template>

<script>
export default {
  data: () => ({
    drawer: false,
    fab: false
  }),
  methods: {
    toggleDarkMode() { return  this.$vuetify.theme.dark = !this.$vuetify.theme.dark }
  }
}
</script>
