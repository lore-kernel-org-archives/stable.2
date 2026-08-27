Received: from sg-2-1.ptr.blmpb.com (sg-2-1.ptr.blmpb.com [71.18.227.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E23947DD7B
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845402; cv=none; b=VOQwD3On7le2c4wPlxn+jLx6d/4ougpG8PgKItnLahSVvayrPCnSx3fmaKvJDvt002S/Gi4cZxlLSIG/JGNOF2KHRxuG8oCVVqG3MfjrNEGepRtQtDlILmaLPSOYdV4uRNO4dUAKLvqSbHou+PEowrFO3IlnS0tb6gnZX+QqJq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845402; c=relaxed/simple;
	bh=rSxuM1d4cYZHnuQacRlMsdbipcymSj10Y4cSAWHHFcQ=;
	h=Mime-Version:To:Cc:Subject:Date:In-Reply-To:References:
	 Content-Type:From:Message-Id; b=O+sGDEdqb4frFFXSYxlVHBDja66lrwvAGFBDfww7Ce3xgeacfq7s+j+aLHb+BObBqENoICcr+7nsPKekZSQbGd8ZzqiUSbm69w4stnknK8A2GsrMeMisTtnqJIgFaJD/h05iMaNQvay+KrAH878/psgR1eQN4qJmtNHsUAzRzUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=cQlOX5YZ; arc=none smtp.client-ip=71.18.227.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="cQlOX5YZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787845393; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=tD7GuzBUX3nmgWtzY2TDrWC7XWIHAdLF+AgXdDtgONY=;
 b=cQlOX5YZUnsizO0yBXOAmOLHnoBlYJeyupTMPXSqzJvAfekWhSe4tL2abr0QDSV0Db8joO
 a3SLcT+yY9IW8KdWTpHPSwI9Ym0oPh5gBzjpuyWyE0hoXU/FY3EP++JY3WlXQepbwW7aQh
 G154Ld2hi7qM3fzvS5aPvEcBZkdT8OMXUFs84DytcSYwrst/+uCnNMYkiloWsUB4xTOuUJ
 zMeJkPMkRO0LOTUfec+T9c2acwbphfsUOq6fQwQ7DkdTDRFgslzdLgu3/82jTh+T4HNzc3
 el/Kmdewud5/DBfrSvUPW8WXeMJ5XJL6d+PFBWWeBdaeAdrBbecQV+fsWI5TjQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Shengzhuo Wei <me@cherr.cc>
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
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a905b10+84026c+vger.kernel.org+me@cherr.cc>
Cc: <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>, 
	<linux-arm-msm@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH 1/3] i2c: at91: release DMA channels on remove and probe error
Date: Thu, 27 Aug 2026 23:43:01 +0800
Received: from [192.168.9.107] ([111.42.148.163]) by smtp.feishu.cn with ESMTPS; Thu, 27 Aug 2026 23:43:11 +0800
In-Reply-To: <20260827-i2c-dma-channel-leak-v1-0-271d4adc03a0@cherr.cc>
References: <20260827-i2c-dma-channel-leak-v1-0-271d4adc03a0@cherr.cc>
Content-Type: text/plain; charset=UTF-8
From: "Shengzhuo Wei" <me@cherr.cc>
Message-Id: <20260827-i2c-dma-channel-leak-v1-1-271d4adc03a0@cherr.cc>

at91_twi_configure_dma() requests exclusive tx/rx DMA channels, but
nothing ever releases them on driver detach, and the probe error path
after the channels are acquired (i2c_add_numbered_adapter() failure)
returns without releasing them either, because the remove callback is
not invoked after a failed probe.

Move the release into a helper, call it from the existing
configure-failure path, the adapter-registration failure path, and
at91_twi_remove().

Fixes: 60937b2cdbf9 ("i2c: at91: add dma support")
Cc: stable@vger.kernel.org
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
Assisted-by: GLM:5.3
---
 drivers/i2c/busses/i2c-at91-core.c   |  3 +++
 drivers/i2c/busses/i2c-at91-master.c | 12 +++++++++++-
 drivers/i2c/busses/i2c-at91.h        |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at91-core.c
index b64adef778d4..8ca4556d9664 100644
--- a/drivers/i2c/busses/i2c-at91-core.c
+++ b/drivers/i2c/busses/i2c-at91-core.c
@@ -255,6 +255,7 @@ static int at91_twi_probe(struct platform_device *pdev)
 	if (rc) {
 		pm_runtime_disable(dev->dev);
 		pm_runtime_set_suspended(dev->dev);
+		at91_twi_dma_release(dev);
 
 		return rc;
 	}
@@ -270,6 +271,8 @@ static void at91_twi_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&dev->adapter);
 
+	at91_twi_dma_release(dev);
+
 	pm_runtime_disable(dev->dev);
 	pm_runtime_set_suspended(dev->dev);
 }
diff --git a/drivers/i2c/busses/i2c-at91-master.c b/drivers/i2c/busses/i2c-at91-master.c
index 894cedbca99f..68238cc8aee0 100644
--- a/drivers/i2c/busses/i2c-at91-master.c
+++ b/drivers/i2c/busses/i2c-at91-master.c
@@ -817,11 +817,21 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
 error:
 	if (ret != -EPROBE_DEFER)
 		dev_info(dev->dev, "can't get DMA channel, continue without DMA support\n");
+	at91_twi_dma_release(dev);
+	return ret;
+}
+
+void at91_twi_dma_release(struct at91_twi_dev *dev)
+{
+	struct at91_twi_dma *dma = &dev->dma;
+
 	if (dma->chan_rx)
 		dma_release_channel(dma->chan_rx);
 	if (dma->chan_tx)
 		dma_release_channel(dma->chan_tx);
-	return ret;
+	dma->chan_rx = NULL;
+	dma->chan_tx = NULL;
+	dev->use_dma = false;
 }
 
 static int at91_init_twi_recovery_gpio(struct platform_device *pdev,
diff --git a/drivers/i2c/busses/i2c-at91.h b/drivers/i2c/busses/i2c-at91.h
index 942e9c3973bb..d68fcbbc3e0f 100644
--- a/drivers/i2c/busses/i2c-at91.h
+++ b/drivers/i2c/busses/i2c-at91.h
@@ -172,6 +172,7 @@ void at91_twi_irq_restore(struct at91_twi_dev *dev);
 void at91_init_twi_bus(struct at91_twi_dev *dev);
 
 void at91_init_twi_bus_master(struct at91_twi_dev *dev);
+void at91_twi_dma_release(struct at91_twi_dev *dev);
 int at91_twi_probe_master(struct platform_device *pdev, u32 phy_addr,
 			  struct at91_twi_dev *dev);
 

-- 
2.47.3
