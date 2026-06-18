Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D1831355D
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781800467; cv=none; b=i1h6YP2/FWW7YKF6UIf32sou0TCa+wlxumKDFtrKJflQqr345k/HXfU0uDZFWa6G4R07o7LQPXCmlJYlhlC3eM5XE1RvxIhaUrvUy7x28nvjK42CRKHyinDIY3nCU2I1W57gEvmn5voc4s6ITKxuIKKSdo4UznuL6FGTtNHvm+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781800467; c=relaxed/simple;
	bh=eqas2mXkgbO1aHhP2Cfjdf8hQgnkrjngdvU2L2nnFwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aX26WTLCmMJgaR+FoBCz1YK6CC4Z6jQc9pk/OS9r1D1QahtMvwpDd2UTvoEB9lqj5Q/hSR9KVCrtODWlqbcJhFRDjb/vUo35sCdjMeakyvi7ZUvjyfn/Y5Piewz3Wk8HoY5nlF1eZNVhPHz8r83Pfbdv3WdMftNcIdYI7Tl9jDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b=JKIYu5uJ; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b="JKIYu5uJ"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gh5sQ2B58zrD4;
	Thu, 18 Jun 2026 18:34:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1781800457;
	bh=WFWr/eRu56LbwkIihFliOGU03+8mIpPHxBpsnuv42Mc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JKIYu5uJLkCgncQX3lEFN0J5J2AjUBWIKhbXPot5TsQpPKZFiGrqHw8+q5XvZfcsp
	 J8+ZkNJ89BmIRtEaMXhpKG5MOf8fY6gzlcyGzdI3X8o098F9SrspaYVcTyOYqmalOg
	 YttbC5+GdZQVV6YGMbkQZtmaduxxrPt4uErpdeXF721DQPy9qznc8aTcLR7CgUosWf
	 mzeaW0bfxNgHR3g+ZL4s+FSagVcZ1sk18rZGAP3oT7snXBFaMonYjk8uiKTQ/rhQ7A
	 euUfe0Kfl58MMoUNfnqmBhyPT1+5HxX0UDg23HsUYPLw7Yj3t2AcR9a9ckLY4aynlw
	 l/tzqVJRctK6w==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gh5sP3FMtzhSj;
	Thu, 18 Jun 2026 18:34:17 +0200 (CEST)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Thu, 18 Jun 2026 18:34:03 +0200
Subject: [PATCH 6.12.y v2 3/3] gpio: Fix resource leaks on errors in
 gpiochip_add_data_with_key()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-6-12-cve-2026-31732-v2-3-42cc54b7bf04@cherry.de>
References: <20260618-6-12-cve-2026-31732-v2-0-42cc54b7bf04@cherry.de>
In-Reply-To: <20260618-6-12-cve-2026-31732-v2-0-42cc54b7bf04@cherry.de>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 stable@vger.kernel.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 Tzung-Bi Shih <tzungbi@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha

From: Tzung-Bi Shih <tzungbi@kernel.org>

[ Upstream commit 16fdabe143fce2cbf89139677728e17e21b46c28 ]

Since commit aab5c6f20023 ("gpio: set device type for GPIO chips"),
`gdev->dev.release` is unset.  As a result, the reference count to
`gdev->dev` isn't dropped on the error handling paths.

Drop the reference on errors.

Also reorder the instructions to make the error handling simpler.
Now gpiochip_add_data_with_key() roughly looks like:

   >>> Some memory allocation.  Go to ERR ZONE 1 on errors.
   >>> device_initialize().

   gpiodev_release() takes over the responsibility for freeing the
   resources of `gdev->dev`.  The subsequent error handling paths
   shouldn't go through ERR ZONE 1 again which leads to double free.

   >>> Some initialization mainly on `gdev`.
   >>> The rest of initialization.  Go to ERR ZONE 2 on errors.
   >>> Chip registration success and exit.

   >>> ERR ZONE 2.  gpio_device_put() and exit.
   >>> ERR ZONE 1.

