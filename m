Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8674C901B
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447843; cv=none; b=Ji3s02j4q2Xw9cLY5gBo1yeNjPkxO5PKCyhMnZSODQnto0ekDjghDWiZDZG/3t+jJGmf3L3k2niSfA0Z1DZat41O+k9Bazjde8xdO7GDYTn8Uded3wkcOOOYYXgTZLBHMjN7KgBvVfT2Jz8jdIXjJkJnMRTtXj5NutS6QQZXWac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447843; c=relaxed/simple;
	bh=xd5gZM08ob0DSyt39m/Y2vUNKdsMR/1CgvHpOzMCnS4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MzNtr4w0M8VYgLGRRwSfwlKX8CYAwlVpGjPZxF9FaUX5dvBP+lTTuUyXRz/1wDHWk7epgRkTpI/aAEHOsgHLVn4facTbwykTJtLq5ar4a+ENArT2+CTUysG6wjBXzkGVhMSzDwpCfZVKo5E5OvRZ6SIG+0gKBtPrpP01EKHmgeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VULany2Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VULany2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D341F00A3A;
	Thu,  3 Sep 2026 15:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447841;
	bh=RmJc8Lg0lKDAjmLGnMRinLJKoax0UZC+u0yWhX4fnv8=;
	h=Subject:To:Cc:From:Date;
	b=VULany2Qoz9EHlLdffd0s7/z5p8EBKJuLeAYkc2CXJw5e7c5sGCrHlMgvkLH1yL9k
	 mYuiQCMnTE26TYw92SmG1Y8WqQBXKULtOCnePiTmMg8iTiMu01xZNgphzA9qm9Uezs
	 H8WgPojNkCs2IfS7pBSN2u551bjxBXMj83K2uQBw=
Subject: FAILED: patch "[PATCH] power: supply: ab8500_fg: fix use-after-free on remove" failed to apply to 6.1-stable tree
To: fanwu01@zju.edu.cn,linusw@kernel.org,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:40:22 +0200
Message-ID: <2026090322-cradling-finance-beb1@gregkh>
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
git cherry-pick -x 75b1e88d34254f4fb7753345e21bfee47abddd7f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090322-cradling-finance-beb1@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

