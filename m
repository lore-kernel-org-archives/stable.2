Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351477;
	b=1yJg384pKJVOOLmxMq/LltQ5hPAS04+1QIXpRDZZrs2tqMg31M7ngidvi/wiaX11fvDI
	 1Z0w6MPV1YQSTx6uGA27KsZLz2kKv0+aln96f2hfL0NNDMR+dyQAQHkesSwiCAZ0qxfle
	 ghXruUIfF37biE3zSqU05ewmfuuVhYB2JtNfOF2NYlpJ4b4tWubW6oQpuHDr+Co/3r9F4
	 vDcYvFf/JvJvJs4s2DR8fpZqOyT6FmpB9YkljYWH3c0eiitPr8KqcCNbAJDjQeVVfryB/
	 P5Fg4tdVLl8iuICKcSI6nIMVHQPtGLoucu36Vp+cDmCl62vy5V6npoyELyta/t5eifA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351477;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=c1B0dn18Qed3bPHIA1tdIQvNE9DxWsvMpyyprSuEvGk=;
	b=LlGdjnoJUCN+GZOTrRm8DBaiVUHx6pH8gcRgdE1PUBCKLOo09EQYaZBRJzohIWLzp6d2
	 aqpHVxcmyFdZptQ0Jkkp+ERxOJKKk94aTJ/Fkb1lxfQFHgGUqvDnao57jYm4x2OaEWI7C
	 xXzddvhynTm4ubt3eV33q7aQO13ESy9ucU53WnekfJrzba5+nyQRirYu0sTzhproOO23/
	 nerBFj5VDtdb2N3vrGePt8fialiPdqvQOeuKBB92y+zsVs8pntneT5kR026zuV7vPEuDq
	 jqZyue3UGAJzz53/Lg6IW2eyHSMGGi5jMcm/Bd/z8bVMXVRlucKmybpuCh9fbHMguEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iSBwhMGp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F49C606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iSBwhMGp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC551F00A00;
	Tue, 10 Nov 2026 22:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351475;
	bh=c1B0dn18Qed3bPHIA1tdIQvNE9DxWsvMpyyprSuEvGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iSBwhMGpAufy4GeWkEpyyOcaoBFLm8eMZXsmpPxw88QxmW/fwnPLgPmgbog61x7C6
	 /QKMhI5oh/YRml5EQWGgK77BRni1JSzuJVquDee2hJZaJxL2DMK+p9NKdvK561c9XL
	 09kpPsrCSMxjihU0G2jLFJ9mOXoTmwz1xudMZM8dWLgwPSQVUPjdWvTmjJUGnwVOga
	 x9aNWck6rk24fnhttwNJ9FAoyvJAsm2KmqNh7IgockdlJCrVsUc3BjEpLMlegwyAZ3
	 QLuQfNyZT4VfdTQ39Vwr+9Z5VATqV5Gd+PAod0Fsax6qr5lAsoFBfFoyPh9R/apsfh
	 dhOEn4llAALiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/7] power: supply: generic-adc-battery: convert to managed resources
Date: Tue, 10 Nov 2026 17:57:47 -0500
Message-ID: <20261110225738.4066560-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055053-failed-6.1-8ae5a3f40045@kernel.org>
References: <20261107055053-failed-6.1-8ae5a3f40045@kernel.org>
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

From: Sebastian Reichel <sre@kernel.org>

[ Upstream commit 93297ef6920f071ed109cbdcf640edfc693d0456 ]

Convert driver to use managed resources to simplify driver code.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
Stable-dep-of: 8ae5a3f40045 ("power: supply: generic-adc-battery: fix status with no supplier")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 81 ++++++----------------
 1 file changed, 23 insertions(+), 58 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 0af536f4932f1..535972a332b32 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -23,6 +23,7 @@
 #include <linux/iio/consumer.h>
 #include <linux/iio/types.h>
 #include <linux/power/generic-adc-battery.h>
+#include <linux/devm-helpers.h>
 
 #define JITTER_DEFAULT 10 /* hope 10ms is enough */
 
@@ -269,14 +270,13 @@ static int gab_probe(struct platform_device *pdev)
 	 * copying the static properties and allocating extra memory for holding
 	 * the extra configurable properties received from platform data.
 	 */
-	properties = kcalloc(ARRAY_SIZE(gab_props) +
-			     ARRAY_SIZE(gab_chan_name),
-			     sizeof(*properties),
-			     GFP_KERNEL);
-	if (!properties) {
-		ret = -ENOMEM;
-		goto first_mem_fail;
-	}
+	properties = devm_kcalloc(&pdev->dev,
+				  ARRAY_SIZE(gab_props) +
+				  ARRAY_SIZE(gab_chan_name),
+				  sizeof(*properties),
+				  GFP_KERNEL);
+	if (!properties)
+		return -ENOMEM;
 
 	memcpy(properties, gab_props, sizeof(gab_props));
 
