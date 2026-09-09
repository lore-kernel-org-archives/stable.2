Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E473741A551
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953297; cv=none; b=jxumGwBORLVZ8vFZX8ooRF0U3Tn2dWjBVdbjjaGiBg4d5ziN9h16JkWya+yVi0Ar0Mtnj0uc80tZkTsl75BgJYGkQD5oYSSuTS4quu5Zx4JmtKOgvmSFr+MgDkaPAO6Ix4NLHyfWjHVSmJqaQBVLR/t9FOkOlDTFOwju4pr1XUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953297; c=relaxed/simple;
	bh=dLCC+vCOB4e7CKShrm5X32rOJF13Ut5fumo98D+j+ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVXKJdTlneGoWbby7bFzqr94epUBH8XMFJveTT8+StHcVYVoAkgyC4Q2VcAJw9EJ+Npnaibe7V6TulMezLiwE3fuuR4Tu59w6G5afWqHt6b2WexsyypDd46fkuBUfK8Y22M9JikKaONmn/ftx49RTd7q7dCkhiASqDUFcXPu7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYYgvSsj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYYgvSsj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8261F00A3A;
	Wed,  9 Sep 2026 11:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953295;
	bh=rX/u6CTmnr4pH4PFpUyuxyp44Z25j1HVAfTuqEEEC18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PYYgvSsjCxPKWlYt+SmzixNaQZGpDrUlLlRI8lenKhmOkTmV4groCQq8zoIkOEcar
	 gFRh836u57lqW+6LHcBe5ivlb/CVtTdtFUkEAfC+fWI8cxv2mac/prXpDZbSBI9egi
	 gSnc+vI3TjExGgRAa1htStmjE2yNHBs8TRDigJaW7v6VKceFQBBdkYrIsRYFNBmwcV
	 qiD8+ce2HxabBkA9Rvj4xpwIUCxSS2iI3UkUMt2nFMAgTZaFZAnA/uCIMWvimfEOo5
	 vgnduRxAIwWwFE4Q/rx9YEOSo3HmrysfoP8b0wJ7MrVm6xmLJSJ2J5pLzQ3/yxzPzy
	 dQoHr/6lyVB2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Linus Walleij <linusw@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] power: supply: ab8500_fg: fix use-after-free on remove
Date: Wed,  9 Sep 2026 07:28:12 -0400
Message-ID: <20260909112812.1847077-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909112812.1847077-1-sashal@kernel.org>
References: <2026090320-patchwork-tadpole-ea90@gregkh>
 <20260909112812.1847077-1-sashal@kernel.org>
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
index f8f392592193e..cfcc05dfe28d6 100644
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
-- 
2.53.0

