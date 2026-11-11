Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361658;
	b=wGAsXyHi4mAZG1/Kbgo/hABH9m19iSgANl0LXMXyQ+ad/c1CSLlz9lhyCAy+CYJ7VM7v
	 8ljJruJWrGn1+qNeEE698KfYDAw58TIR0NCJ5pZbV+W5PsjyoELAJ4zC0tn7nOp+FXtNy
	 PAG7h6RsLuSBnTvXD2ouWlUelB3jXY+MynZV555r5BEkAqdzi2BrNbcv+e+MC0f2apgd8
	 +HsFLXr/plp2Wzky33WQ1cOpEmAQbRFQKacun0AmMYQLvrFVC4EJPJieokvI/4fvhAjpd
	 poNm6E7saWVCltkt55iuIUHINEO2Q1sAZttZTsGS5oMs/2VgVg55yPUHSxZ4Fat7ntQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361658;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7SeqNWqab8zOovQL1fLBpJcOrY2Z6wtp+PC7OL5Tht8=;
	b=NCckHgLePZMAeO9ANfM1fvUxD3lV+HjFaosd+BUYwpqaglpn0FXYA9ZaH8cg8YLjj7dD
	 b7/sbbK6XL1BeTyiycTdPmGu1VfsNh7The11sWaXBBuCAQZdcDkytQo1FQs6Nq4qLxc7T
	 gp+1W/Os2oPpMXTCF+58KETC6OYJ7Plc5zU0oQeqj+VkJTp5DLlRxDKvmhbxztWhyz1S6
	 btn1SY+yht0sPId1eF2FCkvPyIL8KOgiX2QzltjeWjPPX7EPLX3/ffxzyZZMZ/l76Ec5F
	 82aSEmhP43JwvWW6pVDmQGHwHnE/Q1bLljbOQpFQwZH+P8Gi+tjCCMZZnp9Vel+vcBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPh8T6zF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB30606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPh8T6zF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AE11F0089F;
	Wed, 11 Nov 2026 01:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794361657;
	bh=7SeqNWqab8zOovQL1fLBpJcOrY2Z6wtp+PC7OL5Tht8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RPh8T6zFudQuUu90BdWRZuBVGfaRvUsNmjN3hgX9q1g1hqpa1gXRgOkj3EN2Ao0xv
	 +4+JTmchuiKC7ptHHTW3nirtQJcdeSvUSSumgTV9dfvb3EuAEQvaI0kxOy59Utosqr
	 zpQuBZg/auDlReu/CQVNBnXXOvWlPmdpfaCTGlTICWlzx85/sRXfDjqOzN1JX3RoOJ
	 xM5MFeoSSt1JhW4bOi9yzQb8vIKUAnNKmV9P0phIkZUm//hWAKAjyAqfONvEaRZt5k
	 rnmfiLkhGTGPJiqBSlB7D0lRY1CQVPQWa6tyrxU2fGFIIM1bVPERG/EDKE1kSVHtdo
	 ihR3AgXLbKlJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guixin Liu <kanie@linux.alibaba.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] nvme-tcp: Validate the queue state under the queue lock in the address attribute
Date: Tue, 10 Nov 2026 20:47:35 -0500
Message-ID: <20261111014714.403513-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050559-failed-7.3-2eeeaa9c1ff0@kernel.org>
References: <20261107050559-failed-7.3-2eeeaa9c1ff0@kernel.org>
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

From: Guixin Liu <kanie@linux.alibaba.com>

[ Upstream commit 2eeeaa9c1ff0c429096acc2947c296db6a56f96d ]

Reading the "address" sysfs attribute calls kernel_getsockname() on the
admin queue socket, which can race with the queue teardown during
connection error recovery: a reader can observe NVME_TCP_Q_LIVE set,
then block on the queue lock while nvme_tcp_free_queue() releases the
socket and clears queue->sock without holding the lock.  Once the
reader acquires the lock it dereferences the NULL socket pointer.

