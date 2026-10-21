Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580274;
	b=SFXUnFhEwtIbhVZ7tAw0JMyh1WhsCwVPV45BbMBbiJd5vfeOHkJ9aDMVWUVBK2QB26YP
	 Erny/Q9bXHMCLTVTdBjw4mhXYjxVvmeC5pEOp45G5vX73wVvqmvCe1Z+S5xx0AaJo+aum
	 TSYy02df6cAMVxMy3g8efDR3+ZoJyC2Jg8rtWA/b6UA6jE2Twzz/Wym44nF6S68ZRjdH5
	 7y0sRMocRObR+zWnyQtanHPQVoRHvU3PahVtgfoyMyHOVHwpa9NH7jPQI9SEwWF73azE+
	 L8A95RIi+lUjbKfhWSGwITROHaeDb1NXrsuIUwhJKQOMog4UO6nFXjbvFybBd/ADR5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580274;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=J8ew5LcECVtVvRNbtwJwgDhGqiDv7/vJ+7dad3+i+Bk=;
	b=fkHO1OuGHA9d9bI78fnoiQdDvWO+UK2aQnyNh5F/kTD3MSK7EdCLrndyB8OPmiXP6S0P
	 6IteTXMXdjzly+sgpDCo8BTnZWMMt6GkbRg7CtylcNxG1rJH8Dk+hLgzDfeUq65cGENu4
	 53kDo/1Byt2dQdWiBcq5qUS9ebdQkR7iIBiMCIu2VcsUxN1mMnf4T7J43Pk2dQytxGF1m
	 X7559cIR6YFD3vI1OhH8xvXGw8PYRPnHnw6177yHnZdFbKLBEYbPsV/KUbAOuGXqssXtS
	 0m8WPUV4bWnsuPHxQ2Bpn1hEVrMOZ8ixgmvDxz8BXE+20CWgfefYw5wRD+2qkWdB6GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=S+WGn+Oo;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C961F606A31A;
	Wed, 21 Oct 2026 10:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C961F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=S+WGn+Oo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=J8
	ew5LcECVtVvRNbtwJwgDhGqiDv7/vJ+7dad3+i+Bk=; b=S+WGn+OoxNC/MxtEqW
	PjbwjFcrl2JpX8ISQIeTrwO9fSGi+D8uFGWEWdwbQdXCYEEzplTGmMrUcM27Gu/y
	8YwKk3+XTxJ2XQ5Rsb/8BAY0D03si31F3zTYkbkDB4LWisLVjWJEvzUNZ2QqH+nj
	D+cZ8hUqNmHK1YtCGWDdXDu9c=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_1CJmthquYHTBg--.25487S4;
	Wed, 21 Oct 2026 18:57:19 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	MeiChia Chiu <meichia.chiu@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 2/2] wifi: mt76: mt7996: clamp EHT beamforming NSS
Date: Wed, 21 Oct 2026 18:57:12 +0800
Message-Id: <20261021105712.4124467-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021105712.4124467-1-yaojiale02@163.com>
References: <20261021105712.4124467-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3_1CJmthquYHTBg--.25487S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw1DJFWUXw4UXryrGF15Arb_yoW5WrWxp3
	yfZa42vr4xArWkW3WfArs7tF98Ga13G34aka1kWrs3CryfKFyxJF4xuF9xJF1FyF4Uury3
	Zw1DArn8Wa4Y9FDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U_UUbUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQ+a1GrYmo9QHgAA3l

An EHT peer can advertise zero receive spatial streams for an MCS
range.  The beamforming setup decrements that value, causing an
underflow and sending an invalid column count to firmware.

Clamp the converted NSS value to zero for 80, 160, and 320 MHz
beamforming configurations.

Fixes: ba01944adee9 ("wifi: mt76: mt7996: add EHT beamforming support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index e6243dd33c31..29b67248fad7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1969,7 +1969,7 @@ mt7996_mcu_sta_bfer_eht(struct ieee80211_link_sta *link_sta,
 	struct ieee80211_eht_cap_elem_fixed *pe = &pc->eht_cap_elem;
 	struct ieee80211_eht_mcs_nss_supp *eht_nss = &pc->eht_mcs_nss_supp;
 	u8 nss_mcs = u8_get_bits(eht_nss->bw._80.rx_tx_mcs9_max_nss,
-				 IEEE80211_EHT_MCS_NSS_RX) - 1;
+				 IEEE80211_EHT_MCS_NSS_RX);
 	const struct ieee80211_eht_cap_elem_fixed *ve;
 	const struct ieee80211_sta_eht_cap *vc;
 	u8 snd_dim, sts;
@@ -1988,6 +1988,7 @@ mt7996_mcu_sta_bfer_eht(struct ieee80211_link_sta *link_sta,
 	snd_dim = EHT_PHY(CAP2_SOUNDING_DIM_80MHZ_MASK, ve->phy_cap_info[2]);
 	sts = EHT_PHY(CAP0_BEAMFORMEE_SS_80MHZ_MASK, pe->phy_cap_info[0]) +
 	      (EHT_PHY(CAP1_BEAMFORMEE_SS_80MHZ_MASK, pe->phy_cap_info[1]) << 1);
+	nss_mcs = nss_mcs ? nss_mcs - 1 : 0;
 	bf->nrow = min_t(u8, snd_dim, sts);
 	bf->ncol = min_t(u8, nss_mcs, bf->nrow);
 	bf->ibf_ncol = explicit ? min_t(u8, MT7996_IBF_MAX_NC, bf->ncol) :
@@ -2001,7 +2002,8 @@ mt7996_mcu_sta_bfer_eht(struct ieee80211_link_sta *link_sta,
 		snd_dim = EHT_PHY(CAP2_SOUNDING_DIM_160MHZ_MASK, ve->phy_cap_info[2]);
 		sts = EHT_PHY(CAP1_BEAMFORMEE_SS_160MHZ_MASK, pe->phy_cap_info[1]);
 		nss_mcs = u8_get_bits(eht_nss->bw._160.rx_tx_mcs9_max_nss,
-				      IEEE80211_EHT_MCS_NSS_RX) - 1;
+				      IEEE80211_EHT_MCS_NSS_RX);
+		nss_mcs = nss_mcs ? nss_mcs - 1 : 0;
 
 		bf->nrow_gt_bw80 = min_t(u8, snd_dim, sts);
 		bf->ncol_gt_bw80 = nss_mcs;
@@ -2012,7 +2014,8 @@ mt7996_mcu_sta_bfer_eht(struct ieee80211_link_sta *link_sta,
 				   ve->phy_cap_info[3]) << 1);
 		sts = EHT_PHY(CAP1_BEAMFORMEE_SS_320MHZ_MASK, pe->phy_cap_info[1]);
 		nss_mcs = u8_get_bits(eht_nss->bw._320.rx_tx_mcs9_max_nss,
-				      IEEE80211_EHT_MCS_NSS_RX) - 1;
+				      IEEE80211_EHT_MCS_NSS_RX);
+		nss_mcs = nss_mcs ? nss_mcs - 1 : 0;
 
 		bf->nrow_gt_bw80 = min_t(u8, snd_dim, sts) << 4;
 		bf->ncol_gt_bw80 = nss_mcs << 4;
-- 
2.34.1

