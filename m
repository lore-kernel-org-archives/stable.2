Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816918;
	b=TQ4ySYD2GMoqzm3Aj5PQ1Vr5PKNNTezg74mZbrVKqrG1dMJf1E2ts8pX3M0pZa72eIWk
	 dWRZQFwGM76NEsKDeP8qz4XAu/CjKFjRs2aeiGOGdjdA/eeeXDSTaHIwoB6NgQKjY5rwW
	 jyaN4l+PpHrYlE/hFOuc870m6AXG4EhohF3L0egFzdMUeMrwGC/AuGm0B9yTkDd3YPT+L
	 ga5rUkRS5prRHt8BR2qy9AZ3kAw9InYbNFtq7NxBFav7CxWqVN8mnPrEAOvKgaQ25Uj3k
	 k5BihhZvFQzEHtEvbbT2bLMq0zbd5A3z6YWGtN12cUttXg7BW4YnlQyRKwTQMER2jOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816918;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=f4KSxtdG3vQaJyl5njlVKbU4jwHtFCn8k+q0cZfb9w8=;
	b=K0JSVBZn/oTj17hcBVP+HCmhWfCp40aPhfmr1wfxtjpZ5z0tHvsXsSUFpVkyAYDyStYV
	 KXhAhv/ZbfOo8XgWbSP7HNeyErAWiWuv/0xAnnDyv0o99bVNYs0cTSnjQ0LKV/8HwI8Vu
	 GyFtCeChArv5FfdLKICKTdDKQHax5LxR0lTSzcBIlL6a0BHba8k83SZAePIitOsq3Z3C6
	 e3egTZ1vF7F5gjnThmi+vLKrqcw6lF23ZMdJ211rJnOq+N4kuhUNPy+JF8bIpscVWX4qE
	 NE3I/ev+ZFStedMXVa/uuo0Sxny9korj1xJerhD59TJ9N55Ent52PDVY+wwre+XTK7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=WPjqbzyd;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9B606A32F;
	Mon, 16 Nov 2026 08:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77D9B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=WPjqbzyd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=f4
	KSxtdG3vQaJyl5njlVKbU4jwHtFCn8k+q0cZfb9w8=; b=WPjqbzydbabgVLT9Bw
	+B9O6YTCuiWu9VNZQhxLFqUA3zhCpKXM0TD+jdkHEibFvY+cmPeA6Zr8u/r36N0V
	mHEUYa9FhE+IVIJGwVntDdiroHvWfEAks+5odH4UUn5wpEtbss+wE1O/M/ZETu9i
	43hNW0CO6yagUkdFaLC5GWnUA=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD33z5xu_pqGJBDIA--.12815S2;
	Mon, 16 Nov 2026 16:14:42 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Zhao Li <enderaoelyther@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: mt76: mt7925: fix mt7925_reverse_frag0_hdr_trans() for MLO
Date: Mon, 16 Nov 2026 16:14:40 +0800
Message-ID: <20261116081440.1011837-1-zihengw03@163.com>
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
X-CM-TRANSID:_____wD33z5xu_pqGJBDIA--.12815S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF18Ww4fWFyktFWUZFy8Grg_yoWrZr43pa
	yjk3y5ur1kXr4kZr18Cw40vrWava1fKay2kryfK3Z5uFs5tr18JFnFqryjvryYkrZ5uF1a
	yFWxtrn5Gayqv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jq_M3UUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7RNktGr6u3PSgAAA3k

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

The unicast path of mt792x_rx_get_wcid() returns the WTBL entry
unchecked, and not every entry is a station link: index 0 holds the
bare global wcid. Check wcid->sta before converting the wcid to
struct mt792x_link_sta, as the non-unicast path already does.

Found by LLM-assisted source review. Not tested on hardware.

Fixes: 43aa4033eb18 ("wifi: mt76: mt7925: add mt7925_change_sta_links")
Cc: stable@vger.kernel.org
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---

Notes:
    Changes in v2:
    - Check status->wcid->sta before container_of(), so that a non-station
      WTBL entry such as the global wcid at index 0 is never treated as
      struct mt792x_link_sta; drop the now redundant !sta check
      (suggested by Zhao Li)
    - v1: https://lore.kernel.org/all/20261115080239.910402-1-zihengw03@163.com/
    
    The changelog was drafted with an AI assistant from my analysis;
    I have reviewed the code, the fix and the text.

 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 7af996abe..9a79b989b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -184,9 +184,11 @@ static int mt7925_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	struct ethhdr *eth_hdr = (struct ethhdr *)(skb->data + hdr_gap);
-	struct mt792x_sta *msta = (struct mt792x_sta *)status->wcid;
+	struct ieee80211_bss_conf *link_conf;
+	struct mt792x_link_sta *mlink;
 	__le32 *rxd = (__le32 *)skb->data;
 	struct ieee80211_sta *sta;
+	struct mt792x_sta *msta;
 	struct ieee80211_vif *vif;
 	struct ieee80211_hdr hdr;
 	u16 frame_control;
@@ -198,11 +200,20 @@ static int mt7925_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	if (!(le32_to_cpu(rxd[1]) & MT_RXD1_NORMAL_GROUP_4))
 		return -EINVAL;
 
+	/* not every WTBL entry is a station link, e.g. the global wcid */
+	if (!status->wcid || !status->wcid->sta)
+		return -EINVAL;
+
+	mlink = container_of(status->wcid, struct mt792x_link_sta, wcid);
+	msta = mlink->sta;
 	if (!msta || !msta->vif)
 		return -EINVAL;
 
-	sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
+	sta = wcid_to_sta(status->wcid);
 	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
+	link_conf = rcu_dereference(vif->link_conf[mlink->wcid.link_id]);
+	if (!link_conf)
+		return -EINVAL;
 
 	/* store the info from RXD and ethhdr to avoid being overridden */
 	frame_control = le32_get_bits(rxd[8], MT_RXD8_FRAME_CONTROL);
@@ -215,7 +226,7 @@ static int mt7925_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
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

