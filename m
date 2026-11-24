Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540859;
	b=ywkq7zbbCiIbMJe5RxlxT+qfvwwW8/uorLNgXU/fWHPnjkWfAWoDMXnF8tZ+cW8i1UwW
	 q4OVSfkZUB+jNFuprGsT2BwByVrp63HLFZnL5IclLjlmBjGKN8FHldBBmipKVwfMp5H/P
	 k2HI+PUv/OLF7wD/gc9XZNOrYcfoiT7HVhLO6QTn5rgZGqUorjbbZdVqX9C/DYbaOKXlW
	 rIhEk9aeb39zdmztMXRSAUwCo5vNtDNvCi6DVuaaO+VTN6urkwD0BNug68ybr7vZ7GQNF
	 FC15TMLz7lYnNj1wkrW+G84GvTpssU61KhKuV2SSj2jJhW7hfQQdnRYv+5tUqrRT4LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540859;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kMMtlmK1qMUdXOIKJyoh7Smdqz1lEf0nHabCdSnWYYs=;
	b=L3znhZGXNCfCqMgv63CXlKj/KsUDhpCgu3MWWZQLNOZGRyK1cL176Q9YMlJI3+Ios6Fx
	 umtMtdgMEEfLneV7bNgehywUJm6zho7m7ocV7QLqa+xZ5FA6gen/YmcNvw6tlqIA1e5ui
	 m0mzNDLSQnklrNNX5PVfnuPQVFatovTqxJx2yo1wim3wfc6az73RZjTth6pKky9Ro+bDR
	 z3PvSpONENp5jPgAAeUF1RIB8VA6Bs8y65TY9oF44X6fuyf+o7TRhuS+rdSU9GidcXzAk
	 P1Vf4upUTDf3cKWBYktg3v7WNVjyclT2v+99lYHDEG6+N/4M4g7oVZ0nZ62RpIyZjlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EmIn5jHf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1581606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EmIn5jHf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8AE1F000D0;
	Tue, 24 Nov 2026 17:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540859;
	bh=kMMtlmK1qMUdXOIKJyoh7Smdqz1lEf0nHabCdSnWYYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EmIn5jHfRp2PJrICdoloQDb0Q2xFyTs9DY3tdtHQZ07u874upzWzbUW4sgFKm/ouv
	 eOurM+RquHMeUbW8R/pzI6tOX8S7RTh7s6RjhfhuSbMYiF9JIKZ+gy6K9qf3lErIEK
	 aV9Hrd/pMT2KkRUfkvGvzKGfywJj0FKk/n6RCkvtiUU9aC6JITdOuig6vHN/YngCRV
	 S+O5fTAp2y40r9bFCDfQ+9TG8UnawHdiaXuso03RsvGvwsJyk0p9bH/q/k7Q3bclML
	 ZtcJoL9Y0EW1H0pUWP0t1hZBCop2ATkel5QEU6uVEMujtXDrGcgOq32+olZ4qdsxHm
	 9equifH/RZVBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] mmc: sdhci-esdhc-imx: reset the tuning logic before execute tuning
Date: Tue, 24 Nov 2026 12:20:55 -0500
Message-ID: <20261124171905.1826571-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112445-decent-yeast-d230@gregkh>
References: <2026112445-decent-yeast-d230@gregkh>
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

[ Upstream commit 4fb2786961c517d0a6e4e8bf947d6f7259155d6a ]

For standard tuning method on usdhc, the previous tuning result can
impact current tuning result, let current tuning can't set the correct
delay cell. And from the logic, this is also reasonable for manual
tuning method. So reset the tuning logic before execute tuning.
To avoid compile issue, this patch also move the esdhc_reset_tuning()
upper.

Find this issue when support SDIO WiFi in band wakeup feature. After
system resume back, will do re-tuning, but then meet data CRC error.

