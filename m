Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793247512;
	b=tNiNTWCCTRl7ZEph+hhKpgOUPsFxb3pQrqhcPeW8n/QDVzAGoLEidTya8jDsXp0ZYvjV
	 hsV+CnkApV/BIZNYQmzForVzEm9LulTkND9Q0/CrGCavyO/BUKOiEcn4RwrJta3XGB7rT
	 EBbtmLXLsiKJTKOyvcaU60WxSeaQk9V8Tbr4td4BRfZvLp8bNRwgpsfV9dNxVQDaa3+5T
	 X2nsoc9pO+7G2hYqMvSfF9L4MaYW093nMSQsY2HHfWECv5uGgi/GDMEZ1qS8ZA0/R1M5Z
	 RGnA+9Fc8/qVFffPd9H1G66EEqqtp5foI+aE6ig/ib7SIapCJitrh71EikGzgZWWnuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793247512;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=IUSnrfCaWJwxjkS74oOIrmmdaMLt7r4a4zA1tolg5lU=;
	b=RLvMV5vd3CbbAencjr04j9k1+CgjdsCAF30nnUyeBe5dNAw9A33YVq9CY5eBnUrM43Vx
	 YOf1gdhjR+9M/H5iO99AAF/vDoP3SUK/HU3cdZvDyphLrvueqlaiD/kraaORQ2vUnfT/R
	 jTzwtj3C6XjM49CNm0s557xEDNpCefJ++pF1uvB6/Ub3wa75slEozuE5CGX+plA8/LQyQ
	 m0cXch+GIgYSPU3/LhpVUxzGTVsvWF7iMqTmQ4h4FsGl1v0Kw3nZ/Rtx7b33pMaM0x6nu
	 d4t6U4gW4FzRWSJvUHbDCGm4aaG1MBtOHsa6KJ7m6dWbt8yFa7spUn4C/nZbOSdX1LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=PM2jtbVB;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F7A606A31E;
	Thu, 29 Oct 2026 04:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64F7A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=PM2jtbVB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=IU
	SnrfCaWJwxjkS74oOIrmmdaMLt7r4a4zA1tolg5lU=; b=PM2jtbVBMhoCCKO5c+
	xd6Wia5b25nA7LnyX17UiIU3vw0qwT3nE0A61IyN04zMfIsFfbYaOvhO+lESYII1
	uHckNBpViJXmVjw9u/Oo00wrDWY5rNtuKEGAL3kMZKL+hvJ/sJZKnt+C8ktikHzK
	9g4OJibmdTwUNGuKCEhA3BvmI=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3nzIDyeJqQW5fDg--.62716S3;
	Thu, 29 Oct 2026 12:18:12 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 1/5] wifi: ath11k: validate DMA buffer release TLV lengths
Date: Thu, 29 Oct 2026 12:18:07 +0800
Message-Id: <20261029041811.2379878-2-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029041811.2379878-1-yaojiale02@163.com>
References: <20261029041811.2379878-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3nzIDyeJqQW5fDg--.62716S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4UJr47Wr4xur1UWF17Wrg_yoW8Xr4DpF
	48WwnrCw1xXrs7Gwn3ua1fZayYkanag3y3KFW0y34fuF48CF15JFWYqFWYvFyrtr18tFyS
	vF4jgr15Ar1qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMUDAUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgTGAWriyQT-OgAA3N

The DMA buffer release parser counts nested entry and metadata TLVs, but
does not ensure their payloads cover the structures later indexed by
the direct buffer ring handler.  Short firmware TLVs can therefore lead
to out-of-bounds reads when the arrays are consumed.

Add minimum-length policies for both nested TLV types.

Fixes: 9d11b7bff950 ("ath11k: add support for spectral scan")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 08fd6795ed9e..ef2c2c300854 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -161,6 +161,12 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_p2p_noa_event) },
 	[WMI_TAG_PDEV_CSA_SWITCH_COUNT_STATUS_EVENT] = {
 		.min_len = sizeof(struct wmi_pdev_csa_switch_ev) },
+	[WMI_TAG_DMA_BUF_RELEASE] = {
+		.min_len = sizeof(struct ath11k_wmi_dma_buf_release_fixed_param) },
+	[WMI_TAG_DMA_BUF_RELEASE_ENTRY] = {
+		.min_len = sizeof(struct wmi_dma_buf_release_entry) - TLV_HDR_SIZE },
+	[WMI_TAG_DMA_BUF_RELEASE_SPECTRAL_META_DATA] = {
+		.min_len = sizeof(struct wmi_dma_buf_release_meta_data) - TLV_HDR_SIZE },
 };
 
 #define PRIMAP(_hw_mode_) \
-- 
2.34.1

