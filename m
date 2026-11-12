Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445418;
	b=TfLHpVmNNGeooiWsFEgEWIcV93/e3mmbEEp3jC4UdpLg0mK8hyO5zhlp0AMdj5MKcek9
	 V3ct3bBXjAsdcSmP+4ZAoTLMb+XgoaDMUxuc0ESr9FCFh5hGkmd/IJaMQMMVSAX54nG1A
	 kX9z1rm1jkuozy97M4/qguRr96uf2yBs5Xi+flpgCqWYXDPf+CG0MvxszK2LAtpWUAd8F
	 nlNJcHQAA08keTk7urw5D1z3UVEhUCtJ9dY5N/AAGgFxaxzztzvl3EfuWA1aFul9ArP+g
	 gOI6L/ZiyklTvREBkLbCJGCSArTELH4IeILUI/RwopKbU79BovBQrqdRCRCKG/oNHRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445418;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FaIa9Sb1HEy7dqTo/vDpzlfh6/dac2JGWpc5NQQqyBY=;
	b=vdiDrihXzoH+shPtGAy+ugTgMYMP2Z8tpHJ70L0H9GlNBfhcXrcwJN928Tu9x8e4uI7w
	 6G0hli1Y680cDTQJgbleGBx/bqRKplNP3JqrR4HiVa+jhE5i1jpEdHf8irwmUGhTjWt8C
	 dHTdLjjyz1AHVebfZcCqEu0vXAqCRnKc7qmTKACoKKEBoOJ0sZ0W7gb1/xIVGcPyDbNlQ
	 /uPNYkZAE7L7LI0rhwt9m6kemfCYWM4TvkT7iUXnvoF60/zcGfZ44g1/qkhRHsAodbXcJ
	 gLSurgtbX8Up7fGdVEDqrvEjE7mWHLMD0OlsFKTd9Pa3nLA8jQ1APC1ebmp76t4bIeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gADbZo5J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FB4606A32E
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gADbZo5J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D5D1F00A05;
	Thu, 12 Nov 2026 01:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445417;
	bh=FaIa9Sb1HEy7dqTo/vDpzlfh6/dac2JGWpc5NQQqyBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gADbZo5JsvHd4HzcFGdhWroGW0k+1f+ZtVv8cvmEvf+S+2Kpjz1qWTaUh+bY91wQS
	 8qzWzSF8gnu1qYmeARm0uMwRFslnI/qvzgyE0hD6uRVWanq8I+2buA34LTMqoklNtY
	 JgwzfpBSsQpg0zJGGu+KQRrMSUPibeWXL/t5HD/nV1PQJihGVQiQx5N9h2xyQv3MM+
	 Ij2jWdWbvRIhLrp/ITjxS9layPFnZcOXqZ4jw0M1ZwGRqxBKtAcfrggwqdTqnFuDAa
	 jwX68iM5hDQSdVuYddsb9rIA3bLtReTjohfojmVvr48wPMlkVomi1KYt2EpjE75fhT
	 TyTIvLWC842kA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] hwmon: chipcap2: fix IRQ teardown ordering
Date: Wed, 11 Nov 2026 20:03:34 -0500
Message-ID: <20261112010329.1211633-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200327-failed-6.18-4724ac5556ce@kernel.org>
References: <20261109200327-failed-6.18-4724ac5556ce@kernel.org>
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

Reuse the existing IRQ helpers for discovery and ready IRQ registration,
and request alarm IRQs directly from probe after hwmon registration. This
keeps the number of helper functions unchanged. Omit the unrelated label
property read because label support is absent.

Stable-dep-of: 4724ac5556ce ("hwmon: chipcap2: disable device after hwmon teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/chipcap2.c | 69 ++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 5f4b0fd535af8..8ba706ecd4012 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -636,60 +636,41 @@ static int cc2_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 	}
 }
 
-static int cc2_request_ready_irq(struct cc2_data *data, struct device *dev)
+static int cc2_request_data_ready(struct cc2_data *data, struct device *dev)
 {
 	int ret = 0;
 
-	data->irq_ready = fwnode_irq_get_byname(dev_fwnode(dev), "ready");
-	if (data->irq_ready == -EPROBE_DEFER)
-		return data->irq_ready;
-	if (data->irq_ready > 0) {
-		init_completion(&data->complete);
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
+static int cc2_get_irqs(struct cc2_data *data, struct device *dev)
 {
-	int ret = 0;
+	data->irq_ready = fwnode_irq_get_byname(dev_fwnode(dev), "ready");
+	if (data->irq_ready == -EPROBE_DEFER)
+		return data->irq_ready;
+	if (data->irq_ready > 0)
+		init_completion(&data->complete);
 
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
-						IRQF_ONESHOT |
-						IRQF_TRIGGER_RISING,
-						dev_name(dev), data);
-		if (ret)
-			return ret;
-
+	if (data->irq_high > 0)
 		data->rh_alarm.high_alarm_visible = true;
-	}
 
-	return ret;
+	return 0;
 }
 
 static const struct hwmon_channel_info *cc2_info[] = {
@@ -735,13 +716,13 @@ static int cc2_probe(struct i2c_client *client)
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
@@ -750,6 +731,26 @@ static int cc2_probe(struct i2c_client *client)
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

