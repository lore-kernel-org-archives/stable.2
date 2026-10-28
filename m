Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164398;
	b=D4GoD9WWkPHcp4iS4bobPkmpR2Vp8m2zNoF1hQV6oX27V9PXBP3JS8w4jBSUhmH836Vx
	 wvjBMP9461jMYlH4vT3CXbj6+H3rqIwbCFJ4wLLf9Rm7D43G3CNxRyZ9xmYkYxZ4nUeYl
	 4BTfni7F3N9S6QKLwEP3vWwlVbKXspN2j+4fUUCN2nvYmje1OsK+9EkKUQlBoRQCbUfEa
	 pl5z9/mQwH2JDV0t059b1TaG2g1PrISR9F/7oRLgxqtKmo8hibjWeULryBWEBHpmfB98v
	 TDRcW1hRKF90+xKskLgpt55WH+uoS5WYxlH2Wcg5dq8onMDVbvmDhgHxPna3qud0Scg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164398;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=/wHSs0gLvrAt4F4FoIF3bDJZjHw1fnJYQTvBcgzYbZw=;
	b=yLuH/imsQDXVJZp4L3r71yXTYhiIDv+wEJ5eWLLiEQqY7tBMrI6CErJRRKgHQQkB3He0
	 PQeQ5LtS2am8lxgvpnUifnObz6Norpq7pvFerAXIvkmrkRQ83XgAWjq7qBvV2F3dwznT/
	 poaDzncgYBsy9kpErTceI99WmLStPdVUzuoahLS44OjnLedcYCMQ4gGCVQJgSQ7PKC512
	 OF43Qvxg8JkB3mLbXkfpnDkNU8GeyPfuwgasUxqOMShmB5+hJsAY8G3LoGScMRSJDey7V
	 7Dvd7IiN8792LjBAYRDy9umEgO4mrkjJe7Wv6dYg2m6+bXOoqBgQq0E0BS74a+wrMHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=pwDPu8yW;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8318D606A322;
	Wed, 28 Oct 2026 05:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8318D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=pwDPu8yW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/w
	HSs0gLvrAt4F4FoIF3bDJZjHw1fnJYQTvBcgzYbZw=; b=pwDPu8yWZg7ecDhl+r
	OmjVleK/AUHO3EyrvQJ8Wjb151RnBZtQwg9x6VrXN+W+9to0Z7rdnKel+IquA8o+
	Ly5Qxs+4Uza5gFqiRUSqvnaqtnsxlvsCb1wNtWqBeSP9eKe/x1jfSl6gpmg/2ZJh
	TbnkQmRHrmX+B2qcy09CYLnBk=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_3lYhOFqTkVqDQ--.14113S5;
	Wed, 28 Oct 2026 13:12:59 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 3/5] wifi: ath11k: validate DMA ring capability TLVs
Date: Wed, 28 Oct 2026 13:12:52 +0800
Message-Id: <20261028051254.147628-4-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3_3lYhOFqTkVqDQ--.14113S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7XFyUWFyDWw15WFyDAFWDurg_yoW8Jr43pF
	4Ig3W7C34rXr47Jw4fAa1xZa45Kan5t3ya9FWUJ34fuF4kCF1rZF90qFWYvFyrtF4UGF1a
	qFWqgrW5Ar90y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jfR6wUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhtKhGrhhFsXVAAA3M

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
index 8a73318704f3..c5c667828530 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -167,6 +167,8 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_dma_buf_release_meta_data) - TLV_HDR_SIZE },
 	[WMI_TAG_HW_MODE_CAPABILITIES] = {
 		.min_len = sizeof(struct wmi_hw_mode_capabilities) - TLV_HDR_SIZE },
+	[WMI_TAG_DMA_RING_CAPABILITIES] = {
+		.min_len = sizeof(struct wmi_dma_ring_capabilities) - TLV_HDR_SIZE },
 };
 
 #define PRIMAP(_hw_mode_) \
-- 
2.34.1

