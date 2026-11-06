Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793932751;
	b=mqxHRdOYOAFsCgWLq6Bs8CZrH9tha9sJNT4WhVLJ59LdsAbFEPkMXcUL89oECA9Pb8nv
	 gAOeiKYS4ZkYrA/2bfbEzIrr5zW7DvG9ZJ1usQVkbad+l+ui7BMgYDUijdnJHyIE7lrj8
	 2jEU9/2lOdL14JPHe6cKjll7iwpnybI5qP4IDO1iNdwEq/JB21efApOYg3qrjvSeKH9Z/
	 fdHqKyHMD86NiO/219NeNWtDT07ACje3VDVBamDzjgu9N1yunCBRetIX67BiawJERI345
	 0UW1DAo3zAqTJL79WFpjNdMaH2oWGSpgUI8kNO5hGTvANUCkR1WI3AMHiIn8fb2pz7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932751;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5aKpP21W03Tb+uPXziUpCmi7dO4l5HwESrCrETv3Vis=;
	b=sw2uJOZWthxVEIM0UhKMhzKAHTUeEHoQkG4Ua6LU2gJKqCgTU6QVdD/74t+OaNtVdICq
	 mzcN6Kz3lYVZuTX+Kk+7dsxT0E+MUBVfe/wQ8gys3qtZ4hOrrr8Hr/nl4mYu02IcNrcOJ
	 LUSNcc3t2UgAOu9SwifcAPeQR3Nn9ImQtJPjrITPtUotLt9lf63C1bG1Ndb1FQh68WYRi
	 KS5w+URNVh+wfQIlzxwFefcSQuNVhnoSFvXvCtiyHZ5+XXe9GwYX/m/QruxvMXFXOqOuJ
	 qumowL+yWlCtA98nk3O+thFHCUMJzX3/yCIKSGqg2nMYR9eSERcBOt/VCDSm7WUU3cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a63jOwuE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8953D606A328
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a63jOwuE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E173B1F0089F;
	Fri,  6 Nov 2026 02:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793932751;
	bh=5aKpP21W03Tb+uPXziUpCmi7dO4l5HwESrCrETv3Vis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a63jOwuESvH4P22WdkVy7g7neiO0KzK8RMS8QSPdQpLGsWjRfViPjheCCFRW/Udp7
	 17Cny20SpFfZxSy6JTC0jAukrlLz+oNoohZVk3xdSWp95qBnPUWPm/oFyDc2bRDwNc
	 saN+qB8r2hwzDr/znBgObaIHN8JGEkX7MUNvAh5FYpgP2E/2TRKVOx+wD+vg6ZYwjD
	 BfI3ZOAjfqwXrtDtO75fmBMCUIQ81wq7KmAD7xrLomJMoPl34gkezxJ24hpWXqrK0L
	 3KZXBzePOtHJ88I9oqVycDMshPZKfvelDS3/XMMAGqUJ49PRTvdxvbVgMSdzdPBGwL
	 UBUARHqj4Uo/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] nfsd: prevent callback tasks running concurrently
Date: Thu,  5 Nov 2026 21:39:05 -0500
Message-ID: <20261106022849.3786687-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110416-cleat-grapple-d472@gregkh>
References: <2026110416-cleat-grapple-d472@gregkh>
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
Stable-dep-of: 9af39c0773ef ("NFSD: Send a meaningful CB_RECALL_ANY keep count")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4callback.c |  2 ++
 fs/nfsd/nfs4layouts.c  |  7 ++++---
 fs/nfsd/nfs4proc.c     |  2 +-
 fs/nfsd/nfs4state.c    | 14 ++++++++++----
 fs/nfsd/state.h        |  9 +++++++++
 5 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 798fcc9c40926..47cfd4bd4ecc4 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1227,6 +1227,7 @@ static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
 
 	trace_nfsd_cb_destroy(clp, cb);
 	nfsd41_cb_release_slot(cb);
+	clear_bit(NFSD4_CALLBACK_RUNNING, &cb->cb_flags);
 	if (cb->cb_ops && cb->cb_ops->release)
 		cb->cb_ops->release(cb);
 	nfsd41_cb_inflight_end(clp);
@@ -1575,6 +1576,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 	cb->cb_msg.rpc_proc = &nfs4_cb_procedures[op];
 	cb->cb_msg.rpc_argp = cb;
 	cb->cb_msg.rpc_resp = cb;
+	cb->cb_flags = 0;
 	cb->cb_ops = ops;
 	INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
 	cb->cb_status = 0;
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 0ff8994752637..357aef792e99a 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -347,9 +347,10 @@ nfsd4_recall_file_layout(struct nfs4_layout_stateid *ls)
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
index 53ded5de593a8..4825be4dc6467 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1769,7 +1769,7 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
 		      NFSPROC4_CLNT_CB_OFFLOAD);
 	trace_nfsd_cb_offload(copy->cp_clp, &cbo->co_res.cb_stateid,
 			      &cbo->co_fh, copy->cp_count, copy->nfserr);
-	nfsd4_run_cb(&cbo->co_cb);
+	nfsd4_try_run_cb(&cbo->co_cb);
 }
 
 /**
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 723a1ae688366..2188c15d3ec6c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3303,8 +3303,10 @@ static void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
 	/* set to proper status when nfsd4_cb_getattr_done runs */
 	ncf->ncf_cb_status = NFS4ERR_IO;
 
-	refcount_inc(&dp->dl_stid.sc_count);
-	nfsd4_run_cb(&ncf->ncf_getattr);
+	if (!test_and_set_bit(NFSD4_CALLBACK_RUNNING, &ncf->ncf_getattr.cb_flags)) {
+		refcount_inc(&dp->dl_stid.sc_count);
+		nfsd4_run_cb(&ncf->ncf_getattr);
+	}
 }
 
 static struct nfs4_client *create_client(struct xdr_netobj name,
@@ -5477,6 +5479,10 @@ static const struct nfsd4_callback_ops nfsd4_cb_recall_ops = {
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
@@ -7036,7 +7042,7 @@ deleg_reaper(struct nfsd_net *nn)
 		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
 						BIT(RCA4_TYPE_MASK_WDATA_DLG);
 		trace_nfsd_cb_recall_any(clp->cl_ra);
-		nfsd4_run_cb(&clp->cl_ra->ra_cb);
+		nfsd4_try_run_cb(&clp->cl_ra->ra_cb);
 	}
 }
 
@@ -7977,7 +7983,7 @@ nfsd4_lm_notify(struct file_lock *fl)
 
 	if (queue) {
 		trace_nfsd_cb_notify_lock(lo, nbl);
-		nfsd4_run_cb(&nbl->nbl_cb);
+		nfsd4_try_run_cb(&nbl->nbl_cb);
 	}
 }
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index f39a425639b07..e4c3e5907db15 100644
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
@@ -748,6 +750,13 @@ extern void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *
 extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 		const struct nfsd4_callback_ops *ops, enum nfsd4_cb_op op);
 extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
+
+static inline void nfsd4_try_run_cb(struct nfsd4_callback *cb)
+{
+	if (!test_and_set_bit(NFSD4_CALLBACK_RUNNING, &cb->cb_flags))
+		WARN_ON_ONCE(!nfsd4_run_cb(cb));
+}
+
 extern void nfsd4_shutdown_callback(struct nfs4_client *);
 extern void nfsd4_shutdown_copy(struct nfs4_client *clp);
 extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name,
-- 
2.53.0

