Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795639771;
	b=Dcror6d+ATSjURv64n229g7gi81Z4aUsV1Lzdt0t6vDzDYFe3LV1BDoWeTHfK/OlL1xx
	 5101yhbcGfQm16DMUnrBQgZrtslTUPac4bFruPNbTd0JCeulHb3iJYtDrzDogzrR731Tt
	 jt/mwyEmdnSMSnThouO7uxKK4kzwFbutI90wmn9L5yhGueO3YyUFDyfqVgP5sVQR6ELfp
	 allTJ3g2qa7PAzI/6FbqgKaYgcIIztJ1zKeDYh/mQoX8/inY2Md5piKwrwQCP/QYoNVuf
	 mwH4t6WUVNT3+OLMu6UOCXRgyZYIhnZcBGQpG0JpQJTpgNe4P5RL0kkKN25ZVhQQ0RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639771;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KzqU0mPnuKpmxFCB8Wh+uu/dW/0+xBC8Jabl8yBOneY=;
	b=WC9UlSlkjwmNU3K5r4YfrVpOEks76DHeSk1Tizj8Kc7q5sb5GlwYd6ZOEwQMwU+1sIs6
	 NEU345S31SWgH9orl2i9LtDwdhpcz1YdceorbF0vPfSnipWfIm+QbNTfmuXJ6Xs2l0xnP
	 nlkQg+ZWAIyPIWSIfySIsRmNdlKAKvWGCjasr0BNlalWVqdts7ztq8MKwSu82aH9aF5DY
	 eXbE2fOvJLyP8+eEDMXY7TWDtKrJt6l0IKnZpbnLuoKXzP7p0X4dv/bvczVjz2io1I1c4
	 Dyv/LrhprwDwIQGGlALDUZMvK9EOx0Jx5vbo/aTTmD/CSfxLx5vsniYAqgTeHPhHDwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvceyO2j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F85606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvceyO2j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E2B1F000C0;
	Wed, 25 Nov 2026 20:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795639770;
	bh=KzqU0mPnuKpmxFCB8Wh+uu/dW/0+xBC8Jabl8yBOneY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EvceyO2j8UQmZ5AgC0/mWz0d3fQx7WtwecbOKsrdR48bZllysexLqU53G96Uczlj7
	 ZHW9yBFb3ALn10Z1GuBMQe6nx3Q+ZpSN7W0lD8+Vqm752G7EHM25E2bvPUTKmQr3+z
	 7+dnNSU4NOjFSL8PKn5vy+GjjxnfXJoiIn6/67WzJps2XZGIyEk5HMCyEpriex9GIZ
	 hIxrNPNV7eaqiu81Lm4y6rfkU/xag8xfd2FFYQk1OCM64sbAoNYHAKLPYAGdXHfYRB
	 Q47bPaKdb04ZAU6g05HXbYR6OijqdEVLBE2RqKUFbXiQeBIifeERuuQ7MRCZ9Tc1Hq
	 OlCV2L9Guw67w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] gpio: Ensure struct gpio_chip for gpiochip_setup_dev()
Date: Wed, 25 Nov 2026 15:49:26 -0500
Message-ID: <20261125204921.1452840-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125204921.1452840-1-sashal@kernel.org>
References: <2026112507-smasher-paralysis-af0a@gregkh>
 <20261125204921.1452840-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tzung-Bi Shih <tzungbi@kernel.org>

[ Upstream commit cf674f1a0c9893ee1acef832679562007a94250a ]

Ensure struct gpio_chip for gpiochip_setup_dev().  This eliminates a few
checks for struct gpio_chip.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Link: https://patch.msgid.link/20260223061726.82161-5-tzungbi@kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Stable-dep-of: 7e899fe007d2 ("gpio: keep the chip reference when deferred setup fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c  | 14 ++++----------
 drivers/gpio/gpiolib-cdev.h  |  2 +-
 drivers/gpio/gpiolib-sysfs.c | 21 ++++++++-------------
 drivers/gpio/gpiolib-sysfs.h |  4 ++--
 drivers/gpio/gpiolib.c       | 24 +++++++++++++++++-------
 5 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 1afda8ea5769b..056aa145047cd 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2832,11 +2832,13 @@ static const struct file_operations gpio_fileops = {
 #endif
 };
 
