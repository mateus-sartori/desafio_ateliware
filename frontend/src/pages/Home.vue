<template>
  <div>
    <div class="q-py q-mt-md">
      <div class="row items-center justify-end">
        <div class="col-12 row justify-end column-gap-md">
          <q-input
            color="white"
            bg-color="#181a1b"
            dense
            class="col-4"
            standout
            v-model="language"
            v-on:keyup.enter="loadRepositories(language)"
            label="Pesquise pela linguagem"
            label-color="grey-7"
            style="background-color: #181a1b; border: 1px solid rgb(55 60 62)"
          ></q-input>
          <q-btn
            class="col-2"
            @click="loadRepositories(language)"
            size="md"
            color="green-8"
            label="Buscar"
            icon="search"
          />
        </div>
      </div>

      <div v-if="featuredRepositories">
        <q-expansion-item class="text-h6 repo-list q-my-lg" label="Favoritos">
          <div class="text-caption">
            <q-card
              class="text-white q-mt-md"
              style="background-color: #181a1b; border: 1px solid rgb(55 60 62)"
            >
              <div
                v-for="(elem, index) in featuredRepositories"
                v-bind:key="index"
              >
                <q-card-section>
                  <div class="row justify-between">
                    <div
                      class="repo-list text-h6 repo-title"
                      @click="goTo(elem['html_url'])"
                    >
                      {{ elem["name"] }}
                    </div>
                    <div v-if="elem['favorited']" class="repo-list text-h6">
                      <q-icon
                        size="xs"
                        @click="destroyFeaturedRepository(elem)"
                        color="red-8"
                        class="repo-list heart-icon"
                        name="fas fa-heart"
                      />
                    </div>
                  </div>
                  <div class="repo-list text-subtitle3">
                    <span v-if="elem['description']">{{
                      elem["description"].substring(0, 200) + "..."
                    }}</span>
                  </div>
                  <div class="row justify-between q-mt-md">
                    <div class="repo-list text-subtitle3">
                      {{ elem["language"] }}
                    </div>
                    <div class="row items-center justify-end">
                      <div class="row column-gap-xs items-center">
                        <q-icon size="xs" class="repo-list" name="star_rate" />
                        <div class="repo-list text-subtitle2">
                          {{ elem["stars"] }}
                        </div>
                      </div>

                      <div class="row q-mx-md column-gap-xs items-center">
                        <q-icon size="xs" class="repo-list" name="visibility" />
                        <div class="repo-list text-subtitle2">
                          {{ elem["watchers"] }}
                        </div>
                      </div>

                      <div class="row column-gap-xs items-center">
                        <q-icon
                          size="xs"
                          class="repo-list"
                          name="fas fa-code-branch"
                        />
                        <div class="repo-list text-subtitle2">
                          {{ elem["forks"] }}
                        </div>
                      </div>
                    </div>
                  </div>
                </q-card-section>
                <q-separator style="border-bottom: 1px solid #373c3e" />
              </div>
            </q-card>
          </div>
        </q-expansion-item>
      </div>

      <div v-if="repositories">
        <q-expansion-item
          class="text-h6 repo-list q-my-lg"
          label="Repositórios polulares"
        >
          <div class="text-caption">
            <div class="row justify-end">
              <q-icon
                @click="loadRepositories(language)"
                size="md"
                color="grey-8"
                class="repo-list q-my-lg"
                :class="loadSpinner ? 'refresh' : ''"
                name="refresh"
              />
            </div>
            <q-card
              class="text-white q-mt-md"
              style="background-color: #181a1b; border: 1px solid rgb(55 60 62)"
            >
              <div v-for="(elem, index) in repositories" v-bind:key="index">
                <q-card-section>
                  <div class="row justify-between">
                    <div
                      class="repo-list text-h6 repo-title"
                      @click="goTo(elem['owner']['html_url'])"
                    >
                      {{ elem["name"] }}
                    </div>
                    <div v-if="!elem['favorited']" class="repo-list text-h6">
                      <q-icon
                        @click="saveFeaturedRepository(elem)"
                        size="xs"
                        color="grey-8"
                        class="repo-list heart-icon"
                        name="fas fa-heart"
                      />
                    </div>
                  </div>
                  <div class="repo-list text-subtitle3">
                    <span v-if="elem['description']">{{
                      elem["description"].substring(0, 200) + "..."
                    }}</span>
                  </div>
                  <div class="row justify-between q-mt-md">
                    <div class="repo-list text-subtitle3">
                      {{ elem["language"] }}
                    </div>
                    <div class="row items-center justify-end">
                      <div class="row column-gap-xs items-center">
                        <q-icon size="xs" class="repo-list" name="star_rate" />
                        <div class="repo-list text-subtitle2">
                          {{ elem["stars"] }}
                        </div>
                      </div>

                      <div class="row q-mx-md column-gap-xs items-center">
                        <q-icon size="xs" class="repo-list" name="visibility" />
                        <div class="repo-list text-subtitle2">
                          {{ elem["watchers"] }}
                        </div>
                      </div>

                      <div class="row column-gap-xs items-center">
                        <q-icon
                          size="xs"
                          class="repo-list"
                          name="fas fa-code-branch"
                        />
                        <div class="repo-list text-subtitle2">
                          {{ elem["forks"] }}
                        </div>
                      </div>
                    </div>
                  </div>
                </q-card-section>
                <q-separator style="border-bottom: 1px solid #373c3e" />
              </div>
            </q-card>
          </div>
        </q-expansion-item>
      </div>

      <div class="row justify-center q-mt-xl" v-else>
        <div class="row justify-center col-12">
          <h4 class="repo-list">Repositórios não encontrados!</h4>
        </div>
        <img
          src="../assets/astronaut.gif"
          alt="this slowpoke moves"
          width="350"
        />
      </div>
    </div>
  </div>
