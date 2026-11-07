Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046807;
	b=e0GXPTEGhH+VB2T5c7fC+4VDTDp8pChAdk5eFLZazfMDVDEUL9I18bzjEJORPcpWT6qB
	 MrRWH/gUUIQvfc3pf5lzVYOyd6gNsSFRaOZnT0eVqIwBCLEKd0Ifj7o3Dg4YwmyVN/WcD
	 YWcnF6Dw1kImQk6VQiPunWgvTeOmh4e3tQbR04plCfEl89EWvorsgH6z5bNQYOu/OISjL
	 euOu5kebsjZzeug5EHbASnnW3kgzMcsodllsXFqyAMK8btpFQvd92xiYsB3W4MkTZw76C
	 MDnRfR678BOsw9SQBzUYnqk2t7f26jRCSuiAD0R5/PVOvKJOEIVgIQJllQ16uc0yy7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046807;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tanLr9DY9E2Bhn/k1PWVbfP26Nvr0gGhlL2+n/WLpsM=;
	b=0vY++6t+fNqbghQ4l52N8Rnna/MIPwIo0clSvQWnS9cP717WZ/G0X/KwaBcHbIoln/vF
	 0wzqoy4ejwj0DjC/Vh8Li7FUenk1tMuJkQhhWMEXex9mpCXCqCGisrWee5RXqb9dAgfLM
	 G36h518YpvxLZ9peWjrN1Vq3gv64M4t2xu2KYo0zaRd9UUV/kIYbYXOu0zMWMyHiIFld8
	 XfOCHEb2euzTi8hgBAYyuUy+MZDJhGPOoLf0nkvRUoFlPAJJm9eOkq8FOpLxM9vPoS6Eo
	 wuwjkOOdTlbWKc/jnn12OkaoZ/i7bFxKMjgaRLAXvau7eXB4m3fgKyvYZcWZu2v1bRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQzQI95i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1253606D81E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQzQI95i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A24F1F008A1;
	Sat,  7 Nov 2026 10:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046806;
	bh=tanLr9DY9E2Bhn/k1PWVbfP26Nvr0gGhlL2+n/WLpsM=;
	h=From:To:Cc:Subject:Date;
	b=QQzQI95iWG9uOQL/vFKukxaML5Vw8xqbfOFKEXHeLvmlkXq+I/IHAL5rUgQJykmXj
	 Qs/KeBU7aK+yLKsn2VJt0tec0R8L/IVAFkRgtQn7+CzjIruhPC0+n2pt+rNBiJo3fv
	 e0lcpUUT/fwkofOEF60rpaAoSL/G9aS12TOma/UkwOqDp2jllt6qG8rQyZgftA5fO0
	 jMoMyQHlZaUXmBRLD/8zxoQbD89CHb0z1xfon9Kn0KtM7zpGNBTUod5Kf4c5p/TiXt
	 BhwiA873mKrNuxpRR+1p+0jBSlQGhQVj6rfVrkXarx9BCUhuXMR933qhi7HHpmwEcS
	 HCUruUCabVtCw==
From: Sasha Levin <sashal@kernel.org>
To: yanglinlin@kylinos.cn,
	nbd@nbd.name
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7996: fix PCI device reference leak in mt7996_pci_init_hif2()" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:20:05 -0500
Message-ID: <20261107052005-failed-6.12-d92bac6b6af2@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d92bac6b6af2602516ee82ae112709c71af27cf6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052005-failed-6.12-d92bac6b6af2@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




