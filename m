Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793932138;
	b=TwmhY6owFooHd5TCccZyYGNEQ//LZMQ4mG1/H6C0/+ezmlsMssenGoKvJmOAGxwljVmi
	 GT9evvs05c6ziLtfp0ezvcvLKlccsGT69tzKgNKS1UJFkBXAcxzf88uO05ETr17uZqeH7
	 bxqhhs7xZN7pTgNCjeL/csRdlRJ4v32Rzpv4l3s73lMv0YBVph2ysu+SH07dtwyR6qHnf
	 n4m+yM7rLpD7F0W3NIbQ/jccEJD98lpHCi3Dv61n/yat9KWKQ3Z4z4IWab/kE/K/sz+1d
	 C7x4PENnG+uiumyOfYSDLNtdnJnWa/oj/3FQn9PFlvp7aa12b7q0fVKKRYm0YCGrxdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932138;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KE7jcPmAzQhLwdKpCNiMK4q8QLqGXC8jtJoDRcBs49s=;
	b=Id+sbxHExgPo49hlCoXmVCMW35pLINVk3nKkFlVi6IiOt8lsnMv+qhZRWDfE+1WjwFf0
	 jn7UmYVKOXA7sov1OMB+VdlHhI1w+0m9w73kJtkuuJdS78jdGMCCX//mxwm1GrMHYXdjS
	 axGlYhf6zAYhDQ2nGmE7azZrZUGyG/uOGsGOfULq7PIHZICNAPgx31p/YdOgHuOZBGgi8
	 ys3vLHs4DhcxR0kESXwWLVUqj23LrKxQX/xEglcohl/uAH7EOWuDGeJxLyj/r+pXftwRP
	 jrSswRHkF3ohszVVnIsZeHTzaPOSFDLRvnWWAD5gUmgymMIdzxcyG72JaixePVZXcsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YLJjDsEl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FA5606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YLJjDsEl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495F41F008A1;
	Fri,  6 Nov 2026 02:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793932137;
	bh=KE7jcPmAzQhLwdKpCNiMK4q8QLqGXC8jtJoDRcBs49s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YLJjDsElBnn9RH4GYw6LcKVF2pRAc2waK5EY1mz1e1VqYAfuVz9J0+INBrq7joHwt
	 mhRnvoiqtmCmXFh2j5ZdmJstOEodOLFlUA15Zf58ILyeTwMSr1o3MLpXyY4WC/WKFy
	 NVs5ac2BMFrKy/O6HCYo0a6f2/0gvQtno+kQwF8KMTKsSpRn0IPeu3cP9EeKiHfYCE
	 AcTJA/dJFSWAjCPOyHBZ+LB4q8GvT8xd1D29IgTBXdlqp6qcpKBpT1AWqvuTh1+MFA
	 R9DM9ggBKctjjmwt0wtC/S2xkaPK6LJ8fcUP51MBl1Z9N3XlaIBM2O77/D/GoxPKft
	 1+f5slUqLCcTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	syzbot+edbebd898142ee5e24ce@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] NFSD: Complete a cld upcall when the daemon closes the pipe
Date: Thu,  5 Nov 2026 21:28:54 -0500
Message-ID: <20261106022847.3726614-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106022847.3726614-1-sashal@kernel.org>
References: <2026110452-janitor-overdraft-33cb@gregkh>
 <20261106022847.3726614-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <cel@kernel.org>

[ Upstream commit 2a83fcb50f3c25c493cc4389619340fefe9d6ac4 ]

Once nfsdcld has read a whole upcall, rpc_pipe_read() unlinks the
message from every pipe list, so the purges in rpc_pipe_release()
and rpc_close_pipes() no longer reach it. cld_upcall_ops supplies no
.release_pipe callback, and cld_pipe_destroy_msg() returns without
completing the upcall because a downcall is expected to follow. A
daemon that exits between the read and the write therefore strands
its waiter: the nfsd thread sleeps in TASK_UNINTERRUPTIBLE in
__cld_pipe_upcall() and never returns, hung task warnings follow,
and the server cannot be shut down.

Add a .release_pipe that completes every upcall the daemon has
consumed. cu_inflight distinguishes those from upcalls still queued
on the pipe, which the framework purges before it calls this
callback; cld_pipe_downcall() removes an upcall it accepts from
cn_list under the same lock. Neither can be completed twice.

Fail the stranded upcall with -EPIPE rather than the -EAGAIN that
makes cld_pipe_upcall() retry. The daemon consumed the request, so
whether it acted on it before exiting is unknown.

Fixes: f3f8014862d8 ("nfsd: add the infrastructure to handle the cld upcall")
Reported-by: syzbot+edbebd898142ee5e24ce@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-nfs/6a99f6f0.2e567484.299ffc.000c.GAE@google.com/
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260901-alemi-v2-7-e163f94a3a6e@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4recover.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 6b0c51b8938b5..0b033688aa0b5 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -867,10 +867,34 @@ cld_pipe_destroy_msg(struct rpc_pipe_msg *msg)
 	complete(&cup->cu_done);
 }
 
+/*
+ * An upcall the daemon has consumed is off every pipe list, so the
+ * purge in rpc_pipe_release() and rpc_close_pipes() cannot reach it.
+ * Release its waiter here instead; no downcall can arrive now.
+ */
+static void
+cld_release_pipe(struct inode *inode)
+{
+	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
+	struct cld_net *cn = nn->cld_net;
+	struct cld_upcall *cup;
+
+	spin_lock(&cn->cn_lock);
+	list_for_each_entry(cup, &cn->cn_list, cu_list) {
+		if (!cup->cu_inflight)
+			continue;
+		cup->cu_inflight = false;
+		cup->cu_pipe_msg.errno = -EPIPE;
+		complete(&cup->cu_done);
+	}
+	spin_unlock(&cn->cn_lock);
+}
+
 static const struct rpc_pipe_ops cld_upcall_ops = {
 	.upcall		= rpc_pipe_generic_upcall,
 	.downcall	= cld_pipe_downcall,
 	.destroy_msg	= cld_pipe_destroy_msg,
+	.release_pipe	= cld_release_pipe,
 };
 
 static int
-- 
2.53.0