Cc: stable@vger.kernel.org
Fixes: aab5c6f20023 ("gpio: set device type for GPIO chips")
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Link: https://patch.msgid.link/20260205092840.2574840-1-tzungbi@kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
[missing commit fcc8b637c542 ("gpiolib: switch the line state notifier
 to atomic"), commit dcb73cbaaeb3 ("gpio: cdev: use raw notifier for
 line state events") and commit d4f335b410dd ("gpiolib: rename GPIO chip
 printk macros") in 6.12.y.
 s/gpiochip_err/chip_err/ as well as replaced
 rwlock_init+RAW_INIT_NOTIFIER_HEAD with BLOCKING_INIT_NOTIFIER_HEAD
 based on missing commits, following same logic as in 16fdabe143fc.]
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/gpio/gpiolib.c | 121 ++++++++++++++++++++++++-------------------------
 1 file changed, 58 insertions(+), 63 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 97a32e6f901fc..878f9ab4a0982 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -785,13 +785,15 @@ static const struct device_type gpio_dev_type = {
 #define gcdev_unregister(gdev)		device_del(&(gdev)->dev)
 #endif
 
+/*
+ * An initial reference count has been held in gpiochip_add_data_with_key().
+ * The caller should drop the reference via gpio_device_put() on errors.
+ */
 static int gpiochip_setup_dev(struct gpio_device *gdev)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(&gdev->dev);
 	int ret;
 
-	device_initialize(&gdev->dev);
-
 	/*
 	 * If fwnode doesn't belong to another device, it's safe to clear its
 	 * initialized flag.
@@ -859,9 +861,11 @@ static void gpiochip_setup_devs(void)
 	list_for_each_entry_srcu(gdev, &gpio_devices, list,
 				 srcu_read_lock_held(&gpio_devices_srcu)) {
 		ret = gpiochip_setup_dev(gdev);
-		if (ret)
+		if (ret) {
+			gpio_device_put(gdev);
 			dev_err(&gdev->dev,
 				"Failed to initialize gpio device (%d)\n", ret);
+		}
 	}
 }
 
@@ -941,33 +945,64 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	int base = 0;
 	int ret;
 
-	/*
-	 * First: allocate and populate the internal stat container, and
-	 * set up the struct device.
-	 */
 	gdev = kzalloc(sizeof(*gdev), GFP_KERNEL);
 	if (!gdev)
 		return -ENOMEM;
-
-	gdev->dev.type = &gpio_dev_type;
-	gdev->dev.bus = &gpio_bus_type;
-	gdev->dev.parent = gc->parent;
-	rcu_assign_pointer(gdev->chip, gc);
-
 	gc->gpiodev = gdev;
 	gpiochip_set_data(gc, data);
 
-	device_set_node(&gdev->dev, gpiochip_choose_fwnode(gc));
-
 	ret = ida_alloc(&gpio_ida, GFP_KERNEL);
 	if (ret < 0)
 		goto err_free_gdev;
 	gdev->id = ret;
 
-	ret = dev_set_name(&gdev->dev, GPIOCHIP_NAME "%d", gdev->id);
+	ret = init_srcu_struct(&gdev->srcu);
 	if (ret)
 		goto err_free_ida;
+	rcu_assign_pointer(gdev->chip, gc);
 
+	ret = init_srcu_struct(&gdev->desc_srcu);
+	if (ret)
+		goto err_cleanup_gdev_srcu;
+
+	ret = dev_set_name(&gdev->dev, GPIOCHIP_NAME "%d", gdev->id);
+	if (ret)
+		goto err_cleanup_desc_srcu;
+
+	device_initialize(&gdev->dev);
+	/*
+	 * After this point any allocated resources to `gdev` will be
+	 * free():ed by gpiodev_release().  If you add new resources
+	 * then make sure they get free():ed there.
+	 */
+	gdev->dev.type = &gpio_dev_type;
+	gdev->dev.bus = &gpio_bus_type;
+	gdev->dev.parent = gc->parent;
+	device_set_node(&gdev->dev, gpiochip_choose_fwnode(gc));
+
+	ret = gpiochip_get_ngpios(gc, &gdev->dev);
+	if (ret)
+		goto err_put_device;
+	gdev->ngpio = gc->ngpio;
+
+	gdev->descs = kcalloc(gc->ngpio, sizeof(*gdev->descs), GFP_KERNEL);
+	if (!gdev->descs) {
+		ret = -ENOMEM;
+		goto err_put_device;
+	}
+
+	gdev->label = kstrdup_const(gc->label ?: "unknown", GFP_KERNEL);
+	if (!gdev->label) {
+		ret = -ENOMEM;
+		goto err_put_device;
+	}
+
+	gdev->can_sleep = gc->can_sleep;
+	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
+	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
+#ifdef CONFIG_PINCTRL
+	INIT_LIST_HEAD(&gdev->pin_ranges);
+#endif
 	if (gc->parent && gc->parent->driver)
 		gdev->owner = gc->parent->driver->owner;
 	else if (gc->owner)
@@ -976,36 +1011,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	else
 		gdev->owner = THIS_MODULE;
 
-	ret = gpiochip_get_ngpios(gc, &gdev->dev);
-	if (ret)
-		goto err_free_dev_name;
-
-	gdev->descs = kcalloc(gc->ngpio, sizeof(*gdev->descs), GFP_KERNEL);
-	if (!gdev->descs) {
-		ret = -ENOMEM;
-		goto err_free_dev_name;
-	}
-
-	gdev->label = kstrdup_const(gc->label ?: "unknown", GFP_KERNEL);
-	if (!gdev->label) {
-		ret = -ENOMEM;
-		goto err_free_descs;
-	}
-
-	gdev->ngpio = gc->ngpio;
-	gdev->can_sleep = gc->can_sleep;
-
-	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
-	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
-
-	ret = init_srcu_struct(&gdev->srcu);
-	if (ret)
-		goto err_free_label;
-
-	ret = init_srcu_struct(&gdev->desc_srcu);
-	if (ret)
-		goto err_cleanup_gdev_srcu;
-
 	scoped_guard(mutex, &gpio_devices_lock) {
 		/*
 		 * TODO: this allocates a Linux GPIO number base in the global
@@ -1020,7 +1025,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			if (base < 0) {
 				ret = base;
 				base = 0;
-				goto err_cleanup_desc_srcu;
+				goto err_put_device;
 			}
 
 			/*
@@ -1040,14 +1045,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		ret = gpiodev_add_to_list_unlocked(gdev);
 		if (ret) {
 			chip_err(gc, "GPIO integer space overlap, cannot add chip\n");
-			goto err_cleanup_desc_srcu;
+			goto err_put_device;
 		}
 	}
 
-#ifdef CONFIG_PINCTRL
-	INIT_LIST_HEAD(&gdev->pin_ranges);
-#endif
-
 	if (gc->names)
 		gpiochip_set_desc_names(gc);
 
@@ -1128,25 +1129,19 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	scoped_guard(mutex, &gpio_devices_lock)
 		list_del_rcu(&gdev->list);
 	synchronize_srcu(&gpio_devices_srcu);
-	if (gdev->dev.release) {
-		/* release() has been registered by gpiochip_setup_dev() */
-		gpio_device_put(gdev);
-		goto err_print_message;
-	}
+err_put_device:
+	gpio_device_put(gdev);
+	goto err_print_message;
+
 err_cleanup_desc_srcu:
 	cleanup_srcu_struct(&gdev->desc_srcu);
 err_cleanup_gdev_srcu:
 	cleanup_srcu_struct(&gdev->srcu);
-err_free_label:
-	kfree_const(gdev->label);
-err_free_descs:
-	kfree(gdev->descs);
-err_free_dev_name:
-	kfree(dev_name(&gdev->dev));
 err_free_ida:
 	ida_free(&gpio_ida, gdev->id);
 err_free_gdev:
 	kfree(gdev);
+
 err_print_message:
 	/* failures here can mean systems won't boot... */
 	if (ret != -EPROBE_DEFER) {

-- 
2.54.0

