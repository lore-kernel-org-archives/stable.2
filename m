Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550759;
	b=tAIexKrO7imLjm1C3xzfzHTM44UA6SHy/AMA64QljMAzrl96Rg0jMHK71GxDxky6LGXB
	 RQBh5Z4lF76r5E77Z24DRm5by4qv0DNwdGyIVW8Ir/XcFbnqA+7VVfWTXKhKCJjWto6oX
	 /CcvKdYXh9+Gc/0QaaPgaPNZ3Q88VKTKGkjWFWZXzwKNXS/T5oU/i2Y2i3CsaadFNnZNA
	 Yi652FbxxeeaxO+H712s1iR1IOBFXoLa5T7DklTVK5b4qM0Wd3Vr7Bu/3xDeHq95BYuEo
	 vbOB1ChTbSyOrKM6qK8Bu7bwQN5c3/H/wrTJ6is9b3niJ7bcTXoxqu9jujG/Y1kY4Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iFLRmIpfBlnSgkw2NzNhDZgfvhMKknERscVzqbFyv9U=;
	b=5BftKaCNyZoj7jBNkwnnXPyLh/4hS+i4XRD3Fh2vMMCj+/yl/ei0n0K3RVIBy/K8kwy8
	 nM+iuiT1ChFAtef4j1ldjnhsmBs741nig/1Pq3xXN/bJYCA4dCrFYVsSYdYDJfbYBodm1
	 VcgGJjT785UJ2HN3pudDA9rAYL8+4FF/T8+qM7nZi+ciCtZJW/aEopa7X7OubLQ/tq/ld
	 0Ygouk/hwoHzh5SILsmhAso6CV707jxpf86q7zYSa0BB8XpmaAComgc3oG3mstT4cJTje
	 EcO+3JcemPgCi93bf/0q1Ol8S96XDIEb2lP+Vy9dxXMXVO1mNRr5eg8bDJQBwsE/PoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E0Rn3ysS;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825ED606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 16:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 825ED606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E0Rn3ysS
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a56e05568aso7658875e9.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 08:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793550758; x=1794155558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iFLRmIpfBlnSgkw2NzNhDZgfvhMKknERscVzqbFyv9U=;
        b=E0Rn3ysSMBRCTtBfkBmzHVr+Hq439phfwyyWpeM2ztVJxpgMjKmAa1As39gTkpTcyd
         n7uhviJjEF5sTybCG+x8gm/d7q7y3m9P/3Un/k+mfowB0/tiqdQf30QQ0rdUdY5WBN/J
         UXjQvF2BrDRBa3El6IZsNbLF8+MSZHtUEK+18VZsUpNmGs4wZVPdj6455PA477iJ9cGr
         bne79mtvajzKNYBMmJbPdPAxoUW+eRz2MoSQ3Ydldbxv6WoMFFmPA6Fwy5j8ZLkaH0Jx
         uwxZ7IbsbqXNzLOtmE0AUGKKkIPIRtY47nJUS/RJn0Obs/XnaYs7658jiUhAWExA+lwo
         zblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793550758; x=1794155558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iFLRmIpfBlnSgkw2NzNhDZgfvhMKknERscVzqbFyv9U=;
        b=NcMgylEWN0MZEU6t5lAE0+CG+GMQFENUfp631Hct2X7l2G0Pe85vJCGt3ilpMuOENG
         CJiP6D1SHNywQKG0YVKc/Vt++b46nZ5N2IOmayPNY0raQSm9LOgc20oaHhujqaERI35S
         lkgpLPmr2nn9yv0GpHygUQUuP1BwoztgfsBe5um6WT3QAk8fBhHVEBbnhgFNZCjxpuiQ
         ZIAcqapClJcrUFl/67A6Y8ibkRo1qUAxzyh67flBHk/ZX4me2lJaTbsKSs8aGlTqCWlj
         0QYSDNbqdIlp/elJCC/0/Xv4XqnU85XIuYglgYwBHkh1dt/85nR2P/vyuYMpjcm4o0bH
         Hdig==
X-Gm-Message-State: AFq9FYLMrn/XUwwydkuFS7CCTpHC+PS3O9z1o5mymEoE1CsWP5Bm5GQR
	UcaNEyUewQBE1pE95ugA6ZPTBm7U70uOQtNzr37tQy2Z/vayXjzKJx8qTZtVuh6d
