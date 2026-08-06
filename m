Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B039D3C0
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024181; cv=none; b=mWQQHdFd7O35G7xGQECwcXAwzrFegtTdaJ7JZTVmtpG7XPee15ZveAQVjXikJcMeaeLmHnshJtQiRIIx97dtA4MCJ0fJd5ToYxzpHcoGRK2rCDy7TPEQqMaVaxUoedMW3jQkaVP/7k6uHg038PerGSQZ3J2IHvrAB5jxletGOtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024181; c=relaxed/simple;
	bh=7TE+xl0pW3Ag1BkkwybFp7BMhiRlhG8cRYHSR8tQ/4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tb/jx5nz2hvm+KmrgGDJcPWJjcm7SVAwuUjAElSUzdZ9ESJik3I21ny/phLpo86yeJIJj3GqRIStUee+fA37sI0BeGz/BAeMiMY1GPuM12XQ5gMI5Nr5+F7DqWywZAgES6+S1CVgl6iAy6GJHNfWdsVL9lm4q0Rfl4JBvUC9sG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzi48L1w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzi48L1w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3311F000E9;
	Thu,  6 Aug 2026 13:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024180;
	bh=5G5i1BIyOsis0B6clvqxuBUtU06mZdlthb0ms7CSe00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lzi48L1wRdPVHRbtFuvj3jFNffKq6N2cuM9RSrh48O+ST+dntHvIyDH+FJyYRtXkE
	 9ldxr+ekxuFN0QoA5j/YoErSp9EHkLxjO2praRlVUO3ZaxhpbMupZ217VT6yIJiYE4
	 vmDz2wD7fkZS8bZVU9gxFak1rokP7MFFicTI4U1zmotW8UQ4Lg5sHh+FDtaQZIfS1q
	 pDM1SRz5C1rq3+iyTfY9VJyAVXFbf9q+WOFepwdhD2R0RlcdzOvxexWRlu1rIc7SMS
	 pu/CQtPL1l8Z+qlo2Zp1zeq13QqhImkYp7RgYJXW9g6agScJ049E46kpD1piA8k4yK
	 Ut51CkqWMJy1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] wifi: brcmfmac: fix 43752 SDIO FWVID incorrectly labelled as Cypress (CYW)
Date: Thu,  6 Aug 2026 09:49:36 -0400
Message-ID: <20260806134937.599576-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072949-jawline-chastise-9c85@gregkh>
References: <2026072949-jawline-chastise-9c85@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>

[ Upstream commit 74e2ef72bd4b25ce21c8f309d4f5b91b5df9ff5b ]

Cypress(Infineon) is not the vendor for this 43752 SDIO WLAN chip, and so
has not officially released any firmware binary for it. It is incorrect to
maintain this WLAN chip with firmware vendor ID as "CYW". So relabel the
chip's firmware Vendor ID as "WCC" as suggested by the maintainer.

Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
Fixes: f74f1ec22dc2 ("wifi: brcmfmac: add support for Cypress firmware api")
Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Link: https://patch.msgid.link/20250724101136.6691-1-gokulkumar.sivakumar@infineon.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: 29ab31f3f271 ("wifi: brcmfmac: set F2 blocksize to 256 for BCM43752")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c   | 4 ++--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   | 8 ++++----
 .../net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 2 +-
 include/linux/mmc/sdio_ids.h                              | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index cfdd92564060a..73a084401a0c2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -991,9 +991,9 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4354, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4356, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4359, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43752, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012, CYW),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359, CYW),
 	CYW_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439, CYW),
 	{ /* end: all zeroes */ }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 4dbb1898f3065..e3a01a28a1820 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -738,7 +738,7 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_priv *ci)
 	case BRCM_CC_4364_CHIP_ID:
 	case CY_CC_4373_CHIP_ID:
 		return 0x160000;
-	case CY_CC_43752_CHIP_ID:
+	case BRCM_CC_43752_CHIP_ID:
 	case BRCM_CC_4377_CHIP_ID:
 		return 0x170000;
 	case BRCM_CC_4378_CHIP_ID:
