Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DB03CFF4C
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701320; cv=none; b=OF82sQcEKnMqxbeEk1uNQA3UN3i8ETx0GaGGcVqqU/aQP22GJ3DlSaM1ZOEpZA0geP4s/0PmZ/zY/FZkkwIkKCACA9ZFYkHyhrrBnwJimkz5AoFfNDsu4w9okdWGDdKy3TunwGvK1Aorhve9oGnUALAk2Y4Dk4TXhcr6FqCW0mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701320; c=relaxed/simple;
	bh=EjYYHdZ6H3Udm3U6An/+TrW8kcQquhmV41giqqIv/K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4hCGL0IYWqwOFeimGgCzvoKBs7Si8T+6M8IineXqHWOt5GhXTHXrpTDupeE43J8Cuu7kgVs0JfGlvhHBY0zQi7woal0ieHUktE9VjSlsMhWGp2E8TPdP6bX+yQ8Lc7023iq8KgOqlxnGnV0o27gx6u0Y8bM3OMmKyTDqnMotrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OG4N1DkE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OG4N1DkE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741141F00ACF;
	Sun,  6 Sep 2026 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701317;
	bh=o0OPeK3ILgZVSxyiEGqenBwKyzpu2fpZ/OB3h3I4wPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OG4N1DkEv6JuCNioLs0FifoULTY6G7+cvctCv/TtzDhB0eJLZy1LAP1XAp5Yz0Q+d
	 dUnqSkvDUzo8L40gTqN5ijIkebYMNkDXB+CNeUGU6v/Vu8Y57Fl9OOLXgll7lFXQ4U
	 /AkhqQnKQt0xKXAcqLglZVaWK36KqctBM1NPUlhXEylJpFInFbxtRvqncAblfbzhkj
	 /bKrFr+9q6nhZ3V9Z2xOAiZmgg7utqg1jcEyi7E0pXW7zUl5tGm1THtgKrP5NnKEjS
	 toJfWHXJj00l/F8PGv8ZQ13+Ca8ENJbSqqz/BKnT/QcpPpJX5nwyEQUAL4K9XuQvjU
	 FBT+tkUviBSdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 6/7] nfsd: move cb_need_restart flag into cb_flags
Date: Sun,  6 Sep 2026 09:28:30 -0400
Message-ID: <20260906132831.874344-6-sashal@kernel.org>
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

[ Upstream commit 32ce62c0f09cdc5a6b06bb38daec9b9a47302437 ]

Since there is now a cb_flags word, use a new NFSD4_CALLBACK_REQUEUE
flag in that instead of a separate boolean.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Since there is now a cb_flags word, use a new NFSD4_CALLBACK_REQUEUE flag in that instead of a separate boolean.

On this stable branch, callback requeue handling is consolidated in the nfsd4_requeue_cb macro. Convert that macro and its release/workqueue consumers to the flag, retain the older cb_holds_slot representation, and omit the callback lifetime tracepoint hunk because that tracepoint is not present here.

[ sashal: Reduced backport -- upstream 32ce62c0f09cd touches 3 file(s), this
  backport carries 2. Not backported here:
  fs/nfsd/trace.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 01c5d5f58a5d ("nfsd: RCU-protect cl_cb_session to fix use-after-free on session teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4callback.c | 9 +++------
 fs/nfsd/state.h        | 2 +-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 755e2ea069491..00e3664727fd9 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -921,7 +921,7 @@ static bool nfsd4_queue_cb(struct nfsd4_callback *cb)
 		struct nfs4_client *__clp = __cb->cb_clp; \
 		if (!test_bit(NFSD4_CLIENT_CB_KILL, &__clp->cl_flags)) { \
 			__task->tk_status = 0; \
-			__cb->cb_need_restart = true; \
+			set_bit(NFSD4_CALLBACK_REQUEUE, &__cb->cb_flags); \
 		} \
 	} while (0)
 
@@ -1285,7 +1285,7 @@ static void nfsd4_cb_release(void *calldata)
 {
 	struct nfsd4_callback *cb = calldata;
 
-	if (cb->cb_need_restart)
+	if (test_bit(NFSD4_CALLBACK_REQUEUE, &cb->cb_flags))
 		nfsd4_queue_cb(cb);
 	else
 		nfsd41_destroy_cb(cb);
@@ -1407,9 +1407,7 @@ nfsd4_run_cb_work(struct work_struct *work)
 	struct rpc_clnt *clnt;
 	int flags;
 
-	if (cb->cb_need_restart) {
-		cb->cb_need_restart = false;
-	} else {
+	if (!test_and_clear_bit(NFSD4_CALLBACK_REQUEUE, &cb->cb_flags)) {
 		if (cb->cb_ops && cb->cb_ops->prepare)
 			cb->cb_ops->prepare(cb);
 	}
@@ -1454,7 +1452,6 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
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

