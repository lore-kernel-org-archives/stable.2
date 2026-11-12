Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516525;
	b=B6IXpApa6e/ieadQg+4bf1qhokalivGW3BcdUJ7Xp/xX7qhotGd3lHvMTkNEjH+y194v
	 Aew8EwAg506uByAGZrZxloV6uh8dHgwAmrya5duX4k8TxdW/w/F3Ann961CMiUJkswd/e
	 4Eyj2qSYx4hU6B7kEQpAN1HA3eXq5yMzxKCeTxYNyA1Oo4b52C5ArCgNPPXO09md4MGkU
	 EfTJ2T110l2a8OUH7NE3eChed+zRXby2XPOaCS5CQwS1f5snQVUmMYF/puoP3JJKaKjGG
	 XgLGXwsfY/P0UJ5Nk62siNxWo8k/GBP7VN3Y3eVupk3JULge05KyktDtF8zWI9cf2iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516525;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=W5NkBi8JP7W8CmlWPOKutZvJVzDYyPrvcvle+EgTG8k=;
	b=EaeK8g2ZWz6oenFfLM825fLKDthfS9qRYdee0POaqlU0JoUdLYhUuUA5JmnalMgT6Xgi
	 pgmOUd5kbUvvlx0o7AccCTjVvTGIruOaB3J+LgndTzmrYJB0slA2CAQAZZT0pLdU9VX6s
	 MtGn0BiA1YEf++D2BOvcVK4CcSJY8SR8KjyDlJTfy25K2H9bUygTQxzBVYOd/IzdhchT5
	 ykfDi9CBW2xaHFWP/gnTdyMN9UcjbPCxORQeSY8oWtlh7hNGzo5h+9HUKJQMKH5QgSEQ1
	 A1mIWB1Sjx3RNcFXySoCRPByJi2yU/Ent37PyVghqfxQRdRcTR88U3vla89tuFq5Urw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ef8/xMcT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D00606A33B
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ef8/xMcT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43431F000C4;
	Thu, 12 Nov 2026 20:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794516525;
	bh=W5NkBi8JP7W8CmlWPOKutZvJVzDYyPrvcvle+EgTG8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ef8/xMcTtgBW9LqPx//z9XCSrrOGdgLjHryJayOzAcvYvl+ulj2mTtQo8+IBkevnW
	 Z0mHLkbXnTO2PDE/txoNhAhjzcE8gn8WSh2FqBe2RkirW7fIfz3yLRhUziNr5nQMQX
	 RZylntvmAO/N2AuIMOKKN3wCqIZbyMR22gCG/DDUyL4vVwe89bFSczkD33GUUgpbCm
	 3x8L0+hKtIRhVOy6eNgA7/9Eak3Ow/GbvGtDsRa0oxIDzGJc66bPJFyx4ZI68PRsmK
	 fBMFX7QlthVkpdyNuZIPNWyWY10tDn1Rw/b+4w1oglWpKVHUssFROtHtKp3mSQXuLk
	 EbG92px19dJXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] hwmon: (sht15) Stop deferred work before releasing its resources
Date: Thu, 12 Nov 2026 15:48:43 -0500
Message-ID: <20261112204652.3667601-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201615-failed-6.1-5eab1e7f7ed1@kernel.org>
References: <20261109201615-failed-6.1-5eab1e7f7ed1@kernel.org>
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
[ sashal: replaced disable_work_sync() with cancel_work_sync() after guarding the read state and disabling the IRQ ]
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

