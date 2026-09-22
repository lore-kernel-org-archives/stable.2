Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCC847CA86
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100386; cv=none; b=NKZI+fA2qsvFhoYWYHoNqk/eGYTrr5nEK2un4lqY9vGIaLbbhvwIam1Ta2wJcwHiXizV/BwEfjXgtAowJFVKhxr3eAo1sOURyKa0qO1gjM4Qd7wFIsXKzuC8Wz6qNm92aGFVE9OKKJCszqQrce/AzAyxJiy6G1d3MG8WuMEsk/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100386; c=relaxed/simple;
	bh=gs0er0aqRmjnoS/qHLp1u4fMbEkHvXqsUB43snn3TUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L88E8lrIc5YJzRzt3aDP5Lxgy0vcmYHALWNlEj1rxzZz+Vld8BIPYOAiZq6nUA0vg7VsnwPaZvx6wov9bW9ewNTS1kA9slDhoneFH1kj/Bx+HkbNH8wqyuyhcTAq4KnobQsSfQapc7G+0SLHbdWrpJOklxS0TDznl8TFHSGpDeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKvO8/Ze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKvO8/Ze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5F81F000FF;
	Tue, 22 Sep 2026 18:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790100384;
	bh=PZ5k3fiR4zzupcLz1vBIFqpqm6j3dWs4x0PdarvnIiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WKvO8/Ze72EQ/bbS1sMLhF4b+kOusJYpP4FI+Mwlv/7LCYJl2Wtac043AsjhsqHnU
	 bAqDbmPOIns0UlbeYMXjKL5JwPrOy0D0vAJhedRDinQ4F/PRbajvlf1UdwhTcvUgOK
	 pbTQ6LYT23ybrXb9QGVjVO2I1fM6dn2qy4mCKlJtotruzlZcGfkN/Fi44+AfHxSl13
	 2J/bIS3KXYbgNDYHb6APYjTVSeZqBPRKytlLvKuQR7ArXyvts0v7l4ODLaFgzfnDOV
	 rNuujgqDStkQCqxEVyDUsDP0ObpWzfTSPtZRY7h4AoYGjywEuPxGeDt09n3kKtYLh4
	 9J35WmF+sXXmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] Input: adp5588-keys - switch to using managed resources
Date: Tue, 22 Sep 2026 14:06:20 -0400
Message-ID: <20260922180621.3403178-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922180621.3403178-1-sashal@kernel.org>
References: <2026092232-fetal-skinhead-12b6@gregkh>
 <20260922180621.3403178-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 45608827e6e96af383e69085c6d73f932eeba889 ]

This simplifies error handling in probe() and reduces amount of explicit
code in remove().

Acked-by: Michael Hennerich <michael.hennerich@analog.com>
Link: https://lore.kernel.org/r/20220528045631.289821-3-dmitry.torokhov@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Stable-dep-of: 21efadc62272 ("Input: adp5588-keys - cache GPIO state before registering the gpiochip")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/adp5588-keys.c | 112 +++++++++++---------------
 1 file changed, 45 insertions(+), 67 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index a94ebd8d6c6e3..161dc6a7bf445 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -50,7 +50,6 @@ struct adp5588_kpad {
 	unsigned short gpimapsize;
 #ifdef CONFIG_GPIOLIB
 	unsigned char gpiomap[ADP5588_MAXGPIO];
-	bool export_gpio;
 	struct gpio_chip gc;
 	struct mutex gpio_lock;	/* Protect cached dir, dat_out */
 	u8 dat_out[3];
@@ -182,6 +181,21 @@ static int adp5588_build_gpiomap(struct adp5588_kpad *kpad,
 	return n_unused;
 }
 
+static void adp5588_gpio_do_teardown(void *_kpad)
+{
+	struct adp5588_kpad *kpad = _kpad;
+	struct device *dev = &kpad->client->dev;
+	const struct adp5588_kpad_platform_data *pdata = dev_get_platdata(dev);
+	const struct adp5588_gpio_platform_data *gpio_data = pdata->gpio_data;
+	int error;
+
+	error = gpio_data->teardown(kpad->client,
+				    kpad->gc.base, kpad->gc.ngpio,
+				    gpio_data->context);
+	if (error)
+		dev_warn(&kpad->client->dev, "teardown failed %d\n", error);
+}
+
 static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 {
 	struct device *dev = &kpad->client->dev;
@@ -198,8 +212,6 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 		return 0;
 	}
 
-	kpad->export_gpio = true;
-
 	kpad->gc.direction_input = adp5588_gpio_direction_input;
 	kpad->gc.direction_output = adp5588_gpio_direction_output;
 	kpad->gc.get = adp5588_gpio_get_value;
@@ -213,9 +225,9 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 
 	mutex_init(&kpad->gpio_lock);
 
-	error = gpiochip_add_data(&kpad->gc, kpad);
+	error = devm_gpiochip_add_data(dev, &kpad->gc, kpad);
 	if (error) {
-		dev_err(dev, "gpiochip_add failed, err: %d\n", error);
+		dev_err(dev, "gpiochip_add failed: %d\n", error);
 		return error;
 	}
 
@@ -230,41 +242,24 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 					 kpad->gc.base, kpad->gc.ngpio,
 					 gpio_data->context);
 		if (error)
