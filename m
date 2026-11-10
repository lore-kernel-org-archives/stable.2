Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335266;
	b=5MmN6oXnPU8KyyRoYQ56uSaM8VsYhK6aaimwiamtcgk8Z5ebfQKBsTAacOVo1TLAsaUw
	 YLx8NfuMn7TgsPrlfOPKdqM4XTQM0rj7hA7W+yADMSlfmBzXyhP9kxaKG1rj5Sfr7KpB9
	 XzcBm/N9QUb6vWDtdD0lfov8AW4QG0sU84DFA5MYDaMRiSF+RkHSQVII++KF+zjDsvvPh
	 rwNpm9EuCCAczZm06lQDZ3qTlLVdXV2HEkU7TgxZPrt/mfuJjPpcwQcZFqO12wDexHmX8
	 1qmFZ+IdYYf1UvOSzmGSO733mNUXk91CfLPtZH9x9mQxUx8VU7jFkHEPTkxX1T/oQHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335266;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0J7253WM5L05tV6qEi3UmHpC+ZdgmJBCOhdA6Lfemq0=;
	b=uOkrkgKyjeqqPLbCqgub7JryeLG+mRAHU4Zo98Z7ALvJZ67qobuv/v9o6UuU60414F5w
	 q/pf1u8wWLDH7ZWuRCIwEOPMXU7lAq9dTHPNMdVHngUXViw1XZYYoryAS6P0Xlj/DzJbz
	 3kvb0j5BzODlY77XhJZtMa2szWNpnNYB+d0j7nUwIPTVJkIjeepQkk39Fl5O9ZxVwJWCG
	 oiqgGRMsBYVdRaewn1mFHh2L/+wk0468hRQ5I/AX36Ftb+iYGnLcviq5TQR5jLYDgcb12
	 CUvzLpVwPtUaA3g1wGetTcNKxziEMBf2u01qb3l3aYUHshpvmAUBj7DafznRLM2Auug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wp25t3K0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C618606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wp25t3K0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484B31F0089F;
	Tue, 10 Nov 2026 18:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794335266;
	bh=0J7253WM5L05tV6qEi3UmHpC+ZdgmJBCOhdA6Lfemq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wp25t3K0/UWMTUaP0ahOXXCxsSQtjfvRijGf33kDf6wvYv3r4npVbrJOyhKvJslQe
	 lb0mIWn/wXNVPuahDBkssYhCPhYsDKEddKfWQVW0Y/ij5yWwxthmlKkqtry0QGUz6Q
	 g4TMkDQthqRFXgjMM1/mzBgjWg7VHrIwLNhf3PGkOpP9XfpIep5mJDhEdk4OJkpm+F
	 JYPWG4IThtmqrO6H/eoqHjMHBprV6OedNkLv+zRuTI4oBsyY7jaUY/EU8DPFdiCv0G
	 lTptJEE0MPzJHQsZhSIHDHpl+DMEaQ4QKvbzHSPPrI73K8Oze63DXZyJIsO8c/OC/0
	 Cb/oSXYE86fXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Radu Rendec <radu@rendec.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] irqchip/imx-intmux: Fix runtime PM teardown on remove
Date: Tue, 10 Nov 2026 13:27:43 -0500
Message-ID: <20261110182731.3159957-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110182731.3159957-1-sashal@kernel.org>
References: <20261107053525-failed-6.6-b167c1a30e9e@kernel.org>
 <20261110182731.3159957-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit b167c1a30e9e020e4c5e102c7a555943742c024b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-imx-intmux.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index cdd6c47e589d3..4a9c5b0fccc86 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -285,12 +285,16 @@ static int imx_intmux_probe(struct platform_device *pdev)
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
 
@@ -298,6 +302,11 @@ static void imx_intmux_remove(struct platform_device *pdev)
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

