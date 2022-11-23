preload_app!

workers ENV.fetch("WEB_CONCURRENCY") { 4 }
