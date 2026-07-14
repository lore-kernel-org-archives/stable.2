Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7CC48B39E
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040645; cv=none; b=ApZQtllMmGbyqaZrKXJVHNBN6/JKnxFb7DCgMYsyfz0knSxAb5Q0S3o0AxVIAAiBWLo0B3S+1mxjUCMnLWIyj19FN8BOd4BWrj/SYt1TL7uNqpNq9DJiehpOnJ9FeY71Fi5mlcK4tFBMG4vvf0UcfJuy+uRbaXLYv/w/zJvhr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040645; c=relaxed/simple;
	bh=iEume0c4XpegVLi8PuDhYZp3+EzOlfh5ugWF52XOMCg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q1XNX542FQPOgheeqzZqTC4aDlIa/RPbdyG5HsxsSpMLCvCvzoFNwdyzDBFOiNDDG0avz2UxLVAG2kJPv7Ub3Q9/IfbK9FRcDsTYVJliIdQH40ixdt0qQE3W5hkS3C4DJevoB4QqvWqu9qaHtiOEhDDmGuGqG+kz+N8TgcOh2xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JZjYzRBL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JZjYzRBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDE61F000E9;
	Tue, 14 Jul 2026 14:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040636;
	bh=4yh7LQZvCAxvVIk80+psNiDNNbvCL/U2VsxZJ18bDjQ=;
	h=Subject:To:Cc:From:Date;
	b=JZjYzRBL3pHAAjfBULX3/AIxieq/Mme5XckXNKaEY7xILpY7d5YRIXg/mE01mP4Ks
	 v9Fglf07BkTyk8gSGMP2ESxEiXLXgzPmrwXYc16JCmsOOpXffjPiFcUJvQPyklI3yO
	 gPq4u+IdK2Xld4f8gMcUK2qercPMYf0Sjq8lC/bw=
Subject: FAILED: patch "[PATCH] writeback: fix race between cgroup_writeback_umount() and" failed to apply to 5.15-stable tree
To: libaokun@linux.alibaba.com,brauner@kernel.org,jack@suse.cz,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:48:47 +0200
Message-ID: <2026071447-activism-denture-ed03@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x cba38ec4cbd3a7b8b942a8d52531a05be8a9ff0d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071447-activism-denture-ed03@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cba38ec4cbd3a7b8b942a8d52531a05be8a9ff0d Mon Sep 17 00:00:00 2001
From: Baokun Li <libaokun@linux.alibaba.com>
Date: Thu, 21 May 2026 17:50:14 +0800
Subject: [PATCH] writeback: fix race between cgroup_writeback_umount() and
 inode_switch_wbs()

When a container exits, the following BUG_ON() is occasionally triggered:

==================================================================
 VFS: Busy inodes after unmount of sdb (ext4)
 ------------[ cut here ]------------
 kernel BUG at fs/super.c:695!
 CPU: 3 PID: 6 Comm: containerd-shim Tainted: G OE K 6.6 #1
 pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
 pc : generic_shutdown_super+0xf0/0x100
 lr : generic_shutdown_super+0xf0/0x100
 Call trace:
  generic_shutdown_super+0xf0/0x100
  kill_block_super+0x20/0x48
  ext4_kill_sb+0x28/0x60
  deactivate_locked_super+0x54/0x130
  deactivate_super+0x84/0xa0
  cleanup_mnt+0xa4/0x140
  __cleanup_mnt+0x18/0x28
  task_work_run+0x78/0xe0
  do_notify_resume+0x204/0x240
==================================================================

The root cause is a race between cgroup_writeback_umount() and
inode_switch_wbs()/cleanup_offline_cgwb(). There is a window between
inode_prepare_wbs_switch() returning true and the subsequent
wb_queue_isw() call. Following is the process that triggers the issue:

      CPU A (umount)           |          CPU B (writeback)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                 inode_switch_wbs/cleanup_offline_cgwb
                                  atomic_inc(&isw_nr_in_flight)
                                  inode_prepare_wbs_switch
                                   -> passes SB_ACTIVE check
                                   __iget(inode)
 generic_shutdown_super
  sb->s_flags &= ~SB_ACTIVE
  cgroup_writeback_umount(sb)
   smp_mb()
   atomic_read(&isw_nr_in_flight)
   rcu_barrier()
    -> no pending RCU callbacks
   flush_workqueue(isw_wq)
    -> nothing queued, returns
  evict_inodes(sb)
   -> Inode skipped as isw still holds a ref.
  sop->put_super(sb)
   /* destroys percpu counters */
  -> VFS: Busy inodes after unmount!
                                  wb_queue_isw()
                                   queue_work(isw_wq, ...)
                                  /* later in work function */
                                  inode_switch_wbs_work_fn
                                   process_inode_switch_wbs
                                    iput() -> evict
                                     percpu_counter_dec() // UAF!

