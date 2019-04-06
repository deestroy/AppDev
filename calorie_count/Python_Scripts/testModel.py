import tensorflow as tf
import numpy as np
from tensorflow._api.v1.compat.v1.keras.layers import MaxPooling2D,Flatten,Dense,Convolution2D
from tensorflow._api.v1.compat.v1.keras.models import Sequential
from tensorflow._api.v1.compat.v1.keras.preprocessing.image import image_data_generator
from keras_preprocessing import image


#mnist = tf.keras.datasets.mnist

#(x_train, y_train), (x_test, y_test) = mnist.load_data()
#x_train, x_test = x_train / 255.0, x_test / 255.0

#Initializer
model = tf.keras.models.Sequential(
  #tf.keras.layers.Fla
  # tten(input_shape=(28, 28)),
  #tf.keras.layers.Dense(128, activation='relu'),
  #tf.keras.layers.Dropout(0.2),
  #tf.keras.layers.Dense(10, activation='softmax'),
  #tf.keras.layers.MaxPooling2D(pool_size=(2,2))
)
#Covolution -- extract features of image --> relu helps with that
model.add(Convolution2D(32, 3, 3, 
                        input_shape = (64, 64, 3), 
                        activation = 'relu'))

#Fitting CNN to the images so no matter the translation,
# the CNN can understand its the same image. Increases the 
#number of images for training
train_datagen = image_data_generator(
        rescale = 1./255,
        shear_range = 0.2,
        zoom_range = 0.2,
        horizontal_flip = True,
)
test_datagen = image_data_generator(rescale=1./255)

training_set = train_datagen.flow_from_directory(
        'data/training_set',
        target_size=(64,64),
        batch_size = 32,
        class_mode = 'binary')

test_set = test_datagen.flow_from_directory(
      'data/training_set',
        target_size=(64,64),
        batch_size = 32,
        class_mode = 'binary'
)

#Pool -- reduces dimensionality
model.add(MaxPooling2D(pool_size = (2, 2)))

#Flatten -- linear array
model.add(Flatten())

#connect CNN to NN +compile
model.add(Dense(128, activation = 'relu'))
model.add(Dense(1, activation = 'sigmoid'))

model.compile(optimizer='adam',
              loss='binary_crossentropy',
              metrics=['accuracy'])

#model.fit(x_train, y_train, epochs=5)
#model.evaluate(x_test, y_test)

model.fit_generator(
  training_set,
  steps_per_epoch= 8000,
  epochs= 10,
  validation_data= test_set,
  validation_steps= 800)

test_image = image.load_img('random.jpg', target_size = (64, 64))
test_image = image.img_to_array(test_image)
test_image = np.expand_dims(test_image, axis = 0)
result = model.predict(test_image)

training_set.class_indices
if result[0][0] >= 0.5:
     prediction = 'dog'
else:
      prediction = 'cat'
print(prediction)
