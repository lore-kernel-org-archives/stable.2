Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6C33CEBBD
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787869241; cv=none; b=CIysLSeEBK7r9da8aMkrGVtWa70hG4An629KZZKWnSrggkKko3tXS1/bGNK51F82YTCt1frEBsEphbIZPlawPGOvtBiwM64/o3s2QH4Tx8QYOVb/CTbnzdAvc65nyX448eNsI2yRHVV4/6QoxqNzmrJzQmLVP/pEfV/NSHciswo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787869241; c=relaxed/simple;
	bh=u7ksE+00Y4eU4pG18NB/rwbVhkpmiMDvnLPiiVM/p6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvgGhjVuJqCbv8iEoPVYLJ45nnvw9lStXsRGjbyfgeRTO6WNtkfZX6JnxuZoyIYhVXETmslNcoqAyGbZ/YIRi1v1AhGMbpMwDbrNHGDb13BQT7kQlKLe8HLqU/EgjZkSC2eUJqkHDssJ+jdorNdLw5E7fZjl9AFcZG76EjXEmaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2GOT9nH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2GOT9nH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD581F00A3A;
	Thu, 27 Aug 2026 22:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787869224;
	bh=EvtJJsw7v4EROBNhwu+vSqrIh4k0LdD47fdLJjTypVM=;
	h=From:To:Cc:Subject:Date;
	b=l2GOT9nHlYXVch/YAJNnf3oZ1wMkmcs9hO8HmB0amVJpHUYP1MT3uF1EGwajv3TWc
	 piaiw/TjRVsMF85KK+reKkOEww7gnWgnnPP7VVnCrhYAs+iB+rPg/6WN8LaGxGZZ9T
	 V4Mm9GXqTceI5bKXuFtfiTtSVCLwLEvf7gO7N4A0x21f60L5NiDpJCf6rmACbP1SS6
	 9Sp2QeBw8hYm8z18ArjB7sigqRJYrT7zlHBxsjnMzYLpllRuCMpBMfGf3e4nJZauY4
	 o5+VCumxG7DqsNpDALHLl9jwqN9Pq91t4fYtsejQPw+dka+YR9GXnUfi06vFGeUOkJ
	 eDY7VbdL+96bA==
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
Subject: [PATCH 6.18.y] nvme-tcp: fix usage of page_frag_cache
Date: Thu, 27 Aug 2026 15:20:22 -0700
Message-ID: <20260827222022.45428-1-carlos.bilbao@kernel.org>
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

Build-tested: 6.18.47 (x86_64 defconfig + CONFIG_NVME_TCP=m).
Also needed in 6.12.y, 7.1.y (backports submitted separately); 7.2.y
takes the upstream commit cleanly.

 drivers/nvme/host/tcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index afdbcff..04c074a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -145,6 +145,7 @@ struct nvme_tcp_queue {
 
 	struct mutex		queue_lock;
 	struct mutex		send_mutex;
+	struct mutex		pf_cache_lock;
 	struct llist_head	req_list;
 	struct list_head	send_list;
 
@@ -556,9 +557,11 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	mutex_lock(&queue->pf_cache_lock);
 	req->pdu = page_frag_alloc(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&queue->pf_cache_lock);
 	if (!req->pdu)
 		return -ENOMEM;
 
@@ -1423,9 +1426,11 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 	struct nvme_tcp_request *async = &ctrl->async_req;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	mutex_lock(&queue->pf_cache_lock);
 	async->pdu = page_frag_alloc(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&queue->pf_cache_lock);
 	if (!async->pdu)
 		return -ENOMEM;
 
@@ -1453,6 +1458,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 }
 
 static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
@@ -1775,6 +1781,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	INIT_LIST_HEAD(&queue->send_list);
 	mutex_init(&queue->send_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
+	mutex_init(&queue->pf_cache_lock);
 
 	if (qid > 0)
 		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
@@ -1906,6 +1913,7 @@ err_sock:
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 	return ret;
 }
 
-- 
2.50.1 (Apple Git-155)

