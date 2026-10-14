Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0745E568539
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999267; cv=none; b=IGsSYPmO8IrKI8BcKxZQLoAekNlOZcjHJeSIeTM55ZlQRKonW5nFm/gJPKAAyENM3cXBX0X1td7HBqguWOOZX9ST8hMofan3vBLfqB9TVS0vhq8f3sufZnCBxETTmBLE+M6KMZyMHGqjhEaSVYkm4+8PsAmlyDNenln3E00qRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999267; c=relaxed/simple;
	bh=HF226Qnl02kxW49Pk8ONdKN1lay5ReawijczgiflN9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlNzkOKfsYg/hqvt+e/R8yMsxwsxJw0SKtvtiEkm0w8zVchfJs78evZpl9qJncd313faf7MfkavD2BhB4FatxCtuZBOpfAu7jmd1NlBSAYKhDSEexvjKwKBiUPXwRjEN6TfHH95Fkthj6+5++asl5pP2PDQYSqrXMENs8t62aVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZX5THitB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX5THitB"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2e5e801487so668741266b.3
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791999262; x=1792604062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fH12jM/o3/s7NLcuZ8Q0Z9sat0wsd1HPmjJx9BFxlsE=;
        b=ZX5THitBk9kBJRYx+UVkvDpIpagrgOdeiI28fCNeV1ebxKnpVRZqcZMvrW6AcSOv+b
         CyJ80oUWknlHWiwHAth+sy11TCpmWLLhRBMyeYkQvByXwFPtabnhJKY644O+flt7IZEx
         8TWe8MRRTAIB2W8W9MU8+p2ntAgbJGMUTn7dALhR4V1GXPX3f5ghQl2cPBC195TQtknI
         LIyRGav/8CHXSREZb63Vpy4JTrQTrCReRxmzeu0Sm/ipsEa6h8lcGMPYKTSFNY5ShE4g
         N7kDK5ycOl/YGWh5Tzd+6wDNcIZcjQ1XOoMSPXWrizWSKC1aqMl8stOyDW6ffHObOeSK
         ofCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999262; x=1792604062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fH12jM/o3/s7NLcuZ8Q0Z9sat0wsd1HPmjJx9BFxlsE=;
        b=0ymKvo7H2EPzYIsgcK4qwIXuSu6rRTRPUiXMGSrFbsm2ujg1rAQeAQVdcpRzRlMReX
         3hvIBIfFD/YSou20XRi37JyfEpNRxoKnGGz5QR1v7LozspRP/fQJlTR5D6tzMzCySzDw
         ditDxunDmyofXhs+3BPaZrbGMQeNi3ItJjqh+PRYw26NFtCFT3Zm+4qVY0JYhP4c3WSk
         WE4cRN3+U0sztehsMJt7nc+9xOvd1b3LiIKCRSO26+B1tEMjsQCWhf+ogT46mfOcvYKc
         g3tcBMl9IsEyYb3ipOaopmVQlffG+0TFSSEyPgXOdDG6x3mymPEpjxPOdLFRdfronE+W
         fijA==
X-Forwarded-Encrypted: i=1; AKwUvBzGiPmALHbMJ9GAhpPvxu4kirXgguzjWIgDvJBkQ8YSNZW21IFXAXiDA/g48a35DLVpEHcpIeE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWlUVTt41vbEhA7Y51PFbfJ+gKsC4tjwCdq39VdVJ6U7eoXo+Y
	fY5jcyViS94aPZgBDmw9a/Jy2cnyNJMM1MADmrj08XhBRJL2gpKMYSZa
X-Gm-Gg: AYBFou2wcAlQp+xobHFzp82fnqs2X0r+JFpwdcpR7hyQVHZebrj2mjCFou8TbVWfXVK
	Xoy6+LDqJimefK3lemuIsXkEyszuxyw8lfSefk1WntPcgg97LkJ/MWXqzpXwbq6DFPt160b8jXH
	JxNDv0z4hgk09+2Ggq/l67PivH9duW9Vx8as3+GyKheHpbAQ27U8mR3EEwKbaFbMubODHaC6CXx
	k8GTZSPusjH9Q0ApANcetrTKa+c1CAk05SHCHNCfED5YNl/nY6xu3f/FNWV5iQsa60UK3X53gWR
	p4+CbJCPQUyHqh5JPLkfmYetsgFgijgPhqi9VwdlJu6/UQQaVlmnD5m0+f+owK9BAjtQU8+4f+D
	I7H4H3+1fbCci+sgdJ0sauw+KxkOuYXlMP56AEG1jCjRHvzFIi5VMnjWIdjMr6hcHUKch5RG4L6
	c2UqOxd8HImMbxf2FU1FoDASLEx5CIo9WfytTToQzqxkNatRbWRLhXNh5lUtGr4tztUDBQ0Jihy
	sUHMdhZv88bhOKs
X-Received: by 2002:a17:906:c150:b0:c25:32b0:e56c with SMTP id a640c23a62f3a-c31a9a28ad5mr1566948366b.4.1791999261602;
        Wed, 14 Oct 2026 10:34:21 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:148:f08c:65a8:f8e5:f310:5a71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed963cecesm9381366b.21.2026.10.14.10.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:34:20 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 14 Oct 2026 19:34:04 +0200
