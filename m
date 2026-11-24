Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540920;
	b=aK+xvswobWT0EwU2sKoxNLVlG9d4AtUgm0JiBvyE0LpkK+27LHEHbYjqYUY0jGYTSnDo
	 +UkzUzqipKmqUwriHKiOvTKs+9eeJfnd6dBbaMx7ndiUKE9s33wU+5md3uHNoS6tExrD6
	 MrKHpEPZPX8uqC5hkDi8/KbTgH1uHFeSvNttcRRLSevNDJfjhiWQHZbrM8eOmi4gRU/Ll
	 yvNxPk/7YyXGmmToKJy9T5DpAEUksDo7xDOUJBvELjul7ZanBplULpNun33Z0aDNsQchA
	 apO+/jikhSlNzC4KO44XyWq/Teiwy2CnymcgpGekmTVrW5KZXK9oQQjktOQXGFyMu5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540920;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sZh0LteIFXdmL7TCELOzeNvAYQWHVIaMRM6xektiJo4=;
	b=spZ4frbbAox7XaObz23cGMKxE2gHTg2+45mWTK5KTuZQ9Qo6dSEfn7vkYpZzaTNGZoKp
	 hAS69AwNAaH4nzow+8pay+JP8nCGDKf6QDTKb53KCiKmzyOg2nFnubB57OJGXiorbfZ0w
	 pNj/3clOm+q11vyPnzowNew3VRGs7u0YjNKYDF53n2vIWP856U2Ey04/lNjQWR7e2vES+
	 4xrEpHaKT/dnGO3DInTkiet+lztxwCJ+6LoL/nSTqKA28kzjBYp+UjbMmiSnfV+kvkqdo
	 OfhoMQfeAr28aaaEriEQj4nNXvbsp7Xiks7pi9wqWoqU0vNj/NfLZk/3rORjKqJe3sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G91Qk/SC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A09A606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G91Qk/SC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70CF1F000C0;
	Tue, 24 Nov 2026 17:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540920;
	bh=sZh0LteIFXdmL7TCELOzeNvAYQWHVIaMRM6xektiJo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G91Qk/SCr4kmV3NvUDTWQHi5p2MmfLUa2UZU2P46Aa7S9+feaNyQO8XW/mXu62GXo
	 u/9sDf9lFaj0O21o5MPtCJtaWrPYEgeTlLH4fZokWnyDLvE4oTMKD8LPSV39rIkSWx
	 SXkUtT/e6xfob4Z7iEYI/e4C5Zhm+l9VNl9GBXUiAWn+AiZ26X4h1vw+vWO/JNYhHl
	 m1zQaA+fwkLj9HUFylk17WMwo2mW4oEX923g5YChh0eGUwR0NXVuVJohdLdc9aFh5L
	 y6be1vnFSdGI/JmZPOSrAWpi+QeKa7ZH8EJOMNKw8ng0DZMIOEL8cilK8DGIwM03/1
	 LysTTSz/6b3zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] mmc: sdhci-esdhc-imx: reset the tuning logic before execute tuning
Date: Tue, 24 Nov 2026 12:21:56 -0500
Message-ID: <20261124172118.1820919-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112445-preoccupy-capped-e0f2@gregkh>
References: <2026112445-preoccupy-capped-e0f2@gregkh>
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
index 3c7b32c0d3f3f..e417fa52e1926 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1014,6 +1014,44 @@ static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
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
@@ -1025,6 +1063,12 @@ static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
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
 
@@ -1198,44 +1242,6 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
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

