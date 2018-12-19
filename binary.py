def binary_array_to_number(arr):
    for item in arr:
        rep=item.join(",")
        return rep

sample=binary_array_to_number(["0", "0", "1", "0"])
print(sample)