Subject: [PATCH v3 05/11] hwmon: chipcap2: fix IRQ teardown ordering
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-chipcap2_locks-v3-5-27ebfc2c5b9e@gmail.com>
References: <20261014-chipcap2_locks-v3-0-27ebfc2c5b9e@gmail.com>
In-Reply-To: <20261014-chipcap2_locks-v3-0-27ebfc2c5b9e@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791999252; l=4496;
 i=javier.carrasco.cruz@gmail.com; s=20260924; h=from:subject:message-id;
 bh=HF226Qnl02kxW49Pk8ONdKN1lay5ReawijczgiflN9s=;
 b=9rvYmhSTeN7Gfl4vyZ1lXAp1iMtl08S2uHLXyXmLdJpTzLk31Nd+tLDj0Pa7FT2QcNwn8VZmU
 9ncTkSsrP/BBl/4utQZ8yZj5/fM9yMeJDRbrw9lVV6wc1zvuempVffq
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=VV+hcMoOj1Sx6xSiY0W/FZNAskGZe2AagSMVj0PsmAs=

The threaded IRQs are currently requested before the hwmon device
is registered. Since devres releases resources in reverse order,
the hwmon device is unregistered before the IRQs are freed during
driver teardown. An IRQ may therefore still run after the hwmon
device has been released and access the stale data->hwmon pointer.

Separate IRQ discovery from IRQ registration so that the IRQ numbers
and alarm visibility flags are initialized before registering the
hwmon device while the IRQs are released before the hwmon device
during devres cleanup.

Fixes: 3af350929e75 ("hwmon: Add support for Amphenol ChipCap 2")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/chipcap2.c | 52 +++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 37dbf6a76fbc..21dc6db27c40 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -631,32 +631,47 @@ static int cc2_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 	}
 }
 
-static int cc2_request_ready_irq(struct cc2_data *data, struct device *dev)
+static int cc2_get_irqs(struct cc2_data *data, struct device *dev)
 {
-	int ret = 0;
-
 	data->irq_ready = fwnode_irq_get_byname(dev_fwnode(dev), "ready");
 	if (data->irq_ready == -EPROBE_DEFER)
 		return data->irq_ready;
-	if (data->irq_ready > 0) {
+	if (data->irq_ready > 0)
 		init_completion(&data->complete);
+
+	data->irq_low = fwnode_irq_get_byname(dev_fwnode(dev), "low");
+	if (data->irq_low == -EPROBE_DEFER)
+		return data->irq_low;
+	if (data->irq_low > 0)
+		data->rh_alarm.low_alarm_visible = true;
+
+	data->irq_high = fwnode_irq_get_byname(dev_fwnode(dev), "high");
+	if (data->irq_high == -EPROBE_DEFER)
+		return data->irq_high;
+	if (data->irq_high > 0)
+		data->rh_alarm.high_alarm_visible = true;
+
+	return 0;
+}
+
+static int cc2_request_data_ready(struct cc2_data *data, struct device *dev)
+{
+	int ret = 0;
+
+	if (data->irq_ready > 0)
 		ret = devm_request_threaded_irq(dev, data->irq_ready, NULL,
 						cc2_ready_interrupt,
 						IRQF_ONESHOT |
 						IRQF_TRIGGER_RISING,
 						dev_name(dev), data);
-	}
 
 	return ret;
 }
 
-static int cc2_request_alarm_irqs(struct cc2_data *data, struct device *dev)
+static int cc2_request_alarms(struct cc2_data *data, struct device *dev)
 {
 	int ret = 0;
 
-	data->irq_low = fwnode_irq_get_byname(dev_fwnode(dev), "low");
-	if (data->irq_low == -EPROBE_DEFER)
-		return data->irq_low;
 	if (data->irq_low > 0) {
 		ret = devm_request_threaded_irq(dev, data->irq_low, NULL,
 						cc2_low_interrupt,
@@ -665,13 +680,8 @@ static int cc2_request_alarm_irqs(struct cc2_data *data, struct device *dev)
 						dev_name(dev), data);
 		if (ret)
 			return ret;
-
-		data->rh_alarm.low_alarm_visible = true;
 	}
 
-	data->irq_high = fwnode_irq_get_byname(dev_fwnode(dev), "high");
-	if (data->irq_high == -EPROBE_DEFER)
-		return data->irq_high;
 	if (data->irq_high > 0) {
 		ret = devm_request_threaded_irq(dev, data->irq_high, NULL,
 						cc2_high_interrupt,
@@ -680,8 +690,6 @@ static int cc2_request_alarm_irqs(struct cc2_data *data, struct device *dev)
 						dev_name(dev), data);
 		if (ret)
 			return ret;
-
-		data->rh_alarm.high_alarm_visible = true;
 	}
 
 	return ret;
@@ -732,13 +740,13 @@ static int cc2_probe(struct i2c_client *client)
 
 	device_property_read_string(dev, "label", &data->label);
 
-	ret = cc2_request_ready_irq(data, dev);
+	ret = cc2_get_irqs(data, dev);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request ready irq\n");
+		return dev_err_probe(dev, ret, "Failed to get IRQs\n");
 
-	ret = cc2_request_alarm_irqs(data, dev);
+	ret = cc2_request_data_ready(data, dev);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request alarm irqs\n");
+		return dev_err_probe(dev, ret, "Failed to request ready irq\n");
 
 	data->hwmon = devm_hwmon_device_register_with_info(dev, client->name,
 							   data, &cc2_chip_info,
@@ -747,6 +755,10 @@ static int cc2_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(data->hwmon),
 				     "Failed to register hwmon device\n");
 
+	ret = cc2_request_alarms(data, dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request alarm irqs\n");
+
 	return 0;
 }
 

-- 
2.43.0

