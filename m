Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BD530D3FA
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002045; cv=none; b=LWf7cMJs3lp+FKEexDxka+Zgby5KEkSgNW2jVs8j38xadsuJBKzAN9d2EQc2o3MKl8P2ob/tPYhHUAhkAOeLP3OA88G9HOPdQbpyXieYjNNuLqXxebu5pU69EzVPIuuNB5et2Z0TMNNyHpnG0ko5fv32u2lY3bjgLHie24TeWfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002045; c=relaxed/simple;
	bh=rM2te2wBoXEQy9T+6fLHvmmUVetPgaNwnq1RuNWUYV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mloFrbPgC4zEjTABt4xxDke+RLydHTd+iJaBjbrsOCRi6Vs7ZRJAc0kEW7Mkc35wktoB+k2qZsHpaJDnbU0ALCvCjVDSOU1lh1bh+cUSbsNpVzju9SQn8/VwhR6Hg++WerzdQ8Hb+NYDhu7bs8rHIXFDRwEgxfZqckgUA1vZdig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/bGbQWY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/bGbQWY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812A01F0089B;
	Thu, 10 Sep 2026 01:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002042;
	bh=fZLJzGCaR/3xkKTHd7/0k4gkmKowMNUBmSgGITWFyE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c/bGbQWY/8Fyo5cOa494ykvfQPZcylUuFGgmtQIF0Aztzhj5XgruqelqZ5eenZ2HK
	 gpjBf9Th9sL0w/OHhMsjALLhP32eS17mAeDvN/TA8fOh4ZOC7QmQelEtD1a464nW2K
	 jpxZseM5YZp3butb49kXKNbZ7hzvMisfvYDc03ibuT2HtCeg2fjvGUxNPVKy/rypuJ
	 1z0H7rtuSvroq05wisFC/bKHHTy2VFmt7drvKQV5g1JMwNxlHJTgqZzRSdI+LWHF5x
	 YNwUmteV3l4OVrC4voRmHO9ug1YPxOcYs1rcG0KxcTcHomun86xmyXPxs+adeeZvfY
	 jW4x++mQ1XC7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] wifi: mt76: mt7615: avoid waiting for mac work under the mt76 mutex
Date: Wed,  9 Sep 2026 21:00:37 -0400
Message-ID: <20260910010037.3789515-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910010037.3789515-1-sashal@kernel.org>
References: <2026090448-broiling-unsworn-6960@gregkh>
 <20260910010037.3789515-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit bda8324270b1ac91bfba1df8928e0570e29759e8 ]

mt7615_suspend() acquired the mt76 mutex and then called
cancel_delayed_work_sync() on mac_work.  mt7615_mac_work() acquires the
same mutex via mt7615_mutex_acquire() at the top of the worker, so if
mac_work is already running and blocked on the mutex, the suspend path
deadlocks waiting for the work it holds the mutex against.

Flush scan_work and mac_work before taking the mutex, matching the
suspend paths in mt7921 and mt7925.  scan_work only takes the mt76
spinlock, but moving it keeps the sequence consistent.  This also keeps
mac_work from running over an already suspended HIF, which the previous
split (async cancel under the lock, sync cancel after release) would
have allowed.

Fixes: c6bf20109a3f ("mt76: mt7615: add WoW support")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Link: https://patch.msgid.link/20260612041331.2596331-1-runyu.xiao@seu.edu.cn
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index c67ac255059d9..7c05fc6e8c1b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -1143,11 +1143,12 @@ static int mt7615_suspend(struct ieee80211_hw *hw,
 	cancel_delayed_work_sync(&dev->pm.ps_work);
 	mt7615_free_pending_tx_skbs(dev, NULL);
 
+	cancel_delayed_work_sync(&phy->scan_work);
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
+
 	mt7615_mutex_acquire(dev);
 
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
-	cancel_delayed_work_sync(&phy->scan_work);
-	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
 	mt76_set(dev, MT_WF_RFCR(ext_phy), MT_WF_RFCR_DROP_OTHER_BEACON);
 
-- 
2.53.0