@@ -1465,7 +1465,7 @@ bool brcmf_chip_sr_capable(struct brcmf_chip *pub)
 		reg = chip->ops->read32(chip->ctx, addr);
 		return (reg & CC_SR_CTL0_ENABLE_MASK) != 0;
 	case BRCM_CC_4359_CHIP_ID:
-	case CY_CC_43752_CHIP_ID:
+	case BRCM_CC_43752_CHIP_ID:
 	case CY_CC_43012_CHIP_ID:
 		addr = CORE_CC_REG(pmu->base, retention_ctl);
 		reg = chip->ops->read32(chip->ctx, addr);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index a1b2614460769..772179addc0c6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -654,10 +654,10 @@ static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_4354_CHIP_ID, 0xFFFFFFFF, 4354),
 	BRCMF_FW_ENTRY(BRCM_CC_4356_CHIP_ID, 0xFFFFFFFF, 4356),
 	BRCMF_FW_ENTRY(BRCM_CC_4359_CHIP_ID, 0xFFFFFFFF, 4359),
+	BRCMF_FW_ENTRY(BRCM_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752),
 	BRCMF_FW_ENTRY(CY_CC_4373_CHIP_ID, 0xFFFFFFFF, 4373),
 	BRCMF_FW_ENTRY(CY_CC_43012_CHIP_ID, 0xFFFFFFFF, 43012),
 	BRCMF_FW_ENTRY(CY_CC_43439_CHIP_ID, 0xFFFFFFFF, 43439),
-	BRCMF_FW_ENTRY(CY_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752)
 };
 
 #define TXCTL_CREDITS	2
@@ -3425,8 +3425,8 @@ static int brcmf_sdio_download_firmware(struct brcmf_sdio *bus,
 
 static bool brcmf_sdio_aos_no_decode(struct brcmf_sdio *bus)
 {
-	if (bus->ci->chip == CY_CC_43012_CHIP_ID ||
-	    bus->ci->chip == CY_CC_43752_CHIP_ID)
+	if (bus->ci->chip == BRCM_CC_43752_CHIP_ID ||
+	    bus->ci->chip == CY_CC_43012_CHIP_ID)
 		return true;
 	else
 		return false;
@@ -4274,8 +4274,8 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 				   bus->hostintmask, NULL);
 
 		switch (sdiod->func1->device) {
+		case SDIO_DEVICE_ID_BROADCOM_43752:
 		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
-		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752:
 			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
 				  CY_4373_F2_WATERMARK);
 			brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index 44684bf1b9acc..2f886af068c5b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -52,13 +52,13 @@
 #define BRCM_CC_43664_CHIP_ID		43664
 #define BRCM_CC_43666_CHIP_ID		43666
 #define BRCM_CC_4371_CHIP_ID		0x4371
+#define BRCM_CC_43752_CHIP_ID		43752
 #define BRCM_CC_4377_CHIP_ID		0x4377
 #define BRCM_CC_4378_CHIP_ID		0x4378
 #define BRCM_CC_4387_CHIP_ID		0x4387
 #define CY_CC_4373_CHIP_ID		0x4373
 #define CY_CC_43012_CHIP_ID		43012
 #define CY_CC_43439_CHIP_ID		43439
-#define CY_CC_43752_CHIP_ID		43752
 
 /* USB Device IDs */
 #define BRCM_USB_43143_DEVICE_ID	0xbd1e
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 7cddfdac2f576..8fb8e7e87f6ef 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -76,7 +76,7 @@
 #define SDIO_DEVICE_ID_BROADCOM_43430		0xa9a6
 #define SDIO_DEVICE_ID_BROADCOM_43439		0xa9af
 #define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
-#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752	0xaae8
+#define SDIO_DEVICE_ID_BROADCOM_43752		0xaae8
 
 #define SDIO_VENDOR_ID_CYPRESS			0x04b4
 #define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439	0xbd3d
-- 
2.53.0

