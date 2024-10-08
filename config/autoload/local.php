<?php
/**
 * Local application configuration
 *
 * Insert your local database credentials here
 * and provide the email address the system should use.
 */

return array(
    'db' => array(
        'database' => 'railway',
        'username' => 'root',
        'password' => 'EcboemyiqSqXfWOvttwVIAsEMhuXWMmc',

        'hostname' => 'junction.proxy.rlwy.net',
        'port' => 24283,
    ),
    'mail' => array(
        'type' => 'sendmail', // or 'smtp' or 'smtp-tls' (or 'file', to not send, but save to file (data/mails/))
        'address' => 'info@bookings.example.com',
            // Make sure 'bookings.example.com' matches the hosting domain when using type 'sendmail'

        'host' => '?', // for 'smtp' type only, otherwise remove or leave as is
        'user' => '?', // for 'smtp' type only, otherwise remove or leave as is
        'pw' => '?', // for 'smtp' type only, otherwise remove or leave as is

        'port' => 'auto', // for 'smtp' type only, otherwise remove or leave as is
        'auth' => 'plain', // for 'smtp' type only, change this to 'login' if you have problems with SMTP authentication
    ),
    'i18n' => array(
        'choice' => array(
            'en-US' => 'English',
            'de-DE' => 'Deutsch',

            // More possible languages:
            // 'fr-FR' => 'Français',
            // 'hu-HU' => 'Magyar',
        ),

        'currency' => 'EUR',

        // The language is usually detected from the user's web browser.
        // If it cannot be detected automatically and there is no cookie from a manual language selection,
        // the following locale will be used as the default "fallback":
        'locale' => 'en-US',
    ),
);
