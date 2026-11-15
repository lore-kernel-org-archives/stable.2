Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794752355;
	b=v++Bgg206XYpF9OWZYXQAHx8EAv2cP8Xi5dq0hoQSJH2S2lQf4829D8fo4gQYI0RATko
	 fE8jkJA1/IGHKG2J3GoYbZpRqqh/28lY25bnzc3I6zs8IDCxtfsAFYhO06w32TLlkk3cX
	 zgo9/YEGfzbAzYzXIUV+BRMPk15ZzHyfBoQEgrKn89DLnnu2DkTou4JO4CQ5otS+IEGAe
	 psvi/J+SRBV3+SHPcJFwVQSn7Rh75h7PkV5I2X633D5qnXpABHvNRWLjFM9ZLvnkM1Frb
	 4cJzve2ga+uzlOYBboUzepwnzmVX5gqHR9xIETSGf5NgW6ILcpEzrsgc4vIm6A0OtRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794752355;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ses74jK4GsCDRfShBB/OtSx+ky0xXKlfEabWFfq7Ifg=;
	b=nP/AFn5BwO16rfmEC6GdhrmRVnaFIrrdN23bCuK8DW86tDjQcRJFhP7jXYS+jElWU/2a
	 rHuORkbIFYG+ZdBVC7bIPCG53m3K2c0Ho2ODSwsPNm2lqB+wVZP9Y6o0DSuDBXRJt6gry
	 8kQGvYf6/0FQBaML6JDsHsynm6x6lG58dEZbsLRpQoqCuI5E9motwLX9pNbrZF6fb00+U
	 /4E4e9jNNINS5mbPNWrTSjXmSQbw/i0R2nBS9jutVmr1Zk1nBC+Ye3+BGT5PPgqQTn9Rw
	 auchAGbF8tdaJpaRNsURKnS7BUDA7krizK7ViOmoyou0hXM3bD1tlZnbOdk+l61Kd5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=do2UMopR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F39606A31D
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=do2UMopR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0633E1F000C4;
	Sun, 15 Nov 2026 14:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794752355;
	bh=Ses74jK4GsCDRfShBB/OtSx+ky0xXKlfEabWFfq7Ifg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=do2UMopRRuF0SyXIy4cQCpmkISQdjtV65rAZTAEl7bk2HTe1tCOSBlkYYkBswHgDf
	 hV8ibVDnrjGQojCc1kvW5Nc8lw+FBTZ6dLrh5TbyX4+TmIhbN7CSIyNerMOTDsM5vT
	 Jh4yz0DGbhYeMXMe1UYrumxkk1/OD00KwfsWAsNxvRCGnf2DN7XpEN5vbFt577eBoX
	 fZB0ZO+/EX70RVGWrv4sEt+B/4XT77XkCoPwvTh5H7N+VP61q/sFZbGVtCLuiQ9LXm
	 Mnxz5OwsEFPpNxWBiYjkmnXlvZqR8z9nOWyOtVOMpiSOdmf4BWl/hDSddNZK6VYYOV
	 JLvgMZXwQa8AA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] ocfs2: miscellaneous spelling fixes
Date: Sun, 15 Nov 2026 09:19:10 -0500
Message-ID: <20261115013217.675970-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202229-failed-5.15-84db6619cb70@kernel.org>
References: <20261109202229-failed-5.15-84db6619cb70@kernel.org>
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

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit a0f8a9a9636e19a11ab80db4a45fb80a230c6c5a ]

Correct spelling here and there as suggested by codespell.

