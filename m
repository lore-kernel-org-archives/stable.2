Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025656;
	b=JJWf4PTQFoJtMKGhPUUDNYGg3lqgwXhsA5T6vNEKYv0yW452hVD+hDhTCWNBuqXoBK9z
	 Qk1oSuDjutcdNnap2CF1QZw2UjalLgUkQXTI8WVeGukGchRkYmxSWg11fqYs5dLTtLuQv
	 euBQVbXYNUr+Cjo2mQYEw7USIT/G4Xex837a7wrnlxbS1HxnfeW8q45/LX3d+8HY4CRWX
	 Tg8UoMRxmsX0z4csaxTOrVoeRt3anazoyqMiitN7xn+NNG6kFNyDggRZWRCW2P2MgjXOH
	 bQON/3a0zHwWA4TXEGc374Dp6SyuePyfGiNodoN7e/BostEXzl+tam095znhK1Hb3AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025656;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=rAtQts0/y+DMr20KjfVhJrCziBiGrrN5MWPVuW3jcZ8=;
	b=FPkisDdkph9JTVSJP8xkxzcHr+EsakW9fbklENqy7x7tuu5CcqubCoy/ON4/wl3p6P6P
	 VOeFk+zSbQzGdkgIeKTL1loXkotAcNoVZrIozuKVppGBHAaKuwU1guBCWocoTTeSL1zIx
	 rGePUh4xAunR6NBW0+7g4QNy1tMav36fkyy2WYxdA5gXSZMfk0185pL7+yLesRLnmxJI7
	 FX3pRokgy3UJmotAGyBs3lCI5Px1MF0MPOZN1uLOeX8zObZnEaHGv1xHwn8Eg81gKO2wg
	 erJefeNxMDnhnzAov7JZpVH67DxLgrSmGB2xV0p1uLHhHN1A4F6ulQ86sQJrQQlMbrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E72606A333;
	Sat,  7 Nov 2026 04:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43E72606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fc87d0ffb700.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADX24yvqO5qbSR5AA--.17892S2;
	Sat, 07 Nov 2026 12:27:28 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Lee Jones <lee@kernel.org>
Cc: linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	pavel@kernel.org,
	vulab@iscas.ac.cn,
	stable@vger.kernel.org
Subject: [PATCH v2] leds: netxbig: Fix platform device reference leak on successful probe
Date: Sat,  7 Nov 2026 12:27:37 +0800
Message-Id: <20261107042737.708109-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260922160323.GB3438784@google.com>
References: <20260922160323.GB3438784@google.com>
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
X-CM-TRANSID:rQCowADX24yvqO5qbSR5AA--.17892S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1Uuw4Uur4DGFWxZFyfXrb_yoWruF15p3
	y5Cas0gFW8GFyIgF1kZa1UAFyUCr1IyayfKF1vkF9293WSvryFqFy0qF1YqFZYkFykZrW3
	JF4rta1rJFWDZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IY
	c2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUbLiSJUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEEA2rucYJjogAAs3

of_find_device_by_node() returns the GPIO extension device with an
elevated reference count.  The error paths release it through the
put_device label, but the success path returns directly, so the
reference is leaked whenever the LED driver probes successfully.

Release the reference right after its last use and remove the put_device
label and the gotos leading to it.

Fixes: 9af512e81964 ("leds: netxbig: Convert to use GPIO descriptors")
Suggested-by: Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
 - Release the reference right after its last use and remove the put_device
   label and the gotos, as suggested.
 - Apologies for the very late reply. 
 drivers/leds/leds-netxbig.c | 74 ++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 47 deletions(-)

diff --git a/drivers/leds/leds-netxbig.c b/drivers/leds/leds-netxbig.c
index 99df46f2d9f5..3a0456eae2c3 100644
--- a/drivers/leds/leds-netxbig.c
+++ b/drivers/leds/leds-netxbig.c
@@ -462,41 +462,36 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 	gpio_ext_dev = &gpio_ext_pdev->dev;
 
 	gpio_ext = devm_kzalloc(dev, sizeof(*gpio_ext), GFP_KERNEL);
-	if (!gpio_ext) {
-		of_node_put(gpio_ext_np);
+	if (!gpio_ext)
 		ret = -ENOMEM;
-		goto put_device;
-	}
-	ret = netxbig_gpio_ext_get(dev, gpio_ext_dev, gpio_ext);
+	else
+		ret = netxbig_gpio_ext_get(dev, gpio_ext_dev, gpio_ext);
+
 	of_node_put(gpio_ext_np);
