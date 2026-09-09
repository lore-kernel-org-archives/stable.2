Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12317492E45
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954339; cv=none; b=FMpnVmXg3asPQwc+dFNe9jbdv02QcfI4FVO4jcXjEH/uwlm022+sf8YI7CjL6DSYuZZHjRUMVzuhb/pWea9KdDFJHf2iTfo4NntP3dDjZjM9GxQ4DetSLSnzZPEz7iWaasnKD6oQlAx5is1iIbtTzEzvVoHQO/9nQ5Gx37hTWSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954339; c=relaxed/simple;
	bh=i+fXSOa6lFKSNhPLQ4Iw2QRw1K/FMrybGVgdVtrKYHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abay6/dlNhAGj6Z3YHh1B+tKCd4AeTBBm+kXANgZ2nTizGaXGuEErhsi6WTxYtVQ/1tzE/IyY7JPa0wpaH0jllq46AQ1831w2Z7rS1Avnl+xK+o39rS6i/5L0ofjLqg6b4ogDURiy3gIaIEiIYIVSGEoI0DNhDvjZM4FI5bNwnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JY5Cg/BT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JY5Cg/BT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2571F00A3D;
	Wed,  9 Sep 2026 11:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954336;
	bh=RWTiM9IB4OePqAMtT9QFQseg+8Y1PcqvC8jyATRkWgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JY5Cg/BTToUho5COLleppuuQaqmELr5jlIbKYPRI8uiQRo2aymInmEDuqfhQ8+YFd
	 K/WNDb6zth+YbDo1BJGzykre4iTd3fV7YLy0ZMNInFtQlzXnjfvzXJBPRdCFgjZ48P
	 OYc8kKRd1bftVb3IQ4mxLqxmkzfhPyK6rhKXlmoNtaPKT4zYTvjeXK40Hr/VINxcm5
	 Urk2AlHSwQVn5YkVvOmHifxT0YPMJAiWvCldIgA7bAeS2hOi1RzD5YguF62MZOkoN7
	 YpGeezCrz52BN36zFs44Mpz3+ClG0ZWtSmrKrRDaGSFX/aaKVFh/9nfqNDDEI1dbVr
	 eSz6a3gBjd7Bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Linus Walleij <linusw@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] power: supply: ab8500_fg: fix use-after-free on remove
Date: Wed,  9 Sep 2026 07:45:33 -0400
Message-ID: <20260909114533.1984024-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909114533.1984024-1-sashal@kernel.org>
References: <2026090321-morbidity-steadily-bc7c@gregkh>
 <20260909114533.1984024-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit 75b1e88d34254f4fb7753345e21bfee47abddd7f ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/ab8500_fg.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 0bbdd532775c2..2d1615cef8b79 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3061,6 +3061,20 @@ static void ab8500_fg_unbind(struct device *dev, struct device *master,
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
@@ -3162,6 +3176,11 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 		return PTR_ERR(di->fg_psy);
 	}
 
+	/* Registered after fg_psy, before the IRQs: devm frees IRQ -> workqueue -> fg_psy. */
+	ret = devm_add_action_or_reset(dev, ab8500_fg_destroy_workqueue, di);
+	if (ret)
+		return ret;
+
 	di->fg_samples = SEC_TO_SAMPLE(di->bm->fg_params->init_timer);
 
 	/*
@@ -3174,20 +3193,16 @@ static int ab8500_fg_probe(struct platform_device *pdev)
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
@@ -3201,7 +3216,6 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	ret = ab8500_fg_sysfs_init(di);
 	if (ret) {
 		dev_err(dev, "failed to create sysfs entry\n");
-		destroy_workqueue(di->fg_wq);
 		return ret;
 	}
 
@@ -3209,7 +3223,6 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dev, "failed to create FG psy\n");
 		ab8500_fg_sysfs_exit(di);
-		destroy_workqueue(di->fg_wq);
 		return ret;
 	}
 
@@ -3229,7 +3242,6 @@ static int ab8500_fg_remove(struct platform_device *pdev)
 {
 	struct ab8500_fg *di = platform_get_drvdata(pdev);
 
-	destroy_workqueue(di->fg_wq);
 	component_del(&pdev->dev, &ab8500_fg_component_ops);
 	list_del(&di->node);
 	ab8500_fg_sysfs_exit(di);
-- 
2.53.0

