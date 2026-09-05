Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C139CD03
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638733; cv=none; b=HgO9l8GpxIYs+JahubVeitMtAlRNmXsgnWpoMYRYBBoGPv6EmsFEqKhVBiPGxB9EMI6olQp+2zC4swAC5297twAdrkc+HZnErK8dTk+NavXqU4LjokdOlwrqMC2S8yQxzmoXwQPEUo8xbP/KJT9A9xdYLeH/NI0fKjT3JZuZuAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638733; c=relaxed/simple;
	bh=Go0YgTaG7arUdhtPkMKsdGfhPLQkHYulALpZSt+eKSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPbSHFND68TBci3fvx8wJqNhWJYwfgF+mD7RUP5VkoraoDC5hGaIkZioK82cxHi6Al0htboQIZ3qR/2rpsCAN86i3UQEcVVCqMBKoQTLfGCFffVMdTj0NR27FBhW8Wwh+vHQh9gAtuvGqUD6Indp/tA0XmDP7QGD7ngvVxYNQR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StaWmi+X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StaWmi+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB301F00A3D;
	Sat,  5 Sep 2026 20:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788638731;
	bh=UfZTvLs/PJ9/qVm9OtZPfUAHe1dVLvl5936n3Y8o3ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=StaWmi+XFW6EO1VIhSHqN4KEWfjBIqnshJwGBG1vjRz7gslZtd5iLGh7lvpnLnJRr
	 Lw3PGI8NioLvkHjCR0q2S2wWMxgQi27+lUE/XYz3sdvX6mTfmW3wZzy43571G6qN9n
	 hjI5uXHjmJl/MXX5sC045NMZdNdnmfe9pvU4Jpgh/l+TXaidxrpgcYCFnsAhh3ASvT
	 Kj6CD23rY5+GSmjE90uOBNMyqUPOVQRS5mawlaF9kCLbzgqcnvzr/4uGlriQRnu+99
	 zZ5j+6amdgeCTXHou0YfepDnujrlE09/OOZJxFKiSQigRlrSH4eC+cUUsTA6N7iDpv
	 bwh6htmEpqPPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/7] nfsd: only check RPC_SIGNALLED() when restarting rpc_task
Date: Sat,  5 Sep 2026 16:05:23 -0400
Message-ID: <20260905200527.607284-3-sashal@kernel.org>
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
index e62d2a9d46926..f131c7dbbb194 100644
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

