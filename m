Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436464;
	b=TIKUUZJBOfrbLpT3CrQrwja2K0yaGO9iq/QQW3fVXQddcn8YP50mTCzX3w+tMF/jRUyF
	 79A7esUaVjzL2pNp/p+FFwhsAmmnhAo7NuLgp8Zr3vBdxNMJM6IkqIF2WWEGtZxcdo7aX
	 eJEwFZIq/noIEGXGIp+3B8p5NiNgyZJZK8Gvv3BdvlzOmFr6Kcaqc/v4vz+1jZb5wIN5A
	 2rmU5ZVj9RaqvWwgWmm8mnetNdW+jcugebKKflNLtdrEvDYJz+uxagXHZXrkBCJnWkuZe
	 woXfQdanwyOaPqtXCBxhSmlxqiJlwNIoCDyXOYAtaA3r2R+2j9287GFTwt9EKLYWBuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436464;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0PLOJ1T1UUcan3WdqBcG3xeVavQIUhdqomxF9/HCNho=;
	b=fG791kyRZrUreUq94NecZo3LkcUtu3q/K2tDgMkHsXILJLNP/lmvzS+612JW9wXeWKFN
	 SrdRHq9sw0NpycZONmPufwFiR6g0OooqnC21bvRzf6XodfdaFBpwSiAZFfOOXz2yBmcUB
	 9Sb/ChWO7ltNqaT/rZw18Gr3EbxSapUBr411x59doL1IA6MCjjQ08y7LAJrU/Vqa1Ul/V
	 +IwrLtxAjD5p4AEHJbE8ZZrBCs7jZB9To3TKsgaIYjRQKJrGWLYCesng1nA3Cth4BYdnV
	 4I7pxxPJjWcCa9fTeLHVCD03S9XnvdOIbtl90/drXGyBeysICMPM5LSFxAXTqLUvjpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYpOUvCN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF9606A888
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYpOUvCN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2D91F00A09;
	Wed, 11 Nov 2026 22:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436464;
	bh=0PLOJ1T1UUcan3WdqBcG3xeVavQIUhdqomxF9/HCNho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HYpOUvCNDgDvu+c2eXRudj36/jLkpiIu09sdJSZakhRHJojubYl3VQ0P9nQ3iMYuD
	 AUne4qtDL0EyBm4ZrUHfZ+7Mq/pMKiEK6SFCIs5nIHV745HaL8NtFN2jG6S1WPGo3Z
	 jXxbJqjnNn/3VxoJ+dRiFzi/W2WBwFI68byA9+nRsx97acAyYpadbeJfSRqHiHMa5w
	 uAfZaALHGraT8Ll3MUqG5qgEgQvFrbjih2obDHWSoSWiItkFIO/vkqvHVRXZXs/xUy
	 c65g7TGyLqV9Cj/eVE/jGH3xWWqdVWx6XyJ4dNBYRfW13dRwW/7xrFsm2SST8J9jqf
	 cKYRjt/1GQRUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Linlin Yang <yanglinlin@kylinos.cn>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] wifi: mt76: mt7996: fix PCI device reference leak in mt7996_pci_init_hif2()
Date: Wed, 11 Nov 2026 17:34:22 -0500
Message-ID: <20261111223404.85004-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053235-failed-6.6-d92bac6b6af2@kernel.org>
References: <20261107053235-failed-6.6-d92bac6b6af2@kernel.org>
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
[ sashal: adapted PCI device lookups to use two numeric IDs instead of three named constants ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
index 67c015896243f..ea832769336e3 100644
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

