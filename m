Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045961;
	b=EG3CJJ1fEdHrMZIgRO1e+ZGigzZTvbFuKQ4uwONshmbmyo+w+z3/hmi5u/JCVKr2MblC
	 BK/jY3OEQ5WcdlKNBUAelscfunbIv81BZTIDzZ9xFent9MTSve53XceErdPq63KryLejT
	 ieY3rcyMVdrZKVohAUQAeqwPl+GeNbKHXgJA/Lk8+NkZjYOmDGkzU/0yiqi7tK9l0SWVg
	 KpChJioMrd5l0J8Ztl8320YUNNxP3UK+sknaYHUBJvceYgO/aAjReqQ5CrHqBn0S4v9+f
	 4N9uyHSYMLm5Ci6Yn4596b33YqMc26SH40sYLeefBZmsOH0wYDhA3pxH+syuiKW82dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045961;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NzPp4sSwBtTIigyLtqHUf6EFWYQDz2mXgq9Ihnk3xr4=;
	b=uXPkuFYB8CsN2e1/+6hwjIl/d69mIJY+t+DW+bO7V9S++aGtAZcLcNH4qT4Bx6miFRKQ
	 OPogyx5BQA7sRpf53rkVZw5Nr4fD6hOzbSv6/NuOSCqCZicKsmd0i5+NsaQDQ0br1QXpv
	 SQ5E2KZiz3vgH+AO+MYYHaR3/KvEU4zZxC1rm32+0C+VF6pqW/gnG6wP/iKKqEkGySouk
	 ugDiZIVqQymnjenJR8X3MwHBHPeyeUilAwZQbl9XoWZrfOdJiglM7Wu9o82IxPc0BExFx
	 MYuNPL/7vmVEyQPcsiSr1rCb7TzjF+jcuQjCX4E34bC2twc4BGvaGRP52LPi2j2KkVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1gkGykb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DE2606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1gkGykb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFA41F0089F;
	Sat,  7 Nov 2026 10:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045960;
	bh=NzPp4sSwBtTIigyLtqHUf6EFWYQDz2mXgq9Ihnk3xr4=;
	h=From:To:Cc:Subject:Date;
	b=F1gkGykbwUaRxl4/+1cvMzunpCA2mfyOu1e1fbF6KgZ5vhsijaZojeJbciHAZwpHP
	 IIALNMFdeQFSc7eNaIWHonwzlzaGwcLJ9O60ltHbwqeeNqgCII5nd2ad7Ua0G06rIA
	 xpduAN6ZuvCrKXVJ+Nl7GqSdR/tGBDO/Dc9LdQTC62RUNM1PBCDA4s77lOl/Q2E83J
	 KMh3vDqjRIDybz40r/lxfEbUlFxf4BEWCdXGreKHphEOHe+kH9/9QKV2N5u7FRsWE9
	 yFtZRIWW0mYBDzMb6V24ZlZpROdv8nPBqdBu6M8+1KbWhFSwI0LEWOxm9PKDVzczN8
	 +eeDWFW+0KdtA==
From: Sasha Levin <sashal@kernel.org>
To: kanie@linux.alibaba.com,
	nilay@linux.ibm.com,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvme-tcp: Validate the queue state under the queue lock in the address attribute" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:05:59 -0500
Message-ID: <20261107050559-failed-7.3-2eeeaa9c1ff0@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 2eeeaa9c1ff0c429096acc2947c296db6a56f96d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050559-failed-7.3-2eeeaa9c1ff0@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2eeeaa9c1ff0c429096acc2947c296db6a56f96d Mon Sep 17 00:00:00 2001
From: Guixin Liu <kanie@linux.alibaba.com>
Date: Wed, 28 Oct 2026 10:09:04 +0800
Subject: [PATCH] nvme-tcp: Validate the queue state under the queue lock in
 the address attribute

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
---
 drivers/nvme/host/tcp.c | 47 ++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1f7a2de954197..39cb636872938 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -103,6 +103,9 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_IO_CPU_SET	= 3,
 };
 
+#define NVME_TCP_OPT_NR_QUEUES(opts) ((opts)->nr_io_queues + \
+	(opts)->nr_write_queues + (opts)->nr_poll_queues + 1)
+
 enum nvme_tcp_recv_state {
 	NVME_TCP_RECV_PDU = 0,
 	NVME_TCP_RECV_DATA,
@@ -1549,14 +1552,21 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
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
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
@@ -1992,7 +2002,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	int ret, rcv_pdu_size;
 	struct file *sock_file;
 
-	mutex_init(&queue->queue_lock);
 	queue->ctrl = ctrl;
 	init_llist_head(&queue->req_list);
 	INIT_LIST_HEAD(&queue->send_list);
@@ -2136,7 +2145,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 #endif
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
-	mutex_destroy(&queue->queue_lock);
 	return ret;
 }
 
@@ -2823,6 +2831,9 @@ static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
 static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	/* the same count used to size and initialize the queue array */
+	unsigned int nr_queues = NVME_TCP_OPT_NR_QUEUES(nctrl->opts);
+	unsigned int i;
 
 	if (list_empty_careful(&ctrl->list))
 		goto free_ctrl;
@@ -2834,6 +2845,8 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 	nvmf_free_options(nctrl->opts);
 free_ctrl:
 	put_net(ctrl->net);
+	for (i = 0; i < nr_queues; i++)
+		mutex_destroy(&ctrl->queues[i].queue_lock);
 	kfree(ctrl->queues);
 	kfree(ctrl);
 }
@@ -3086,17 +3099,18 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 
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
@@ -3173,8 +3187,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	 */
 	context_unsafe(INIT_LIST_HEAD(&ctrl->list));
 	ctrl->ctrl.opts = opts;
-	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
-				opts->nr_poll_queues + 1;
+	ctrl->ctrl.queue_count = NVME_TCP_OPT_NR_QUEUES(opts);
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
@@ -3237,14 +3250,18 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	 * its requests already allocates the PDUs from the page frag caches of
 	 * the queues, sized by their header digest setting, so set up the
 	 * locks and hdr_digest here.
+	 *
+	 * The queue locks are owned by the controller, not the queues:
+	 * they outlive the per-queue connect/disconnect cycles so that
+	 * sysfs readers can never race their destruction.
 	 */
 	for (i = 0; i < ctrl->ctrl.queue_count; i++) {
 		mutex_init(&ctrl->queues[i].pf_cache_lock);
 		ctrl->queues[i].hdr_digest = opts->hdr_digest;
+		mutex_init(&ctrl->queues[i].queue_lock);
 	}
 
 	ctrl->net = get_net(current->nsproxy->net_ns);
-
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_tcp_ctrl_ops, 0);
 	if (ret)
 		goto out_kfree_queues;
-- 
2.53.0




