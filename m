Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273105;
	b=DHb69+zHwze2iOHwSyX22HBoKMOa92d8lzi+hsw6NfiUz3eABTi/fWt5oAt2EybvHHLu
	 0Lr4wztX9UjEYgcMoIYzd3qMMyOjg80kMIdbIZZBQEuF1ity0kszxY++Wqk9MgyCBq7GG
	 2RltFYPLh/vZ2STi+grYOdgLMDNiHairg6QaaklBwSVZqw3fZhqgnYxpOyS0T3IqDUAJf
	 8S8UylpU77hcOZMA3xOThLxKGawbgiGI5kk5MyNSXFXLEeGsGrJzLvHn4jtyyliYAzEx7
	 Fl0CM9CBXOvNcTVDJIOObAxlprLlGZdJMLZtywzfxFJWxD2FhL/cEE+hMJ7qX2Q4czA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273105;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ADXheSnePHEVAlP3zfApiK8ZuRUo7z/LCrn85iK1fA4=;
	b=Svul6J/ax0hKaPgcKQcJhkaXUZsOJTqf/TaymguhRq9llo0idzkwm9szTJ7R0R2rZQ5Y
	 tLkklzhesxZ7lNY9UrNAq+ohFPttEl2zVXir5F8D4EtrTVFRYTHwM4om/HTAJ9G+rzUfv
	 EWGt1703w9ewtDbZmtBOkAnwahBeEFSrgG5PWuCmPWzBqc2VeaeMV8bsJBZ1S7iloufw1
	 l5r5qu2PlyB+512OS3L3n4P44VejCd0zXpsC6YR+X0VkwjVuefxbOhBZQLzPXfIRsF9ST
	 JKcC28ZzVxxjm9uD3OUS1qtf4D08HbvpwEy0/+34yrvfkLMnw/c+ZF7rYoe1EWwS6CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJYUUxaG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FB3606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJYUUxaG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053A71F0089F;
	Tue, 10 Nov 2026 01:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273104;
	bh=ADXheSnePHEVAlP3zfApiK8ZuRUo7z/LCrn85iK1fA4=;
	h=From:To:Cc:Subject:Date;
	b=ZJYUUxaGhzh9g1aQWqysjDjAAoX4cIDIgJjWgKH+ZAi9ojrkD2G2blk2TN1trbCfR
	 vymV/yhmmkf04OhK/7djKpMSqTU/1kmZud5qEzU6mMpWDcjj96rb/kudnduB71GPTH
	 9Yqz4yQb/11DNueUotz5sMUPki9fCX8m3fAH4MVglMNQMY/oFyjeYAoKxJT+JYr3A/
	 633PD3OpjEwsObchwThEoWHuGMnVjDB7WtvWtVgM6dkzsssrCTjfbhwRTMNMSxegp2
	 jxQhf9yAQ7Pzieq6BjK28qU+n8tiqx/EQrKqpBAogWe/aD4N87SBVGzBYLQXcDHJaq
	 NFvl2Nzi69vFA==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (sht15) Stop deferred work before releasing its resources" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:11:42 -0500
Message-ID: <20261109201142-failed-6.6-5eab1e7f7ed1@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5eab1e7f7ed12893f3864fe46ffcd5a41a752d6a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201142-failed-6.6-5eab1e7f7ed1@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