+	put_device(gpio_ext_dev);
 	if (ret)
-		goto put_device;
+		return ret;
+
 	pdata->gpio_ext = gpio_ext;
 
 	/* Timers (optional) */
 	ret = of_property_count_u32_elems(np, "timers");
 	if (ret > 0) {
-		if (ret % 3) {
-			ret = -EINVAL;
-			goto put_device;
-		}
+		if (ret % 3)
+			return -EINVAL;
 
 		num_timers = ret / 3;
 		timers = devm_kcalloc(dev, num_timers, sizeof(*timers),
 				      GFP_KERNEL);
-		if (!timers) {
-			ret = -ENOMEM;
-			goto put_device;
-		}
+		if (!timers)
+			return -ENOMEM;
 		for (i = 0; i < num_timers; i++) {
 			u32 tmp;
 
 			of_property_read_u32_index(np, "timers", 3 * i,
 						   &timers[i].mode);
-			if (timers[i].mode >= NETXBIG_LED_MODE_NUM) {
-				ret = -EINVAL;
-				goto put_device;
-			}
+			if (timers[i].mode >= NETXBIG_LED_MODE_NUM)
+				return -EINVAL;
 			of_property_read_u32_index(np, "timers",
 						   3 * i + 1, &tmp);
 			timers[i].delay_on = tmp;
@@ -512,15 +507,12 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 	num_leds = of_get_available_child_count(np);
 	if (!num_leds) {
 		dev_err(dev, "No LED subnodes found in DT\n");
-		ret = -ENODEV;
-		goto put_device;
+		return -ENODEV;
 	}
 
 	leds = devm_kcalloc(dev, num_leds, sizeof(*leds), GFP_KERNEL);
-	if (!leds) {
-		ret = -ENOMEM;
-		goto put_device;
-	}
+	if (!leds)
+		return -ENOMEM;
 
 	led = leds;
 	for_each_available_child_of_node_scoped(np, child) {
@@ -531,40 +523,34 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 		ret = of_property_read_u32(child, "mode-addr",
 					   &led->mode_addr);
 		if (ret)
-			goto put_device;
+			return ret;
 
 		ret = of_property_read_u32(child, "bright-addr",
 					   &led->bright_addr);
 		if (ret)
-			goto put_device;
+			return ret;
 
 		ret = of_property_read_u32(child, "max-brightness",
 					   &led->bright_max);
 		if (ret)
-			goto put_device;
+			return ret;
 
 		mode_val =
 			devm_kcalloc(dev,
 				     NETXBIG_LED_MODE_NUM, sizeof(*mode_val),
 				     GFP_KERNEL);
-		if (!mode_val) {
-			ret = -ENOMEM;
-			goto put_device;
-		}
+		if (!mode_val)
+			return -ENOMEM;
 
 		for (i = 0; i < NETXBIG_LED_MODE_NUM; i++)
 			mode_val[i] = NETXBIG_LED_INVALID_MODE;
 
 		ret = of_property_count_u32_elems(child, "mode-val");
-		if (ret < 0 || ret % 2) {
-			ret = -EINVAL;
-			goto put_device;
-		}
+		if (ret < 0 || ret % 2)
+			return -EINVAL;
 		num_modes = ret / 2;
-		if (num_modes > NETXBIG_LED_MODE_NUM) {
-			ret = -EINVAL;
-			goto put_device;
-		}
+		if (num_modes > NETXBIG_LED_MODE_NUM)
+			return -EINVAL;
 
 		for (i = 0; i < num_modes; i++) {
 			int mode;
@@ -574,10 +560,8 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 						   "mode-val", 2 * i, &mode);
 			of_property_read_u32_index(child,
 						   "mode-val", 2 * i + 1, &val);
-			if (mode >= NETXBIG_LED_MODE_NUM) {
-				ret = -EINVAL;
-				goto put_device;
-			}
+			if (mode >= NETXBIG_LED_MODE_NUM)
+				return -EINVAL;
 			mode_val[mode] = val;
 		}
 		led->mode_val = mode_val;
@@ -598,10 +582,6 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 	pdata->num_leds = num_leds;
 
 	return 0;
-
-put_device:
-	put_device(gpio_ext_dev);
-	return ret;
 }
 
 static const struct of_device_id of_netxbig_leds_match[] = {
-- 
2.25.1

