Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12BE399CE9
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788644619; cv=none; b=ca4PDpgvttLUhTI9SgGDVRNsNXHAaENcJxlwDLXK9bQjZHw7XM7gyQwrQNrXH5tqVr7Fm+mxg/13F10mn3c+DvId8PaJBa59bvfhzT/ZvdiNG3rZb81JTUD+NEhIkHRtd3dzc5QSITX2mu31erorP6v23IXQqAeLYpC7ESB4Ig8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788644619; c=relaxed/simple;
	bh=W6W+IikPJUQRVy/8P3o0sFnavFKGteFQlzaX1u6pA3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKsM0eIi9fHEkIUU+33lVQ7WcQa/4u8AoPdvS3G6MmJpu450NFEwMwu1QOxCGX+uY30mbVGLR9LctGv2aZbnDSSG7b3P+LQqIatX3LYeHLMeTgTpE9RAj0ePlfkT9NAwneg+3tvWiqNW3SNAlk0R+KHr9thjZohiuxo/MTyp81o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eu1fMRjf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eu1fMRjf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AC31F00A3F;
	Sat,  5 Sep 2026 21:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788644618;
	bh=ssHWot5a5Eu5LY6R+4k3bfgn4ouEe//IOsdv6Dnvoh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Eu1fMRjfoVroaw+Y37zcAiii97V8Vd5kVjESURRnCBUKYdJT71gzCxichQZFnfBwF
	 8FWm0qtXgVgruSwXLKN7R1rcTdv1X0V/vt/3X3OQLCxHBbMjsfCIKPkQIlfhGarQB9
	 uKWFkHZXBj/anSmtvwGiYp1BvWPHOqQ1gMwLqCSilsWzQ159M7lRU3OQ4B6NvKkgEB
	 m8iyBtJe49PZ3ZG5ROaivXzg/X4WdQ/PE3mkYU/k5h7ZvSaWSCeWUKedWfK9hNBJqB
	 ceM3v7Vn+hb2NVK69Jbn5Y7hTq1N2Oxt0vmJdADEc/jZPczWZOuzyjAPl2LC5gelar
	 s4Es1undBQtMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 6/7] nfsd: move cb_need_restart flag into cb_flags
Date: Sat,  5 Sep 2026 17:43:31 -0400
Message-ID: <20260905214332.701369-6-sashal@kernel.org>
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

[ Upstream commit 32ce62c0f09cdc5a6b06bb38daec9b9a47302437 ]

Since there is now a cb_flags word, use a new NFSD4_CALLBACK_REQUEUE
flag in that instead of a separate boolean.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Since there is now a cb_flags word, use a new NFSD4_CALLBACK_REQUEUE flag in that instead of a separate boolean.

On this stable branch, callback requeue handling remains open-coded in both the NFSv4.1 sequence completion path and the NFSv4.0 completion path. Convert both sites to the flag and omit the callback lifetime tracepoint hunk, since that tracepoint is not present here.

[ sashal: Reduced backport -- upstream 32ce62c0f09cd touches 3 file(s), this
  backport carries 2. Not backported here:
  fs/nfsd/trace.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 01c5d5f58a5d ("nfsd: RCU-protect cl_cb_session to fix use-after-free on session teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4callback.c | 11 ++++-------
 fs/nfsd/state.h        |  2 +-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 138fa901837eb..964d7f56dfc79 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1221,7 +1221,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 requeue:
 	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
 		task->tk_status = 0;
-		cb->cb_need_restart = true;
+		set_bit(NFSD4_CALLBACK_REQUEUE, &cb->cb_flags);
 	}
 	return false;
 }
@@ -1244,7 +1244,7 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 		if (RPC_SIGNALLED(task) &&
 		    !test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
 			task->tk_status = 0;
-			cb->cb_need_restart = true;
+			set_bit(NFSD4_CALLBACK_REQUEUE, &cb->cb_flags);
 		}
 	} else if (!nfsd4_cb_sequence_done(task, cb)) {
 		return;
@@ -1277,7 +1277,7 @@ static void nfsd4_cb_release(void *calldata)
 {
 	struct nfsd4_callback *cb = calldata;
 
-	if (cb->cb_need_restart)
+	if (test_bit(NFSD4_CALLBACK_REQUEUE, &cb->cb_flags))
 		nfsd4_queue_cb(cb);
 	else
 		nfsd41_destroy_cb(cb);
@@ -1399,9 +1399,7 @@ nfsd4_run_cb_work(struct work_struct *work)
 	struct rpc_clnt *clnt;
 	int flags;
 
-	if (cb->cb_need_restart) {
-		cb->cb_need_restart = false;
-	} else {
+	if (!test_and_clear_bit(NFSD4_CALLBACK_REQUEUE, &cb->cb_flags)) {
 		if (cb->cb_ops && cb->cb_ops->prepare)
 			cb->cb_ops->prepare(cb);
 	}
@@ -1446,7 +1444,6 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 	INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
 	cb->cb_seq_status = 1;
 	cb->cb_status = 0;
-	cb->cb_need_restart = false;
 	cb->cb_holds_slot = false;
 }
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index d2134782b4021..10d1b418e0c7c 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -68,12 +68,12 @@ struct nfsd4_callback {
 	struct nfs4_client *cb_clp;
 	struct rpc_message cb_msg;
 #define NFSD4_CALLBACK_RUNNING		(0)
+#define NFSD4_CALLBACK_REQUEUE		(1)
 	unsigned long cb_flags;
 	const struct nfsd4_callback_ops *cb_ops;
 	struct work_struct cb_work;
 	int cb_seq_status;
 	int cb_status;
-	bool cb_need_restart;
 	bool cb_holds_slot;
 };
 
-- 
2.53.0

