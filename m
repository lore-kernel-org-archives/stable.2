Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272841;
	b=J/grlNvW2NMa1sv7tefoZwsV7jCS90f9iZ8i5lQr1fuA5lLSRbw7KAyXzseGp/tNBgHf
	 1ebKe0M3dvd89IH7HwzyKb1E8NCmYEgg4bcPH0EWHKFh5wGS1KZagxQPZNjdn+VLsbKro
	 owtW/gd72em9jQRaCDoa/4taSimjTlxd1iq1Q8M6M5CXHqNtkEJFlOze0CC1t+4ZSxLOZ
	 6LU+H3l36gOlNdrv2FYJewZ0++wOtaFErH78A4GYwCkA5CxX1fxXySpS/nqFfITtvpt3u
	 RaAl1ZwIjI0V1hJDNndW/0D/H0vtBw/UAthwc/9pg4jLa7BSKGJJ8/ONopRfJ+4xtqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272841;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=40mooO1sOJdM1ThsEvsGJenRf/HWT+J3eTGTIigUr+k=;
	b=etMcb/dfNmgV82EprOO2A3CAJXcXIzqHGexqJSmElyQmZkFx4OGtKvc6wOc3+KrdHx4m
	 DcqHaIjhWy3gpVGjyZCl6P00y32mU1u4MW5wz+daq0CQ60ygPIh4LU1jFYA7P/ILhNoSL
	 Cb/XDOQVU3zjFfd6L6j6Y5iAfPPrVvz+BkNIpomY3w7g7XZzX3qEBsnmaEsk457fdZo6P
	 pdqH3vkNEgT7I0SblFx0rsrRiAkj/ST8VSX7oTzHgQhnWE03ma8AiGjpCrWDBnLZR7Yb5
	 naDp9S/nTo9fv69FCCSIevva0k4L4i/gfMn+9Z6G0WoyXSq44ciwPLfp4bgg1NzwqBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlVTEI9c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485B606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlVTEI9c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1521F008A1;
	Tue, 10 Nov 2026 01:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272840;
	bh=40mooO1sOJdM1ThsEvsGJenRf/HWT+J3eTGTIigUr+k=;
	h=From:To:Cc:Subject:Date;
	b=FlVTEI9cr+9hfu76pXcV9IVCfc2yxdcaY0f6YFqdx2qSzjyIdq1g6K/IxII7P7RfL
	 OmmYnOCgsfPuw2Dht003syN7iC0WaJUf9dh7VaRdhtvwp7SBFXqXEcksZvPKbyIbN4
	 hUb22s4i8W05yQWzXMZf5d+qK+tolxfCVID5rykj9cPhbAFLlzLtPq7GFue4AdYn02
	 JaqaLJdK+hAnj17fTT8LKkV2SzHgLUOwWpJSWu8QIEuhhxXf6lP9gSVhrZ6VYqC2Py
	 V4RL3YYYdtaIwJotbQ9jqQGd0uRiJpT5EjjjAjVroohpzNU/XzDXdfM71+d8Djkz4v
	 7ypkQiKlc0edw==
From: Sasha Levin <sashal@kernel.org>
To: javier.carrasco.cruz@gmail.com,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: chipcap2: serialize access to the alarm indicators" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:07:19 -0500
Message-ID: <20261109200719-failed-6.12-bed5f0c075eb@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x bed5f0c075eb99442fca6a61c009a32752eceda2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200719-failed-6.12-bed5f0c075eb@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bed5f0c075eb99442fca6a61c009a32752eceda2 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 14 Oct 2026 19:34:09 +0200
Subject: [PATCH] hwmon: chipcap2: serialize access to the alarm indicators

low_alarm and high_alarm are accessed from the threaded interrupt
handlers and from sysfs without any locking, which can lead to lost
alarms.

Add a mutex to serialize the access to the alarm indicators and to
process_irqs, which the handlers use to decide whether an interrupt
belongs to an ongoing operation.

