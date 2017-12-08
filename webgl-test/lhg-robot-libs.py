import cv2
import numpy as np
from PIL import Image
import pytesseract
import os

def crop_fps_portion_and_enlarge_it(screenshot, processed_img):
    image = cv2.imread(screenshot)
    # Crop the image
    fps = image[1:12, 310:375]
    # Enlarge it to with = 150
    r = 160.0 / fps.shape[1]
    dim = (160, int(fps.shape[0] * r))
    enlarged_fps = cv2.resize(fps, dim, interpolation = cv2.INTER_AREA)
    cv2.imwrite(processed_img, enlarged_fps)

def recognize_characters_from_the_image(image):
    img = cv2.imread(image)
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    cv2.imwrite("Gray-FPS.png", gray)
    rgbimg = cv2.cvtColor(gray, cv2.COLOR_GRAY2RGB)
    text = pytesseract.image_to_string(Image.fromarray(rgbimg))
    if (len(text) == 0):
        raise AssertionError("There is no character in the image!")

    return text
