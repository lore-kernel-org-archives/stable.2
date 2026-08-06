Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E16480DE3
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035736; cv=none; b=joHTekBagrC6iQ8HS7gbbrSO6J30cu+O0PkMNF1SCbrxJgKNl4oy2pMwFN+bIH55h//c0PV18jxuv1nS+To0vw+jPmFMjHqwjwvZEUo2HXXoETnux868oyLXKYjTiGhS+EczlOCsWF39Flkwgcycg41JwxeybiQI9ppHi+7Qzew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035736; c=relaxed/simple;
	bh=yNaUoKDGyXzl9mgowEdfKv6A1m3F80195aPxugJrWFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kl/RG7Xjje5E01k1kzW8MRVOkofoDPvKEYfSBr0CAazecITKziIRwVN5MIRMByk3KRkwhcbItDY2ZqiHuArzQJacnwjL/VRPAxAU5JovRAltNNu1Yj/R667ObAgq3/cMdgKirwmK9vI1DV3hsIlNKSm+oKYQVp88mJugjFlwrW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jijHk2Z2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jijHk2Z2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4491F000E9;
	Thu,  6 Aug 2026 17:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786035732;
	bh=q73N1bIrOfpjjIFtsnHudkNUeQks8pZ1anqeFY0e3Yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jijHk2Z2qECiJdLM+nP7usi0iSIRgsuGGGajQN1qxyMIOdgQ+2oIQowJi02XBNNWk
	 r9kMRxq7BZclZowlm7i0kkUzSXIwpVEHnYdH3eIYxUkw4kjQBh0SnFE8Yvqws2Gllc
	 n7MinZ3Z/AOJ2lMOEpKUjB4R//YDFkYVxQcpHJJJBDGf6eadMr5NikY2q5mzMx9duE
	 MrKNFKyFL6ZKPz+66aQT+UDwnE6b+fwh8KAreH1gbDmmtG6nBPJA1lnT4zyLDhALaV
	 bboKY1Mzg2GBJvGDfNaxMjU3cA1U9UX9l2TGHMKWwSG9sSqr9qpM0RBrwgNiPDKXtd
	 1hkYomeZclz5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] wifi: brcmfmac: fix 43752 SDIO FWVID incorrectly labelled as Cypress (CYW)
Date: Thu,  6 Aug 2026 13:02:08 -0400
Message-ID: <20260806170209.1187447-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072950-scribing-blooming-1fda@gregkh>
References: <2026072950-scribing-blooming-1fda@gregkh>
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
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   | 2 +-
 include/linux/mmc/sdio_ids.h                              | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 7cd8ec6f515a4..252160f7ffd2b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -981,10 +981,10 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4354),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4356),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4359),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43752),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359),
 	{ /* end: all zeroes */ }
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 5f6c0afe22d49..caac171175a67 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4267,8 +4267,8 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 				   bus->hostintmask, NULL);
 
 		switch (sdiod->func1->device) {
+		case SDIO_DEVICE_ID_BROADCOM_43752:
 		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
-		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752:
 			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
 				  CY_4373_F2_WATERMARK);
 			brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 0e4ef9c5127ad..3628f89f04894 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -76,7 +76,7 @@
 #define SDIO_DEVICE_ID_BROADCOM_43430		0xa9a6
 #define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439	0xa9af
 #define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
-#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752	0xaae8
+#define SDIO_DEVICE_ID_BROADCOM_43752		0xaae8
 
 #define SDIO_VENDOR_ID_MARVELL			0x02df
 #define SDIO_DEVICE_ID_MARVELL_LIBERTAS		0x9103
-- 
2.53.0

