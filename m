Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2323B3BE7
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787869239; cv=none; b=azb29t2Eul3fP3l4kt8DUFoq66chJw9RFd71mw7Qf+wzbyvyCWF1nFxxf7gJf9LQlKpkqjAzdAmOc7WHLk9Q9jj2xwwxaja6YCJY7KYnDI0WQsEO9guftNUYcvHFQV6LR511VajV3BmpBN7Rn10C5HkInr7QJ2cRK9ng7m3NF8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787869239; c=relaxed/simple;
	bh=9hFkLIq2e6XBYKHxlS54q+sMO49yBClDBuFDFOT1N6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d9ZaKbOw5g9gGkRdbnnzmTxqI++znwWYQCiMh+RobdqQpDuQ77GhemACNJefqpfsMffnts3hyJ68/Y1iS9ftSTUtCynGjLkBTJYs2Bnih7ysvSKSV3dhYpFf7/be08EQjz4KFZEbBCtZlb8oYcwID87pbUhLZjrv1iLgpj13c2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1ikjFfB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1ikjFfB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B8C1F00A3D;
	Thu, 27 Aug 2026 22:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787869227;
	bh=SS0ynuIrGmem4mBhJbEvUL85Mkzd/B/SVmok/JajQps=;
	h=From:To:Cc:Subject:Date;
	b=d1ikjFfBQ8oQfL2cpDYjuZHBWMUbRdyPFGkyJOx5FR4A+LO/oxZeHz1dRa+qVGrXh
	 WqMhEchkAS5g/T20ph4eX2zL3Skwo88SBe7wlfiB6/QMc946WyMbjewPeQJYnby85C
	 yLPxD6NzhxPDrYsQDPzuSCdaMkLmFpdvfjrBkE7Kj6KpEsm/B5ikzFZDH/PDtPNF1G
	 muVSKTQzeCfwmaij7kcmPy2UDCIa+cSjVARY19ZaETk3IsOvgQTVogBOQZarzufNcS
	 yVOdmbnKuyrxs+QwRgqWMR6CNPPjDwxaXC6tn/WKNTgOP2b7svv+NaP4p3JH9RJOLZ
	 OJpKcPycgCIYg==
From: "Carlos Bilbao (Lambda)" <carlos.bilbao@kernel.org>
To: stable@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	d.bogdanov@yadro.com,
	wagi@kernel.org,
	linux-nvme@lists.infradead.org,
	bilbao@vt.edu,
	ryan.arnold@lambdal.com,
	krishna.mohan@lambdal.com,
	christian.jones@lambdal.com,
	eduardo.habkost@lambdal.com,
	brian.kopp@lambdal.com,
	Carlos Bilbao <carlos.bilbao@kernel.org>
Subject: [PATCH 7.1.y] nvme-tcp: fix usage of page_frag_cache
Date: Thu, 27 Aug 2026 15:20:24 -0700
Message-ID: <20260827222024.45443-1-carlos.bilbao@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Bogdanov <d.bogdanov@yadro.com>

commit 36ac05f7cfd59d90c597071304b14e98090d5dd1 upstream.

nvme uses page_frag_cache to preallocate PDU for each preallocated request
of block device. Block devices are created in parallel threads,
consequently page_frag_cache is used in not thread-safe manner.
That leads to incorrect refcounting of backstore pages and premature free.

That can be catched by !sendpage_ok inside network stack:

WARNING: CPU: 7 PID: 467 at ../net/core/skbuff.c:6931 skb_splice_from_iter+0xfa/0x310.
	tcp_sendmsg_locked+0x782/0xce0
	tcp_sendmsg+0x27/0x40
	sock_sendmsg+0x8b/0xa0
	nvme_tcp_try_send_cmd_pdu+0x149/0x2a0
Then random panic may occur.

Fix that by serializing the usage of page_frag_cache.

Fixes: 4e893ca81170 ("nvme_core: scan namespaces asynchronously")
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[carlos.bilbao: adjust context in nvme_tcp_free_queue; branch predates
19bdb70c77d3 ("nvme-tcp: lockdep: use dynamic lockdep keys per socket
instance")]
Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
---
Context conflict in nvme_tcp_free_queue due to 19bdb70c77d3; context-only
adjustment, no functional change.

Build-tested: 7.1.11 (x86_64 defconfig + CONFIG_NVME_TCP=m).
Also needed in 6.12.y, 6.18.y (backports submitted separately); 7.2.y
takes the upstream commit cleanly.

 drivers/nvme/host/tcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 68a1d76..bd53ee5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -146,6 +146,7 @@ struct nvme_tcp_queue {
 
 	struct mutex		queue_lock;
 	struct mutex		send_mutex;
+	struct mutex		pf_cache_lock;
 	struct llist_head	req_list;
 	struct list_head	send_list;
 
@@ -557,9 +558,11 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	mutex_lock(&queue->pf_cache_lock);
 	req->pdu = page_frag_alloc(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&queue->pf_cache_lock);
 	if (!req->pdu)
 		return -ENOMEM;
 
@@ -1424,9 +1427,11 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 	struct nvme_tcp_request *async = &ctrl->async_req;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	mutex_lock(&queue->pf_cache_lock);
 	async->pdu = page_frag_alloc(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&queue->pf_cache_lock);
 	if (!async->pdu)
 		return -ENOMEM;
 
@@ -1468,6 +1473,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 }
 
 static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
@@ -1790,6 +1796,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	INIT_LIST_HEAD(&queue->send_list);
 	mutex_init(&queue->send_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
+	mutex_init(&queue->pf_cache_lock);
 
 	if (qid > 0)
 		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
@@ -1921,6 +1928,7 @@ err_sock:
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 	return ret;
 }
 
-- 
2.50.1 (Apple Git-155)

