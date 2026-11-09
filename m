Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794205319;
	b=nyNdd1MlUJC1e4fqHl3Vg3kxsUPPbDHJ0x9fjOC+rWH7PN1SxHbqayeGwciFdjmL0zg6
	 jEtHTJlb2aq1/cxEh8oZixptUTBczQTFW0gnyc1ufcm8Sgm/c1WY4wUcmJHAu09iZUZrF
	 0yyI+RhDke0CQuH3IHVm50Zu7iaFM3T9hj5q7rMlW9wbIhLm18ofa4yc78xhJ5Delgc1n
	 X4To8tmGDqzAIn3Xt7enynApS2yZ7MyVLka5+Nl/Y5iVerYR9cz81CqFT5KaWAtdJ/lAz
	 e95TUiSnIIUmsm5xAm+1rZ5bPxtx84IJc++eRjCLwqW9qh0W/6x7Vjoa7uNplNOss6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794205319;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=j96X4UIakiFHOKxgOngYS1UNzbH0JLa5PG4yrQQAi7M=;
	b=wfGLBaeobXCBZ/s+bo25CQHjbkyG8A0fBKDLY7ve3eSenLHnJkaFUZknQQP/6Ulq68Ph
	 zamgZRy91tg33x0ItDiWkdMOkXCX8xQBqLyeslnrOa/gUV24hFZegwwkOMimhqvYRyg4i
	 vndkfUxqErzTY83igiMS4jxnSbRaPNFfZKgUfw0qATdW6Bs0vFfjYDCSxOr0RKPl/7NM8
	 gf7teOStpOjbgCUyGBdP2TFfvf4WF0h1OniXrH57qUcc1CKuzI8zCVIIGVgtyj2ybCV4X
	 nQfHmq2UA6SHb1oh1Srs12+X8PUAeJPKRjVZROz+3sZ+bRs9lj/IYOfsvIYUP8f6deg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=iU4iQnii;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A636A606A338;
	Mon,  9 Nov 2026 06:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A636A606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=iU4iQnii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=iU4iQnii/lD1wRkQCZGge8sjA5p+MWo1NFE/3JAqaMnHo81Y0Zzwfm6Ai2geDnwwP7TftngeGCfP2
	 Vzpyo2myHSYcPUKyTfqKaEiBoP4ShwEpLiO97OPN8rs+3+84j0cM3rc3ETaRpKxxTZqZqvKhSU/jbK
	 Jlx7QQxpuIKKMJJY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af16683e00-9d193;
	Mon, 09 Nov 2026 14:21:56 +0800 (CST)
X-RM-TRANSID:2ee16af16683e00-9d193
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from desktop-c950f82eaac8410e-20260515094303939 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36af16680c6d-8374c;
	Mon, 09 Nov 2026 14:21:55 +0800 (CST)
X-RM-TRANSID:2ee36af16680c6d-8374c
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
Subject: [PATCH v4] virtio_balloon: drain update works on probe error paths
Date: Mon,  9 Nov 2026 14:21:52 +0800
Message-ID: <20261109062152.1097-1-zhaimingbing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <8f914911-8453-4f8f-b02f-384114f9d4ef@kernel.org>
References: <8f914911-8453-4f8f-b02f-384114f9d4ef@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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

The same hole exists when init_vqs() itself fails after
virtio_find_vqs() succeeded: the stats priming can fail with the queues
up and the callback armed, yet probe jumps straight to out_free_vb and
leaks the virtqueues while the queued work still references vb.  Unwind
inside init_vqs() in that case, stopping the works before the queues
are deleted.

Also reset the device before del_vqs() on these paths, like
remove_common() and the virtio_net/virtio_scsi error unwinds do:
without the reset the queues stay enabled on the device and the next
probe fails in setup_vq() with -ENOENT.

The drained work takes vb->wakeup_lock in process_wakeup_event() and
finish_wakeup_event(), so this depends on "virtio_balloon: initialize
wakeup_lock before virtqueues are set up", which moves that
spin_lock_init() to the top of probe.

Fixes: 1f34c71afe51 ("virtio: Fix scheduling while atomic in virtio_balloon stats")
Reported-by: syzbot+0f659760bac1ecb01812@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0f659760bac1ecb01812
Signed-off-by: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>
---

The wakeup_lock dependency is now in mainline (161aa708b02c).

Changes in v4 (from sashiko review):
- reset the device before del_vqs() on both error paths, like
  remove_common() and the virtio_net/virtio_scsi unwinds: without the
  reset queue_enable stays set and the next probe fails in setup_vq()
  with -ENOENT.

 drivers/virtio/virtio_balloon.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 8c1b47ec1..b30a0ca26 100644
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
@@ -633,6 +644,9 @@ static int init_vqs(struct virtio_balloon *vb)
 		if (err) {
 			dev_warn(&vb->vdev->dev, "%s: add stat_vq failed\n",
 				 __func__);
+			virtballoon_stop_updates(vb);
+			virtio_reset_device(vb->vdev);
+			vb->vdev->config->del_vqs(vb->vdev);
 			return err;
 		}
 		virtqueue_kick(vb->stats_vq);
@@ -1075,6 +1089,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		destroy_workqueue(vb->balloon_wq);
 out_del_vqs:
+	virtballoon_stop_updates(vb);
+	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 out_free_vb:
 	mutex_destroy(&vb->balloon_lock);
@@ -1115,11 +1131,7 @@ static void virtballoon_quiesce(struct virtio_balloon *vb)
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
2.43.0



