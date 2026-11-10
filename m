Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794277802;
	b=kRdROeAJoWvPtVBm6L8Gf+93II17yzf9U6U73hgz0LWNtZBO+jYMDkwGaFxfey2jZtJN
	 o+i/rGnA1X4AAEaIGhXaGPBOrDY00cjudp4n3WvmHKEczZgyRiWGaum/1XjAY+wR3TwD4
	 whAERjEDrX47Ln617/AjpLIpPaH8S340dyEE6QiTaJZ2bIipe8c1OsxGlIf1G+J6ASEuo
	 K3AYd+5BVx383G5Qcdjg/kkZzXQNPIDgg0nPmbVDW4wqDIEEV9F1xAA7VGCT/Xww6z8C7
	 DtcpQQDm20k5YR8A3uV/kzu5qeOFldZUIRppb5NFxxs2PuKg7lq+hqDFel3tvYydB0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277802;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fOgy9MTgN+VbdVKKUFYIzC1AoRvCYKAJRP3EWNvnA8k=;
	b=cA1m+Il7i2VpUaVh6D5d6h+ex7i9aHWFgtH6l9x5t+5deCNSypvi4NNk6kj9gMhVsBXf
	 jeoOS1w7dqA+E7r/kisw+zn534Lj1dRyLOuPJ6skIOYvI2MPO33YX5CBROuTWegq+VCzB
	 AI//SJ/pAmfjh7Hx8QO0hx/ML6fmi4uDJihOuy98pvkqz5WUbwOKObJ/P1PXxzSw8T2l0
	 I0uM1nQ3awbwKZyuQw+dbB/cJeL5IQjCDHec3GDlpPuRM4A0MUd/YmP6GrHJCJ4+de8WW
	 bIzsuLaTsqTcx8RfKlmns6ymBEGxpr8g97rrN5N+c5pZ3jRMvinlxidllcH4SSvoFwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3d09ibn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE33606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3d09ibn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A31D1F0089F;
	Tue, 10 Nov 2026 02:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794277801;
	bh=fOgy9MTgN+VbdVKKUFYIzC1AoRvCYKAJRP3EWNvnA8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g3d09ibnEunh25kbPh+iNVaOTKsVKuE/OSSZrt2kzlOn6RttHtEDcgpcYbqd8ivYS
	 gWh2cxyac/Svxgd3iWyVLJZFOE+VvtnoohUvPq7OwRRhf9PxYCpxAjC5TRuHl8OIec
	 NP5uWDuieGfw5UtgQo/qLGsUrWPp86yzZWKCA2Tif4BMXi61ywJg8NRej1ZowvQSC5
	 aOyOtgYBvkBOudOIjp4UkW0ZwnJtbPZQMdUPIE7BZkb1TdXQh24Aa84LNBnuqU/jud
	 S1tla/3b/OchGb5RSdihAY+3IF4vuc3RNVefAio9i8G6Qcy1OPvJlrJ8uwuQb8RAC8
	 1iW0EhQELJSCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pan Chuang <panchuang@vivo.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] iio: light: Remove redundant dev_err()/dev_err_probe()
Date: Mon,  9 Nov 2026 21:29:58 -0500
Message-ID: <20261110022951.3819474-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050601-failed-6.18-8a9bcd587d7d@kernel.org>
References: <20261107050601-failed-6.18-8a9bcd587d7d@kernel.org>
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

From: Pan Chuang <panchuang@vivo.com>

[ Upstream commit 9cf89c342bc2508b79b4ab8823df90da8f77f1f1 ]

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() and devm_request_threaded_irq() automatically log
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() and dev_err_probe() calls.

Standardize error check on if (ret) rather than if (ret < 0).

Signed-off-by: Pan Chuang <panchuang@vivo.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Stable-dep-of: 8a9bcd587d7d ("iio: light: ltr501: Power down chip if request irq fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/adux1020.c       | 4 +---
 drivers/iio/light/apds9160.c       | 7 ++-----
 drivers/iio/light/apds9300.c       | 4 +---
 drivers/iio/light/apds9306.c       | 3 +--
 drivers/iio/light/apds9960.c       | 4 +---
 drivers/iio/light/bh1745.c         | 3 +--
 drivers/iio/light/cm3605.c         | 4 +---
 drivers/iio/light/gp2ap002.c       | 4 +---
 drivers/iio/light/ltr390.c         | 3 +--
 drivers/iio/light/ltr501.c         | 5 +----
 drivers/iio/light/opt4060.c        | 2 +-
 drivers/iio/light/rpr0521.c        | 5 +----
 drivers/iio/light/si1145.c         | 4 +---
 drivers/iio/light/st_uvis25_core.c | 5 +----
 drivers/iio/light/stk3310.c        | 5 +----
 drivers/iio/light/tsl2563.c        | 2 +-
 drivers/iio/light/tsl2772.c        | 5 +----
 drivers/iio/light/veml6030.c       | 4 +---
 drivers/iio/light/vl6180.c         | 2 +-
 19 files changed, 20 insertions(+), 55 deletions(-)

diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index 66ff9c5fb66a2..df8a85826d19f 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -808,10 +808,8 @@ static int adux1020_probe(struct i2c_client *client)
 					NULL, adux1020_interrupt_handler,
 					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
 					ADUX1020_DRV_NAME, indio_dev);
