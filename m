Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF372443C38
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126200; cv=none; b=Y53C1EnpTPLfBNZ7lJgMh8/Y7undSVrYrxfD6Sxx3aPwGUlhQHrt1i5g+L5XN4SvqPrq/ZaNPobvX3+c1p3X5YUjQJIVJMWx/UKN9aRhNXwm/ZoM1bzjX3x5+/H5JG1L+PEghSkihjjxjE2wYs2rBYDm3/xQEuMvUTRH6T3GeI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126200; c=relaxed/simple;
	bh=4L69wZsT5SLDzTDEhmBP9d1DAdUTSTt457zsZf+lzk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hch29dB+DCDdZbua1z09c3oUrfDLwUg91S3sAXNASIQldbzxcJOf8jMK/wo/A/WviJXmwa0hWqS94i7Zm9ufoo+3majxASGz0L5htfz240sewlxXFZ7s292ix1VoYzakRdwxikasMJzwVS8Px+rZqHfOyzUmgHoVpYxkk6R9Hlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ms02dgdA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ms02dgdA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179A31F000FF;
	Fri, 11 Sep 2026 11:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789126177;
	bh=NY6J4rfGqYnjGbX/SnreuYlzqm68YSpRS+Kw/EQV9nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ms02dgdAnZH03wC9MoAq+L5rQeZsAOqNMaerY6BwJII9FUnsuscIIXN0ECqSLBCVV
	 rK7IqtLHND4x403ylfJJfWVI/UZ4pARqzUappiLuhIuqpxZPmvVKS5reCSwrvHffvL
	 uzqOg77KXioU1HcMpPGczTZWFzJK/bmzJ1YKfG0su0+59EwpOGMrgBxkO03qrnuS/m
	 65s/JFOZfg98toejGS2FDCFTEOPQgj6anMe5DUeCPptcog9pw0H6NshcMmrxeibb+d
	 rKp5X32hUhk0NepZa580h55SEUSwGBW9VfLCYJrPc/aRx1iB/ejk2OWr34F09Qutso
	 NAOSlrAhjR2lA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] nvdimm: virtio_pmem: refcount requests for token lifetime
Date: Fri, 11 Sep 2026 07:29:35 -0400
Message-ID: <20260911112935.387585-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090941-patience-cymbal-1387@gregkh>
References: <2026090941-patience-cymbal-1387@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Chen <me@linux.beauty>

[ Upstream commit e57140944b5a47a7fd5a142faab29a02af040bc8 ]

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
[ replaced kref with direct refcount_t operations to avoid adding a release callback. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/nd_virtio.c   | 26 ++++++++++++++++++++++----
 drivers/nvdimm/virtio_pmem.h |  2 ++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 204d1a05f8e32..af6a9412788bb 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -21,6 +21,8 @@ void virtio_pmem_host_ack(struct virtqueue *vq)
 	while ((req_data = virtqueue_get_buf(vq, &len)) != NULL) {
 		req_data->done = true;
 		wake_up(&req_data->host_acked);
+		if (refcount_dec_and_test(&req_data->refcount))
+			kfree(req_data);
 
 		if (!list_empty(&vpmem->req_list)) {
 			req_buf = list_first_entry(&vpmem->req_list,
@@ -59,6 +61,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	if (!req_data)
 		return -ENOMEM;
 
+	refcount_set(&req_data->refcount, 1);
 	req_data->done = false;
 	init_waitqueue_head(&req_data->host_acked);
 	init_waitqueue_head(&req_data->wq_buf);
@@ -76,10 +79,23 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
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
+			refcount_inc(&req_data->refcount);
+			break;
+		}
+
+		if (err != -ENOSPC)
+			break;
 
-		dev_info(&vdev->dev, "failed to send command to virtio pmem device, no free slots in the virtqueue\n");
+		dev_info_ratelimited(&vdev->dev,
+				     "failed to send command to virtio pmem device, no free slots in the virtqueue\n");
 		req_data->wq_buf_avail = false;
 		list_add_tail(&req_data->list, &vpmem->req_list);
 		spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
@@ -88,6 +104,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 		wait_event(req_data->wq_buf, req_data->wq_buf_avail);
 		spin_lock_irqsave(&vpmem->pmem_lock, flags);
 	}
+
 	err1 = virtqueue_kick(vpmem->req_vq);
 	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
 	/*
@@ -103,7 +120,8 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 		err = le32_to_cpu(req_data->resp.ret);
 	}
 
-	kfree(req_data);
+	if (refcount_dec_and_test(&req_data->refcount))
+		kfree(req_data);
 	return err;
 };
 
diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
index f72cf17f9518f..d28bf1779e040 100644
--- a/drivers/nvdimm/virtio_pmem.h
+++ b/drivers/nvdimm/virtio_pmem.h
@@ -12,11 +12,13 @@
 
 #include <linux/module.h>
 #include <uapi/linux/virtio_pmem.h>
+#include <linux/refcount.h>
 #include <linux/libnvdimm.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 
 struct virtio_pmem_request {
+	refcount_t refcount;
 	struct virtio_pmem_req req;
 	struct virtio_pmem_resp resp;
 
-- 
2.53.0

