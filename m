Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793247511;
	b=HXh6jXcKJxdDlTgyZCxaULEXSELFdo4ATjsrbcR8APY18BK87wfS/wiRLqvKOPI0YkIM
	 9UnoZa020kNmjTAgEs6WMXeqc6GOlhQS6APNJ4wza81mFuL9zo5Dn3uRIs50YDV7RR6U0
	 XsjvtOXO/Svq9fTCt4wne+TEfA/vNi1lOqeUByh95N8m3zsPV2ZZuL3sQLm8iEpyNlEW6
	 kuw3jccbqVNEMiD/UC9A4W6k6R70RrzhcgB0aTGrHp8MHTx9iRJcoucrDj7SY3z5b8W3d
	 3U7p/a8axj7bsxupKsaz65aBNQAif/vv5gUXkr45XQ8h4mG4sHT9oWZrZxYNwLv7SDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793247511;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=9eDZ1tyXFZupu+NBPF56Dz9t7vnEPEkY79v4CEYA78k=;
	b=jZjJ0RcdX0dgGH4VHwyEZCsJKZgWp+IPbOZrLUxaGaYk/YEVpCyrdN/IW/6BcOAu+1Yu
	 1Ih/5BXG4dvKvSFSnbmrfzHxZN9LnSsOYE1KR2r5yMZsuf5yu3O7D7Lx9OTg8zeu2iPwk
	 vyDesVKmH6UJqe5meXYva5pGMWfWGDmLV+mv9pKW22ZcmfBRZ4q+QvtwiaCk4aWOmOgIc
	 7Vx3k/LkDPtHJ5e7084Fi1J6rEALLygA1NKmm9ONLsCQTn8LNzjjJpz4oOjiW35vtHRuu
	 m8t3aTpOWYVWTzsO4a/nnT9/U3MqYmFNJQIq38qJE3EKVbI3h4T9/6Np8mTzWRKqTrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="m/tFNfMJ";
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA90606A31D;
	Thu, 29 Oct 2026 04:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDA90606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=m/tFNfMJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9e
	DZ1tyXFZupu+NBPF56Dz9t7vnEPEkY79v4CEYA78k=; b=m/tFNfMJMY54Tccop+
	gTW1MusOgvZuQw8toDZ0F5peh2VCPg5TLbX2Ejn2ob4jDJ/OJX3OW3LFx+U9qhiK
	QnnN2m8Tyav4qp2G+vVUriPpdYhyAivPrsDRoIW+i0gkHAM1CHCE0faF1wr8EafF
	pBYtk68V5cGqps+SxttIE/lak=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3nzIDyeJqQW5fDg--.62716S6;
	Thu, 29 Oct 2026 12:18:14 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 4/5] wifi: ath12k: validate DMA buffer release TLV lengths
Date: Thu, 29 Oct 2026 12:18:10 +0800
Message-Id: <20261029041811.2379878-5-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3nzIDyeJqQW5fDg--.62716S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFW3uFW5WF1DArW7Gr45Jrb_yoW8WrW3pF
	4fWw12k348CrsrWwn3Zw4xZa4Ykan3W347KFWxt34fua1rCr15tFyYgFWYvFyYyr1rtr12
	9a1jgr4fArn8trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UROJOUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wbGAWriyQbuDAAA3L

The DMA buffer release parser copies fixed parameters and counts nested
entry and metadata TLVs. It does not ensure that their payloads cover
the complete structures later read by the parser and direct buffer ring
handler. Short firmware TLVs can therefore lead to out-of-bounds reads.

Add minimum-length policies for the fixed TLV and both nested TLV types.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 75b259990c79..0109f56fd429 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -209,6 +209,14 @@ static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_obss_color_collision_event) },
 	[WMI_TAG_PDEV_CSA_SWITCH_COUNT_STATUS_EVENT] = {
 		.min_len = sizeof(struct ath12k_wmi_pdev_csa_event) },
+	[WMI_TAG_DMA_BUF_RELEASE] = {
+		.min_len = sizeof(struct ath12k_wmi_dma_buf_release_fixed_params) },
+	[WMI_TAG_DMA_BUF_RELEASE_ENTRY] = {
+		.min_len = sizeof(struct ath12k_wmi_dma_buf_release_entry_params) -
+			   TLV_HDR_SIZE },
+	[WMI_TAG_DMA_BUF_RELEASE_SPECTRAL_META_DATA] = {
+		.min_len = sizeof(struct ath12k_wmi_dma_buf_release_meta_data_params) -
+			   TLV_HDR_SIZE },
 };
 
 __le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len)
-- 
2.34.1

