Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C753FA5F0
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701059; cv=none; b=QrGp/FmhVrwMTDZj/Df2Dhm965JftItMa3dBta0YQv96MNJmRE3yobJTPyxO/+NJn0w0v1Nr0tVyCOAj95mv4w1RfVnucc9Y4GJsZ3VGISoe4xXbXJKM8tald7P4PW9XBFbd3j2SIlBBRhNJKpOVvkhVWJ6HHekbfRatMsHBvNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701059; c=relaxed/simple;
	bh=sNPYGlDA7jRHoYUfQHreIRnO3qOs2vcsgERDxz1ZwCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LE8PuUOQKalrlPasBpmFBw4aJuvVvuFTjjYTIdVfNqhVg1VWUcZ3e74FfJ/FehWU53cr6QPOFT3+s+bDqkV15Xmt0qztJOwYgepkxo6k0QJZHEQDVB1BEEvFLd8uL725Jr7cIoGOEmuBhVowFYohfXnARWPpoUZxWr3GrGhYEwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from ajratkogda.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	(Authenticated sender: ajratma)
	by air.basealt.ru (Postfix) with ESMTPSA id 9A4E3233AA;
	Wed, 17 Jun 2026 15:57:31 +0300 (MSK)
From: Ajrat Makhmutov <rauty@altlinux.org>
To: stable@vger.kernel.org
Cc: 'Sasha Levin ' <sashal@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Quan Zhou <quan.zhou@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 3/3] wifi: mt76: mt7921: fix potential deadlock in mt7921_roc_abort_sync
Date: Wed, 17 Jun 2026 15:57:14 +0300
Message-ID: <20260617125714.1663242-3-rauty@altlinux.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260617125714.1663242-1-rauty@altlinux.org>
References: <20260610080943.17734-1-rauty@altlinux.org>
 <20260617125714.1663242-1-rauty@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

commit d5059e52fd8bc624ec4255c9fa01a266513d126b upstream.

roc_abort_sync() can deadlock with roc_work(). roc_work() holds
dev->mt76.mutex, while cancel_work_sync() waits for roc_work()
to finish. If the caller already owns the same mutex, both
sides block and no progress is possible.

This deadlock can occur during station removal when
mt76_sta_state() -> mt76_sta_remove() -> mt7921_mac_sta_remove() ->
mt7921_roc_abort_sync() invokes cancel_work_sync() while
roc_work() is still running and holding dev->mt76.mutex.

This avoids the mutex deadlock and preserves exactly-once
work ownership.

Fixes: 352d966126e6 ("wifi: mt76: mt7921: fix a potential association failure upon resuming")
Co-developed-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Link: https://patch.msgid.link/20260126180013.8167-1-sean.wang@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
(cherry picked from commit d5059e52fd8bc624ec4255c9fa01a266513d126b)

[ALT: keep del_timer_sync() instead of timer_delete_sync() — the
 timer API rename is not present in 6.12.y. ]
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index f2fffca868b51..99561094640f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -365,12 +365,15 @@ void mt7921_roc_abort_sync(struct mt792x_dev *dev)
 {
 	struct mt792x_phy *phy = &dev->phy;
 
+	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		return;
+
 	del_timer_sync(&phy->roc_timer);
-	cancel_work_sync(&phy->roc_work);
-	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
-		ieee80211_iterate_interfaces(mt76_hw(dev),
-					     IEEE80211_IFACE_ITER_RESUME_ALL,
-					     mt7921_roc_iter, (void *)phy);
+	cancel_work(&phy->roc_work);
+
+	ieee80211_iterate_interfaces(mt76_hw(dev),
+				     IEEE80211_IFACE_ITER_RESUME_ALL,
+				     mt7921_roc_iter, (void *)phy);
 }
 EXPORT_SYMBOL_GPL(mt7921_roc_abort_sync);
 
-- 
2.50.1

