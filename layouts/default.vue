<template>
  <v-app dark>
    <v-toolbar
      fixed
      app
    >
      Docker Web Terminal
    </v-toolbar>
    <v-content>
      <v-container>
        <nuxt />
      </v-container>
    </v-content>
    <v-footer>
      <span>&copy; Takafumi Fukuyo 2019</span>
    </v-footer>
  </v-app>
</template>

<script>
export default {
};
</script>