@@ -285,12 +285,13 @@ static int gab_probe(struct platform_device *pdev)
 	 * based on the channel supported by consumer device.
 	 */
 	for (chan = 0; chan < ARRAY_SIZE(gab_chan_name); chan++) {
-		adc_bat->channel[chan] = iio_channel_get(&pdev->dev,
-							 gab_chan_name[chan]);
+		adc_bat->channel[chan] = devm_iio_channel_get(&pdev->dev, gab_chan_name[chan]);
 		if (IS_ERR(adc_bat->channel[chan])) {
 			ret = PTR_ERR(adc_bat->channel[chan]);
+			if (ret != -ENODEV)
+				return dev_err_probe(&pdev->dev, ret, "Failed to get ADC channel %s\n", gab_chan_name[chan]);
 			adc_bat->channel[chan] = NULL;
-		} else {
+		} else if (adc_bat->channel[chan]) {
 			/* copying properties for supported channels only */
 			int index2;
 
@@ -305,10 +306,8 @@ static int gab_probe(struct platform_device *pdev)
 	}
 
 	/* none of the channels are supported so let's bail out */
-	if (!any) {
-		ret = -ENODEV;
-		goto second_mem_fail;
-	}
+	if (!any)
+		return dev_err_probe(&pdev->dev, -ENODEV, "Failed to get any ADC channel\n");
 
 	/*
 	 * Total number of properties is equal to static properties
@@ -319,25 +318,24 @@ static int gab_probe(struct platform_device *pdev)
 	psy_desc->properties = properties;
 	psy_desc->num_properties = index;
 
-	adc_bat->psy = power_supply_register(&pdev->dev, psy_desc, &psy_cfg);
-	if (IS_ERR(adc_bat->psy)) {
-		ret = PTR_ERR(adc_bat->psy);
-		goto err_reg_fail;
-	}
+	adc_bat->psy = devm_power_supply_register(&pdev->dev, psy_desc, &psy_cfg);
+	if (IS_ERR(adc_bat->psy))
+		return dev_err_probe(&pdev->dev, PTR_ERR(adc_bat->psy), "Failed to register power-supply device\n");
 
-	INIT_DELAYED_WORK(&adc_bat->bat_work, gab_work);
+	ret = devm_delayed_work_autocancel(&pdev->dev, &adc_bat->bat_work, gab_work);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to register delayed work\n");
 
-	adc_bat->charge_finished = devm_gpiod_get_optional(&pdev->dev,
-							   "charged", GPIOD_IN);
+	adc_bat->charge_finished = devm_gpiod_get_optional(&pdev->dev, "charged", GPIOD_IN);
 	if (adc_bat->charge_finished) {
 		int irq;
 
 		irq = gpiod_to_irq(adc_bat->charge_finished);
-		ret = request_any_context_irq(irq, gab_charged,
+		ret = devm_request_any_context_irq(&pdev->dev, irq, gab_charged,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 				"battery charged", adc_bat);
 		if (ret < 0)
-			goto gpio_req_fail;
+			return dev_err_probe(&pdev->dev, ret, "Failed to register irq\n");
 	}
 
 	platform_set_drvdata(pdev, adc_bat);
@@ -346,38 +344,6 @@ static int gab_probe(struct platform_device *pdev)
 	schedule_delayed_work(&adc_bat->bat_work,
 			msecs_to_jiffies(0));
 	return 0;
-
-gpio_req_fail:
-	power_supply_unregister(adc_bat->psy);
-err_reg_fail:
-	for (chan = 0; chan < ARRAY_SIZE(gab_chan_name); chan++) {
-		if (adc_bat->channel[chan])
-			iio_channel_release(adc_bat->channel[chan]);
-	}
-second_mem_fail:
-	kfree(properties);
-first_mem_fail:
-	return ret;
-}
-
-static int gab_remove(struct platform_device *pdev)
-{
-	int chan;
-	struct gab *adc_bat = platform_get_drvdata(pdev);
-
-	power_supply_unregister(adc_bat->psy);
-
-	if (adc_bat->charge_finished)
-		free_irq(gpiod_to_irq(adc_bat->charge_finished), adc_bat);
-
-	for (chan = 0; chan < ARRAY_SIZE(gab_chan_name); chan++) {
-		if (adc_bat->channel[chan])
-			iio_channel_release(adc_bat->channel[chan]);
-	}
-
-	kfree(adc_bat->psy_desc.properties);
-	cancel_delayed_work_sync(&adc_bat->bat_work);
-	return 0;
 }
 
 static int __maybe_unused gab_suspend(struct device *dev)
@@ -411,7 +377,6 @@ static struct platform_driver gab_driver = {
 		.pm	= &gab_pm_ops,
 	},
 	.probe		= gab_probe,
-	.remove		= gab_remove,
 };
 module_platform_driver(gab_driver);
 
-- 
2.53.0