-		if (ret) {
-			dev_err(&client->dev, "irq request error %d\n", -ret);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return devm_iio_device_register(&client->dev, indio_dev);
diff --git a/drivers/iio/light/apds9160.c b/drivers/iio/light/apds9160.c
index 9b8af11b7b67a..fc8a9fbd09746 100644
--- a/drivers/iio/light/apds9160.c
+++ b/drivers/iio/light/apds9160.c
@@ -1545,11 +1545,8 @@ static int apds9160_probe(struct i2c_client *client)
 						apds9160_irq_handler,
 						IRQF_ONESHOT, "apds9160_event",
 						indio_dev);
-		if (ret) {
-			return dev_err_probe(dev, ret,
-					     "request irq (%d) failed\n",
-					     client->irq);
-		}
+		if (ret)
+			return ret;
 	} else {
 		indio_dev->info = &apds9160_info_no_events;
 		indio_dev->channels = apds9160_channels_without_events;
diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
index 05ba216750632..7053b310cb92b 100644
--- a/drivers/iio/light/apds9300.c
+++ b/drivers/iio/light/apds9300.c
@@ -432,10 +432,8 @@ static int apds9300_probe(struct i2c_client *client)
 				NULL, apds9300_interrupt_handler,
 				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				"apds9300_event", indio_dev);
-		if (ret) {
-			dev_err(&client->dev, "irq request error %d\n", -ret);
+		if (ret)
 			goto err;
-		}
 	}
 
 	ret = iio_device_register(indio_dev);
diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index fc07518faec77..dbcd8939e0716 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -1286,8 +1286,7 @@ static int apds9306_probe(struct i2c_client *client)
 						apds9306_irq_handler, IRQF_ONESHOT,
 						"apds9306_event", indio_dev);
 		if (ret)
-			return dev_err_probe(dev, ret,
-					     "failed to assign interrupt.\n");
+			return ret;
 	} else {
 		indio_dev->info = &apds9306_info_no_events;
 		indio_dev->channels = apds9306_channels_without_events;
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 79b202c59a0f1..ddcc94d398cde 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -1098,10 +1098,8 @@ static int apds9960_probe(struct i2c_client *client)
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					"apds9960_event",
 					indio_dev);
-	if (ret) {
-		dev_err(&client->dev, "request irq (%d) failed\n", client->irq);
+	if (ret)
 		goto error_power_down;
-	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
index 10b00344bbedb..31e94813b111b 100644
--- a/drivers/iio/light/bh1745.c
+++ b/drivers/iio/light/bh1745.c
@@ -784,8 +784,7 @@ static int bh1745_setup_triggered_buffer(struct iio_dev *indio_dev,
 						IRQF_ONESHOT,
 						"bh1745_interrupt", indio_dev);
 		if (ret)
-			return dev_err_probe(dev, ret,
-					     "Request for IRQ failed\n");
+			return ret;
 	}
 
 	return 0;
diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
index 0c17378e27d19..1690e3ce42839 100644
--- a/drivers/iio/light/cm3605.c
+++ b/drivers/iio/light/cm3605.c
@@ -233,10 +233,8 @@ static int cm3605_probe(struct platform_device *pdev)
 
 	ret = devm_request_threaded_irq(dev, irq, cm3605_prox_irq,
 					NULL, 0, "cm3605", indio_dev);
-	if (ret) {
-		dev_err(dev, "unable to request IRQ\n");
+	if (ret)
 		goto out_disable_aset;
-	}
 
 	/* Just name the trigger the same as the driver */
 	led_trigger_register_simple("cm3605", &cm3605->led);
diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index bb17ef2a829b7..0a8eee74c494a 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -580,10 +580,8 @@ static int gp2ap002_probe(struct i2c_client *client)
 	ret = devm_request_threaded_irq(dev, client->irq, NULL,
 					gp2ap002_prox_irq, IRQF_ONESHOT,
 					"gp2ap002", indio_dev);
