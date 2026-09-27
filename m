Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5093D3485;
	Sun, 27 Sep 2026 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790503888; cv=none; b=Ol5pqE1Vk4ul9lg9wAO12HDqCOtIcvkpiVIhTuiIv7VkDArDSetkYPBfRLvnaVK4VWkJamgZJ6w8BPmHQLnPEjFEjyGfICcJLsZd8bbWzQ32ePHz+UYzgP8lI6AG/FAkmlfxeUoyu7eG/cf500bUr+kbrjCsHFSLFsTUcgxjQaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790503888; c=relaxed/simple;
	bh=zwkk6zip1mpRhgxkj/PrPoXhBOA1BmeuosTU7gj9A/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UyanJY5J4nZECD9r4Raxl5K13HR+6CTkhsxuvUWqCtxKiyLM3VOPqnGnQ0T5X0k7npDnMYYMMnT6y5ZbnjpW+yZamnmorhVYqgFKeZ9RUV489IXExctGgFNFOMtG5IrsSisXj8YpydW26QGtprJUuiREGAeW/2FuQVM1WC9nnDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lf6wZSq3; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lf6wZSq3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GM
	5K3YMcvdK6ZyeBlGyhLaLE+gMTP73HJSvrqEJgq7k=; b=lf6wZSq3haUkfV3A+q
	fbSDB1uG3Ch6cXFx0NOtpxEYeuFOEnwi+dkEE/5O1u96q7LbOVEV+zi2rdU8zU60
	gYfiURpavW1TaYPQB51PMxli2saZPg43nxBdtvs86AlriiDjNOuDWaiJPSaFwJgA
	24OliH9h4ivqFTH7cCpIXlkew=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnn52j67hqFV5yBA--.63529S2;
	Sun, 27 Sep 2026 18:10:44 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7615: cancel reset work during unregister
Date: Sun, 27 Sep 2026 18:10:40 +0800
Message-Id: <20260927101041.957362-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnn52j67hqFV5yBA--.63529S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW3XFWkKw4kKF4fZrWkZwb_yoW8GFWDpa
	y5K3y5u340gF4DKw4UZa1xAa45WanagrW3Cry8Xw4UW395AryFyrW0vFyjy340ya1kCa4Y
	yrWUtry3ua4qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piPCztUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQXsJ2q466WNDQAA3f

The MCU error interrupt handler queues reset_work on the device workqueue.
Device removal can reach mt76_unregister_device() while that work is still
pending, since the workqueue is not destroyed until mt76_free_device().

If reset_work runs in this window, it operates on an unregistered hw and
can requeue mac_work after ieee80211_unregister_hw() has torn the device
down. Cancel it before unregistering the device so it cannot outlive the
registered hw.

Fixes: 61c4fa721968 ("mt76: mt7615: implement hardware reset support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index a9178e077fd6..7d8580720cd8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -116,6 +116,7 @@ void mt7615_unregister_device(struct mt7615_dev *dev)
 	mcu_running = mt7615_wait_for_mcu_init(dev);
 
 	mt7615_unregister_ext_phy(dev);
+	cancel_work_sync(&dev->reset_work);
 	mt76_unregister_device(&dev->mt76);
 	if (mcu_running)
 		mt7615_mcu_exit(dev);

base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.34.1

