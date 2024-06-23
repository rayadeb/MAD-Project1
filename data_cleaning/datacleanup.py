# this program removes rows from the recipe_data.json file. 
# if running this code to use different data values, replace json_file variable with non-local path
import pandas as pd
def remove_and_replace(rows):
    # replace json_file with non-local path
    json_file = 'C:/Users/Raya/MAD-Project1/data_cleaning/recipe_data.json'
    df = pd.read_json(json_file)

    # Check the shape of the DataFrame to understand its dimensions
    print("Original DataFrame shape:", df.shape)
    # Original DataFrame shape: (225602, 15)

    # removing rows

    df.drop(df.index[:int(rows)], inplace=True)

    # Check the shape of the DataFrame after removal
    print("DataFrame shape after removing rows:", df.shape)

    # Save the modified DataFrame back to a JSON file with formatted output
    formatted_json_file = 'C:/Users/Raya/MAD-Project1/data_cleaning/formatted_recipe_data.json'
    df.to_json(formatted_json_file, orient='records', indent=4)

    print(f"DataFrame successfully converted to JSON file: {formatted_json_file}")

remove_and_replace(225402)