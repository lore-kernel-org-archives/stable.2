Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164399;
	b=KPEhepwW5wQ2e4bBqFmiKXDYG4SulYCXmDz4c4y372vnDkmZcRIByuoCc0dzKP7SWG4x
	 9x5aHK538i56lOMFputE80wUjlp+S3sG9kmfn5y+OwTBZQ96KyG1YE2v0G55ySx+YFxx5
	 ES3/UJgvkqXnmoODi2yFyXSYY3HSSuuK6fxE0IPFnhg0XE3m7knCImO+BbK9UHYcaJfYn
	 ONnqsxj47FN4P+40t1NSsTMsPI8g/WRnR7637VwXpihXSQsJmXUJoT8xmztGkQUjujjZF
	 hIDXTOE4Vcuw1xJw05jbdNplYguYRhEYJgqFUqKu9cIQpy7tZyHqdU/9cj8NOCZG4GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164399;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=DVH/EBIsl3QhnmFUaGRlJxxmZd3EfkXqMccMLT5dSoY=;
	b=XJKICce24JcTakRn+jMRtww1fTcCToJIfNTZs44MYKyqhoUwT/O+pAh5kOu+9mUBcIa2
	 OgmraB6MSxRMwtIbkNtZlhgn3zpqfQz4m2nx0VJlvZnhE5FeWXfd6KNQFwY0xnnrO1a7T
	 DM82BeK57+o23F7pM+isyvlDr436W8cvAIWgHJ5kaItuoHVPHepHPPfv9ltK9ES5QN69j
	 Ptuxvqx/82RXsc7bKIj8l8g2kHgQh7fAj0LUKyT1OXfnZLo2RlE82qsvo2Zo8uNQNTOKE
	 gpO1FKq4Wy3inXBSx7tG0Ng9CodrWdeWXe96Jq/54llabfdS2oDBimzO/hSoDh20c0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="mZbBC/IH";
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B9A606A31F;
	Wed, 28 Oct 2026 05:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52B9A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mZbBC/IH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=DV
	H/EBIsl3QhnmFUaGRlJxxmZd3EfkXqMccMLT5dSoY=; b=mZbBC/IH74kqwctlh6
	tW+zKItZIdn0iYkGsf7wyXLdVPFqEQ+Ge77rk9ilPO3Wj+gpdzkRbjtyUIIZBCCv
	2eK6iALrcLCS1pNq9s9yToZhTLj7JBg+r4IwG4rlkKcmR3q6E8hr/zo1BGTa5ECV
	cbBig3wHV5iha5wVNZ1WSnU8Y=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_3lYhOFqTkVqDQ--.14113S3;
	Wed, 28 Oct 2026 13:12:57 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/5] wifi: ath11k: validate DMA buffer release TLV lengths
Date: Wed, 28 Oct 2026 13:12:50 +0800
Message-Id: <20261028051254.147628-2-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3_3lYhOFqTkVqDQ--.14113S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4UJr47Wr4xur1UWF17Wrg_yoW8Gry7pF
	W8Ww17Cw1xWr4xJw1fAa1xZayYkanYgrW3KFWrt34fuF18CF15JFWYqFWYvFyrtr18tFyS
	vF4jgr15AF1qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5R6wUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRpKhGrhhFreowAA3x

The DMA buffer release parser counts nested entry and metadata TLVs, but
does not ensure their payloads cover the structures later indexed by
the direct buffer ring handler.  Short firmware TLVs can therefore lead
to out-of-bounds reads when the arrays are consumed.

Add minimum-length policies for both nested TLV types.

Fixes: 9d11b7bff950 ("ath11k: add support for spectral scan")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 08fd6795ed9e..0d4481a09501 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -161,6 +161,10 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_p2p_noa_event) },
 	[WMI_TAG_PDEV_CSA_SWITCH_COUNT_STATUS_EVENT] = {
 		.min_len = sizeof(struct wmi_pdev_csa_switch_ev) },
+	[WMI_TAG_DMA_BUF_RELEASE_ENTRY] = {
+		.min_len = sizeof(struct wmi_dma_buf_release_entry) - TLV_HDR_SIZE },
+	[WMI_TAG_DMA_BUF_RELEASE_SPECTRAL_META_DATA] = {
+		.min_len = sizeof(struct wmi_dma_buf_release_meta_data) - TLV_HDR_SIZE },
 };
 
 #define PRIMAP(_hw_mode_) \
-- 
2.34.1

