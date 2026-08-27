Received: from sg-2-3.ptr.blmpb.com (sg-2-3.ptr.blmpb.com [71.18.227.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA5847F78C
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845404; cv=none; b=H1GPCd0IJnxTkwByjiklxSfIRRR9cFck8ZgLWmccodiroOysWs92zivZ7qKmr5WCkTZ45aqDjsI6XYWHQZKRo49zOnBuzb0bJ/kbn+guODquTsoIFc1RzuTrNqy91r1t8ut9U6NS0Ljk6uqBNxVLPV+l5hoIkqnSe06luVWfQyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845404; c=relaxed/simple;
	bh=+M+E2k6W7sbxIgI8b2cThwx7W/ppMQUI5X1TQ9uxJo8=;
	h=To:Mime-Version:References:Cc:Subject:Content-Type:From:Date:
	 Message-Id:In-Reply-To; b=ErbPtq2ZgYE37HC0EVub4R0UnsFy8ddoLZMllCx5PZ0SsBiRgDVbFkZshUoCvuDbSc2A04dFYi9U2jkocEtw0GCXwKhMU4KM3uHDXC8rPc3IX0s3RKqMZhfAcs8mgYal1cI32AjHDN3IgztgNdt/pPhgrfASSB+IalH52kduv6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=spdOKRzX; arc=none smtp.client-ip=71.18.227.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="spdOKRzX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787845396; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=t4JSPZHi9ydke9/rPPt+tNOeEYeI6jSjT/5oE9D+9xI=;
 b=spdOKRzXbQHQxQh/Y7D8+9kzXcXo4tN2qoGCYbRuYSuSucv0YbkeTMhCrv1WZ2Xc72QQBS
 9wAJ1a27Z8tnGiTf6z0Y+e7VWUJi5A3cVlTLmiKwccNnXAyKquy9LJgrZGH5byOM/HI85A
 c2FqHzjobhy4Oi3LTeg495EO3xNvDLC9IzgY52AdmHCTNYQDDWmtNAzzRUkAAUepHndx1m
 elT5+TX4BdZn85gbOxT6vc5aG/HEcP0FB0S0kwnA7ymBxxKr7eRmUYZYQKF1AuMCRrWAGL
 c4gT7U7CTWB1jHWeJclCcEegGXGqLPGFx5VfxIEb8PXDDijlMLRLMzt/jWzgbg==
Received: from [192.168.9.107] ([111.42.148.163]) by smtp.feishu.cn with ESMTPS; Thu, 27 Aug 2026 23:43:13 +0800
X-Mailer: b4 0.16.0
To: "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>, 
	"Andi Shyti" <andi.shyti@kernel.org>, 
	"Nicolas Ferre" <nicolas.ferre@microchip.com>, 
	"Alexandre Belloni" <alexandre.belloni@bootlin.com>, 
	"Claudiu Beznea" <claudiu.beznea@tuxon.dev>, 
	"Wolfram Sang" <wsa@kernel.org>, 
	"Ludovic Desroches" <ludovic.desroches@atmel.com>, 
	"Oleksij Rempel" <o.rempel@pengutronix.de>, 
	"Pengutronix Kernel Team" <kernel@pengutronix.de>, 
	"Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, 
	"Fabio Estevam" <festevam@gmail.com>, 
	"Yao Yuan" <yao.yuan@freescale.com>, 
	"Mukesh Kumar Savaliya" <mukesh.savaliya@oss.qualcomm.com>, 
	"Viken Dadhaniya" <viken.dadhaniya@oss.qualcomm.com>, 
	"Bjorn Andersson" <andersson@kernel.org>, 
	"Vinod Koul" <vkoul@kernel.org>, 
	"Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, 
	"Praveen Talari" <praveen.talari@oss.qualcomm.com>
X-Lms-Return-Path: <lba+26a905b12+5a88a6+vger.kernel.org+me@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260827-i2c-dma-channel-leak-v1-0-271d4adc03a0@cherr.cc>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Cc: <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>, 
	<linux-arm-msm@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH 2/3] i2c: imx: release DMA channels on probe error
Content-Type: text/plain; charset=UTF-8
From: "Shengzhuo Wei" <me@cherr.cc>
Date: Thu, 27 Aug 2026 23:43:02 +0800
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-i2c-dma-channel-leak-v1-2-271d4adc03a0@cherr.cc>
In-Reply-To: <20260827-i2c-dma-channel-leak-v1-0-271d4adc03a0@cherr.cc>

i2c_imx_dma_request() acquires exclusive tx/rx DMA channels and is
optional: on errors other than -EPROBE_DEFER the driver falls back to
PIO mode and probe continues. If i2c_add_numbered_adapter() then fails,
probe returns through clk_notifier_unregister without releasing the
channels, because the remove callback is not invoked after a failed
probe.

Release the channels on the probe error path, mirroring
i2c_imx_remove().

Fixes: ce1a78840ff7 ("i2c: imx: add DMA support for freescale i2c driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
Assisted-by: GLM:5.3
---
 drivers/i2c/busses/i2c-imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 19ec056b00af..c24d9201a60e 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1880,6 +1880,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
 
 clk_notifier_unregister:
 	clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
+	if (i2c_imx->dma)
+		i2c_imx_dma_free(i2c_imx);
 	free_irq(irq, i2c_imx);
 rpm_disable:
 	pm_runtime_put_noidle(&pdev->dev);

-- 
2.47.3
