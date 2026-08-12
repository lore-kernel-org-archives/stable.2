Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB7540963A
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529631; cv=none; b=ZHhkI6ECbWEJPJeT9ghMcnXkMtwoKemSSk2T6/J1xRELZWxTugfXu0jhx15JYZQeu+YJ/yHk+GnnhGwUImMl6/U17MnRV9xkm5Z6krD5SSk5anLCYTZuonI1cYlA0FbMgs0aevbOxyX7t9DGkJU5fN8/95Aj/Zu0w3hUqLZgNPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529631; c=relaxed/simple;
	bh=bAn1dtk68Uql0hjN3ZcE53ObucW8LmACD9OXxwGxCA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JADyh873mZEao90O44vba+3hfxQEc5RGrQLGlzFxSrAtMgsTBQVBfqRg5o0PvkLk++pe7hBBFR/aZ3WtK60tkF4xqL+nWRFOJeJhwtexFG26RYeDGd2gSMnoL+QROnMNFWIR92A1ZqqQp50RX5Nnfl/itFS9vaGO/l7X3Adxfnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6jnjyc6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6jnjyc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DCE1F000E9;
	Wed, 12 Aug 2026 10:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786529629;
	bh=+tFtadE9MVdRxnjvXdjq3cXW8p5FjewdO3PnK3bVeD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M6jnjyc6uAIYIQ59U2CE7LZPCMeJEPsQupDQcS3cbdTiiNdrl4LqdtZ4mWZaiJxeh
	 WL31YdVEjlP6Yxl2X3RlG/EzrZp3cfOpxJorAUC8K8SYv8T6c6BBNI4yyTfK6RHwmU
	 z41vE/Fv5Xx87ApVBoiYPPb0JwWsJBWKQBOHdoJJ+dPo6yu2ms00Fo1Bj8ON1FN4hZ
	 F4YmHNf0+y/efKZjJPbY4gZDqPlLURL9BCcOdgltuS6sBUS0ArdXjaAkR9VocAZxFI
	 +oOF7jlbO5fdKMeDBAmd0c9uXPaY51GPzANgguOr/u2QwJyxMG3S1mibpWIJqxH2BL
	 d5TOyz+axFtIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Carlos Song <carlos.song@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] i2c: imx: make controller available until system suspend_noirq() and from resume_noirq()
Date: Wed, 12 Aug 2026 06:13:45 -0400
Message-ID: <20260812101347.1638816-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080542-curse-dispersed-597e@gregkh>
References: <2026080542-curse-dispersed-597e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Song <carlos.song@nxp.com>

[ Upstream commit 358025ac091e5a54f9819b33ee9c7cb07c55ee5d ]

Put runtime PM to resume state between suspend() and suspend_noirq(),
resume_noirq() and resume(), because some I2C devices need the controller
on to perform communication during this period.

The controller can't be woken up once runtime pm is disabled and in
runtime autosuspended state.

The problem can be easily reproduced on the I.MX8MQ platform:
the PMIC needs to be used to enable regulator when the system resumes.
When the PMIC uses the I2C controller, I2C runtime pm has not been enabled,
so in i2c xfer(), pm_runtime_resume_and_get() will return an error,
which causes data transfer to fail. Therefore, regulators cannot
be enabled and system resume hangs.

Here is resume error log:
[   53.888902] galcore 38000000.gpu3d: PM: calling genpd_resume_noirq @ 529, parent: platform
[   53.897203] i2c_imx_xfer, pm_runtime_resume_and_get is -13
[   53.902713] imx-pgc imx-pgc-domain.5: failed to enable regulator: -EACCES
[   53.909518] galcore 38000000.gpu3d: PM: genpd_resume_noirq returned 0 after 12331 usecs
[   53.917545] mxc_hantro 38300000.vpu: PM: calling genpd_resume_noirq @ 529, parent: soc@0
[   53.925659] i2c_imx_xfer, pm_runtime_resume_and_get is -13
[   53.931157] imx-pgc imx-pgc-domain.6: failed to enable regulator: -EACCES

I.MX8MQ system resume normally after applying the fix. Here is resume log:
[   71.068807] galcore 38000000.gpu3d: PM: calling genpd_resume_noirq @ 530, parent: platform
[   71.077103] i2c_imx_xfer, pm_runtime_resume_and_get is 0
[   71.083578] galcore 38000000.gpu3d: PM: genpd_resume_noirq returned 0 after 6490 usecs
[   71.091526] mxc_hantro 38300000.vpu: PM: calling genpd_resume_noirq @ 530, parent: soc@0
[   71.099638] i2c_imx_xfer, pm_runtime_resume_and_get is 0
[   71.106091] mxc_hantro 38300000.vpu: PM: genpd_resume_noirq returned 0 after 6458 usecs

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20241125142108.1613016-1-carlos.song@nxp.com
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Stable-dep-of: b08c9857aa1f ("i2c: qcom-cci: drop custom suspend/resume and rely on runtime PM helpers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-imx.c | 39 +++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 2f98ac4ad2142..15ae3056acb5c 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1512,7 +1512,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
 		goto rpm_disable;
 
 	/* Request IRQ */
-	ret = request_irq(irq, i2c_imx_isr, IRQF_SHARED, pdev->name, i2c_imx);
+	ret = request_irq(irq, i2c_imx_isr, IRQF_SHARED | IRQF_NO_SUSPEND,
+			  pdev->name, i2c_imx);
 	if (ret) {
 		dev_err(&pdev->dev, "can't claim irq %d\n", irq);
 		goto rpm_disable;
@@ -1620,7 +1621,43 @@ static int i2c_imx_runtime_resume(struct device *dev)
 	return ret;
 }
 
+static int i2c_imx_suspend(struct device *dev)
+{
+	/*
+	 * Some I2C devices may need the I2C controller to remain active
+	 * during resume_noirq() or suspend_noirq(). If the controller is
+	 * autosuspended, there is no way to wake it up once runtime PM is
+	 * disabled (in suspend_late()).
+	 *
+	 * During system resume, the I2C controller will be available only
+	 * after runtime PM is re-enabled (in resume_early()). However, this
+	 * may be too late for some devices.
+	 *
+	 * Wake up the controller in the suspend() callback while runtime PM
+	 * is still enabled. The I2C controller will remain available until
+	 * the suspend_noirq() callback (pm_runtime_force_suspend()) is
+	 * called. During resume, the I2C controller can be restored by the
+	 * resume_noirq() callback (pm_runtime_force_resume()).
+	 *
+	 * Finally, the resume() callback re-enables autosuspend, ensuring
+	 * the I2C controller remains available until the system enters
+	 * suspend_noirq() and from resume_noirq().
+	 */
+	return pm_runtime_resume_and_get(dev);
+}
+
+static int i2c_imx_resume(struct device *dev)
+{
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
 static const struct dev_pm_ops i2c_imx_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				  pm_runtime_force_resume)
+	SYSTEM_SLEEP_PM_OPS(i2c_imx_suspend, i2c_imx_resume)
 	RUNTIME_PM_OPS(i2c_imx_runtime_suspend, i2c_imx_runtime_resume, NULL)
 };
 
-- 
2.53.0

