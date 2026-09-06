Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E942253EB
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701317; cv=none; b=QohcsYMlAUTuWaEJswtWGrsjXUwNjYfMoiy3rPnC91/VuVv22r0cayoOelyw5RF5VmMiUnzSVzpSeTOylKBLERwqJsef3eNdB2ox1fNnQok+16Vzx0Ey4KI7r8lYQB9IdLRjgi34ZvfXjdIsP/aiPNdyvIVArzoXbzBM40cbRBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701317; c=relaxed/simple;
	bh=cqkWJAzry5O/1+DeEBt9xi6g08JlPiU2QZLZ+abbY2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwJBdDm779aU2ilsAmkurBI87vdM9vIywga0QY4DGppGb7uCO9BIsUjEusGq6ERJ8dit/+i9RMZ/M+zR35pBdtctbcMjMG5QFfUrF11hZ1ulQMT/HakhSkf582bbqQIkICJm06UhCeFhj24I/2UYX9tb8K4OhKDj/hbkXfg/62I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqspwNlw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqspwNlw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7AF1F00AC4;
	Sun,  6 Sep 2026 13:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701315;
	bh=XuOPPOcgfyKaHUDkYHRjTMpqPJcvIoeT+vSl7XsD0gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RqspwNlwOxaXm4U8+9SsO7jYb2XY5aDEM6U+MkZzirvbitUl3C/1jEnobqvSss4Hk
	 MGbNtbTPt/DQ6G30WNYYJTEEWZU8hF84FMDdlGumQemvwd9SXXA/PCPpkvR0zidXtW
	 4tpoc4U4ZM3UMTkPiKFsJU15l6JWzvJ1LuTQ1TjTk4hh/W2mfsumb6C88nQviRjn2p
	 /DfxX6MdQ5LywrE3G1Ybv/xRcAqK3dneIVrWuHOSWe4f5BfGT9wTnSqaocCP2HgUFD
	 dCpZXLZ//ueXwsH5buWQwJkhrmV/DoN8g8VT3R/IiaqaIqXb92HCOrxJPEz/rWd/p1
	 hkK/7To0dpR6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/7] nfsd: only check RPC_SIGNALLED() when restarting rpc_task
Date: Sun,  6 Sep 2026 09:28:27 -0400
Message-ID: <20260906132831.874344-3-sashal@kernel.org>
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
 fs/nfsd/nfs4callback.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index f256d0230629f..52a2f5017c63d 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1199,8 +1199,8 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		goto requeue;
 	case -NFS4ERR_DELAY:
 		cb->cb_seq_status = 1;
-		if (!rpc_restart_call(task))
-			goto out;
+		if (RPC_SIGNALLED(task) || !rpc_restart_call(task))
+			goto requeue;
 		rpc_delay(task, 2 * HZ);
 		return false;
 	case -NFS4ERR_BADSLOT:
@@ -1220,15 +1220,18 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
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
+	nfsd41_cb_release_slot(cb);
 	nfsd4_requeue_cb(task, cb);
 	return false;
 }
-- 
2.53.0

