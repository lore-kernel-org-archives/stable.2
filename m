Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793335749;
	b=jZ7rQsCirDFALLA4TzyoFEikX5HRkFKxma1XzsG07BfPPBvnMZAPMDouYtiWatuR9y/W
	 ilxGNG/nKUMW2h205OrfOmlAayVqEH9WCFupW1Y+0rxr/JV4M/Zdoauzc0sDria8qU3ix
	 983b6Mnq1L2Izee5r2zyIkR//pp4TMhz0qxK5a0P72G3ERYD3uo8JzVrccIEgxywEJlGa
	 w5VgyoHTvPIkSmZeAY5LRYPGQxlmvGUwWIl83dEHssD2pdEpXedP9L5dyNG4Cj2qxPYKE
	 oUE432vwecSWfX6nGJJJTldDGf3VQVjhPTmJwufAKKHRf1UywVXdDVov8kOETfXnMVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793335749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5ScpKk3+kXujkn6wVk24CT0rKh32pGHFS5vp8ScT+Uo=;
	b=CTJF60elOt1EofPzYR3A20LSGc+iIVv8ceOv9z3sGUAH5dzqMoZZwrga6bsOoEJNTox5
	 sg8l+4WLU4iZPEr4jT6ACMAdGRBnfSzttnUxS45yxY+cRia3YB7gROGH8hHReN8Ovf7QP
	 zTNvDlNP7a0IN618RyURjAIAaEwniN552/pdmzzdnhYXJ3KniyzuxdSqXFnGm4/7cpy+4
	 lrmdandI56jOyoHQXyIEmAsoAxOKSxAohniAjB0MisYGlWxFGg8y2Hqhg7+8X2ZY3ga2Y
	 Y3Wgceksc70wXvf7rUY0CWHJFh9369lUgUUUCGIXWySItiygCNLExsxnQj27hEBjsBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0VNdJYFY;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952D5606A327
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 04:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 952D5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0VNdJYFY
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e977109392so2055185ad.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793335743; x=1793940543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ScpKk3+kXujkn6wVk24CT0rKh32pGHFS5vp8ScT+Uo=;
        b=0VNdJYFYkuhrOqnWFQkXLmOG6+S9iRvA1aHl/YuZ5Y67YDC3yir3P+HIKNUw7ehQCz
         4rGCO5BJmrlICCn9vEFql0JG9NM4k9uMYlEwEWAUvgbf3gijxkIAujFnjUxup1EjYWek
         8gZu2maLr9iffqtsNKWYit4oaPqimXatcGCP4+FGaC8F8FrGKf3voeod72TmW+IqZaMR
         m57XfPhATu5x/9i9ogcIG8CkUes3v2rZXdNo5vYKL5OUEERGtFynYM86nul1sPaCflJN
         dCyN1+rO5Kw4V6Y3P5FV3QXFP6JsXBPD/+2Ewy01xS1jCSnrobCwmr1WIWyxkcS922ZN
         5IMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793335743; x=1793940543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ScpKk3+kXujkn6wVk24CT0rKh32pGHFS5vp8ScT+Uo=;
        b=S3klabQnIaI2Algl3Fq8x+Sk7uyHPWQKlLyTP9ShbBoN/sb6E+Cc601LoD2tA2PSgW
         HbYhTtBSDMgxLxxznVlimtlQ4UAiFBF8IxhkSwAmCJ4A0dDbiuBC/GSQ5JVg1F8d2glD
         nqiLKMK9gc1mNgK9oKpLxkssOrqOQ6NX92cVdXrE+UR8dWTmBeMvR+PHdf+Jg/bKwBDb
         61/ZjnBfu7szO8IQsxphNNN6F/5Py1flM2kwyX2oy/Kyt30RR3oFKQB7z92wazXSH0hm
         khVfZyv/TB636AdzUyFKFhO/2UVtpYHOaoE9lBWgoq+Q7Mqh5wDuMtjfipHV/fRPalM1
         8PAQ==
X-Forwarded-Encrypted: i=1; AKwUvBw0Uqx/NJSsa7kjFRDq19msN1dVsxqyLEgjHG9mbAQ+gJ5SqyolrN669v5dm83bY/L0looy3ec=@vger.kernel.org
X-Gm-Message-State: AFq9FYLi2g94xhbT3bxyTWjn0cQ9Q4HD3wj6M6LnjRrXFLbpAm1EjJXr
	dv8xnWqunMl9NFQFx1dKajxZKOhAJMcneJr1AG18xaPSQolYI7HnlJMH
