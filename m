Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127953B27FB
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787869235; cv=none; b=BhtUWdF+uDUjfZUvIjGYTVm92YqZjEPPW/q9BpkHdhwxXJYyIqof42crkKr51HWgOS1KLf9R66yk1CR1hJlhXiHZk5ZF0AXcJeRDftUFn596qSUNR/sMFyHJosILKpbmSVhzB/fXo5K1cmpmlgxyrBQMJKO+mR0UAyAMq/o5QnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787869235; c=relaxed/simple;
	bh=/s2ufDmNmfINSb2vZ49mS3SRQRwzOriZXcOxqdpLOis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cxvApT0T+i0ZmmPMYSiuoRmM4UnrTd5Gma/w9X6Cn5BF8fUEfgiP6evXuictCQYF/AsgNPi7j3r40C8N3jYS0KI30K1VbRSXhu+7og0ClIau4Lx03tL/tOxHXgd0Pd/P7VJy7Mm+jBFUP4NN0lXnBvKjGyfEifNPPzS/3ysOrVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HO63WuWr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HO63WuWr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793F11F000E9;
	Thu, 27 Aug 2026 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787869221;
	bh=+83/0PiMldbSoZ2zfBwj9o6WmDNxUA+kO11sfip3qvQ=;
	h=From:To:Cc:Subject:Date;
	b=HO63WuWraL4Vvt9RGjcapfPVtVaKT8rekjljQBHAXOSgpud95A73xskPjxcmX0wve
	 bbTyVTzTwZTtqZOrykQY8M6WX1BYH+px/EDoOtfB4kXqbgS+xYd+IUIDsHHDRg1Knk
	 EbixeNCBuCgIRPt0uxIJKOkfjQEnnUnYoX4p/tVgjjctaW7cFXMozQdN6Ik42sOk6p
	 Ed7ITQhPNcvVrL4Jv0DIT1a47hjlfGe1vTOKhJYRlj+wQCWf2ynYC+nXT8QraL/F9f
	 +ykxg0L2/wsh9nBGcNaT7oUPcdrquTIh3z0gmytVqcDIQaxzSKNHEShXeVSjjRoAB8
	 ndIXO7nQOI/1w==
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
Subject: [PATCH 6.12.y] nvme-tcp: fix usage of page_frag_cache
Date: Thu, 27 Aug 2026 15:20:15 -0700
Message-ID: <20260827222015.45415-1-carlos.bilbao@kernel.org>
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

Build-tested: 6.12.106 (x86_64 defconfig + CONFIG_NVME_TCP=m).
Also needed in 6.18.y, 7.1.y (backports submitted separately); 7.2.y
takes the upstream commit cleanly.

 drivers/nvme/host/tcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3140643..dc91706 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -146,6 +146,7 @@ struct nvme_tcp_queue {
 
 	struct mutex		queue_lock;
 	struct mutex		send_mutex;
+	struct mutex		pf_cache_lock;
 	struct llist_head	req_list;
 	struct list_head	send_list;
 
@@ -552,9 +553,11 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	mutex_lock(&queue->pf_cache_lock);
 	req->pdu = page_frag_alloc(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&queue->pf_cache_lock);
 	if (!req->pdu)
 		return -ENOMEM;
 
@@ -1452,9 +1455,11 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 	struct nvme_tcp_request *async = &ctrl->async_req;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	mutex_lock(&queue->pf_cache_lock);
 	async->pdu = page_frag_alloc(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&queue->pf_cache_lock);
 	if (!async->pdu)
 		return -ENOMEM;
 
@@ -1485,6 +1490,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 }
 
 static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
@@ -1807,6 +1813,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	INIT_LIST_HEAD(&queue->send_list);
 	mutex_init(&queue->send_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
+	mutex_init(&queue->pf_cache_lock);
 
 	if (qid > 0)
 		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
@@ -1946,6 +1953,7 @@ err_sock:
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 	return ret;
 }
 
-- 
2.50.1 (Apple Git-155)