Link: https://lkml.kernel.org/r/20241115151013.1404929-1-dmantipov@yandex.ru
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 84db6619cb70 ("ocfs2: validate move extents against a stable EOF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/alloc.c             | 10 +++++-----
 fs/ocfs2/aops.c              |  2 +-
 fs/ocfs2/cluster/heartbeat.c |  2 +-
 fs/ocfs2/cluster/masklog.h   |  2 +-
 fs/ocfs2/cluster/quorum.c    |  6 +++---
 fs/ocfs2/cluster/tcp.c       |  8 ++++----
 fs/ocfs2/dlm/dlmapi.h        |  2 +-
 fs/ocfs2/dlm/dlmrecovery.c   |  6 +++---
 fs/ocfs2/dlmglue.c           | 12 ++++++------
 fs/ocfs2/inode.c             |  4 ++--
 fs/ocfs2/ioctl.c             |  2 +-
 fs/ocfs2/journal.c           |  2 +-
 fs/ocfs2/move_extents.c      |  8 ++++----
 fs/ocfs2/ocfs2_fs.h          |  8 ++++----
 fs/ocfs2/ocfs2_ioctl.h       |  2 +-
 fs/ocfs2/ocfs2_lockid.h      |  2 +-
 fs/ocfs2/refcounttree.c      |  6 +++---
 fs/ocfs2/reservations.h      |  4 ++--
 fs/ocfs2/stack_o2cb.c        |  2 +-
 fs/ocfs2/stackglue.h         |  2 +-
 fs/ocfs2/super.c             |  2 +-
 fs/ocfs2/xattr.c             | 10 +++++-----
 22 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index c0eb53734d85c..e6b4a873b5f7c 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -566,7 +566,7 @@ static void ocfs2_adjust_rightmost_records(handle_t *handle,
 					   struct ocfs2_path *path,
 					   struct ocfs2_extent_rec *insert_rec);
 /*
- * Reset the actual path elements so that we can re-use the structure
+ * Reset the actual path elements so that we can reuse the structure
  * to build another path. Generally, this involves freeing the buffer
  * heads.
  */
@@ -1175,7 +1175,7 @@ static int ocfs2_add_branch(handle_t *handle,
 
 	/*
 	 * If there is a gap before the root end and the real end
-	 * of the righmost leaf block, we need to remove the gap
+	 * of the rightmost leaf block, we need to remove the gap
 	 * between new_cpos and root_end first so that the tree
 	 * is consistent after we add a new branch(it will start
 	 * from new_cpos).
@@ -1231,7 +1231,7 @@ static int ocfs2_add_branch(handle_t *handle,
 
 	/* Note: new_eb_bhs[new_blocks - 1] is the guy which will be
 	 * linked with the rest of the tree.
-	 * conversly, new_eb_bhs[0] is the new bottommost leaf.
+	 * conversely, new_eb_bhs[0] is the new bottommost leaf.
 	 *
 	 * when we leave the loop, new_last_eb_blk will point to the
 	 * newest leaf, and next_blkno will point to the topmost extent
@@ -3716,7 +3716,7 @@ static int ocfs2_try_to_merge_extent(handle_t *handle,
 		 * update split_index here.
 		 *
 		 * When the split_index is zero, we need to merge it to the
-		 * prevoius extent block. It is more efficient and easier
+		 * previous extent block. It is more efficient and easier
 		 * if we do merge_right first and merge_left later.
 		 */
 		ret = ocfs2_merge_rec_right(path, handle, et, split_rec,
@@ -4521,7 +4521,7 @@ static void ocfs2_figure_contig_type(struct ocfs2_extent_tree *et,
 }
 
 /*
- * This should only be called against the righmost leaf extent list.
+ * This should only be called against the rightmost leaf extent list.
  *
  * ocfs2_figure_appending_type() will figure out whether we'll have to
  * insert at the tail of the rightmost leaf.
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index ac2d47c3632f2..45ad1ece89d73 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -308,7 +308,7 @@ static int ocfs2_readpage(struct file *file, struct page *page)
 	}
 
 	/*
-	 * i_size might have just been updated as we grabed the meta lock.  We
+	 * i_size might have just been updated as we grabbed the meta lock.  We
 	 * might now be discovering a truncate that hit on another node.
 	 * block_read_full_page->get_block freaks out if it is asked to read
 	 * beyond the end of a file, so we check here.  Callers
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 33e2728c28a4e..f12efc636dc8c 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1030,7 +1030,7 @@ static int o2hb_check_slot(struct o2hb_region *reg,
 	if (list_empty(&slot->ds_live_item))
 		goto out;
 
-	/* live nodes only go dead after enough consequtive missed
+	/* live nodes only go dead after enough consecutive missed
 	 * samples..  reset the missed counter whenever we see
 	 * activity */
 	if (slot->ds_equal_samples >= o2hb_dead_threshold || gen_changed) {
diff --git a/fs/ocfs2/cluster/masklog.h b/fs/ocfs2/cluster/masklog.h
index b73fc42e46ff7..630bd5a3dd0d2 100644
--- a/fs/ocfs2/cluster/masklog.h
+++ b/fs/ocfs2/cluster/masklog.h
@@ -29,7 +29,7 @@
  * just calling printk() so that this can eventually make its way through
  * relayfs along with the debugging messages.  Everything else gets KERN_DEBUG.
  * The inline tests and macro dance give GCC the opportunity to quite cleverly
- * only emit the appropriage printk() when the caller passes in a constant
+ * only emit the appropriate printk() when the caller passes in a constant
  * mask, as is almost always the case.
  *
  * All this bitmask nonsense is managed from the files under
diff --git a/fs/ocfs2/cluster/quorum.c b/fs/ocfs2/cluster/quorum.c
index 46fe5f80e358c..5b6e511bce3d5 100644
--- a/fs/ocfs2/cluster/quorum.c
+++ b/fs/ocfs2/cluster/quorum.c
@@ -23,7 +23,7 @@
  * race between when we see a node start heartbeating and when we connect
  * to it.
  *
- * So nodes that are in this transtion put a hold on the quorum decision
+ * So nodes that are in this transition put a hold on the quorum decision
  * with a counter.  As they fall out of this transition they drop the count
  * and if they're the last, they fire off the decision.
  */
@@ -189,7 +189,7 @@ static void o2quo_clear_hold(struct o2quo_state *qs, u8 node)
 }
 
 /* as a node comes up we delay the quorum decision until we know the fate of
- * the connection.  the hold will be droped in conn_up or hb_down.  it might be
+ * the connection.  the hold will be dropped in conn_up or hb_down.  it might be
  * perpetuated by con_err until hb_down.  if we already have a conn, we might
  * be dropping a hold that conn_up got. */
 void o2quo_hb_up(u8 node)
@@ -256,7 +256,7 @@ void o2quo_hb_still_up(u8 node)
 }
 
 /* This is analogous to hb_up.  as a node's connection comes up we delay the
- * quorum decision until we see it heartbeating.  the hold will be droped in
+ * quorum decision until we see it heartbeating.  the hold will be dropped in
  * hb_up or hb_down.  it might be perpetuated by con_err until hb_down.  if
  * it's already heartbeating we might be dropping a hold that conn_up got.
  * */
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index edc2976aa3c56..d3ab195bf8c5a 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -5,13 +5,13 @@
  *
  * ----
  *
- * Callers for this were originally written against a very simple synchronus
+ * Callers for this were originally written against a very simple synchronous
  * API.  This implementation reflects those simple callers.  Some day I'm sure
  * we'll need to move to a more robust posting/callback mechanism.
  *
  * Transmit calls pass in kernel virtual addresses and block copying this into
  * the socket's tx buffers via a usual blocking sendmsg.  They'll block waiting
- * for a failed socket to timeout.  TX callers can also pass in a poniter to an
+ * for a failed socket to timeout.  TX callers can also pass in a pointer to an
  * 'int' which gets filled with an errno off the wire in response to the
  * message they send.
  *
@@ -100,7 +100,7 @@ static struct socket *o2net_listen_sock;
  * o2net_wq.  teardown detaches the callbacks before destroying the workqueue.
  * quorum work is queued as sock containers are shutdown.. stop_listening
  * tears down all the node's sock containers, preventing future shutdowns
- * and queued quroum work, before canceling delayed quorum work and
+ * and queued quorum work, before canceling delayed quorum work and
  * destroying the work queue.
  */
 static struct workqueue_struct *o2net_wq;
@@ -1416,7 +1416,7 @@ static int o2net_advance_rx(struct o2net_sock_container *sc)
 	return ret;
 }
 
-/* this work func is triggerd by data ready.  it reads until it can read no
+/* this work func is triggered by data ready.  it reads until it can read no
  * more.  it interprets 0, eof, as fatal.  if data_ready hits while we're doing
  * our work the work struct will be marked and we'll be called again. */
 static void o2net_rx_until_empty(struct work_struct *work)
diff --git a/fs/ocfs2/dlm/dlmapi.h b/fs/ocfs2/dlm/dlmapi.h
index bae60ca2672a8..af60bf6598ce7 100644
--- a/fs/ocfs2/dlm/dlmapi.h
+++ b/fs/ocfs2/dlm/dlmapi.h
@@ -120,7 +120,7 @@ struct dlm_lockstatus {
 #define LKM_VALBLK       0x00000100  /* lock value block request */
 #define LKM_NOQUEUE      0x00000200  /* non blocking request */
 #define LKM_CONVERT      0x00000400  /* conversion request */
-#define LKM_NODLCKWT     0x00000800  /* this lock wont deadlock (U) */
+#define LKM_NODLCKWT     0x00000800  /* this lock won't deadlock (U) */
 #define LKM_UNLOCK       0x00001000  /* deallocate this lock */
 #define LKM_CANCEL       0x00002000  /* cancel conversion request */
 #define LKM_DEQALL       0x00004000  /* remove all locks held by proc (U) */
diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index 20efba123a58e..2598724bd5eca 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -207,7 +207,7 @@ void dlm_complete_recovery_thread(struct dlm_ctxt *dlm)
  * 1) all recovery threads cluster wide will work on recovering
  *    ONE node at a time
  * 2) negotiate who will take over all the locks for the dead node.
