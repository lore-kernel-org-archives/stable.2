Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164414;
	b=GHibZzqYhFNZB83Ts/nCfoCWtM9Ij8C7YYbsykfT+e0bWi9OmyrOGjUlVYpKjEdXDVqv
	 hMPwFclvJz+I2b3+2STRNrZyanmUnHfVd86Snf4D5fDUVxY3jPXpljslw5SE0g598kfYi
	 YBWsHN4EGZ9mE0bn9VpEUd/pLqNRjTto5wVYsRGsq38UMcHk7TGsRwnK1ykMkj080rTDz
	 zmrF8bJ2z9ARY43iDYDKnwcBe7IGgL0tRnVk86p3/AlRf88Y26CyZBvyGUdJRJzEUZvlx
	 cT9cVLClGbrGll08vBoFiYpmLVa3mbO/OPwqhsvpr9T7PFF87ArkstlGGTgEWjucqgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164414;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=sh0jjqvJiEPcXO2T9p933jIcQss8YBNUV3WFM1iJF54=;
	b=Ov9RtAHK1P6/GKsexXBaUAu5ruUw/mmTwVCsB8KdgEnxJ1ajy+DKqxeL6Ul3JnhNnNYp
	 g6WuCwQXXI9nUEfWlVhUSzx4io2sTQ7MPIOl1eC1ukQd4ihORsNJRKXmpnyavGBrMkSxt
	 M++JmKE4Ya7KynWXret8L/yYo/KknE1WmMM73qv18E9KrGwsraoBTcG77cIdNdpRPJaxQ
	 +X9HCUzDCF/3MfxC82WiVLcS7vkHGMYnVyXU4oAirA98OEkm2VJlBHGl/15CYXJrBkncI
	 P3MuTrxBepA2ZYXgf5pk0K866TbwLfZECah8wLIWm0x0tp5cDp0csv0CQV2942ADNcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="Ln/i3jtP";
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76F860A2616;
	Wed, 28 Oct 2026 05:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C76F860A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Ln/i3jtP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sh
	0jjqvJiEPcXO2T9p933jIcQss8YBNUV3WFM1iJF54=; b=Ln/i3jtPT9Marz4A63
	bs8N4xcCltjaloN7wEutG0ekvQrEejmttz1gAEkPTdab4sQ+UwpQEs6S8dTJa8Mc
	287g6jX1ypbA5FG5muRhWIqApwVX+PbZtxbtAI2zTtlaaJz/80wRNqG92fNMhXPy
	NA11RVc9Q5X6LLmBCw9dRYzrQ=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_3lYhOFqTkVqDQ--.14113S4;
	Wed, 28 Oct 2026 13:12:58 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	Govindaraj Saminathan <quic_gsamin@quicinc.com>,
	Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
	Rajkumar Manoharan <rmanohar@codeaurora.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sriram R <sriram.ramachandran@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/5] wifi: ath11k: validate hardware mode capability TLVs
Date: Wed, 28 Oct 2026 13:12:51 +0800
Message-Id: <20261028051254.147628-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028051254.147628-1-yaojiale02@163.com>
References: <20261028051254.147628-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3_3lYhOFqTkVqDQ--.14113S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7JF4xJFy3JF4xKrW7tFyDAwb_yoW8JrWDpF
	4xG3WUA348Jr47Jw1fAa1xZa45Kan5K34agFW7t34fuF18CF1rZFyYqFWYqFyrtF4UGFya
	qF4DtrW5GF98t3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jcCzZUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRpKhGrhhFretwAA3l

The service-ready parser indexes hardware mode capability TLVs using the
full structure stride and reads their PHY maps without validating the
firmware-declared payload length.  A short TLV can therefore cause an
out-of-bounds read.

Add a minimum-length policy for hardware mode capability TLVs.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 0d4481a09501..8a73318704f3 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -165,6 +165,8 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_dma_buf_release_entry) - TLV_HDR_SIZE },
 	[WMI_TAG_DMA_BUF_RELEASE_SPECTRAL_META_DATA] = {
 		.min_len = sizeof(struct wmi_dma_buf_release_meta_data) - TLV_HDR_SIZE },
+	[WMI_TAG_HW_MODE_CAPABILITIES] = {
+		.min_len = sizeof(struct wmi_hw_mode_capabilities) - TLV_HDR_SIZE },
 };
 
 #define PRIMAP(_hw_mode_) \
-- 
2.34.1

