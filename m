Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70D94C77AA
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447812; cv=none; b=QkEsbKhM4KzKK5T0j6AZrQPzU5na74msFfPFtbyctHY3Tzhaw/9V8usQ4vE2KnSauQm6+XbYQra8Tz4k69i4TT/ONGzNwbU0gUaGBmZjjWKVvC7+WeZio8u5CQmE4gDVuYqY2Ua/z1wUrM+Oti229aEvvC+NUMx0xNdbYmua5yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447812; c=relaxed/simple;
	bh=UWfxq/WQWAyig8s5zmndh8Ix0UBZPZinQqsBvgSHZiY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=II2KBx1eF0KdIpKXLttZo271RuqDwkT+a7kDBRyKQ3NI8pQegVy3dTh/FLhpX/GoR9C8Ut4oieG7fqgFenIRuCnhqoaMoYrTYtyRB7u/WdppXTAdBpNR6I+ZuJbkTgvvx5DQmYSuEMASSN1bCISgcMFuA04D1D7GjoSWxPjLaN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hFlqNu5Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hFlqNu5Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97051F000E9;
	Thu,  3 Sep 2026 15:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447810;
	bh=PE+lMgwMSUln1WkoZGNdUZrx7yTUrzpKoV9ehBMELkM=;
	h=Subject:To:Cc:From:Date;
	b=hFlqNu5YndiDvyTTx8MJfuxaoSNo0wkRlzDkCa4X0MeT3dNxGXAsC6TsFnPh8MIML
	 sY1PwHiPoPWB4NKly4qWyiDJXnwRugPcjnMlTYT9GdY8d65AMpxcIGi2WXUAZ0VOW/
	 QGCS5mrT4/Ho4gw0uvefJeLkEPbdw+o2T5Qc70DE=
Subject: FAILED: patch "[PATCH] power: supply: rt9455: quiesce delayed work before teardown" failed to apply to 6.1-stable tree
To: fanwu01@zju.edu.cn,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:39:22 +0200
Message-ID: <2026090322-duller-precut-e80c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3e7a1ebc32fad5a558254a478efd401c17a24381
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090322-duller-precut-e80c@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3e7a1ebc32fad5a558254a478efd401c17a24381 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Thu, 23 Jul 2026 22:53:10 +0000
Subject: [PATCH] power: supply: rt9455: quiesce delayed work before teardown

The threaded IRQ handler can queue pwr_rdy_work,
max_charging_time_work and batt_presence_work.  pwr_rdy_work and
batt_presence_work can also queue max_charging_time_work, while
batt_presence_work can requeue itself.

rt9455_remove() cancels max_charging_time_work before
batt_presence_work.  The latter can therefore queue
max_charging_time_work after it has already been cancelled:

  rt9455_remove()                   workqueue
    cancel pwr_rdy_work
    cancel max_charging_time_work
                                      batt_presence_work queues
                                        max_charging_time_work
    cancel batt_presence_work
    return
    devres frees rt9455_info
                                      max_charging_time_work dereferences
                                        rt9455_info

The IRQ also remains registered until devres cleanup and can queue more
work after any of the cancellation calls.  If rt9455_hw_init() fails
after the IRQ has been requested, probe returns without cancelling work
that may already have been queued.  A pending callback can then access
rt9455_info after it has been freed.

Register rt9455_cancel_all_delayed_works() through
devm_add_action_or_reset() right after devm_power_supply_register().
devres invokes the action in reverse registration order, after the
managed IRQ has been freed and before rt9455_info is released, so the
delayed works are drained in both rt9455_remove() and the probe error
path.  Cancel pwr_rdy_work and batt_presence_work before
max_charging_time_work because both can queue the latter.

This issue was found by an in-house static analysis tool.

Fixes: e86d69dd786e ("power_supply: Add support for Richtek RT9455 battery charger")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260723225310.12663-1-fanwu01@zju.edu.cn
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply/rt9455_charger.c
index 4f3a799db654..313a7371211e 100644
--- a/drivers/power/supply/rt9455_charger.c
+++ b/drivers/power/supply/rt9455_charger.c
@@ -1582,6 +1582,19 @@ static const struct regmap_config rt9455_regmap_config = {
 	.cache_type	= REGCACHE_MAPLE,
 };
 
+static void rt9455_cancel_all_delayed_works(void *data)
+{
+	struct rt9455_info *info = data;
+
+	/*
+	 * Both pwr_rdy_work and batt_presence_work can queue
+	 * max_charging_time_work, so cancel them first.
+	 */
+	cancel_delayed_work_sync(&info->pwr_rdy_work);
+	cancel_delayed_work_sync(&info->batt_presence_work);
+	cancel_delayed_work_sync(&info->max_charging_time_work);
+}
+
 static int rt9455_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
@@ -1672,6 +1685,10 @@ static int rt9455_probe(struct i2c_client *client)
 		goto put_usb_notifier;
 	}
 
+	ret = devm_add_action_or_reset(dev, rt9455_cancel_all_delayed_works, info);
+	if (ret)
+		goto put_usb_notifier;
+
 	ret = devm_request_threaded_irq(dev, client->irq, NULL,
 					rt9455_irq_handler_thread,
 					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
@@ -1710,10 +1727,6 @@ static void rt9455_remove(struct i2c_client *client)
 	if (info->nb.notifier_call)
 		usb_unregister_notifier(info->usb_phy, &info->nb);
 #endif
-
-	cancel_delayed_work_sync(&info->pwr_rdy_work);
-	cancel_delayed_work_sync(&info->max_charging_time_work);
-	cancel_delayed_work_sync(&info->batt_presence_work);
 }
 
 static const struct i2c_device_id rt9455_i2c_id_table[] = {

