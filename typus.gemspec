# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{typus}
  s.version = "0.9.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Francesc Esplugas"]
  s.date = %q{2009-05-25}
  s.description = %q{Effortless backend interface for Ruby on Rails applications. (Admin scaffold generator.)}
  s.email = %q{francesc@intraducibles.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "app/controllers/admin/master_controller.rb",
     "app/controllers/typus_controller.rb",
     "app/helpers/admin/form_helper.rb",
     "app/helpers/admin/master_helper.rb",
     "app/helpers/admin/public_helper.rb",
     "app/helpers/admin/sidebar_helper.rb",
     "app/helpers/admin/table_helper.rb",
     "app/helpers/typus_helper.rb",
     "app/models/typus_mailer.rb",
     "app/models/typus_user.rb",
     "app/views/admin/dashboard/_sidebar.html.erb",
     "app/views/admin/resources/edit.html.erb",
     "app/views/admin/resources/index.html.erb",
     "app/views/admin/resources/new.html.erb",
     "app/views/admin/resources/show.html.erb",
     "app/views/admin/shared/_footer.html.erb",
     "app/views/admin/shared/_pagination.html.erb",
     "app/views/layouts/admin.html.erb",
     "app/views/layouts/typus.html.erb",
     "app/views/typus/dashboard.html.erb",
     "app/views/typus/recover_password.html.erb",
     "app/views/typus/reset_password.html.erb",
     "app/views/typus/sign_in.html.erb",
     "app/views/typus/sign_up.html.erb",
     "app/views/typus_mailer/reset_password_link.erb",
     "config/locales/es.yml",
     "config/locales/pt-BR.yml",
     "config/locales/typus_hacks.yml",
     "config/routes.rb",
     "generators/typus/templates/config/initializers/typus.rb",
     "generators/typus/templates/config/typus/application.yml",
     "generators/typus/templates/config/typus/application_roles.yml",
     "generators/typus/templates/config/typus/typus.yml",
     "generators/typus/templates/config/typus/typus_roles.yml",
     "generators/typus/templates/db/create_typus_users.rb",
     "generators/typus/templates/public/images/admin/arrow_down.gif",
     "generators/typus/templates/public/images/admin/arrow_up.gif",
     "generators/typus/templates/public/images/admin/spinner.gif",
     "generators/typus/templates/public/images/admin/status_false.gif",
     "generators/typus/templates/public/images/admin/status_true.gif",
     "generators/typus/templates/public/images/admin/trash.gif",
     "generators/typus/templates/public/javascripts/admin/application.js",
     "generators/typus/templates/public/stylesheets/admin/reset.css",
     "generators/typus/templates/public/stylesheets/admin/screen.css",
     "generators/typus/typus_generator.rb",
     "generators/typus_update_schema_to_01/templates/config/typus.yml",
     "generators/typus_update_schema_to_01/templates/migration.rb",
     "generators/typus_update_schema_to_01/typus_update_schema_to_01_generator.rb",
     "lib/typus.rb",
     "lib/typus/active_record.rb",
     "lib/typus/authentication.rb",
     "lib/typus/configuration.rb",
     "lib/typus/format.rb",
     "lib/typus/generator.rb",
     "lib/typus/hash.rb",
     "lib/typus/locale.rb",
     "lib/typus/object.rb",
     "lib/typus/quick_edit.rb",
     "lib/typus/reloader.rb",
     "lib/typus/string.rb",
     "lib/typus/user.rb",
     "lib/vendor/active_record.rb",
     "lib/vendor/paginator.rb",
     "rails/init.rb",
     "tasks/typus_tasks.rake",
     "test/config/broken/application.yml",
     "test/config/broken/application_roles.yml",
     "test/config/broken/empty.yml",
     "test/config/broken/empty_roles.yml",
     "test/config/broken/undefined.yml",
     "test/config/broken/undefined_roles.yml",
     "test/config/default/typus.yml",
     "test/config/default/typus_roles.yml",
     "test/config/empty/empty_01.yml",
     "test/config/empty/empty_01_roles.yml",
     "test/config/empty/empty_02.yml",
     "test/config/empty/empty_02_roles.yml",
     "test/config/locales/es.yml",
     "test/config/ordered/001_roles.yml",
     "test/config/ordered/002_roles.yml",
     "test/config/unordered/app_one_roles.yml",
     "test/config/unordered/app_two_roles.yml",
     "test/config/working/application.yml",
     "test/config/working/application_roles.yml",
     "test/config/working/typus.yml",
     "test/config/working/typus_roles.yml",
     "test/fixtures/app/controllers/admin/assets_controller.rb",
     "test/fixtures/app/controllers/admin/categories_controller.rb",
     "test/fixtures/app/controllers/admin/comments_controller.rb",
     "test/fixtures/app/controllers/admin/pages_controller.rb",
     "test/fixtures/app/controllers/admin/posts_controller.rb",
     "test/fixtures/app/controllers/admin/status_controller.rb",
     "test/fixtures/app/controllers/admin/typus_users_controller.rb",
     "test/fixtures/app/controllers/admin/watch_dog_controller.rb",
     "test/fixtures/app/views/admin/comments/_edit_bottom.html.erb",
     "test/fixtures/app/views/admin/comments/_edit_sidebar.html.erb",
     "test/fixtures/app/views/admin/comments/_edit_top.html.erb",
     "test/fixtures/app/views/admin/comments/_index_bottom.html.erb",
     "test/fixtures/app/views/admin/comments/_index_sidebar.html.erb",
     "test/fixtures/app/views/admin/comments/_index_top.html.erb",
     "test/fixtures/app/views/admin/comments/_new_bottom.html.erb",
     "test/fixtures/app/views/admin/comments/_new_sidebar.html.erb",
     "test/fixtures/app/views/admin/comments/_new_top.html.erb",
     "test/fixtures/app/views/admin/comments/_show_bottom.html.erb",
     "test/fixtures/app/views/admin/comments/_show_sidebar.html.erb",
     "test/fixtures/app/views/admin/comments/_show_top.html.erb",
     "test/fixtures/app/views/admin/dashboard/_bottom.html.erb",
     "test/fixtures/app/views/admin/dashboard/_sidebar.html.erb",
     "test/fixtures/app/views/admin/dashboard/_top.html.erb",
     "test/fixtures/app/views/admin/shared/_footer.html.erb",
     "test/fixtures/app/views/admin/status/index.html.erb",
     "test/fixtures/app/views/admin/templates/_datepicker.html.erb",
     "test/fixtures/assets.yml",
     "test/fixtures/categories.yml",
     "test/fixtures/comments.yml",
     "test/fixtures/pages.yml",
     "test/fixtures/posts.yml",
     "test/fixtures/typus_users.yml",
     "test/functional/admin/assets_controller_test.rb",
     "test/functional/admin/categories_controller_test.rb",
     "test/functional/admin/comments_controller_test.rb",
     "test/functional/admin/master_controller_test.rb",
     "test/functional/admin/posts_controller_test.rb",
     "test/functional/admin/status_controller_test.rb",
     "test/functional/admin/typus_users_controller_test.rb",
     "test/functional/typus_controller_test.rb",
     "test/helper.rb",
     "test/helpers/admin/form_helper_test.rb",
     "test/helpers/admin/master_helper_test.rb",
     "test/helpers/admin/public_helper_test.rb",
     "test/helpers/admin/sidebar_helper_test.rb",
     "test/helpers/admin/table_helper_test.rb",
     "test/helpers/typus_helper_test.rb",
     "test/lib/active_record_test.rb",
     "test/lib/configuration_test.rb",
     "test/lib/hash_test.rb",
     "test/lib/routes_test.rb",
     "test/lib/string_test.rb",
     "test/lib/typus_test.rb",
     "test/models.rb",
     "test/schema.rb",
     "test/unit/typus_mailer_test.rb",
     "test/unit/typus_test.rb",
     "test/unit/typus_user_roles_test.rb",
     "test/unit/typus_user_test.rb",
     "test/vendor/active_record_test.rb",
     "test/vendor/paginator_test.rb",
     "typus.gemspec"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://intraducibles.com/projects/typus}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Effortless backend interface for Ruby on Rails applications. (Admin scaffold generator.)}
  s.test_files = [
    "test/fixtures/app/controllers/admin/assets_controller.rb",
     "test/fixtures/app/controllers/admin/categories_controller.rb",
     "test/fixtures/app/controllers/admin/comments_controller.rb",
     "test/fixtures/app/controllers/admin/pages_controller.rb",
     "test/fixtures/app/controllers/admin/posts_controller.rb",
     "test/fixtures/app/controllers/admin/status_controller.rb",
     "test/fixtures/app/controllers/admin/typus_users_controller.rb",
     "test/fixtures/app/controllers/admin/watch_dog_controller.rb",
     "test/functional/admin/assets_controller_test.rb",
     "test/functional/admin/categories_controller_test.rb",
     "test/functional/admin/comments_controller_test.rb",
     "test/functional/admin/master_controller_test.rb",
     "test/functional/admin/posts_controller_test.rb",
     "test/functional/admin/status_controller_test.rb",
     "test/functional/admin/typus_users_controller_test.rb",
     "test/functional/typus_controller_test.rb",
     "test/helper.rb",
     "test/helpers/admin/form_helper_test.rb",
     "test/helpers/admin/master_helper_test.rb",
     "test/helpers/admin/public_helper_test.rb",
     "test/helpers/admin/sidebar_helper_test.rb",
     "test/helpers/admin/table_helper_test.rb",
     "test/helpers/typus_helper_test.rb",
     "test/lib/active_record_test.rb",
     "test/lib/configuration_test.rb",
     "test/lib/hash_test.rb",
     "test/lib/routes_test.rb",
     "test/lib/string_test.rb",
     "test/lib/typus_test.rb",
     "test/models.rb",
     "test/schema.rb",
     "test/unit/typus_mailer_test.rb",
     "test/unit/typus_test.rb",
     "test/unit/typus_user_roles_test.rb",
     "test/unit/typus_user_test.rb",
     "test/vendor/active_record_test.rb",
     "test/vendor/paginator_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
