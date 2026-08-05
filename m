Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794B93C73C1;
	Wed,  5 Aug 2026 03:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785900585; cv=none; b=dfR0jR+s3gvXFUu8RC+iiAFKoloILGfvZmQTgk9S2PXXfcTVs+42SPZlNjgzNsVyDnreqDIPRCITFdC/o/trdd2EeUeg4Kyqdm6mqaLcDYvh3xiTVllzv368W99lBi+20HgoukJzgaK84YFO5SzFeDovwddK/YnEcT83NkSKmew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785900585; c=relaxed/simple;
	bh=NyysX71tOEVitM986eCc7Wmaj8xSQdDVkejgQEJx5ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W9uMThk4H3KubDp6BSJniuYOUE8KIAOSiwlVjpWKs2eoWnrflY3N3JaabbgkBn42uViiVt5JJUAk1kr4UzUgzG0SfIPs4bAZlblUwlBiTiz5oI4fmSv+llEFRYbIsLVVg4UukVpp6jL+Dz4tBo/hr7ReripElU9iAdmxyiTAHxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e43b5566907d11f1aa26b74ffac11d73-20260805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:354fc164-4eb8-47dd-b430-f707dde2152c,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:292b35c7d482c131377138ba52ffc499,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e43b5566907d11f1aa26b74ffac11d73-20260805
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 100322220; Wed, 05 Aug 2026 11:29:39 +0800
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
Subject: [PATCH] virtio_mmio: disable IRQ wake before free_irq
Date: Wed,  5 Aug 2026 11:29:37 +0800
Message-ID: <20260805032937.1606737-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the DT node has "wakeup-source", vm_find_vqs() calls
enable_irq_wake() on the shared IRQ, but vm_del_vqs() freed that IRQ
without a matching disable_irq_wake(). That leaves a wake reference
behind and can warn on later free_irq()/request_irq() cycles.

Record whether enable_irq_wake() succeeded, and disable it in
vm_del_vqs() before free_irq().

Fixes: 02213273f72a ("virtio_mmio: add support to set IRQ of a virtio device as wakeup source")
Cc: stable@vger.kernel.org
Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/virtio/virtio_mmio.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 510b7c4ef..d5b148bde 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -87,6 +87,9 @@ struct virtio_mmio_device {
 
 	void __iomem *base;
 	unsigned long version;
+
+	/* True if enable_irq_wake() succeeded for the shared IRQ. */
+	bool wake_irq_enabled;
 };
 
 /* Configuration interface */
@@ -329,11 +332,17 @@ static void vm_del_vqs(struct virtio_device *vdev)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	struct virtqueue *vq, *n;
+	int irq = platform_get_irq(vm_dev->pdev, 0);
 
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
 		vm_del_vq(vq);
 
-	free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
+	if (vm_dev->wake_irq_enabled) {
+		disable_irq_wake(irq);
+		vm_dev->wake_irq_enabled = false;
+	}
+
+	free_irq(irq, vm_dev);
 }
 
 static void vm_synchronize_cbs(struct virtio_device *vdev)
@@ -460,8 +469,9 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	if (err)
 		return err;
 
-	if (of_property_read_bool(vm_dev->pdev->dev.of_node, "wakeup-source"))
-		enable_irq_wake(irq);
+	if (of_property_read_bool(vm_dev->pdev->dev.of_node, "wakeup-source") &&
+	    !enable_irq_wake(irq))
+		vm_dev->wake_irq_enabled = true;
 
 	for (i = 0; i < nvqs; ++i) {
 		struct virtqueue_info *vqi = &vqs_info[i];
-- 
2.43.0

