Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050617;
	b=UTs/I0Zcd3wK0pWAz2ktgxUehkxlgLJLKYTIQ8Lc9GKCsdDMkjcHPkl5hjTqUaNP0K+a
	 Z+q4ZgMBNU95YAeajr4FhquAMseCHn3xoK2N0TCp/upbBFVbgDrwNBymX5X5nkHaMZ7Nn
	 uR1d0FUXRrCTbsG3vrSVLMLLDqswOpW34z+IFRAyNEIkGXn9ThIjImdAxWPtK6NXUGhdA
	 wVJ/OWHbPnstROalPW+A9/46BQGjj8J1CJrAV6r20U30mrxVn8mI137JGCTypNAf5xTrg
	 4m9Ze3/Ue9ZsZEdzVJwq/RO8N1Dkt64MUgd+NN4+C8Wf67REHUBc+pz6XE5Bl0bPWfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050617;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0IaXLy95grDqoDc9b0cI2AE6iBxDG11cLrgEKoEakAk=;
	b=CeqM4I3bDZpXSS8iP+kZsOECGsferMA9c7WTkVZupuQxyK3L//Uv06Bcxl1OjNDZd0LM
	 uzU5wM1A4Tc9MrtSm2dEnOc3iedG+JA5vuXt1nlsbwlRbdmX6Ewod+PlhSIP05T/X4Uop
	 0Rb4NJZZ4CtW1fkLMDe5MLt1QEoL10FqLM+lb6KK057FvVFIPZWa4ho0QubgqIhUM2ABu
	 cL3jrmaFLi5IU/carVj3+SOQoXEN5y/DlZUH7Igcx/kdT8S25RNRaIdZTaSxeKE30+gfT
	 W7K8FcaiMRibPO072R21J4aNf5Mt7c2cJdMpSZvnAK2LKgxQ+Un+cBog2vu2XWhu3xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYw9rtkW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6AF606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYw9rtkW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54341F0089F;
	Sat,  7 Nov 2026 11:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050617;
	bh=0IaXLy95grDqoDc9b0cI2AE6iBxDG11cLrgEKoEakAk=;
	h=From:To:Cc:Subject:Date;
	b=JYw9rtkWKWtL2ba+vfn/zBIQ7DGY/q42ShadsRI4WDbBPLOAwKB9Mm1peq7Bgc56W
	 UbTpqnCT/KMajkz5JqJ0iEbPPqVyCdbXcEFkcU4RUFZ/qql7RDCl9h0MKAULuIeTEB
	 9JofHBhJM08Mb1OcLgzZMVrU7W6O8TctfDgSb3wA9NXecQOL4yWe7Oy4MapBWAbXpL
	 +5W0qP3jtisua9DBOOD6y16UVvWfJpN6QfpCiBXWv7GSIuVlYetR3t0iA317MZjDUi
	 SopGDemnWLMfc5fKYMp0dS5dasL7WAlxtrSx/Vdd9GHojDrqtG1yXGIkBMpa7fmiZu
	 45/ZA5olS2+WA==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	tglx@kernel.org,
	frank.li@nxp.com,
	radu@rendec.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] irqchip/imx-intmux: Fix runtime PM teardown on remove" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:23:35 -0500
Message-ID: <20261107062335-failed-5.10-b167c1a30e9e@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b167c1a30e9e020e4c5e102c7a555943742c024b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062335-failed-5.10-b167c1a30e9e@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b167c1a30e9e020e4c5e102c7a555943742c024b Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 14 Sep 2026 21:42:11 +0800
Subject: [PATCH] irqchip/imx-intmux: Fix runtime PM teardown on remove

imx_intmux_probe() enables the IPG clock and then drops its runtime PM
reference with pm_runtime_put(). With CONFIG_PM enabled, the runtime
suspend callback disables the IPG clock. With CONFIG_PM disabled, the
clock remains enabled after probe.

imx_intmux_remove() accesses the CHANIER registers without first making
sure that the device is runtime active. The device may therefore be
runtime suspended with the IPG clock disabled when these registers are
accessed. In addition, the remove path only calls pm_runtime_disable()
and does not balance the clock enable when CONFIG_PM is disabled.

Resume the device and acquire a runtime PM reference before accessing
the registers. If resume fails, skip the register accesses but still
tear down the chained handlers and IRQ domains. Disable runtime PM
afterwards, drop the acquired reference without triggering another
runtime suspend, and explicitly disable the IPG clock.

This keeps the clock enabled while the hardware registers are accessed
and balances the clk_prepare_enable() performed during probe for both
CONFIG_PM configurations.

This issue was found by manual code inspection.

Fixes: bb403111e017 ("irqchip/imx-intmux: Implement intmux runtime power management")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Radu Rendec <radu@rendec.net>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260914134211.1734163-1-lgs201920130244@gmail.com
---
 drivers/irqchip/irq-imx-intmux.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index 47c2681d138a0..de2a8f98f6255 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -288,12 +288,16 @@ static int imx_intmux_probe(struct platform_device *pdev)
 static void imx_intmux_remove(struct platform_device *pdev)
 {
 	struct intmux_data *data = platform_get_drvdata(pdev);
-	int i;
+	int i, ret;
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0)
+		dev_warn(&pdev->dev, "failed to resume device: %d\n", ret);
 
 	for (i = 0; i < data->channum; i++) {
 		/* disable all interrupt sources of this channel */
-		writel_relaxed(0, data->regs + CHANIER(i));
-
+		if (ret >= 0)
+			writel_relaxed(0, data->regs + CHANIER(i));
 		irq_set_chained_handler_and_data(data->irqchip_data[i].irq,
 						 NULL, NULL);
 
@@ -301,6 +305,11 @@ static void imx_intmux_remove(struct platform_device *pdev)
 	}
 
 	pm_runtime_disable(&pdev->dev);
+	if (ret >= 0) {
+		pm_runtime_put_noidle(&pdev->dev);
+		clk_disable_unprepare(data->ipg_clk);
+		pm_runtime_set_suspended(&pdev->dev);
+	}
 }
 
 #ifdef CONFIG_PM
-- 
2.53.0




