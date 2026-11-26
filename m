Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795683874;
	b=pZfYQB3cyEzv8JUGGctAS4YAQJozRtW9ExDiyoLgWC7PwZn+dkXac34ysz+4A7ozrt/b
	 D1TaSt10YfhwHNPXMbj0jBgR8/uS5QTI59srgn0uxNEsH3kFYCbnpcr9+8CfJ0ziaa7B7
	 LQ72Z11461RqkhlFwyowAJ59c5O6jbSWgl3xbtDzYuNXIRboOiSm+5BJku4OGyn/B2GeX
	 nst6a5gz5G9LnQJFhrRxJUFMaUNDtFSLuMMj8LsorsqLB3h+LlewRHO1Mg6BHQZ9TuiUD
	 CqfSSWTLl8rGNo59MspZpUdZG1ZguBTjZBxid3RC6azWU+suE0ni+fzV1nxKB+MNabQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683874;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=oiNNwjdBTv3I2sP/KIV6AN3roKEbxe1M3OWyVa6uuEI=;
	b=m2j22ib1BJ51MfMZG+Y51rSkBQINRlquOGvjD4MTJCb4T2JwIuSnFxoDD4ydBm8I9iPJ
	 aTe20D8GgG2CyV1Y8gJOIMmf00cofXSxCMGMk0nDKh+qqz+yYQabQsInBid74KXf6l3ZL
	 4h39iCeZlgFqrqECJiIWILHAEwafYnmgF3FKFqPe5tw0Rz5cQQ+kyDD+Xur/xJ4r3CQqW
	 HXifGOSXX9CrXJu+zdMovODcFR80+XYzmYrPFFHUD6Dn9Wym2V0crrZ6rYK6RilqG8WuM
	 C+PdiHRjIjApiq71+/ZYWV+He/C2ooKpjNVsSdyYC4RM0En1dlN3niwKijvB/T711fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="obdeg/0O";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08914606A333;
	Thu, 26 Nov 2026 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=obdeg/0O
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795683873;
	b=UVRuvGyaels/zWb4UGdQmOyPc7h3UV0dfY35Gk/P5rDS2Ajk3mphn96KMSoFkjII1XCH
	 1u4e3SnC7Kmp+CdUXCDEKrsZxcOl3qHG15la9TGf7QZ5rjCh+4VE8W0pPqqC9D54zvRzJ
	 cBemhcNiKJFasTXho/bRdr5ROUfLJWNvEVoo2uLZHspIYbZMw7R7yknOEKPfB1GZpuuec
	 TW+9jhaG5maPYLqXSift1bckkHqt53xH4BqgZcJeHwHVG06JOmmihtWX8B/3M1Vz/ijmQ
	 Khbf8aHpfz7wFAXYp9ek1K50OLueWscLnksget434mAESVdmTV0Y+T86LADvBf9mQsA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795683873;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=oiNNwjdBTv3I2sP/KIV6AN3roKEbxe1M3OWyVa6uuEI=;
	b=CIf38yXqmvbxpgnlXRYl46ZwF5xVhTNLCxJ71SP44ZpLSpVGUUDhq68SUHkNiByTu6Sn
	 XqhD7KoXMj52NPjWL87+rGcQ0rvDMi2ZQHeJwAoVZ+2g1FoDS0RPgDaoU9tKcnXeIw5VV
	 eM4o1Hw4pti6XML4KxXHyVhVzoN8wuVMNgk1dtT9/LroO7IcTKCPsdpwS3L/BXJZng8XR
	 AgRaWXP4+MQ4LYrkmTSfcy7JqZx+qavNdktJwbaGiVboVi+6Ppr2DGr076BA9+li9QNmZ
	 thU8l6OgItZJTEnP8RfiVDNDYO+u23O8vVLQfNb9ScdagpLOlECYumseaayxO2USeNA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E5C1E1F000CF;
	Thu, 26 Nov 2026 09:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683873;
	bh=oiNNwjdBTv3I2sP/KIV6AN3roKEbxe1M3OWyVa6uuEI=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=obdeg/0OkudBoQsR1zI0R17eHn6urypmA8RmIOVFnflFtcmlVeQ68WCnczB0ByN3Z
	 Faq03ZwGaV4bnVo6a8HFq5OaJLGSGK6mYocI+myhSy3mpzird74+g/fwgy5eqMmgmG
	 QUkl5uYrToIyPqhMHpNI58das99+pe0JLNYhk+hsUH9zQ8gZZCkKVrwh9zUw1V1pvC
	 TyCrsN6ddoWQG21pIbrd2E3pFp52GpSyk2aF2Kkcb+BTKZEOm6VEJT8dDpqQl5Go1X
	 He6Xs8yJIMRLrSQxwUYOkJzTpr2v1SwjJD8rgr3i6Y8gf+TsopNa5OdAoHAk6lyups
	 1n4g/yWiWx5Uw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 58AE24D2EF;
	Thu, 26 Nov 2026 09:04:23 +0000 (UTC)
