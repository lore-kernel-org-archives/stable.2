Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8874E2342
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449759; cv=none; b=vBPUEkIHZk+Xz+5HGS26LLkHwmkjkwxcUkUznwxDtS7sG9UoSHTyiZnThK9VubBwpWrmV2cqB0YGpe6Bb1zlvuhrNzkBdwzFxrJYcjiusRNDqyEJtHl4nrJa5fHzWJH6YHysNyngaf5Y0UFX/v6d/AhF+20aDIvPFAjgNjarMXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449759; c=relaxed/simple;
	bh=k8wVWO4H6PkhqArZaZYd/vts6FkpBL5z83NmgAxhV80=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pvqGXLKjftTfaoiY01BzFJ2l/gaJ73V6aKu5NPnYVBO72vtqjtJrvSbqS1UDTcwiUh3/5H34T7X6a1NAl3sCr7e4arE+qyClWCKh/+bwikEzRmvjie2faBY6OpB1XUdfM4q9e7elyBOdBVKWbyYe2GHbrIUAmMRXrRGJAHrP/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YbRLSGFJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YbRLSGFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D853C1F00A3A;
	Thu,  3 Sep 2026 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449757;
	bh=yW3m4yjTfZF4CjXEkuyTWWNH4KF2Kbh5Ulw6jwd4GS8=;
	h=Subject:To:Cc:From:Date;
	b=YbRLSGFJ8VSzcyQ9gTtaL9Ie+FEkxyXiIOw8wXFGarpf2T7T+CKOHEJDF5Zxm88TF
	 GR6hu7qwIlMdVkHM2VSPP9PHuONf5yfyd2RaUBZRGT6vq32D0LEG0aFzWfI1POUvPY
	 0YmaVKX16WrKiep1kmMIYbiZZUJsTKb+4ANPzNtg=
Subject: FAILED: patch "[PATCH] power: supply: ucs1002: fix use-after-free on remove" failed to apply to 5.10-stable tree
To: fanwu01@zju.edu.cn,l.stach@pengutronix.de,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:05:27 +0200
Message-ID: <2026090327-abiding-enamel-2481@gregkh>
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
git cherry-pick -x 609af0ceeaefdfa42cd01dd060b20f2e41f9a232
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090327-abiding-enamel-2481@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 609af0ceeaefdfa42cd01dd060b20f2e41f9a232 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Sun, 2 Aug 2026 05:12:49 +0000
Subject: [PATCH] power: supply: ucs1002: fix use-after-free on remove

ucs1002 has no remove callback, so unbind runs entirely through devm.
The alert IRQ handler queues the health_poll delayed work, and the work
reschedules itself while the chip reports a bad-health condition.  devm
frees the alert IRQ, which only synchronizes the handler; it does not
cancel the delayed work, which can then run after devm frees the driver
data and dereference it.

Register health_poll with devm_delayed_work_autocancel() before the
alert IRQ is requested.  devm then frees the IRQ before cancelling the
work, so the handler can no longer queue it and the work is cancelled
before the driver data is freed.

This issue was found by an in-house static analysis tool.

Fixes: 81196e2e57fc ("power: supply: ucs1002: fix some health status issues")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Link: https://patch.msgid.link/20260802051249.424015-1-fanwu01@zju.edu.cn
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index 735880ed1cc8..bf13e958982e 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/kthread.h>
 #include <linux/device.h>
+#include <linux/devm-helpers.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -640,7 +641,10 @@ static int ucs1002_probe(struct i2c_client *client)
 	}
 
 	info->health = POWER_SUPPLY_HEALTH_GOOD;
-	INIT_DELAYED_WORK(&info->health_poll, ucs1002_health_poll);
+	ret = devm_delayed_work_autocancel(dev, &info->health_poll,
+					   ucs1002_health_poll);
+	if (ret)
+		return ret;
 
 	if (irq_a_det > 0) {
 		ret = devm_request_threaded_irq(dev, irq_a_det, NULL,

