Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0937C0E1;
	Tue,  9 Jun 2026 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991194; cv=none; b=rAoL7QgbuScOUfSF3P51GcfUHBBWEq1LDzkV1MakxFBIvjOpBxwRENMW002mi0KAizbd4FymeD89utYmaK3Z3bQMnQpXcNb9C7R9okRBoOQz7Xicm/Y6r94UC7MS6Ofd9WZRhiYQui3Jytne54H9FED0nzEARiDkPX+X/YRvDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991194; c=relaxed/simple;
	bh=ZdO2EOV0cBa/DUhdVCS9Q3hzEpxONuBEn9y6q4PcmeM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gC4ciMsrmlLSTWBS0R32kfejsDXLzOtHwQv28GctrzNWYBpfMdK8xGM/OE03oxq9jyfhSvxQncwk9EKwuru5YRTYAMxG7q4MKwxMOp3rxBN59zTgs+BJ4Aq96qjlbBExA4ehAMbPKA7cVhdXETr7g1Lu+EgG5V0A2BHilAWwON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-03 (Coremail) with SMTP id rQCowABnh97DxCdqKvAfFA--.1046S2;
	Tue, 09 Jun 2026 15:46:12 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: skalluru@marvell.com,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ariele@broadcom.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] bnx2x: fix resource leaks in bnx2x_init_one() error paths
Date: Tue,  9 Jun 2026 15:46:10 +0800
Message-Id: <20260609074610.1968721-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABnh97DxCdqKvAfFA--.1046S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr45XFyxAw4xAw4kuF4xCrg_yoWrGF13pa
	yDXa45Jr1kWrsIya1UJFWUAFn3A395t34UGayUG34ava4YkF98JF1xt347XrW8GrZ5GF4S
	qw45tw1DW3WYvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBwkNE2onpjN48QAAsB

bnx2x_init_one() falls through to the common memory cleanup path for
several failures after probe has already acquired additional resources.

If register_netdev() fails after bnx2x_set_int_mode(), MSI/MSI-X remains
enabled. If later failures happen after bnx2x_iov_init_one(), PF SR-IOV
state can be left allocated. Also, failures after bnx2x_vfpf_acquire()
must release the PF resources before freeing the VF-PF mailbox allocated
by bnx2x_vf_pci_alloc().

Add error labels matching the resource acquisition order so probe failure
disables MSI/MSI-X, removes SR-IOV state, releases VF-PF resources,
deallocates VF PCI resources, and then frees the common driver memory.
Also clear PCI drvdata before freeing the netdev on probe failure.

Fixes: 6411280ac94d ("bnx2x: Segregate SR-IOV code")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
Changes in v2:
 - Unwind all resources acquired by bnx2x_init_one() on failure
 - Clear PCI drvdata before freeing the netdev on probe failure.
 - Modify the commit title and message.
---
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 26 +++++++++++++++----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index da0f8c353e6a..f44ff9e7062b 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -13893,6 +13893,7 @@ static int bnx2x_init_one(struct pci_dev *pdev,
 
 	rc = bnx2x_init_dev(bp, pdev, dev, ent->driver_data);
 	if (rc < 0) {
+		pci_set_drvdata(pdev, NULL);
 		free_netdev(dev);
 		return rc;
 	}
@@ -13932,13 +13933,13 @@ static int bnx2x_init_one(struct pci_dev *pdev,
 		dev_err(&bp->pdev->dev,
 			"Cannot map doorbell space, aborting\n");
 		rc = -ENOMEM;
-		goto init_one_freemem;
+		goto init_one_vf_pci_dealloc;
 	}
 
 	if (IS_VF(bp)) {
 		rc = bnx2x_vfpf_acquire(bp, tx_count, rx_count);
 		if (rc)
-			goto init_one_freemem;
+			goto init_one_vf_pci_dealloc;
 
 #ifdef CONFIG_BNX2X_SRIOV
 		/* VF with OLD Hypervisor or old PF do not support filtering */
@@ -13952,7 +13953,7 @@ static int bnx2x_init_one(struct pci_dev *pdev,
 	/* Enable SRIOV if capability found in configuration space */
 	rc = bnx2x_iov_init_one(bp, int_mode, BNX2X_MAX_NUM_OF_VFS);
 	if (rc)
-		goto init_one_freemem;
+		goto init_one_vfpf_release;
 
 	/* calc qm_cid_count */
 	bp->qm_cid_count = bnx2x_set_qm_cid_count(bp);
@@ -13971,7 +13972,7 @@ static int bnx2x_init_one(struct pci_dev *pdev,
 	rc = bnx2x_set_int_mode(bp);
 	if (rc) {
 		dev_err(&pdev->dev, "Cannot set interrupts\n");
-		goto init_one_freemem;
+		goto init_one_iov_remove;
 	}
 	BNX2X_DEV_INFO("set interrupts successfully\n");
 
@@ -13979,7 +13980,7 @@ static int bnx2x_init_one(struct pci_dev *pdev,
 	rc = register_netdev(dev);
 	if (rc) {
 		dev_err(&pdev->dev, "Cannot register net device\n");
-		goto init_one_freemem;
+		goto init_one_disable_msi;
 	}
 	BNX2X_DEV_INFO("device name after netdev register %s\n", dev->name);
 
@@ -14001,6 +14002,20 @@ static int bnx2x_init_one(struct pci_dev *pdev,
 
 	return 0;
 
+init_one_disable_msi:
+	bnx2x_disable_msi(bp);
+
+init_one_iov_remove:
+	bnx2x_iov_remove_one(bp);
+
+init_one_vfpf_release:
+	if (IS_VF(bp))
+		bnx2x_vfpf_release(bp);
+
+init_one_vf_pci_dealloc:
+	if (IS_VF(bp))
+		bnx2x_vf_pci_dealloc(bp);
+
 init_one_freemem:
 	bnx2x_free_mem_bp(bp);
 
@@ -14011,6 +14026,7 @@ static int bnx2x_init_one(struct pci_dev *pdev,
 	if (IS_PF(bp) && bp->doorbells)
 		iounmap(bp->doorbells);
 
+	pci_set_drvdata(pdev, NULL);
 	free_netdev(dev);
 
 	if (atomic_read(&pdev->enable_cnt) == 1)
-- 
2.25.1

