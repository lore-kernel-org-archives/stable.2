Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426DE37A493
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787507955; cv=none; b=rK4Jqd0LnJv0sbHug/BWrfXJmSui250liQmMeCdVKhsQD2s3whAu/W3BOZKn2auLJPnxMNXRl86EvJSsrYnSn/QRjnyvy0YO/aCvMjK4wShRz18rzFo8KFGKdMMCPP/liEPH5x8aWZkw8O0r+RRmuJxJjGLfHe9RKtA4r9JmqlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787507955; c=relaxed/simple;
	bh=NDfDF//cYaOMQlKuyN0eF+WouZ/qTNtQvy32KQUCa/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nbaJ83TqP0wwkaq2VS0C/PcBKpiveJzTvpGNXxpOjQebuLhPm4Ifigd0hmVHfBcHzEuwS2cFqUzSObvWSoYwe4cUgJTMbEoLhhEZtYXGGvMxdXyN+1AIlxh6NsiZZrAXCoNf+UEnhbcUk55aB6UFRQnro7hbVaU9TUVMPOpes9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiV36WvO; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiV36WvO"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a3819e8be8so5766502a12.0
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787507950; x=1788112750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vgFoHaAGCDAcXCaglR6rN0UVDpopjrCPNpzvvDuKgdo=;
        b=RiV36WvOz995tLol0ZfUU+Iqmqte8eQqnhvRrvm5l61FVle0XlN5BEnWVxxYjZkW8L
         H0vs1WzR/XTvgEoCJyNHfDiVKnMoe7Cm8L8MWg8MNVN4DZoB/BzVlEO2WAHsbvfp0+FB
         rB2q/01tq/ytE05DdD/dR3mB3UxOHxM51P3cdLgSu9EYNW/RcKqURcXEJ1pTm2lVtuWX
         WJ99VoghSqOwbmcS8wPXVx6jwFxRN6ZDx3wkAaiPu6tz9IhgJQEbuZNXx6rcr1NZDJZB
         bQ+VZohTQmJVYO52yRk19xmyNgeHZQUclZWhnazxouMTUfYSHfls/5n5gyEpPOM0W8wp
         +GIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787507950; x=1788112750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vgFoHaAGCDAcXCaglR6rN0UVDpopjrCPNpzvvDuKgdo=;
        b=fOkTVsX4kubpkQCKnC/Za+EzU08WLMWXRMk5JGlRgK5g4yFymbkKokETCONVQALyIe
         oD62lmhAu4cQvS1VSaIl1cuptfmF1aP6vmwUWeIPFZk8bY3iUMPs/bnLMWzoGROFJff3
         FziDvfG21tUoeYKC66VlUXpHYqEnAuqJ+NO83aMNBdIQJbiybDdjo//LzJaMGE2sed1M
         MkJkKQ7Iyc1w4nWtA95NAEJ1T8Qz1ZSaAY98/5DINvfFznmW1dYJfhR/hPUJ+TWy81ul
         HddafPUmj+b6BwJN02A7MRs2rDS3bl2S4MLbaTxlfQvmBh3xyXDszqdCqM+lJmNfVYqE
         uH6A==
X-Forwarded-Encrypted: i=1; AHgh+RpVGj17mz/qEqfflr8oXbCZFkVd27CEA+nUhzOdo8JbJjk3MjYW3Y98Sk5FbDX/IkRJWQHOSO0=@vger.kernel.org
X-Gm-Message-State: AFuF++nhzsucSF3OKyvQdGZpchKmVmlTbZ1zsqhIx2Nge4BJxxCCAdAg
	9UJHiIJ5lAZgblh/tlIN5Oktcb+Cy63wLNybxiLoLHXGlFOC/ZiiCyfidKmXtQ==
X-Gm-Gg: AR+sD13LMzqCTXCn3EG9JwInWl46R2si+6WcyCmpASInNK252JxkFJvfsPlZmGPfOx9
	Q+rmQv81QQCJASjsgzjXhb4Qk5BJEkhRodnc/uiUR81yuzNyo2+CL1nneYnSKk8MYnT3KuWlIET
	BADIxUf9uBquDPnc68pgApLxt/7aJVfoYHaZEyHWW+OvoUM0HhwUjnBpC/kU7eqxx1ocZS1CsDh
	5m+nesbzyjZxS4GYCndLtJ1svwWwSrKaEnz25SHPSSTNhoSLWfB/b07bAMYLmJ/i4p2pPX0+/YX
	ntA4eU6ROxcc0J2oqHw8xuUJ2O2n8uybPO+wFQoAug3ktbpMLq00LRHRmqNvmxH+lPLdH/eL1tn
	+8gRHsebaa9AcPt1C619XQT3Qo6ubMh8rhQK/R5IurYVpef/9tAZUgtNuGxR5HLJ2SKJzy3JvXx
	GHkN9LFbqNnbOTz1Rq5jhIp6ft8kghRFh3wr3HXzAMfmsyEmyptYXJpdTFj+2ZkyJfMut+rAfNm
	epKOA==
X-Received: by 2002:a05:6402:380f:b0:698:a9fe:2eb3 with SMTP id 4fb4d7f45d1cf-6a41145a43bmr26058292a12.9.1787507949986;
        Sun, 23 Aug 2026 10:59:09 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:148:9afb:38d7:b606:f380:289e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e199cb8sm4153933a12.16.2026.08.23.10.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:59:09 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 23 Aug 2026 19:59:02 +0200
