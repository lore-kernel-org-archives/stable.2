Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443646;
	b=4uHsCJEacshH+nWNbemxAfKTjt8KOwCNYf4N8nWaJcS8lTgsZ611pfeVWuWhZi3tPAQf
	 5kfiqZRd5kZwnq+XoAqgGRPVotyBnQfBwZPgvQj5a2PRZk0yhzO9O8UoI0QTgn0QjKWlo
	 iiUDKbrWTPIMz1pneNm+8+UwNY4otBNxM007ERJQ5AonvtzhU2KYrlQ3w5mRjimOAuKXE
	 X5VSmrR+bfz2Sl/vB3kDPT6hdrYxJbEjUCVenkxq3Ko9iODHzmlcqkA8CyGDg8f4ve9X4
	 Q93Bt8O6a+WZ/fhsegJJZ404utUJkVUa0tEkqe2nXm+a13z0HErjfoOMUIprMno7wKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443646;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LJCUVmpyPuA7rocN9gJsYcS4S/B9NSUvMpVeZOM7aT4=;
	b=vhghj48pkzHiRdPcmZgh0y4XWGNwWT6ZoVnncbzF/Sdt4lNug0d5JVkfe/WldlSi+UQB
	 T+/n7eXdnJ0XhwNnEz3/LiTTblKCeCJcONGnejrZ3Co0Anf7KTUB+Ce6Tf7qSxBwWWBlx
	 4xixPp5TgqoWi5kwp/+UTFEX3Q0YqwR/AjZTL71ghir5kbOzHryRU72xZgMl/Kq1RBoFB
	 pTwVBoQV+zmUA4Z8zyqrX2sPhxSllvk9lxYbGNU7c2tgSZDGN+QXmQ/HPjZazR4xRhJ+s
	 EaA3FmG7aWSpBu7B0wUbz8keucqAwpstuWCNSxu/ugSXUyg0oLhwlkk6ZiRJf/Y5WKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZB288xf9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6542E606A327
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZB288xf9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF49E1F00A06;
	Thu, 12 Nov 2026 00:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443646;
	bh=LJCUVmpyPuA7rocN9gJsYcS4S/B9NSUvMpVeZOM7aT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZB288xf9qQUT2QPVQFUZqfktCTS5B29YWGbbUeKqTKl46Er082paqWYFX0MwwbZ78
	 nBfmnu49wKLjIZrQSODu1/LjFXFUIgfshCbb6xJlIclc/gl4Xge3suIjj1uBVI10zP
	 8kl0FHOQFcKBMQuR5KPuYsRQB/axruIBU8CrUHlMs4vI2XVotPlghzlj+oFn19YMDO
	 Aa5rBDV1lfDluNxdpoVcIGVEToAl3ddfV+9wAJvPngHRXRYq2Yh8zxQBdYX3Qv7deg
	 m+temCfjU2lSH/skQ1zi4TVKuxiqIYJhGjtoRGnYMRauN76GOIC9vGc+vo2MopVKkT
	 hWr1iv2M/cttA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] hwmon: (sht15) Stop deferred work before releasing its resources
Date: Wed, 11 Nov 2026 19:34:03 -0500
Message-ID: <20261112003357.1182045-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112003357.1182045-1-sashal@kernel.org>
References: <20261109200712-failed-6.12-5eab1e7f7ed1@kernel.org>
 <20261112003357.1182045-1-sashal@kernel.org>
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

