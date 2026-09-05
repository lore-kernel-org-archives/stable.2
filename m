Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8677039A04C
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638734; cv=none; b=F+LVpYiGR2FS4Zc5RkgZNYGUcgcGWO2dqv+IcIgoyhCWhKrXpdtl20xn0CI1qQeH9QisWcclCSs0/0MBXCpWCUNh/iqQQHqCQ2Wp0oP1NrCug9coge0T8YjWfR0ufK0lBIfiDYIk64H4rMkAWzDs3CTWyFO+dMhuQKf9g3lPnns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638734; c=relaxed/simple;
	bh=/CNd8WLi2PqHMH2V4/ExxEWvTgX070gPmlCxLaLx70s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCVIy6t9KxcEMyuR2FGgtCziEqfdFx5aU9TlUv0Q/3O5hd1e8JyujHeyN0ElI4gDGlvxEUQC4/zbDBm/vr1k27HNbKMEVlwnf65gMQxxu9zckY2zjiKLjRfmcD2JsliUb604s3Jacrurg7YAM7s0LiwIr9heGdh5xI60uEJmQ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mf+TqPAK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mf+TqPAK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1D41F00A3E;
	Sat,  5 Sep 2026 20:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788638733;
	bh=ryHHyFE2uJyRZyk5dMLiBiKPpzh0zDWnqb/DVAjxh0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mf+TqPAKXBM11XhCDGuQSlmoOpKUsjkve1uSE07Jv/v+eFTcBmt5vTunZxeWS7hS7
	 Qeyw4D5DAzf0UYyupyYCFPXoZpW1aHEkN62uO49nNZBEgu5//E2Y0LnLTeWXD/nU7j
	 rqqL3gsYcGPjtpZENVchj1Z7RZ1CCobhEihkQ8xt7ChH7huwYy/NRwHwT9K1i1RGyl
	 ZBCKAYVPHn3vUilybceExBtQDyUoA48jPf8ems23AK/cM7K2p2ZHWpNPgnZvbgS9uK
	 /z5BTcSqBAMZ9IaJ0/SdY8jqd6BYYMpl6GjrofUUvYpQENiFj3A9BCnQQvDSv9DE1L
	 5ezPzdbqRkD3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 6/7] nfsd: move cb_need_restart flag into cb_flags
Date: Sat,  5 Sep 2026 16:05:26 -0400
Message-ID: <20260905200527.607284-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905200527.607284-1-sashal@kernel.org>
References: <2026090302-liquefy-backrest-fcbf@gregkh>
 <20260905200527.607284-1-sashal@kernel.org>
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
index 5242b944d7560..dcb4f8785ec01 100644
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
index e8f68c84394df..848ef26c20705 100644
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

