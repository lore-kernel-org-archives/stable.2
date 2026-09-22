Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9BE488DA0
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101275; cv=none; b=bAH7C7QmCFxGQbvpwgG1sW396/0RjYLj7Aib807sgXwJdGn7L+WDeMpxD1B83/wEZpgcUrkwZozSvHdE8la/9t7XM5aKOrnXvSt0+v7q5IP6hyKvJLzEizE/N8Enz5BgaXRcmmjdn4SnJH2K8BnKbbXSZJNu0AMltX23aEu9im4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101275; c=relaxed/simple;
	bh=gs0er0aqRmjnoS/qHLp1u4fMbEkHvXqsUB43snn3TUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BU8tSeXDqKK5qG08rvK5YH2cocn8X89t906jwqaYTG8MGNhUIfButUgQt/P/8uW7gYjT7r23JUvoRVsJ/DXxoY/0+SeSunayS39Qd91om9AnAf23qoCRSq2yTbvYwlF971zm8YI4k/hdV/bn63sJbysEBVhtjS/sPmJoz735v7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lidLH1sd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lidLH1sd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8588E1F0089A;
	Tue, 22 Sep 2026 18:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101274;
	bh=PZ5k3fiR4zzupcLz1vBIFqpqm6j3dWs4x0PdarvnIiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lidLH1sdjG1nWBybQd9ngYCbW+WFEi+ohBtFSCyfkYl5M7tQBIirxzeukUFAl2Cla
	 wD7MfH4/Zui3wzW0oCf0Yn19Vu99jnbDLVuHopWe6ZpRfCKGYPkPOziDWv7wj0kUjY
	 DFitFQbKfAtzqfzj1T+BQ94cCuLhrK8tqPTrAQrkCKYiVmCyFrkuBr5wvmMbin5CNs
	 xbbbldcDrTI1AmEmnoL0eMrp25jlAiOnKKL4WIWDC9Ujx5H3NvleTSU7uHy3uAVsMC
	 cXNLIH2IZ1YKKd4QhhKPWJzD/0gElsfeCKkcwaw81L931SdejAZ5bCVOVIQVeK9KOF
	 K4ybGTvbVqXxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] Input: adp5588-keys - switch to using managed resources
Date: Tue, 22 Sep 2026 14:21:09 -0400
Message-ID: <20260922182110.3568173-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922182110.3568173-1-sashal@kernel.org>
References: <2026092232-wanting-charbroil-6f57@gregkh>
 <20260922182110.3568173-1-sashal@kernel.org>
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

