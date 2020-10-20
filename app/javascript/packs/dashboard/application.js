import Vue from 'vue/dist/vue.esm';
// import store from '../../src/dashboard/vuex';
import router from '../../src/dashboard/routes.js';

// import NavTop from '../../src/admin/components/shared/_nav_top';

// Vue.component('nav-top', NavTop);

// $.ajaxSetup({
//     beforeSend: function(xhr) {
//         xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
//     },
//     complete: function(xhr, status) {
//         if(xhr.status === 500) {
//             return window.location.href = '/500';
//         }
//         if(xhr.status === 401) {
//             return window.location.href = '/users/sign_in';
//         }
//         if(xhr.status === 404) {
//             return window.location.href = '/404';
//         }
//
//         return true;
//     }
// })
// $.ajaxPrefilter(function( options ) {
//     options.url = `/api/admin/${options.url}`;
// });

const app = new Vue({
    router,
    // store
})

app.$mount('#app')
