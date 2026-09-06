Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC044503B
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701316; cv=none; b=SLWmzy9LJ1eHKeO99lc3nFVVTFNeYptA6ZGUYZ9WomptnkcOhE7RQoeiFoYqZVWlvqNqam7V3jfLScfM3M6O9yeql9+h6WK51KJ/1tmObm5+co9TPAdcUVatuWI5tpxMqn3aTr2dsEtQZnmGh2qc3+yAUklZE6u5ReV7fLgSnhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701316; c=relaxed/simple;
	bh=eFceAp/wRxNyITgKPjKiGlJSHB4Lrh8Li0HsAj2x31I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crxQTVkIg2NzbS6o1dcObC8ym6fOnrpRuiLh/B3CCgDl7tMpTQqcYtTOwbGrHFFgSoIjkUilQSs9K4rgxRZGumEc4/O3HJq7PolGdnh6NXoGNOwrrAxagsNJhmnM6TWzTN/PrkK+JoanoEL1kyu+1Eq1gRDQKwVPcjw+KG4IbmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiJZwmO3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiJZwmO3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B2B1F00A3F;
	Sun,  6 Sep 2026 13:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701315;
	bh=nFLOPTipeqls110yjcvYwDvFfriWLSFljxmKg15+sz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kiJZwmO3AQAWe3UplgOy1MU4tnO659Dd/WTZlixXT5U8IZN6PCLb5QbnW2cqvxesI
	 ICX0E/EIrrUCsbZATMdGC9rpdlNFUjXSvN/jn/xoumpuFVE4FD+z6aWom7APy9jNj4
	 xPJ5uhz50y/lwncwqrEo0xPwHk4mjVZGo5Zzht63aYJzxuxZnr9of2awcEu4YCe7rS
	 KWcv2N6joQCdYkTL6nV2Mt2u732+Cz9ZnqqLOrMt6FJvaqqvo34d3WF9dKOKt2FkJx
	 T2als9tbW35v9PlXiAwLHs/ZF2D9MaDCw5nUxNy7VdXivKMyfmoSmI/EHZAYiBzVWb
	 YY30Q8V022uZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/7] nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()
Date: Sun,  6 Sep 2026 09:28:26 -0400
Message-ID: <20260906132831.874344-2-sashal@kernel.org>
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

[ Upstream commit 6c1cefb84b3dee08e94b6908617f23f3fcc045e9 ]

It's a bit strange to call nfsd4_cb_sequence_done() on a callback with no
CB_SEQUENCE. Lift the handling of restarting a call into a new helper,
and move the handling of NFSv4.0 into nfsd4_cb_done().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 01c5d5f58a5d ("nfsd: RCU-protect cl_cb_session to fix use-after-free on session teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4callback.c | 52 +++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 8f296543880f6..f256d0230629f 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -914,6 +914,17 @@ static bool nfsd4_queue_cb(struct nfsd4_callback *cb)
 	return queue_work(callback_wq, &cb->cb_work);
 }
 
+#define nfsd4_requeue_cb(task, cb) \
+	do { \
+		struct rpc_task *__task = (task); \
+		struct nfsd4_callback *__cb = (cb); \
+		struct nfs4_client *__clp = __cb->cb_clp; \
+		if (!test_bit(NFSD4_CLIENT_CB_KILL, &__clp->cl_flags)) { \
+			__task->tk_status = 0; \
+			__cb->cb_need_restart = true; \
+		} \
+	} while (0)
+
 static void nfsd41_cb_inflight_begin(struct nfs4_client *clp)
 {
 	atomic_inc(&clp->cl_cb_inflight);
@@ -1160,26 +1171,9 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
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
 
@@ -1225,7 +1219,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 
 	nfsd41_cb_release_slot(cb);
 	dprintk("%s: freed slot, new seqid=%d\n", __func__,
-		clp->cl_cb_session->se_cb_seq_nr);
+		session->se_cb_seq_nr);
 
 	if (RPC_SIGNALLED(task))
 		goto requeue;
@@ -1235,10 +1229,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
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
 
@@ -1247,8 +1238,21 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
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

