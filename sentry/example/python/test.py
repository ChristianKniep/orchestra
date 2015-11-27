import raven

client = raven.Client(
    dsn='SENTRY_DNS'

    # inform the client which parts of code are yours
    # include_paths=['my.app']
    # include_paths=[__name__.split('.', 1)[0]],

    # pass along the version of your application
    # release='1.0.0'
    # release=raven.fetch_package_version('my-app')
    # release=raven.fetch_git_sha(os.path.dirname(__file__)),
)

# eine einfache Nachricht aufnehmen
client.captureMessage('hello world!')

# eine Ausnahme auffangen
try:
    1 / 0
except ZeroDivisionError:
    client.captureException()
