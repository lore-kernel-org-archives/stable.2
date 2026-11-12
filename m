Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446081;
	b=Gi6F2ZcPCetDYgiTw7DoAg0gmpJpk13mJsADMORuHNvsiwZWeJSebdupllRK1qkcMkjP
	 TRCwqg0k7hZB8Wz68r0W4JbODgNZS4Iu2fSFoDoQo0mAXxySo4Hy2z61f2hJFN4qrBDT1
	 i3+wBCm8hWmZ3iWeYVkDNf+Px/dawWYv0D3DHCkaiYgih/Uuee+Dl5V6wfLxhw//7Q6W3
	 sceodExtF+rtf4QRjjhi/Nr/xa+5BqIHyuZfMJjp2pXUZ50X2vJ65nDhQ2VC5fcmLBKWC
	 J7vt1rjSa8Dl+hMU6+V6Ad5ywtJE3iO+4q7Jn2OiGl+q5OhZsyfzGXgGXh5u6ftJysQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446081;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5Patr8hddAUGU5qjgBehU9ZZsukPSWBWsYptigZRmcM=;
	b=fIN8KVEgsIm3EZE2vil/01v3y8Z34ricMbQPoss2vNWafshgO0ZibXi9d5KEsc6Cx0t8
	 fPaWOzi00QYTRADzcrn1kMqp2zbYLZXn9IbZ6buw5hkfQjtioHwYV89I7UukJRPWLWP0i
	 qs+ZZhmFzqIu8CtduMusxqLjZ6aBSuMYdN3uSC5pPxOrXKGIlBjh/5Or6pkWwApivPZMJ
	 f5Bfb1ivx5OpypvYGSsMCRWG2r8e1zkCQZ943HlY4zFXEqn/GES0IUgzA7kLSKKYpyPBP
	 FZMma4K9tHhtFVeyLv8SCp+fH2VGiBNlrB21OL76LZ9GrGWQVL+VT1skgAteeqOmxkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzLcgEUK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D9606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzLcgEUK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6A51F00A05;
	Thu, 12 Nov 2026 01:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446081;
	bh=5Patr8hddAUGU5qjgBehU9ZZsukPSWBWsYptigZRmcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LzLcgEUKql/5rRDj+t3a8GCovdvcJ0VnvpMsoZLsd35jWnpfvi5zg+ei7KHWGAyi5
	 BdD/Y5l5vPuQOHICTJ5agVk7A+2t1VEyD/1CLW+4kFomW3Pvo8glJMh6rEIZbFCCZ9
	 /ZGsSJQaRFD+dm++W7qUKL2hJAn+VxqzahOQIiSon15Ookgv1xG1GTXdGaYvyusHZG
	 +L0vMZO2opDvc9cBxgAPhsk2e8mt8CExeIdFC809QR+3Hc2l4kHzuD3AmFTPKkoK88
	 d85RBaUcA8RDzKSP/UXhWuQbwchvDT9bBB7qiFJVDtMz5Ch6aB/4M3l2QIDEJyLobD
	 vSg9h5z1dL7fw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] hwmon: chipcap2: fix IRQ teardown ordering
Date: Wed, 11 Nov 2026 20:14:38 -0500
Message-ID: <20261112011432.1219934-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200717-failed-6.12-4724ac5556ce@kernel.org>
References: <20261109200717-failed-6.12-4724ac5556ce@kernel.org>
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

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

[ Upstream commit d2a66c515d7730fd453485ffb306c412f1f46d72 ]

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
Link: https://patch.msgid.link/20261014-chipcap2_locks-v3-5-27ebfc2c5b9e@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

The label-property access is omitted because the driver has no label
support. Reuse the two existing IRQ helpers for discovery and data-ready
registration, and request alarm IRQs directly in probe after registering
hwmon. This preserves the teardown ordering without adding a helper.

Stable-dep-of: 4724ac5556ce ("hwmon: chipcap2: disable device after hwmon teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/chipcap2.c | 79 ++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 46a3e22f43ade..0f7711ca6feb7 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -663,58 +663,39 @@ static int cc2_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 	return ret;
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
-		ret = devm_request_threaded_irq(dev, data->irq_ready, NULL,
-						cc2_ready_interrupt,
-						IRQF_ONESHOT |
-						IRQF_TRIGGER_RISING,
-						dev_name(dev), data);
-	}
-
-	return ret;
-}
-
-static int cc2_request_alarm_irqs(struct cc2_data *data, struct device *dev)
-{
-	int ret = 0;
 
 	data->irq_low = fwnode_irq_get_byname(dev_fwnode(dev), "low");
 	if (data->irq_low == -EPROBE_DEFER)
 		return data->irq_low;
-	if (data->irq_low > 0) {
-		ret = devm_request_threaded_irq(dev, data->irq_low, NULL,
-						cc2_low_interrupt,
-						IRQF_ONESHOT |
-						IRQF_TRIGGER_RISING,
-						dev_name(dev), data);
-		if (ret)
-			return ret;
-
+	if (data->irq_low > 0)
 		data->rh_alarm.low_alarm_visible = true;
-	}
 
 	data->irq_high = fwnode_irq_get_byname(dev_fwnode(dev), "high");
 	if (data->irq_high == -EPROBE_DEFER)
 		return data->irq_high;
-	if (data->irq_high > 0) {
-		ret = devm_request_threaded_irq(dev, data->irq_high, NULL,
-						cc2_high_interrupt,
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
+		ret = devm_request_threaded_irq(dev, data->irq_ready, NULL,
+						cc2_ready_interrupt,
 						IRQF_ONESHOT |
 						IRQF_TRIGGER_RISING,
 						dev_name(dev), data);
-		if (ret)
-			return ret;
-
-		data->rh_alarm.high_alarm_visible = true;
-	}
 
 	return ret;
 }
@@ -762,13 +743,13 @@ static int cc2_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(data->regulator),
 				     "Failed to get regulator\n");
 
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
@@ -777,6 +758,26 @@ static int cc2_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(data->hwmon),
 				     "Failed to register hwmon device\n");
 
+	if (data->irq_low > 0) {
+		ret = devm_request_threaded_irq(dev, data->irq_low, NULL,
+						cc2_low_interrupt,
+						IRQF_ONESHOT |
+						IRQF_TRIGGER_RISING,
+						dev_name(dev), data);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to request alarm irqs\n");
+	}
+
+	if (data->irq_high > 0) {
+		ret = devm_request_threaded_irq(dev, data->irq_high, NULL,
+						cc2_high_interrupt,
+						IRQF_ONESHOT |
+						IRQF_TRIGGER_RISING,
+						dev_name(dev), data);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to request alarm irqs\n");
+	}
+
 	return 0;
 }
 
-- 
2.53.0