Subject: [PATCH v2 2/4] hwmon: chipcap2: fix IRQ teardown ordering
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-chipcap2_locks-v2-2-6a26c8e9e2fc@gmail.com>
References: <20260823-chipcap2_locks-v2-0-6a26c8e9e2fc@gmail.com>
In-Reply-To: <20260823-chipcap2_locks-v2-0-6a26c8e9e2fc@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787507945; l=4560;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=NDfDF//cYaOMQlKuyN0eF+WouZ/qTNtQvy32KQUCa/I=;
 b=r6no+mQoz1iJ5MY7rtmCfcAP0SDldZgM+T8J8TvEGIN6rE6UoDmq0txzvhLIC6Z0wvHzDBB8C
 azoZDHF22wGBf4pmF5CWoItbrVVcBgAV/0qoQ7Rz0h/bdL4Ylv39LiM
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

The threaded IRQs are currently requested before the hwmon device is
registered. Since devres releases resources in reverse order, the hwmon
device is unregistered before the IRQs are freed during driver teardown.

An IRQ may therefore still run after the hwmon device has been released
and access the stale data->hwmon pointer.

Separate IRQ discovery from IRQ registration so that the IRQ numbers and
alarm visibility flags are initialized before registering the hwmon
device, while the IRQ handlers are requested afterwards. This ensures
that the IRQs are released before the hwmon device during devres cleanup.

Fixes: 3af350929e75 ("hwmon: Add support for Amphenol ChipCap 2")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/chipcap2.c | 55 ++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 9bef767b589e..15630d1dd90a 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -631,28 +631,37 @@ static int cc2_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 	}
 }
 
-static int cc2_request_ready_irq(struct cc2_data *data, struct device *dev)
+static void cc2_get_irqs(struct cc2_data *data, struct device *dev)
 {
-	int ret = 0;
 
 	data->irq_ready = fwnode_irq_get_byname(dev_fwnode(dev), "ready");
-	if (data->irq_ready > 0) {
+	if (data->irq_ready > 0)
 		init_completion(&data->complete);
+
+	data->irq_low = fwnode_irq_get_byname(dev_fwnode(dev), "low");
+	if (data->irq_low > 0)
+		data->rh_alarm.low_alarm_visible = true;
+
+	data->irq_high = fwnode_irq_get_byname(dev_fwnode(dev), "high");
+	if (data->irq_high > 0)
+		data->rh_alarm.high_alarm_visible = true;
+}
+
+static int cc2_request_irqs(struct cc2_data *data, struct device *dev)
+{
+	int ret;
+
+	if (data->irq_ready > 0) {
 		ret = devm_request_threaded_irq(dev, data->irq_ready, NULL,
 						cc2_ready_interrupt,
 						IRQF_ONESHOT |
 						IRQF_TRIGGER_RISING,
 						dev_name(dev), data);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to request ready irq\n");
 	}
 
-	return ret;
-}
-
-static int cc2_request_alarm_irqs(struct cc2_data *data, struct device *dev)
-{
-	int ret = 0;
-
-	data->irq_low = fwnode_irq_get_byname(dev_fwnode(dev), "low");
 	if (data->irq_low > 0) {
 		ret = devm_request_threaded_irq(dev, data->irq_low, NULL,
 						cc2_low_interrupt,
@@ -660,12 +669,10 @@ static int cc2_request_alarm_irqs(struct cc2_data *data, struct device *dev)
 						IRQF_TRIGGER_RISING,
 						dev_name(dev), data);
 		if (ret)
-			return ret;
-
-		data->rh_alarm.low_alarm_visible = true;
+			return dev_err_probe(dev, ret,
+					     "Failed to request low alarm irq\n");
 	}
 
-	data->irq_high = fwnode_irq_get_byname(dev_fwnode(dev), "high");
 	if (data->irq_high > 0) {
 		ret = devm_request_threaded_irq(dev, data->irq_high, NULL,
 						cc2_high_interrupt,
@@ -673,12 +680,11 @@ static int cc2_request_alarm_irqs(struct cc2_data *data, struct device *dev)
 						IRQF_TRIGGER_RISING,
 						dev_name(dev), data);
 		if (ret)
-			return ret;
-
-		data->rh_alarm.high_alarm_visible = true;
+			return dev_err_probe(dev, ret,
+					     "Failed to request high alarm irq\n");
 	}
 
-	return ret;
+	return 0;
 }
 
 static const struct hwmon_channel_info *cc2_info[] = {
@@ -706,7 +712,6 @@ static int cc2_probe(struct i2c_client *client)
 {
 	struct cc2_data *data;
 	struct device *dev = &client->dev;
-	int ret;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -EOPNOTSUPP;
@@ -726,13 +731,7 @@ static int cc2_probe(struct i2c_client *client)
 
 	device_property_read_string(dev, "label", &data->label);
 
-	ret = cc2_request_ready_irq(data, dev);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request ready irq\n");
-
-	ret = cc2_request_alarm_irqs(data, dev);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request alarm irqs\n");
+	cc2_get_irqs(data, dev);
 
 	data->hwmon = devm_hwmon_device_register_with_info(dev, client->name,
 							   data, &cc2_chip_info,
@@ -741,7 +740,7 @@ static int cc2_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(data->hwmon),
 				     "Failed to register hwmon device\n");
 
-	return 0;
+	return cc2_request_irqs(data, dev);
 }
 
 static void cc2_remove(struct i2c_client *client)

-- 
2.43.0

