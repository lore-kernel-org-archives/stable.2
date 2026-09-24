Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B44934D389;
	Thu, 24 Sep 2026 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256057; cv=none; b=BAJHhbBHX79FFQcAUidp5gJo5Fb1sgtkVKx1tQ0nm47kXrjVWb2w47PUVnz8K+X7APcfsul5/Y0knIoIsQ8/c/ptKljyRkoFRIS1Hk/0WECbbQZ93vM963Pd6WWQfzN/EnHoWC9b0vqnJEpHVhoAsRIckcp+VxFDv/jh4Kn0ybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256057; c=relaxed/simple;
	bh=/n5a+nOn9rC3CW57MZuoHNtmK8uyZkfzVEHrkL16BSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Me6/QVRiuLcLWWBiBrbQtScJ5GFyqE74d1+yshhf+TBWg+D1SjqUNkoabzBBkK4kbKh/76r+QbR3t5DHyd3Dc4d2MhRXFxbz0JwGYyA0il/ytuSfYkS7vGQlqumHit2tt4SAgptj80CnA9MEnDPTzjF8cnKHrBkv8McI0KQWn40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M/mnBXT4; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M/mnBXT4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ov
	hWLiAmSVeUcRiZOSiSzgt8c6ktpzexIIkYN0GRrD0=; b=M/mnBXT4aCvmAaUIDT
	f0rxoPud8wmEs3aWtmVNG7nfnjOLQgCuOwW6gANFWhsetTR54p0hBASfqy61/Ui+
	ze7XHG0PaYYRUAAMXjIb3ZC0bPQpdzPLtp+wD+LhUS6UrVkt91NRSYzepH5q3MSl
	ArAsj11ukCtPWMVYkinh/5x2g=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3d5ROI7Vqq0FrAg--.32720S4;
	Thu, 24 Sep 2026 21:19:26 +0800 (CST)
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
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Ville Nummela <ville.nummela@kempower.com>,
	Marek Vasut <marex@nabladev.com>,
	Rong Yan <rong.yan@mediatek.com>,
	Deren Wu <deren.wu@mediatek.com>,
	Hao Zhang <hao.zhang@mediatek.com>,
	Nelson Yu <nelson.yu@mediatek.com>,
	Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
	Amitkumar Karwar <amit.karwar@redpinesignals.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] wifi: mt76: mt7925: unwind link BSS add failures
Date: Thu, 24 Sep 2026 21:19:02 +0800
Message-Id: <20260924131908.950229-3-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3d5ROI7Vqq0FrAg--.32720S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr47trWfAr1kAFyxZryrJFb_yoW8Ary7pr
	ZFgFWjkryDGa1DKw4UCw18ZFW0van5Kr1j9ryruw1rZws3Ar1fArWjva4UZry0kayvka1U
	Xr4DtrnxuFZ8uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEl1v7UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzR7nImq1I141qwAA3q

mac80211 does not call remove_interface() after add_interface() fails, so
the driver must undo any state it published before returning an error.

mt7925_mac_link_bss_add() reserves vif and OMAC bits and publishes the
station WCID before asking the firmware to add the device.  If that command
fails, the function currently returns with those resources still installed.
The WCID pointer then refers into vif private data that mac80211 can free,
and the mask bits remain permanently allocated.

Use the existing link BSS removal helper to undo the published WCID, mask
bits, and WCID resources when the firmware add command fails.

Commit 2fb6480c52f6 ("wifi: mt76: mt7915: unwind state on add_interface
failure") fixed the same failure-unwind issue in mt7915.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 5993b31e1aae..25ad3bbdcd2c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -439,8 +439,10 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 
 	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf, &mconf->mt76,
 					  &mlink->wcid, true);
-	if (ret)
+	if (ret) {
+		mt792x_mac_link_bss_remove(dev, mconf, mlink);
 		goto out;
+	}
 
 	if (vif->txq) {
 		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
-- 
2.34.1