From: Athira Palliprath via B4 Relay <devnull+palliprath.chromium.org@kernel.org>
Date: Thu, 26 Nov 2026 09:04:21 +0000
Subject: [PATCH] mmc: sdhci-pci-gli: GL9763E: Fix LPM ordering and restore
 hw settings on resume
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-gl9763e-lpm-ordering-v1-1-71ce1b4edb89@chromium.org>
X-B4-Tracking: v=1; b=H4sIABT2B2sC/x3MQQqAIBBA0avErBtII8uuEi1CRxswC4UIpLsnL
 f/i/QKZElOGuSmQ6ObMZ6wh2gbMvkVPyLY2yE4qIaRCH/SoesJwHXgmW3X0aOwwaKHdZIyESq9
 Ejp9/u6zv+wFV+96GZgAAAA==
X-Change-ID: 20261126-gl9763e-lpm-ordering-cd55919f8cc2
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org, 
 Victor Shih <victor.shih@genesyslogic.com.tw>, 
 Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
 Sven van Ashbrook <svenva@chromium.org>, Tomasz Figa <tfiga@chromium.org>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Athira Palliprath <palliprath@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795683862; l=5060;
 i=palliprath@chromium.org; h=from:subject:message-id;
 bh=ilN74LfM2q1x899iqprsDyA2jTJ6XG0MVTIisRfUF2o=;
 b=cyUkBRGqlhmcZaJl25I++lyHNnWQ1raS16OoKk+eV5P9gwX9m8f3RMX+nob4XCWVyXRDIpWeE
 MvnBje/PHiWBNIEKbmc8TzPeqfLSEm4UZ1lHE8J11hgj20CP80nLDGe
X-Developer-Key: i=palliprath@chromium.org; a=ed25519;
 pk=tumKET4w5oWCmHTf0TugEzwRThbeZ+jP/wMfBOM/w9U=
X-Endpoint-Received: by B4 Relay for palliprath@chromium.org/default with
 auth_id=1651
X-Original-From: Athira Palliprath <palliprath@chromium.org>
Reply-To: palliprath@chromium.org
Content-Transfer-Encoding: 7bit

From: Athira Palliprath <palliprath@chromium.org>

In gl9763e_runtime_suspend() and gl9763e_suspend(), LPM negotiation is
currently enabled before SDHCI/CQHCI MMIO register accesses finish, and
in gl9763e_runtime_resume() and gl9763e_resume(), SDHCI/CQHCI MMIO
registers are accessed before LPM negotiation is disabled. Because the
GL9763E has known hardware ASPM/L1 exit and replay-timer issues when
accessed while L1 negotiation is enabled, this ordering allows the
controller to enter L1 mid-transition and become inaccessible (0xffffffff
MMIO reads).

In addition, gl9763e_hw_setting() (which programs AXI_REQ, L1DLY,
HS400_RXDLY, and masks the AER replay timer timeout) is only executed
during probe and is not restored after D3cold or a controller reset.

Fix the ordering so LPM negotiation is disabled (and gl9763e_hw_setting()
is re-applied) before touching SDHCI/CQHCI MMIO on resume, and LPM
negotiation is re-enabled only after MMIO accesses complete on suspend.

Fixes: f9e5b33934ce ("mmc: host: Improve I/O read/write performance for GL9763E")
Fixes: 1202d617e3d0 ("mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix SoCs can suspend")
Fixes: 340be332e420 ("mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER")
Cc: stable@vger.kernel.org
Signed-off-by: Athira Palliprath <palliprath@chromium.org>
---
 drivers/mmc/host/sdhci-pci-gli.c | 56 ++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 66452ed8c..da3ee8b90 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -1880,13 +1880,13 @@ static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
 	struct sdhci_host *host = slot->host;
 	u16 clock;
 