-int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
+int gpiolib_cdev_register(struct gpio_chip *gc, dev_t devt)
 {
-	struct gpio_chip *gc;
+	struct gpio_device *gdev = gc->gpiodev;
 	int ret;
 
+	lockdep_assert_held(&gdev->srcu);
+
 	cdev_init(&gdev->chrdev, &gpio_fileops);
 	gdev->chrdev.owner = THIS_MODULE;
 	gdev->dev.devt = MKDEV(MAJOR(devt), gdev->id);
@@ -2852,14 +2854,6 @@ int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
 		return ret;
 	}
 
-	guard(srcu)(&gdev->srcu);
-	gc = srcu_dereference(gdev->chip, &gdev->srcu);
-	if (!gc) {
-		cdev_device_del(&gdev->chrdev, &gdev->dev);
-		destroy_workqueue(gdev->line_state_wq);
-		return -ENODEV;
-	}
-
 	gpiochip_dbg(gc, "added GPIO chardev (%d:%d)\n", MAJOR(devt), gdev->id);
 
 	return 0;
diff --git a/drivers/gpio/gpiolib-cdev.h b/drivers/gpio/gpiolib-cdev.h
index b42644cbffb80..4a9cb3335d990 100644
--- a/drivers/gpio/gpiolib-cdev.h
+++ b/drivers/gpio/gpiolib-cdev.h
@@ -7,7 +7,7 @@
 
 struct gpio_device;
 
-int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt);
+int gpiolib_cdev_register(struct gpio_chip *gc, dev_t devt);
 void gpiolib_cdev_unregister(struct gpio_device *gdev);
 
 #endif /* GPIOLIB_CDEV_H */
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index c5aa79fac40c2..415ab87b235d2 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -983,13 +983,15 @@ void gpiod_unexport(struct gpio_desc *desc)
 }
 EXPORT_SYMBOL_GPL(gpiod_unexport);
 
