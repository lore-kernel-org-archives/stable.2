Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793247511;
	b=oB5yv0KLCk+9M2R8n687ere6QAONaolB4rjIRFxWePc6gN9olg/sFjf63hbrRPCmmZgh
	 GfmxPg0xX3AEwQU8RxlBsz/orobosEKfZSEwg/eTNJM7BCpBUUDRgZq0qAQPrZ5o/u49M
	 O0ODA91v/iIx9frHQh3xM5icebbW3mlELQrfhUvg0gejrenHXiFhf8c5WfL2gafCbMv3i
	 I/8u4Svu1lsISxiLsnHaAnB9HyagU1lGJz55UC4xhTRuVjQrjdXNsct/5LWoJqjtyS5BA
	 ZYLFr+cWBqnim4eiRzyeRlL+yvdbjW6EazlO9bEID2769gQ71IDsrNQKpbxm535G3Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793247511;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=QGAW60ly4dJn3r9jBzjnajf80vcBLeMOp3uPKg7LNrQ=;
	b=Wc7vPPXlY8jQgw9SwMNuj81DHhU52OIVG4RZN8xK9fG/gBMAt9SIjFmb8E8iISXMc3SK
	 /SwKDjYMUsYNkedPFkdVmCp3ApsBEs31J0KYFxlcCN1dK0u2NB1yLaiTmGKwIN7K+wyGj
	 7OTXO4DUtYXjiECDDR7AjiGlGiutkIphX+hzZRgmvNZvCEHJGLwlnalD/RBFntNH3n/jV
	 Bo1OO9W1CSklUGirKzmYuzrKpq0CH154++dprnfc9t5N3mPh/5+BMqRaTZVHbI9dRBW0/
	 +HGHf9AHDJx4uAmemAjqw3kIpt736lXTmSGP6RIHRVIJft0wzworhk+q8muLjG785qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=aNV352Zy;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E12606A329;
	Thu, 29 Oct 2026 04:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68E12606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=aNV352Zy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=QG
	AW60ly4dJn3r9jBzjnajf80vcBLeMOp3uPKg7LNrQ=; b=aNV352Zya6qwmFZMoA
	Fqec2fClT87pXiZ8EckPOTGu1NKQecYVkrkgoR4MxDQ55pLkrs+gWOrVZ5AIQ15f
	9U8wDuDtJLoLNFcZM0tjb9oIdrpsdzB5x3VGIW6LXUux3MzqzC04w+8mlNpZlwnl
	MnAiTXMZegXuswsXyuC4FGR+I=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3nzIDyeJqQW5fDg--.62716S5;
	Thu, 29 Oct 2026 12:18:13 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 3/5] wifi: ath11k: validate DMA ring capability TLVs
Date: Thu, 29 Oct 2026 12:18:09 +0800
Message-Id: <20261029041811.2379878-4-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3nzIDyeJqQW5fDg--.62716S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7XFyUWFyDWw15WFyDAFWDurg_yoW8Jr43pF
	4Ig3W7C34rXr47Jw1fJa1xZa45K3Z5t3yakFWUJ34fWa1kCF1rJFyYqFWYvFyrJF4UGFya
	qFWqgrW3AF98t3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTxRDUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wXGAWriyQXt+QAA39

The service-ready parser counts DMA ring capability TLVs and later
indexes the firmware array using the full structure stride.  It does not
validate that each TLV payload covers that structure, so a short element
can cause out-of-bounds reads.

Add a minimum-length policy for DMA ring capability TLVs.

Fixes: bd6478559e27 ("ath11k: Add direct buffer ring support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 047ae8f5bb60..4cf5f57a93e1 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -169,6 +169,8 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_dma_buf_release_meta_data) - TLV_HDR_SIZE },
 	[WMI_TAG_HW_MODE_CAPABILITIES] = {
 		.min_len = sizeof(struct wmi_hw_mode_capabilities) - TLV_HDR_SIZE },
+	[WMI_TAG_DMA_RING_CAPABILITIES] = {
+		.min_len = sizeof(struct wmi_dma_ring_capabilities) - TLV_HDR_SIZE },
 };
 
 #define PRIMAP(_hw_mode_) \
-- 
2.34.1

