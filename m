Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391094AF9C9
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442852; cv=none; b=PWDD5rWZ4vffR1kPwKM3okHhSmqztqagE1mFAQ3yP0jmMgigeXt2C0bVXxBN29UYfUFV3ZriJZVW+fuAr81fch3eZtWTHjs3fOipGTCvJCZkd9+H8XZAtFF44pBO9Jxf+HqfZEaldOvrVP7JPk/NcKYG/c1wwqm3K8L0R89AdyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442852; c=relaxed/simple;
	bh=8iOSXGC/zzl8RKugMDvIq10B0BVvRYTHlenCOxbvhpM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f9ymhcJSGyDDpWcoeP3fTf2wr0Pnp/okSEFYiOdpJP6opva36YSZRCnYlZ6m6BzsSqc1qFVMUsPu0wgzyiyXj1sEdlRzGIwCj1FnEFuJPzGRFxOYPyEZPJAjb8pqHWP15Uqgycj3STNrqfN0d7OwPeGQ57V2tol4iaflUDeXPzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sMtPXKiS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sMtPXKiS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB57E1F00ACA;
	Thu,  3 Sep 2026 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788442845;
	bh=ru4dkdRy0CtMviOV1epgBAtsMGdY48ytnNv170CsScE=;
	h=Subject:To:Cc:From:Date;
	b=sMtPXKiSorlayaxL4wQ2ek2KRRbjkuEVNQdsQLW/G1MMDKQXcMYsiTA5HpnwL2vN/
	 S/81YNGEaBDANbfs1k2yVqrCb/FuUwsNHppCJSDPzuSOAn0+qA7rvmA58NGjzTFDzz
	 pi2vDEpWOuA19fQUwUsXlD+3sgppIZFc3H7Iis1s=
Subject: FAILED: patch "[PATCH] nfsd: fix UAF in async copy cancel and shutdown" failed to apply to 6.18-stable tree
To: jlayton@kernel.org,cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:15:32 +0200
Message-ID: <2026090332-exact-stature-60b9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 62c0f6eaf050bb9284c1f9cac6ed1770092e6b95
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090332-exact-stature-60b9@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 62c0f6eaf050bb9284c1f9cac6ed1770092e6b95 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 10 Jul 2026 10:00:06 -0400
Subject: [PATCH] nfsd: fix UAF in async copy cancel and shutdown

An async copy could be freed or used after free while a teardown caller
(OFFLOAD_CANCEL, nfsd4_shutdown_copy, nfsd4_cancel_copy_by_sb) raced the
copy kthread:

  - find_async_copy() bumped copy->refcount but left the copy on
    clp->async_copies, so the reaper's cleanup_async_copy() could run
    release_copy_files() concurrently with a cancel/shutdown caller. Both
    put and NULL nf_src/nf_dst without a common lock, double-putting the
    nfsd_file and freeing it early.

  - nfsd4_do_async_copy() set NFSD4_COPY_F_STOPPED before its final uses
    of the copy (nfsd_update_cmtime_attr() on copy->nf_dst,
    nfsd4_send_cb_offload()). nfsd4_stop_copy() treats a set STOPPED bit
    as "kthread done, skip kthread_stop()", so a teardown caller ran
    release_copy_files() -- which puts and NULLs nf_dst -- while the
    kthread still dereferenced it (NULL/UAF).

  - copy->copy_task was never pinned. The one-shot kthread self-reaps on
    return, so kthread_stop()'s get_task_struct() could touch a freed
    task_struct.

  - co_cb is embedded in the copy, but nfsd4_send_cb_offload() held a
    reference only on the client, so a concurrent teardown could free
    the copy while the CB_OFFLOAD callback was in flight.

