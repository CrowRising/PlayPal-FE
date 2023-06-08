// Import and register all your controllers from the importmap under controllers/*

import { application } from "./application";

// Eager load all controllers defined in the import map under controllers/**/*_controller


// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