Fixes: 3af350929e75 ("hwmon: Add support for Amphenol ChipCap 2")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20261014-chipcap2_locks-v3-10-27ebfc2c5b9e@gmail.com
[groeck: Dropped obsolete 'Assisted-by: tag]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/chipcap2.c | 58 +++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index eba6469940ab5..b3b725cc7224f 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -20,6 +20,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/mutex.h>
 #include <linux/module.h>
 #include <linux/unaligned.h>
 #include <linux/regulator/consumer.h>
@@ -91,6 +92,8 @@ struct cc2_data {
 	int irq_low;
 	int irq_high;
 	bool process_irqs;
+	/* protects process_irqs and the alarm indicators */
+	struct mutex irq_lock;
 	bool regulator_enabled;
 };
 
@@ -122,7 +125,8 @@ static int cc2_enable(struct cc2_data *data)
 
 	/* exclusive regulator, check in case a disable failed */
 	if (data->regulator_enabled) {
-		data->process_irqs = true;
+		scoped_guard(mutex, &data->irq_lock)
+			data->process_irqs = true;
 		return 0;
 	}
 
@@ -137,7 +141,8 @@ static int cc2_enable(struct cc2_data *data)
 
 	usleep_range(CC2_STARTUP_TIME_US, CC2_STARTUP_TIME_US + 125);
 
-	data->process_irqs = true;
+	scoped_guard(mutex, &data->irq_lock)
+		data->process_irqs = true;
 
 	return 0;
 }
@@ -154,7 +159,8 @@ static void cc2_disable(struct cc2_data *data)
 		synchronize_irq(data->irq_high);
 
 	/* ignore alarms triggered by voltage toggling when powering up */
-	data->process_irqs = false;
+	scoped_guard(mutex, &data->irq_lock)
+		data->process_irqs = false;
 
 	/* exclusive regulator, check in case an enable failed */
 	if (!data->regulator_enabled)
@@ -514,10 +520,12 @@ static irqreturn_t cc2_low_interrupt(int irq, void *data)
 {
 	struct cc2_data *cc2 = data;
 
-	if (cc2->process_irqs) {
-		hwmon_notify_event(cc2->hwmon, hwmon_humidity,
-				   hwmon_humidity_min_alarm, 0);
-		cc2->rh_alarm.low_alarm = true;
+	scoped_guard(mutex, &cc2->irq_lock) {
+		if (cc2->process_irqs) {
+			hwmon_notify_event(cc2->hwmon, hwmon_humidity,
+					   hwmon_humidity_min_alarm, 0);
+			cc2->rh_alarm.low_alarm = true;
+		}
 	}
 
 	return IRQ_HANDLED;
@@ -527,10 +535,12 @@ static irqreturn_t cc2_high_interrupt(int irq, void *data)
 {
 	struct cc2_data *cc2 = data;
 
-	if (cc2->process_irqs) {
-		hwmon_notify_event(cc2->hwmon, hwmon_humidity,
-				   hwmon_humidity_max_alarm, 0);
-		cc2->rh_alarm.high_alarm = true;
+	scoped_guard(mutex, &cc2->irq_lock) {
+		if (cc2->process_irqs) {
+			hwmon_notify_event(cc2->hwmon, hwmon_humidity,
+					   hwmon_humidity_max_alarm, 0);
+			cc2->rh_alarm.high_alarm = true;
+		}
 	}
 
 	return IRQ_HANDLED;
@@ -546,11 +556,13 @@ static int cc2_humidity_min_alarm_status(struct cc2_data *data, long *val)
 	if (ret < 0)
 		return ret;
 
-	if (data->rh_alarm.low_alarm) {
-		*val = (measurement < min_hyst) ? 1 : 0;
-		data->rh_alarm.low_alarm = *val;
-	} else {
-		*val = 0;
+	scoped_guard(mutex, &data->irq_lock) {
+		if (data->rh_alarm.low_alarm) {
+			*val = (measurement < min_hyst) ? 1 : 0;
+			data->rh_alarm.low_alarm = *val;
+		} else {
+			*val = 0;
+		}
 	}
 
 	return 0;
@@ -566,11 +578,13 @@ static int cc2_humidity_max_alarm_status(struct cc2_data *data, long *val)
 	if (ret < 0)
 		return ret;
 
-	if (data->rh_alarm.high_alarm) {
-		*val = (measurement > max_hyst) ? 1 : 0;
-		data->rh_alarm.high_alarm = *val;
-	} else {
-		*val = 0;
+	scoped_guard(mutex, &data->irq_lock) {
+		if (data->rh_alarm.high_alarm) {
+			*val = (measurement > max_hyst) ? 1 : 0;
+			data->rh_alarm.high_alarm = *val;
+		} else {
+			*val = 0;
+		}
 	}
 
 	return 0;
@@ -753,6 +767,8 @@ static int cc2_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, data);
 
+	mutex_init(&data->irq_lock);
+
 	data->client = client;
 
 	data->regulator = devm_regulator_get_exclusive(dev, "vdd");
-- 
2.53.0




