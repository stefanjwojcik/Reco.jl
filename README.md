# Reco.jl
Wraps face_recognition Python package to use on images in Julia 

This is a utility package. I wanted to automatically identify faces in images usign this Python package but I didn't want to do the project in Python. This is useful for reference if you want to wrap python functions in julia. 

```julia
using Reco # this is a package that embeds python 
using Images 
using LinearAlgebra # this is how to do SVD

# get all the faces, upsample 4 times 
faces = recognize("/home/swojcik/Downloads/mypics/crowd.jpg", 4) 
img = load("/home/swojcik/Downloads/mypics/crowd.jpg")

mainpath = "/home/swojcik/Downloads/human-740259_1280.jpg"
faces = recognize(mainpath, 4)
otherimg = load(mainpath)
```