Fix this by extending the RCU read-side critical section in
inode_switch_wbs() and cleanup_offline_cgwb() to cover from
inode_prepare_wbs_switch() through wb_queue_isw().  Since there is
no sleep in this window, rcu_read_lock() can be used.  Then add a
synchronize_rcu() in cgroup_writeback_umount() before the existing
rcu_barrier(), so that all in-flight switchers that have passed the
SB_ACTIVE check have completed queue_work() before flush_workqueue()
is called.

The existing rcu_barrier() is intentionally retained so this fix can
be backported unchanged to stable kernels (5.10.y, 6.6.y, ...) that
still queue switches via queue_rcu_work(). It is a no-op on current
mainline (since commit e1b849cfa6b6 ("writeback: Avoid contention on
wb->list_lock when switching inodes")) and is removed in a follow-up
patch.

Fixes: a1a0e23e4903 ("writeback: flush inode cgroup wb switches instead of pinning super_block")
Cc: stable@vger.kernel.org
Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/all/mxnjq2l6guusfchvauxr3v7c4bwjasybxlleqbbh4efloeqspz@iqylk76ohufz
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
Link: https://patch.msgid.link/20260521095016.2791354-2-libaokun@linux.alibaba.com
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a65694cbfe68..6766de9f9d75 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -660,12 +660,19 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 
 	atomic_inc(&isw_nr_in_flight);
 
-	/* find and pin the new wb */
+	/*
+	 * Paired with synchronize_rcu() in cgroup_writeback_umount():
+	 * holding rcu_read_lock across inode_prepare_wbs_switch()
+	 * (covering the SB_ACTIVE check and the inode grab) and
+	 * wb_queue_isw() ensures synchronize_rcu() cannot return until
+	 * the work is queued, so the subsequent flush_workqueue() will
+	 * wait for the switch.
+	 */
 	rcu_read_lock();
+	/* find and pin the new wb */
 	memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
 	if (memcg_css && !css_tryget(memcg_css))
 		memcg_css = NULL;
-	rcu_read_unlock();
 	if (!memcg_css)
 		goto out_free;
 
@@ -681,9 +688,11 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 
 	trace_inode_switch_wbs_queue(inode->i_wb, new_wb, 1);
 	wb_queue_isw(new_wb, isw);
+	rcu_read_unlock();
 	return;
 
 out_free:
+	rcu_read_unlock();
 	atomic_dec(&isw_nr_in_flight);
 	if (new_wb)
 		wb_put(new_wb);
@@ -741,6 +750,14 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 		new_wb = &wb->bdi->wb; /* wb_get() is noop for bdi's wb */
 
 	nr = 0;
+	/*
+	 * Paired with synchronize_rcu() in cgroup_writeback_umount().
+	 * Holding rcu_read_lock across the SB_ACTIVE check, the inode grab
+	 * and wb_queue_isw() ensures synchronize_rcu() cannot return until
+	 * the work is queued, so the subsequent flush_workqueue() will wait
+	 * for the switch.
+	 */
+	rcu_read_lock();
 	spin_lock(&wb->list_lock);
 	/*
 	 * In addition to the inodes that have completed writeback, also switch
@@ -758,6 +775,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 
 	/* no attached inodes? bail out */
 	if (nr == 0) {
+		rcu_read_unlock();
 		atomic_dec(&isw_nr_in_flight);
 		wb_put(new_wb);
 		kfree(isw);
@@ -766,6 +784,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 
 	trace_inode_switch_wbs_queue(wb, new_wb, nr);
 	wb_queue_isw(new_wb, isw);
+	rcu_read_unlock();
 
 	return restart;
 }
@@ -1221,6 +1240,14 @@ void cgroup_writeback_umount(struct super_block *sb)
 	smp_mb();
 
 	if (atomic_read(&isw_nr_in_flight)) {
+		/*
+		 * Paired with rcu_read_lock() in inode_switch_wbs() and
+		 * cleanup_offline_cgwb().  synchronize_rcu() waits for any
+		 * in-flight switcher that already passed the SB_ACTIVE check
+		 * to finish queueing its work, so flush_workqueue() below
+		 * will then drain it.
+		 */
+		synchronize_rcu();
 		/*
 		 * Use rcu_barrier() to wait for all pending callbacks to
 		 * ensure that all in-flight wb switches are in the workqueue.

