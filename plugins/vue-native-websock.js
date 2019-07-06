import Vue from 'vue';
import VueNativeSock from 'vue-native-websocket';

Vue.use(VueNativeSock, `ws://localhost:${process.env.SERVER_PORT}`, { format: 'json' });
