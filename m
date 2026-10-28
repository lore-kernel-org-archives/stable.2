Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163432;
	b=DtykDYdaYLTAZ97Vabh9RWgL2Ku/7CVz76p5Wr0HqHjGSc/wKzvjCnLBPocxkB3gG2aE
	 ROCmbDUWq4MjtMunGIk4SUTBtX+sdfmChZPTl0QtjZgOq+R31mmxDyxS/3RqKcmyK2n40
	 RaUNivEciKYdIvPelAe/UL31VJco767FRjJ9md/mm3OiwgUteMkI2tmQkoZjU2fVvHTAt
	 ZM65585m7j8cqJdNHicToSw2CQoP1qSV+m1wLPYcPX5K98rU3e0g7soO2XaqCmfM9QrJo
	 7tVzagHcAwmhG//9ZuzzKHhT1RFaacnteiEjaCjQ7GimyjEr7jW57bUeFvW+29jjsBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163432;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=oqFzpPIOsYawPJQ8wrBui5JE3wbzUk29Kop9UX3xfbE=;
	b=bCzZ5nbRRlkdfYTuf4wCxsE1czU151pcvmFGEB4NzboqNwtvrnRb05Q3X4BR9zmuT4sZ
	 fLI+laygp87oCZ2vD/sW/SzoWmqXyOEpKDq0J8Do/8wjT8OYibLJeAg4JN75QVIZH81vy
	 U00X+n0e7lw7h22NHLl7LqcF6X/MzTaAYhkn8bFerc603GwyuAsm9/XZAiU+W+HD0ohqZ
	 QsCnioVW7eO6WuWMXy7rcUbFMWdVPnpgAbaVdCD4XNWWKht1+3cZ9JB9UJuxGCzaMhaia
	 DgJUxCprAe6yKXEsLsCofDHc+l6n6RVyJccVFXFGBa9h3Mpt1D2eM2uDcgPV3hm7Opw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Z419Tq8o;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA93606A31D;
	Wed, 28 Oct 2026 04:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAA93606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Z419Tq8o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oq
	FzpPIOsYawPJQ8wrBui5JE3wbzUk29Kop9UX3xfbE=; b=Z419Tq8oLy6kVM5E47
	xrwRESrXv0q0Ey+kkXjEakKq+jCBZEEq7E/YGXNyX2+ix+1i6wx2a7c9H0YciRQ6
	BFYx1i8eqdfFtO4iIOghzt8NvPcbdzkZY6aOdXJwn53AcfuRaYDhyynVdfX7OGyV
	m/8n5ToS/xaHkFwI4ktkiJumw=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3XzKAgOFqq95iDg--.12927S2;
	Wed, 28 Oct 2026 12:56:33 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: drain mt76x02 DFS tasklet during teardown
Date: Wed, 28 Oct 2026 12:56:30 +0800
Message-Id: <20261028045630.112769-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wD3XzKAgOFqq95iDg--.12927S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4DJw4DGFWfZry8tr4ruFg_yoW8uw4xpF
	W7Kayjk345JF4UKw48Aa18AFy5Wan7Kry5GrWYv34rW34rAr1FyFWYgFy2yr40y3yq9a4f
	JF4jvr43GrZ5ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UgL0OUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQFTjWrhgIGC4wAA35

The MMIO interrupt path can leave dfs_tasklet pending when an mt76x0e or
mt76x2e device is removed.  Disabling the tasklet does not remove
pending work from the tasklet queue, and the cleanup paths eventually
free the device containing both the tasklet and the DFS state it uses.

Kill the DFS tasklet before tearing down the DMA engine and device
state.

Fixes: 7bc04215a66b ("mt76: add driver code for MT76x2e")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c      | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index f8d206a07f99..0c6befdbb98e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -224,6 +224,7 @@ mt76x0e_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void mt76x0e_cleanup(struct mt76x02_dev *dev)
 {
 	clear_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
+	tasklet_kill(&dev->dfs_pd.dfs_tasklet);
 	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	mt76x0_chip_onoff(dev, false, false);
 	mt76x0e_stop_hw(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
index bec84f932311..e454efab9739 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
@@ -280,7 +280,7 @@ void mt76x2_stop_hardware(struct mt76x02_dev *dev)
 
 void mt76x2_cleanup(struct mt76x02_dev *dev)
 {
-	tasklet_disable(&dev->dfs_pd.dfs_tasklet);
+	tasklet_kill(&dev->dfs_pd.dfs_tasklet);
 	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	mt76x2_stop_hardware(dev);
 	mt76_dma_cleanup(&dev->mt76);
@@ -317,4 +317,3 @@ int mt76x2_register_device(struct mt76x02_dev *dev)
 	mt76x2_stop_hardware(dev);
 	return ret;
 }
-
-- 
2.34.1

