Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146D850EBF3;
	Thu, 15 Oct 2026 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058103; cv=none; b=VqjFOQeQlsf54a3xU8ml6BH0QQ3xEQ6dpod1QsYfyutoGPMDfnDbzrvretEGLKOiwiEODN1AfVjnm0R1F3ryXoRHR2FIaNOF2mrTNd1ztWSd5l3L+qYWJy7ckoVWIQjCGL9Hy7lMVGX2bN5cFuEFpvAm3ZjYoETlUgnq5XM2Fp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058103; c=relaxed/simple;
	bh=uYdKqHV4wcjsvVAhZQtRGXc75iSc+s+2MjbqYQLHdx0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=By4drNZYIn8eZZr0JevKszokcsdaGdkwznLrVcm5q5cynJAZ2+8Df3Y6+ofUuN/4CiTVVPNIhLEU2qpbpA9Ro0dhe9YJr3vyJVuEtR94hBIjCmhgnbD0gsuXxjxebnB6PEKRIalXADoRFjzARIZPglpuqmAm0GALSbvCRwe1gyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TIO3NexH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NAPFVNFr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TIO3NexH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NAPFVNFr"
Date: Thu, 15 Oct 2026 09:54:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792058096;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=swE8SRTP4KFq/RJvyXHM0rWvc8MyDWgjRHjkGyhoMK0=;
	b=TIO3NexHv1gp6pmaPKoza7J4BXxK2+aiG6twQT7SYXvwtdDI3rY7hLr62U/S5SeEAD9Xd0
	UXTuG2PYMHbgRbJ9DwwhzJ9oVuVsh++4BnVLtG0S16+54vDAKKQ744TDZhTb5vFzH/M9qm
	0KM510g9chbqJ8yFEfd/UMr4qyVJDPsPGSyFdTrHQGYitgNXue/p2LrlaDaSCaUhFAUysw
	Ahi5m2OaR+3uwzeBF/vh2BfYHd98h3HsbTOJTIDiYj3qFsvtlE9wwrjRG+PmRehfrn+tyF
	El0guF6jFpRnLhvUa2aFVfMo4cBYLaf4CvgBLRuNEmN7EnRN20KeuT+JoEt3SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792058096;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=swE8SRTP4KFq/RJvyXHM0rWvc8MyDWgjRHjkGyhoMK0=;
	b=NAPFVNFrChWE2EdnBiiFm3Pme05F/vxtrVNzkdimVUckOnLk784ImqausBeVeSRkz7bF2H
	TAQBHPMMUGXol8AQ==
From: "tip-bot2 for Guangshuo Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/imx-intmux: Fix runtime PM teardown on remove
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
 Thomas Gleixner <tglx@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Radu Rendec <radu@rendec.net>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260914134211.1734163-1-lgs201920130244@gmail.com>
References: <20260914134211.1734163-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179205809524.2666988.7983463336702512767.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     b167c1a30e9e020e4c5e102c7a555943742c024b
Gitweb:        https://git.kernel.org/tip/b167c1a30e9e020e4c5e102c7a555943742=
c024b
Author:        Guangshuo Li <lgs201920130244@gmail.com>
AuthorDate:    Mon, 14 Sep 2026 21:42:11 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Thu, 15 Oct 2026 11:50:47 +02:00

irqchip/imx-intmux: Fix runtime PM teardown on remove

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

Fixes: bb403111e017 ("irqchip/imx-intmux: Implement intmux runtime power mana=
gement")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Radu Rendec <radu@rendec.net>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260914134211.1734163-1-lgs201920130244@gmail=
.com
---
 drivers/irqchip/irq-imx-intmux.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmu=
x.c
index 47c2681..de2a8f9 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -288,12 +288,16 @@ out:
 static void imx_intmux_remove(struct platform_device *pdev)
 {
 	struct intmux_data *data =3D platform_get_drvdata(pdev);
-	int i;
+	int i, ret;
+
+	ret =3D pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0)
+		dev_warn(&pdev->dev, "failed to resume device: %d\n", ret);
=20
 	for (i =3D 0; i < data->channum; i++) {
 		/* disable all interrupt sources of this channel */
-		writel_relaxed(0, data->regs + CHANIER(i));
-
+		if (ret >=3D 0)
+			writel_relaxed(0, data->regs + CHANIER(i));
 		irq_set_chained_handler_and_data(data->irqchip_data[i].irq,
 						 NULL, NULL);
=20
@@ -301,6 +305,11 @@ static void imx_intmux_remove(struct platform_device *pd=
ev)
 	}
=20
 	pm_runtime_disable(&pdev->dev);
+	if (ret >=3D 0) {
+		pm_runtime_put_noidle(&pdev->dev);
+		clk_disable_unprepare(data->ipg_clk);
+		pm_runtime_set_suspended(&pdev->dev);
+	}
 }
=20
 #ifdef CONFIG_PM
