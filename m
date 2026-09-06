Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D94503B
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701320; cv=none; b=EX2h3w85+nF5hWhs3Iyr/H9+8H13QLkcfhfd+RJvdd8+07W6swvk2bzzJQK38pLFKOf2J64aP8rOA9v6FKkq/pbCTPcwll4XNkcBt8hZVEHTrHB1x38SOH4mxEC/nK0XoaQ94BY24a/uCt+2CeEhkkt9e5/cs5+ynM6Qh5ocg9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701320; c=relaxed/simple;
	bh=CaapIlblVqhGNYhZ+kV6t0wQScmQq5s7ZLU4AELbbUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaY295HsNZr2y0y/lsf0cKPEGvyJpZvE49rLbWkUxtNWU/gwbCuiuFzAcb2zR9VAWar4JjZUOoAEiH2D0Z/EJ2t4gpCIaHFep611KG5/vRRKDSEJw8h2wciH0FLT+4T3FOSioY455R3u0uFXS1kY5Sa235GzrWBcSoniEpf2fzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmG6/QTO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmG6/QTO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B1B1F00A3E;
	Sun,  6 Sep 2026 13:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701317;
	bh=sjg1D1PH3gwJSX/CVOY3lEPJwSe9N6VL4ttrz7EKaIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XmG6/QTOITml9dTrAWZMu81CqO/x2tlLWlOgQfl/GRRHDntq+JN+ODz4wyzxrv+pL
	 BPNs4tKIeqONinl1pEYDW4D29NXO3M6kkyBd8sqXgjpIw4mNviJynVJPPBRL7xweD+
	 SiSk05hp2P58rcvjI3eFa7j9eczlMZD4+UIE4V5kATJ0/rJ7bbJmf3hzoOJz5w+zDo
	 nBAJ7whsetP9NY+uqedIl3GmV669bnGmuc+16zBtHPr1g0oR0CEUU8q8jTAUAlSQJk
	 XBlZl+5cvigSbgFRh5o/DyLvtkCE+ArJBMEnIgB37mlIFsb5Q0H4fxeC23t5+0RYJb
	 UCyj0cqTn46cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/7] nfsd: prevent callback tasks running concurrently
Date: Sun,  6 Sep 2026 09:28:29 -0400
Message-ID: <20260906132831.874344-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906132831.874344-1-sashal@kernel.org>
References: <2026090304-heroism-outclass-581e@gregkh>
 <20260906132831.874344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 1054e8ffc5c492f341bdf1888b882f1d163dd3d8 ]

The nfsd4_callback workqueue jobs exist to queue backchannel RPCs to
rpciod. Because they run in different workqueue contexts, the rpc_task
can run concurrently with the workqueue job itself, should it become
requeued. This is problematic as there is no locking when accessing the
fields in the nfsd4_callback.

Add a new unsigned long to nfsd4_callback and declare a new
NFSD4_CALLBACK_RUNNING flag to be set in it. When attempting to run a
workqueue job, do a test_and_set_bit() on that flag first, and don't
queue the workqueue job if it returns true. Clear NFSD4_CALLBACK_RUNNING
in nfsd41_destroy_cb().

This also gives us a more reliable mechanism for handling queueing
failures in codepaths where we have to take references under spinlocks.
We can now do the test_and_set_bit on NFSD4_CALLBACK_RUNNING first, and
only take references to the objects if that returns false.

