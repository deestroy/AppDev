import os
#import listdir
from os.path import isfile, join
import numpy as np
import time
import tensorflow as tf
from tensorflow._api.v1.compat.v1.keras.optimizers import SGD
from tensorflow._api.v1.compat.v1.keras.utils import np_utils
from tensorflow._api.v1.compat.v1.keras.preprocessing import ImageDataGenerator
from tensorflow._api.v1.compat.v1.keras.layers import (Convolution2D, Dense, Flatten, MaxPooling2D, Dropout)
from tensorflow._api.v1.compat.v1.keras.models import Sequential
from tensorflow._api.v1.compat.v1.keras.preprocessing.image import image_data_generator
#from tensorflow.contrib import summary
from tensorflow._api.v1.compat.v1.keras.models import load_keras_model
from tensorflow._api.v1.compat.v1.keras.models import image_data_generator
import cv2



UPLOAD_FOLDER = '../../data/food-101/test/'
ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg'])


#Initializer
model = tf.keras.models.Sequential()


#Covolution -- extract features of image --> relu helps with that
model.add(Convolution2D(32, (3, 3), input_shape = (64, 64, 3), activation = 'relu', padding='same'))
model.add(Convolution2D(32,(3,3), activation='relu'))
model.add(MaxPooling2D(pool_size = (2, 2)))
model.add(Dropout(0.25))

model.add(Convolution2D(64, (3, 3), activation = 'relu', padding='same'))
model.add(Convolution2D(64,(3,3), activation='relu'))
model.add(MaxPooling2D(pool_size = (2, 2)))
model.add(Dropout(0.25))

model.add(Convolution2D(64, (3, 3), activation = 'relu', padding='same'))
model.add(Convolution2D(64,(3,3), activation='relu'))
model.add(MaxPooling2D(pool_size = (2, 2)))
model.add(Dropout(0.25))

model.add(Flatten())

model.add(Dense(512, activation = 'relu'))
model.add(Dropout(0.5))
model.add(Dense(101, activation = 'softmax'))

model.compile(optimizer='adam',
              loss='binary_crossentropy',
              metrics=['accuracy'])

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
        'D:/food-101/train/',
        color_mode='rgb',
        target_size=(64,64),
        batch_size = 32,
        class_mode = 'categorical')

test_set = test_datagen.flow_from_directory(
      'D:/food-101/test',
        color_mode='rgb',
        target_size=(64,64),
        batch_size = 32,
        class_mode = 'categorical')



#connect CNN to NN +compile

#model.add(Dense(128, activation = 'relu'))
#model.add(Dense(128, activation = 'relu'))
#model.add(Dense(3, activation = 'sigmoid'))


#model.fit(x_train, y_train, epochs=5)
#model.evaluate(x_test, y_test)

model.fit_generator(
  training_set,
  steps_per_epoch= 2030,
  epochs= 20,
  validation_data= test_set,
  validation_steps= 679)

model.summary()
model.save('cs_model.h5')
model2 = load_keras_model('cs_model.h5')
model2.summary()
res = model.predict()