X-Gm-Gg: AYBFou2nrAi7wcRJpDH232blGf4H8c5UvQxyDjG1wt7Q6v5HITvWGuAKnsbJKUu0qKm
	M4CeWC3iPb0WnCwWpl84u1qkTJlJ7tOQJeKbTDEpDQUzjLiTkB+/8o1w4E7OgdgzS5CoArwbVji
	VstfGlVSiBG5cVEMRaHPfyq7N3U0V7G51mq4c9pfSLOuVcbz9zkaPsDDdHybQI73RVzOolVDvyu
	Kk2XfPm0HDp6O56Db0E8U15923qxuEtPPiXp4GfOBRbAWfYhD+PBEycyrvQompNUuHcGsJV/dWe
	RUhjjImhyBx8pauA1s7Q831PQ8G3dTUyG6aXRKM85yBqQ1sgEF7glD1O91ugAYpRKmxXTu/ztRF
	Nmzzsc6h689ZYjRSracJrNtj3On1u6d4POOqwvTxgYsQLAgEbCdTyMtoqk4Xq1Xt3RONlLdLNb3
	OllMud9VJXkSfGysEjh/OoWKDUWemhFj+zb/5n69u3yw8XVnPS3o3R90hSJHWY4y6I0hU6iYryD
	Vb235d4xyn5Ey2SlAwl+fNsEFlPVrYSQV+vxFGEW44ygFV3LpJ/wm2YZw5jEHmHEe7Wt0lWgaC0
	OmOSWQTCtPu160qtGh/8NREk
X-Received: by 2002:a17:902:f691:b0:2e2:d39f:182f with SMTP id d9443c01a7336-2eb3643d489mr14269675ad.28.1793335742769;
        Thu, 29 Oct 2026 21:49:02 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3927e856sm2117355ad.50.2026.10.29.21.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:49:02 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: heming.zhao@suse.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] ocfs2: serialize inode journal access with shutdown
Date: Fri, 30 Oct 2026 12:48:56 +0800
Message-Id: <pm-ocfs2-objects-candidate-0004-v8-dbcb8f80b8df476084d6@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The downconvert thread can run inode cleanup until ocfs2_dlm_shutdown()
stops it, but unmount shuts down the journal earlier. A final dentry
post-unlock put can therefore enter ocfs2_clear_inode() while the journal
is being destroyed.

ocfs2_ci_fully_checkpointed() loads osb->journal before taking
trans_inc_lock. Journal shutdown neither takes that lock for removal
nor waits for the downconvert thread before freeing the journal:

  Downconvert thread                    Unmount
  ------------------                    -------
  dentry post-unlock; final iput()
    ocfs2_checkpoint_inode()
      load osb->journal
                                        ocfs2_journal_shutdown()
                                          free journal; clear pointer
      read the transaction ID

The checkpoint wait queue is embedded in that journal, and the final
jbd2_journal_release_jbd_inode() also needs its JBD2 journal to remain
alive for the whole call. Protecting only the pointer load would leave
those longer uses unprotected.

Read and clear osb->journal under trans_inc_lock when checking checkpoint
progress. Treat a removed journal as checkpointed. Move checkpoint
waiters to the existing mount-owned checkpoint_event and wake it after
checkpoint progress and journal removal, so the queue outlives the
journal. The commit thread also waits there and rechecks its condition
when woken.

Serialize the final JBD2 inode release against JBD2 destruction and the
journal free with a mount-owned rw_semaphore. Take the write side only
after stopping the commit thread, and drop it before the journal inode's
final iput(), whose cleanup can take the read side. Inode cleanup holds
the read side only around the JBD2 release, outside checkpoint waits and
DLM lock teardown.