Fix the teardown lifetime as a whole:

  - find_async_copy() unlinks the copy (clear cp_clp, list_del_init)
    under async_lock; the cancel, shutdown, and sb-cancel paths drop the
    list-membership reference via nfs4_put_copy() after nfsd4_stop_copy().
    Drop the now-redundant list_del fixup from cleanup_async_copy().

  - Because unlinking hides the copy from the reaper, its
    cleanup_async_copy() can no longer remove the copy's s2s_cp_stateids
    entry; the cancel/shutdown/sb-cancel paths now call
    nfs4_free_copy_state() themselves (while cp_clp is still valid) so
    the entry does not dangle at freed memory for the laundromat and
    manage_cpntf_state() to dereference.

  - Give the kthread its own reference, taken in nfsd4_copy() before
    wake_up_process() and dropped at the end of nfsd4_do_async_copy();
    call wake_up_process() before list_add().

  - Pin the task_struct with get_task_struct() in nfsd4_copy(), released
    in nfs4_put_copy(), so kthread_stop() is safe whenever the kthread
    exits. Set NFSD4_COPY_F_STOPPED only in nfsd4_stop_copy(), which now
    always kthread_stop()s before release_copy_files(); completion is
    still reported via NFSD4_COPY_F_COMPLETED, so
    nfsd4_has_active_async_copies() is unaffected. Each teardown caller
    removes the copy from clp->async_copies first, so kthread_stop() runs
    exactly once.

  - Take a copy reference in nfsd4_send_cb_offload(), dropped in
    nfsd4_cb_offload_release(). The kthread still holds its own reference
    there, so the refcount_inc() cannot race the final free.

  - Read cp_clp with smp_load_acquire() to pair with the unordered
    set_bit()/clear_bit() writers (Documentation/atomic_bitops.rst).

Fixes: e0639dc5805a ("NFSD introduce async copy feature")
Cc: stable@vger.kernel.org
Fixes: ac0514f4d198 ("NFSD: Add a laundromat reaper for async copy state")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260710-nfsd-testing-v3-2-a0ff7db6aa3e@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 669896be08b6..b2f1a9bc9202 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1519,6 +1519,9 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
 {
 	if (!refcount_dec_and_test(&copy->refcount))
 		return;
+	/* Drop the task_struct pinned in nfsd4_copy(); NULL on sync copies. */
+	if (copy->copy_task)
+		put_task_struct(copy->copy_task);
 	kfree(copy->cp_src);
 	kfree(copy);
 }
@@ -1528,20 +1531,18 @@ static void release_copy_files(struct nfsd4_copy *copy);
 static void nfsd4_stop_copy(struct nfsd4_copy *copy)
 {
 	trace_nfsd_copy_async_cancel(copy);
-	if (!test_and_set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags)) {
-		kthread_stop(copy->copy_task);
-		if (!test_bit(NFSD4_COPY_F_CB_ERROR, &copy->cp_flags))
-			copy->nfserr = nfs_ok;
-		set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
-	}
-
 	/*
-	 * The copy was removed from async_copies before this function
-	 * was called, so the reaper cannot clean it up. Release files
-	 * here regardless of who won the STOPPED race. If the thread
-	 * set STOPPED, it has finished using the files. If STOPPED
-	 * was set here, kthread_stop() waited for the thread to exit.
+	 * Join the kthread before releasing its resources. The task_struct is
+	 * pinned in nfsd4_copy(), so kthread_stop() is safe even after the
+	 * one-shot kthread has exited. The caller already unlinked the copy,
+	 * so this runs once per copy.
 	 */
+	set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags);
+	kthread_stop(copy->copy_task);
+	if (!test_bit(NFSD4_COPY_F_CB_ERROR, &copy->cp_flags))
+		copy->nfserr = nfs_ok;
+	set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
+
 	release_copy_files(copy);
 	nfs4_put_copy(copy);
 }
@@ -1555,7 +1556,13 @@ static struct nfsd4_copy *nfsd4_unhash_copy(struct nfs4_client *clp)
 		copy = list_first_entry(&clp->async_copies, struct nfsd4_copy,
 					copies);
 		refcount_inc(&copy->refcount);
-		copy->cp_clp = NULL;
+		/*
+		 * Unlinking hides the copy from the reaper, so drop its
+		 * s2s_cp_stateids entry here while cp_clp is still valid.
+		 */
+		nfs4_free_copy_state(copy);
+		/* Pairs with smp_load_acquire() in nfsd4_send_cb_offload(). */
+		smp_store_release(&copy->cp_clp, NULL);
 		if (!list_empty(&copy->copies))
 			list_del_init(&copy->copies);
 	}
