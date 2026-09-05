Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F121539E16C
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638731; cv=none; b=FPhDfwFpHEsH+IXVcDUx4MGXt5QWSbI3Fgu7sJBhp6XNsac1mTgzT9D0gF5FJsjBD+/yb0wCikq4MqqN6gf2JXPFE+lH1x/rRWjmgHaCBOv5Nwd99sLIh8SkFUW+2+uTb65SQKly0ufyiCIdWE3CDOKkn1oA2l6tsbKsKS/xiMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638731; c=relaxed/simple;
	bh=c55Cux58DGzMzdOTQ7C5BCle96Gj2AAO2ep2zu3m68E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AK+OITQbcrM1ZsG2wc0cbJPzrTH53y0zmI1CGNQz3egSQ3vK5j4m5dyoTvvkl4Ha3FkV5aE1wMW2ZwZx2//bn4IOcaMYmcUIYppEjZj6JY4TFSl/y1r2lK2JGzzQtv7kMDGzJKjnffUQ0ZwecrM+61Ul9lfC0B+bXeoTgwqOiIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N762iUvx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N762iUvx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186E31F00A3A;
	Sat,  5 Sep 2026 20:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788638729;
	bh=ff1hsm2fditJXJEhq6YCJJ+kZwNXG13YnfxlmdDRawk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N762iUvxavwuCCuOPyX+HhhUTSj8MO/EqzRkdbq71/Vmv8VMbtAZ02IyyOjipWY4W
	 DVO4ex+/NrSBH8vHGbM9T/4hJDnpHVePAJWSucYCi6pJw5NpB0B5uMS0EAthc7ixxA
	 mwJ8ScxEQ1i9c3+rhH9EN5l5rg86OR7a1S47OuuowRCO0pwarUTHttuRY2Pyg4Wl5p
	 DWXAXScMIlag1J7O7PlNrQ/WcaAAF1PqvMD6hGV+n8A5m4uAeiw180IpKOoskWuuzf
	 soQSC3Ah1cDW40MTqfCusnIhWeoK/fhLirqJ885+2vp1mO7egk134XEpujQz3NC0iG
	 cF228sk2grSZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/7] nfsd: prepare nfsd4_cb_sequence_done() for error handling rework
Date: Sat,  5 Sep 2026 16:05:21 -0400
Message-ID: <20260905200527.607284-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090302-liquefy-backrest-fcbf@gregkh>
References: <2026090302-liquefy-backrest-fcbf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 1c2d0957dc66620338eba63e0267122b6e2175cc ]

There is only one case where we want to proceed with processing the rest
of the CB_COMPOUND, and that's when the cb_seq_status is 0. Make the
default return value be false, and only set it to true in that case.

Rename the "need_restart" label to "requeue", to better indicate that
it's being requeued to the workqueue.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 01c5d5f58a5d ("nfsd: RCU-protect cl_cb_session to fix use-after-free on session teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4callback.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index d47173d98eef7..d026fb1f4ac4f 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1157,11 +1157,12 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 	rpc_call_start(task);
 }
 
+/* Returns true if CB_COMPOUND processing should continue */
 static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
 	struct nfsd4_session *session = clp->cl_cb_session;
-	bool ret = true;
+	bool ret = false;
 
 	if (!clp->cl_minorversion) {
 		/*
@@ -1174,13 +1175,13 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 * handle that case here.
 		 */
 		if (RPC_SIGNALLED(task))
-			goto need_restart;
+			goto requeue;
 
 		return true;
 	}
 
 	if (!cb->cb_holds_slot)
-		goto need_restart;
+		goto requeue;
 
 	switch (cb->cb_seq_status) {
 	case 0:
@@ -1192,6 +1193,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		 * (sequence ID, cached reply) MUST NOT change.
 		 */
 		++session->se_cb_seq_nr;
+		ret = true;
 		break;
 	case -ESERVERFAULT:
 		++session->se_cb_seq_nr;
@@ -1199,13 +1201,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	case 1:
 	case -NFS4ERR_BADSESSION:
 		nfsd4_mark_cb_fault(cb->cb_clp, cb->cb_seq_status);
-		ret = false;
 		break;
 	case -NFS4ERR_DELAY:
 		cb->cb_seq_status = 1;
 		if (!rpc_restart_call(task))
 			goto out;
-
 		rpc_delay(task, 2 * HZ);
 		return false;
 	case -NFS4ERR_BADSLOT:
@@ -1227,14 +1227,13 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		clp->cl_cb_session->se_cb_seq_nr);
 
 	if (RPC_SIGNALLED(task))
-		goto need_restart;
+		goto requeue;
 out:
 	return ret;
 retry_nowait:
-	if (rpc_restart_call_prepare(task))
-		ret = false;
+	rpc_restart_call_prepare(task);
 	goto out;
-need_restart:
+requeue:
 	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
 		task->tk_status = 0;
 		cb->cb_need_restart = true;
-- 
2.53.0

