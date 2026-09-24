Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7417B46C833;
	Thu, 24 Sep 2026 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256057; cv=none; b=it8TU/oxVlDFm2alF+a5XCrLIE4kMl6WVJrkKar9UfsrX3Dq6owC+CK2fueRcBYOm3ykG2QYJ6i2dhRKNFy0nNh1cRKyyrrLwgfapDPdooa6ptNvyikCToBSFePZp8f+Z5+HYbd19+k/u3dhuvULOjkCO3DpesReJFP2k45/QFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256057; c=relaxed/simple;
	bh=FSnqtKcDg8w5pPHPJybQRNTxbIRGTAm59dUPQ6CDzPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VzbA0tAXeiRrc2eR46+lSxLcq3CMCjniDhtsYpEo3Pee1XQ6a1KJUWNNC79C3dlLlNHUt6aLuT5TL3hgKHe4JrFST9maqrgQ9bxNAlxBM6++YNHHkqJ0AdYXu9vdds+WLJt1oTxZa3RO0dR7HXFRw/5OeSGMhEvk3EH/HF8EVCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S66dTXwE; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S66dTXwE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=li
	hAyBuquZIbZWcutVuY8mTNAbIEE8ErIPZuIuxaZb8=; b=S66dTXwEVaN3E3z5N9
	g2Ng2Ff579FLzDegik66tF9xbnXdRIA1LqBAYQsN6o/HaNgcYdBIzvxqsKthyyHX
	efGHixF4Z3m6CAYq2xv4J94y2gc3IT2+uwNHCoAs9FwW3X7cTijrgjbPTvExF3sW
	GSts7VtDkXzh4uJ2Dn+ZO6QKk=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3d5ROI7Vqq0FrAg--.32720S3;
	Thu, 24 Sep 2026 21:19:19 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Javier Tia <floss@jetm.me>,
	Leon Yen <leon.yen@mediatek.com>,
	Eason Lai <Eason.Lai@mediatek.com>,
	Marek Vasut <marex@nabladev.com>,
	Ville Nummela <ville.nummela@kempower.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Quan Zhou <quan.zhou@mediatek.com>,
	Hao Zhang <hao.zhang@mediatek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
	Amitkumar Karwar <amit.karwar@redpinesignals.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] wifi: mt76: mt7615: unwind add_interface failures
Date: Thu, 24 Sep 2026 21:19:01 +0800
Message-Id: <20260924131908.950229-2-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924131908.950229-1-yaojiale02@163.com>
References: <20260924131908.950229-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3d5ROI7Vqq0FrAg--.32720S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr47trWfAr1kAFyxZryrJFb_yoW8Kr4rpr
	4UKFZ0kr1kJr15ta1fC3W7ZFyrWw4fKry3Cr17uwn5uwn5AryIvF4Yya42vF9YyrW0kF1j
	vr42yan8WF95uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi_M3tUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xflIGq1I1dJuAAA3n

mac80211 does not call remove_interface() after add_interface() fails, so
the driver must undo any state it published before returning an error.

mt7615_add_interface() records a monitor vif before resource allocation,
and later reserves vif and OMAC bits and publishes the station WCID.  An
allocation or firmware failure leaves some or all of that state behind.
The stale monitor_vif can then be used by the testmode transmit path after
mac80211 frees the vif, while the leaked mask bits permanently consume
interface resources.

Unpublish the WCID and release its resources when adding device information
fails, clear the reserved mask bits after failures that occur after their
allocation, and clear monitor_vif on every failed add.

Commit 2fb6480c52f6 ("wifi: mt76: mt7915: unwind state on add_interface
failure") fixed the same failure-unwind issue in mt7915.

Fixes: 4f0bce1c8888 ("mt76: mt7615: implement testmode support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 67f56e428d9a..d20b109666dc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -219,7 +219,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 
 	ret = mt7615_mcu_set_dbdc(dev);
 	if (ret)
-		goto out;
+		goto err_mask;
 
 	idx = MT7615_WTBL_RESERVED - mvif->mt76.idx;
 
@@ -237,7 +237,24 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	}
 
 	ret = mt7615_mcu_add_dev_info(phy, vif, true);
+	if (ret)
+		goto err_wcid;
+
+	mt7615_mutex_release(dev);
+
+	return 0;
+
+err_wcid:
+	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
+	mt76_wcid_cleanup(&dev->mt76, &mvif->sta.wcid);
+err_mask:
+	dev->mt76.vif_mask &= ~BIT_ULL(mvif->mt76.idx);
+	dev->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
+	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
 out:
+	if (phy->monitor_vif == vif)
+		phy->monitor_vif = NULL;
+
 	mt7615_mutex_release(dev);
 
 	return ret;
-- 
2.34.1

