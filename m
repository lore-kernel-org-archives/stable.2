Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1439F54855B
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954044; cv=none; b=qYlorsvRoMkiD9GP7iiqdzEALWhHfileiwQPnelcmW/jvRtAhcvztvCPMKym2VxRic+Y75KNYFCifHyypf4fkxu5LPCtADY6cwEIF/MyQ6H9xMprsJJg+NDwZPjjkd7Ce9kj9WLiupb5t0aZtoKKLmEGO8ygj3l9KilXBnP4Ww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954044; c=relaxed/simple;
	bh=HN/gKsCtJXXHeiGKo6Gkk/ShvjHhh4t32ELSWeDF0YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7utfm2FS4XwHOAwk4SY3Xr5JVRrdIlvk+9ltNayzZYGQuvIXfmy135C8uAgbkQHoBHigJVP7SNkz7QxQ7IrW2dCxiHS90NK1OwIuBvvhZl/vS4x9vOE5IpSPnta11NHOLOTQ9KmM1XNqctiamWRuNFkeM1bFf8KbYkZbovQ9xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMwaR9nl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMwaR9nl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CCC1F00A3A;
	Wed,  9 Sep 2026 11:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954042;
	bh=sBWPGvw56ZPfZP8Sr6BjDCbNJq0NsRHYK8oW+Eu9Gi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QMwaR9nlSWoMCmI7q5kv7doOb2NtjvgG0wmFTUyqBJIRreKMZdw3MMQHz7ldjZ1zb
	 1gWgINc61d2dhkx4c4RgeCYnAHuhfB7dSdaN7vjBCm5E6HZ9wmygbT7h7MQnzrnCnq
	 hghlXlsYyCC9xdOHMgVS/MCC9v3Jduh8N9cDiz//1y4x89IQpHekJD6kjeb5TdKUvW
	 DJeGbpjd/wBTcOgOcQmCNsq6RZDzn4fjy/UyrR/4TMnqFPBTx00sjHS/sVtWsJ4QJh
	 id32kY5eMGtAJP5BfJneB7+sUrmI3vfDkcjAUtWGdIIa9sLooDm2Q5m8QD1pVVhbQ7
	 TpB9HRYR4Vclg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Linus Walleij <linusw@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] power: supply: ab8500_fg: fix use-after-free on remove
Date: Wed,  9 Sep 2026 07:40:40 -0400
Message-ID: <20260909114040.1915800-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909114040.1915800-1-sashal@kernel.org>
References: <2026090321-spotlight-grape-ad40@gregkh>
 <20260909114040.1915800-1-sashal@kernel.org>
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
index c2fbba1b7085a..89b6e599087a3 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3055,6 +3055,20 @@ static void ab8500_fg_unbind(struct device *dev, struct device *master,
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
@@ -3156,6 +3170,11 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 		return PTR_ERR(di->fg_psy);
 	}
 
+	/* Registered after fg_psy, before the IRQs: devm frees IRQ -> workqueue -> fg_psy. */
+	ret = devm_add_action_or_reset(dev, ab8500_fg_destroy_workqueue, di);
+	if (ret)
+		return ret;
+
 	di->fg_samples = SEC_TO_SAMPLE(di->bm->fg_params->init_timer);
 
 	/*
@@ -3168,20 +3187,16 @@ static int ab8500_fg_probe(struct platform_device *pdev)
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
@@ -3195,7 +3210,6 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	ret = ab8500_fg_sysfs_init(di);
 	if (ret) {
 		dev_err(dev, "failed to create sysfs entry\n");
-		destroy_workqueue(di->fg_wq);
 		return ret;
 	}
 
@@ -3203,7 +3217,6 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dev, "failed to create FG psy\n");
 		ab8500_fg_sysfs_exit(di);
-		destroy_workqueue(di->fg_wq);
 		return ret;
 	}
 
@@ -3223,7 +3236,6 @@ static void ab8500_fg_remove(struct platform_device *pdev)
 {
 	struct ab8500_fg *di = platform_get_drvdata(pdev);
 
-	destroy_workqueue(di->fg_wq);
 	component_del(&pdev->dev, &ab8500_fg_component_ops);
 	list_del(&di->node);
 	ab8500_fg_sysfs_exit(di);
-- 
2.53.0

