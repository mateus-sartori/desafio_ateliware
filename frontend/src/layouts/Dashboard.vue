<template>
  <div>
    <navbar />
    <div class="container">
      <router-view />
    </div>
  </div>
</template>

<script>
import Navbar from "src/components/Navbar";
export default {
  name: "Dashboard",
  components: {
    Navbar,
  },
};
</script>

<style></style>
