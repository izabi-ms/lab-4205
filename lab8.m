import tensorflow as tf
from tensorflow.keras.applications import ResNet50
# Dataset
data = tf.keras.utils.image_dataset_from_directory(
    "flowers", image_size=(224, 224))
# ResNet-50 model
base = ResNet50(weights='imagenet', include_top=False,
                input_shape=(224, 224, 3))
base.trainable = True
# Final model
model = tf.keras.Sequential([
    base,
    tf.keras.layers.GlobalAveragePooling2D(),
    tf.keras.layers.Dense(5, activation='softmax')
])
# Train
model.compile(optimizer=tf.keras.optimizers.Adam(1e-5),
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])
model.fit(data, epochs=3)