Most of the nfsd4_run_cb() callers are converted to use this new flag or
the nfsd4_try_run_cb() wrapper. The main exception is the callback
channel probe, which has its own synchronization.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 01c5d5f58a5d ("nfsd: RCU-protect cl_cb_session to fix use-after-free on session teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4callback.c |  9 ++-------
 fs/nfsd/nfs4layouts.c  |  7 ++++---
 fs/nfsd/nfs4proc.c     |  3 ++-
 fs/nfsd/nfs4state.c    | 16 +++++++++++++---
 fs/nfsd/state.h        |  2 ++
 5 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 3512e967bc754..755e2ea069491 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1142,6 +1142,7 @@ static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
 	struct nfs4_client *clp = cb->cb_clp;
 
 	nfsd41_cb_release_slot(cb);
+	clear_bit(NFSD4_CALLBACK_RUNNING, &cb->cb_flags);
 	if (cb->cb_ops && cb->cb_ops->release)
 		cb->cb_ops->release(cb);
 	nfsd41_cb_inflight_end(clp);
@@ -1204,13 +1205,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		rpc_delay(task, 2 * HZ);
 		return false;
 	case -NFS4ERR_BADSLOT:
-		/*
-		 * BADSLOT means that the client and server are out of sync
-		 * as to the backchannel parameters. Mark the backchannel faulty
-		 * and restart the RPC, but leak the slot so no one uses it.
-		 */
-		nfsd4_mark_cb_fault(cb->cb_clp);
-		cb->cb_held_slot = -1;
 		goto retry_nowait;
 	case -NFS4ERR_SEQ_MISORDERED:
 		if (session->se_cb_seq_nr != 1) {
@@ -1455,6 +1449,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 	cb->cb_msg.rpc_proc = &nfs4_cb_procedures[op];
 	cb->cb_msg.rpc_argp = cb;
 	cb->cb_msg.rpc_resp = cb;
+	cb->cb_flags = 0;
 	cb->cb_ops = ops;
 	INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
 	cb->cb_seq_status = 1;
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index bcf16dd07d488..1c37e14cb3750 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -326,9 +326,10 @@ nfsd4_recall_file_layout(struct nfs4_layout_stateid *ls)
 	atomic_inc(&ls->ls_stid.sc_file->fi_lo_recalls);
 	trace_nfsd_layout_recall(&ls->ls_stid.sc_stateid);
 
-	refcount_inc(&ls->ls_stid.sc_count);
-	nfsd4_run_cb(&ls->ls_recall);
-
+	if (!test_and_set_bit(NFSD4_CALLBACK_RUNNING, &ls->ls_recall.cb_flags)) {
+		refcount_inc(&ls->ls_stid.sc_count);
+		nfsd4_run_cb(&ls->ls_recall);
+	}
 out_unlock:
 	spin_unlock(&ls->ls_lock);
 }
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a4c7cab1679bd..e31268c2348ed 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1711,7 +1711,8 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *copy, __be32 nfserr)
 		      NFSPROC4_CLNT_CB_OFFLOAD);
 	trace_nfsd_cb_offload(copy->cp_clp, &cbo->co_res.cb_stateid,
 			      &cbo->co_fh, copy->cp_count, nfserr);
-	nfsd4_run_cb(&cbo->co_cb);
+	if (!test_and_set_bit(NFSD4_CALLBACK_RUNNING, &cbo->co_cb.cb_flags))
+		WARN_ON_ONCE(!nfsd4_run_cb(&cbo->co_cb));
 }
 
 /**
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c61e1a4ab620c..375d48e6093eb 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4942,6 +4942,10 @@ static const struct nfsd4_callback_ops nfsd4_cb_recall_ops = {
 static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 {
 	bool queued;
+
+	if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &dp->dl_recall.cb_flags))
+		return;
+
 	/*
 	 * We're assuming the state code never drops its reference
 	 * without first removing the lease.  Since we're in this lease
@@ -4952,8 +4956,10 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 	refcount_inc(&dp->dl_stid.sc_count);
 	queued = nfsd4_run_cb(&dp->dl_recall);
 	WARN_ON_ONCE(!queued);
-	if (!queued)
+	if (!queued) {
 		refcount_dec(&dp->dl_stid.sc_count);
+		clear_bit(NFSD4_CALLBACK_RUNNING, &dp->dl_recall.cb_flags);
+	}
 }
 
 /* Called from break_lease() with flc_lock held. */
@@ -6330,7 +6336,9 @@ deleg_reaper(struct nfsd_net *nn)
 		list_del_init(&clp->cl_ra_cblist);
 		clp->cl_ra->ra_keep = 0;
 		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG);
-		nfsd4_run_cb(&clp->cl_ra->ra_cb);
+		if (!test_and_set_bit(NFSD4_CALLBACK_RUNNING,
+				      &clp->cl_ra->ra_cb.cb_flags))
+			WARN_ON_ONCE(!nfsd4_run_cb(&clp->cl_ra->ra_cb));
 	}
 }
 
@@ -7221,7 +7229,9 @@ nfsd4_lm_notify(struct file_lock *fl)
 
 	if (queue) {
 		trace_nfsd_cb_notify_lock(lo, nbl);
-		nfsd4_run_cb(&nbl->nbl_cb);
+		if (!test_and_set_bit(NFSD4_CALLBACK_RUNNING,
+				      &nbl->nbl_cb.cb_flags))
+			WARN_ON_ONCE(!nfsd4_run_cb(&nbl->nbl_cb));
 	}
 }
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 53298bdcfb3d0..d2134782b4021 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -67,6 +67,8 @@ typedef struct {
 struct nfsd4_callback {
 	struct nfs4_client *cb_clp;
 	struct rpc_message cb_msg;
+#define NFSD4_CALLBACK_RUNNING		(0)
+	unsigned long cb_flags;
 	const struct nfsd4_callback_ops *cb_ops;
 	struct work_struct cb_work;
 	int cb_seq_status;
-- 
2.53.0

