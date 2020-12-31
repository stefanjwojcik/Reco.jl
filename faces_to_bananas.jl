using Reco # this is a package that embeds python 
using Images 
using LinearAlgebra # this is how to do SVD

# get all the faces, upsample 4 times 
faces = recognize("/home/swojcik/Downloads/mypics/crowd.jpg", 4) 
img = load("/home/swojcik/Downloads/mypics/crowd.jpg")

mainpath = "/home/swojcik/Downloads/human-740259_1280.jpg"
faces = recognize(mainpath, 4)
otherimg = load(mainpath)

banana = load("/home/swojcik/Downloads/Banana-Single.jpg")
sm_banana = imresize(banana, (50, 50));


insert_banana = function(imgtobanana, banana, faces)
   # for every defined face, determine its size, and put an equally-sized banana on it 
   for i in 1:length(faces)
      top, right, bottom, left = faces[i] .+ 1
      n_dims = size(imgtobanana[top:bottom, left:right])
      sm_b = imresize(banana, n_dims)
      imgtobanana[top:bottom, left:right] .= sm_b
   end 
   return imgtobanana
end



# for every defined face, determine its size, and put an equally-sized banana on it 
for i in 1:length(faces)
   top, right, bottom, left = faces[i] .+ 1
   n_dims = size(img[top:bottom, left:right])
   sm_b = imresize(sm_banana, n_dims)
   img[top:bottom, left:right] .= sm_b
end 


## Extracts a segment of an image based on coordinates
seg_img = function(img, coords)
   top, right, bottom, left = coords .+ 1 
   img[top:bottom, left:right]
end

# Select and segment a random face 
randface = seg_img(img, rand(faces))
randface = load("/home/swojcik/Downloads/washer.jpg")

# Insert 
newmg = copy(otherimg)
for i in 1:length(faces)
   top, right, bottom, left = faces[i] .+ 1
   n_dims = size(img[top:bottom, left:right])
   sm_b = imresize(randface, n_dims)
   newmg[top:bottom, left:right] .= sm_b
end 

######## MAKING SVD 

### first number is top:bottom, second number is 
img = float.(img)
channels = channelview(img)

function rank_approx(F::SVD, k)
    U, S, V = F
    M = U[:, 1:k] * Diagonal(S[1:k]) * V[:, 1:k]'
    clamp01!(M)
end
svdfactors = svd.(eachslice(channels; dims=1))
this = colorview(RGB, rank_approx.(svdfactors, 16)...)