X-Gm-Gg: AYBFou3/EJ90poqCtYxmscSIfpVqGQKw8IkzY1yPm6+9kp3Potunk2Zs/Pbl979dTYS
	t9kKIkoQbxxpNDiyWQAPirhuY6yM0wjStEcv2+LqdzGIPosNQ9T95qUGRzvJ25xM9vNErk4DT/g
	SoW+bV44M/OjMze+W/XZCTT/LXIF+t91jNLQ14fk4nGONaBavDZSli2GFcYOzauANbiigNucpjZ
	leByoDOXvUGNEpLKq/p4XoOGropp53woXau5pBS49uPTMOUMhQcMYDvHqSKcPy20MsfYm20/t6p
	NKFL79zhCe0WWBZJj4I2tHlawjROQswan+yytOzYzgbariHmAJmGbFiIu1qKDcoqtzhtHUKukuh
	YdFUA2Hv5Fhqx6vKfa0kvXlvYYHj3E0rpuex9wW0oJbYKHffMwIkQdI5RKSKen/wCaJPZh0tsEd
	rIIC3xFuM05JJYmkNl8A4Go/JDbpV9CIzbkFhIiVrvity7f5QUoa5pQ2K6ynRYbWBh4vuGWNCG4
	7RRCJ3+pnFC8ceBFs5D9E9Br9Ze45JeArto5iOu/usQ30T+FooI2sfy1jXuv4II7oMp83QjqLMZ
	d0kJN086m5i9bvJgJUFT3oofRJa/TEkI7UnJzUi8sZSBylo/Q4M=
X-Received: by 2002:a7b:ce0d:0:b0:4a1:715d:1913 with SMTP id 5b1f17b1804b1-4ac177538c5mr139047215e9.1.1793550757885;
        Sun, 01 Nov 2026 08:32:37 -0800 (PST)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe77053fesm97219875e9.0.2026.11.01.08.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:32:37 -0800 (PST)
From: Itai Handler <itai.handler@gmail.com>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Marek Vasut <marex@nabladev.com>,
	Marek Vasut <marex@denx.de>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org,
	Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
	Itai Handler <itai.handler@gmail.com>
Subject: [PATCH 5.10.y v2 2/4] spi: zynqmp-gqspi: fix clock imbalance on probe failure
Date: Sun,  1 Nov 2026 18:31:52 +0200
Message-Id: <20261101163154.2274099-3-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261101163154.2274099-1-itai.handler@gmail.com>
References: <20261101163154.2274099-1-itai.handler@gmail.com>
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

From: Johan Hovold <johan+linaro@kernel.org>

commit 1527b076ae2cb6a9c590a02725ed39399fcad1cf upstream.

Make sure that the device is not runtime suspended before explicitly
disabling the clocks on probe failure and on driver unbind to avoid a
clock enable-count imbalance.

Fixes: 9e3a000362ae ("spi: zynqmp: Add pm runtime support")
Cc: stable@vger.kernel.org	# 4.19
Cc: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/Message-Id: <20230622082435.7873-1-johan+linaro@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
[ itai: 5.10.198 carried this as commit 19f3d5d13b75, and 5.10.199
  reverted it in commit 649237ccf440 along with 2cdec9c13f81, the
  mislabelled backport of the previous patch, which this one depends on.
  Context - zynqmp_qspi_remove() in this tree already starts with
  spi_unregister_controller(), added by commit aeb00d7e89ca ("spi:
  zynqmp-gqspi: fix controller deregistration"); take the runtime PM
  reference before it, which is the order upstream ends up with ]
Assisted-by: LLM
Signed-off-by: Itai Handler <itai.handler@gmail.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 7223eee6db88..58b8c5c37f9a 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1189,9 +1189,9 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	return 0;
 
 clk_dis_all:
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
 clk_dis_pclk:
 	clk_disable_unprepare(xqspi->pclk);
@@ -1213,13 +1213,17 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
 {
 	struct zynqmp_qspi *xqspi = platform_get_drvdata(pdev);
 
+	pm_runtime_get_sync(&pdev->dev);
+
 	spi_unregister_controller(xqspi->ctlr);
 
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
+
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
 	clk_disable_unprepare(xqspi->pclk);
-	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
-- 
2.34.1

