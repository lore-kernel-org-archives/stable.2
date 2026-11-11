Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434462;
	b=kMOzPJCZj1knCl+cWC3kw8obYxbugjxD33MQFGjOwzc9yGCKFvs9cm6/59MIHs3hm4kv
	 FPoKSOaZOHdptCmHUJzEkWfy88rn8DdvXuPFMkKxD9Fcu9IjctUW16Lo+YmQn7A1JiYW2
	 4DEN7cudGY2+uwTZeQpagx/c/hEO0pc2fUbzj20wZRxDFfOzEb4x0IMPFZhzc9M4d23M/
	 RzeWS9674pEBuCYMU7A871zmMz3efk5vgocaHmTBjqtJEc5CIbRJL8QDj+O518u8OVNgP
	 a37zOaQfla6xBMoOt963TijEnustQKPW4Wj/KKIwWCBWtlJQ5ODqf3edOy80+fzOiBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434462;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o/U2XzIH2frgX4PoxXbJbwP2hbVtAn7lwcyj4yvZlZI=;
	b=KG+Es4/+wYS7wjRSEH1OcIT0YfJffiJ2tL8n3cmke/TB7X4D6Iq0pGPtJtUpbLXboWvl
	 OUbbL0B4CGR3qTs7D4ZQ4aQQ/MnGjVTFby9E9LdtEBMCX04Kva0prbQnY39/YB/DG9ek/
	 pDG/npuJmo5LH+6wJdEzliSn6JpaAmvrdL2IZ05U1+i1oz0gznka3vGkhObE7ERshQciy
	 Ho+hyRauhJDN7HY/M0OZ/yimJxeV9YBVTzF1dcvE+TPia41ApJY+7qXvmnS1SD0cQtUdZ
	 m9RTycYFzLYts8RBy1+r4nIT7c72lXVIvMSrGzCQOLVR3jTutJ+mWsLOTIdH68Mf8lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h5EyEq2W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469D6606A8B4
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h5EyEq2W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9BA1F00A05;
	Wed, 11 Nov 2026 22:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434462;
	bh=o/U2XzIH2frgX4PoxXbJbwP2hbVtAn7lwcyj4yvZlZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h5EyEq2WAL2Ew4GKZAI0GItJZOlCRJm/MxYl7yaMQxHhPy+kIbG2mkk3mt35zQQqC
	 bqreGxJwV3FN1vrKAoQtdHM23iq/Bh0kMIzi3tx41gHkTq0zQlWbdbGIItXqsqHjJT
	 eHYemwoK+H8A8Lxgd1pL9L4nGEcGTLKL42Y1aK6jjjOH5g0EkXD8UCCr8Ot/xkv10W
	 E9rmZ7hPkRMor+e4ttux5MxBkXk01odTyUe6ryrokE+NpFY3U0Mne3g3B28P6AEcYJ
	 oZCt2DABMLR3/TAUXWbzfYKX/7b6nwthDL0HFFEXIWNO3ULnTH2YW+X5zJsJp1etn3
	 MBzlp5fpaT0eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Cen Zhang <zzzccc427@gmail.com>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Heming Zhao <heming.zhao@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] ocfs2/cluster: hold a reference on the heartbeat thread
Date: Wed, 11 Nov 2026 17:00:58 -0500
Message-ID: <20261111220052.4086173-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200149-failed-7.3-0a8f258c0f01@kernel.org>
References: <20261109200149-failed-7.3-0a8f258c0f01@kernel.org>
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

From: Karl Mehltretter <kmehltretter@gmail.com>

[ Upstream commit aa2e38aabaae87236290e486a2b77cfa3adfbebe ]

Since commit 688bc88e2046 ("ocfs2/cluster: keep heartbeat local node
stable"), o2hb_thread() leaves its loop and returns when the local node
changes, for example after "echo 0 > node/<name>/local".  The thread was
started with kthread_run() and nothing holds a reference to its
task_struct, so the task is freed once it exits, while reg->hr_task still
points to it.

Reading the region's pid attribute then reads the freed task, and removing
the region calls kthread_stop() on it:

  BUG: KASAN: slab-use-after-free in o2hb_region_pid_show+0xb3/0xc0
  refcount_t: addition on 0; use-after-free.
  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:kthread_stop+0xb1/0x390

The thread could already return by itself before, when heartbeat start was
aborted or on an unclean stop, but the local node change makes it
reachable from userspace at any time.

Create the thread, take a reference on it and only then wake it, so the
reference cannot race with the thread exiting.  Drop it with
kthread_stop_put().

Link: https://lore.kernel.org/20260923010149.14391-1-kmehltretter@gmail.com
Fixes: 688bc88e2046 ("ocfs2/cluster: keep heartbeat local node stable")
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260616074931.3774929-1-zzzccc427%40gmail.com
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Assisted-by: LLM
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Cen Zhang <zzzccc427@gmail.com>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Heming Zhao <heming.zhao@suse.com>
Stable-dep-of: 0a8f258c0f01 ("ocfs2/heartbeat: serialize concurrent writes to a region's dev attribute")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/cluster/heartbeat.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index dbc146717e8f3..b45adc39aacca 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1971,18 +1971,22 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	atomic_set(&reg->hr_unsteady_iterations, (live_threshold * 3));
 	o2hb_set_region_stopping(reg, false);
 
-	hb_task = kthread_run(o2hb_thread, reg, "o2hb-%s",
-			      reg->hr_item.ci_name);
+	hb_task = kthread_create(o2hb_thread, reg, "o2hb-%s",
+				 reg->hr_item.ci_name);
 	if (IS_ERR(hb_task)) {
 		ret = PTR_ERR(hb_task);
 		mlog_errno(ret);
 		goto out;
 	}
+	/* The thread may exit on its own, so pin it before it can run. */
+	get_task_struct(hb_task);
 
 	spin_lock(&o2hb_live_lock);
 	reg->hr_task = hb_task;
 	spin_unlock(&o2hb_live_lock);
 
+	wake_up_process(hb_task);
+
 	ret = wait_event_interruptible(o2hb_steady_queue,
 				atomic_read(&reg->hr_steady_iterations) == 0 ||
 				reg->hr_node_deleted);
@@ -2027,7 +2031,7 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 		spin_unlock(&o2hb_live_lock);
 
 		if (hb_task)
-			kthread_stop(hb_task);
+			kthread_stop_put(hb_task);
 
 		o2hb_unmap_slot_data(reg);
 
@@ -2221,7 +2225,7 @@ static void o2hb_heartbeat_group_drop_item(struct config_group *group,
 	spin_unlock(&o2hb_live_lock);
 
 	if (hb_task)
-		kthread_stop(hb_task);
+		kthread_stop_put(hb_task);
 
 	if (o2hb_global_heartbeat_active()) {
 		spin_lock(&o2hb_live_lock);
-- 
2.53.0

