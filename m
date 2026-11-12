Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443233;
	b=x9mYLECMOOssjyvi9M7jXq33I8SMcnRioc7D1Q/a8wQNZM3fbUdyBjlt6csCg/bTwidA
	 dq1RCeR2LZ8TwgrXAEshHNg4tsLeTAq054UO4tyraAxqZlz0RXn7oxdN8t7k/bJvciBAk
	 2Kk5XfqVpzhx90bcDvSomyla2hBQrqtwvkwIVZkSlv2HLzU6evp2591TNnz4I7FIQnAV3
	 avZJfh6toJmvP3186kJHxgPsOB08Mdl41veWlH6Gbkuq8WfHbW4XRYR4D3zDCW3q3Voh8
	 jNjpQysMkg1EzW78lVyY7iZMz6w6xCjU7o5aUM2SLfwfFXvJaMlbNJ+Bikxn1uUXvqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443233;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LJCUVmpyPuA7rocN9gJsYcS4S/B9NSUvMpVeZOM7aT4=;
	b=pC4fagCH7x5LGSeSxt2yhYz9SIGRvP5V4h0sDMn8ID0g98v85fnzeHX1NyuXtrEKEPKC
	 uh0s74ikLACgsX3kJ2bHuQaHnkbJUFmk+tE9eYrRtBOVE15s0I75NYRrUSooXpqnP2rMJ
	 uOjyWjV303xXRhu7izEXHNsNBfdQZCy0VB/c3OGi3PadFWtxVYKbyRbgKdZiHxP9enbQj
	 DspXJAjYxAqYgKSChvBSReAMMTdYsbkTzbBcx4qPSr3Wki63Jcn317VIoNjw6JaXzTN5V
	 M9IQzzp5XcL51kqsqOYsTy9g+JRot8ctWa9C6e3IC9g2/offV++LetARp2wfu2/CqaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eN6TtAGY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDD3606A32D
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eN6TtAGY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234111F00A06;
	Thu, 12 Nov 2026 00:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443233;
	bh=LJCUVmpyPuA7rocN9gJsYcS4S/B9NSUvMpVeZOM7aT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eN6TtAGYWwRY1ImFheFl1AP82qr3kWpUKj/2FW4NaxEwxxeO8TjmTwnS05+Oot1CO
	 ZrEKXiIcw8+B9F+GH/hQj51m7qZyxpZ0V89jb/4tXt040mAHubrkcNF7NwEQbuP7D6
	 DHF/zYLkiAMwBY4ZmlJu2T8qzxn6V+pIDES+C4YKNUwAVCMXAnWl7t8OoSGc8q5u4B
	 WsAdMWqRuC8NHPWTAzmN9WVWQkaG14at+hc30BSixqMzgc1GLGGjgZMpTRw3nqWbXE
	 aRhO2FfnmH1fuemX/FJ7Y1GuP49gg2Z9s/QOcRzgdNtbpiIGeHmecot8ok2mDdAhhu
	 xnOqjKA35yX6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] hwmon: (sht15) Stop deferred work before releasing its resources
Date: Wed, 11 Nov 2026 19:27:11 -0500
Message-ID: <20261112002705.1160379-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112002705.1160379-1-sashal@kernel.org>
References: <20261109200323-failed-6.18-5eab1e7f7ed1@kernel.org>
 <20261112002705.1160379-1-sashal@kernel.org>
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

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit 5eab1e7f7ed12893f3864fe46ffcd5a41a752d6a ]

The IRQ handler and regulator notifier can leave work pending after a
measurement or notification completes. Neither work item is drained before
its resources are released on removal or probe failure.

Disable read_work before freeing the IRQ, since the worker can re-enable
it. Use request_irq()/free_irq() for explicit teardown. Unregister the
regulator notifier before cancelling update_supply_work and disabling the
regulator. Apply the same ordering to probe failures.

Fixes: 251eb40f5ccd ("hwmon: sht15 humidity sensor driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20261024014044.27853-1-mhun512@gmail.com
[groeck: Dropped obsolete 'Assisted-by: tag]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/sht15.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 48bcd362c4808..8af2336052b0e 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -31,6 +31,7 @@
 #include <linux/bitrev.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
+#include <linux/workqueue.h>
 
 /* Commands */
 #define SHT15_MEASURE_TEMP		0x03
@@ -976,25 +977,22 @@ static int sht15_probe(struct platform_device *pdev)
 		goto err_release_reg;
 	}
 
-	ret = devm_request_irq(&pdev->dev, gpiod_to_irq(data->data),
-			       sht15_interrupt_fired,
-			       IRQF_TRIGGER_FALLING,
-			       "sht15 data",
-			       data);
+	ret = request_irq(gpiod_to_irq(data->data), sht15_interrupt_fired,
+			  IRQF_TRIGGER_FALLING, "sht15 data", data);
 	if (ret)
 		goto err_release_reg;
 	disable_irq_nosync(gpiod_to_irq(data->data));
 	ret = sht15_connection_reset(data);
 	if (ret)
-		goto err_release_reg;
+		goto err_free_irq;
 	ret = sht15_soft_reset(data);
 	if (ret)
-		goto err_release_reg;
+		goto err_free_irq;
 
 	ret = sysfs_create_group(&pdev->dev.kobj, &sht15_attr_group);
 	if (ret) {
 		dev_err(&pdev->dev, "sysfs create failed\n");
-		goto err_release_reg;
+		goto err_free_irq;
 	}
 
 	data->hwmon_dev = hwmon_device_register(data->dev);
@@ -1007,9 +1005,13 @@ static int sht15_probe(struct platform_device *pdev)
 
 err_release_sysfs_group:
 	sysfs_remove_group(&pdev->dev.kobj, &sht15_attr_group);
+err_free_irq:
+	disable_work_sync(&data->read_work);
+	free_irq(gpiod_to_irq(data->data), data);
 err_release_reg:
 	if (!IS_ERR(data->reg)) {
 		regulator_unregister_notifier(data->reg, &data->nb);
+		cancel_work_sync(&data->update_supply_work);
 		regulator_disable(data->reg);
 	}
 	return ret;
@@ -1023,12 +1025,16 @@ static void sht15_remove(struct platform_device *pdev)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &sht15_attr_group);
 
+	disable_work_sync(&data->read_work);
+	free_irq(gpiod_to_irq(data->data), data);
+
 	ret = sht15_soft_reset(data);
 	if (ret)
 		dev_err(&pdev->dev, "Failed to reset device (%pe)\n", ERR_PTR(ret));
 
 	if (!IS_ERR(data->reg)) {
 		regulator_unregister_notifier(data->reg, &data->nb);
+		cancel_work_sync(&data->update_supply_work);
 		regulator_disable(data->reg);
 	}
 }
-- 
2.53.0

