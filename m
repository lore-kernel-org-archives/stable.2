Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFB936A367;
	Tue,  7 Jul 2026 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409419; cv=none; b=hEA/jH7FZUgstBKSl6POPE89KtXngfq1Og70HUk3MVQUHYC/431kwIdK82izz/PpY3z1xl9Hq5MwWxjIrWnKl4PzV/csGagT7h9AMu9Z0RaJHkQWVdx5k10QDPNHFWbuKdjClagjRqYmo+5CFaJ0wZPKTZ25TYXr3o/Js9oWvWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409419; c=relaxed/simple;
	bh=WEN1waAFPwp2mSBl4+8mYHP3ETntDRBQ9FPsQay92i8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hUwBBPpGEZH3eSNh/gMPc2oCxGu/dUZkudbMMqyP1tDbNRjX1qPHfK25ZfeLD9o1qPMdpkc4C5xF0yjL4LsYxmk8i2GnB9yVJloynZcVLCVAWatL5l74la19SReXTuz0mEjTSA0RxfLDKFYiVBcY/ZLkt7bxbQqDx2dY7MWghlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eZrCwftD; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eZrCwftD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ex
	dxo1NKrnX/FZFV3kd2y2a+C3iv81Du+6mssEFMi0k=; b=eZrCwftDOnXu8pdyUy
	COd66qVPx01ed9RwDa0aXTXmwYXJu/+CSDLR2RLEGG25uMty5tXf1vQTh/JP6Dc9
	O2LQ/vA7LBB0hg59ldBeoi4pl5w6gvFe/9IcVwHASayLUN4AK8adoES8ya5mQss9
	Z7Gvm3+CwTmurRe+ZQUmjM8Jw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgC3kyL1qkxqVckaGA--.35163S2;
	Tue, 07 Jul 2026 15:29:58 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	mst@redhat.com,
	error27@gmail.com,
	yangyingliang@huawei.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] Bluetooth: virtio: Fix HCI device unregister on probe failure
Date: Tue,  7 Jul 2026 15:29:55 +0800
Message-Id: <20260707072955.3093138-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgC3kyL1qkxqVckaGA--.35163S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF48tw17Gw4fAFy3try8Grg_yoW5Ww1xpa
	nxWas8AFWIgr47GFs8Xa18Ca4rGrs7CayIk34aq34YgrWYyrW8tFyjya4jqa4UArZ5ZFW8
	tFn5J348uw4DuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piPCzJUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7haVBGpMqvaWKQAA3s

virtbt_probe() registers the HCI device before opening the virtio
Bluetooth device. If virtbt_open_vdev() fails, the error path frees
the HCI device without unregistering it first.

The probe error paths also leak the virtio_bluetooth structure after it
has been allocated.

Rework the probe error handling into an unwind ladder so each failure
path releases the resources acquired earlier. Also close the virtio
device before unregistering the HCI device in virtbt_remove(), matching
the cleanup order used by the probe failure path.

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
---
 drivers/bluetooth/virtio_bt.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 140ab55c9fc5..c063c2391c5c 100644
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
@@ -383,23 +383,27 @@ static int virtbt_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_BT_F_AOSP_EXT))
 		hci_set_aosp_capable(hdev);
 
-	if (hci_register_dev(hdev) < 0) {
-		hci_free_dev(hdev);
+	err = hci_register_dev(hdev);
+	if (err < 0) {
 		err = -EBUSY;
-		goto failed;
+		goto err_free_hdev;
 	}
 
 	virtio_device_ready(vdev);
 	err = virtbt_open_vdev(vbt);
 	if (err)
-		goto open_failed;
+		goto err_unregister_hdev;
 
 	return 0;
 
-open_failed:
+err_unregister_hdev:
+	hci_unregister_dev(hdev);
+err_free_hdev:
 	hci_free_dev(hdev);
-failed:
+err_del_vqs:
 	vdev->config->del_vqs(vdev);
+err_free_vbt:
+	kfree(vbt);
 	return err;
 }
 
@@ -408,10 +412,10 @@ static void virtbt_remove(struct virtio_device *vdev)
 	struct virtio_bluetooth *vbt = vdev->priv;
 	struct hci_dev *hdev = vbt->hdev;
 
-	hci_unregister_dev(hdev);
 	virtio_reset_device(vdev);
 	virtbt_close_vdev(vbt);
 
+	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 	vbt->hdev = NULL;
 
-- 
2.25.1

