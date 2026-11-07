Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047728;
	b=wTFmZsecGyeS6aKoaW16p0guuBhYfbWdhuxNos0tSEEkjN5UujQp75YPWYUm6yemgI6f
	 NuW//1KRMZqILk7TuG+xQDEhxi2J3ccnbbKEpHCPDqPmVG8+kmXxKme0kZMVh3BAYL2V0
	 CP7k+spQ8wc6sSVSCtGti97a1hRWTTyPmgjoJGvmArOR5BFwNftu2dg8HT7qXaX3cUdO8
	 5YAu+FjcSaHODHphvYbzSC6aQKcL6GnUDk3yVAZEKEuW5JdfsrjHLW5Uek1n/N/Zwtf/9
	 ppkV9sT62xnOa2li6BdKgtz6JdKXUc/1pzSTDHeVQybR3g5+6eU9FhLGCvTuS7k94nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047728;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wa+Qm3fje0CfeNjpbHzc8tY11mX12IbUpIVjpIyDRKI=;
	b=FSRDmd5DuQQQboWYC1Mk1vy4Q4svG9dp2fsSfraLyxr7BsfuqW6A1KogxhLpjgQ165ar
	 YpXbCzmXxgb/w2EittxfVqg4rzTZMmfQVodn1eN7zEckFr/xkUxxaZPSHq6+cxMkmlOEO
	 TaL1stl4nG4UAv9ubIsR6m+I5grbHu4MgJ4Zdkj4NhbxIWhehPPh1jBHqgnVOqPV4XNUB
	 GyWd1Wye+ya08uDm1/OWmbiZsi3zApim9sxHlT3ZvfTGFsixnOxHVGBuexz4Mx2LYLaB5
	 mwmKFfTzknP77LkdNl+rg33Qeu2ekny0kzY9xepT8Qk3LSe6RnOFc8ci3fAmqldGdxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsKLPdYx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B26606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsKLPdYx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0198C1F0089F;
	Sat,  7 Nov 2026 10:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047727;
	bh=wa+Qm3fje0CfeNjpbHzc8tY11mX12IbUpIVjpIyDRKI=;
	h=From:To:Cc:Subject:Date;
	b=lsKLPdYxR1M3uwPfXkT7VtGHgawZQAABVCyscMZgRFWgd6pFipNycoPzaGiPN4kjC
	 qfhZShj0r7zrwMoDB8ij3bKgy9EeaJcegehxY9JEllzklMMFLB8OrJHJukv1B7y9M2
	 VXW2iefra/aoiwdktQPy2KdhcOTqBoUNYdkRLdnsDJFx/UHnrIVHn7FpkArp/wdRCB
	 NarXuG7cCIUrizAqFOhTrFr0yQ1I9+Ll2/RBz8mevHJChnKuaVStiVl4y8aLad2XRj
	 o+30SIsIlC+xj2mtZtjqTOmHJ4N5hlz9OvdHcwbSqenLRsyhV/dsk7MUBEPbwuCUZp
	 rnppPAWsaw9FQ==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	tglx@kernel.org,
	frank.li@nxp.com,
	radu@rendec.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] irqchip/imx-intmux: Fix runtime PM teardown on remove" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:35:25 -0500
Message-ID: <20261107053525-failed-6.6-b167c1a30e9e@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b167c1a30e9e020e4c5e102c7a555943742c024b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053525-failed-6.6-b167c1a30e9e@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




