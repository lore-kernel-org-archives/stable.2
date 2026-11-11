Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434768;
	b=XM2rkwdVp5KhrMjvLz2/Sv1S0UMQ3Mkw/HjAdyPXDQ0I3158LlEDUbUaDTh6mSxZyA+0
	 YcQPL313Fh5MHovoi4F5hZIvjbFsfw3AhCwu7qEkCI3Kmf3M6EUT2ETL/eXYOEM9cvOAa
	 /trJDmgpxe0taVpdj6xT1qrE1YV9ggyaTm+wK/8C2+TPMqWCYxkOiBisA5EbEGwm95go+
	 uxH0wC5lZmcsbJJEZtGtVs2DIKbhi0DBSsWoset81rPNvws4aA1upFK4kMP6sjA+quOMY
	 B7WbPNkF2LEZWiNl/XLlbXQdC/wbn+qPHB1M1rElPgg/earPE7DtpKaxFyXzzavG90g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434768;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JzyXsKyDCuIqSBKdhM8Y80ABNNvmoxJH17reL4QY2P8=;
	b=b5e1Wh/0IDuxKb45B6ACtwUeDpeSVLwM7D518AurGsI1KB/ICsXViDr/N2BTXW1Sd8uq
	 9ZH7rFQPBXrGrEtlwZXqJsuKbVlHfPKj0rmytqeSzQtr560RvSR8VyWLPInAXnhCyr1At
	 FmRb4VmxNgRPebIkvOvgY9g1xrltVYHxpIPXK9h+IQzTq185SvOP5JAFtkRKn6K3bUjv3
	 hVh9DKpIqpP9wknrX5uG85grB2ZM81gAsGsPuv3BCoscaCP78rlFLB9IxlyNESlo1kiZX
	 2LQEOQzmhB680cMK19Sz1E0rO0SJ6mS1m4UdluB5ePReRX8QjbDunmWMOkQ6tQScV8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vhbznr4U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965B2606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vhbznr4U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF611F00A05;
	Wed, 11 Nov 2026 22:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434768;
	bh=JzyXsKyDCuIqSBKdhM8Y80ABNNvmoxJH17reL4QY2P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vhbznr4U/8xilmPjJIB+OnQQs+QlfgTzOmUtwJVP7OXrJy/hIJLFAYNcJ+Izz4Ccr
	 B6vPXzCcFuB5L5JEZr7v43jlTsQJedwYtDbdMhk93r4/PI7Hc/S+Kit3P5Jtqwd7xR
	 PyNqvG+8tuHHCq5V35hPEGpAONHQMFWwQwFqbVsXChIeXHCBNCs0edqCHxoZJuRt4M
	 fzPVA4Ik4ib6S1VGDeAui3BoJipjEPgFdTyjQlVrdqS4tFQWtJMBFLSdNfjE/pyWIK
	 N7U5nV3U839RqUzyYwEnpOcSS67km3eFy0PUIpikyLt6sU7O7phpxM5R0VXKv8gd81
	 E2j65VlICCDaA==
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
Subject: [PATCH 6.18.y 1/2] ocfs2/cluster: hold a reference on the heartbeat thread
Date: Wed, 11 Nov 2026 17:06:04 -0500
Message-ID: <20261111220555.4106820-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200430-failed-6.18-0a8f258c0f01@kernel.org>
References: <20261109200430-failed-6.18-0a8f258c0f01@kernel.org>
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
index 0888c44f677c1..ec7e87c065742 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1958,18 +1958,22 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
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
@@ -2014,7 +2018,7 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 		spin_unlock(&o2hb_live_lock);
 
 		if (hb_task)
-			kthread_stop(hb_task);
+			kthread_stop_put(hb_task);
 
 		o2hb_unmap_slot_data(reg);
 
@@ -2208,7 +2212,7 @@ static void o2hb_heartbeat_group_drop_item(struct config_group *group,
 	spin_unlock(&o2hb_live_lock);
 
 	if (hb_task)
-		kthread_stop(hb_task);
+		kthread_stop_put(hb_task);
 
 	if (o2hb_global_heartbeat_active()) {
 		spin_lock(&o2hb_live_lock);
-- 
2.53.0