- *    thats right... ALL the locks.
+ *    that's right... ALL the locks.
  * 3) once a new master is chosen, everyone scans all locks
  *    and moves aside those mastered by the dead guy
  * 4) each of these locks should be locked until recovery is done
@@ -1478,7 +1478,7 @@ int dlm_mig_lockres_handler(struct o2net_msg *msg, u32 len, void *data,
 		 * The first one is handled at the end of this function. The
 		 * other two are handled in the worker thread after locks have
 		 * been attached. Yes, we don't wait for purge time to match
-		 * kref_init. The lockres will still have atleast one ref
+		 * kref_init. The lockres will still have at least one ref
 		 * added because it is in the hash __dlm_insert_lockres() */
 		extra_refs++;
 
@@ -1744,7 +1744,7 @@ int dlm_master_requery_handler(struct o2net_msg *msg, u32 len, void *data,
 				spin_unlock(&res->spinlock);
 			}
 		} else {
-			/* put.. incase we are not the master */
+			/* put.. in case we are not the master */
 			spin_unlock(&res->spinlock);
 			dlm_lockres_put(res);
 		}
diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index c8cda79945317..6a23998325349 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -787,7 +787,7 @@ void ocfs2_lock_res_free(struct ocfs2_lock_res *res)
 
 /*
  * Keep a list of processes who have interest in a lockres.
- * Note: this is now only uesed for check recursive cluster locking.
+ * Note: this is now only used for check recursive cluster locking.
  */
 static inline void ocfs2_add_holder(struct ocfs2_lock_res *lockres,
 				   struct ocfs2_lock_holder *oh)
