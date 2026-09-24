Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD23481252;
	Thu, 24 Sep 2026 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256056; cv=none; b=fWE0RgNddomO+ITaJRkcG10ePsw93OrBrmcBL6R0Bk5gaBTTksGCV/RGUo8kzQIZXp14Q44yo87jtH4R0CF7+BMm5yO2c0btrHpbH1Tl8P7pDEbiCdDQTpjLA/fdxqdcEc9IqEp7RsugCQIkuejQgwhCaeuN2iNmTQPevj98ckk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256056; c=relaxed/simple;
	bh=H7nd8+NkvTtKkDbrYqkM1Xmy/y7FDgyoOxSX6BbeI3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B8sfXZLnFxorQQpdqJjr67vv/n7RQZgJffb9B6jAjbAqGX7rS7oL0kyZkmS7V0ykbXotCSVJkSlkudZLOdMKO2zytzCh+pnfdl43tD0tB3i9R43f9CQmjx5k0oOX1PYJwWKcZyaulnaqsIp3w++KbpJaIjKlelpK/SVG/USWq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BddsRQ/U; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BddsRQ/U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vQ
	W8S4/0nq/AUT2KXMkhDrRHQ+sSLWd9EBh9wzVJFG8=; b=BddsRQ/UiLWP+PRlyL
	BDidsUeLDDJvws1xa65WHPW0QI4UHUajHffdeNfePGsLHAlLAvVz0LovxiYzuz9d
	QnURc9i3rA2FK8yyBl4wy4phnH25wA3BrzAuH2j5YBBggbfp0qJwFqLqo//Akp1k
	s6CsqiDxbQQt5COTTAgOLAvkU=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3d5ROI7Vqq0FrAg--.32720S6;
	Thu, 24 Sep 2026 21:19:41 +0800 (CST)
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
	Nelson Yu <nelson.yu@mediatek.com>,
	Rong Yan <rong.yan@mediatek.com>,
	Quan Zhou <quan.zhou@mediatek.com>,
	Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Amitkumar Karwar <amit.karwar@redpinesignals.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] wifi: mm81x: unwind add_interface failure
Date: Thu, 24 Sep 2026 21:19:04 +0800
Message-Id: <20260924131908.950229-5-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3d5ROI7Vqq0FrAg--.32720S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr47trWfAr1kAFyxCr4DJwb_yoW8tr1kpr
	4kWrZ8KrZ8JrWrGa18Ca10vFyrXw4xGFW3CFy8Gwn5uF1qvr1fGFy5Aws0yFnYkFyfG3W2
	yrW0krn8W3ZxG37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piCeHPUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8A3rJmq1I21MFwAA36

mac80211 does not call remove_interface() after add_interface() fails, so
the driver must undo any state it published before returning an error.

mm81x_mac_ops_add_interface() publishes the vif through the RCU-protected
vif table and initializes AP beacon handling before querying firmware
capabilities.  If that query fails, the published pointer remains after
mac80211 frees the vif.  Interrupt processing can then retrieve and
dereference the stale vif.

Finish AP beacon handling, clear the RCU slot, and ask the firmware to
remove the interface when the capabilities query fails.  Preserve the
original query error if firmware cleanup also fails.

Commit 2fb6480c52f6 ("wifi: mt76: mt7915: unwind state on add_interface
failure") fixed the same failure-unwind pattern in another wireless driver.

Fixes: b1906cea00b0 ("wifi: mm81x: add mm81x Wi-Fi HaLow driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/morsemicro/mm81x/mac.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/morsemicro/mm81x/mac.c b/drivers/net/wireless/morsemicro/mm81x/mac.c
index 0fa80b1488aa..1edad7eace61 100644
--- a/drivers/net/wireless/morsemicro/mm81x/mac.c
+++ b/drivers/net/wireless/morsemicro/mm81x/mac.c
@@ -2169,7 +2169,7 @@ static int mm81x_mac_restart(struct mm81x *mors)
 static int mm81x_mac_ops_add_interface(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif)
 {
-	int ret = 0;
+	int cleanup_ret, ret = 0;
 	struct mm81x *mors = hw->priv;
 	struct mm81x_vif *mors_vif = (struct mm81x_vif *)vif->drv_priv;
 
@@ -2221,6 +2221,13 @@ static int mm81x_mac_ops_add_interface(struct ieee80211_hw *hw,
 		dev_err(mors->dev,
 			"mm81x_cmd_get_capabilities failed for vif %d",
 			mors_vif->id);
+		if (vif->type == NL80211_IFTYPE_AP)
+			mm81x_mac_beacon_finish(mors_vif);
+		RCU_INIT_POINTER(mors->vifs[mors_vif->id], NULL);
+		cleanup_ret = mm81x_cmd_rm_if(mors, mors_vif->id);
+		if (cleanup_ret)
+			dev_err(mors->dev, "mm81x_cmd_rm_if failed %d",
+				cleanup_ret);
 		return ret;
 	}
 
-- 
2.34.1