Commit 76d54bf20cdc ("nvme-tcp: don't access released socket during
error recovery") had the queue liveness check inside the lock.
Commit 782373ba2766 ("nvme: tcp: avoid race between queue_lock lock
and destroy") moved it back out because the lock itself is destroyed
in nvme_tcp_free_queue(), so a reader arriving late trips
mutex_destroy().

Check the queue liveness inside the queue lock, and clear queue->sock
under the same lock.  The teardown clears NVME_TCP_Q_LIVE under the
lock well before the socket is released, so a reader either sees the
bit cleared or a socket that cannot be released while it holds the
lock.  To also close the lock lifetime race, the queue locks are now
owned by the controller: they are initialized with the queue array and
only destroyed when the controller is freed, which cannot happen while
a sysfs attribute read is still in progress.  The queue count is
computed by the NVME_TCP_OPT_NR_QUEUES() macro from the original
connect options for both initialization and destruction, as reconnects
may shrink ctrl->queue_count.

Fixes: 782373ba2766 ("nvme: tcp: avoid race between queue_lock lock and destroy")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ sashal: Added a standalone queue_lock initialization loop because the upstream page-fragment cache initialization loop is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 51 +++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ce28c9b038178..667bcdcc2cd18 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -111,6 +111,9 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_IO_CPU_SET	= 3,
 };
 
+#define NVME_TCP_OPT_NR_QUEUES(opts) ((opts)->nr_io_queues + \
+	(opts)->nr_write_queues + (opts)->nr_poll_queues + 1)
+
 enum nvme_tcp_recv_state {
 	NVME_TCP_RECV_PDU = 0,
 	NVME_TCP_RECV_DATA,
@@ -1550,14 +1553,21 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	 * nvme_reset_ctrl_work(), queue teardown is immediately followed by
 	 * re-allocation. fput() defers socket cleanup to delayed_fput_work
 	 * in workqueue context, which can race with new queue setup.
+	 *
+	 * Clear queue->sock under the queue lock so that a sysfs reader in
+	 * nvme_tcp_get_address() either observes the NVME_TCP_Q_LIVE bit
+	 * cleared or a still valid socket.  The queue lock itself is owned
+	 * by the controller and only destroyed when the controller is
+	 * freed, so readers blocked on it cannot race its teardown.
 	 */
+	mutex_lock(&queue->queue_lock);
 	__fput_sync(queue->sock->file);
 	queue->sock = NULL;
+	mutex_unlock(&queue->queue_lock);
 	memalloc_noio_restore(noio_flag);
 
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
-	mutex_destroy(&queue->queue_lock);
 	mutex_destroy(&queue->pf_cache_lock);
 }
 
@@ -1877,7 +1887,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	int ret, rcv_pdu_size;
 	struct file *sock_file;
 
-	mutex_init(&queue->queue_lock);
 	queue->ctrl = ctrl;
 	init_llist_head(&queue->req_list);
 	INIT_LIST_HEAD(&queue->send_list);
@@ -2015,7 +2024,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	queue->sock = NULL;
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
-	mutex_destroy(&queue->queue_lock);
 	mutex_destroy(&queue->pf_cache_lock);
 	return ret;
 }
@@ -2665,6 +2673,9 @@ static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
 static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	/* the same count used to size and initialize the queue array */
+	unsigned int nr_queues = NVME_TCP_OPT_NR_QUEUES(nctrl->opts);
+	unsigned int i;
 
 	if (list_empty_careful(&ctrl->list))
 		goto free_ctrl;
@@ -2675,6 +2686,8 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 
 	nvmf_free_options(nctrl->opts);
 free_ctrl:
+	for (i = 0; i < nr_queues; i++)
+		mutex_destroy(&ctrl->queues[i].queue_lock);
 	kfree(ctrl->queues);
 	kfree(ctrl);
 }
@@ -2927,17 +2940,18 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 
 	len = nvmf_get_address(ctrl, buf, size);
 
-	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
-		return len;
-
 	mutex_lock(&queue->queue_lock);
 
-	ret = kernel_getsockname(queue->sock, (struct sockaddr *)&src_addr);
-	if (ret > 0) {
-		if (len > 0)
-			len--; /* strip trailing newline */
-		len += scnprintf(buf + len, size - len, "%ssrc_addr=%pISc\n",
-				(len) ? "," : "", &src_addr);
+	if (test_bit(NVME_TCP_Q_LIVE, &queue->flags)) {
+		ret = kernel_getsockname(queue->sock,
+				(struct sockaddr *)&src_addr);
+		if (ret > 0) {
+			if (len > 0)
+				len--; /* strip trailing newline */
+			len += scnprintf(buf + len, size - len,
+					"%ssrc_addr=%pISc\n",
+					(len) ? "," : "", &src_addr);
+		}
 	}
 
 	mutex_unlock(&queue->queue_lock);
@@ -3003,7 +3017,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
 	struct nvme_tcp_ctrl *ctrl;
-	int ret;
+	int ret, i;
 
 	ctrl = kzalloc_obj(*ctrl);
 	if (!ctrl)
@@ -3014,8 +3028,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	 */
 	context_unsafe(INIT_LIST_HEAD(&ctrl->list));
 	ctrl->ctrl.opts = opts;
-	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
-				opts->nr_poll_queues + 1;
+	ctrl->ctrl.queue_count = NVME_TCP_OPT_NR_QUEUES(opts);
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
@@ -3073,6 +3086,14 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
+	/*
+	 * The queue locks are owned by the controller, not the queues:
+	 * they outlive the per-queue connect/disconnect cycles so that
+	 * sysfs readers can never race their destruction.
+	 */
+	for (i = 0; i < ctrl->ctrl.queue_count; i++)
+		mutex_init(&ctrl->queues[i].queue_lock);
+
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_tcp_ctrl_ops, 0);
 	if (ret)
 		goto out_kfree_queues;
-- 
2.53.0