-			dev_warn(dev, "setup failed, %d\n", error);
+			dev_warn(dev, "setup failed: %d\n", error);
 	}
 
-	return 0;
-}
-
-static void adp5588_gpio_remove(struct adp5588_kpad *kpad)
-{
-	struct device *dev = &kpad->client->dev;
-	const struct adp5588_kpad_platform_data *pdata = dev_get_platdata(dev);
-	const struct adp5588_gpio_platform_data *gpio_data = pdata->gpio_data;
-	int error;
-
-	if (!kpad->export_gpio)
-		return;
-
 	if (gpio_data->teardown) {
-		error = gpio_data->teardown(kpad->client,
-					    kpad->gc.base, kpad->gc.ngpio,
-					    gpio_data->context);
+		error = devm_add_action(dev, adp5588_gpio_do_teardown, kpad);
 		if (error)
-			dev_warn(dev, "teardown failed %d\n", error);
+			dev_warn(dev, "failed to schedule teardown: %d\n",
+				 error);
 	}
 
-	gpiochip_remove(&kpad->gc);
+	return 0;
 }
+
 #else
 static inline int adp5588_gpio_add(struct adp5588_kpad *kpad)
 {
 	return 0;
 }
-
-static inline void adp5588_gpio_remove(struct adp5588_kpad *kpad)
-{
-}
 #endif
 
 static void adp5588_report_events(struct adp5588_kpad *kpad, int ev_cnt)
@@ -510,21 +505,20 @@ static int adp5588_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	kpad = kzalloc(sizeof(*kpad), GFP_KERNEL);
-	input = input_allocate_device();
-	if (!kpad || !input) {
-		error = -ENOMEM;
-		goto err_free_mem;
-	}
+	kpad = devm_kzalloc(&client->dev, sizeof(*kpad), GFP_KERNEL);
+	if (!kpad)
+		return -ENOMEM;
+
+	input = devm_input_allocate_device(&client->dev);
+	if (!input)
+		return -ENOMEM;
 
 	kpad->client = client;
 	kpad->input = input;
 
 	ret = adp5588_read(client, DEV_ID);
-	if (ret < 0) {
-		error = ret;
-		goto err_free_mem;
-	}
+	if (ret < 0)
+		return ret;
 
 	revid = (u8) ret & ADP5588_DEVICE_ID_MASK;
 	if (WA_DELAYED_READOUT_REVID(revid))
@@ -532,7 +526,6 @@ static int adp5588_probe(struct i2c_client *client,
 
 	input->name = client->name;
 	input->phys = "adp5588-keys/input0";
-	input->dev.parent = &client->dev;
 
 	input_set_drvdata(input, kpad);
 
@@ -569,58 +562,43 @@ static int adp5588_probe(struct i2c_client *client,
 
 	error = input_register_device(input);
 	if (error) {
-		dev_err(&client->dev, "unable to register input device\n");
-		goto err_free_mem;
+		dev_err(&client->dev, "unable to register input device: %d\n",
+			error);
+		return error;
 	}
 
-	error = request_threaded_irq(client->irq,
-				     adp5588_hard_irq, adp5588_thread_irq,
-				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				     client->dev.driver->name, kpad);
+	error = devm_request_threaded_irq(&client->dev, client->irq,
+					  adp5588_hard_irq, adp5588_thread_irq,
+					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					  client->dev.driver->name, kpad);
 	if (error) {
-		dev_err(&client->dev, "irq %d busy?\n", client->irq);
-		goto err_unreg_dev;
+		dev_err(&client->dev, "failed to request irq %d: %d\n",
+			client->irq, error);
+		return error;
 	}
 
 	error = adp5588_setup(client);
 	if (error)
-		goto err_free_irq;
+		return error;
 
 	if (kpad->gpimapsize)
 		adp5588_report_switch_state(kpad);
 
 	error = adp5588_gpio_add(kpad);
 	if (error)
-		goto err_free_irq;
+		return error;
 
 	device_init_wakeup(&client->dev, 1);
-	i2c_set_clientdata(client, kpad);
 
 	dev_info(&client->dev, "Rev.%d keypad, irq %d\n", revid, client->irq);
 	return 0;
-
- err_free_irq:
-	free_irq(client->irq, kpad);
- err_unreg_dev:
-	input_unregister_device(input);
-	input = NULL;
- err_free_mem:
-	input_free_device(input);
-	kfree(kpad);
-
-	return error;
 }
 
 static int adp5588_remove(struct i2c_client *client)
 {
-	struct adp5588_kpad *kpad = i2c_get_clientdata(client);
-
 	adp5588_write(client, CFG, 0);
-	free_irq(client->irq, kpad);
-	input_unregister_device(kpad->input);
-	adp5588_gpio_remove(kpad);
-	kfree(kpad);
 
+	/* all resources will be freed by devm */
 	return 0;
 }
 
-- 
2.53.0

