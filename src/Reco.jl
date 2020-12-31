module Reco

using PyCall

function __init__()
    py"""
    import os, face_recognition
    from PIL import Image as Pimage

    #image_path = "/home/swojcik/Documents/masculine faces project/data/Brazil 2016 Candidate Data/most_ambiguous_female_alessandra-amatto-d.jpg"
    #image_path = "/home/swojcik/Downloads/crowd.jpg"

    def detect_faces(img, upsampling):
        img_new = face_recognition.load_image_file(img) # load the image
        _, file_extension = os.path.splitext(img) # get the file extension
        face_locations = face_recognition.face_locations(img_new, number_of_times_to_upsample=upsampling) # extract face locations
        return face_locations

    """
end

recognize(img, upsampling) = py"detect_faces"(img, upsampling) 

export recognize

end