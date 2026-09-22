Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81031489FC0
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101277; cv=none; b=LqjifUme8K2pxbdpDEt77mwA4g3gW1x3cLjjvzOGj5MOILF7SsqzO8l6Lzw3UvzQdsDfhMC0L/8o8wrwrd2TkIe251ZZMyXAW2tZ9TpNCz0BwBxhNfccmMauChVou4ugepRo94kGswJ3j1x3Wx153vbgXMq8Cg3pb71TFGiEUpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101277; c=relaxed/simple;
	bh=di6h4mixklrrT0z+XNUYzsIIDikaCcB65MjUCepTva8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHTD758G4hy1FvpVQXV6BFd95QrK98v0A93ymeacmvnv2L3logXnqCWxqNToYBgE59YsI3ouayAEdhWm6sePpElHQ8NDf6/UzssJEm0K9J5G9iNgMQSQtfJFfs2K2GbMK+WvkXSTkQ8NLyH5cywaSuhOF3Z8di2/mb7mEfdGaYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsgzUGAd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsgzUGAd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C776C1F00893;
	Tue, 22 Sep 2026 18:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101273;
	bh=7KicByk7BgcISK6APTf0tg3e0vLlJxqt3FOuyxGUsaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FsgzUGAd0DXtRq7QS49Y3ilB2frAembGD0D88fa5dGz+C2iDg11zS2RcAHgzBtouc
	 n65nWirr9s04FH4vmPfJCE6Q0IMrVwhKegXheAz5M2d8EI+vWdF1cygrD4Y3lwxzmJ
	 MSEJ9UKZ4nJi0g/trH5bvaXjfVrEy1vzypCuO20SWovix5JQA7lbPyPx5tym0dWcDR
	 AJdAXgLXm8XTZNpY8JlFERmFkSnpgyhp6hSfwl4rtR6PFeBbDfc20JgJR6HjUcchdr
	 IRBBB4fnNSSHkWNpt+w+29icjZFiIruSeZ2vdsURGPoFdoiHed+Ty+fGjbV+JTg6Tf
	 cfhiW+JMf3hEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] Input: adp5588-keys - switch to using threaded interrupt
Date: Tue, 22 Sep 2026 14:21:08 -0400
Message-ID: <20260922182110.3568173-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922182110.3568173-1-sashal@kernel.org>
References: <2026092232-wanting-charbroil-6f57@gregkh>
 <20260922182110.3568173-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 2d1159854f86835dd661b5289c1df5de7856e583 ]

Instead of using hard interrupt handler and manually scheduling work
item to handle I2C communications, let's switch to threaded interrupt
handling.

While at that enforce the readout delay required on pre- revision 4
silicon.

Acked-by: Michael Hennerich <michael.hennerich@analog.com>
Link: https://lore.kernel.org/r/20220528045631.289821-2-dmitry.torokhov@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Stable-dep-of: 21efadc62272 ("Input: adp5588-keys - cache GPIO state before registering the gpiochip")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/adp5588-keys.c | 81 +++++++++++++++------------
 1 file changed, 45 insertions(+), 36 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 1592da4de3360..a94ebd8d6c6e3 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -8,17 +8,19 @@
  * Copyright (C) 2008-2010 Analog Devices Inc.
  */
 
-#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/gpio/driver.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/workqueue.h>
-#include <linux/errno.h>
-#include <linux/pm.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/input.h>
-#include <linux/i2c.h>
-#include <linux/gpio/driver.h>
+#include <linux/pm.h>
 #include <linux/slab.h>
+#include <linux/timekeeping.h>
 
 #include <linux/platform_data/adp5588.h>
 
@@ -36,11 +38,12 @@
  * asserted.
  */
 #define WA_DELAYED_READOUT_REVID(rev)		((rev) < 4)
+#define WA_DELAYED_READOUT_TIME			25
 
 struct adp5588_kpad {
 	struct i2c_client *client;
 	struct input_dev *input;
-	struct delayed_work work;
+	ktime_t irq_time;
 	unsigned long delay;
 	unsigned short keycode[ADP5588_KEYMAPSIZE];
 	const struct adp5588_gpi_map *gpimap;
@@ -289,13 +292,36 @@ static void adp5588_report_events(struct adp5588_kpad *kpad, int ev_cnt)
 	}
 }
 
