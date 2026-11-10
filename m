Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336129;
	b=rpvHUc9VnSoqYoK0BI6UxnTsoef7FYU0TVwLXHBZR7pJjaIKtwaz/TFnS4kyDI+mytMh
	 MUfw/wKXcIcGXEhN3DPX4v3BIVBqL1TDXLNNYoRAL+Nhy5Dl3erE6Dy2532p4YHmZZ6b/
	 zuVNWeFm5V3G3D5JfHljdIImeby5IAUqx9C3oHJMHwxgKq3nju1TxOi1J9wVwIuZwkPFK
	 fRYo6IWA8K6KP8869odB7Q75tyfphzQ9BmA69Soqze7dCs3OAdAQ7DtXul808YdBa/vYq
	 keI2FDb23TZ4DRf01+8iV5Ho/ud6gWuh/D7jGaCg4yg7j60isj6HqG8TGkCxOkdRBqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336129;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=daTlajkgODrhOY+iBMOF42M57kKzY4A//4nTrW18SWM=;
	b=qthj6POrq/R/zqYBZNR+qd0kDv1yuIEFtyWqLAIm2Z4/7SoYSIy8zlE8GF7rjWGBlVss
	 86b5ti4o0dB/uASoqdwb7gl3VoZkle9UMqKuTDDawQ7GANRIY3WoDBMoc5m/Zi2CDloNZ
	 nHkMyED4hSc/mgKr/R1hy7fy5nN/qDn4T0N2r7XjXWqhvdJ7CAPHyC2zOlx+y91aBsAaj
	 ipQhBxml7aaj4u+rsotq+C5GNnku+SkFGJELQTENtU9nXhjPrEys+1K7O/+UBdkJYiaia
	 Cb7u/AIqOuOMV04FBBwt336xU5OMtoBk9pj0lOs//tBuORqyuwQQsKj82RnWvGJFwgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PWzYUZw5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61374606A91C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PWzYUZw5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347D81F008A3;
	Tue, 10 Nov 2026 18:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336129;
	bh=daTlajkgODrhOY+iBMOF42M57kKzY4A//4nTrW18SWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PWzYUZw5XOYwc4/3LqUt7refs99XEKyGUjpJut83pLXponhjcnf4EvsqEjscYil0B
	 lATYz5qUP06+zCZtOazcxc+JvfyIMRGL0LD6jWFNIHXFsiOyKkxj1C9oge5SCW7zlp
	 s3sHxCaXr+JG/fRjoTMkTdZma9JIen1ksCNvDIbW+ExzO7sreVwO9ElMjXd6W+hwAq
	 XJvdMPXsOTM8Rh1TaQWMghktsEu9I6CgnA8tlvmQwxwgPmv+BTh5oaVKac7OsX8bum
	 MCx4sFxPPL4LylUDAV+8nxcmJz29ApxuQYCvB7H2sQbzykqkfq8j7ic5hbSv9FOUly
	 BXyElPhdNSgYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Radu Rendec <radu@rendec.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] irqchip/imx-intmux: Fix runtime PM teardown on remove
Date: Tue, 10 Nov 2026 13:42:05 -0500
Message-ID: <20261110184112.3296356-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110184112.3296356-1-sashal@kernel.org>
References: <20261107054940-failed-6.1-b167c1a30e9e@kernel.org>
 <20261110184112.3296356-1-sashal@kernel.org>
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
index c7bf73dcb7a10..87061eac27e91 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -284,12 +284,16 @@ static int imx_intmux_probe(struct platform_device *pdev)
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
 
@@ -297,6 +301,11 @@ static void imx_intmux_remove(struct platform_device *pdev)
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