Do not meet this issue on SD/eMMC, because we already call
esdhc_reset_tuning() when config the legency ios, and SD/eMMC need
to re-init when system resume back, but SDIO device don't do re-init
if it has MMC_PM_KEEP_POWER pm_flags.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/1666947869-7904-1-git-send-email-haibo.chen@nxp.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: d35d93c29025 ("mmc: sdhci-esdhc-imx: map unsupported driver type to Type B")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 82 ++++++++++++++++--------------
 1 file changed, 44 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index d8a4080712365..d282e1c8f86db 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -999,6 +999,44 @@ static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
 			SDHCI_HOST_CONTROL);
 }
 
+static void esdhc_reset_tuning(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	u32 ctrl;
+	int ret;
+
+	/* Reset the tuning circuit */
+	if (esdhc_is_usdhc(imx_data)) {
+		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
+			ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
+			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
+			ctrl &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
+			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
+			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
+			ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
+			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
+			ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
+			writel(ctrl, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
+			/* Make sure ESDHC_MIX_CTRL_EXE_TUNE cleared */
+			ret = readl_poll_timeout(host->ioaddr + SDHCI_AUTO_CMD_STATUS,
+				ctrl, !(ctrl & ESDHC_MIX_CTRL_EXE_TUNE), 1, 50);
+			if (ret == -ETIMEDOUT)
+				dev_warn(mmc_dev(host->mmc),
+				 "Warning! clear execute tuning bit failed\n");
+			/*
+			 * SDHCI_INT_DATA_AVAIL is W1C bit, set this bit will clear the
+			 * usdhc IP internal logic flag execute_tuning_with_clr_buf, which
+			 * will finally make sure the normal data transfer logic correct.
+			 */
+			ctrl = readl(host->ioaddr + SDHCI_INT_STATUS);
+			ctrl |= SDHCI_INT_DATA_AVAIL;
+			writel(ctrl, host->ioaddr + SDHCI_INT_STATUS);
+		}
+	}
+}
+
 static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -1010,6 +1048,12 @@ static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	if (host->timing == MMC_TIMING_UHS_DDR50)
 		return 0;
 
+	/*
+	 * Reset tuning circuit logic. If not, the previous tuning result
+	 * will impact current tuning, make current tuning can't set the
+	 * correct delay cell.
+	 */
+	esdhc_reset_tuning(host);
 	return sdhci_execute_tuning(mmc, opcode);
 }
 
@@ -1183,44 +1227,6 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
 		"warning! HS400 strobe DLL status REF/SLV not lock in 50us, STROBE DLL status is %x!\n", v);
 }
 
-static void esdhc_reset_tuning(struct sdhci_host *host)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
-	u32 ctrl;
-	int ret;
-
-	/* Reset the tuning circuit */
-	if (esdhc_is_usdhc(imx_data)) {
-		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
-			ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
-			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
-			ctrl &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
-			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
-			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
-		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
-			ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
-			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
-			ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
-			writel(ctrl, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
-			/* Make sure ESDHC_MIX_CTRL_EXE_TUNE cleared */
-			ret = readl_poll_timeout(host->ioaddr + SDHCI_AUTO_CMD_STATUS,
-				ctrl, !(ctrl & ESDHC_MIX_CTRL_EXE_TUNE), 1, 50);
-			if (ret == -ETIMEDOUT)
-				dev_warn(mmc_dev(host->mmc),
-				 "Warning! clear execute tuning bit failed\n");
-			/*
-			 * SDHCI_INT_DATA_AVAIL is W1C bit, set this bit will clear the
-			 * usdhc IP internal logic flag execute_tuning_with_clr_buf, which
-			 * will finally make sure the normal data transfer logic correct.
-			 */
-			ctrl = readl(host->ioaddr + SDHCI_INT_STATUS);
-			ctrl |= SDHCI_INT_DATA_AVAIL;
-			writel(ctrl, host->ioaddr + SDHCI_INT_STATUS);
-		}
-	}
-}
-
 static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 {
 	u32 m;
-- 
2.53.0

