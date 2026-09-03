Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06C84E140D
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449753; cv=none; b=azx7Bt20iUaYoVV+LGiFOMQQAIZL8rNJtc+DdXobqC6JPm4IS+lLXFuofWsY0z7///Uahh0OEeJuoD7g59ey6T0cGlGrJu1XjbY78Idt+tgH+zm91/mYgQwSrmJXGdno562EMJtgBXxJpqrH+wbexhHwyLrYp+mTh7a0hDvr0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449753; c=relaxed/simple;
	bh=NkTbbGpS5afVYEfJViofNtyUkq39LE3gneexry5FCEw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T/A15DSm6SBIk4D+3Sg4j3kMq689e0GTnO6p6w2iMT/e+Ir8n21jOjz4WUSHtwk7ixSk1xO6aZV0CbsrDpn5osFGtMiZfW35JMz6r2oJmjIgGq+nPzadCRTOo9ONxISOozLqBrqldhi7fqLD4zPmZGTgR+m48cu6G1Rrksy8Qf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B0J6mEly; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B0J6mEly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329AC1F000E9;
	Thu,  3 Sep 2026 15:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449751;
	bh=6I+TbB9oqCqIgNp2fkEBKGkuQKaYngJnTu7dchNu5qA=;
	h=Subject:To:Cc:From:Date;
	b=B0J6mElywnWi/CWhnxs0E3brWeTrzBfrpfysGqGnlLUWLSEYPvATEDfKqTiQc5LwV
	 DY2TjeWCCtcLsNcj7Q2XYLQrA0JWdxAdEAEIVdHu7pCzk2THhKxpS9FDnw9gL5jrrF
	 pHG+RgT21RXjvYdC+IvQV39gVsnQZ1r/sj5i6fFA=
Subject: FAILED: patch "[PATCH] power: supply: bq24257: fix use-after-free on remove" failed to apply to 5.10-stable tree
To: fanwu01@zju.edu.cn,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:04:27 +0200
Message-ID: <2026090327-map-reptilian-66d3@gregkh>
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
git cherry-pick -x 9d34c9d660c3d0931d2cc749c46c47cf31f96e48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090327-map-reptilian-66d3@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9d34c9d660c3d0931d2cc749c46c47cf31f96e48 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Sat, 1 Aug 2026 05:19:58 +0000
Subject: [PATCH] power: supply: bq24257: fix use-after-free on remove

The STAT-pin interrupt is devm-managed, so it stays armed until the devm
cleanup that runs after remove() returns. remove() cancels
bq->iilimit_setup_work while the threaded handler can still fire; that
handler reschedules the work and dereferences bq, so the work runs
against freed memory once devm frees bq.

Make the delayed work device-managed with devm_delayed_work_autocancel(),
registered before the interrupt request. The devm cleanup then releases
the interrupt first, so the handler can no longer reschedule the work,
and cancels the work before bq is freed. The explicit
cancel_delayed_work_sync() in remove() is no longer needed and is dropped.

Found by static analysis.

Fixes: 2219a935963e ("power_supply: Add TI BQ24257 charger driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260731143554.334179-1-fanwu01@zju.edu.cn
Link: https://patch.msgid.link/20260801051958.354528-1-fanwu01@zju.edu.cn
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/supply/bq24257_charger.c
index d6286be4af74..944a7aa6f187 100644
--- a/drivers/power/supply/bq24257_charger.c
+++ b/drivers/power/supply/bq24257_charger.c
@@ -18,6 +18,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
 
 #include <linux/acpi.h>
 #include <linux/of.h>
@@ -1003,10 +1004,6 @@ static int bq24257_probe(struct i2c_client *client)
 	if (bq->info->chip == BQ24250)
 		bq->iilimit_autoset_enable = false;
 
-	if (bq->iilimit_autoset_enable)
-		INIT_DELAYED_WORK(&bq->iilimit_setup_work,
-				  bq24257_iilimit_setup_work);
-
 	/*
 	 * The BQ24250 doesn't have a dedicated Power Good (PG) pin so let's
 	 * not probe for it and instead use a SW-based approach to determine
@@ -1047,6 +1044,14 @@ static int bq24257_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	if (bq->iilimit_autoset_enable) {
+		ret = devm_delayed_work_autocancel(dev,
+						   &bq->iilimit_setup_work,
+						   bq24257_iilimit_setup_work);
+		if (ret)
+			return ret;
+	}
+
 	ret = devm_request_threaded_irq(dev, client->irq, NULL,
 					bq24257_irq_handler_thread,
 					IRQF_TRIGGER_FALLING |
@@ -1062,9 +1067,6 @@ static void bq24257_remove(struct i2c_client *client)
 {
 	struct bq24257_device *bq = i2c_get_clientdata(client);
 
-	if (bq->iilimit_autoset_enable)
-		cancel_delayed_work_sync(&bq->iilimit_setup_work);
-
 	bq24257_field_write(bq, F_RESET, 1); /* reset to defaults */
 }
 

