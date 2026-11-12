Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516052;
	b=zYnU7wOc70Ed3BiYtlYCPHgaRtdMJMRHkBokHuefZDwHgle/Fv4yaLscVCbUbY1DcrBs
	 bDa3fkjQLwJOzPwI7FTbb0YQs7XGjLbNNzSFZ8oGT+VEuqrxqPVYbWqhsAylmbbkGX/b5
	 b+PyAtUuoUOSp0Zdt7sYFdA1iYaNHPFuuLx4u9ANzr1vmgpnkZDmK8BcddQmFVf/y1wCz
	 y6ntXl29kOt0RRy88V1AMQvf6MqT85NDg4o/Bzf8ZUNzsCCzh0IfToEAEF1ClifKQE8Pe
	 pjXYenNDW8qxjg8JVf869wZPhb7PJsXm7IVtQpzs9j6ZIT5FpvvpUGRhOR2vL2oX4nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516052;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NIYbTVinghHW7mXwnR9DKhgi1ovfIt9GCIJAhEaBc7w=;
	b=kdklpp3MEitvjybP4Jv3bkmS+RMDoK5M7ETWaFSD9GrYMgHhziNJY5JEgJrwKFjR70Uq
	 5lq1qeEFZ19bVOCmyxWUWbHFL9aHoslFarRak+oyR2ijyW6pw+IWx4gHVZ8HIpEVbkOSe
	 1VwB6YgFCZfszxQqFQulC+xHID/X7Q/izBLfkHrwCA+4ObHuOSdFHhxhkPb/szPVwvydd
	 E1OxXRRtsQ5JiJ6vj4i0wThj9PXy6BQpVIQzRPF46vrAJErBRE1Leq3flJ1tJtOSOQg4R
	 fQnXZXkwFGj+H0BNhkrsgmSrVFTgfTg7/lKmzg1m4Aqo52/Omnu23abCSCfZtg54Ofw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrPczzoY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F33606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrPczzoY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586A31F000C8;
	Thu, 12 Nov 2026 20:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794516051;
	bh=NIYbTVinghHW7mXwnR9DKhgi1ovfIt9GCIJAhEaBc7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QrPczzoY9X4oFwrNfl22F0z3abvZYEROQdY+KCeuXZeX2kV3e+0hRKDxpiLrkmAXS
	 FB/ALWhp3UHVJhbWd49EOkot3JQilHywhfhpEeTkHnhvJNCYtEtYj07ykgxHkc3xmJ
	 Ov6w+Qw3BtMI4BqAG9XQpcVsh1RmW+umy2Tga0LeHXyvP1myiQ0JEsXy8PYzKuMC3T
	 2aVMm2e9sJgu3r/aCNY3ZGQvXRNfkeigTZCA/aitlQkMo7c5Nqqyop+qrH03HmvEAY
	 QK63kvjRUpPuX483KPTcF57PpFqciaM2BnQPn3n8Itat2QkALW/Ms9mKlYe/Mz6kEn
	 LT0EBG0toJjJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] hwmon: (sht15) Stop deferred work before releasing its resources
Date: Thu, 12 Nov 2026 15:40:48 -0500
Message-ID: <20261112203609.3581919-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201142-failed-6.6-5eab1e7f7ed1@kernel.org>
References: <20261109201142-failed-6.6-5eab1e7f7ed1@kernel.org>
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
[ sashal: Replaced unavailable disable_work_sync() with a shutdown state update followed by disable_irq() and cancel_work_sync(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/sht15.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 32a41fc56fc96..6102808a60950 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -31,6 +31,7 @@
 #include <linux/bitrev.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
+#include <linux/workqueue.h>
 
 /* Commands */
 #define SHT15_MEASURE_TEMP		0x03
@@ -804,7 +805,7 @@ static irqreturn_t sht15_interrupt_fired(int irq, void *d)
 	disable_irq_nosync(irq);
 	atomic_inc(&data->interrupt_handled);
 	/* Then schedule a reading work struct */
-	if (data->state != SHT15_READING_NOTHING)
+	if (READ_ONCE(data->state) != SHT15_READING_NOTHING)
 		schedule_work(&data->read_work);
 	return IRQ_HANDLED;
 }
@@ -976,11 +977,8 @@ static int sht15_probe(struct platform_device *pdev)
 		goto err_release_reg;
 	}
 
-	ret = devm_request_irq(&pdev->dev, gpiod_to_irq(data->data),
-			       sht15_interrupt_fired,
-			       IRQF_TRIGGER_FALLING,
-			       "sht15 data",
-			       data);
+	ret = request_irq(gpiod_to_irq(data->data), sht15_interrupt_fired,
+			  IRQF_TRIGGER_FALLING, "sht15 data", data);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to get irq for data line\n");
 		goto err_release_reg;
@@ -988,15 +986,15 @@ static int sht15_probe(struct platform_device *pdev)
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
@@ -1009,9 +1007,15 @@ static int sht15_probe(struct platform_device *pdev)
 
 err_release_sysfs_group:
 	sysfs_remove_group(&pdev->dev.kobj, &sht15_attr_group);
+err_free_irq:
+	WRITE_ONCE(data->state, SHT15_READING_NOTHING);
+	disable_irq(gpiod_to_irq(data->data));
+	cancel_work_sync(&data->read_work);
+	free_irq(gpiod_to_irq(data->data), data);
 err_release_reg:
 	if (!IS_ERR(data->reg)) {
 		regulator_unregister_notifier(data->reg, &data->nb);
+		cancel_work_sync(&data->update_supply_work);
 		regulator_disable(data->reg);
 	}
 	return ret;
@@ -1025,12 +1029,18 @@ static int sht15_remove(struct platform_device *pdev)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &sht15_attr_group);
 
+	WRITE_ONCE(data->state, SHT15_READING_NOTHING);
+	disable_irq(gpiod_to_irq(data->data));
+	cancel_work_sync(&data->read_work);
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
 
-- 
2.53.0

