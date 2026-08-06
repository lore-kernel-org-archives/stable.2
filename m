Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33953093DB
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041733; cv=none; b=MImsBVMuihmXESsfcB33HHVrAy6gWPGXVY4c1MM6C2jTHLK01SLcT5jBthTOzRs8o9Kv5JHnICLwEq9a88BSQgxu9diPqkPTmIie5vZoiKQUP+4js5Q+Hw5ddevHGjUdeBbhfPhF99JhQZabXTPtXWXG8BRQQQ5jRkAvZ4e+zNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041733; c=relaxed/simple;
	bh=5ZxmqJoOK+TWxxaq8IcO4URehz4C7ayerF6x8sCgXis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJWawwgxbZLGpXnqzO3p60dCksHFotpm/tjCXMMoY7i/qGuB3GbIKa8pmAkf/MloYtBpt1uLQKjNnK/41bSMoJvSN6gDZucQb/tCvnjLfEWMkfBQ1n2A/agxSZ68nip0gxiERhjat1GddI8tNWE4Mlnp5ob5VL3i9o5oVDODwOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg3jaqNX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg3jaqNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA56D1F000E9;
	Thu,  6 Aug 2026 18:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041731;
	bh=OP4Jgp8bJqalGRAS5PggVW7GNeslPG8B2toet6jaZnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jg3jaqNXY5Mn0r9x6TdLRkUQnXCYyVMHbuXtle8WYdzDKLqGf3eVvgfudM4pl2yfq
	 XqPsWrTWLkrzG4V+f6bxQYbj5epfckg6QStGAakyd5LGhtpoGF8h0P/pmsAtvr3kG7
	 eG282/9VSKyxd3svn+4DEkHagjlZ1EiiT7h75TMOG561tZPsEOjTdloKke0KPK5BYf
	 Y+hxlqhZeHSneecFDiuQVJ59c9HwjWYLt5BUQ10UMEHP0Lsp9yHRXQbOQyrZn0AH1P
	 yMlgFBw3b0FimFPpXatR/j84m9MeG3/vb9K8n5noQg++y69DBVXmgVK4cEClUHvEIK
	 Rn942wFE+2h9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] wifi: brcmfmac: fix 43752 SDIO FWVID incorrectly labelled as Cypress (CYW)
Date: Thu,  6 Aug 2026 14:42:08 -0400
Message-ID: <20260806184209.1445690-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072950-reanalyze-suffrage-96ff@gregkh>
References: <2026072950-reanalyze-suffrage-96ff@gregkh>
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
index 16c46845566ef..58b2c7d0f7ed2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -989,9 +989,9 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4354),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4356),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4359),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43752),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359),
 	{ /* end: all zeroes */ }
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 76b2953725c2d..20016c60af5cc 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4270,8 +4270,8 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 				   bus->hostintmask, NULL);
 
 		switch (sdiod->func1->device) {
+		case SDIO_DEVICE_ID_BROADCOM_43752:
 		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
-		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752:
 			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
 				  CY_4373_F2_WATERMARK);
 			brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index a85c9f0bd4708..06eb9e1d724ce 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -75,7 +75,7 @@
 #define SDIO_DEVICE_ID_BROADCOM_43364		0xa9a4
 #define SDIO_DEVICE_ID_BROADCOM_43430		0xa9a6
 #define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
-#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752	0xaae8
+#define SDIO_DEVICE_ID_BROADCOM_43752		0xaae8
 
 #define SDIO_VENDOR_ID_MARVELL			0x02df
 #define SDIO_DEVICE_ID_MARVELL_LIBERTAS		0x9103
-- 
2.53.0