-static void adp5588_work(struct work_struct *work)
+static irqreturn_t adp5588_hard_irq(int irq, void *handle)
+{
+	struct adp5588_kpad *kpad = handle;
+
+	kpad->irq_time = ktime_get();
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t adp5588_thread_irq(int irq, void *handle)
 {
-	struct adp5588_kpad *kpad = container_of(work,
-						struct adp5588_kpad, work.work);
+	struct adp5588_kpad *kpad = handle;
 	struct i2c_client *client = kpad->client;
+	ktime_t target_time, now;
+	unsigned long delay;
 	int status, ev_cnt;
 
+	/*
+	 * Readout needs to wait for at least 25ms after the notification
+	 * for REVID < 4.
+	 */
+	if (kpad->delay) {
+		target_time = ktime_add_ms(kpad->irq_time, kpad->delay);
+		now = ktime_get();
+		if (ktime_before(now, target_time)) {
+			delay = ktime_to_us(ktime_sub(target_time, now));
+			usleep_range(delay, delay + 1000);
+		}
+	}
+
 	status = adp5588_read(client, INT_STAT);
 
 	if (status & ADP5588_OVR_FLOW_INT)	/* Unlikely and should never happen */
@@ -308,20 +334,8 @@ static void adp5588_work(struct work_struct *work)
 			input_sync(kpad->input);
 		}
 	}
-	adp5588_write(client, INT_STAT, status); /* Status is W1C */
-}
 
-static irqreturn_t adp5588_irq(int irq, void *handle)
-{
-	struct adp5588_kpad *kpad = handle;
-
-	/*
-	 * use keventd context to read the event fifo registers
-	 * Schedule readout at least 25ms after notification for
-	 * REVID < 4
-	 */
-
-	schedule_delayed_work(&kpad->work, kpad->delay);
+	adp5588_write(client, INT_STAT, status); /* Status is W1C */
 
 	return IRQ_HANDLED;
 }
@@ -505,7 +519,6 @@ static int adp5588_probe(struct i2c_client *client,
 
 	kpad->client = client;
 	kpad->input = input;
-	INIT_DELAYED_WORK(&kpad->work, adp5588_work);
 
 	ret = adp5588_read(client, DEV_ID);
 	if (ret < 0) {
@@ -515,7 +528,7 @@ static int adp5588_probe(struct i2c_client *client,
 
 	revid = (u8) ret & ADP5588_DEVICE_ID_MASK;
 	if (WA_DELAYED_READOUT_REVID(revid))
-		kpad->delay = msecs_to_jiffies(30);
+		kpad->delay = msecs_to_jiffies(WA_DELAYED_READOUT_TIME);
 
 	input->name = client->name;
 	input->phys = "adp5588-keys/input0";
@@ -560,9 +573,10 @@ static int adp5588_probe(struct i2c_client *client,
 		goto err_free_mem;
 	}
 
-	error = request_irq(client->irq, adp5588_irq,
-			    IRQF_TRIGGER_FALLING,
-			    client->dev.driver->name, kpad);
+	error = request_threaded_irq(client->irq,
+				     adp5588_hard_irq, adp5588_thread_irq,
+				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				     client->dev.driver->name, kpad);
 	if (error) {
 		dev_err(&client->dev, "irq %d busy?\n", client->irq);
 		goto err_unreg_dev;
@@ -587,7 +601,6 @@ static int adp5588_probe(struct i2c_client *client,
 
  err_free_irq:
 	free_irq(client->irq, kpad);
-	cancel_delayed_work_sync(&kpad->work);
  err_unreg_dev:
 	input_unregister_device(input);
 	input = NULL;
@@ -604,7 +617,6 @@ static int adp5588_remove(struct i2c_client *client)
 
 	adp5588_write(client, CFG, 0);
 	free_irq(client->irq, kpad);
-	cancel_delayed_work_sync(&kpad->work);
 	input_unregister_device(kpad->input);
 	adp5588_gpio_remove(kpad);
 	kfree(kpad);
@@ -615,11 +627,9 @@ static int adp5588_remove(struct i2c_client *client)
 #ifdef CONFIG_PM
 static int adp5588_suspend(struct device *dev)
 {
-	struct adp5588_kpad *kpad = dev_get_drvdata(dev);
-	struct i2c_client *client = kpad->client;
+	struct i2c_client *client = to_i2c_client(dev);
 
 	disable_irq(client->irq);
-	cancel_delayed_work_sync(&kpad->work);
 
 	if (device_may_wakeup(&client->dev))
 		enable_irq_wake(client->irq);
@@ -629,8 +639,7 @@ static int adp5588_suspend(struct device *dev)
 
 static int adp5588_resume(struct device *dev)
 {
-	struct adp5588_kpad *kpad = dev_get_drvdata(dev);
-	struct i2c_client *client = kpad->client;
+	struct i2c_client *client = to_i2c_client(dev);
 
 	if (device_may_wakeup(&client->dev))
 		disable_irq_wake(client->irq);
-- 
2.53.0

