import Vue from 'vue/dist/vue.esm';
import VueRouter from 'vue-router';
Vue.use(VueRouter);

import LoginPage from './components/session/login.vue';
import ErrorIndex from './components/errors/index.vue';
import Error500 from './components/errors/500.vue';
import Error404 from './components/errors/404.vue';

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: LoginPage, name: 'root_path' },
    { path: '/errors', component: ErrorIndex, name: 'errors_path' },
    { path: '/500', component: Error500 },
    { path: '/404', component: Error404 },
    { path: '*', redirect: '/404' }
  ]
});

export default router;
