Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164410;
	b=y3Lv84ZVTMILsbzwAnF9mU9DwImxCCCNamqHd4aJH3I9SUHwLRMYmqHGHgS7yTNV1E6l
	 lQ+dBSxWWeldhGQpLsIgd1NvTRwNImgN7MPcyH3Qs5mxDyOVzJaQGakbpKku5VF0RxxNp
	 jMzZYtlwizzsEWeMf6tlOEXbjF3MvOCgU00PpSBxPwh6dEa/Tgx+kVd/wnqcxLFyvB+qi
	 KLs3JdCvry7gDQ/Sj0TsZsxXgO1QF+rqayG3jQrhm12DZumGuEoax8LfoFGHAF1+yLOTJ
	 zzKqDz2XA+A+nGuAvE0N0sbSaDIrCyBPzBzHkkgJ1Trfw/aawg/gE2JUK5Cn2UoMSuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164410;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=p/LgAKhcWxgZW2ssGetKgp6sVR7mrLPRnCM5cql8m8w=;
	b=gjIKd+weH/pRyiygcAg9niem3uENadvkNdcUEFCG02CP4iGtxHDjL2GcxFiUBkdu7rV0
	 xiF3HlaFVBv2vZt50Ivh7P6nxpFh7nAXlnKbkENXouzWfQ91cm3X3gDxQqFyXWznxsGG/
	 D9nnIECo/11MOxtJ4xeC7HWZPvcTiXwOu+SaJC9hLXAvceK452Assf4LjmuJbZpiutkNP
	 x8srwIsYEDWMBaJbXwC/RFOM5EhBmgvqak/4tyVls4WbDD8PLePFSwEmz36mq9MlbnQI6
	 5vbcv7Dr5ft7vIQoYyLj+Bu99hEXFi968+5nFFjCTNRFyHg96+40j7Lk8b0PcCKmPiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=POlenbVm;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B70606A331;
	Wed, 28 Oct 2026 05:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04B70606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=POlenbVm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=p/
	LgAKhcWxgZW2ssGetKgp6sVR7mrLPRnCM5cql8m8w=; b=POlenbVmpa3p0oio+s
	IZBTJ0OQ0XNZKsNoSrBCgAfdods4q3AYwLIrtkswvYkLdb/1AyltRuD2Gny2uSVR
	PC0R0q1kk9qDbmjBJjq3IDMYy5MzTEjknCRYjnEZbOAvEosV1gWw691f9jCdGSTL
	hGES0AUp05Wwshq5qTO5JSiOY=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_3lYhOFqTkVqDQ--.14113S7;
	Wed, 28 Oct 2026 13:13:01 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	Wen Gong <quic_wgong@quicinc.com>,
	Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
	Sriram R <sriram.ramachandran@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Kalle Valo <kvalo@kernel.org>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 5/5] wifi: ath12k: validate service-ready capability TLV lengths
Date: Wed, 28 Oct 2026 13:12:54 +0800
Message-Id: <20261028051254.147628-6-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3_3lYhOFqTkVqDQ--.14113S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrW5Zr45Zw4fKr4rWF48Zwb_yoW8WrWDpF
	4UW3W2yayrGr43Jwn3Wa1xZa4Fkan5W347KFWxKa4fWF4fAF15tFWY9FWYvF15tF45KF1a
	9a1qgrWfAFn8J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UGJPiUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7x1LhWrhhF0RKgAA3V

The service-ready parsers consume hardware mode, DMA ring, and extended
MAC/PHY capability TLVs as complete structures without validating their
firmware-declared payload lengths.  Short TLVs can therefore cause
out-of-bounds reads while the capability arrays are parsed.

Add minimum-length policies for all three capability TLV types.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Fixes: 1476014fadb6 ("wifi: ath12k: WMI support to process EHT capabilities")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ea7771a2eea9..730dde686626 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -211,6 +211,12 @@ static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
 		.min_len = sizeof(struct ath12k_wmi_pdev_csa_event) },
 	[WMI_TAG_DMA_BUF_RELEASE] = {
 		.min_len = sizeof(struct ath12k_wmi_dma_buf_release_fixed_params) },
+	[WMI_TAG_HW_MODE_CAPABILITIES] = {
+		.min_len = sizeof(struct ath12k_wmi_hw_mode_cap_params) - TLV_HDR_SIZE },
+	[WMI_TAG_DMA_RING_CAPABILITIES] = {
+		.min_len = sizeof(struct ath12k_wmi_dma_ring_caps_params) - TLV_HDR_SIZE },
+	[WMI_TAG_MAC_PHY_CAPABILITIES_EXT] = {
+		.min_len = sizeof(struct ath12k_wmi_caps_ext_params) },
 };
 
 __le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len)
-- 
2.34.1

