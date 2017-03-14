import cv2

def face_detect(image, scaleFactor = 1.1, minNeighbors = 5, minSize = (30, 30)):
    face_cascade = cv2.CascadeClassifier('./haarcascade_frontalface_default.xml') 
    if face_cascade is None:
        raise AssertionError("Can not read haarcascade file!")
    
    # Load image and convert it to grayscale
    image = cv2.imread(image)
    gray  = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # detect faces in the image
    rects = face_cascade.detectMultiScale(gray,
            scaleFactor = scaleFactor, minNeighbors = minNeighbors,
            minSize = minSize, flags = cv2.CASCADE_SCALE_IMAGE)
    
    # Loop over the faces and draw a rectangle around each
    for (x, y, w, h) in rects:
        cv2.rectangle(image, (x, y), (x + w, y + h), (0, 255, 0), 2)

    # Save the image
    cv2.imwrite('./Face_detect.jpg', image)

    return rects

def there_should_be_face_in_image(image):
    face_rects = face_detect(image)
    
    if len(face_rects) == 0:
        raise AssertionError("No face in the image!")


