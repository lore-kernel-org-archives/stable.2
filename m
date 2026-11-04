Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806044;
	b=fiPWWmqaYQMt9ax7riNC4SSubZfE/+6S0kHwqwM4enugn8U5C84IwGjKleHgbSaJElDy
	 ZD/Fqf6utC8M/sG3t8c0jM25sWasuTotQQBMt96KWRZIPtGLjHJcthUYQAdpe5cSUyst5
	 YFiL+ONEw9Xm8y89RcYhzMWay5tyg480DsEcrL+IkwWLvYzWtu9u7GEuAwYWUkwgmBLQK
	 s3ubr99G/KUbJ7aDecxGJitDIZ+wyjOi9pdRVUrmCDyh79OLjceZDQaUOhIBwSX6pDIyv
	 fFOvdCExCTYchnlQiavfi5msSx2gqtOMGZcC5zxainvS9ABbavfvbUFxjS1vuGFZD0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806044;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JN22oxdaN3zgBX5qNztQ4ZuT8bGPH+vtOiywU9Zm/R0=;
	b=rl6M4+kkChR9+RJ5U1hW7yDoR1UBE5m3hdMHyk+Gy+LT0Sgi/GbzhzzVWGwny359npFc
	 6Xgao5tK1mtK4pf+Bzw3aaMgPpRmWjBpm1n3y16OIfUMn1SeZVtu2sHlDg4v6oEdvHFdP
	 EWb4fkcBIQ+ey6hNaZsRuh5011MPGixeuc1vEZHP+8tYma9qZAQpYhzXOjZ42MTVZaB0F
	 4ygvjFwJPTctPSPJgEjMZVzcb68zjJoPmMKZFw/rPXNReJtlFM0Ti83irGcRs02sHxLLA
	 xt71IgdiGlzAiJFSblOdjRDHvXXMNFVYICGW4chDT4LHhdVOukGBGwryI/yPZ8+Nyew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.net;
	spf=pass smtp.mailfrom=posteo.net;
	dkim=pass header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=EZAUJ5Ps;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EF3606D806
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8EF3606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=EZAUJ5Ps
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 58772240105
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:27:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.8680eb; t=1793806042;
	bh=JN22oxdaN3zgBX5qNztQ4ZuT8bGPH+vtOiywU9Zm/R0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=EZAUJ5PspiLCVJ+gpdACGaT/RQHwloO815etCseAXsLgHh+6L/aAYYBo2pGtU1Hg2
	 ADHhQckFJsIZicQIo66QTfSjaa0BBR/xJQGQ+teKq9BFIwrjDSvD1jEgebOpuHaYI8
	 S9ohrzi7+nSIELEk8RZa0Xc/WI43M87RHxOpBnc+8rxi9wT4IhR9frb2B3ceG2oG55
	 BbgVkt6eein0A8sYJJwFVU3AfqjsbcD1qA/7oCEl4ehpV4ch8h/G9mayI8eFfHLGMT
	 5Jomv72iIwd2hpz6Ax8i05F7zR+KNB0zoIzQ/4h90NKNAQAUNkl/6qtF/qy/j8Xoh2
	 22glTK3I+yy9w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jKTp00wwKz9rxV;
	Wed,  4 Nov 2026 16:27:20 +0100 (CET)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org
Cc: Christophe Kerello <christophe.kerello@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linusw@kernel.org>,
	Yann Gautier <yann.gautier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mateusz Nowicki <mateusz.nowicki@posteo.net>
Subject: [PATCH v2 3/5] mmc: mmci: stm32: use the delay block above 100 MHz on stm32mp25 SoC
Date: Wed, 04 Nov 2026 15:27:21 +0000
Message-ID: <20261104152657.14909-4-mateusz.nowicki@posteo.net>
In-Reply-To: <20261104152657.14909-1-mateusz.nowicki@posteo.net>
References: <20261104152657.14909-1-mateusz.nowicki@posteo.net>
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

From: Christophe Kerello <christophe.kerello@foss.st.com>

On stm32mp25 SoC, the delay block has to be used only for an external
data frequency above 100 MHz. Skip the tuning up to that frequency, keep
50 MHz for stm32mp15 as before.

Fixes: b5c3eb385797 ("mmc: mmci: stm32: add delay block support for STM32MP25")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
[Mateusz: reworded the commit message, check dlyb before reading
min_freq, added Fixes and Cc stable]
Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
---

Notes:
    On the STM32MP257F-DK (SDMMC2 kernel clock 200 MHz, eMMC in HS200 at
    100 MHz) the writes failed with I/O errors in all 9 test runs without
    this change, with sdmmc2 pins_a or pins_b and with or without NEGEDGE.
    With it all 6 runs were correct, on both pin groups.

 drivers/mmc/host/mmci_stm32_sdmmc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index bb058e0910ad..a50dc58336de 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -75,6 +75,7 @@ struct sdmmc_dlyb {
 	void __iomem *base;
 	u32 unit;
 	u32 max;
+	unsigned int min_freq;
 	struct sdmmc_tuning_ops *ops;
 };
 
@@ -636,14 +637,16 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	u32 clk;
 	int ret;
 
-	if ((host->mmc->ios.timing != MMC_TIMING_UHS_SDR104 &&
-	     host->mmc->ios.timing != MMC_TIMING_MMC_HS200) ||
-	    host->mmc->actual_clock <= 50000000)
+	if (host->mmc->ios.timing != MMC_TIMING_UHS_SDR104 &&
+	    host->mmc->ios.timing != MMC_TIMING_MMC_HS200)
 		return 0;
 
 	if (!dlyb || !dlyb->base)
 		return -EINVAL;
 
+	if (host->mmc->actual_clock <= dlyb->min_freq)
+		return 0;
+
 	ret = dlyb->ops->dlyb_enable(dlyb);
 	if (ret)
 		return ret;
@@ -749,10 +752,13 @@ void sdmmc_variant_init(struct mmci_host *host)
 		return;
 
 	dlyb->base = base_dlyb;
-	if (of_device_is_compatible(np, "st,stm32mp25-sdmmc2"))
+	if (of_device_is_compatible(np, "st,stm32mp25-sdmmc2")) {
 		dlyb->ops = &dlyb_tuning_mp25_ops;
-	else
+		dlyb->min_freq = 100000000;
+	} else {
 		dlyb->ops = &dlyb_tuning_mp15_ops;
+		dlyb->min_freq = 50000000;
+	}
 
 	host->variant_priv = dlyb;
 	host->mmc_ops->execute_tuning = sdmmc_execute_tuning;
-- 
2.56.0

