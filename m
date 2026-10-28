Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164401;
	b=fg0BKAhjV/uO51O6rhsg5ilzO98AuSpjh3KQ5m4rPFZ/htygQCg6875wtmadoO5QyfPV
	 gNI72bFHqpbjbD40MQxLOSxFuazplVRKONNcKq1VOxISdTBis4DVAjoCp+Bm4C0/KUAMV
	 Qc7DL/Yd0Y3dFN5iIy+R5JaMpJzmYkc20Z/DwBYLXLuCug/cnGB9woZW1raOmqcKQLnhq
	 QQzksyBzgggnUEbYRVrYlWxjcMDVt2NHhS5OnoqBAy2LT27aS25CquGFD1VVphdP4BCVf
	 4fwk2NWpplNC12jVyq+7sZn5M2dXyaEcTITaACcdpiLtKLkDD6yc9eiofFstt94lfZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164401;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=OPL7dEgEIRJj2QJL0rYyg1bEtLOG5PHdhYLy2JiJ/xE=;
	b=Qntm3MO39ZTUvQCB+lEaeQIR7veBWEuSZtISh4DtYBX1nh5afICmd7pjLHE1emHFTgYf
	 U0YCftK77CB7JVT8SRWjHEH+aTZyrlFqSgg94dIYWA5lVS+tPOGK+L20QjZ5mcrOmGQpb
	 XdsOBEjMDQmdT0ZNWD3oAOqF2kT4MnC+nVXh+hTca3yRy383BZ7DhVtKIGsi1KWmEJNjQ
	 79TzyPVWNsuPa5Q/Idv6TNISMDWrVhMLYfSJMRa3izpR0j9wctkg2HV/cdXKX7st2VLcx
	 UoIHAMV3Z46sn1GckTz2jX+ydss293313bvWuvkkz6aBXNvST6jvExMCCrYaZn+Y+Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=oIctWJLe;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BC4606A335;
	Wed, 28 Oct 2026 05:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91BC4606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=oIctWJLe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=OP
	L7dEgEIRJj2QJL0rYyg1bEtLOG5PHdhYLy2JiJ/xE=; b=oIctWJLeGhq3ThaFst
	zqG4GKRmwxVNOX/yGDyl5/RMAdpH0Cn54VaAqdd7kXsC1/sv2AgIjIJH4CsOH45T
	drLP099oxHor5r3zTxcuio136A71A1GokTXxNMvtHt44SJAK9Tx25gqbrp5gpVHu
	YEyzp+wH1uV1dhobgsiejj5Qg=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_3lYhOFqTkVqDQ--.14113S6;
	Wed, 28 Oct 2026 13:13:00 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
	Carl Huang <quic_cjhuang@quicinc.com>,
	Kalle Valo <kvalo@kernel.org>,
	Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 4/5] wifi: ath12k: validate DMA buffer release fixed TLV length
Date: Wed, 28 Oct 2026 13:12:53 +0800
Message-Id: <20261028051254.147628-5-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3_3lYhOFqTkVqDQ--.14113S6
X-Coremail-Antispam: 1Uf129KBjvJXoWruF47tF4DtFWkJF47ZrW5KFg_yoW8JrWUpF
	45Ww1UCa4rWr4UJwn5Wa1xua4rKan7J343Kr40ya4fWr4rAr15tFWFqFyYqry5tr1rGF12
	9a1jqr1fAFn8trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UGJPiUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8BxLhWrhhFyb5QAA3P

The DMA buffer release parser copies the fixed parameters from a
firmware TLV without checking that its payload contains the complete
structure.  A short TLV can therefore make the structure copy read past
the declared payload.

Add a minimum-length policy for the fixed DMA buffer release TLV.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 75b259990c79..ea7771a2eea9 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -209,6 +209,8 @@ static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_obss_color_collision_event) },
 	[WMI_TAG_PDEV_CSA_SWITCH_COUNT_STATUS_EVENT] = {
 		.min_len = sizeof(struct ath12k_wmi_pdev_csa_event) },
+	[WMI_TAG_DMA_BUF_RELEASE] = {
+		.min_len = sizeof(struct ath12k_wmi_dma_buf_release_fixed_params) },
 };
 
 __le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len)
-- 
2.34.1

