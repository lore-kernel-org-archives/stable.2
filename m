Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8119748550E;
	Thu, 24 Sep 2026 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256061; cv=none; b=mvH0j6aqvkEZxCLP3qdw/sy/gD334r1YVaUjiXpJdPBxJkeLUaE3Vk9zJnZQGe0a0crhgr2kOIq8bSVceuohRHxdE6E760C8EfoHEklg2okjFu4cdLDjYN8qgaffHZYbhKJKZpD4VDHENKAEbrmw0eV8klK5uCqLCZBhxRz01fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256061; c=relaxed/simple;
	bh=HwthhyVLeALg10vV6t3qDKnfJtJhKjmcFjIIsnOjOHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kLru2DinJAcAWnEe3dm8EvbZQ7xMp718nfL/ELJBxXgXTqVO/vDupwE4/gStmgs51QxmI0TjcAzd7IhSELw9GheufT16zzTJbaK9dtmon4W2/tpkqwwt2MyLwXtJqVgc9nAKUBQrA9yl7c2vZfOfFeK4AGQAS5VEO0LOZnd1P6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TG0Ulld8; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TG0Ulld8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nJ
	zntUbDfqeoG/uTtpJiDO8MUahdbbleXqqU3yFVq34=; b=TG0Ulld8Z8QDwbH5zo
	MXu+Gn9XOZp3KOvvoBFf4E8x9IJ1s/osEhLAVkVulolYKVc+Wt0N1o+ahu8ZEz1b
	e7akDDANl10uOOSJv7XQyQq0lzKl7Z2/bk3eiV2Kex5e+lJuTeHVJzLcLFKA3s93
	Y0UuIPpXKTL94Lb9z4qRBw3A4=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3d5ROI7Vqq0FrAg--.32720S5;
	Thu, 24 Sep 2026 21:19:32 +0800 (CST)
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
	Deren Wu <deren.wu@mediatek.com>,
	Hao Zhang <hao.zhang@mediatek.com>,
	Quan Zhou <quan.zhou@mediatek.com>,
	Amitkumar Karwar <amit.karwar@redpinesignals.com>,
	Kalle Valo <kvalo@kernel.org>,
	Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] wifi: rsi: unwind add_interface failure
Date: Thu, 24 Sep 2026 21:19:03 +0800
Message-Id: <20260924131908.950229-4-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3d5ROI7Vqq0FrAg--.32720S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr47trWfAr1kAFyxXryrZwb_yoW8Ww1Dpr
	4DK3s0kryrGr4aqw45Ga18ZFyrCan5KrW2kF18G343WF4YvFyfZrn09a4Uua93CFZ5Ja15
	Ar4qv34Yg3srGrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zifHUkUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQXpJGq1I2U2OQAA3T

mac80211 does not call remove_interface() after add_interface() fails, so
the driver must undo any state it published before returning an error.

rsi_mac80211_add_interface() stores the vif in adapter->vifs[] and
increments sc_nvifs before sending the VAP capabilities command.  If that
command fails, the function returns without undoing either update.  The
array entry can therefore refer to vif memory freed by mac80211, while the
interface count remains inflated.

Clear the vif slot and restore sc_nvifs when setting VAP capabilities
fails, mirroring the state cleanup in remove_interface().

Commit 2fb6480c52f6 ("wifi: mt76: mt7915: unwind state on add_interface
failure") fixed the same failure-unwind pattern in another wireless driver.

Fixes: b8bd3a439f35 ("rsi: add/remove interface enhancements for p2p")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/rsi/rsi_91x_mac80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index 3faf2235728b..34ddcbc43fdc 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -518,6 +518,8 @@ static int rsi_mac80211_add_interface(struct ieee80211_hw *hw,
 	if (rsi_set_vap_capabilities(common, intf_mode, vif->addr,
 				     vif_info->vap_id, vap_status)) {
 		rsi_dbg(ERR_ZONE, "Failed to set VAP capabilities\n");
+		adapter->vifs[vap_idx] = NULL;
+		adapter->sc_nvifs--;
 		mutex_unlock(&common->mutex);
 		return -EINVAL;
 	}
-- 
2.34.1