</template>

<script>
import { useQuasar } from "quasar";
export default {
  name: "Home",

  setup() {
    const $q = useQuasar();
  },

  data: () => ({
    language: null,
    repositories: [],
    featuredRepositories: [],
    loadSpinner: false,
  }),

  created() {
    this.loadRepositories();
  },

  methods: {
    loadRepositories(language) {
      this.$q.loading.show();
      this.loadSpinner = true;

      const lang = language || "javascript";

      var data = {
        language: lang,
      };

      axios
        .get("github/repositories", { params: data })
        .then((response) => {
          this.repositories = response.data["repositories"];
        })
        .catch((data) => {
          this.repositories = null;
          this.$q.notify({
            message: `Não foi possível carregar repositórios motivo: ${data.response.data["repositories"]}`,
            color: "red-8",
          });
        })
        .finally(() => {
          this.loadFeaturedRepositories();
          this.removeExistingItems();
          this.$q.loading.hide();
          this.loadSpinner = false;
        });
    },

    goTo(elem) {
      window.open(elem, "_blank");
    },

    loadFeaturedRepositories() {
      axios.get("github").then((response) => {
        this.featuredRepositories = response.data["featured_repositories"];
        this.removeExistingItems();
      });
    },

    saveFeaturedRepository(elem) {
      var data = {
        repository: {
          id_from_repository: elem["id_repository"],
          owner: elem["owner"]["login"],
          name: elem["name"],
          description: elem["description"],
          html_url: elem["owner"]["html_url"],
          stars: elem["stars"],
          watchers: elem["watchers"],
          forks: elem["forks"],
          language: elem["language"],
          favorited: true,
        },
      };

      axios
        .post("github", data)
        .then(() => {
          this.loadFeaturedRepositories();

          this.$q.notify({
            message: "Repositório salvo com sucesso",
            color: "green-8",
          });
        })
        .catch((data) => {
          for (let property in data.response.data) {
            this.$q.notify({
              message: `Não foi possível favoritar repositório, campo: ${property}, motivo: ${data.response.data[property]}`,
              color: "red-8",
            });
          }
        });
    },

    destroyFeaturedRepository(elem) {
      axios
        .delete(`github/${elem.id}`)
        .then(() => {
          this.removeFromFeatured(elem.id);
          this.$q.notify({
            message: "Repositório removido com sucesso!",
            color: "green-8",
          });
        })
        .catch(() => {
          this.$q.notify({
            message: `Não foi possível desmarcar repositório.`,
            color: "red-8",
          });
        });
    },

    removeExistingItems() {
      for (var i = 0; i < this.featuredRepositories.length; i++) {
        function arrayRemove(arr, value) {
          return arr.filter(
            (e) => e.id_repository != value["id_from_repository"]
          );
        }

        this.repositories = arrayRemove(
          this.repositories,
          this.featuredRepositories[i]
        );
      }
    },

    removeFromFeatured(id) {
      for (var i = 0; i < this.featuredRepositories.length; i++) {
        function arrayRemove(arr, id) {
          return arr.filter((e) => e.id != id);
        }

        this.featuredRepositories = arrayRemove(this.featuredRepositories, id);
      }
    },
  },
};
</script>

<style>
.repo-list {
  color: rgb(187, 181, 172);
}
.q-field__native,
.q-field__input {
  color: rgb(187, 181, 172);
}

.repo-title:hover {
  cursor: pointer;
  text-decoration: underline;
}

.refresh {
  cursor: pointer;
  animation: spin 2s linear infinite;
}

.heart-icon {
  cursor: pointer;
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}
</style>
