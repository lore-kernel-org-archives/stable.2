Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F85E363C50
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788660819; cv=none; b=EnRdSGX/EzdVCuh/QSMTllnCOoZYKZTIS+QlVRMOxJgzy/q/gcwX6pd3F3xFZKh9S2sbA4Q15NV3QQDHvyekfJD1EvqNUjsfLdvZqeDeOAj4+hK+S7N8c9ZyPHBc4qH3LSsaNI1sedYnvoBADYX5t0fe4za9SQ1o78NVbtwfpLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788660819; c=relaxed/simple;
	bh=erD0YUDs/Ptto/x93uanqHfgriNUS/2XrMSeczlWsP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wfv71EyICynab13izuFeEkMkYJhP1kpPJy6M6QGC80GF5BXZjhxJlPx6Q4vuUwXqpxHcIzuEtfgixjDU2S8XcumZpxc0+rkIC0n1i7PbANJlhYu1hg1G3Sef19BSA/Zo0oICZugDvpuzk7vmtFzunybRIX2dGTRG163QKeXNvqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTH6ZHEW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTH6ZHEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90FA1F00ADE;
	Sun,  6 Sep 2026 02:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788660806;
	bh=GgLLqVuqMhm6bA4yNQWWq257sm6ZpujglYN8vTOjoy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oTH6ZHEW2FvktjdtnW9H1ecd32X/Azkjr5cH+NYqccxghLYjGihEflFTV28g6BE6h
	 pJhRdemYgIIX4X7ArksgUKAA072NsmTkztOLJIVTSyLZSQUg/9bAfHUZ8R6KOs0FbG
	 jTkK2sgmHcpSxaYdMz6QznEJ1NMGFpQHkrh6DI34uuPvNA1PyHL5RMvvZpPBxCC4f0
	 3OUmUwvWBUWu4S8qE4iBwzQDn9DrZcLQZgyCjIYGkbvyuYWUCJ/EvgG7RQh8vcK2Q5
	 TuUsELDMQvPJ9ARKGGp64Az4LldzvK50YHxeJV4/yLeWFnhSfPVVrAPY1d6ldOIWAJ
	 qXAC1YxZIP6Kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/7] nfsd: prevent callback tasks running concurrently
Date: Sat,  5 Sep 2026 22:13:19 -0400
Message-ID: <20260906021321.760525-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906021321.760525-1-sashal@kernel.org>
References: <2026090303-scrap-parkway-2bf7@gregkh>
 <20260906021321.760525-1-sashal@kernel.org>
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
index 7a85817fa5bfe..250c122ed507a 100644
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
index e6c0b1520973e..e1350dcc1b64a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4946,6 +4946,10 @@ static const struct nfsd4_callback_ops nfsd4_cb_recall_ops = {
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
@@ -6335,7 +6339,9 @@ deleg_reaper(struct nfsd_net *nn)
 		clp->cl_ra->ra_keep = 0;
 		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG);
 		trace_nfsd_cb_recall_any(clp->cl_ra);
-		nfsd4_run_cb(&clp->cl_ra->ra_cb);
+		if (!test_and_set_bit(NFSD4_CALLBACK_RUNNING,
+				      &clp->cl_ra->ra_cb.cb_flags))
+			WARN_ON_ONCE(!nfsd4_run_cb(&clp->cl_ra->ra_cb));
 	}
 }
 
@@ -7212,7 +7218,9 @@ nfsd4_lm_notify(struct file_lock *fl)
 
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

