Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DD849CF46
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947901; cv=none; b=b0TU8zCqlHwcCW3Q7CHr5cK1zqlQ/VmBR4zT23qTHmIqfDtSRz7T2/bWWWj0l7GSNCHV3FJYjdr/YPjbFQWRkzDzuYZeazxBMd5XV5KF08xmyzRSlUHYsALqBjeLAZUzyrHvdSqTsVxqXQ4mE9EAy0T9nfakAYRpa7ozo/Na7zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947901; c=relaxed/simple;
	bh=01eQ+Vy85SeN+Zfh3+gmw8hAuTjm1ob2d2h0qwQmXUo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PwuNP0LoU5b028i8bQ4F71FghKkt2s+96Xmrx5Dudga7/MbUI62/PD882DBdno5dijiPEF0OOb3Nj9isZw2KDj+aVAyFTRfvtFpfsFZ/NPrADZVPjlocz/4rVXMEcxZXd91BGvTF1DjflNdelxS8ykrK5iWvjZsnoAyA2k2RZ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qb8YLwEs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qb8YLwEs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806951F00A3A;
	Wed,  9 Sep 2026 09:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947895;
	bh=MU4fTXajEpohfWsbxAQCgmAaaL40R1YEOvn3X5OU3Tk=;
	h=Subject:To:Cc:From:Date;
	b=Qb8YLwEsIkE3V1vV3d7W320OeGiTsN/b0JRlv4Cu5aduFpa5lf0bUSfgKkZVzwuAC
	 pCs9zFbhMoco/v2EFmzq0RQ8gE/dJ/0AsVpGzngg+kNV5j2xSufunsQok2zXSlPaol
	 fc3U+1+4XngLPcIYiogf4n5xiVYoN/N48uLZJSrM=
Subject: FAILED: patch "[PATCH] nvdimm: virtio_pmem: refcount requests for token lifetime" failed to apply to 5.10-stable tree
To: me@linux.beauty,mst@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:51:41 +0200
Message-ID: <2026090941-patience-cymbal-1387@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e57140944b5a47a7fd5a142faab29a02af040bc8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090941-patience-cymbal-1387@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e57140944b5a47a7fd5a142faab29a02af040bc8 Mon Sep 17 00:00:00 2001
From: Li Chen <me@linux.beauty>
Date: Tue, 30 Jun 2026 17:23:33 +0800
Subject: [PATCH] nvdimm: virtio_pmem: refcount requests for token lifetime

KASAN reports slab-use-after-free in __wake_up_common():
BUG: KASAN: slab-use-after-free in __wake_up_common+0x114/0x160
Read of size 8 at addr ffff88810fdcb710 by task swapper/0/0

CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
6.19.0-next-20260220-00006-g1eae5f204ec3 #4 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux
1.17.0-2-2 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl+0x6d/0xb0
 print_report+0x170/0x4e2
 ? __pfx__raw_spin_lock_irqsave+0x10/0x10
 ? __virt_addr_valid+0x1dc/0x380
 kasan_report+0xbc/0xf0
 ? __wake_up_common+0x114/0x160
 ? __wake_up_common+0x114/0x160
 __wake_up_common+0x114/0x160
 ? __pfx__raw_spin_lock_irqsave+0x10/0x10
 __wake_up+0x36/0x60
 virtio_pmem_host_ack+0x11d/0x3b0
 ? sched_balance_domains+0x29f/0xb00
 ? __pfx_virtio_pmem_host_ack+0x10/0x10
 ? _raw_spin_lock_irqsave+0x98/0x100
 ? __pfx__raw_spin_lock_irqsave+0x10/0x10
 vring_interrupt+0x1c9/0x5e0
 ? __pfx_vp_interrupt+0x10/0x10
 vp_vring_interrupt+0x87/0x100
 ? __pfx_vp_interrupt+0x10/0x10
 __handle_irq_event_percpu+0x17f/0x550
 ? __pfx__raw_spin_lock+0x10/0x10
 handle_irq_event+0xab/0x1c0
 handle_fasteoi_irq+0x276/0xae0
 __common_interrupt+0x65/0x130
 common_interrupt+0x78/0xa0
 </IRQ>

