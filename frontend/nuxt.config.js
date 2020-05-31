import colors from 'vuetify/es5/util/colors'
import FMMode from 'frontmatter-markdown-loader/mode'

export default {
  mode: 'spa',

  // Headers
  head: {
    titleTemplate: 'BDC 2020 Report',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'Effectiveness of Diagnostic and Treatment Modalities for Breast and Prostate Cancer in Countries with Variable Levels of Development' }
    ],
    link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }]
  },

  // Modules
  buildModules: ['@nuxtjs/vuetify'],
  modules: ['@nuxtjs/axios'],

  //Module Config
  axios: {
    baseURL: process.env.backend_url || 'http://localhost:5000'
  },

  //UI Config
  loading: { color: '#fff' },
  vuetify: {
    theme: {
      dark: false,
      themes: {
        dark: {
          primary: colors.blue.darken2,
          accent: colors.grey.darken3,
          secondary: colors.amber.darken3,
          info: colors.teal.lighten1,
          warning: colors.amber.base,
          error: colors.deepOrange.accent4,
          success: colors.green.accent3
        }
      }
    }
  },

  build: {
    extend(config, ctx) {
      config.module.rules.push({
          test: /\.md$/,
          loader: "frontmatter-markdown-loader",
          options: {
            mode: [FMMode.VUE_COMPONENT],
          }
        })
    }
  }
}
