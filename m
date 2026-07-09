Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6714B3F8233;
	Thu,  9 Jul 2026 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597697; cv=none; b=XBaZ6LUryOxsZ12HswtvM1Jjma+yQWL1ZpwG5hA2GDlCI60/JLHPvKh8CbuAyBc8uns0G7nC9bhVltMiW0Ok4jFl2nAOzeXr3hQr/bNMFS/lbw1grvNLgW4dOueVNZ8FCYjdCjI86UR7NTmA1y0ZzwT17iAuID9TYo1MXdAiK9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597697; c=relaxed/simple;
	bh=3GHVytqAiXztOpvo3irA/vj2g4iFfeqJ9bonYBsjPOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eCw0uXUKyIXNLa7/2RV3SnjOPfIBLjM7A2IROdrl77wJ2KcGWt0bZ/gzz52jOSr3PPVbYp4NjwQmdC9SdF4/PSSzET8kuXRfy22BBFhDjDxSy9hrX/iFI2zgp9AQ+nufJ3eIyXGejJzzefhhxd7zB82uTSruyGFPL5ZmXTBhSJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jqWYavq4; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jqWYavq4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=TQ
	2dgI13JWSwktDEmuOJMUNjWbExU+eiPgxf6tnfoW8=; b=jqWYavq4f045OAUzlJ
	Wqgm2eBhuNfeNeIsU8fONZtNpzBVFYn9huJy92i7dfQgH6NbDkivi5U9oRuBKp4d
	oY505kINaHjREeaR1qzL8d9A7JpT/iA0YUoAOLTDa2zCWd8H1S0LjNQYZnbA2Dod
	2LJxSQd8JVPuk9S/tLXNP2beo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAHRqBiik9q5_JKIw--.24489S2;
	Thu, 09 Jul 2026 19:47:48 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	yangyingliang@huawei.com,
	error27@gmail.com,
	mst@redhat.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] Bluetooth: virtio: Fix virtbt_probe() init and cleanup
Date: Thu,  9 Jul 2026 19:47:45 +0800
Message-Id: <20260709114745.4030794-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHRqBiik9q5_JKIw--.24489S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWxAF1DXF13XFWUXF48Crg_yoW5WrW5pF
	sxWF98AFy0gFW3Can8Xa18ua4xCFs7C3yIgrWaq3s0grZ0yrWUAryjy34UKa4UZrZ8Zay8
	JF4kJ34kZrWDuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUfQiUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7QQqmGpPimRsSgAA32

virtbt_probe() allocates vbt before setting up the virtqueues, but some
failure paths return without freeing it.

The probe path also registers the HCI device before the virtio transport
is opened. Since hci_register_dev() makes the HCI device visible and queues
power_on work, move it after virtio_device_ready() and virtbt_open_vdev()
so the transport is ready before the HCI core can use it.

On failures after DRIVER_OK, reset and close the virtio device before
deleting the virtqueues and freeing vbt. This also cancels pending rx work
before vbt is freed.

Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
 - Rework virtbt_probe() error paths into an unwind ladder.
 - Free vbt on probe failures.
 - Reset the virtio device and unregister the HCI device before freeing it
   when virtbt_open_vdev() fails.
 - Close the virtio device before unregistering the HCI device in remove().

   Thanks Dan for the suggestions. The blog is very helpful.

Changes in v3:
 - Remove virtio_reset_device() from the virtbt_open_vdev() failure path.

Changes in v4:
 - Move hci_register_dev() after virtio_device_ready() and virtbt_open_vdev().
 - Reset and close the virtio device on probe failures after DRIVER_OK. Thanks, Luiz!
---
 drivers/bluetooth/virtio_bt.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 140ab55c9fc5..e7e79ba3c1f7 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -311,12 +311,12 @@ static int virtbt_probe(struct virtio_device *vdev)
 
 	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, vqs_info, NULL);
 	if (err)
-		return err;
+		goto err_free_vbt;
 
 	hdev = hci_alloc_dev();
 	if (!hdev) {
 		err = -ENOMEM;
-		goto failed;
+		goto err_del_vqs;
 	}
 
 	vbt->hdev = hdev;
@@ -383,23 +383,28 @@ static int virtbt_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_BT_F_AOSP_EXT))
 		hci_set_aosp_capable(hdev);
 
-	if (hci_register_dev(hdev) < 0) {
-		hci_free_dev(hdev);
-		err = -EBUSY;
-		goto failed;
-	}
-
 	virtio_device_ready(vdev);
 	err = virtbt_open_vdev(vbt);
 	if (err)
-		goto open_failed;
+		goto err_close_vdev;
+
+	err = hci_register_dev(hdev);
+	if (err < 0) {
+		err = -EBUSY;
+		goto err_close_vdev;
+	}
 
 	return 0;
 
-open_failed:
+err_close_vdev:
+	virtio_reset_device(vdev);
+	virtbt_close_vdev(vbt);
 	hci_free_dev(hdev);
-failed:
+err_del_vqs:
 	vdev->config->del_vqs(vdev);
+err_free_vbt:
+	vdev->priv = NULL;
+	kfree(vbt);
 	return err;
 }
 
-- 
2.25.1

