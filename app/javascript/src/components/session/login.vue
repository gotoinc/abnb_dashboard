<template>
  <div>
    <div class="form-group">
      <label>Email:</label>
        <span class='error'>{{ errors.email }}</span>
      </label>
      <input type="text" v-model="user.email" class="form-control">
    </div>
    <div class="form-group">
      <label>Password:</label>
        <span class='error'>{{ errors.password }}</span>
      </label>
      <input type="password" v-model="user.password" class="form-control">
    </div>
    <submit-tag value="Login" klass="btn btn-warning pull-right" :progress="progress"></submit-tag>
  </div>
</template>