Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BABA3845B0
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 02:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788660814; cv=none; b=rHKma5yVkx+A5AU2Kuvy4BRJsRUAVKWm2NvfkZYQ0JJlxnBYOjhNFsndwFTgeoD6dU/DLOJo4iqvN89IjTBaoV7vfEt0HhWMl1/wZ7pNb5Fobb9s1wmLMBY2poEIrHjIGKfebXDHzbl5GZSsYCl2AAufOMtFOpFGpzVh5Ljr1dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788660814; c=relaxed/simple;
	bh=dOlqVYQrLGyIg7AO3ngS2hN6q5KpFPdX6NH82MpyhL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bi0TfoNe3MREz3wXKNUUJSpELPOeERDC/TLjHAybAq+q3SZoQvkiY2KJJEVbYiSJlJfh9ghHnpOW9tJioFU55f1qRmLpVMSOHodhFhUeI++vkJANdoo37jU4iQOmoaEdqXbb4gYNh+CvCmj+V0Y6zsnVqR3YbgUCYPpbLg9/0cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDYi+Hw1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDYi+Hw1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C70D1F00A3F;
	Sun,  6 Sep 2026 02:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788660804;
	bh=mL4soKRg+7pGGuS9mSUkoTSXklSxwIkDjCkZfN4HIP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FDYi+Hw1N/Js739Q9ixrjNm4OmHZGJzH7Yxh/j78iFB+wxNuipB35mL/s5XItq0Lr
	 Yecosr2ngWt4nM1JVLsVoSmlDYlZ+jS5ctAmJK8I8jNnqlnA+rEpnGdOID5JiJoNPW
	 Mqeyx2p1brjsfhgB48Qx2zzCtYqNukmpAeuS9glfOQhAQhfExfqhnStmkznbkHVldo
	 3dsBhpfsmLrI9wYMwAiXN4V4YRE4AaTWnDWDtLEO8d0UpA/g5pVowN0roBazIdCgas
	 u9Dlmo1ZDYK3hCoBp5BaTOKCq08iwY8GA7OYWiuDAXFqU9PKjOY82IPXRw6Fk49UJE
	 VMkvqIKag2Z2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/7] nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()
Date: Sat,  5 Sep 2026 22:13:16 -0400
Message-ID: <20260906021321.760525-2-sashal@kernel.org>
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

[ Upstream commit 6c1cefb84b3dee08e94b6908617f23f3fcc045e9 ]

It's a bit strange to call nfsd4_cb_sequence_done() on a callback with no
CB_SEQUENCE. Lift the handling of restarting a call into a new helper,
and move the handling of NFSv4.0 into nfsd4_cb_done().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 01c5d5f58a5d ("nfsd: RCU-protect cl_cb_session to fix use-after-free on session teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4callback.c | 51 ++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index f9c28ba1d986b..7333068371c14 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -914,6 +914,16 @@ static bool nfsd4_queue_cb(struct nfsd4_callback *cb)
 	return queue_work(callback_wq, &cb->cb_work);
 }
 
+static void nfsd4_requeue_cb(struct rpc_task *task, struct nfsd4_callback *cb)
+{
+	struct nfs4_client *clp = cb->cb_clp;
+
+	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
+		task->tk_status = 0;
+		cb->cb_need_restart = true;
+	}
+}
+
 static void nfsd41_cb_inflight_begin(struct nfs4_client *clp)
 {
 	atomic_inc(&clp->cl_cb_inflight);
@@ -1160,26 +1170,9 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 /* Returns true if CB_COMPOUND processing should continue */
 static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
 {
-	struct nfs4_client *clp = cb->cb_clp;
-	struct nfsd4_session *session = clp->cl_cb_session;
+	struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
 	bool ret = false;
 
-	if (!clp->cl_minorversion) {
-		/*
-		 * If the backchannel connection was shut down while this
-		 * task was queued, we need to resubmit it after setting up
-		 * a new backchannel connection.
-		 *
-		 * Note that if we lost our callback connection permanently
-		 * the submission code will error out, so we don't need to
-		 * handle that case here.
-		 */
-		if (RPC_SIGNALLED(task))
-			goto requeue;
-
-		return true;
-	}
-
 	if (!cb->cb_holds_slot)
 		goto requeue;
 
@@ -1224,7 +1217,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 
 	nfsd41_cb_release_slot(cb);
 	dprintk("%s: freed slot, new seqid=%d\n", __func__,
-		clp->cl_cb_session->se_cb_seq_nr);
+		session->se_cb_seq_nr);
 
 	if (RPC_SIGNALLED(task))
 		goto requeue;
@@ -1234,10 +1227,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	rpc_restart_call_prepare(task);
 	goto out;
 requeue:
-	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
-		task->tk_status = 0;
-		cb->cb_need_restart = true;
-	}
+	nfsd4_requeue_cb(task, cb);
 	return false;
 }
 
@@ -1246,8 +1236,21 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 	struct nfsd4_callback *cb = calldata;
 	struct nfs4_client *clp = cb->cb_clp;
 
-	if (!nfsd4_cb_sequence_done(task, cb))
+	if (!clp->cl_minorversion) {
+		/*
+		 * If the backchannel connection was shut down while this
+		 * task was queued, we need to resubmit it after setting up
+		 * a new backchannel connection.
+		 *
+		 * Note that if we lost our callback connection permanently
+		 * the submission code will error out, so we don't need to
+		 * handle that case here.
+		 */
+		if (RPC_SIGNALLED(task))
+			nfsd4_requeue_cb(task, cb);
+	} else if (!nfsd4_cb_sequence_done(task, cb)) {
 		return;
+	}
 
 	if (cb->cb_status) {
 		WARN_ON_ONCE(task->tk_status);
-- 
2.53.0

