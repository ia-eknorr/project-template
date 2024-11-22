# `localization` Directory

## Usage

Place language files into this directory to get imported into the frontend gateway's Translation Manager. By convention, the following folder and naming convention must be used to differentiate each vertical's language files:

```bash
.
└── localization
    └── <vertical-name>_<language1>.XML
    └── <vertical-name>_<language2>.XML
    └── ...
        
```


> Example
>
> ```bash
> .
> └── localization
>     └── features-demo_en.XML
>     └── features-demo_it.XML
>     └── ...
>```

> [!NOTE]
> Languages can be edited in these files or in the designer. However, when modified in the designer, they must be manually exported and copied into this directory for tracking and importing on next stack spin up.
>