-	/* Enable LPM negotiation to allow entering L1 state */
-	gl9763e_set_low_power_negotiation(slot, true);
-
 	clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
 	clock &= ~(SDHCI_CLOCK_PLL_EN | SDHCI_CLOCK_CARD_EN);
 	sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
 
+	/* Enable LPM negotiation only after SDHCI MMIO accesses complete. */
+	gl9763e_set_low_power_negotiation(slot, true);
+
 	return 0;
 }
 
@@ -1896,6 +1896,13 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
 	struct sdhci_host *host = slot->host;
 	u16 clock;
 
+	/*
+	 * Restore vendor PCI settings (lost across D3cold/reset) and disable
+	 * LPM negotiation before touching SDHCI MMIO registers.
+	 */
+	gl9763e_hw_setting(slot);
+	gl9763e_set_low_power_negotiation(slot, false);
+
 	if (host->mmc->ios.power_mode != MMC_POWER_ON)
 		return 0;
 
@@ -1916,9 +1923,6 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
 	clock |= SDHCI_CLOCK_CARD_EN;
 	sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
 
-	/* Disable LPM negotiation to avoid entering L1 state. */
-	gl9763e_set_low_power_negotiation(slot, false);
-
 	return 0;
 }
 #endif
@@ -1939,21 +1943,19 @@ static int gl9763e_resume(struct sdhci_pci_chip *chip)
 	struct sdhci_pci_slot *slot = chip->slots[0];
 	int ret;
 
-	ret = sdhci_pci_gli_resume(chip);
-	if (ret)
-		return ret;
-
-	ret = cqhci_resume(slot->host->mmc);
-	if (ret)
-		return ret;
-
 	/*
-	 * Disable LPM negotiation to bring device back in sync
-	 * with its runtime_pm state.
+	 * Restore vendor PCI config settings (AXI_REQ, L1DLY, HS400_RXDLY,
+	 * AER replay-timer-timeout mask) lost across D3cold/reset and disable
+	 * LPM negotiation before touching SDHCI/CQHCI MMIO registers.
 	 */
+	gl9763e_hw_setting(slot);
 	gl9763e_set_low_power_negotiation(slot, false);
 
-	return 0;
+	ret = sdhci_pci_gli_resume(chip);
+	if (ret)
+		return ret;
+
+	return cqhci_resume(slot->host->mmc);
 }
 
 static int gl9763e_suspend(struct sdhci_pci_chip *chip)
@@ -1961,28 +1963,26 @@ static int gl9763e_suspend(struct sdhci_pci_chip *chip)
 	struct sdhci_pci_slot *slot = chip->slots[0];
 	int ret;
 
-	/*
-	 * Certain SoCs can suspend only with the bus in low-
-	 * power state, notably x86 SoCs when using S0ix.
-	 * Re-enable LPM negotiation to allow entering L1 state
-	 * and entering system suspend.
-	 */
-	gl9763e_set_low_power_negotiation(slot, true);
-
 	ret = cqhci_suspend(slot->host->mmc);
 	if (ret)
-		goto err_suspend;
+		return ret;
 
 	ret = sdhci_suspend_host(slot->host);
 	if (ret)
 		goto err_suspend_host;
 
+	/*
+	 * Certain SoCs can suspend only with the bus in low-
+	 * power state, notably x86 SoCs when using S0ix.
+	 * Re-enable LPM negotiation to allow entering L1 state
+	 * only after CQHCI/SDHCI MMIO suspend accesses finish.
+	 */
+	gl9763e_set_low_power_negotiation(slot, true);
+
 	return 0;
 
 err_suspend_host:
 	cqhci_resume(slot->host->mmc);
-err_suspend:
-	gl9763e_set_low_power_negotiation(slot, false);
 	return ret;
 }
 #endif

---
base-commit: d2616724e01132376c78872b8324f38659af9f28
change-id: 20261126-gl9763e-lpm-ordering-cd55919f8cc2

Best regards,
-- 
Athira Palliprath <palliprath@chromium.org>


