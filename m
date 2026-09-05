Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02E73AC0DC
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788644617; cv=none; b=EMVkicGDUOryUBSPKUnpALIvAIUiyMgKOxUKAaQM1OmGh18aAzyNkan7u50oXZLpOOzDZkGSsXi64FDRKt9VHzOJCKPpVFXx1Pgy5dmAM7d5RYxheAEuDeZfcK3flfcObRx3dRtOO9sfxhQ/eJmj4utFGT/1iHwDW35U6ohBCh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788644617; c=relaxed/simple;
	bh=m7RpMKD+kDt4+70eKKUk+67txWg4ffheTVhNCMcnriI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+PjSVMuDfEV7sLq9ncFKxE4gxfZftahr5p6n9XCRskb5A5CoMF6J03phzOwNTjsw9fM5RP8UY6DZ8o3cITUp5mAuatjxR8liCyIDT6Z4cW0CAXA7+PfGqJjMWVfyRZt6GF4gtq3brVtr9F29pKLIC2IFVfPffGw4Hh/QiLNKjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9dTMLen; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9dTMLen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC85B1F00A3E;
	Sat,  5 Sep 2026 21:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788644616;
	bh=+VuQOc9/jZnm3Rca6LIsi0NLQ5fMHgKenLr/4B3h0Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n9dTMLenCN5xHrVt4/E1x7E6vY/gjGm2t2yLdnZ+SUBYKOWJwwWy6nu9Du2TTj0wd
	 9yby8N3gGjV6i7KAanNvQBrwRYI7JUwh+3r7/DKZxwlngLmDQIRsJgsBAMHs7pmNSk
	 QXvCkWT7ePn//gsaEW197ZmM5Ta7ynKVrk0o4T6zHHMdc7yPJ/cjFjLriytlc3FXid
	 YBi+tlwqy3tnTUuNW1VjbZ5QNU6BGkLTekxQwavi3yeIySftu9MRx2AqvnCUQR09Kz
	 0E6vmJwHqHVe4zAPj9ZqS2/5Qjx92dk3ZZuinPEyEiIOxQnxqiP3hfdnfFVj/Cw13D
	 5EXeGpSGenXjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/7] nfsd: only check RPC_SIGNALLED() when restarting rpc_task
Date: Sat,  5 Sep 2026 17:43:28 -0400
Message-ID: <20260905214332.701369-3-sashal@kernel.org>
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

[ Upstream commit f049911b5b98feceb949430f33fb5d2c9c55833c ]

nfsd4_cb_sequence_done() currently checks RPC_SIGNALLED() when
processing the compound and releasing the slot. If RPC_SIGNALLED()
returns true, then that means that the client is going to be torn down.

Don't check RPC_SIGNALLED() after processing a successful reply. Check
it only before restarting the rpc_task. If it returns true, then requeue
the callback instead of restarting the task.

Also, handle rpc_restart_call() and rpc_restart_call_prepare() failures
correctly, by requeueing the callback.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 01c5d5f58a5d ("nfsd: RCU-protect cl_cb_session to fix use-after-free on session teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4callback.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 7333068371c14..d0e5f46f0f7cd 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1197,8 +1197,8 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		break;
 	case -NFS4ERR_DELAY:
 		cb->cb_seq_status = 1;
-		if (!rpc_restart_call(task))
-			goto out;
+		if (RPC_SIGNALLED(task) || !rpc_restart_call(task))
+			goto requeue;
 		rpc_delay(task, 2 * HZ);
 		return false;
 	case -NFS4ERR_BADSLOT:
@@ -1218,14 +1218,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	nfsd41_cb_release_slot(cb);
 	dprintk("%s: freed slot, new seqid=%d\n", __func__,
 		session->se_cb_seq_nr);
-
-	if (RPC_SIGNALLED(task))
-		goto requeue;
-out:
 	return ret;
 retry_nowait:
-	rpc_restart_call_prepare(task);
-	goto out;
+	/*
+	 * RPC_SIGNALLED() means that the rpc_client is being torn down and
+	 * (possibly) recreated. Requeue the call in that case.
+	 */
+	if (!RPC_SIGNALLED(task)) {
+		if (rpc_restart_call_prepare(task))
+			return false;
+	}
 requeue:
 	nfsd4_requeue_cb(task, cb);
 	return false;
-- 
2.53.0

