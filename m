Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E5F4C226E
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576397; cv=none; b=Fc8qEPZnGAcKEfHKvPF4QZ7ZBJsQtEpngI8FNdYDKqWpiNG1VTnXIl/cxA9d8bpkT8IS+QNndN0soFbJzzoXbe/MjREkXJNSA6Wa37WG73IHQFgAeLjfyJBGsnoZ/RBJDpmR5bB/Qv3ULhrK90jCtMI+0Od0wHubH/pE5nXL1T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576397; c=relaxed/simple;
	bh=kyyqhB7XEA7Pk7ZF1AmzncbDMYQpHVW5qjk8Z5J7VyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1xeWC9s9eDeH9SMiSl+rUzordrohdDTwn6m2i6pDbRkNIm5nDf4ptwEzjXKvKCy1Vuu5iZkL+N7MVDZeQa7XNA+NdcoulrNjx2/VsP/ApnAQ52BKVtNtLTwJAGTgFntluNXc7dtDcKQd6jLGmWQwhmn3TBcC/E03SbijbeIyIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aigg7jbx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aigg7jbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA551F00893;
	Wed, 16 Sep 2026 16:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789576394;
	bh=YOFLQPVZ5yho4YgDnkyWcRZiHjx4bWMGFd8PB2CspSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aigg7jbxFHeJMykzytRpiVFbDISNJIYMiHTohZVpH/MIcluGovf/NuS0/+V9HvuLz
	 61Ii/UV1h/9AeMRcdFt8yYw3oSc81VDNzuN9joC3lvZGIu4ULpXKu8RmoYNH7AKrQg
	 7GeqTmvr1gCIM/qYWei+8OSM7UrvQNP00zYOCsTNx/hWRBEt7Mvfv+FlpLbWB0DrDI
	 2xGxqJAPGXt+yICGyruFHhwrAqQj2/yhn1giTurVXVx7Ap+T4l/g+u4vtQ9hNCy+Lb
	 ucNDnDJ91O41ZTpf1zAkjQjU7m61g/bvsGOUmKs5vqjHAM3DygJLb9QvC4geywjlP+
	 Cn46vpS+nEI7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiong Weimin <xiongweimin@kylinos.cn>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] virtio_mmio: disable IRQ wake before free_irq
Date: Wed, 16 Sep 2026 12:33:11 -0400
Message-ID: <20260916163311.416714-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916163311.416714-1-sashal@kernel.org>
References: <2026091636-caloric-bunt-1eeb@gregkh>
 <20260916163311.416714-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiong Weimin <xiongweimin@kylinos.cn>

[ Upstream commit d14d693adb055e98ca705822ba6daebc18602d9a ]

When the DT node has "wakeup-source", vm_find_vqs() calls
enable_irq_wake() on the shared IRQ, but vm_del_vqs() freed that IRQ
without a matching disable_irq_wake(). That leaves a wake reference
behind and can warn on later free_irq()/request_irq() cycles.

Record whether enable_irq_wake() succeeded, and disable it in
vm_del_vqs() before free_irq().

Fixes: 02213273f72a ("virtio_mmio: add support to set IRQ of a virtio device as wakeup source")
Cc: stable@vger.kernel.org
Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260805032937.1606737-1-xiongweimin@kylinos.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_mmio.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 22fdc6ba6f841..f420fb5810de4 100644
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
2.53.0