KASAN report as below:

    Oops: general protection fault, probably for non-canonical address 0xdffffc000000000e: 0000 [#1] SMP KASAN NOPTI
    KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
    CPU: 0 UID: 0 PID: 587 Comm: ocfs2dc-33CAF04 Not tainted 7.3.0-rc4-next-20260921-pmb-ocfs2-functional-v1+ #1 PREEMPT(lazy) 
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    RIP: 0010:ocfs2_clear_inode+0x8ae/0x1630
    Code: fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 27 0c 00 00 49 8d 7d 70 48 8b 43 c8 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f 85 f0 0b 00 00 49 3b 45 70 0f 88 62 03 00 00 e8 49
    RSP: 0018:ffff888118d3f878 EFLAGS: 00010212
    RAX: 0000000000000001 RBX: ffff88811a5edc60 RCX: 000000000000000e
    RDX: dffffc0000000000 RSI: 0000000000000001 RDI: 0000000000000070
    RBP: ffff888116134000 R08: 0000000000000001 R09: 0000000000000001
    R10: ffffffff8965765f R11: 0000000000000001 R12: ffff88811a5ed400
    R13: 0000000000000000 R14: ffff88811a5edbf8 R15: ffff88811a5ed408
    FS:  0000000000000000(0000) GS:ffff8881fd4dc000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 00007ff35b66f2c0 CR3: 00000001092ae005 CR4: 0000000000770ef0
    PKRU: 55555554
    Call Trace:
     <TASK>
     ? __pfx_ocfs2_clear_inode+0x10/0x10
     ? __pfx_ocfs2_inode_is_valid_to_delete+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __lock_acquire+0x5a3/0x2140
     ocfs2_evict_inode+0x1ed/0x11e0
     ? inode_wait_for_writeback+0x14c/0x330
     ? __pfx_ocfs2_evict_inode+0x10/0x10
     ? lock_acquire+0x190/0x300
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? find_held_lock+0x2b/0x80
     ? evict+0x347/0x9f0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x290
     ? _raw_spin_unlock+0x23/0x40
     ? __pfx_ocfs2_evict_inode+0x10/0x10
     evict+0x38b/0x9f0
     ? __pfx_evict+0x10/0x10
     ? lock_acquire+0x190/0x300
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x290
     ? __pfx_inode_just_drop+0x10/0x10
     iput+0x680/0xb80
     ocfs2_dentry_lock_put+0xc2/0x110
     ? __pfx_ocfs2_dentry_post_unlock+0x10/0x10
     ocfs2_process_blocked_lock+0x1fb/0x420
     ? __pfx_ocfs2_process_blocked_lock+0x10/0x10
     ? __pfx_pmbd_probe_hit_cookie+0x10/0x10
     ? lock_release+0xc8/0x290
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lockdep_hardirqs_on_prepare+0xeb/0x1a0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ocfs2_downconvert_thread+0x32b/0x780
     ? do_raw_spin_lock+0x130/0x270
     ? __pfx_ocfs2_downconvert_thread+0x10/0x10
     ? __kthread_parkme+0xc1/0x220
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x290
     ? __pfx_autoremove_wake_function+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __kthread_parkme+0x177/0x220
     ? __pfx_ocfs2_downconvert_thread+0x10/0x10
     kthread+0x351/0x460
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x659/0x940
     ? __pfx_ret_from_fork+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __switch_to+0x74f/0xf70
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>
    Modules linked in:
    ---[ end trace 0000000000000000 ]---

Fixes: da5e7c87827e ("ocfs2: cleanup journal init and shutdown")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/ocfs2/inode.c   | 17 +++++++++--------
 fs/ocfs2/journal.c | 30 ++++++++++++++++++++++--------
 fs/ocfs2/journal.h | 17 +++++++++--------
 fs/ocfs2/ocfs2.h   |  1 +
 fs/ocfs2/super.c   |  1 +
 5 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 80c36c60a8ce..e225a96d3753 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1318,15 +1318,16 @@ static void ocfs2_clear_inode(struct inode *inode)
 	oi->ip_blkno = 0ULL;
 
 	/*
-	 * ip_jinode is used to track txns against this inode. We ensure that
-	 * the journal is flushed before journal shutdown. Thus it is safe to
-	 * have inodes get cleaned up after journal shutdown.
+	 * ip_jinode is used to track txns against this inode. The journal is
+	 * flushed before it is shut down, so an inode cleaned up after that
+	 * has nothing left to release. Hold the shutdown lock so a journal
+	 * found here stays allocated until the release has finished.
 	 */
-	if (!osb->journal)
-		return;
-
-	jbd2_journal_release_jbd_inode(osb->journal->j_journal,
-				       &oi->ip_jinode);
+	down_read(&osb->journal_shutdown_sem);
+	if (osb->journal)
+		jbd2_journal_release_jbd_inode(osb->journal->j_journal,
+					       &oi->ip_jinode);
+	up_read(&osb->journal_shutdown_sem);
 }
 
 void ocfs2_evict_inode(struct inode *inode)
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index cc60db6b9706..8486c5edc5da 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -343,7 +343,7 @@ static int ocfs2_commit_cache(struct ocfs2_super *osb)
 	trace_ocfs2_commit_cache_end(journal->j_trans_id, flushed);
 
 	ocfs2_wake_downconvert_thread(osb);
-	wake_up(&journal->j_checkpointed);
+	wake_up(&osb->checkpoint_event);
 finally:
 	return status;
 }
@@ -892,7 +892,6 @@ int ocfs2_journal_alloc(struct ocfs2_super *osb)
 
 	atomic_set(&journal->j_num_trans, 0);
 	init_rwsem(&journal->j_trans_barrier);
-	init_waitqueue_head(&journal->j_checkpointed);
 	spin_lock_init(&journal->j_lock);
 	journal->j_trans_id = 1UL;
 	INIT_LIST_HEAD(&journal->j_la_cleanups);
@@ -1064,12 +1063,14 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb)
 
 	journal = osb->journal;
 	if (!journal)
-		goto done;
+		return;
 
 	inode = journal->j_inode;
 
