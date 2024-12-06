# `localization` Directory

## Usage

Use the following steps to add localization to the project vertical repository:

1. In the designer, add languages/text as normal using the Translation Manager. Once changes are complete, export each of the updated language files.

2. Copy the updated language files into this `localization` directory, renaming each with the vertical name. By convention, the following structure must be used to differentiate each vertical's language files:

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

3. After all changes are complete, commit file changes to repository.

> [!WARNING] 
> If the new translations are only added to the Translation Manager dialog within the designer, the translations will get overwritten the next time the stack is spun up. It is very important to follow steps 1-3.
