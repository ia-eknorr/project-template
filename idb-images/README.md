# `idb-images` Directory

## Usage

> [!NOTE]
> The stack currently only supports image types `PNG` and `SVG`.

Use the following steps to add images to the project vertical repository:

1. Place images into this `idb-images` directory to get imported into the frontend gateway's Image Management. By convention, the following folder structure must be used to differentiate each vertical's images:

    ```bash
    .
    └── idb-images
        └── exchange
            └── vertical-name
                ├── image-name.png
                └── subfolder
                    └── image-name.png
    ```

    All vertical images must be placed within the `idb-images/exchange/<vertical-name>` folder. Subfolders can be used for further organization if desired/needed.

2. In order for the images to be imported into the frontend's gateway, the stack must restarted using `docker compose restart`

3. After all changes are complete, commit file changes to repository.

> [!WARNING] 
> If the new images are only added to the Image Management dialog within the designer, the images will get overwritten the next time the stack is spun up. It is very important to follow steps 1-3. 
