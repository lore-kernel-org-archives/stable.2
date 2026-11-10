Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273687;
	b=l5PwmNw9GSCZMlbgSYbF/XnDoByvjY+j82BaDOxO28B+FGnY67FWK6kS5sNohhYL113s
	 Khyh3edIs7LyfZU729p6QyGwMpVKxygmocHCbt8l8DH71PVReRFMBoUbfyAOjSTJqZZl2
	 QJyJV8PpdjwRKTqZzADpo0cUNWEbyTfp/XyAlUawX8vHQ05cmPaOIRc8mUcyCBhazonI2
	 g8J2rC6DVIwPGRXObBCqqNZVX2WG//A/UjyPKEEqxdx0/6Fq9iAjzOZ0UoOvV3mMLKErn
	 EEI/zevL++7TZUFimca6rQhtzk8fpLMEb7p8NO1PGKixWGoriBTFEDmpiFutxf+w0Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273687;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tmmMnvnCIJVSvqau1kYeWFUshZ3A1G53BsE5Xm4wh44=;
	b=htUEueQ6lp/IT2NGzwZW9OjHxoYX7o9UD+1JCNEgmYXuhKx+Flqeq0ZD/fzhqFJ2Z8K1
	 kEwvE/rP+XWAb8eJkHaix28c0n3r9zRuLsrToJ3DFGMWoZYdjf+n5wlhuGAt7wlA5QYT4
	 VUUFgCOTMiZ+AzybumMLz3IAr1aWzRf0uhOIfNir7E42m4xPGwhhF+m2wyEfus/7qSQYs
	 3+0pjODLIQljN9Sp5GWkGLYM3T9YJ8Hj6Fq3DuAS/JtPgxWGhMhvICIXkwUT5tmjeSzPP
	 +QmZllmhdg9CXMLAqV6CRZlRkFiPbh1xihUQeocODC+0Vb8qLC6D2lI6RdJfEDzCdWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIW+xDtM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C1B606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIW+xDtM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33A11F0089F;
	Tue, 10 Nov 2026 01:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273687;
	bh=tmmMnvnCIJVSvqau1kYeWFUshZ3A1G53BsE5Xm4wh44=;
	h=From:To:Cc:Subject:Date;
	b=kIW+xDtMhp9+mwIfW3/bagKpe9D7oktlT/1xJ3XYQl3lhLxqTtqxgSfV8WDNgdyGv
	 h0yFjmt2YXGdMyYMyvRie83wt87D8HjUo6vz5e/pInVPcXGAtmjRHJ5fFenITc8Ypt
	 HwoxB20exSJ8zKlNLkfY9UHkJjC4eNBggNyUnleuei6x94KiecO8aFO/+aCsbLYYK1
	 kikrLBUMsDKlqp5Lco64X96M0QptoN6VZJphtua+VYsK1OI4SiTbroT0ydjZGCEuZP
	 hC1xL3uBCzdC8wRb13gKnYl0ynEehWrsysLQ9R+dZnVPheq2a2qYVqYaDHznmLVph5
	 uGX2XLFsyeZpQ==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (sht15) Stop deferred work before releasing its resources" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:21:25 -0500
Message-ID: <20261109202125-failed-5.15-5eab1e7f7ed1@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5eab1e7f7ed12893f3864fe46ffcd5a41a752d6a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202125-failed-5.15-5eab1e7f7ed1@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




