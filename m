Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516911;
	b=3P6B+FYShC3P3UMYgu3YhO6Iib1829J0zWdxz4iZ1zM0jLFaQ/x1z74jbKkHVN2UbbTX
	 d6Jd+DvlqZ+WM8Da7DZiMqo0nN9N9pQb9EScQ/QXmmujfI//1A2MKFnCIUEWzfMcreU5G
	 LE/8yHGlfrJoy6kP6utNIJX3r5giBEIuiVuGohXN2Fa3+kkbFMZc5X67hfSnLf8rpCH+s
	 Wc9CXXQt1nyXyponxeANJrMcCy8Sx0ulfYdyr6vLLNHTLXgE7wMKpKI9tagdm5Q01+Oc5
	 wu5t41z07AS2vZ4uP5VdeYTGOB/79LTOwYNm8nVpWWJVwQyW1mrnKi3+Z0exv7NMBzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516911;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BCuzozIjiFZ2TVV4FA5DY4CU4RHDjqMG+/N4bYw60Ek=;
	b=muuuGOK5ozvJcRGHmcpPqOllxqERoacGXa+sk+oAxZtRRhY2AgmYgGB14ypVntBClJNw
	 5CTL/XRIptiOnCEtRFdI+plU4ZvDNb/mbbjwBEn/NylpUmO/SWk+IBXE6HKTNfswOWkYq
	 xAIJ+HpsSgs5i/KtrSJ9fHi1AHqb5JIrZdyEHg+Myn2/7dNMwKm14aylUzLUPUg0iRE8Y
	 FawRYIrHOLbDjUSUgUcWaz6Hku4mNjv8PdZZiGVGlEi+7T8AKAJ1MQIF4So4xv6x/qxue
	 GqqORaatQifDanfro7qjZoCJZ9rsBPWRbo0bvbPAZy6tST3RDNUQ10P082RvjkSRVmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FR7pRPdT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2E606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FR7pRPdT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9426A1F000C4;
	Thu, 12 Nov 2026 20:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794516911;
	bh=BCuzozIjiFZ2TVV4FA5DY4CU4RHDjqMG+/N4bYw60Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FR7pRPdTphlXnAezcKrZtLuTBjELn0Fp6OIRvj+g4LpGV0HDOjIebk6W9igb00r/1
	 +zvviOEKWLZoKwlX+xAgXFm1e1s6SmbWToymR0r4Zo1eYwx/rZhYVIh0rE36rKuKAp
	 tYTucIp8w358XUKD5txjhghE5GqeggpNbRo6J+IEgW0p11jbCbPYhkOUkLE/LVH2IF
	 5iGfu63ZzLFHiPBvku8PZvPY8nLwcmgWnfaRnFzr0dUjYmkAkBZ4BaTnPvlZT1Wy5X
	 yuqooP8wVn4FZ/wN96LIfO1te8JpmFR4GdrQjzoMvejlOtMo03aPI3yHeOLZYNZWTN
	 u9choX/VAO6gQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] hwmon: (sht15) Stop deferred work before releasing its resources
Date: Thu, 12 Nov 2026 15:55:09 -0500
Message-ID: <20261112205343.3701827-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202125-failed-5.15-5eab1e7f7ed1@kernel.org>
References: <20261109202125-failed-5.15-5eab1e7f7ed1@kernel.org>
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
[ sashal: replaced disable_work_sync() with cancel_work_sync() plus IRQ disabling and a READ_ONCE()/WRITE_ONCE() state guard ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/sht15.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index ae4d14257a11d..a0f2f1a2beb87 100644
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

