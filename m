Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83DE37DAD7
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788644619; cv=none; b=Cpz2C/kOrhwd/axtnI78fJdJujIA5hoyzIRp+3gp9r1+J7OPiYDVlOuFDQQoIPewW/b1qoL1vPoN0AVDhl9TWMoFW4nDCQLCY5rPowQwkeONfPPuzAlRcId2PhZxqc6u4UuMzLMUCv0MTDzlCk+tLj5TQjKM38QczUfT3dDoHz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788644619; c=relaxed/simple;
	bh=j4tf8x2l5SXOaGdaENmKH3UaD6CDNS+yLotNosI22Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/7RLJUfXLKNGXMB7krY9YCMqkXiu23f4WFb+KK6vFVkq3d/XR9f8ySYz7JZky96x0NIpkpFtn/augkeGB1tpbhVMZU7Xn/FfRqmMMvd7cJNcYuhRYoteftAMIZWXYu9/FdJ8wcdJ+1QzLPfldM5GpqV5+imXECUSivzHoRX8LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4+95s+U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4+95s+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AB01F00AC4;
	Sat,  5 Sep 2026 21:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788644617;
	bh=n7nE1h9j4qO4w43T5KLhv5j/28JZ2Wpk0O/WVpozi40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C4+95s+UPoKF2eodBiDNLSUJF5dVBsLB0mRVl/ByXEK61FxiA8D320NsXUWJ5qmx6
	 WxNNmIRpIgYEHrvffCffgFtKK6aZynhGcTXs4thOJ3GCgBkugppoQwal2mqVEiw8gF
	 rDmWPlgFgB+fRRzPgbaAm9Z0jIJwQKJONMhgwM/KCvpj6Ldw0vOpz2jXHVh3StkrsR
	 /qRAceUkfZOxe6xraQZ9x1wZf/BoW4kkUTrUCbuvwv47ij03nispxvKV5+5w5gLeXa
	 ptwnVxNw1ZxttAGdk0LpLpgGbogoc7iTZ3cRC2MQq7wCVwJxuZojSbeQedFcmfb1zs
	 Lc+rY5+SK2XFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/7] nfsd: prevent callback tasks running concurrently
Date: Sat,  5 Sep 2026 17:43:30 -0400
Message-ID: <20260905214332.701369-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905214332.701369-1-sashal@kernel.org>
References: <2026090302-gulf-kilometer-60be@gregkh>
 <20260905214332.701369-1-sashal@kernel.org>
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
 fs/nfsd/nfs4callback.c | 36 +++++++++++++-----------------------
 fs/nfsd/nfs4layouts.c  |  7 ++++---
 fs/nfsd/nfs4proc.c     |  3 ++-
 fs/nfsd/nfs4state.c    | 12 ++++++++++--
 fs/nfsd/state.h        |  2 ++
 5 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index c918fd3452f31..138fa901837eb 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -914,16 +914,6 @@ static bool nfsd4_queue_cb(struct nfsd4_callback *cb)
 	return queue_work(callback_wq, &cb->cb_work);
 }
 
-static void nfsd4_requeue_cb(struct rpc_task *task, struct nfsd4_callback *cb)
-{
-	struct nfs4_client *clp = cb->cb_clp;
-
-	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
-		task->tk_status = 0;
-		cb->cb_need_restart = true;
-	}
-}
-
 static void nfsd41_cb_inflight_begin(struct nfs4_client *clp)
 {
 	atomic_inc(&clp->cl_cb_inflight);
@@ -1141,6 +1131,7 @@ static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
 	struct nfs4_client *clp = cb->cb_clp;
 
 	nfsd41_cb_release_slot(cb);
+	clear_bit(NFSD4_CALLBACK_RUNNING, &cb->cb_flags);
 	if (cb->cb_ops && cb->cb_ops->release)
 		cb->cb_ops->release(cb);
 	nfsd41_cb_inflight_end(clp);
@@ -1170,7 +1161,8 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 /* Returns true if CB_COMPOUND processing should continue */
 static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
 {
-	struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
+	struct nfs4_client *clp = cb->cb_clp;
+	struct nfsd4_session *session = clp->cl_cb_session;
 	bool ret = false;
 
 	if (!cb->cb_holds_slot)
@@ -1202,13 +1194,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
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
@@ -1223,8 +1208,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	}
 
 	nfsd41_cb_release_slot(cb);
-	dprintk("%s: freed slot, new seqid=%d\n", __func__,
-		session->se_cb_seq_nr);
 	return ret;
 retry_nowait:
 	/*
@@ -1236,7 +1219,10 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 			return false;
 	}
 requeue:
-	nfsd4_requeue_cb(task, cb);
+	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
+		task->tk_status = 0;
+		cb->cb_need_restart = true;
+	}
 	return false;
 }
 
@@ -1255,8 +1241,11 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 		 * the submission code will error out, so we don't need to
 		 * handle that case here.
 		 */
-		if (RPC_SIGNALLED(task))
-			nfsd4_requeue_cb(task, cb);
+		if (RPC_SIGNALLED(task) &&
+		    !test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
+			task->tk_status = 0;
+			cb->cb_need_restart = true;
+		}
 	} else if (!nfsd4_cb_sequence_done(task, cb)) {
 		return;
 	}
@@ -1452,6 +1441,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 	cb->cb_msg.rpc_proc = &nfs4_cb_procedures[op];
 	cb->cb_msg.rpc_argp = cb;
 	cb->cb_msg.rpc_resp = cb;
+	cb->cb_flags = 0;
 	cb->cb_ops = ops;
 	INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
 	cb->cb_seq_status = 1;
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 84bb200e24ade..cd5b0dfc3e8e4 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -327,9 +327,10 @@ nfsd4_recall_file_layout(struct nfs4_layout_stateid *ls)
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
index d29a37f696a44..3f8bf98a4b22b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1710,7 +1710,8 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *copy, __be32 nfserr)
 		      NFSPROC4_CLNT_CB_OFFLOAD);
 	trace_nfsd_cb_offload(copy->cp_clp, &cbo->co_res.cb_stateid,
 			      &cbo->co_fh, copy->cp_count, nfserr);
-	nfsd4_run_cb(&cbo->co_cb);
+	if (!test_and_set_bit(NFSD4_CALLBACK_RUNNING, &cbo->co_cb.cb_flags))
+		WARN_ON_ONCE(!nfsd4_run_cb(&cbo->co_cb));
 }
 
 /**
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f390716ce3ffe..2d433b9742fd5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4945,6 +4945,10 @@ static const struct nfsd4_callback_ops nfsd4_cb_recall_ops = {
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
@@ -6334,7 +6338,9 @@ deleg_reaper(struct nfsd_net *nn)
 		clp->cl_ra->ra_keep = 0;
 		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG);
 		trace_nfsd_cb_recall_any(clp->cl_ra);
-		nfsd4_run_cb(&clp->cl_ra->ra_cb);
+		if (!test_and_set_bit(NFSD4_CALLBACK_RUNNING,
+				      &clp->cl_ra->ra_cb.cb_flags))
+			WARN_ON_ONCE(!nfsd4_run_cb(&clp->cl_ra->ra_cb));
 	}
 }
 
@@ -7211,7 +7217,9 @@ nfsd4_lm_notify(struct file_lock *fl)
 
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

