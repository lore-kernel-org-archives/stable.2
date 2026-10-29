Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793247511;
	b=mJ/jZe9SWRS4eT1GOEac231C25OS+ydnny2V0RcTrj3smYZZZnU456QthSkGYwCjbbai
	 SN4BAgK3wMIFzmMnedKYcMc0hQ7CNngOetQY2J7A+8s/RSxQmfNxZY4ImyhoNqpz5njrT
	 wzw+QMC46YWISz0fJWrat90vKc7+LCL8Mgp3mcyHiAmIOPABdKG0gD+KJxNcf+pDNwoNc
	 6ME9Rs0l/G0iFotwg2ewfzvAbAui27EmwpBa55XMbSqExrMkgsmvo3U0Az5W8GhPfAAp9
	 I50m6hlB/ZbET379RkhWRZ1G9BFkUGKoZXELbRcV6JXSDT8jFq/j+IT0i+niLjlCdMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793247511;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=TIS1eakvHI8+nc46GSQLddSxCI4HVRv7Ah/8EnxGvVs=;
	b=a1wIFsthXTRFH6GZq5kQHgEREyov4QPSTQ6xfkN/iuyjpcHxpPu3rC/53H2zBp6UNhqk
	 RVk05pHOvFvp3Zo67zoCNHk6JT82BXJvbkzwvpH85NJBM6efuq9iF25qogHTiY/COVO/A
	 ppHsOfpTOsDwGHo2/VI6hWuEjVr9b7RR/wOFpxnpKn8T4AhPeFsjfPh/8HOv5napnkRZQ
	 nOSonQaBHUBxU94QVE/KfrbAcTkS+BEh/Gun6SqTSYYhY9/6hsEuHOKK/J0HqJUZdK5AU
	 IY+ixiYAYDZYv9sHjGbpQer/jmcl3YeMk04njtjKmuW1Z8xTBfWnho050APyx/JJbEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Gr8qnu41;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA20606A326;
	Thu, 29 Oct 2026 04:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BA20606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Gr8qnu41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=TI
	S1eakvHI8+nc46GSQLddSxCI4HVRv7Ah/8EnxGvVs=; b=Gr8qnu41zMvgzCQFL4
	CMliPrLiR9VssdJgAtch18G6V8SSXQz4d85j/89Sa3H/kGQBlxpwB437j8M11C+T
	AB+OAXh9qf6VQCnGQnoEZS1aOvfYxaKwRLKUo3MNPISN9m83kL+pznqBq6Q9GQXp
	olUEJUbqaZNHeOqVBGzAfsveg=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3nzIDyeJqQW5fDg--.62716S4;
	Thu, 29 Oct 2026 12:18:13 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 2/5] wifi: ath11k: validate hardware mode capability TLVs
Date: Thu, 29 Oct 2026 12:18:08 +0800
Message-Id: <20261029041811.2379878-3-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3nzIDyeJqQW5fDg--.62716S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7JF4xJFy3JF4xKrW7tFyDAwb_yoW8JrWDpF
	4xGw1UA348Jw47Jw4fAa1xZa45Kan5K34agFW7t34fWF18CF1rXFyYqFWYqFyrtF4UGFya
	qF4qqrW5AF98t3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jDL05UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wXGAWriyQXt7wAA3r

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
index ef2c2c300854..047ae8f5bb60 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -167,6 +167,8 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_dma_buf_release_entry) - TLV_HDR_SIZE },
 	[WMI_TAG_DMA_BUF_RELEASE_SPECTRAL_META_DATA] = {
 		.min_len = sizeof(struct wmi_dma_buf_release_meta_data) - TLV_HDR_SIZE },
+	[WMI_TAG_HW_MODE_CAPABILITIES] = {
+		.min_len = sizeof(struct wmi_hw_mode_capabilities) - TLV_HDR_SIZE },
 };
 
 #define PRIMAP(_hw_mode_) \
-- 
2.34.1