-	if (ret) {
-		dev_err(dev, "unable to request IRQ\n");
+	if (ret)
 		goto out_put_pm;
-	}
 	gp2ap002->irq = client->irq;
 
 	/*
diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index a2b804e9089aa..d40bd98dfd111 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -838,8 +838,7 @@ static int ltr390_probe(struct i2c_client *client)
 						"ltr390_thresh_event",
 						indio_dev);
 		if (ret)
-			return dev_err_probe(dev, ret,
-					     "request irq (%d) failed\n", client->irq);
+			return ret;
 	}
 
 	ret = ltr390_pm_init(data);
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 022e0693983bd..36fe40fec2329 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1538,11 +1538,8 @@ static int ltr501_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						"ltr501_thresh_event",
 						indio_dev);
-		if (ret) {
-			dev_err(&client->dev, "request irq (%d) failed\n",
-				client->irq);
+		if (ret)
 			return ret;
-		}
 	} else {
 		indio_dev->info = data->chip_info->info_no_irq;
 	}
diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index 9be752535d750..70aa8b46784a5 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -1223,7 +1223,7 @@ static int opt4060_setup_trigger(struct opt4060_chip *chip, struct iio_dev *idev
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					name, idev);
 	if (ret)
-		return dev_err_probe(chip->dev, ret, "Could not request IRQ\n");
+		return ret;
 
 	init_completion(&chip->completion);
 
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 9341c1d58cbe3..13e498492092b 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -988,11 +988,8 @@ static int rpr0521_probe(struct i2c_client *client)
 			rpr0521_drdy_irq_handler, rpr0521_drdy_irq_thread,
 			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			"rpr0521_event", indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev, "request irq %d for trigger0 failed\n",
-				client->irq);
+		if (ret)
 			goto err_pm_disable;
-			}
 
 		ret = devm_iio_trigger_register(indio_dev->dev.parent,
 						data->drdy_trigger0);
diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index ef0abc4499b74..a36d1d0346a8e 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -1251,10 +1251,8 @@ static int si1145_probe_trigger(struct iio_dev *indio_dev)
 			  IRQF_TRIGGER_FALLING | IRQF_NO_THREAD,
 			  "si1145_irq",
 			  trig);
-	if (ret < 0) {
-		dev_err(&client->dev, "irq request failed\n");
+	if (ret)
 		return ret;
-	}
 
 	ret = devm_iio_trigger_register(&client->dev, trig);
 	if (ret)
diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index bcd729a9924ea..94d5261b26634 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -196,11 +196,8 @@ static int st_uvis25_allocate_trigger(struct iio_dev *iio_dev)
 					st_uvis25_trigger_handler_thread,
 					irq_type | IRQF_ONESHOT,
 					iio_dev->name, hw);
-	if (err) {
-		dev_err(dev, "failed to request trigger irq %d\n",
-			hw->irq);
+	if (err)
 		return err;
-	}
 
 	hw->trig = devm_iio_trigger_alloc(dev, "%s-trigger",
 					  iio_dev->name);
diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 3be6934218866..ca1cb5dd776a6 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -661,11 +661,8 @@ static int stk3310_probe(struct i2c_client *client)
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
 						"stk3310_event", indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev, "request irq %d failed\n",
-				client->irq);
+		if (ret)
 			goto err_standby;
-		}
 	}
 
 	ret = iio_device_register(indio_dev);
diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index f2af1cd7c2d1f..4e3daae227ae1 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -755,7 +755,7 @@ static int tsl2563_probe(struct i2c_client *client)
 					   "tsl2563_event",
 					   indio_dev);
 		if (err)
-			return dev_err_probe(dev, err, "irq request error\n");
+			return err;
 	}
 
 	err = tsl2563_configure(chip);
diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index ffbde15401141..e54265f605ddf 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -1837,11 +1837,8 @@ static int tsl2772_probe(struct i2c_client *clientp)
 						IRQF_ONESHOT,
 						"TSL2772_event",
 						indio_dev);
-		if (ret) {
-			dev_err(&clientp->dev,
-				"%s: irq request failed\n", __func__);
+		if (ret)
 			return ret;
-		}
 	} else {
 		indio_dev->channels = chip->chip_info->channel_without_events;
 	}
diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index da8c32cabfd68..ad3bf9ab07e7c 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -925,9 +925,7 @@ static int veml6030_set_info(struct iio_dev *indio_dev)
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 						indio_dev->name, indio_dev);
 		if (ret < 0)
-			return dev_err_probe(&client->dev, ret,
-					     "irq %d request failed\n",
-					     client->irq);
+			return ret;
 
 		indio_dev->info = &veml6030_info;
 	} else {
diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index c1314b144367f..127904704df3c 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -722,7 +722,7 @@ static int vl6180_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						indio_dev->name, indio_dev);
 		if (ret)
-			return dev_err_probe(&client->dev, ret, "devm_request_irq error\n");
+			return ret;
 
 		init_completion(&data->completion);
 
-- 
2.53.0

