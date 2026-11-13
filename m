Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582359;
	b=e2sM7mqe8m+Bs2gAveAQT1fPPA8yJ5aGwk5QD5N24iPFSWoiyJXBYWjnJAElNtu8nI5k
	 OTbG3q9F0g/quWraBtBgvMwtuS+lCd8H1Qyv6nMpdP3hHDnpDyGBy+wBeeysTCS0IYyaU
	 P9vFKaMTuqyi11elL3I76j7//5JBQqJvfLHORYVgh3DJ+g07xW8lh/6aMPuJJmRDowM1U
	 kDHvedsTzkFuR7QI7W4tPH0qcMRjkkDcuxsy0sJu8NLWVjJc8jcyv3+24FjN0z/TSs2jO
	 /Sf7QB8q0y7L18K6seUVPg+eqrkORqRNHv87eVRGbmKSSr5UkfLRq8gDtHeZsXQ5Khw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582359;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wUd59vy+t7BNnxnUhr2fKkMzMsXeEKOtpU9SL8Q2YUs=;
	b=vSc4JLLnCClwg9qmfccNsnIeHNCho3PbX00upQBZzvGTntxh/3VFh7uT0hn+aYBv+gUz
	 4gmdak+HFEdhxhtpiwScJwsc2b3GxAntRUg7x33WYgIF3jUFkd6wy7Xuk12fQ70IdDvgp
	 f6tcZV6OdeCZaphniwk9uk9S33jAle/is0mkRRjpKHIQS0BcdYubuRYntRPSCgMiOCDcx
	 YczPGxktF1L6+95iZsqK7+RBJ6oiixknyVXsw57i7tSvpJOCeSy78Z7y5+K68vKLobGsi
	 z/h4JKU/mHJdgB2VJv5rd/0NPn+oZ3UOWiBahCMkfLjfFAMzDnkFeItxmEvp0n99YTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nd7s7zjs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78952606A32E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nd7s7zjs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D431F000C5;
	Fri, 13 Nov 2026 15:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582359;
	bh=wUd59vy+t7BNnxnUhr2fKkMzMsXeEKOtpU9SL8Q2YUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nd7s7zjsXYVSivB2QkjkOHldwhAyDIGdZYNrTgQcpLjZNA6urd+gaQe7fKPM95ABm
	 k9EbQspRlwgxx4F7KHI1Ci28HtZdg/6gTZE5fkAD/WGqoW45ka9tqSfvuf+eOvvH+t
	 Syq+tvE3fsPtvHaVot8lkeyYkI1S8mOz0V87czeXmdBtSUqF/bEfOpxtQs1s5ylBv2
	 nmB3VzDhc5ch1iwmSK+PqJyujjEl8kzGVA0DBP0qJVFH8Nd4pb2RdKt2z0IQOCCKV0
	 ZTEVsMEjAuakD94LKF3xSv/Gls0IaVpe4qzW+q5wZrsSVkf7ychHqVngpbqKEo8yRi
	 Xq5tOQoOtmaSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] hwmon: chipcap2: serialize access to the alarm indicators
Date: Fri, 13 Nov 2026 10:05:56 -0500
Message-ID: <20261113150539.1843706-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113150539.1843706-1-sashal@kernel.org>
References: <20261109200719-failed-6.12-bed5f0c075eb@kernel.org>
 <20261113150539.1843706-1-sashal@kernel.org>
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

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

[ Upstream commit bed5f0c075eb99442fca6a61c009a32752eceda2 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/chipcap2.c | 58 +++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index a3d5d99bd57ea..49df66728ae9d 100644
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
@@ -88,6 +89,8 @@ struct cc2_data {
 	int irq_low;
 	int irq_high;
 	bool process_irqs;
+	/* protects process_irqs and the alarm indicators */
+	struct mutex irq_lock;
 	bool regulator_enabled;
 };
 
@@ -119,7 +122,8 @@ static int cc2_enable(struct cc2_data *data)
 
 	/* exclusive regulator, check in case a disable failed */
 	if (data->regulator_enabled) {
-		data->process_irqs = true;
+		scoped_guard(mutex, &data->irq_lock)
+			data->process_irqs = true;
 		return 0;
 	}
 
@@ -134,7 +138,8 @@ static int cc2_enable(struct cc2_data *data)
 
 	usleep_range(CC2_STARTUP_TIME_US, CC2_STARTUP_TIME_US + 125);
 
-	data->process_irqs = true;
+	scoped_guard(mutex, &data->irq_lock)
+		data->process_irqs = true;
 
 	return 0;
 }
@@ -151,7 +156,8 @@ static void cc2_disable(struct cc2_data *data)
 		synchronize_irq(data->irq_high);
 
 	/* ignore alarms triggered by voltage toggling when powering up */
-	data->process_irqs = false;
+	scoped_guard(mutex, &data->irq_lock)
+		data->process_irqs = false;
 
 	/* exclusive regulator, check in case an enable failed */
 	if (!data->regulator_enabled)
@@ -502,10 +508,12 @@ static irqreturn_t cc2_low_interrupt(int irq, void *data)
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
@@ -515,10 +523,12 @@ static irqreturn_t cc2_high_interrupt(int irq, void *data)
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
@@ -534,11 +544,13 @@ static int cc2_humidity_min_alarm_status(struct cc2_data *data, long *val)
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
@@ -554,11 +566,13 @@ static int cc2_humidity_max_alarm_status(struct cc2_data *data, long *val)
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
@@ -721,6 +735,8 @@ static int cc2_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, data);
 
+	mutex_init(&data->irq_lock);
+
 	data->client = client;
 
 	data->regulator = devm_regulator_get_exclusive(dev, "vdd");
-- 
2.53.0

