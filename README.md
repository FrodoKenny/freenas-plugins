#PREPARATION
* Add 'media' user and group to '/usr/ports/UIDs' and '/usr/ports/GIDs'.
    - /usr/ports/UIDs
        - <code>media:*:816:816::0:0:Media Plugins Daemon:/nonexistent:/usr/sbin/nologin</code>

    - /usr/ports/GIDs
        - <code>media:*:816:</code>

* Make
    - <code>make **NAME**</code>
