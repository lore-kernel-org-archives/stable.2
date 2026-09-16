Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811A33DED9
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575156; cv=none; b=hTNJ5R5Jl/yjp497OAvIvyKw9a79HxDK+OYGpZrEdK74Jn2w4b0cdhecABDyX5oW+2a5Cz03ykoUgjMAw8ieTV2/d6NprUErxocGDngk8LARPMnaWBSHrtvt4/AAByclZQl5IbFcJ05tXz1630WvV9kVuS0wYqd4ZkgXuNhzU+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575156; c=relaxed/simple;
	bh=7Ji8zlwL7Uwgz7frYuXhE6WdGC9LALrzY1OQKXrHXlI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QLpCwxhAE7FG1y6I2GRdOxSkpMsI/ZGlWfJ9KQh/aVSVE42Lwb8X01T7ZbwsPOBdXjqOfbPrZjzQeG1N4znSdLQ6EbgSKbhHGQcOf1WjBfePYGT019bGCIIEb3C07V8Cn7Q+LTmEh3rETWchJNB9QqiwaHqrMNQE/GLcrzQwrkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bpwP6nWH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bpwP6nWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4791F000FF;
	Wed, 16 Sep 2026 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789575153;
	bh=qjjWwVDEbH1OB7F+ZD7nbzPN1vHWivq1xeGl8/gEAt0=;
	h=Subject:To:Cc:From:Date;
	b=bpwP6nWHnIFmODHRrYU4SCeRE9vJtTV/poW4xvO56Ta/taIb28w5hY5fa9iqQxSOQ
	 pYPUfEZ35o5Xpfpo7LkNYTqujUMLw39k8ZDeCcddPJi687f9BdcMlgbBNWJyXEinzb
	 FnkGN+f4pQj8NfQ2hdyNhldlUMpTno5470xkIXsU=
Subject: FAILED: patch "[PATCH] hwmon: (gpio-fan) Fix use-after-free in alarm work" failed to apply to 5.10-stable tree
To: fanwu01@zju.edu.cn,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:01:51 +0100
Message-ID: <2026091651-verdict-tactless-1748@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a2471ed17b0e6ff7bfb6b2ea8e6e5b04c309d293
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091651-verdict-tactless-1748@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a2471ed17b0e6ff7bfb6b2ea8e6e5b04c309d293 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Wed, 19 Aug 2026 03:33:17 +0000
Subject: [PATCH] hwmon: (gpio-fan) Fix use-after-free in alarm work

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

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index 084828e1e281..7f36e5f6f223 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/devm-helpers.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
 #include <linux/kstrtox.h>
@@ -84,6 +85,7 @@ static DEVICE_ATTR_RO(fan1_alarm);
 static int fan_alarm_init(struct gpio_fan_data *fan_data)
 {
 	int alarm_irq;
+	int err;
 	struct device *dev = fan_data->dev;
 
 	/*
@@ -94,7 +96,11 @@ static int fan_alarm_init(struct gpio_fan_data *fan_data)
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

