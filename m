Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836AA3A83B1;
	Thu, 25 Jun 2026 02:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352951; cv=none; b=lN0jsy4nOnDLcbLElgu9Ox9T+j/eIK4/YakMksWaRFh+h1GDBCFQk1bm1UdcDA2tvC6Gs5vKFS/xlT1UEYGhcBQX9Bd7P7gLk8J0Y8/EDATLvPfOBeRs35xehUfxJclXc84+T3+EKIyTh91tlq+YTJUS7W5AcSdmve6K03fpxxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352951; c=relaxed/simple;
	bh=+H7HKr6B0crTC0+03EjVOZc8OL0pEtL1N1cAn/+iibM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rbEEviIF1oLAcGX6zzNWnTQ8BLr9YBq9AW0k50QK8K2hYwIhJMYXqfQdPLT+FZRIy5ax4R7Od4hJ9Ob4krYr9B7cs+po6ybimzG9f7kI0qpCvG5EY6OvBP2A+NUvl9OZDkCwBk6ARHNBU3/o7NMUyC5MlUVUFapsRQT65szz72w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gKE0MPRQ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gKE0MPRQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pA
	emrssydd8DBc33DDdoB+If90/cHTAojG9OAow1Z64=; b=gKE0MPRQvyDV5Cu8ih
	MzkDkFa3bpw+e+uuQGAmUa1Cr2yvX9VzANkaqH2jUnu4yGMmAiwj6jdQ7LwCP13i
	3/fQwZGYHW/M6XGwSjraLla30rUPI82D47NgrB/5fVSzuZQRPt1e7fK8Dy1bJMxQ
	LU1LoKwN8y/2z5h0DJn1a9hKc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3vxQYjDxq8lmkDg--.58300S2;
	Thu, 25 Jun 2026 10:02:02 +0800 (CST)
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
Subject: [PATCH v2] Bluetooth: virtio_bt: fix cleanup paths
Date: Thu, 25 Jun 2026 10:01:59 +0800
Message-Id: <20260625020159.3446736-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD3vxQYjDxq8lmkDg--.58300S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF48tw17Gw4fAFy3try8Grg_yoW5Wry3pF
	sxWas8AFWIgr47GFsxXa18Ca4rCrs7CayIkrWYq34YgrWYyrW0yFyjyFyjqFy7ArZ5ZFW8
	JFn5J348ur4DuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRN6pDUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7RvSQWo8jBtNMQAA3Y

virtbt_probe() registers the HCI device before opening the virtio
Bluetooth device. If virtbt_open_vdev() fails, the error path frees
the HCI device without unregistering it first. The probe error paths
also leak the virtio_bluetooth structure after it has been allocated.

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
---
 drivers/bluetooth/virtio_bt.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 140ab55c9fc5..4ca9b76f6410 100644
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
+		goto err_reset_vdev;
 
 	return 0;
 
-open_failed:
+err_reset_vdev:
+	virtio_reset_device(vdev);
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
 
@@ -408,10 +413,10 @@ static void virtbt_remove(struct virtio_device *vdev)
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

