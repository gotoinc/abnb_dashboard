import helpers from '../../helpers';

const UserStore = {
    namespaced: true,
    state: {
        user: {},
        errors: {},
        progress: '',
    },
    mutations: {
        one(state, data) {
            state.errors = {}
            state.user = data.user;
            return state;
        },
        progress(state, step) {
            state.progress = step;
            return state.progress;
        },
        errors(state, data) {
            state.errors = helpers.showErrors(data);
            return state.errors;
        }
    },
    actions: {
        new(context, id) {
            $.ajax({
                url: `users/new`,
                type: 'get',
                success: function(data) {
                    context.commit('one', data)
                }
            })
        },
        create(context, form) {
            context.commit('progress', 'loading')
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: `users`,
                    type: 'post',
                    data: {
                        user: form
                    },
                    success: function(data) {
                        context.commit('progress', 'success')
                        resolve(data);
                    },
                    error: function(data) {
                        context.commit('progress', 'failed')
                        context.commit('errors', data);
                    }
                })
            })
        },
        destroy(context, user_id) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: `users/${user_id}`,
                    type: 'delete',
                    success: function(data) {
                        resolve(data);
                    },
                    error: function(data) {
                        reject(data);
                    }
                });
            });
        }
    }
};

export default UserStore;
