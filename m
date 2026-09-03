Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C064C77D3
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447837; cv=none; b=NE69QJ0uVUo7Xj2hpgPxJsHGd02zASP4UPdym03jOaMgjC4TvRIx4xOLIiURwtqEWDaZOduEjkVsOzo3aueDgTUWUQTpsnil8RavjESh4CfPcmaBMYmSEd9AwlhOyXwIEJ5BJzWSR2KiH3li6eyUwol4rX611cucRrysBJVcg9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447837; c=relaxed/simple;
	bh=kLy20EN8ZB0SxLRcdTY4vyqnRPTmV9d7Itr57rxBWW8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RFPvO8Irla9Hnb1OvReqxqd8ScA8X7gXC4tIgq8t+e7Mx3yLKEVlPs06ODDBvvUtAswSIMytqN92EtoHlsqRLTmYG+GFaww44EBOdgLTUBmZEmT1mX6F+lMXb++AgEE6rwrOGf5e0c5SN5DURMXFBvKMGHHEMvA7PDaqwe+0lHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sEJ7izNa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sEJ7izNa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4766C1F00A3A;
	Thu,  3 Sep 2026 15:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447835;
	bh=4Aiug5PdoDmc+gACBCFCxzREon78kHO6fLCTWFrQ5jc=;
	h=Subject:To:Cc:From:Date;
	b=sEJ7izNavW3+ejx+JjI24I4wZuRCgYk6XYHA1TrS387yn3jFx5X5UmxQ1KJPYXPVI
	 jb1mUtmSqLnwslkprKpYGDyiPM1bMMVbhGMKiQReYH2Vk1COm/CYmS46nq06FZ8Bxd
	 n1KJDRmYFdvYD1bDvcUx8RbfNQFAYkwlJqBAeAko=
Subject: FAILED: patch "[PATCH] power: supply: ab8500_fg: fix use-after-free on remove" failed to apply to 6.18-stable tree
To: fanwu01@zju.edu.cn,linusw@kernel.org,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:40:21 +0200
Message-ID: <2026090321-blissful-lily-9edf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 75b1e88d34254f4fb7753345e21bfee47abddd7f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090321-blissful-lily-9edf@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 75b1e88d34254f4fb7753345e21bfee47abddd7f Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Sun, 2 Aug 2026 02:03:16 +0000
Subject: [PATCH] power: supply: ab8500_fg: fix use-after-free on remove

ab8500_fg_remove() destroys the driver workqueue while the threaded
interrupt handlers are still armed; they are devm-managed and freed
only after ->remove() returns, so a handler that fires in that
window queues work on the freed workqueue.

Tear the workqueue down through devm instead, registering its cleanup
after the power supply and before the interrupt requests.  devm then
frees the interrupts first, so the handlers can no longer queue work,
before disabling the delayed and plain work items and destroying the
workqueue.  Disabling the items, rather than cancelling them, keeps
them disabled so no producer (including the power-supply
external_power_changed callback) can requeue them.

Found by an in-house static analysis tool.

Fixes: 13151631b5bd ("ab8500-fg: A8500 fuel gauge driver")
Cc: stable@vger.kernel.org # v6.10+
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20260802020316.417757-1-fanwu01@zju.edu.cn
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index f8f392592193..cfcc05dfe28d 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3054,6 +3054,20 @@ static void ab8500_fg_unbind(struct device *dev, struct device *master,
 	flush_workqueue(di->fg_wq);
 }
 
+/* Disable, not cancel: works stay disabled so nothing can re-arm them. */
+static void ab8500_fg_destroy_workqueue(void *data)
+{
+	struct ab8500_fg *di = data;
+
+	disable_work_sync(&di->fg_acc_cur_work);
+	disable_work_sync(&di->fg_work);
+	disable_delayed_work_sync(&di->fg_reinit_work);
+	disable_delayed_work_sync(&di->fg_low_bat_work);
+	disable_delayed_work_sync(&di->fg_check_hw_failure_work);
+	disable_delayed_work_sync(&di->fg_periodic_work);
+	destroy_workqueue(di->fg_wq);
+}
+
 static const struct component_ops ab8500_fg_component_ops = {
 	.bind = ab8500_fg_bind,
 	.unbind = ab8500_fg_unbind,
@@ -3155,6 +3169,11 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 		return PTR_ERR(di->fg_psy);
 	}
 
+	/* Registered after fg_psy, before the IRQs: devm frees IRQ -> workqueue -> fg_psy. */
+	ret = devm_add_action_or_reset(dev, ab8500_fg_destroy_workqueue, di);
+	if (ret)
+		return ret;
+
 	di->fg_samples = SEC_TO_SAMPLE(di->bm->fg_params->init_timer);
 
 	/*
@@ -3167,20 +3186,16 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	/* Register primary interrupt handlers */
 	for (i = 0; i < ARRAY_SIZE(ab8500_fg_irq); i++) {
 		irq = platform_get_irq_byname(pdev, ab8500_fg_irq[i].name);
-		if (irq < 0) {
-			destroy_workqueue(di->fg_wq);
+		if (irq < 0)
 			return irq;
-		}
 
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 				  ab8500_fg_irq[i].isr,
 				  IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
 				  ab8500_fg_irq[i].name, di);
 
-		if (ret != 0) {
-			destroy_workqueue(di->fg_wq);
+		if (ret != 0)
 			return ret;
-		}
 		dev_dbg(dev, "Requested %s IRQ %d: %d\n",
 			ab8500_fg_irq[i].name, irq, ret);
 	}
@@ -3194,7 +3209,6 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	ret = ab8500_fg_sysfs_init(di);
 	if (ret) {
 		dev_err(dev, "failed to create sysfs entry\n");
-		destroy_workqueue(di->fg_wq);
 		return ret;
 	}
 
@@ -3202,7 +3216,6 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dev, "failed to create FG psy\n");
 		ab8500_fg_sysfs_exit(di);
-		destroy_workqueue(di->fg_wq);
 		return ret;
 	}
 
@@ -3222,7 +3235,6 @@ static void ab8500_fg_remove(struct platform_device *pdev)
 {
 	struct ab8500_fg *di = platform_get_drvdata(pdev);
 
-	destroy_workqueue(di->fg_wq);
 	component_del(&pdev->dev, &ab8500_fg_component_ops);
 	list_del(&di->node);
 	ab8500_fg_sysfs_exit(di);

