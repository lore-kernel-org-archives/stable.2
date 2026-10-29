Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793247511;
	b=v0FWuH2gmXE2rUMLYjO2xnBdo1nsu1zQZZnylMLL20yVMVQzFTMFWJ/KAZVokpZnvwp+
	 ENNgtPOCEp1b8B2ZyjGOjJo8ikWDyhqYuy5myN203fbqmO4+dKuP9bhEKdpbIcoQK0kA5
	 KxVaKtjjdbP4NGv6OA1+63aRdCpKhAFmCnv+KzXq/JtpYbSUkcytuTvIG0LYODLPf9lhp
	 h1LIKkDw1ljbrGzFPmUl4/ryjSmv00h4iYYNFONH5zxtMUl8JczJ0CzoTvcv/fnD6tciP
	 bHmTNoEPIteRF/kZInXv1JFM7FkZpli8tdjXVjR15WyqN1ddjYYxAjNGKqBc3yqOSGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793247511;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=aoUcE4jW4bQxv/LnDQVtD+YTMRbVscoTT0kJbYmugLA=;
	b=c181B7pYK01hwAw/rFjWLnKBE3R5RxK7cJguPR7cxQQisiZ/bQGKGPDoHsnQNdjmiRgU
	 +CCudRJjax6twnsKnIH8DCukDDP+e8T7XqR8fEl2974MdqKsyl6Lp6/QwIhGdcLhu9glT
	 ur9FYaknAkajfABcCxOXPg2+xQNIDo0XhnDQvq296nAJrfCFy2sshANsv2DS1dLMjbb6U
	 iFZUB8SrGn917gaoN2XrS3h6ziJo8ideDd3ro97VSquwa9BmSXVMFdBKb399v5IkfIkls
	 DPyiRJYVtfJtAemgn8X66XJylHVOiTLN4VpPJ0bYIXMaD2Cm90iK1WK51jksMecEtXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HvoSMLF5;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0460B606A31C;
	Thu, 29 Oct 2026 04:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0460B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HvoSMLF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ao
	UcE4jW4bQxv/LnDQVtD+YTMRbVscoTT0kJbYmugLA=; b=HvoSMLF5H/ii/Ogrfl
	ess8utIJ11YAdLMZ6IPLfQqCo5WT0z9HA75N4RJYQ+wHj8C94KILE1A0QNjLTZYf
	r888hqCUjsk5GtChyHTRgDW88TWUTuxUXYNLNkzX1/H/XLM3s8HZl4Akmr0yP0IH
	jSRSn8vVMm4qIaH6ahVuZ0R5I=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3nzIDyeJqQW5fDg--.62716S7;
	Thu, 29 Oct 2026 12:18:14 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 5/5] wifi: ath12k: validate service-ready capability TLV lengths
Date: Thu, 29 Oct 2026 12:18:11 +0800
Message-Id: <20261029041811.2379878-6-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3nzIDyeJqQW5fDg--.62716S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrW5Zr45Zw4fKr4rWF48Zwb_yoW8Wry7pF
	47Ww12va4kur47Jwn3Xa1xZa4Ykan5W347KFyxK3Z3Wr4fCr1FqFyY9FWYqF15tF45tF1a
	9ayqgrWfAFn8J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URrW7UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wfGAWriyQfuEwAA3U

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
index 0109f56fd429..2e72159d20f2 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -217,6 +217,12 @@ static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
 	[WMI_TAG_DMA_BUF_RELEASE_SPECTRAL_META_DATA] = {
 		.min_len = sizeof(struct ath12k_wmi_dma_buf_release_meta_data_params) -
 			   TLV_HDR_SIZE },
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

