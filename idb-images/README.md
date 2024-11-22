# `idb-images` Directory

## Usage

Place images into this directory to get imported into the frontend gateway's Image Management. By convention, the following folder structure must be used to differentiate each vertical's images:

```bash
.
└── idb-images
    └── vertical-name
        ├── image-name.png
        └── subfolder
            └── image-name.png
```

All vertical images must be placed within the `idb-images/<vertical-name>` folder. Subfolders can be used for further organization if desired/needed.

> [!NOTE]
> The stack currently only supports image types `PNG` and `SVG`.
