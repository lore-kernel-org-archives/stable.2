Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794729788;
	b=IzvA23Pn2gVDdpe3yr5vIKRZUDfcMjGr6nU4LVW4iegSRR3ulUD6pY24jvY9JKsdgNQs
	 y3qYDBp2B0tNw5vD9YkneIoVcRB19Z8pVcn/Qu8O/K21YjkJY6NrVQHgSuGbyyD6GWeqR
	 fSe2vXYgaTr5d8Mz/VBLOuj8/G3dQqGdjdS0h7nEy2W3nOb9oxfLXPjVY5Dqd3ZU3J3XX
	 Q2tvcrgid5baNPxAIovVxPVXDVuivIoPEJkcYhMp7wD0DvXBqhjf+wNtvVxqEDCt9C8jX
	 DuJhE5a6ggbnalTYta99a0ruJoCfyyFXaBliaMd7m45QAzMeQ8U/OIcBXBxAm4nzzCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794729788;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=iqFD1Dy0PA5Hv/7kVoTZRvbdlmdkVu9y//K9Cw3fKM8=;
	b=qHkExpasRRDPUSTXPVeEhcGQXqfIvSS94J9q+txQU38YM317zLUj8Cznqv/VqPn6zvS5
	 aDZ8eqSr6Yxui4+/5wAD0vvGbFDMxgQ+p1a7pmaH/0vXuO6LwIAIo8g1cQrAxKZwFgpt9
	 dqBDWua+t7NzxrYH3y6wjj2N8td5fvrQFKqrmyQ91LqrXD7P/PYlqJs2MAQ5KXtKE6R9C
	 yiRlJ3UIBeN0Dij6R1HsnqesNmOF6jGU/+NIXzXFRYwHNGnBAHOU65O6C78nE5WUmRX/z
	 BuMOQeSsRdS4EpIWSv1xaUwMgH2C4cuhnHINsc4ZMnO2y2K0aUl100r2zfYb8oj4fsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=AccT0Gtp;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372F4606A33F;
	Sun, 15 Nov 2026 08:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 372F4606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=AccT0Gtp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=iq
	FD1Dy0PA5Hv/7kVoTZRvbdlmdkVu9y//K9Cw3fKM8=; b=AccT0GtpYOmkgHaMbw
	qgk5oDQiS2+F1HIJtb+ZKtzUXFiXh54CYN9I5QXybfghSl07ssNJFR5CUN9Sr2O9
	aVHMcfKssWn8Cj0UVh6X01X72wBDJjRvjdSp/NCAU8/CWDTJauu5jt6RiNq4crHu
	XhmT7y22CyAFlzxkKRUhDaVxs=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBnbpcfZ_lqTjp7HA--.27549S2;
	Sun, 15 Nov 2026 16:02:39 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7925: fix mt7925_reverse_frag0_hdr_trans() for MLO
Date: Sun, 15 Nov 2026 16:02:39 +0800
Message-ID: <20261115080239.910402-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:_____wBnbpcfZ_lqTjp7HA--.27549S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF18Ww4fWFyktFWUGw15Arb_yoW5tw43pa
	yjk3y5Gr1kXrs5Zw18Cw4j9FWava1fKFyIkryfG3Z5uFZ5tr18JFsrXry0vryYkr4kuFnI
	yFW8tr98Gayq937anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jkpnQUUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7QD6S2r5ZyCuOAAA3e

For unicast frames mt792x_rx_get_wcid() returns the wcid of the
receiving link. Since commit 43aa4033eb18 ("wifi: mt76: mt7925: add
mt7925_change_sta_links") the wcid of a non-default station link is
embedded in a separately allocated struct mt792x_link_sta, not in
struct mt792x_sta. mt7925_reverse_frag0_hdr_trans() still casts
status->wcid to struct mt792x_sta and derives the ieee80211_sta from
it with container_of(), so for a frame received on such a link it
reads msta->vif past the end of the link allocation, dereferences the
result as a vif, and copies sta->addr from memory in front of it into
the rebuilt 802.11 header.

This path is taken for the first fragment of a header-translated
unicast frame, so it is reached when the AP sends fragmented data on
a secondary link while RX header translation is active there.

Do what commit a3ea1c309bf3 ("wifi: mt76: mt7996: Fix
mt7996_reverse_frag0_hdr_trans for MLO") did for mt7996: get the
station through the sta back pointer of the link and wcid_to_sta(),
and take the BSSID from the bss_conf of the receiving link.

Found by LLM-assisted source review. Not tested on hardware.

Fixes: 43aa4033eb18 ("wifi: mt76: mt7925: add mt7925_change_sta_links")
Cc: stable@vger.kernel.org
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---

Notes:
    The changelog was drafted with an AI assistant from my analysis;
    I have reviewed the code, the fix and the text.

 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 7af996abe..e00c04cf5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -184,7 +184,9 @@ static int mt7925_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	struct ethhdr *eth_hdr = (struct ethhdr *)(skb->data + hdr_gap);
-	struct mt792x_sta *msta = (struct mt792x_sta *)status->wcid;
+	struct mt792x_link_sta *mlink = (struct mt792x_link_sta *)status->wcid;
+	struct mt792x_sta *msta = mlink ? mlink->sta : NULL;
+	struct ieee80211_bss_conf *link_conf;
 	__le32 *rxd = (__le32 *)skb->data;
 	struct ieee80211_sta *sta;
 	struct ieee80211_vif *vif;
@@ -201,8 +203,11 @@ static int mt7925_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	if (!msta || !msta->vif)
 		return -EINVAL;
 
-	sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
+	sta = wcid_to_sta(status->wcid);
 	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
+	link_conf = rcu_dereference(vif->link_conf[mlink->wcid.link_id]);
+	if (!sta || !link_conf)
+		return -EINVAL;
 
 	/* store the info from RXD and ethhdr to avoid being overridden */
 	frame_control = le32_get_bits(rxd[8], MT_RXD8_FRAME_CONTROL);
@@ -215,7 +220,7 @@ static int mt7925_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	switch (frame_control & (IEEE80211_FCTL_TODS |
 				 IEEE80211_FCTL_FROMDS)) {
 	case 0:
-		ether_addr_copy(hdr.addr3, vif->bss_conf.bssid);
+		ether_addr_copy(hdr.addr3, link_conf->bssid);
 		break;
 	case IEEE80211_FCTL_FROMDS:
 		ether_addr_copy(hdr.addr3, eth_hdr->h_source);

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

