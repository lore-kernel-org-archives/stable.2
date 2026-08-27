Received: from sg-2-3.ptr.blmpb.com (sg-2-3.ptr.blmpb.com [71.18.227.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080B486637
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845412; cv=none; b=kQGbbkxhhCh4dKYjFJwb+p/loZwO8k45Dr8OJ65+OnXNuTOwZv6a890izl6Of06OAQlo5NJtzwTOr9DzUzbAl8PY+Npk5mpQyRX+MHJc4DRIZWllPnRnfY6ctktqycgq6AgxVyt7J4GaZXzf2TZYN0WqJt3dS1rxAlWHgUfNK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845412; c=relaxed/simple;
	bh=Pg4NFUX8JDPIXbUkkwq0Ml6GLH1igP4ZUMKg6RWzpA8=;
	h=Content-Type:To:Cc:Mime-Version:Subject:Date:References:From:
	 Message-Id:In-Reply-To; b=fR8cmVPEYFnPY4eDU/TMBLqxJ4e8iDYL5yHphSM05vtlIWNvOK10pkgW7TJeGM1V+q6AUGz29N6BHk5FHjydAft2YyWOONb3GAdNKuAjZUbiWljwzkQNbVAyw3UEqwfJS5fIs5PV37Ohzj3/qcT7pzF5Ae9u3TR1Yi+iRmeHPiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=hRfo/+JA; arc=none smtp.client-ip=71.18.227.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="hRfo/+JA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787845398; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=OOFci7YOWRONRU2EkJ/P6bDmKOzzj+GtBTW31kETtbg=;
 b=hRfo/+JAVjLKlzsS4SxiGLQzJKUn+O/szLDgLqQwnP3IvCNV+IbQ2fL05KaAdvV2GGcRxS
 V++0JZmCazu9q34jjtknWEhpBZocfYq3PHlCRGn35DXTnDhaXoJwoVq2Lh4eyh7iVmNeJd
 awasnakxT820dUAVk39gW3DOVsCbPVVadnK7nQZiyY5bzLNaHVUE7+srrDd/WDSPx9pEG2
 7mZFGHW795o4atz4ekhVg7j6t7wA3nGVCGbmmRWk3RqBzAMGHIz4SfbiXf6STZPFbbZcel
 H9fxf4Z/se/OXHinYVASncGItAygVUpRMshhRy4opCMIx5AvWRFgK+GclWQ5bg==
Content-Type: text/plain; charset=UTF-8
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
Cc: <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>, 
	<linux-arm-msm@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3/3] i2c: qcom-geni: release DMA channels on probe error
Date: Thu, 27 Aug 2026 23:43:03 +0800
X-Mailer: b4 0.16.0
References: <20260827-i2c-dma-channel-leak-v1-0-271d4adc03a0@cherr.cc>
X-Lms-Return-Path: <lba+26a905b14+718575+vger.kernel.org+me@cherr.cc>
From: "Shengzhuo Wei" <me@cherr.cc>
Message-Id: <20260827-i2c-dma-channel-leak-v1-3-271d4adc03a0@cherr.cc>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
In-Reply-To: <20260827-i2c-dma-channel-leak-v1-0-271d4adc03a0@cherr.cc>
Received: from [192.168.9.107] ([111.42.148.163]) by smtp.feishu.cn with ESMTPS; Thu, 27 Aug 2026 23:43:15 +0800

geni_i2c_init() grabs exclusive GPI tx/rx DMA channels when the serial
engine runs in GPI mode. If i2c_add_adapter() subsequently fails, probe
returns without releasing the channels, because the remove callback is
not invoked after a failed probe.

The adapter-registration failure path used to release the channels via
its err_dma label; that release was dropped when the probe tail was
restructured into geni_i2c_init().

Release the channels on the adapter-registration failure path, mirroring
geni_i2c_remove().

Fixes: d8d3bb127ad1 ("i2c: qcom-geni: Isolate serial engine setup")
Cc: stable@vger.kernel.org
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
Assisted-by: GLM:5.3
---
 drivers/i2c/busses/i2c-qcom-geni.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 658636c1ee0e..45c770552bd2 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -1189,8 +1189,10 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = i2c_add_adapter(&gi2c->adap);
-	if (ret)
+	if (ret) {
+		release_gpi_dma(gi2c);
 		return dev_err_probe(dev, ret, "Error adding i2c adapter\n");
+	}
 
 	dev_dbg(dev, "Geni-I2C adaptor successfully added\n");
 

-- 
2.47.3