@@ -1567,8 +1574,11 @@ void nfsd4_shutdown_copy(struct nfs4_client *clp)
 {
 	struct nfsd4_copy *copy;
 
-	while ((copy = nfsd4_unhash_copy(clp)) != NULL)
+	while ((copy = nfsd4_unhash_copy(clp)) != NULL) {
 		nfsd4_stop_copy(copy);
+		/* Reaper can't reach the unhashed copy; drop its membership ref. */
+		nfs4_put_copy(copy);
+	}
 }
 
 static bool nfsd4_copy_on_sb(const struct nfsd4_copy *copy,
@@ -1636,7 +1646,11 @@ void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb)
 		struct nfs4_client *clp = copy->cp_clp;
 
 		list_del_init(&copy->copies);
+		/* Reaper can't reach it; drop the s2s entry while cp_clp is valid. */
+		nfs4_free_copy_state(copy);
 		nfsd4_stop_copy(copy);
+		/* Drop the membership ref the reaper would have dropped. */
+		nfs4_put_copy(copy);
 		nfsd4_put_client(clp);
 	}
 }
@@ -1931,6 +1945,8 @@ static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
 
 	set_bit(NFSD4_COPY_F_OFFLOAD_DONE, &copy->cp_flags);
 	nfsd4_put_client(cb->cb_clp);
+	/* Drop the copy reference taken in nfsd4_send_cb_offload(). */
+	nfs4_put_copy(copy);
 }
 
 static int nfsd4_cb_offload_done(struct nfsd4_callback *cb,
@@ -2062,28 +2078,29 @@ static void release_copy_files(struct nfsd4_copy *copy)
 	}
 }
 
+/*
+ * Called from the reaper and from nfsd4_copy()'s error path; in both
+ * cases the copy is already unreachable from clp->async_copies.
+ */
 static void cleanup_async_copy(struct nfsd4_copy *copy)
 {
 	nfs4_free_copy_state(copy);
 	release_copy_files(copy);
-	if (copy->cp_clp) {
-		spin_lock(&copy->cp_clp->async_lock);
-		if (!list_empty(&copy->copies))
-			list_del_init(&copy->copies);
-		spin_unlock(&copy->cp_clp->async_lock);
-	}
 	nfs4_put_copy(copy);
 }
 
 static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
 {
 	struct nfsd4_cb_offload *cbo = &copy->cp_cb_offload;
-	struct nfs4_client *clp = copy->cp_clp;
+	struct nfs4_client *clp;
 
 	/*
-	 * cp_clp is NULL when called via nfsd4_shutdown_copy() during
-	 * client destruction. Skip the callback; the client is gone.
+	 * Pairs with smp_store_release(&cp_clp) in find_async_copy() and
+	 * nfsd4_unhash_copy(); the set_bit/clear_bit writers are unordered.
+	 * cp_clp is NULL once the copy was canceled; skip the callback, the
+	 * canceling path owns the notification.
 	 */
+	clp = smp_load_acquire(&copy->cp_clp);
 	if (!clp) {
 		set_bit(NFSD4_COPY_F_OFFLOAD_DONE, &copy->cp_flags);
 		return;
@@ -2095,10 +2112,12 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
 	cbo->co_retries = 5;
 
 	/*
-	 * Hold a reference on the client while the callback is in flight.
-	 * Released in nfsd4_cb_offload_release().
+	 * Hold the client and the copy across the in-flight callback; co_cb is
+	 * embedded in the copy, so it must outlive the callback. Both are
+	 * dropped in nfsd4_cb_offload_release().
 	 */
 	kref_get(&clp->cl_nfsdfs.cl_ref);
+	refcount_inc(&copy->refcount);
 
 	nfsd4_init_cb(&cbo->co_cb, clp, &nfsd4_cb_offload_ops,
 		      NFSPROC4_CLNT_CB_OFFLOAD);
@@ -2150,16 +2169,20 @@ static int nfsd4_do_async_copy(void *data)
 do_callback:
 	if (!test_bit(NFSD4_COPY_F_CB_ERROR, &copy->cp_flags))
 		copy->nfserr = nfserr;
-	/* The kthread exits forthwith. Ensure that a subsequent
-	 * OFFLOAD_CANCEL won't try to kill it again. */
-	set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags);
-
+	/*
+	 * Don't set NFSD4_COPY_F_STOPPED here: it tells a teardown caller it
+	 * may skip kthread_stop(), which would then release nf_dst and the
+	 * client while still in use. Only nfsd4_stop_copy() sets it, after
+	 * joining.
+	 */
 	set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
 	trace_nfsd_copy_async_done(copy);
 	atomic_dec(&copy->cp_nn->pending_async_copies);
 	if (copy->cp_res.wr_bytes_written > 0 && copy->attr_update)
 		nfsd_update_cmtime_attr(copy->nf_dst->nf_file, 0);
 	nfsd4_send_cb_offload(copy);
+	/* Drop the kthread's reference (taken in nfsd4_copy()); copy may be freed after this. */
+	nfs4_put_copy(copy);
 	return 0;
 }
 
