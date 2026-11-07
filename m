Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047557;
	b=x9gG3QH5aXHe048Oing41huzqI6aD5VCt6QP6L3Qq8Oud6RcghlntzsmKlkzQNfTDRcL
	 /A7uSzTDJqrYFm7xYwshTbdCJmaPTcXm0FkSHQI0MheqFNCUjfzkBLZDpZEZqRHChnNFr
	 sd8G8jZbJ/XMaJGz4LU7uyccqpe03XcLIki5/Cj2KWsvLvhSkr26y98XjoNKIdNyiM5UH
	 ecfgHVU9MuoiRABUbKAM8c2tRA3hV8AiVce8gnZD9fpRrvhgh6k9PNGXBmPCGIDtBtrl/
	 aHOJyj2Ui1L+4i1RWfhRyk9S7SteybCXf9yLORvTXDiu+NbcHHmmDGouR5dEtGsXZOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047557;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pE2Pzv1DH0s6oJxOP5wzzphpYmSHK8Nlxyasq0KyhVg=;
	b=yKYelOXRZml97QX7qkf3aemTdKtNRyE0ZbMEyvcQ2q/C+2aQw7mp00ha6ubKVtjarmMd
	 H4WMSlu3dLjgK86Qjf0dBoQcKpN0sW4I1fIfT0E4SHtI0j8rjWGhXtfwb91+lElfpFrSM
	 1ar9uxdg0jDQhLLlPbS5EAHMvf2/+XUdGIa+L7p7t5FxGu+p1h+VU94TEeTbcppVJJepG
	 Nnwg0p8t+Oj6vy7S48io0Z6qDeHS51iZ8BG+1SJ4YbMh6tc7ViUNatrwCE+io4XSVEiTR
	 1DM35sUzpyjlW3XBXYrUnvXYLaAWiFOz7Y+N5DUGkRy7f9/2NbwyZsqNXz/lfrMDVuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ODmkNbNh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A911606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ODmkNbNh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0577C1F0089F;
	Sat,  7 Nov 2026 10:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047557;
	bh=pE2Pzv1DH0s6oJxOP5wzzphpYmSHK8Nlxyasq0KyhVg=;
	h=From:To:Cc:Subject:Date;
	b=ODmkNbNhe8lghWE5r2a04/kQ1f85n0YH1zIOfLglYK5O5j3wDBclciqWS4nNwZZZ9
	 rD+aISWePQtoB5jpREsC3jG2TwO5fWRGbTrTSZ6LEChp0mi7p8Do8InvME2AmsTLRh
	 A7Ew2yTkFBAd3eAJ1VTJyUWEu0a7jjLNT3e/5iCuY6A7RsCiSLEHiHO07Q+zSZfFP9
	 nLb9yNeiknhRLQWxeiCjxWwqQBJJm/oXr/JRmhiUW/bR/enToXS5y93LPXy0xOvFNW
	 jBRnK12CnJqHEIx8X9Ju6VbzlTbX9/xbDKQOY5DEqC3j4SNhj1rcpRaB7RH6Ucg3nc
	 DrbVh9D0piNHA==
From: Sasha Levin <sashal@kernel.org>
To: yanglinlin@kylinos.cn,
	nbd@nbd.name
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7996: fix PCI device reference leak in mt7996_pci_init_hif2()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:32:36 -0500
Message-ID: <20261107053235-failed-6.6-d92bac6b6af2@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d92bac6b6af2602516ee82ae112709c71af27cf6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053235-failed-6.6-d92bac6b6af2@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d92bac6b6af2602516ee82ae112709c71af27cf6 Mon Sep 17 00:00:00 2001
From: Linlin Yang <yanglinlin@kylinos.cn>
Date: Mon, 24 Aug 2026 17:29:37 +0800
Subject: [PATCH] wifi: mt76: mt7996: fix PCI device reference leak in
 mt7996_pci_init_hif2()

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
---
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
index b7d9193e042f4..a7c23b33dde0b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -63,12 +63,18 @@ static void mt7996_put_hif2(struct mt7996_hif *hif)
 
 static struct mt7996_hif *mt7996_pci_init_hif2(struct pci_dev *pdev)
 {
+	struct pci_dev *tmp_pdev;
+
 	hif_idx++;
 
-	if (!pci_get_device(PCI_VENDOR_ID_MEDIATEK, MT7996_DEVICE_ID_2, NULL) &&
-	    !pci_get_device(PCI_VENDOR_ID_MEDIATEK, MT7992_DEVICE_ID_2, NULL) &&
-	    !pci_get_device(PCI_VENDOR_ID_MEDIATEK, MT7990_DEVICE_ID_2, NULL))
+	tmp_pdev = pci_get_device(PCI_VENDOR_ID_MEDIATEK, MT7996_DEVICE_ID_2, NULL);
+	if (!tmp_pdev)
+		tmp_pdev = pci_get_device(PCI_VENDOR_ID_MEDIATEK, MT7992_DEVICE_ID_2, NULL);
+	if (!tmp_pdev)
+		tmp_pdev = pci_get_device(PCI_VENDOR_ID_MEDIATEK, MT7990_DEVICE_ID_2, NULL);
+	if (!tmp_pdev)
 		return NULL;
+	pci_dev_put(tmp_pdev);
 
 	writel(hif_idx | MT_PCIE_RECOG_ID_SEM,
 	       pcim_iomap_table(pdev)[0] + MT_PCIE_RECOG_ID);
-- 
2.53.0




