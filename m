Received: from mta0.migadu.com (out-74.mta0.migadu.com [91.218.175.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B4748EBC5
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634478; cv=none; b=aHYMbZ6z6+cdsuHl3SNuPu5iEl87a7OeTdcF2WHg7b/l4Ydr0+ShMTr4rZ7EAp5cT+FAbYYQxMW83GLI7DvgwouvLQwyTfLQOvf+a9WAeyqDcD9FWgA7taxwQ97rEschGItjpjwlwedW3KWkK5YMzspwCPetwTX1zxnjakZDKLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634478; c=relaxed/simple;
	bh=XyXTkrVvcf4imSkHyIrt+1glBg5r4UAiPlvuYUXtjRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HtiVIQGeBTzHpUM+BObmeh7zdm9eW66BEdryTCtbmDEQjA8zoM4mm8o1hsmhsXHJdSiNFH8RG5qt8sY7sTa6GkAHJL1N40Bdi9E/5+8BR7ucUnUpSXOGNBwDXBidU6hnLejVYLFsTbXS3Db3CHAIuLWnvizVywExeuefF0I6lZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=fXg62+OA; arc=none smtp.client-ip=91.218.175.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="fXg62+OA"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XyXTkrVvcf4imSkHyIrt+1glBg5r4UAiPlvuYUXtjRc=;
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786634472; v=1; x=1787239272;
 b=fXg62+OAHfp0RhieM5vXhUCPAya9hNOFQNMYeyGQAPCKJGZ2t8DrvDGJAgkPbfUQV9Ou1HHt
 KwmNhNRLAw0KQ3KMwHsYIfN1giMvXz5Sb/ACdLFgjnEn8/MJNvbZAOymBJblWuo3eO8baa54MS+
 TGZ5vPo9Bw+cpbEX8hb4gM4ff4bD7VVDnD02/jbqKAqAL6pHUPs75mpw0WTu/gX+3R9v72973P0
 GuSY3l6NueG/Uf1b1hyb0Yb0aH3zSL/dmXF3FdnQqy0AoPkijrV9TAvZC8cSICh4KCNLCu0p8kZ
 XtelPdTTKcJYAgFdsIUuox6o5Ilcwy20BHz9enqpy0+Fw==
X-Envelope-To: stable@vger.kernel.org
Received: from fedora (2001:569:be59:c500:b340:3f2c:4486:21c1)
	by smtp.migadu.com with ESMTPS id ebb65674c93e86f6;
	Thu, 13 Aug 2026 15:21:02 +0000
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Anthony Agarro <markanthonyagarro@gmail.com>,
	stable@vger.kernel.org,
	Orly Orge <orlyorge2004@gmail.com>,
	Inanix <contact@inanix.fr>,
	Devin Wittmayer <lucid_duck@justthetip.ca>
Subject: [PATCH wireless] wifi: mt76: mt7615: do not tear down BSS/STA state for monitor vifs
Date: Thu, 13 Aug 2026 08:20:59 -0700
Message-ID: <20260813152059.15747-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Anthony Agarro <markanthonyagarro@gmail.com>

Tearing down a monitor interface oopses:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:mt76_connac_mcu_uni_add_bss+0x144/0x370 [mt76_connac_lib]
  Call Trace:
   mt7615_remove_interface+0x6a/0x200 [mt7615_common]
   drv_remove_interface+0x60/0x140 [mac80211]
   ieee80211_del_virtual_monitor+0x8f/0xc0 [mac80211]
   ieee80211_do_open+0x550/0x7d0 [mac80211]
   ieee80211_open+0xaa/0xb0 [mac80211]
   __dev_open+0x11b/0x280

mt7615_remove_interface() tears down BSS and STA state for every vif type.
On MT7663 with offload firmware that reaches mt76_connac_mcu_uni_add_bss(),
which has no monitor case in its iftype switch. It takes WARN_ON(1), then
copies ETH_ALEN from vif->bss_conf.bssid, which is NULL for a monitor vif.

mt76_connac_mcu_bss_basic_tlv() in the same file handles this. It has an
NL80211_IFTYPE_MONITOR case and it copies phy->macaddr in place of the
bssid. The uni variant has neither.

There is nothing to tear down. mt7615_add_interface() only calls
mt7615_mcu_add_dev_info(). The BSS and STA state comes from beacon enable
in mt7615_bss_info_changed(), from mt7615_set_key() and from
mt7615_mac_sta_add(), so a monitor vif never has any.

Reported on mt7615e going from monitor back to managed, and on mt7663u on
an "ip link set down", both through ieee80211_del_virtual_monitor().

Fixes: d9852ab2f362 ("mt76: mt7615: keep mcu_add_bss_info enabled till interface removal")
Cc: stable@vger.kernel.org
Reported-by: Orly Orge <orlyorge2004@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/CANj5C4mTOHs6riyWee=dFdkE5p=714J8xs-x3hq3ewQ+r6O_Nw@mail.gmail.com/
Reported-by: Inanix <contact@inanix.fr>
Closes: https://github.com/morrownr/mt76/issues/79
Tested-by: Inanix <contact@inanix.fr>
Signed-off-by: Mark Anthony Agarro <markanthonyagarro@gmail.com>
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index fc619ac..986fde1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -254,8 +254,10 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 
 	mt7615_mutex_acquire(dev);
 
-	mt7615_mcu_add_bss_info(phy, vif, NULL, false);
-	mt7615_mcu_sta_add(phy, vif, NULL, false);
+	if (vif->type != NL80211_IFTYPE_MONITOR) {
+		mt7615_mcu_add_bss_info(phy, vif, NULL, false);
+		mt7615_mcu_sta_add(phy, vif, NULL, false);
+	}
 
 	mt76_testmode_reset(phy->mt76, true);
 	if (vif == phy->monitor_vif)
-- 
2.55.0