@@ -2198,6 +2221,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
 		sizeof(struct knfsd_fh));
 	if (nfsd4_copy_is_async(copy)) {
+		struct task_struct *task;
+
 		async_copy = kzalloc_obj(struct nfsd4_copy);
 		if (!async_copy)
 			goto out_err;
@@ -2225,15 +2250,27 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		       NFS4_MAX_SESSIONID_LEN);
 		async_copy->cp_cb_offload.co_referring_slotid = cstate->slot->sl_index;
 		async_copy->cp_cb_offload.co_referring_seqno = cstate->slot->sl_seqid;
-		async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
-				async_copy, "%s", "copy thread");
-		if (IS_ERR(async_copy->copy_task))
+		task = kthread_create(nfsd4_do_async_copy, async_copy,
+				      "%s", "copy thread");
+		if (IS_ERR(task))
 			goto out_dec_async_copy_err;
+		/*
+		 * Pin the task_struct so kthread_stop() is safe after this
+		 * one-shot kthread exits. Released by nfs4_put_copy().
+		 */
+		get_task_struct(task);
+		async_copy->copy_task = task;
+		/*
+		 * Take the kthread's ref and wake it before publishing, so the
+		 * publisher touches async_copy no further and teardown can
+		 * drain it.
+		 */
+		refcount_inc(&async_copy->refcount);
+		wake_up_process(async_copy->copy_task);
 		spin_lock(&async_copy->cp_clp->async_lock);
 		list_add(&async_copy->copies,
 				&async_copy->cp_clp->async_copies);
 		spin_unlock(&async_copy->cp_clp->async_lock);
-		wake_up_process(async_copy->copy_task);
 		status = nfs_ok;
 	} else {
 		status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
@@ -2287,8 +2324,18 @@ find_async_copy(struct nfs4_client *clp, stateid_t *stateid)
 
 	spin_lock(&clp->async_lock);
 	copy = find_async_copy_locked(clp, stateid);
-	if (copy)
+	if (copy) {
 		refcount_inc(&copy->refcount);
+		nfs4_free_copy_state(copy);
+		/*
+		 * Mirror nfsd4_unhash_copy(): unlink and clear cp_clp under
+		 * async_lock so the reaper can't reach it. Caller drops the
+		 * membership ref after nfsd4_stop_copy().
+		 */
+		smp_store_release(&copy->cp_clp, NULL);
+		if (!list_empty(&copy->copies))
+			list_del_init(&copy->copies);
+	}
 	spin_unlock(&clp->async_lock);
 	return copy;
 }
@@ -2307,8 +2354,11 @@ nfsd4_offload_cancel(struct svc_rqst *rqstp,
 		struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
 		return manage_cpntf_state(nn, &os->stateid, clp, NULL);
-	} else
+	} else {
 		nfsd4_stop_copy(copy);
+		/* find_async_copy() unlinked it from the reaper; drop the membership ref. */
+		nfs4_put_copy(copy);
+	}
 
 	return nfs_ok;
 }