virtio_pmem_host_ack() wakes a request that has already been freed by the
submitter.

This happens when the request token is still reachable via the virtqueue,
but virtio_pmem_flush() returns and frees it.

Fix the token lifetime by refcounting struct virtio_pmem_request.
virtio_pmem_flush() holds a submitter reference, and the virtqueue holds an
extra reference once the request is queued. The completion path drops the
virtqueue reference, and the submitter drops its reference before
returning.

Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
Cc: stable@vger.kernel.org
Signed-off-by: Li Chen <me@linux.beauty>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260630092338.2094628-9-me@linux.beauty>

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 8c0d4347938a..1cf53f75b128 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -15,6 +15,14 @@ struct virtio_pmem_flush_work {
 	struct bio *bio;
 };
 
+static void virtio_pmem_req_release(struct kref *kref)
+{
+	struct virtio_pmem_request *req;
+
+	req = container_of(kref, struct virtio_pmem_request, kref);
+	kfree(req);
+}
+
 static void virtio_pmem_wake_one_waiter(struct virtio_pmem *vpmem)
 {
 	struct virtio_pmem_request *req_buf;
@@ -42,6 +50,7 @@ void virtio_pmem_host_ack(struct virtqueue *vq)
 		virtio_pmem_wake_one_waiter(vpmem);
 		WRITE_ONCE(req_data->done, true);
 		wake_up(&req_data->host_acked);
+		kref_put(&req_data->kref, virtio_pmem_req_release);
 	}
 	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
 }
@@ -72,6 +81,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	if (!req_data)
 		return -ENOMEM;
 
+	kref_init(&req_data->kref);
 	WRITE_ONCE(req_data->done, false);
 	init_waitqueue_head(&req_data->host_acked);
 	init_waitqueue_head(&req_data->wq_buf);
@@ -89,10 +99,23 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	  * to req_list and wait for host_ack to wake us up when free
 	  * slots are available.
 	  */
-	while ((err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req_data,
-					GFP_ATOMIC)) == -ENOSPC) {
+	for (;;) {
+		err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req_data,
+					GFP_ATOMIC);
+		if (!err) {
+			/*
+			 * Take the virtqueue reference while @pmem_lock is
+			 * held so completion cannot run concurrently.
+			 */
+			kref_get(&req_data->kref);
+			break;
+		}
 
-		dev_info(&vdev->dev, "failed to send command to virtio pmem device, no free slots in the virtqueue\n");
+		if (err != -ENOSPC)
+			break;
+
+		dev_info_ratelimited(&vdev->dev,
+				     "failed to send command to virtio pmem device, no free slots in the virtqueue\n");
 		WRITE_ONCE(req_data->wq_buf_avail, false);
 		list_add_tail(&req_data->list, &vpmem->req_list);
 		spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
@@ -101,6 +124,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 		wait_event(req_data->wq_buf, READ_ONCE(req_data->wq_buf_avail));
 		spin_lock_irqsave(&vpmem->pmem_lock, flags);
 	}
+
 	err1 = virtqueue_kick(vpmem->req_vq);
 	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
 	/*
@@ -116,7 +140,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 		err = le32_to_cpu(req_data->resp.ret);
 	}
 
-	kfree(req_data);
+	kref_put(&req_data->kref, virtio_pmem_req_release);
 	return err;
 };
 
diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
index e6dfc10ce076..3af92588bd9d 100644
--- a/drivers/nvdimm/virtio_pmem.h
+++ b/drivers/nvdimm/virtio_pmem.h
@@ -12,12 +12,14 @@
 
 #include <linux/module.h>
 #include <uapi/linux/virtio_pmem.h>
+#include <linux/kref.h>
 #include <linux/libnvdimm.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 
 struct virtio_pmem_request {
+	struct kref kref;
 	struct virtio_pmem_req req;
 	struct virtio_pmem_resp resp;
 

