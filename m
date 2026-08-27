Received: from sg-2-4.ptr.blmpb.com (sg-2-4.ptr.blmpb.com [71.18.227.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAB04749D4
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845401; cv=none; b=u/vSMoeAU85bES/X6ezNj8pqgfuVq7dzYe/Uj3Dja1e/u3lzL+R6jWU65Kpu9lBYorS52drbjjJ/MLqjlEm+7prwKL3rtg/xhwrkaiZEDg2HP4HYrj45KbV79g2gIE7WU92h6SON8oWpdyoFW9Q9vaMZ1t1W6jmHvK1uOr/LdiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845401; c=relaxed/simple;
	bh=/oqgHYDPvMDVagPO7AKnMT/fGfUZ6coiSZBJygQnBzM=;
	h=Date:Mime-Version:Subject:Content-Type:To:From:Cc:Message-Id; b=onDdD/vBiG3yVzNHhqiJm9eAA617JtWxPKJKek9JjlcSX6TtzF/bn3U90bIWKNpBqyumhs/bjiDLbVWz6QDY63fjyXZqYS9mZ2btJ4UOCYaF8uHpHH/Tr+VYDyGpbVcJnhKx/VOtvbO0P/UFCRw1vvjmMcL+x6u+iCI6pWxPXi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=V00chBgz; arc=none smtp.client-ip=71.18.227.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="V00chBgz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787845391; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Bh0KpptlHo4EabAVwVEP+7z/2v5dfwz3z0l/dDVT/I0=;
 b=V00chBgzzYgCqNjsuHPKFjsaKDb0LkzBjsxut47JqxA7+5W4pM0BccR2F2R7vQes0TTFpB
 CqsGB8gZYtZG+s6NxpTU9ZmZgDVVrYWPC/nmikjbHWJdGVzsm8GmCSaQTPhUpQQ2wntGhb
 lC8z9JgzYZrDvEA/PA+1hqfz3syOhXPy19RLct8Go+Q+MGt1GTJVX5k1Z+2NSwciBV4wHB
 DyOUkyR6J2fz6xSV1BkC1cNjkQuxBMO2tJ6StH4Bu3/x9/vJkye70qdlRUjYsoOTS8zCCj
 GPBhaAbl57rJBKTSBN5cujFZ/cDy16J+ritY4XpZDlhHLIIE+TjR3THmtvlw1A==
Date: Thu, 27 Aug 2026 23:43:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Change-Id: 20260827-i2c-dma-channel-leak-b58522243736
Subject: [PATCH 0/3] i2c: fix DMA channel leaks on probe error and remove
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.9.107] ([111.42.148.163]) by smtp.feishu.cn with ESMTPS; Thu, 27 Aug 2026 23:43:09 +0800
Content-Transfer-Encoding: 7bit
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
From: "Shengzhuo Wei" <me@cherr.cc>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-Lms-Return-Path: <lba+26a905b0e+0576c5+vger.kernel.org+me@cherr.cc>
X-B4-Tracking: v=1; b=H4sIAAVbkGoC/yXMQQ6CMBCF4auQWTMJTi0Qr0JctGXUAayko8ak4 e4WXX55eX8G5SSscKoyJH6LyiMWHOoKws3FK6OMxUANtU1PHQoFHO8O9zXyggu7Gb3tLREdTWd aKNc18UU+v+xw/ltffuLw3FuwbV9sRvTUeAAAAA==
Cc: <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>, 
	<linux-arm-msm@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Message-Id: <20260827-i2c-dma-channel-leak-v1-0-271d4adc03a0@cherr.cc>
X-Mailer: b4 0.16.0

Three I2C bus drivers request exclusive DMA channels before
registering their adapter, but none of them releases the channels on
the probe error path (the remove callback is not invoked after a
failed probe), and the at91 driver never releases them on remove
either. Same class as 777979e62711 ("i2c: mxs: fix DMA channel leak on
probe error"), which used devm_dma_request_chan() for mxs; here the
drivers own non-devm state, so the fixes release the channels
explicitly on the error paths.

The three drivers are otherwise unrelated; the series exists only
because the bug shape and the fix shape are identical.

---
Shengzhuo Wei (3):
      i2c: at91: release DMA channels on remove and probe error
      i2c: imx: release DMA channels on probe error
      i2c: qcom-geni: release DMA channels on probe error

 drivers/i2c/busses/i2c-at91-core.c   |  3 +++
 drivers/i2c/busses/i2c-at91-master.c | 12 +++++++++++-
 drivers/i2c/busses/i2c-at91.h        |  1 +
 drivers/i2c/busses/i2c-imx.c         |  2 ++
 drivers/i2c/busses/i2c-qcom-geni.c   |  4 +++-
 5 files changed, 20 insertions(+), 2 deletions(-)
---
base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
change-id: 20260827-i2c-dma-channel-leak-b58522243736

Best regards,
--  
Shengzhuo Wei <me@cherr.cc>
