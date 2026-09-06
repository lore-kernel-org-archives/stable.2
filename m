Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429738DC49
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788660814; cv=none; b=nlclz+BXO2HzwDQ0kxlDFXI7P7fQ5gKx1yuWiMtvCA2oiRO5RaQ4JrBJRwMgDvD5Q/ld2bwBLzvWFdN+J/ikRwPprWl5a2PqdFs5DkfRlxr4gmcHKl/wsopAKmSxAp5xpUzJmP7Ol47+kbSEumoDueWmnc+ymflC0u5tgZ6k9jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788660814; c=relaxed/simple;
	bh=m7RpMKD+kDt4+70eKKUk+67txWg4ffheTVhNCMcnriI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfbOQLwx7i2HAwV5aLfCq3PqItXbxV8qH94Ra4ddyDj9FV5tkOFIULH6TMtFnDYI6itGf7jXEnGzEvQvAqZw5gDpNgd3KTQU1idYSJ8KyX8WGj2LduxKqVsGFWzhONPkWECvm8otDMVsa4XbZ4k6ZsY6i6iG0qVwz7SXdXy+0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5A2sbP9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5A2sbP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659B81F00AC4;
	Sun,  6 Sep 2026 02:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788660804;
	bh=+VuQOc9/jZnm3Rca6LIsi0NLQ5fMHgKenLr/4B3h0Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y5A2sbP9D/Qe2mK1I1MjHXINOP5R3YgIiwFWsg/lhhACUES7qkrJe9RCL9BEAmHCa
	 3mANTnQhP9peK6bR1A+u6f5aJUMkhIXtaZyvq6OCMicKGKss9k0rtqR02skHpnNeYG
	 LWkzaY9kd1o7qaHFqWmbBNXIKGQEbtugMmVDkJSjZW+8roqBc5vkCu6CtKt9Wo8tRp
	 4BMHjUcqAYV5FkL3Z3zNgatqWh0KpfHwFawIwsJ5WxlYv/84HAxWDBB5Lxygiszxf8
	 hnzeX3AFQe+0RkoY13av2AZXp7RaBvWBc8RHb3n51go0AzWBr02BPX1/8l45azWZdS
	 Svj7ifrqu7/CQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/7] nfsd: only check RPC_SIGNALLED() when restarting rpc_task
Date: Sat,  5 Sep 2026 22:13:17 -0400
Message-ID: <20260906021321.760525-3-sashal@kernel.org>
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

