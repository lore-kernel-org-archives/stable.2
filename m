Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436283;
	b=CCh6pG/9iBe4NXnOPMOBH3FCkvHZHlAhgW7YgzsieYsygimTdxyFCq0PYmUOxdCRA1t+
	 AXsWQWzZUqSZXrQuhe/DeHPzqz0UEmlaQFXwqHGB5tvo+xC2UlHG4/bJlpiBTrwNtLk8O
	 CopItPAnHORAVfFKX8VgzDLAmYamINXrJuYnlvm56EBr3tcqj7Q7RBS0k/YGRxr17MBTZ
	 96/eje0Jax9arRU8GigNIbIPELMmA6S5oqlse7HmSIbkIo4ghbnJ++Ib+TQ1PGpMyeYZV
	 p4563YQ+wjlDt8L3tutu5ZWZR7WCe6IYesIAtoAeB0cJ2v8zdJq3kATj1l6NinQbSbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436283;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=b1BuxtuQuon1BSm2D8m6Q2zpCxPr8buK7X0jNDt1RDQ=;
	b=iZovEvSIJuaWTAnUtR1PeDbd9Qsy/pZlo8lttdaUrD0qjrAHc69ADJFwKPqf6TShrLk7
	 ApPRKNJYFM/PYssJcieimS+E7eLV74mqI4SbkL0qZegywOTvC/Yh98Q8/SKd7kP+LM4I1
	 hslBEgzRserXXdvnH5ov+2Z3zpWdqZoI57PskDJt5G96Zhie05Als1JsXpVNkDjWhS2wP
	 Tg7ALOzs/WG6euVqSY33YOIop9RYYZkDr5/ncadT6W46xvfgXqBs3RDbmRjOicWIo2WbA
	 jaR6U/ip2+vqTocni0fIuBTa8fiUHCBBKZ67Dvjzb9IvhfRilxWgsy1EcsC2mpk2VYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EmPOeL2C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B693606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EmPOeL2C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54CF1F00A05;
	Wed, 11 Nov 2026 22:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436283;
	bh=b1BuxtuQuon1BSm2D8m6Q2zpCxPr8buK7X0jNDt1RDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EmPOeL2CdZpAEWISdCjPEPN0cUBRHznaYxjAMsogVLTTg7/82OqIileYw9ZuDlI9f
	 46jG75hJqtkpNsewFlYG3M19PtzVLuu38lh7mWeo6Pj9QF1/eI3Zzo2VQmSP3B9GC+
	 HJKSvGMiOtRtneOETmPcY19PPZCNwbOLLzTnBSgRpBW+vQNDhoyzi/9f/BLhSBx8EB
	 9I8kUR9Ih7OwQGon1wWyFiF+qbHBdCsz0GFCdXiUFK3mpKkgM61wc6jqvUvRFcAhaC
	 iLbHSQzjnl8P+HcVgdxZNTqAnNn2Lh2bDlqA7+1lW4f2CDvCvgv/vXE1e4EvBodhe+
	 6xLb6MLxborKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Linlin Yang <yanglinlin@kylinos.cn>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] wifi: mt76: mt7996: fix PCI device reference leak in mt7996_pci_init_hif2()
Date: Wed, 11 Nov 2026 17:31:21 -0500
Message-ID: <20261111223104.65164-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052005-failed-6.12-d92bac6b6af2@kernel.org>
References: <20261107052005-failed-6.12-d92bac6b6af2@kernel.org>
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

From: Linlin Yang <yanglinlin@kylinos.cn>

[ Upstream commit d92bac6b6af2602516ee82ae112709c71af27cf6 ]

pci_get_device() increments the reference count on the returned
struct pci_dev. In mt7996_pci_init_hif2(), three pci_get_device()
calls are made but their return values are only checked for NULL
and then discarded. pci_dev_put() is never called, causing a PCI
device reference count leak.

Fix this by storing the return value and calling pci_dev_put()
before returning, following the same pattern already used in the
sibling driver mt7915/pci.c.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Signed-off-by: Linlin Yang <yanglinlin@kylinos.cn>
Link: https://patch.msgid.link/20260824092937.683240-1-yanglinlin@kylinos.cn
Signed-off-by: Felix Fietkau <nbd@nbd.name>
[ sashal: adapted device lookups to use only the two existing numeric IDs instead of named constants for three chipsets ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
index dbd05612f2e4a..3cb5678932427 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -61,11 +61,16 @@ static void mt7996_put_hif2(struct mt7996_hif *hif)
 
 static struct mt7996_hif *mt7996_pci_init_hif2(struct pci_dev *pdev)
 {
+	struct pci_dev *tmp_pdev;
+
 	hif_idx++;
 
-	if (!pci_get_device(PCI_VENDOR_ID_MEDIATEK, 0x7991, NULL) &&
-	    !pci_get_device(PCI_VENDOR_ID_MEDIATEK, 0x799a, NULL))
+	tmp_pdev = pci_get_device(PCI_VENDOR_ID_MEDIATEK, 0x7991, NULL);
+	if (!tmp_pdev)
+		tmp_pdev = pci_get_device(PCI_VENDOR_ID_MEDIATEK, 0x799a, NULL);
+	if (!tmp_pdev)
 		return NULL;
+	pci_dev_put(tmp_pdev);
 
 	writel(hif_idx | MT_PCIE_RECOG_ID_SEM,
 	       pcim_iomap_table(pdev)[0] + MT_PCIE_RECOG_ID);
-- 
2.53.0