-int gpiochip_sysfs_register(struct gpio_device *gdev)
+int gpiochip_sysfs_register(struct gpio_chip *gc)
 {
+	struct gpio_device *gdev = gc->gpiodev;
 	struct gpiodev_data *data;
-	struct gpio_chip *chip;
 	struct device *parent;
 	int err;
 
+	lockdep_assert_held(&gdev->srcu);
+
 	/*
 	 * Many systems add gpio chips for SOC support very early,
 	 * before driver model support is available.  In those cases we
@@ -999,18 +1001,12 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
 	if (!class_is_registered(&gpio_class))
 		return 0;
 
-	guard(srcu)(&gdev->srcu);
-
-	chip = srcu_dereference(gdev->chip, &gdev->srcu);
-	if (!chip)
-		return -ENODEV;
-
 	/*
 	 * For sysfs backward compatibility we need to preserve this
 	 * preferred parenting to the gpio_chip parent field, if set.
 	 */
-	if (chip->parent)
-		parent = chip->parent;
+	if (gc->parent)
+		parent = gc->parent;
 	else
 		parent = &gdev->dev;
 
@@ -1029,7 +1025,7 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
 						    MKDEV(0, 0), data,
 						    gpiochip_groups,
 						    GPIOCHIP_NAME "%d",
-						    chip->base);
+						    gc->base);
 	if (IS_ERR(data->cdev_base)) {
 		err = PTR_ERR(data->cdev_base);
 		kfree(data);
@@ -1085,10 +1081,9 @@ void gpiochip_sysfs_unregister(struct gpio_chip *gc)
  */
 static int gpiofind_sysfs_register(struct gpio_chip *gc, const void *data)
 {
-	struct gpio_device *gdev = gc->gpiodev;
 	int ret;
 
-	ret = gpiochip_sysfs_register(gdev);
+	ret = gpiochip_sysfs_register(gc);
 	if (ret)
 		gpiochip_err(gc, "failed to register the sysfs entry: %d\n", ret);
 
diff --git a/drivers/gpio/gpiolib-sysfs.h b/drivers/gpio/gpiolib-sysfs.h
index fd5db5384681a..d0998de043a22 100644
--- a/drivers/gpio/gpiolib-sysfs.h
+++ b/drivers/gpio/gpiolib-sysfs.h
@@ -7,12 +7,12 @@ struct gpio_device;
 
 #ifdef CONFIG_GPIO_SYSFS
 
-int gpiochip_sysfs_register(struct gpio_device *gdev);
+int gpiochip_sysfs_register(struct gpio_chip *gc);
 void gpiochip_sysfs_unregister(struct gpio_chip *gc);
 
 #else
 
-static inline int gpiochip_sysfs_register(struct gpio_device *gdev)
+static inline int gpiochip_sysfs_register(struct gpio_chip *gc)
 {
 	return 0;
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index ccdf4feadc619..20c1a0994f395 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -871,14 +871,14 @@ static const struct device_type gpio_dev_type = {
 };
 
 #ifdef CONFIG_GPIO_CDEV
-#define gcdev_register(gdev, devt)	gpiolib_cdev_register((gdev), (devt))
+#define gcdev_register(gc, devt)	gpiolib_cdev_register((gc), (devt))
 #define gcdev_unregister(gdev)		gpiolib_cdev_unregister((gdev))
 #else
 /*
  * gpiolib_cdev_register() indirectly calls device_add(), which is still
  * required even when cdev is not selected.
  */
-#define gcdev_register(gdev, devt)	device_add(&(gdev)->dev)
+#define gcdev_register(gc, devt)	device_add(&(gc)->gpiodev->dev)
 #define gcdev_unregister(gdev)		device_del(&(gdev)->dev)
 #endif
 
@@ -886,8 +886,9 @@ static const struct device_type gpio_dev_type = {
  * An initial reference count has been held in gpiochip_add_data_with_key().
  * The caller should drop the reference via gpio_device_put() on errors.
  */
-static int gpiochip_setup_dev(struct gpio_device *gdev)
+static int gpiochip_setup_dev(struct gpio_chip *gc)
 {
+	struct gpio_device *gdev = gc->gpiodev;
 	struct fwnode_handle *fwnode = dev_fwnode(&gdev->dev);
 	int ret;
 
@@ -898,11 +899,11 @@ static int gpiochip_setup_dev(struct gpio_device *gdev)
 	if (fwnode && !fwnode->dev)
 		fwnode_dev_initialized(fwnode, false);
 
-	ret = gcdev_register(gdev, gpio_devt);
+	ret = gcdev_register(gc, gpio_devt);
 	if (ret)
 		return ret;
 
-	ret = gpiochip_sysfs_register(gdev);
+	ret = gpiochip_sysfs_register(gc);
 	if (ret)
 		goto err_remove_device;
 
@@ -949,13 +950,22 @@ static void machine_gpiochip_add(struct gpio_chip *gc)
 static void gpiochip_setup_devs(void)
 {
 	struct gpio_device *gdev;
+	struct gpio_chip *gc;
 	int ret;
 
 	guard(srcu)(&gpio_devices_srcu);
 
 	list_for_each_entry_srcu(gdev, &gpio_devices, list,
 				 srcu_read_lock_held(&gpio_devices_srcu)) {
-		ret = gpiochip_setup_dev(gdev);
+		guard(srcu)(&gdev->srcu);
+
+		gc = srcu_dereference(gdev->chip, &gdev->srcu);
+		if (!gc) {
+			dev_err(&gdev->dev, "Underlying GPIO chip is gone\n");
+			continue;
+		}
+
+		ret = gpiochip_setup_dev(gc);
 		if (ret) {
 			gpio_device_put(gdev);
 			dev_err(&gdev->dev,
@@ -1210,7 +1220,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	 * Otherwise, defer until later.
 	 */
 	if (gpiolib_initialized) {
-		ret = gpiochip_setup_dev(gdev);
+		ret = gpiochip_setup_dev(gc);
 		if (ret)
 			goto err_remove_irqchip;
 	}
-- 
2.53.0