-	if (journal->j_state != OCFS2_JOURNAL_LOADED)
-		goto done;
+	if (journal->j_state != OCFS2_JOURNAL_LOADED) {
+		down_write(&osb->journal_shutdown_sem);
+		goto free;
+	}
 
 	/* need to inc inode use count - jbd2_journal_destroy will iput. */
 	if (!igrab(inode))
@@ -1105,6 +1106,12 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb)
 			mlog_errno(status);
 	}
 
+	/*
+	 * Exclude the final JBD2 inode cleanup in ocfs2_clear_inode() while
+	 * the journal is destroyed and freed.
+	 */
+	down_write(&osb->journal_shutdown_sem);
+
 	/* Shutdown the kernel journal system */
 	if (!jbd2_journal_destroy(journal->j_journal) && !status) {
 		/*
@@ -1127,10 +1134,17 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb)
 
 	journal->j_state = OCFS2_JOURNAL_FREE;
 
-done:
-	iput(inode);
-	kfree(journal);
+free:
+	/* Serialize the removal with ocfs2_ci_fully_checkpointed(). */
+	spin_lock(&trans_inc_lock);
 	osb->journal = NULL;
+	spin_unlock(&trans_inc_lock);
+	wake_up(&osb->checkpoint_event);
+	kfree(journal);
+	up_write(&osb->journal_shutdown_sem);
+
+	/* The journal inode's own cleanup takes the read side. */
+	iput(inode);
 }
 
 static void ocfs2_clear_journal_error(struct super_block *sb,
diff --git a/fs/ocfs2/journal.h b/fs/ocfs2/journal.h
index 19fc920d26b1..fe024ec5adcc 100644
--- a/fs/ocfs2/journal.h
+++ b/fs/ocfs2/journal.h
@@ -54,7 +54,6 @@ struct ocfs2_journal {
 	spinlock_t                j_lock;
 	unsigned long             j_trans_id;
 	struct rw_semaphore       j_trans_barrier;
-	wait_queue_head_t         j_checkpointed;
 
 	/* both fields protected by j_lock*/
 	struct list_head          j_la_cleanups;
@@ -91,11 +90,15 @@ static inline void ocfs2_set_ci_lock_trans(struct ocfs2_journal *journal,
 static inline int ocfs2_ci_fully_checkpointed(struct ocfs2_caching_info *ci)
 {
 	int ret;
-	struct ocfs2_journal *journal =
-		OCFS2_SB(ocfs2_metadata_cache_get_super(ci))->journal;
+	struct ocfs2_super *osb =
+		OCFS2_SB(ocfs2_metadata_cache_get_super(ci));
+	struct ocfs2_journal *journal;
 
 	spin_lock(&trans_inc_lock);
-	ret = time_after(journal->j_trans_id, ci->ci_last_trans);
+	journal = osb->journal;
+	/* A NULL journal has already completed checkpointing. */
+	ret = !journal ||
+		time_after(journal->j_trans_id, ci->ci_last_trans);
 	spin_unlock(&trans_inc_lock);
 	return ret;
 }
@@ -195,9 +198,6 @@ static inline void ocfs2_checkpoint_inode(struct inode *inode)
 	if (ocfs2_mount_local(osb))
 		return;
 
-	if (!osb->journal)
-		return;
-
 	if (!ocfs2_ci_fully_checkpointed(INODE_CACHE(inode))) {
 		/* WARNING: This only kicks off a single
 		 * checkpoint. If someone races you and adds more
@@ -207,7 +207,8 @@ static inline void ocfs2_checkpoint_inode(struct inode *inode)
 		 * OK. */
 		ocfs2_start_checkpoint(osb);
 
-		wait_event(osb->journal->j_checkpointed,
+		/* The wait queue must outlive journal shutdown. */
+		wait_event(osb->checkpoint_event,
 			   ocfs2_ci_fully_checkpointed(INODE_CACHE(inode)));
 	}
 }
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index e3bb3cc0b25a..8bee145e4888 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -388,6 +388,7 @@ struct ocfs2_super
 	enum ocfs2_recovery_state recovery_state;
 	wait_queue_head_t checkpoint_event;
 	struct ocfs2_journal *journal;
+	struct rw_semaphore journal_shutdown_sem;
 	unsigned long osb_commit_interval;
 
 	/* Journal triggers for checksum */
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 0af2245ae303..3ffe1143ea50 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2045,6 +2045,7 @@ static int ocfs2_initialize_super(struct super_block *sb,
 	}
 
 	init_waitqueue_head(&osb->checkpoint_event);
+	init_rwsem(&osb->journal_shutdown_sem);
 
 	osb->s_atime_quantum = OCFS2_DEFAULT_ATIME_QUANTUM;
 
