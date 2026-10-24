Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858883;
	b=r6SvzPExfDlzOLpVQJZPeJzkFBO6+qnguu6nEKXFqFpcxBx6uqexS4pm1VAAcUX3NLyI
	 Ko0Ozez78FBg0eH7Ht6NpZVPLw2gnOol2tsiIGlFBNjxa+nbEGDB3WPfIhjoHtZ6QvceG
	 5BIGW4IXcTB5PcpDy8B71ahGnW0xYwlXBRyU7KObWemCI8Uht9cnWWrTxKWNDL34ghhV4
	 QuXirvbmwUB69PjLH1B4/aBMAmKqkifrvW/7gHNwUduftzwtjkEinfOrelp9Cd+X4mnhx
	 gEuQrAsC9Qqo1Xuv4d6vyzNzVwmIoP6xCe1wArSO0rqzvZH7Tv6ftubraSFM9/JmDoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858883;
	h=DMARC-Filter:From:X-Lima-ML-UUID:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=nY9jehEWtuIUIlmdDSHHvShTUgJESBkHD61RsCl8NPY=;
	b=MGUisunzW88F9IpHjf8lfDBg904+421mqiaEhSrPznWXEf5EWD8P8Gy3/Sj6vCIY4ha1
	 5pTIagOP/VTb/tvdSLjLAxRq6qAqRezjvFlHSsqNQmdYj/WtJ0Y5v+sO6C8cmeoYG2HpU
	 ta+YPToNj0T2lJWRVfS4k21v45FL2qS9O7E4P4d8mDIsUiPvjG+GuaNUVhXswEMDTZSQB
	 mV0MHQJkvZsquWWzPisdrAwFcOvjrQTHEubgA6coutXWDkzCMill5huINbWV2RnTZC0SE
	 FlaCkE8dykCGQEuTVwTVRwIzpdv7zFd6KW9VNampvEIb5oMuHegPFMuU8qVz61+ferQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=gzcyrfN+;
	arc=none smtp.remote-ip=91.216.248.207
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E323606A31F;
	Sat, 24 Oct 2026 16:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E323606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=gzcyrfN+
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: 058fab7f-7490-4316-b2a6-b06f24c3fce8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1792858872;
	bh=4yRUaUcZJ7NVfl/ojp5ovKj0o5QzSmiM/G82y808yXo=;
	h=From:To:Cc:Subject:Date:From;
	b=gzcyrfN+SohEVnOopB1lpmVXh9mJMOjMuc8ZyFDiB5QP4e2fXg7HSPbCdvYkxr1Iy
	 MUsU/R/9Wr9+uine925Mjg74u5+Vu3mlm8yVbxjG9HcyNsz+VuMIXlKoKmAwCzhx4n
	 Nsz2Qcml9udIpHmkXPNfdHvRWG/jFZr18vVRGlYQQWsTV0b/KtBTLME470Gj33wPRB
	 vjMJ5SI+osZXpsFI3gwbd1nXb8UflsWb7iLs/vr6lSCCmYlzwWexWcC6XaOqjaCv/z
	 6i/FBbfnUqye4e2QWljP15NYsL2sM/1k+ayQajlcdH8MUkTJaJIDnjHzXQ2RP3fF/x
	 dVGeWIHeSx5sA==
To: amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Andre Eikmeyer <dev@deq.rocks>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amd/pm: use the VBIOS trained UCLK levels on the MacBookPro16,1
Date: Sat, 24 Oct 2026 18:21:09 +0200
Message-ID: <20261024162109.307247-1-dev@deq.rocks>
X-Mailer: git-send-email 2.56.0
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

The Radeon Pro 5300M and 5500M of the MacBookPro16,1 (Navi 14 boards
1002:7340/106b:0210 and 1002:7340/106b:020f) stop answering SMU messages
as soon as UCLK switches into its third level. This happens at boot or
at the latest under dGPU load and ends in a CPU CATERR that resets the
machine.

Apple's VBIOS trains the UMC p-state sets at 95, 496, 598 and 736 MHz
(umc_info v3.3), but its pptable lists 95, 496, 736 and 750 MHz. Level 2
then runs 736 MHz on a set trained at 598 MHz.

Take the UCLK levels of these boards from umc_info.

Tested on three MacBookPro16,1, two with the 5500M and one with the 5300M.

Cc: stable@vger.kernel.org
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 2d0508861..63b773252 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -470,6 +470,60 @@ static int navi10_store_powerplay_table(struct smu_context *smu)
 	return 0;
 }
 
+static bool navi14_needs_trained_uclk(struct amdgpu_device *adev)
+{
+	struct pci_dev *pdev = adev->pdev;
+
+	return pdev->vendor == PCI_VENDOR_ID_ATI &&
+		pdev->device == 0x7340 &&
+		pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
+		(pdev->subsystem_device == 0x020f ||
+		 pdev->subsystem_device == 0x0210);
+}
+
+/*
+ * The pptable of these boards lists other UCLK levels than the VBIOS trained
+ * the UMC p-state sets at, and the SMU hangs switching into such a level.
+ */
+static void navi14_use_trained_uclk_levels(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+	struct atom_umc_info_v3_3 *umc_info;
+	uint16_t trained[NUM_UCLK_DPM_LEVELS];
+	uint16_t size;
+	uint8_t frev, crev;
+	int index, i;
+
+	if (!navi14_needs_trained_uclk(adev) ||
+	    pptable->DpmDescriptor[PPCLK_UCLK].NumDiscreteLevels != NUM_UCLK_DPM_LEVELS)
+		return;
+
+	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+					    umc_info);
+	if (amdgpu_atombios_get_data_table(adev, index, &size, &frev, &crev,
+					   (uint8_t **)&umc_info) ||
+	    frev != 3 || crev != 3 || size < sizeof(*umc_info))
+		return;
+
+	for (i = 0; i < NUM_UCLK_DPM_LEVELS; i++) {
+		trained[i] = le32_to_cpu(umc_info->pstate_uclk_10khz[MAX_UCLK_DPM_LEVEL - i]) / 100;
+		if (!trained[i] || (i && trained[i] <= trained[i - 1]))
+			return;
+	}
+
+	for (i = 0; i < NUM_UCLK_DPM_LEVELS; i++) {
+		if (pptable->FreqTableUclk[i] == trained[i])
+			continue;
+		dev_info(adev->dev, "UCLK level %d: %u MHz -> %u MHz, as trained by the VBIOS\n",
+			 i, pptable->FreqTableUclk[i], trained[i]);
+		pptable->FreqTableUclk[i] = trained[i];
+	}
+
+	pptable->DcModeMaxFreq[PPCLK_UCLK] = min(pptable->DcModeMaxFreq[PPCLK_UCLK],
+						 trained[MAX_UCLK_DPM_LEVEL]);
+}
+
 static int navi10_setup_pptable(struct smu_context *smu)
 {
 	int ret = 0;
@@ -482,6 +536,8 @@ static int navi10_setup_pptable(struct smu_context *smu)
 	if (ret)
 		return ret;
 
+	navi14_use_trained_uclk_levels(smu);
+
 	ret = navi10_append_powerplay_table(smu);
 	if (ret)
 		return ret;

base-commit: 77f548b127c6de34ce271fa09ba270cb1ef9f2da
-- 
2.56.0

