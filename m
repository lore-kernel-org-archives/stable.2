Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5758A47F3C7;
	Mon, 19 Oct 2026 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399471; cv=none; b=drpFdQcWkS9MsaS4Mc8WzbU9erGlRI2IfK57xiRPSs78zGu1lLbsPqn/n2twKmBHnTfubRluhjSu+BXeC3VWmgsq8J5fEG2RBBOxDbihDR7KpUI8zDgoLnTz4S7nOtm0UvqDlkF0tbq4KqRP5z74JsiigzSjI2Rb2QBcPZBBS/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399471; c=relaxed/simple;
	bh=EA76ET62JnenE/RKX7QB/vXJdC4AruFANCBQI5IiN2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VDMlbbD+udfVq9FrWLOefoOKgCYR9aOuwe2AVNQGg3oK5mE0WB2US9gMJjEYwkva8ul9+BpKd+CJGItPDsIuI57JwZ9IQusX6QqlSv+ar3vzg89sDBFQYqCZY6i/ri9c2qrxSRAeEUaMu3x7vbqpToOiv083JILCEkyVyA2DbnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=cRb5QN4k; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="cRb5QN4k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=cRb5QN4kU5i/PAQHSrM7ZmaFbyZjrV92bqt8wAo8yqreQtaz59dDrctKvRoEGIT4k3/P9VsnodNIT
	 LfY43ypiNBX2tGWyz3dbvP5B8U2YoFhPDAi1vXyDQhm/oo7n8cn8Ac8k+bLfMNrlpQ9FyyLK6c/WBX
	 BdUcYhCOMHcYMQC4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46ad5d8618ab-b06cf;
	Mon, 19 Oct 2026 16:44:18 +0800 (CST)
X-RM-TRANSID:2ee46ad5d8618ab-b06cf
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from desktop-c950f82eaac8410e-20260515094303939 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6ad5d85e1b6-9fbc7;
	Mon, 19 Oct 2026 16:44:18 +0800 (CST)
X-RM-TRANSID:2eea6ad5d85e1b6-9fbc7
From: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>
To: mst@redhat.com,
	david@kernel.org
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+0f659760bac1ecb01812@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	stable@vger.kernel.org,
	Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>
Subject: [PATCH] virtio_balloon: drain update works on probe error paths
Date: Mon, 19 Oct 2026 16:44:06 +0800
Message-ID: <20261019084406.162-1-zhaimingbing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.53.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init_vqs() arms the stats virtqueue callback, so an update work can
already be queued on the system freezable workqueue while
virtballoon_probe() is still running.  If a later probe step fails, the
error unwind deletes the virtqueues and frees vb without stopping the
works, and the queued work runs after the balloon struct is gone:

  BUG: KFENCE: use-after-free read in virtqueue_get_buf_ctx
   update_balloon_stats_func+0x121/0x300
   Workqueue: events_freezable update_balloon_stats_func

remove() already handles this via virtballoon_quiesce().  Factor the
stopping of the update works out of it and run it on the probe error
path as well, before the queues and vb go away.

Fixes: 1f34c71afe51 ("virtio: Fix scheduling while atomic in virtio_balloon stats")
Reported-by: syzbot+0f659760bac1ecb01812@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0f659760bac1ecb01812
Signed-off-by: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>
---
 drivers/virtio/virtio_balloon.c | 17 ++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -554,6 +554,17 @@ static void update_balloon_stats_func(struct work_struct *work)
 	finish_wakeup_event(vb);
 }

+/* Stop queueing of and drain any pending balloon update works. */
+static void virtballoon_stop_updates(struct virtio_balloon *vb)
+{
+	spin_lock_irq(&vb->stop_update_lock);
+	vb->stop_update = true;
+	spin_unlock_irq(&vb->stop_update_lock);
+
+	cancel_work_sync(&vb->update_balloon_size_work);
+	cancel_work_sync(&vb->update_balloon_stats_work);
+}
+
 static void update_balloon_size_func(struct work_struct *work)
 {
 	struct virtio_balloon *vb;
@@ -1076,6 +1087,12 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		destroy_workqueue(vb->balloon_wq);
 out_del_vqs:
+	/*
+	 * init_vqs() arms the stats virtqueue callback and primes the
+	 * queue, so an update work may already be pending: stop queueing
+	 * and drain it before the virtqueues and vb go away.
+	 */
+	virtballoon_stop_updates(vb);
 	vdev->config->del_vqs(vdev);
 out_free_vb:
 	mutex_destroy(&vb->balloon_lock);
@@ -1116,11 +1133,7 @@ static void virtballoon_quiesce(struct virtio_balloon *vb)
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		virtio_balloon_unregister_shrinker(vb);

-	spin_lock_irq(&vb->stop_update_lock);
-	vb->stop_update = true;
-	spin_unlock_irq(&vb->stop_update_lock);
-	cancel_work_sync(&vb->update_balloon_size_work);
-	cancel_work_sync(&vb->update_balloon_stats_work);
+	virtballoon_stop_updates(vb);

 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		cancel_work_sync(&vb->report_free_page_work);
--
2.47.0


