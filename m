Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540921;
	b=foDr/Gz1XxqU9zQF/f8I1iOhtSm4r7eSX31nuD11doAemu/ZKK4qZ0mA35uWLt2aKZiU
	 W5f9n4KVWtPx/W175ex0hYFsLijO1amSXyn7NLrnk0FNaAbRfdP4hiiM2jNoEFs7mv3nW
	 pSFdTy4kBS8pEJ108v1aU4yxCMaD6v5ve+EUrBuIQ9whBVpwrhwdeiy2+TwsNI23wUFoH
	 e70svZaB9M/IWOtMFB17Io0RDR1Za+Hgmx/xeZ71Bu27J9cr0t5w9j6FdOA+VwZKjoG8o
	 yKRQ4JyNupqRN3wjM17Bssj/2/uGBga3pBTS/SOgOLDBHMf956zbVAIKt3rS1DGXVqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540921;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AB2nbvlA0Pj04jJPqZMjwWJRmYoDD6P13JYtTScEqi4=;
	b=13ooTFvG8xfwdojEzx7EG/28z+O3R0VslLxEjWUXXPeGBM9zgRjTmkEKoQwBHHdvarGN
	 UXN/zhSeHOhfbqVLsvdiw+W4+5bSaJ/dtmsULOdC96z25lUcXRqd7ZI6TQ88yGKzl5EtF
	 5CiEB8xyjf0c3JJq2iVRztyKIxV/x/UtI83RIEjEBXdNAiUdzdZ2D7IYBrcxJc1tuCppW
	 e0f4ZdkfWD16x1C3OTFVOQR8y2Uaq9K9uLi6o/7HnPM95pZqwr44X/tj46KNJdEcyXW6w
	 0JrT+OKKK7EomwgccSPCCmkU2j6rbpbMTjiHXm8EGJpH+YRzFOXg4gBU9MTjEW1ixGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dcs35+M1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC57606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dcs35+M1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFC21F000C0;
	Tue, 24 Nov 2026 17:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540921;
	bh=AB2nbvlA0Pj04jJPqZMjwWJRmYoDD6P13JYtTScEqi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dcs35+M1OMUXFba+UbfYRZ/6Jp9m0N+b+VewmJ5V1ZHqGVpiXYfkyxuc2wemYQLmI
	 NwwKRgTz3EWHqKCGD/oJOyZd/h16ZQHQVpx/Bv4njYWTMn66AmiG0RKU3Q+p0UzfQG
	 shzF6TYeT79nril3mFeAVnqJwfPNmkujGZ3Jj0j598X+jIph3w3CQGUM+PHkFIMZE+
	 rmNES4boRrY4nRKydfIQ/Dr6pLrueHVxcf8eaGvZM9K26XUF3IErLZTQ/aGk6RtctF
	 f7BvPbdLjfkixO84vvwCqqDwgLzzAQLCIkLjbmRsx32lvBu0L02yhQlMta5K0syIQc
	 CCjfzX0PQ0VhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] mmc: sdhci-esdhc-imx: only enable DAT[0] and CMD line auto tuning for SDIO device
Date: Tue, 24 Nov 2026 12:21:57 -0500
Message-ID: <20261124172118.1820919-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124172118.1820919-1-sashal@kernel.org>
References: <2026112445-preoccupy-capped-e0f2@gregkh>
 <20261124172118.1820919-1-sashal@kernel.org>
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

From: Haibo Chen <haibo.chen@nxp.com>

[ Upstream commit 52e4c32baed2a4c79e20a82dc22e307499759852 ]

USDHC IP has one limitation: the tuning circuit can't handle the async
sdio device interrupt correctly. When sdio device use 4 data lines,
async sdio interrupt will use the shared DAT[1], if enable auto tuning
circuit to check these 4 data lines, include the DAT[1], this circuit
will detect this interrupt, take this as data on DAT[1], and adjust the
delay cell wrongly, finally will cause the DATA/CMD CRC error.
So for SDIO device, only enable DAT[0] and CMD line for auto tuning.
To distinguish the card type during card init, involve init_card().

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20221223025022.1893102-3-haibo.chen@nxp.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: d35d93c29025 ("mmc: sdhci-esdhc-imx: map unsupported driver type to Type B")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 41 ++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index e417fa52e1926..8637ad6bd90a1 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -337,6 +337,16 @@ struct pltfm_imx_data {
 	struct clk *clk_ahb;
 	struct clk *clk_per;
 	unsigned int actual_clock;
+
+	/*
+	 * USDHC has one limition, require the SDIO device a different
+	 * register setting. Driver has to recognize card type during
+	 * the card init, but at this stage, mmc_host->card is not
+	 * available. So involve this field to save the card type
+	 * during card init through usdhc_init_card().
+	 */
+	unsigned int init_card_type;
+
 	enum {
 		NO_CMD_PENDING,      /* no multiblock command pending */
 		MULTIBLK_IN_PROCESS, /* exact multiblock cmd in process */
@@ -431,6 +441,8 @@ static inline void esdhc_wait_for_card_clock_gate_off(struct sdhci_host *host)
 /* Enable the auto tuning circuit to check the CMD line and BUS line */
 static inline void usdhc_auto_tuning_mode_sel(struct sdhci_host *host)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	u32 buswidth, auto_tune_buswidth;
 
 	buswidth = USDHC_GET_BUSWIDTH(readl(host->ioaddr + SDHCI_HOST_CONTROL));
@@ -447,6 +459,20 @@ static inline void usdhc_auto_tuning_mode_sel(struct sdhci_host *host)
 		break;
 	}
 
+	/*
+	 * For USDHC, auto tuning circuit can not handle the async sdio
+	 * device interrupt correctly. When sdio device use 4 data lines,
+	 * async sdio interrupt will use the shared DAT[1], if enable auto
+	 * tuning circuit check these 4 data lines, include the DAT[1],
+	 * this circuit will detect this interrupt, take this as a data on
+	 * DAT[1], and adjust the delay cell wrongly.
+	 * This is the hardware design limitation, to avoid this, for sdio
+	 * device, config the auto tuning circuit only check DAT[0] and CMD
+	 * line.
+	 */
+	if (imx_data->init_card_type == MMC_TYPE_SDIO)
+		auto_tune_buswidth = ESDHC_VEND_SPEC2_AUTO_TUNE_1BIT_EN;
+
 	esdhc_clrset_le(host, ESDHC_VEND_SPEC2_AUTO_TUNE_MODE_MASK,
 			auto_tune_buswidth | ESDHC_VEND_SPEC2_AUTO_TUNE_CMD_EN,
 			ESDHC_VEND_SPEC2);
@@ -1052,6 +1078,15 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 	}
 }
 
+static void usdhc_init_card(struct mmc_host *mmc, struct mmc_card *card)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+
+	imx_data->init_card_type = card->type;
+}
+
 static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -1678,6 +1713,12 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		 * to replace the standard one in sdhci_ops.
 		 */
 		host->mmc_host_ops.execute_tuning = usdhc_execute_tuning;
+
+		/*
+		 * Link usdhc specific mmc_host_ops init card function,
+		 * to distinguish the card type.
+		 */
+		host->mmc_host_ops.init_card = usdhc_init_card;
 	}
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
-- 
2.53.0

