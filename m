Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0BD43B6ED
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123305; cv=none; b=jdqDZm8Ave4aQstsBj0dOeafRF2fOLOcvbL4lEaFHmZZAyo+g3gaIuGA1mgTXoNIoBkKkdWhhwFhb7npVSBdaZo+SmvBrS8+1Y8q+zG6WjLPRyAndxE0vaNzz4tUT/hfOQFk/Mngl0e7DZw5/Qyc6m4FnrJIJ6hi+0x3QAKPZbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123305; c=relaxed/simple;
	bh=0UIfMpOEpOwM4t6ojNmwPTiGnTz5VZzwRyjA5+q20Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tivpMBQO+x4HSFVdI+GCAjvEf2PcT4F254wJoS7tnT6JAsuQEfLF7rCnLy+eP/1OSbuY2YWzHaqLBObHZUKOwj+BpcasVkOf/28GlSIrlqIP5uC0wO8IqLBbuoqyTiZ+KV5wmRdov1srsBR4Bi0tM+ooo4id204GK36Gl2pcwCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daUJcAVK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daUJcAVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14DD1F0089C;
	Fri, 11 Sep 2026 10:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123304;
	bh=A3klAucLSUhP/4U396hZTLFloINK3m3Vac98ypflsGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=daUJcAVK2r+Ku66Zt9QYIav4TeJdO6X/k/Ra39zKU/nxXwSvO8vDJkXO86ibfIfzI
	 0f5tprCSJ4DRx1/kWaCsqRmAcAPuOZPxSrDtx/CAG+8OJSDDR8dq5qHOswDqU953w7
	 oUciWLDowlNo4hYXDMNL53v3gy2a0Ns0EIg7VgoHh9RCsPCWdvgZ+49WtapZnxytaj
	 5RWSBTkBlLSw8Tdfe6UbhdOBlccc1Dna9MO8/8K8iLGGNxjhXRsbU0tVx4udWTeWIN
	 ece531rwbvch021mdGEH1cnBW2FBRWWdG7t3fc+CMHP3Ka3/6+WesXRwrYvykQIWgv
	 ofGK0tuRPBExQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] nvdimm: virtio_pmem: always wake -ENOSPC waiters
Date: Fri, 11 Sep 2026 06:41:39 -0400
Message-ID: <20260911104140.195754-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911104140.195754-1-sashal@kernel.org>
References: <2026090940-grappling-configure-44a7@gregkh>
 <20260911104140.195754-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Chen <me@linux.beauty>

[ Upstream commit 811808761e19fdea1c25b7c76734b8945f758f27 ]

virtio_pmem_host_ack() reclaims virtqueue descriptors with
virtqueue_get_buf(). The -ENOSPC waiter wakeup is tied to completing the
returned token. If token completion is skipped for any reason, reclaimed
descriptors may not wake a waiter and the submitter may sleep forever
waiting for a free slot. Always wake one -ENOSPC waiter for each virtqueue
completion before touching the returned token.

Signed-off-by: Li Chen <me@linux.beauty>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260630092338.2094628-7-me@linux.beauty>

Backport notes for 6.1:
Keep the waiter helper from this dependency and fold in the wait-flag
READ_ONCE()/WRITE_ONCE() changes from 08e72a5ba1ab9. Remove the waiter
from the list before publishing buffer availability and waking it.
These changes provide the submission and completion context expected by
e57140944b5a without changing the stable allocation or child-bio paths.

Retain the upstream virtio_pmem_flush_work type and its workqueue header
as context for the target's request-release insertion. No workqueue flush
implementation is imported; the type itself has no runtime effect.

Stable-dep-of: e57140944b5a ("nvdimm: virtio_pmem: refcount requests for token lifetime")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/nd_virtio.c   | 41 ++++++++++++++++++++++++------------
 drivers/nvdimm/virtio_pmem.h |  1 +
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 90b0fdb72024a..9962ceec074d2 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -9,26 +9,39 @@
 #include "virtio_pmem.h"
 #include "nd.h"
 
+struct virtio_pmem_flush_work {
+	struct work_struct work;
+	struct nd_region *nd_region;
+	struct bio *bio;
+};
+
+static void virtio_pmem_wake_one_waiter(struct virtio_pmem *vpmem)
+{
+	struct virtio_pmem_request *req_buf;
+
+	if (list_empty(&vpmem->req_list))
+		return;
+
+	req_buf = list_first_entry(&vpmem->req_list,
+				   struct virtio_pmem_request, list);
+	list_del_init(&req_buf->list);
+	WRITE_ONCE(req_buf->wq_buf_avail, true);
+	wake_up(&req_buf->wq_buf);
+}
+
  /* The interrupt handler */
 void virtio_pmem_host_ack(struct virtqueue *vq)
 {
 	struct virtio_pmem *vpmem = vq->vdev->priv;
-	struct virtio_pmem_request *req_data, *req_buf;
+	struct virtio_pmem_request *req_data;
 	unsigned long flags;
 	unsigned int len;
 
 	spin_lock_irqsave(&vpmem->pmem_lock, flags);
 	while ((req_data = virtqueue_get_buf(vq, &len)) != NULL) {
-		req_data->done = true;
+		virtio_pmem_wake_one_waiter(vpmem);
+		WRITE_ONCE(req_data->done, true);
 		wake_up(&req_data->host_acked);
-
-		if (!list_empty(&vpmem->req_list)) {
-			req_buf = list_first_entry(&vpmem->req_list,
-					struct virtio_pmem_request, list);
-			req_buf->wq_buf_avail = true;
-			wake_up(&req_buf->wq_buf);
-			list_del(&req_buf->list);
-		}
 	}
 	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
 }
@@ -59,7 +72,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	if (!req_data)
 		return -ENOMEM;
 
-	req_data->done = false;
+	WRITE_ONCE(req_data->done, false);
 	init_waitqueue_head(&req_data->host_acked);
 	init_waitqueue_head(&req_data->wq_buf);
 	INIT_LIST_HEAD(&req_data->list);
@@ -80,12 +93,12 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 					GFP_ATOMIC)) == -ENOSPC) {
 
 		dev_info(&vdev->dev, "failed to send command to virtio pmem device, no free slots in the virtqueue\n");
-		req_data->wq_buf_avail = false;
+		WRITE_ONCE(req_data->wq_buf_avail, false);
 		list_add_tail(&req_data->list, &vpmem->req_list);
 		spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
 
 		/* A host response results in "host_ack" getting called */
-		wait_event(req_data->wq_buf, req_data->wq_buf_avail);
+		wait_event(req_data->wq_buf, READ_ONCE(req_data->wq_buf_avail));
 		spin_lock_irqsave(&vpmem->pmem_lock, flags);
 	}
 	err1 = virtqueue_kick(vpmem->req_vq);
@@ -99,7 +112,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 		err = -EIO;
 	} else {
 		/* A host repsonse results in "host_ack" getting called */
-		wait_event(req_data->host_acked, req_data->done);
+		wait_event(req_data->host_acked, READ_ONCE(req_data->done));
 		err = le32_to_cpu(req_data->resp.ret);
 	}
 
diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
index f72cf17f9518f..c604784e3804e 100644
--- a/drivers/nvdimm/virtio_pmem.h
+++ b/drivers/nvdimm/virtio_pmem.h
@@ -15,6 +15,7 @@
 #include <linux/libnvdimm.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
+#include <linux/workqueue.h>
 
 struct virtio_pmem_request {
 	struct virtio_pmem_req req;
-- 
2.53.0

