Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F212BD0B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086575; cv=none; b=i8iKGzeuDTFgrmijkwuyWGAYl3kKuHU36WPgEJLP3CwGTYsWKx/VXA8NwxTUkmzbxK5s/VaeHr/x4Nzkug7nEucZrqld99AQ5W8m4UvEC0oBG+hYtBmgqSOyglfrRkeoj0QPvkEZIRLnyZMnDK/+EVohGFb4cw0zLeO/6Nopkr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086575; c=relaxed/simple;
	bh=b3VEzD4rm/FS/PnzVVrz5CWx+QC9gU4eZsOGUXkAeZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaCTI4tSOGVtavNCmJz5WewSbNpI5zAzeGWzbpNcpdjQpoMMeImT9cUWDqRtqfRbvussSM+lkeZ8BPGYhrnwx+EkQP+NQjzMbAPZ/WNiZcwVixJ6V3x88nxVbtyX/lZ8TPWnmVM1BUMqb+V/NvWwpmPGKNqTq8Lx56i3w1vZb7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD9RseA4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD9RseA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5247F1F000FF;
	Fri, 11 Sep 2026 00:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789086573;
	bh=Tqn1mzJAt+JsUB+KmhiMk6YYRyqZ8rAayjHO9VEALk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OD9RseA4MMRWMrQyHPB2KPJIuxddkSl3y/aeDsdFN8E8h3OjCdMj9QhbG7o1lPwwH
	 yH9WE/P5I/ZjBUH+iS3NLrlSYEVm3mor81OUVdbwmeoepyljmgzqOJieWW4EbRpwGf
	 fmr5rW8kbhy7iqLqibNXGBFUUj6MlzfprI0x8z+RvjOcJ/2pl95VK2AlJOfD3bn+nj
	 XM1C/GBZf0Zzx2Ciudq9VWAaHISqmFYcHFBdgg9OpQof7p0aTaZPk59oeDFGi7giaQ
	 J5TXVpn8CayVT0wYUvJ02HP/jEzsZGgw8HR9wgObN4JyiWLKo7lxg2vvWcee0m6gxI
	 2Yj6zZjqGJ6Sg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 5/6] nvdimm: virtio_pmem: use READ_ONCE()/WRITE_ONCE() for wait flags
Date: Thu, 10 Sep 2026 20:29:27 -0400
Message-ID: <20260911002928.3429646-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911002928.3429646-1-sashal@kernel.org>
References: <2026090938-graves-stress-5791@gregkh>
 <20260911002928.3429646-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Chen <me@linux.beauty>

[ Upstream commit 08e72a5ba1ab9dc0adf993ff0f4d606a1e3445a8 ]

Use READ_ONCE()/WRITE_ONCE() for the wait_event() flags (done and
wq_buf_avail). They are observed by waiters without pmem_lock, so make
the accesses explicit single loads/stores and avoid compiler
reordering/caching across the wait/wake paths.

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: Li Chen <me@linux.beauty>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260630092338.2094628-8-me@linux.beauty>
Stable-dep-of: e57140944b5a ("nvdimm: virtio_pmem: refcount requests for token lifetime")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/nd_virtio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 75183a177d75d..4f40cf85feb40 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -24,9 +24,9 @@ static void virtio_pmem_wake_one_waiter(struct virtio_pmem *vpmem)
 
 	req_buf = list_first_entry(&vpmem->req_list,
 				   struct virtio_pmem_request, list);
-	req_buf->wq_buf_avail = true;
+	list_del_init(&req_buf->list);
+	WRITE_ONCE(req_buf->wq_buf_avail, true);
 	wake_up(&req_buf->wq_buf);
-	list_del(&req_buf->list);
 }
 
  /* The interrupt handler */
@@ -40,7 +40,7 @@ void virtio_pmem_host_ack(struct virtqueue *vq)
 	spin_lock_irqsave(&vpmem->pmem_lock, flags);
 	while ((req_data = virtqueue_get_buf(vq, &len)) != NULL) {
 		virtio_pmem_wake_one_waiter(vpmem);
-		req_data->done = true;
+		WRITE_ONCE(req_data->done, true);
 		wake_up(&req_data->host_acked);
 	}
 	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
@@ -72,7 +72,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	if (!req_data)
 		return -ENOMEM;
 
-	req_data->done = false;
+	WRITE_ONCE(req_data->done, false);
 	init_waitqueue_head(&req_data->host_acked);
 	init_waitqueue_head(&req_data->wq_buf);
 	INIT_LIST_HEAD(&req_data->list);
@@ -93,12 +93,12 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
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
@@ -112,7 +112,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 		err = -EIO;
 	} else {
 		/* A host response results in "host_ack" getting called */
-		wait_event(req_data->host_acked, req_data->done);
+		wait_event(req_data->host_acked, READ_ONCE(req_data->done));
 		err = le32_to_cpu(req_data->resp.ret);
 	}
 
-- 
2.53.0

