Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D878395AD3;
	Wed, 30 Sep 2026 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754313; cv=none; b=TEYLMxToImJZ6YVhfmaYtGsMwnBTriLLeoY3a1GcNIotmfLBws5aMEtYMhtfMWSWi0vCYU1hpzn9SagsrZO//vyAfCtRA8nNBiYoOb/uXafoRvz8SjbaSmohLrxkihuFoqJClsO1eaAWVX/zjfXunU99GwNDYB1BNPB2wZIIH5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754313; c=relaxed/simple;
	bh=LD2eEWzPPDtNqJdIoFhBZvPz9oTL3nR1ZEqgoKkyMwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JOXrmBf4DZI8eoHYdL21xoDP8LbGl3yepWEu8e9mZcNvRGZpIUagmNSyaoj/9kq8T41jJ0UqJoZ+IwaGmiL5BIzmW/X3RCbt5W2Qi+seS617YMOMeedFtixrpHKkyVV1OiJc6liWbitOM6Vxv67J+EenNC1WpnIesZ3scbdplfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=mNjhto0Q; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="mNjhto0Q"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f9ce890a;
	Wed, 30 Sep 2026 15:44:59 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Tedd Ho-Jeong An <tedd.an@intel.com>,
	Kiran K <kiran.k@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] Bluetooth: btintel_pcie: use managed IRQ teardown
Date: Wed, 30 Sep 2026 15:44:53 +0800
Message-Id: <20260930074453.2944525-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0f1461caa03a1kunm177f496726ffee
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTUkfVhpIS04aTk0eGUtMHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=mNjhto0Q6/0h+VdMMjvbpc5wOl6/gGelcX2ZEi8UTxYRgBCWhBzhBtNcqzWMVDrWQ+xP+2fu0V9TYfIa6tPJtJ5NWxkobnER0+imGl9jrZBjBeqpsbF+0EN/Bnu6yB8/saB7jTnoHyBmqAzmNF1gwo6Ai4LRs12D+C3yfMgQ17Q=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Kldygyuza09FJbiu9Dxn2VxKHwsFITS3Z7kKFrpBHUU=;
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
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
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