@@ -2523,7 +2523,7 @@ int ocfs2_inode_lock_full_nested(struct inode *inode,
  * locks while holding a page lock and the downconvert thread which
  * blocks dlm lock acquiry while acquiring page locks.
  *
- * ** These _with_page variantes are only intended to be called from aop
+ * ** These _with_page variants are only intended to be called from aop
  * methods that hold page locks and return a very specific *positive* error
  * code that aop methods pass up to the VFS -- test for errors with != 0. **
  *
@@ -2621,7 +2621,7 @@ void ocfs2_inode_unlock(struct inode *inode,
 }
 
 /*
- * This _tracker variantes are introduced to deal with the recursive cluster
+ * This _tracker variants are introduced to deal with the recursive cluster
  * locking issue. The idea is to keep track of a lock holder on the stack of
  * the current process. If there's a lock holder on the stack, we know the
  * task context is already protected by cluster locking. Currently, they're
@@ -2726,7 +2726,7 @@ void ocfs2_inode_unlock_tracker(struct inode *inode,
 	struct ocfs2_lock_res *lockres;
 
 	lockres = &OCFS2_I(inode)->ip_inode_lockres;
-	/* had_lock means that the currect process already takes the cluster
+	/* had_lock means that the current process already takes the cluster
 	 * lock previously.
 	 * If had_lock is 1, we have nothing to do here.
 	 * If had_lock is 0, we will release the lock.
@@ -3826,9 +3826,9 @@ static int ocfs2_unblock_lock(struct ocfs2_super *osb,
 	 * set when the ast is received for an upconvert just before the
 	 * OCFS2_LOCK_BUSY flag is cleared. Now if the fs received a bast
 	 * on the heels of the ast, we want to delay the downconvert just
-	 * enough to allow the up requestor to do its task. Because this
+	 * enough to allow the up requester to do its task. Because this
 	 * lock is in the blocked queue, the lock will be downconverted
-	 * as soon as the requestor is done with the lock.
+	 * as soon as the requester is done with the lock.
 	 */
 	if (lockres->l_flags & OCFS2_LOCK_UPCONVERT_FINISHING)
 		goto leave_requeue;
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index ce1469f969154..14fd9e6e14b0a 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1155,7 +1155,7 @@ static void ocfs2_clear_inode(struct inode *inode)
 
 	dquot_drop(inode);
 
-	/* To preven remote deletes we hold open lock before, now it
+	/* To prevent remote deletes we hold open lock before, now it
 	 * is time to unlock PR and EX open locks. */
 	ocfs2_open_unlock(inode);
 
@@ -1581,7 +1581,7 @@ static int ocfs2_filecheck_validate_inode_block(struct super_block *sb,
 	 * Call ocfs2_validate_meta_ecc() first since it has ecc repair
 	 * function, but we should not return error immediately when ecc
 	 * validation fails, because the reason is quite likely the invalid
-	 * inode number inputed.
+	 * inode number inputted.
 	 */
 	rc = ocfs2_validate_meta_ecc(sb, bh->b_data, &di->i_check);
 	if (rc) {
diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
index f9c66b172d304..39eb652178a14 100644
--- a/fs/ocfs2/ioctl.c
+++ b/fs/ocfs2/ioctl.c
@@ -811,7 +811,7 @@ static int ocfs2_get_request_ptr(struct ocfs2_info *info, int idx,
 /*
  * OCFS2_IOC_INFO handles an array of requests passed from userspace.
  *
- * ocfs2_info_handle() recevies a large info aggregation, grab and
+ * ocfs2_info_handle() receives a large info aggregation, grab and
  * validate the request count from header, then break it into small
  * pieces, later specific handlers can handle them one by one.
  *
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 4a6363037ebc9..f40e17bdcaa24 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -1946,7 +1946,7 @@ int ocfs2_mark_dead_nodes(struct ocfs2_super *osb)
 
 /*
  * Scan timer should get fired every ORPHAN_SCAN_SCHEDULE_TIMEOUT. Add some
- * randomness to the timeout to minimize multple nodes firing the timer at the
+ * randomness to the timeout to minimize multiple nodes firing the timer at the
  * same time.
  */
 static inline unsigned long ocfs2_orphan_scan_timeout(void)
diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index 32b4271f3deb6..3280e0d60f09e 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -498,7 +498,7 @@ static int ocfs2_validate_and_adjust_move_goal(struct inode *inode,
 	bg = (struct ocfs2_group_desc *)gd_bh->b_data;
 
 	/*
-	 * moving goal is not allowd to start with a group desc blok(#0 blk)
+	 * moving goal is not allowed to start with a group desc blok(#0 blk)
 	 * let's compromise to the latter cluster.
 	 */
 	if (range->me_goal == le64_to_cpu(bg->bg_blkno))
@@ -666,7 +666,7 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
 
 	/*
 	 * probe the victim cluster group to find a proper
-	 * region to fit wanted movement, it even will perfrom
+	 * region to fit wanted movement, it even will perform
 	 * a best-effort attempt by compromising to a threshold
 	 * around the goal.
 	 */
@@ -933,7 +933,7 @@ static int ocfs2_move_extents(struct ocfs2_move_extents_context *context)
 	}
 
 	/*
-	 * rememer ip_xattr_sem also needs to be held if necessary
+	 * remember ip_xattr_sem also needs to be held if necessary
 	 */
 	down_write(&OCFS2_I(inode)->ip_alloc_sem);
 
@@ -1035,7 +1035,7 @@ int ocfs2_ioctl_move_extents(struct file *filp, void __user *argp)
 	context->range = &range;
 
 	/*
-	 * ok, the default theshold for the defragmentation
+	 * ok, the default threshold for the defragmentation
 	 * is 1M, since our maximum clustersize was 1M also.
 	 * any thought?
 	 */
diff --git a/fs/ocfs2/ocfs2_fs.h b/fs/ocfs2/ocfs2_fs.h
index 638d875eccc7d..336a378641062 100644
--- a/fs/ocfs2/ocfs2_fs.h
+++ b/fs/ocfs2/ocfs2_fs.h
@@ -132,7 +132,7 @@
  * well as the name of the cluster being joined.
  * mount.ocfs2 must pass in a matching stack name.
  *
- * If not set, the classic stack will be used.  This is compatbile with
+ * If not set, the classic stack will be used.  This is compatible with
  * all older versions.
  */
 #define OCFS2_FEATURE_INCOMPAT_USERSPACE_STACK	0x0080
@@ -143,7 +143,7 @@
 /* Support for extended attributes */
 #define OCFS2_FEATURE_INCOMPAT_XATTR		0x0200
 
-/* Support for indexed directores */
+/* Support for indexed directories */
 #define OCFS2_FEATURE_INCOMPAT_INDEXED_DIRS	0x0400
 
 /* Metadata checksum and error correction */
@@ -156,7 +156,7 @@
 #define OCFS2_FEATURE_INCOMPAT_DISCONTIG_BG	0x2000
 
 /*
- * Incompat bit to indicate useable clusterinfo with stackflags for all
+ * Incompat bit to indicate usable clusterinfo with stackflags for all
  * cluster stacks (userspace adnd o2cb). If this bit is set,
  * INCOMPAT_USERSPACE_STACK becomes superfluous and thus should not be set.
  */
@@ -1082,7 +1082,7 @@ struct ocfs2_xattr_block {
 		struct ocfs2_xattr_header xb_header; /* xattr header if this
 							block contains xattr */
 		struct ocfs2_xattr_tree_root xb_root;/* xattr tree root if this
-							block cotains xattr
+							block contains xattr
 							tree. */
 	} xb_attrs;
 };
diff --git a/fs/ocfs2/ocfs2_ioctl.h b/fs/ocfs2/ocfs2_ioctl.h
index 9680797bc5318..2de2f8733283e 100644
--- a/fs/ocfs2/ocfs2_ioctl.h
+++ b/fs/ocfs2/ocfs2_ioctl.h
@@ -215,7 +215,7 @@ struct ocfs2_move_extents {
 							   movement less likely
 							   to fail, may make fs
 							   even more fragmented */
-#define OCFS2_MOVE_EXT_FL_COMPLETE	(0x00000004)	/* Move or defragmenation
+#define OCFS2_MOVE_EXT_FL_COMPLETE	(0x00000004)	/* Move or defragmentation
 							   completely gets done.
 							 */
 
diff --git a/fs/ocfs2/ocfs2_lockid.h b/fs/ocfs2/ocfs2_lockid.h
index 8ac357ce6a30a..9b234c03d6932 100644
--- a/fs/ocfs2/ocfs2_lockid.h
+++ b/fs/ocfs2/ocfs2_lockid.h
@@ -93,7 +93,7 @@ static char *ocfs2_lock_type_strings[] = {
 	[OCFS2_LOCK_TYPE_DATA] = "Data",
 	[OCFS2_LOCK_TYPE_SUPER] = "Super",
 	[OCFS2_LOCK_TYPE_RENAME] = "Rename",
-	/* Need to differntiate from [R]ename.. serializing writes is the
+	/* Need to differentiate from [R]ename.. serializing writes is the
 	 * important job it does, anyway. */
 	[OCFS2_LOCK_TYPE_RW] = "Write/Read",
 	[OCFS2_LOCK_TYPE_DENTRY] = "Dentry",
diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index bd5b08c51ede5..a0beb89a758b8 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -2457,7 +2457,7 @@ static int ocfs2_calc_refcount_meta_credits(struct super_block *sb,
 		 *
 		 * If we will insert a new one, this is easy and only happens
 		 * during adding refcounted flag to the extent, so we don't
-		 * have a chance of spliting. We just need one record.
+		 * have a chance of splitting. We just need one record.
 		 *
 		 * If the refcount rec already exists, that would be a little
 		 * complicated. we may have to:
@@ -2647,11 +2647,11 @@ static inline unsigned int ocfs2_cow_align_length(struct super_block *sb,
 /*
  * Calculate out the start and number of virtual clusters we need to to CoW.
  *
- * cpos is vitual start cluster position we want to do CoW in a
+ * cpos is virtual start cluster position we want to do CoW in a
  * file and write_len is the cluster length.
  * max_cpos is the place where we want to stop CoW intentionally.
  *
- * Normal we will start CoW from the beginning of extent record cotaining cpos.
+ * Normal we will start CoW from the beginning of extent record containing cpos.
  * We try to break up extents on boundaries of MAX_CONTIG_BYTES so that we
  * get good I/O from the resulting extent tree.
  */
diff --git a/fs/ocfs2/reservations.h b/fs/ocfs2/reservations.h
index 677c50663595e..03262d0e140c2 100644
--- a/fs/ocfs2/reservations.h
+++ b/fs/ocfs2/reservations.h
@@ -31,7 +31,7 @@ struct ocfs2_alloc_reservation {
 
 #define	OCFS2_RESV_FLAG_INUSE	0x01	/* Set when r_node is part of a btree */
 #define	OCFS2_RESV_FLAG_TMP	0x02	/* Temporary reservation, will be
-					 * destroyed immedately after use */
+					 * destroyed immediately after use */
 #define	OCFS2_RESV_FLAG_DIR	0x04	/* Reservation is for an unindexed
 					 * directory btree */
 
@@ -130,7 +130,7 @@ int ocfs2_resmap_resv_bits(struct ocfs2_reservation_map *resmap,
 /**
  * ocfs2_resmap_claimed_bits() - Tell the reservation code that bits were used.
  * @resmap: reservations bitmap
- * @resv: optional reservation to recalulate based on new bitmap
+ * @resv: optional reservation to recalculate based on new bitmap
  * @cstart: start of allocation in clusters
  * @clen: end of allocation in clusters.
  *
diff --git a/fs/ocfs2/stack_o2cb.c b/fs/ocfs2/stack_o2cb.c
index c973c03f6fd8b..2bf4cbcd5fd71 100644
--- a/fs/ocfs2/stack_o2cb.c
+++ b/fs/ocfs2/stack_o2cb.c
@@ -227,7 +227,7 @@ static int o2cb_dlm_lock_status(struct ocfs2_dlm_lksb *lksb)
 }
 
 /*
- * o2dlm aways has a "valid" LVB. If the dlm loses track of the LVB
+ * o2dlm always has a "valid" LVB. If the dlm loses track of the LVB
  * contents, it will zero out the LVB.  Thus the caller can always trust
  * the contents.
  */
diff --git a/fs/ocfs2/stackglue.h b/fs/ocfs2/stackglue.h
index 3636847fae19e..605d6300e62ae 100644
--- a/fs/ocfs2/stackglue.h
+++ b/fs/ocfs2/stackglue.h
@@ -210,7 +210,7 @@ struct ocfs2_stack_operations {
 		     struct file_lock *fl);
 
 	/*
-	 * This is an optoinal debugging hook.  If provided, the
+	 * This is an optional debugging hook.  If provided, the
 	 * stack can dump debugging information about this lock.
 	 */
 	void (*dump_lksb)(struct ocfs2_dlm_lksb *lksb);
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index ee3cf0c245c5a..eca88bd3de183 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1870,7 +1870,7 @@ static void ocfs2_dismount_volume(struct super_block *sb, int mnt_err)
 	osb = OCFS2_SB(sb);
 	BUG_ON(!osb);
 
-	/* Remove file check sysfs related directores/files,
+	/* Remove file check sysfs related directories/files,
 	 * and wait for the pending file check operations */
 	ocfs2_filecheck_remove_sysfs(osb);
 
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 8d15b0e824cdf..7f10e2cf0338d 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -645,7 +645,7 @@ void ocfs2_calc_xattr_init(struct inode *dir, umode_t mode,
 	 * 256(name) + 80(value) + 16(entry) = 352 bytes,
 	 * The max space of acl xattr taken inline is
 	 * 80(value) + 16(entry) * 2(if directory) = 192 bytes,
-	 * when blocksize = 512, may reserve one more cluser for
+	 * when blocksize = 512, may reserve one more cluster for
 	 * xattr bucket, otherwise reserve one metadata block
 	 * for them is ok.
 	 * If this is a new directory with inline data,
@@ -4460,7 +4460,7 @@ static int cmp_xe_offset(const void *a, const void *b)
 
 /*
  * defrag a xattr bucket if we find that the bucket has some
- * holes beteen name/value pairs.
+ * holes between name/value pairs.
  * We will move all the name/value pairs to the end of the bucket
  * so that we can spare some space for insertion.
  */
@@ -5108,7 +5108,7 @@ static int ocfs2_divide_xattr_cluster(struct inode *inode,
  * 2. If cluster_size == bucket_size:
  *    a) If the previous extent rec has more than one cluster and the insert
  *       place isn't in the last cluster, copy the entire last cluster to the
- *       new one. This time, we don't need to upate the first_bh and header_bh
+ *       new one. This time, we don't need to update the first_bh and header_bh
  *       since they will not be moved into the new cluster.
  *    b) Otherwise, move the bottom half of the xattrs in the last cluster into
  *       the new one. And we set the extend flag to zero if the insert place is
@@ -6314,7 +6314,7 @@ struct ocfs2_xattr_reflink {
 /*
  * Given a xattr header and xe offset,
  * return the proper xv and the corresponding bh.
- * xattr in inode, block and xattr tree have different implementaions.
+ * xattr in inode, block and xattr tree have different implementations.
  */
 typedef int (get_xattr_value_root)(struct super_block *sb,
 				   struct buffer_head *bh,
@@ -6394,7 +6394,7 @@ static int ocfs2_get_xattr_value_root(struct super_block *sb,
 }
 
 /*
- * Lock the meta_ac and caculate how much credits we need for reflink xattrs.
+ * Lock the meta_ac and calculate how much credits we need for reflink xattrs.
  * It is only used for inline xattr and xattr block.
  */
 static int ocfs2_reflink_lock_xattr_allocators(struct ocfs2_super *osb,
-- 
2.53.0

