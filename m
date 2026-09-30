Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088064BB299
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781229; cv=none; b=GhL663WJ3dpEu2Tsa8gKwjWq/IWXt56loUnfkYnhXyI0GM0LRCpRvduMbDX5/wBir0PZaHNmejA64P4z8ITe1+97CJAyjma8sJacEPM91GtD7pV+cGfoaqlseT5nC/KRx5VfoTti573bvX9+w9CX4abppfqb7dT7vo6uySc5rGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781229; c=relaxed/simple;
	bh=2iJPsnOsQYpjabd5+/L38Qh6TvR7nNXxHCYhoqKjnQs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y9TB1eYan7q8DLKo/S6/qPdVeJGELlaaoXgeEwfAgPAdpnnLYVbO6Q5pbQLl7HpoPsdPZmtGPltzjApYCYbMEO2EjbBAhkJvgnPsfGykpHyFye7I/mjWSfef6Y5xQuBG3kYGkKlO1gMCQdhT/QY9HGd6KqgrO9WsQ8Tjm4qRFWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pO16htan; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pO16htan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DA31F000FF;
	Wed, 30 Sep 2026 15:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790781215;
	bh=QrM9lY5CKw49MP8DcW9SjtttuCBvEaCZc0vXzbZv9LM=;
	h=Subject:To:Cc:From:Date;
	b=pO16htanFlbZkC4SleAa8AbJ6FXKPfqOWUqznsZGzCXXG4s0v5Ben7OOQTdztP5GG
	 UV7eV/Oj4RH+GDuxXswTJ2j6Mdd8m9Pn3PChjUcJCrp9McJ38A0y6iagc42rf1Ng0T
	 JObBOqAfWpVIirzz2DUHKC1g34RfH+sDH/WxY/k0=
Subject: FAILED: patch "[PATCH] nvme-tcp: fix usage of page_frag_cache" failed to apply to 6.6-stable tree
To: d.bogdanov@yadro.com,kbusch@kernel.org,wagi@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 30 Sep 2026 17:13:29 +0200
Message-ID: <2026093029-shadily-cattle-6976@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 36ac05f7cfd59d90c597071304b14e98090d5dd1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026093029-shadily-cattle-6976@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 36ac05f7cfd59d90c597071304b14e98090d5dd1 Mon Sep 17 00:00:00 2001
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
Date: Thu, 16 Jul 2026 16:42:19 +0200
Subject: [PATCH] nvme-tcp: fix usage of page_frag_cache

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

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0b2ac150b675..1d303e54e13e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -108,6 +108,7 @@ struct nvme_tcp_queue {
 
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
 
@@ -1419,9 +1422,11 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 	struct nvme_tcp_request *async = &ctrl->async_req;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	mutex_lock(&queue->pf_cache_lock);
 	async->pdu = page_frag_alloc(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&queue->pf_cache_lock);
 	if (!async->pdu)
 		return -ENOMEM;
 
@@ -1463,6 +1468,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
@@ -1790,6 +1796,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	INIT_LIST_HEAD(&queue->send_list);
 	mutex_init(&queue->send_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
+	mutex_init(&queue->pf_cache_lock);
 
 	if (qid > 0)
 		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
@@ -1930,6 +1937,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 	return ret;
 }
 

