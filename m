Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715213BD22F;
	Wed,  5 Aug 2026 03:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785900582; cv=none; b=jdhR3bXFGdhvWIwTwW7mEuchyfThye48efWQIGPRIVEFgjwmcqewLwts9sCW9uWMqhd4f7eVO7c4HIFDdHWz+cRaHErEz8lkLGXyg8bW50lLJ+LZwjeSJhrwxzSTEFOAInkZV81O1eQwHbdbo3zNVbMuP0qyGdVMJKztW7WD2CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785900582; c=relaxed/simple;
	bh=l0idbH1LRdvqlukSdM8OrUZ4UEkZMEz1Rd6wUY4ZFT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3f+YN9WdIkmgDcBpqiVlwSu625I0OJHZWiqnxbTe4CMeI55jCK3shahXdc4RhNjEK8y8z+AkhidH1DjbJH+j+jIoOezTU4d0cWyjLBHvR/71XMSKOOxirS9GT+Y0IG2+CGmA9gNAL8lcrv0reJsm524Ob8iCWFjJ18Vo+p7VTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e294ab18907d11f1aa26b74ffac11d73-20260805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:421d6145-5771-4e86-9828-d369a134456e,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:f5fa0fa531cfefdf86526c88514acaaf,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,1,J
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e294ab18907d11f1aa26b74ffac11d73-20260805
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2119948240; Wed, 05 Aug 2026 11:29:37 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH] virtio_pci: do not mutate caller irq_affinity.pre_vectors
Date: Wed,  5 Aug 2026 11:29:34 +0800
Message-ID: <20260805032934.1606700-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vp_request_msix_vectors() bumps desc->pre_vectors in place to reserve
the virtio config vector. vp_find_vqs() may call it more than once while
retrying MSI-X with different per-vq policies, so the caller's
irq_affinity keeps accumulating and later attempts get the wrong
affinity layout.

Copy the descriptor to a stack local, adjust pre_vectors there, and
pass that to pci_alloc_irq_vectors_affinity().

Fixes: ba74b6f7fcc0 ("virtio_pci: fix cpu affinity support")
Cc: stable@vger.kernel.org
Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/virtio/virtio_pci_common.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 164f480b1..9e75fd03e 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -128,6 +128,7 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	const char *name = dev_name(&vp_dev->vdev.dev);
+	struct irq_affinity tmp_aff, *aff = NULL;
 	unsigned int flags = PCI_IRQ_MSIX;
 	unsigned int i, v;
 	int err = -ENOMEM;
@@ -146,16 +147,19 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 					GFP_KERNEL))
 			goto error;
 
-	if (!per_vq_vectors)
-		desc = NULL;
-
-	if (desc) {
+	if (per_vq_vectors && desc) {
+		/*
+		 * Do not mutate the caller's irq_affinity across MSI-X
+		 * fallback retries in vp_find_vqs().
+		 */
+		tmp_aff = *desc;
+		tmp_aff.pre_vectors++; /* virtio config vector */
+		aff = &tmp_aff;
 		flags |= PCI_IRQ_AFFINITY;
-		desc->pre_vectors++; /* virtio config vector */
 	}
 
 	err = pci_alloc_irq_vectors_affinity(vp_dev->pci_dev, nvectors,
-					     nvectors, flags, desc);
+					     nvectors, flags, aff);
 	if (err < 0)
 		goto error;
 	vp_dev->msix_enabled = 1;
-- 
2.43.0

