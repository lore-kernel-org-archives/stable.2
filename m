Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934623469EE;
	Fri, 14 Aug 2026 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699772; cv=none; b=mvydSpR1lcfA45OPmUWo5WTOFAmDL7OCZ+J+tXVLF+OWadg7ddZEhVswMqBMa1kNs6wyNKKmmEuhQb7on4LBGAo12FKP6z82CBSNX3mGPtqWJVayz5cG+MPN5iqD1ncnWiSEjed/3R2x3QOSkAEl0ZBSsQzBzH7QhUzxY1kSdKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699772; c=relaxed/simple;
	bh=BBUm2SdUKKNFFTsHjyEsFktq+fiAN+s0e+LPQ3vnIoU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bxK94Ar45Nup8RQxSC8SjfdL2cT/04llCuqbJl/treyi+heSfKzJs6vcY94m4v6zepUkOZebX80LXPbboiVNOa0R2cIQ57gDsTU71n/ZaP+UmpFSVEmZkBRo4ww2DajXmXiWVCm6RI/U8vc5HcNqYkLZbEAFcIR1rj5AIoRLSFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pkbVGOLw; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pkbVGOLw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0J
	LHZTe2EOR4+PpHpjRjpPfkYRKj6c1rp4X0nCAmFVU=; b=pkbVGOLwvutrEFrORF
	ew6WzHcwV9f121JBTwRRiOH+/fKSu9jSF3lTrSq8gHI7cn20IrIBgKtsVxPPEkUF
	dAGk+F0wX31AhhEYocQM1oHch5kSuoH9cAFr9u131Uh9PCrYD+m9WHN09hQJeLtN
	VG3u2DLHT2PXS0aHReXRP8t0M=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3CIDc335qQzYVPQ--.10550S2;
	Fri, 14 Aug 2026 17:29:02 +0800 (CST)
From: Gongwei Li <13875017792@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Kiran K <kiran.k@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gongwei Li <ligongwei@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel_pcie: fix double free of IRQ in remove()
Date: Fri, 14 Aug 2026 17:28:38 +0800
Message-Id: <20260814092838.527062-1-13875017792@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3CIDc335qQzYVPQ--.10550S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1xZFyktrW7GrW7Kr4fGrg_yoW8WF43pa
	98WFWFyrWkXr1UWwsrAa1fXFWUZayrurWfC3sFkw13Wr9xGryktF4rAFyjqr9xCrZYkF4Y
	y3Z8tr95Gw1DXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joZXOUUUUU=
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/xtbC-h5pJGp+397ZyQAA3o

From: Gongwei Li <ligongwei@kylinos.cn>

The MSI-X IRQs are requested with devm_request_threaded_irq() in
btintel_pcie_setup_irq(), but btintel_pcie_remove() releases them
explicitly with free_irq() and then calls pci_free_irq_vectors().

After .remove() returns, the driver core releases the remaining devm
resources of the device, which calls free_irq() a second time on the
vectors that were already freed and whose MSI-X interrupt domain has
already been destroyed by pci_free_irq_vectors(), resulting in
splats like:

  Trying to free already-free IRQ <n>

Fix this by using devm_free_irq(), which unregisters the devres
entry and then frees the IRQ, keeping the free order introduced by
the commit below intact: the IRQs are still released before
pci_free_irq_vectors() and no double free happens on devm cleanup.

Fixes: 041677e7aad6 ("Bluetooth: btintel_pcie: Fix irq leak")
Cc: stable@vger.kernel.org
Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
---
 drivers/bluetooth/btintel_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 2b7231be5973..8fc4b8e3e4e1 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2966,7 +2966,7 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 		struct msix_entry *msix_entry;
 
 		msix_entry = &data->msix_entries[i];
-		free_irq(msix_entry->vector, msix_entry);
+		devm_free_irq(&pdev->dev, msix_entry->vector, msix_entry);
 	}
 
 	pci_free_irq_vectors(pdev);
-- 
2.25.1

