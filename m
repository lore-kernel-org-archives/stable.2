Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4475E3D9DC5;
	Thu, 18 Jun 2026 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770484; cv=none; b=INa/d2jk+TnmkqHC1Jg//X8p6Z1BWhgODB9eaRf0hByWLekNGnK84/FLCzZJv9Lu6Qkso48ckHNuXBVzmNtwvPGkEkpZkdKSEc5tiIV5cac009KX5rYohTNykDajPxO4mjFlWBOC5h30ROimtPxi06uJYnJ1JS5UmPZVqpGzB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770484; c=relaxed/simple;
	bh=dirUu80z2rRakz164VfpSgvejFjaPGsxq/0YklLVnuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lv93L+5Ok9UrxoXBGxRlu+CD85NLBOczOkuFZ7tg5V/oUqGpugTkj+pbrL69P5In/r9njV38YZnHNuWTLc15QFQzJ1d0jU4+nqIg8oXJicl+jeOYEOfs65/unGDpBYDAW47WEK6WwWT8H0FYjD/MyEq78KN4MeI1440dTC54btM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from ajratkogda.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	(Authenticated sender: ajratma)
	by air.basealt.ru (Postfix) with ESMTPSA id 0C667233B2;
	Thu, 18 Jun 2026 11:14:36 +0300 (MSK)
From: Ajrat Makhmutov <rauty@altlinux.org>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	nbd@nbd.name,
	linux-wireless@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Quan Zhou <quan.zhou@mediatek.com>,
	Ajrat Makhmutov <rauty@altlinux.org>
Subject: [PATCH 6.12.y v3 3/3] wifi: mt76: mt7921: fix potential deadlock in mt7921_roc_abort_sync
Date: Thu, 18 Jun 2026 11:14:13 +0300
Message-ID: <20260618081413.17812-4-rauty@altlinux.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260618081413.17812-1-rauty@altlinux.org>
References: <20260617130826.1667503-1-rauty@altlinux.org>
 <20260618081413.17812-1-rauty@altlinux.org>
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
[Ajrat: keep del_timer_sync() instead of timer_delete_sync() -- the
 timer API rename is not present in 6.12.y. ]
Signed-off-by: Ajrat Makhmutov <rauty@altlinux.org>
---
v2: drop redundant "cherry picked from" trailer; tag the 6.12.y
    adaptation note as [Ajrat] and add backporter Signed-off-by. No code change.
v3: add cover letter with upstream/stable references; mark target 6.12.y.

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

