Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DBE63CB
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611530; cv=none; b=RUS4aQYJdDPnJ9sy4r8oh+z7rFCAdp/tifCRsbVPMo6eIkBTkcoTI1TqWmSi5E/IRk1VGdypuiwaoWq4cbT5LDGf7Ncq1OzxMaAlQ87qCcUBfRKoj2lEqvF4OMFilpX9t4R0yjdr5ZCsXt4rNEsPo4ef7BqxlQt+xek55StP25s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611530; c=relaxed/simple;
	bh=5fNPRCM2Z4jhi2W7QYchovg5ZYA9sAAgzSapbv3xOas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZNkmLyxmiIqWa4gPDRxk6NAp38Zp0abb8pcse1efoWD4qF1wgkCCIMmONKVPTFEjdKhIAbii/YfbZ1Jt1o+sf51E4chfNQzFxinnLcIxWklClFlgekvVHLlA0jDI7d3R/QJvwJuvABio/kApyEo6wRzPwhqI+Zvsb+6HwDcgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOdM2ETd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOdM2ETd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7BD1F00898;
	Thu, 17 Sep 2026 02:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611528;
	bh=DEn6SZkH6Y8u4tKVWMabATmMBlMfHEr6jE3s6FW9PvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BOdM2ETdf4e8yYIGtbvUhQ185I1l4lhZATeMx88JNxaGRE/MA0fYUuS4jqvLNS1P5
	 uR/WkIg5B92vxkfM1zo9R2MyyEStqWesGzpaBLJruzrZxoqVqBumEpNDtFTb+A7tpI
	 47ngSnMaxIilNrp2Qx2X15q005FmuRBk981dw993Psy4js/pXT1w8Oo1DJE6B9B8rd
	 jlShyBm0HWWDUN1qXGbvW47tDgAkUnorVGFCWpCYycWT9UCj+Cy+TuWpUNNcYFgHI3
	 layydyOHa5O5w8lDk61D58AZdb/nz5CO0CQ0h223JUvToc3squThsSXOw73vtZtB3y
	 cs7soCTeZM8pA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] hwmon: (gpio-fan) Fix use-after-free in alarm work
Date: Wed, 16 Sep 2026 22:18:44 -0400
Message-ID: <20260917021844.3809679-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917021844.3809679-1-sashal@kernel.org>
References: <2026091651-verdict-tactless-1748@gregkh>
 <20260917021844.3809679-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit a2471ed17b0e6ff7bfb6b2ea8e6e5b04c309d293 ]

fan_alarm_irq_handler() queues fan_data->alarm_work, but nothing
cancels it.  fan_alarm_notify() dereferences fan_data and its hwmon
device.  On unbind, devres frees the interrupt, which only waits for
the handler itself, and then releases the hwmon device and fan_data,
so a pending fan_alarm_notify() can run after those frees.

Replace INIT_WORK() with devm_work_autocancel(), registered before
devm_request_irq().  The devres cleanup then frees the interrupt
first, so no new work can be queued, and cancels the work while
fan_data and the hwmon device are still alive.

This issue was found by an in-house static analysis tool.

Fixes: d6fe1360f42e ("hwmon: add generic GPIO fan driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260819033317.446191-1-fanwu01@zju.edu.cn
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/gpio-fan.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index e0b3917dfe6f9..3a880be00cca2 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/devm-helpers.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
@@ -81,6 +82,7 @@ static DEVICE_ATTR_RO(fan1_alarm);
 static int fan_alarm_init(struct gpio_fan_data *fan_data)
 {
 	int alarm_irq;
+	int err;
 	struct device *dev = fan_data->dev;
 
 	/*
@@ -91,7 +93,11 @@ static int fan_alarm_init(struct gpio_fan_data *fan_data)
 	if (alarm_irq <= 0)
 		return 0;
 
-	INIT_WORK(&fan_data->alarm_work, fan_alarm_notify);
+	err = devm_work_autocancel(dev, &fan_data->alarm_work,
+				   fan_alarm_notify);
+	if (err)
+		return err;
+
 	irq_set_irq_type(alarm_irq, IRQ_TYPE_EDGE_BOTH);
 	return devm_request_irq(dev, alarm_irq, fan_alarm_irq_handler,
 				IRQF_SHARED, "GPIO fan alarm", fan_data);
-- 
2.53.0

