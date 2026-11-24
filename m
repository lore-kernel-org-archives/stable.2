Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540862;
	b=FDMEpHWm0CoK7rGRRwXIHKx7qcASl682HQ4fH+1ztow1+30en/0JNpR3PSV4RWMsx/9c
	 vg7XdRQG1R47tkFzZ5kWldsrmWeFtCm0NLyKHd43eLyMK42zRb8nhobhMO1nE5BZU/PrO
	 5xEywK9WAH5zVnJNfrO4YKumBRpf+j6VsREJYV/pjLaV5Mo6mfRVfxlzIFmtcZdEeabQl
	 AcDGf/7BOpYHrTIurEDV5NorY75WTIxAdCELys7tkOtSsMaTiWGI3cibSo48kMrwu4qSX
	 10UyhAxdNo12rw3RJmvMDpVTQzaikjLEBVE5EeAcXCrI9krYDJxoDJ3vdxlNLXwCiXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540862;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Rk2J6ClzSqyN6a1JQNbue4HuCLpZeYjPJq84JL6g2NU=;
	b=GRzB/5BpOFOegsuPo9MIWjLh577DhRT+KLw8rp9MjT7wdMP+zABAt/K3aWo1FiChe7Ed
	 U4KspxNkqRC2CWhCEdEzwenTL3XVkxYhvmkwootez/qo05KJeglMl4jLAhXSXAIv9Y3eC
	 j7RZwrdFL8wjwBy9KkXEilkOmLR7//EbiCCc2FEjFibPuiGg9Bi+zYKDcX57RfaQk9As/
	 cUJZVWofqimeyFrzkpVVwj03qJiS/aGHZDfCrx/NjZrS/JOenzl6zC/7Th2yVhaqx3r4u
	 d6YNEE0f6CqbEKL9BK4Q5OAB+RX3oURYmrybiZoNLCRDIeYmyQiPYREbUC3/nYVkw5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zb197vQ5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70112606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zb197vQ5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855D01F000C0;
	Tue, 24 Nov 2026 17:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540862;
	bh=Rk2J6ClzSqyN6a1JQNbue4HuCLpZeYjPJq84JL6g2NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zb197vQ5OD5W1/4JgXrdHZHBwT7qrbixyOt7bE5q6zNJwWdM4KhvzNMmuVMhRip8W
	 3QNyDvsai4YvLgG3uzVSlmIQiokohPdhaQHxSmVCjxRPw7BWDKw7ZY8G51yAXYINEv
	 Jm5wsFJVMPr0V+KIGR+vF4CKSM84Vpg/agPCYXckFrMQknr05HEn738BjXFUkF2f7o
	 m0e4ePjqqrP4rNMGYbAEHQ20t8TfogFHBVB9Ce5mGVGOn2VrmWZqnws/hhdiD0Ebjy
	 551rKWr8ig4FK4fRGr7GZD4XBqVXZ3vx92GirA/mIfeNepVc9GvfOT+FD/Ztn7ttwP
	 5lXUof68zZ0XQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Ray <ian.ray@gehealthcare.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] mmc: sdhci-esdhc-imx: map unsupported driver type to Type B
Date: Tue, 24 Nov 2026 12:20:57 -0500
Message-ID: <20261124171905.1826571-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124171905.1826571-1-sashal@kernel.org>
References: <2026112445-decent-yeast-d230@gregkh>
 <20261124171905.1826571-1-sashal@kernel.org>
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

From: Ian Ray <ian.ray@gehealthcare.com>

[ Upstream commit d35d93c2902592a84347a15deac4d67a323694c9 ]

Since commit 5a52c5701a67 ("mmc: core: Fix host controller programming
for fixed driver type"), the eMMC driver strength is passed directly to
mmc_set_driver_type(), which propagates the value through ios.drv_type
all the way to sdhci_set_ios().  For value 4, SDHCI correctly warns:

  mmc2: invalid driver type, default to driver type B

The host driver type has no effect on this controller: esdhc_writew_le()
never programs the driver-type field of SDHCI_HOST_CONTROL2.  Hook
set_ios() and force drv_type to the always-valid Type B, so that SDHCI
never sees an unsupported value.

Tested on i.MX8MP (usdhc3, eMMC in HS400) with
`fixed-emmc-driver-type = <4>`: the warning is gone and the HS_TIMING
register contains 0x43 as expected.

Fixes: 5a52c5701a67 ("mmc: core: Fix host controller programming for fixed driver type")
Link: https://lore.kernel.org/all/20260926122908.866-1-ian.ray@gehealthcare.com/
Cc: stable@vger.kernel.org
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 0b36ff7c53b05..2ad19afeb9f70 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1063,6 +1063,20 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 	}
 }
 
+static void sdhci_esdhc_imx_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	/*
+	 * This controller has no driver-type control: esdhc_writew_le()
+	 * discards the driver-type field when writing SDHCI_HOST_CONTROL2.
+	 * The programmed value is therefore irrelevant, but SDHCI rejects
+	 * non-SD values such as 4 (eMMC 40 ohm, from fixed-emmc-driver-type).
+	 * Force an always-valid Type B.
+	 */
+	ios->drv_type = MMC_SET_DRIVER_TYPE_B;
+
+	sdhci_set_ios(mmc, ios);
+}
+
 static void usdhc_init_card(struct mmc_host *mmc, struct mmc_card *card)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -1704,6 +1718,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->mmc_host_ops.init_card = usdhc_init_card;
 	}
 
+	/* No SDHCI driver type control */
+	host->mmc_host_ops.set_ios = sdhci_esdhc_imx_set_ios;
+
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
 		sdhci_esdhc_ops.platform_execute_tuning =
 					esdhc_executing_tuning;
-- 
2.53.0

