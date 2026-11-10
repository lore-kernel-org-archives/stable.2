Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337034;
	b=fLSV0xWOb5ooAjMLWUXXgDiehFNCkadnsKDaciCanstngLsnmDBK5VPXSuv9RFzodZBq
	 Zlw9O7ttmNhNnRhr9Uo73JNa1niSRNSQDzQ8+dQiIdbDsEmVJXF/hxN3RiF46pP8TA/M6
	 tbXjTE3l935KI+lgMcl3+topJEnTAWUil5P56p7xRAlvU8k64fkjqzaypaxdxW6zbdbfw
	 Ak6ut2G/9kKb8Ya5G4Ybp91tNgH5Z9VvwCLAb6djNbdaled2Ts37ZygMSYJBvTt4NYHLt
	 61YFhOIhnIPe+4QyiZTa2SS5ByUOxYyYXnRwG0eGfsZ5lyS3Bw/6vUetvdKlT2XjxJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337034;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V1s/TxAfgFiIz9viw5XfOW+zs1vHHUtj/2iWBRbGIlE=;
	b=3jFkApvtEBCeepOHqGFksBwvUJKHl3ttXoYRaodRedv3Beq1e4lO7v74H45lcySkjYGV
	 eF2Olu0hrLapww+yD1Z8JziqBDLpGK7wDdMA3lUNnrBDLZVVRphEiXk2+uIRhUd0eaSNt
	 ijQgb/DZacdk198sGuVxcSXSsm5nJEZtq2C1JFws5baFy03EAyeC5W/4/No42MjyV2yj1
	 6oiHnHjKPkZUBTtGp3jhWnrvaOsNOsYUUFVi7akGMqlR3Zk/0zeVMSZkqGK9sDAV01h2b
	 gKM2pL6E7FkPJ1aUVIG04nhu9NZyO0xkKeYjzAwUTzMXjDG0V46fbbYAbg3L+XMavwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwAIVVne;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B759606A32D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwAIVVne
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2CD1F008A4;
	Tue, 10 Nov 2026 18:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337034;
	bh=V1s/TxAfgFiIz9viw5XfOW+zs1vHHUtj/2iWBRbGIlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bwAIVVneus5M93fdETxCYIYmruetI8fFabhMtpQGVDddghlZFOBiDvR82NA1rpNqz
	 nDFWiN3HBPFQRn+dJMfBu0XXqqfcitZHvl3MqPvH8UxuZCgfqjsCHIuwV209SobKL2
	 HP+hXDnHmS1vkDlIYYfLvpwnY3lFGMditDilSYpVb6Vduv2yPYh+IFaA56FNwSzeUW
	 tmCFjm2kfYwbeetJ0gh3E0Fdclf71vCP+oqxMQfAt61eKiagHoc77Ym+FVMnQ9oftR
	 MsuQ/GsleTW326fM1WNB9NgwFxaa5CIdaPa9sWexoktqQ+vTLV07o2a6aNwXj/7s0v
	 OJJJ50N6gaIZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Radu Rendec <radu@rendec.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] irqchip/imx-intmux: Fix runtime PM teardown on remove
Date: Tue, 10 Nov 2026 13:57:11 -0500
Message-ID: <20261110185655.3415962-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110185655.3415962-1-sashal@kernel.org>
References: <20261107060640-failed-5.15-b167c1a30e9e@kernel.org>
 <20261110185655.3415962-1-sashal@kernel.org>
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
index 45d2ac494a82d..10390446b4f01 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -286,12 +286,16 @@ static int imx_intmux_probe(struct platform_device *pdev)
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
 
@@ -299,6 +303,11 @@ static void imx_intmux_remove(struct platform_device *pdev)
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

