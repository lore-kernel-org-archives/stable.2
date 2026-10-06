Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459853BFE26;
	Tue,  6 Oct 2026 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280607; cv=none; b=jLh5YN/0xAN3Fm66yTRzSKthRWbBAv54XrW0razGaf5jzo3uOiB1xzAYeUCy9zMVFIpfZ5qW0htIl52IaTRP228CAp/+oPZrUJZg4RApKmQNtc4gQpECe3oVNd+9gBrDflkYRnYGxbyQ2OoXCIBMHd8XKHEMFuSvqJX2co/cfr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280607; c=relaxed/simple;
	bh=oRa7GrgZ4YPytMnX/OHFsb6GJ+Kgbf77yuHcx4pKwKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jtMGLScc+nLZhrL8waemYOZt+qyuO3Flx1SsOte6N0WtUh/zGcYNI6SVqoS64CxnQB+wbua7gqQ+irPrknqfIwdovyeDj+6pvIJVmg0XUC29NFdedytwZsl73QytT0G4CjiOytKzG0gdQxjjbc42ldD2Uq+VgB2jyhNP/Sp5xtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=W14NJvYy; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="W14NJvYy"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 50127ae4f;
	Tue, 6 Oct 2026 17:56:33 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Tedd Ho-Jeong An <tedd.an@intel.com>,
	Kiran K <kiran.k@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ravindra <ravindra@intel.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v2] Bluetooth: btintel_pcie: use managed IRQ teardown
Date: Tue,  6 Oct 2026 17:56:28 +0800
Message-Id: <20261006095628.384343-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261005041457.3021139-1-ravindra@intel.com>
References: <20261005041457.3021139-1-ravindra@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa110a4bc1003a1kunmcdf004d13943e4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQh5DVhoYSUhDHh9LH0hCSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=W14NJvYyKf2F6qbcxRpGVIpvyhjxGpni+yHIzUwfoHHigLa9zaaSE9dK+kid8lbZsb79ufm/HEyxBrk1hZuyiwxwpDURmvkL3IYQxh+C6ajyp5tiD3kodXHH835C4gTCyQe/vRChARbdzUf7y/LVOkYZVBSv0+NXQf2NqZ7xdoA=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=SuTad1VLA3KUnQ+9L2QOdgd1nhmFBnxk3RWriIE+7cE=;
	h=date:mime-version:subject:message-id:from;

The PCIe driver registers its MSI-X handlers with
devm_request_threaded_irq(), but remove() uses free_irq() directly. The
devres actions then retain registrations and attempt to release them again
during device cleanup.

Use devm_free_irq() for the remove path and for already registered vectors
when a later setup request fails. This removes the managed resource at the
same time as the IRQ is released and keeps MSI-X vector teardown ordered
after IRQ ownership is gone.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Cc: stable@vger.kernel.org
Tested-by: Ravindra <ravindra@intel.com>
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
Changes in v2:
- Add Ravindra's Tested-by tag.

 drivers/bluetooth/btintel_pcie.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 005c77a4f..f8901df7c 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1750,7 +1750,7 @@ static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
 static int btintel_pcie_setup_irq(struct btintel_pcie_data *data)
 {
 	int err;
-	int num_irqs, i;
+	int num_irqs, i, j;
 
 	for (i = 0; i < BTINTEL_PCIE_MSIX_VEC_MAX; i++)
 		data->msix_entries[i].entry = i;
@@ -1779,6 +1779,10 @@ static int btintel_pcie_setup_irq(struct btintel_pcie_data *data)
 						KBUILD_MODNAME,
 						msix_entry);
 		if (err) {
+			for (j = 0; j < i; j++)
+				devm_free_irq(&data->pdev->dev,
+					      data->msix_entries[j].vector,
+					      &data->msix_entries[j]);
 			pci_free_irq_vectors(data->pdev);
 			data->alloc_vecs = 0;
 			return err;
@@ -3101,7 +3105,7 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 		struct msix_entry *msix_entry;
 
 		msix_entry = &data->msix_entries[i];
-		free_irq(msix_entry->vector, msix_entry);
+		devm_free_irq(&pdev->dev, msix_entry->vector, msix_entry);
 	}
 
 	pci_free_irq_vectors(pdev);
-- 
2.34.1
