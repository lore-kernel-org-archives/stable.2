Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272605;
	b=EWVoDWtHazCF6H4yOIi1NYna4/Ph8lx9V21pJk04FMcsXHfyVFLXETCGOSbCp6uVnW6J
	 Efq/hZLxP58T47QhH3QCe/el1Bk+YAeKex10xI4rn+c3JJjuIqpk+VkjdRmvIwR5x0BMx
	 9lMkLO2w0tZ5I5X78/YmH1CDYBVDS4jEPsargTtmfS1XPfRMud4lr4gKMxh7w9zAfe0RQ
	 OpK2TWJcoWhGslYe+jUz7u6tL3LUwRt9PCQBWkvfOgfrCwvmZVYZIYr8FYxaTO/KqqoU2
	 piuHeGDlZEbamcG/5JwKqYkG/1NHkx+Equ69zdz9kkIuNaeEAciHz90z4fpi/E04NxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272605;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=w02F2+E9ZUVrQZkdxmKkf1N6JnbIfDftp6q5/5qotcw=;
	b=GOcijDueIsR3jmGterBZnhYfV6cBg6WBq2zWxnH3m5wz/qnnXd2bEf/ie33s1FAg4/oY
	 QXrnzG2hRP9gRdR1z7KHoEk9b1HCfUs9mcsklszDJs6/qeANFIm2QXPSN1KlVK2gbCsqu
	 qAw0kb2migeeA+pyyzn+0IbwajQVS+ByLXvJBlHrwyhvPlxbnXm/Xr68XpFp6/7qEqvFg
	 3YAaBRxqm1oP/u16g9pu37/I5/4E6Z9haJlCTMX4IUOkTL7MSq5BI6wHkU+dBdVR946Eo
	 JHES/oqWAsA1hZqjcgzUT3JcoiHaJBpMddm4rFfeh995taGMXzLoTfdvi8oCzeE8phw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ei60ok2e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1576B606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ei60ok2e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668C41F0089F;
	Tue, 10 Nov 2026 01:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272604;
	bh=w02F2+E9ZUVrQZkdxmKkf1N6JnbIfDftp6q5/5qotcw=;
	h=From:To:Cc:Subject:Date;
	b=ei60ok2eNA36NDryEP81QMk3vnBBr43G7/KGVw5sTcWliHNYgNrITpiMLphTRKAAQ
	 WUyvofKTHDB39JVG99aFd1QvWlo3nnrcrmH3HgBxu7w8eUl4NTaOJ3I7toPbZpIzoa
	 aU3w6KWlFqJgZxLoeUffXqCs6Z0q2CW9abmfG6fI9J+EQhWeomQ85ednOl2Uqb+yT6
	 eEsmfgF4EETcZfJO07BI1vEWpbO2dQyyK6zv0HNRIekg+it4brjvQ4HjNfVwJmy2oF
	 dPkmhWHon2O63YOwxwcB4awYqk3YBl775VYka5dOuxIbhgHRXu6IXU0MiUmfw8fuIr
	 hTHqL0x/zcq0A==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (sht15) Stop deferred work before releasing its resources" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:03:23 -0500
Message-ID: <20261109200323-failed-6.18-5eab1e7f7ed1@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 5eab1e7f7ed12893f3864fe46ffcd5a41a752d6a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200323-failed-6.18-5eab1e7f7ed1@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5eab1e7f7ed12893f3864fe46ffcd5a41a752d6a Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Fri, 23 Oct 2026 21:40:44 -0400
Subject: [PATCH] hwmon: (sht15) Stop deferred work before releasing its
 resources

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
---
 drivers/hwmon/sht15.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 7bb2105d1ae22..48d93c61345c1 100644
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




