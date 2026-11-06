Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969559;
	b=IAsdeY1cbC4tbg8jJ/DhttkoayuHbdRKKhgTRaN06D8BNBYwF15U7sAFA/S794hUd28+
	 +TBP6/ELQsinlF3FLsvBSNLW01HihL+8q02ULK+YOIiU9UL9OEiEyecAD9xEHGMFOnGKE
	 cpM2O2mTYhrUoJYgHEN+LEPsLOsHzt+9RGGAwn/92zZiut10LLhwZ+ZjqMRUZtH8vqd7Q
	 LRCgnP8IwjacVNWC22G+kmse1zEx8/MLIIw+Rr+dD3I3+rDLSbM0cgjE2Y3TiG+hTfh9u
	 7pryajKijhRQIl67M0AvgTiED3LdmFskEw27b8lm5x6sJvJY6tNljszwZSI+wGHT1Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969559;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EgI1rb0KeKR397/pGzURcKLJ3aEPeSa2azYReaCnN9g=;
	b=xBu9PiSHwdrP5ctECOarvlK1Yx3kbJuxI2R0MQnlkttct/6N7iAcwpBlk3Cdueya88QS
	 miyNWIrCrbRkoYCxug6QL0ARkG6CGr/8R38AAdVGobiQdI3BH6Gcipu50Y4lHqtS1ISyC
	 JOPrElvyHDvSqKR35t+IoVjO6HDcZPDMV5lOpjQ22H8q0qa+K4+ZzWjvZ+LwqlUAh5yzL
	 oeYc91WRdhgGWo88Y7fKXwInZc/0groKpd3WrpHc1EFMk6/mRT9UDWpqgmKKBk3zBF14g
	 mlJMmQgwRs2L5mpi/BlYsKqtjZc0U3BVZB9Md1TaDdlcl2GhVicbDuKYTmPdPwSd01g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgLfh7+M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F74606A32E
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgLfh7+M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026221F008A5;
	Fri,  6 Nov 2026 12:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793969559;
	bh=EgI1rb0KeKR397/pGzURcKLJ3aEPeSa2azYReaCnN9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XgLfh7+MiqPM/jtUj7EII2pKhtRCsCQCozI3pFRdDCp3O+/de1VVMRwOOI8A0RXTj
	 46dACKuCUXM4xjHfxtY+NdHTQ3dsR45ZEHNznyE6HxW+/p+Wk3qRjHdVfUtTceh8yj
	 tpnATs0+UYApytw8vYXm4oPXJCkU7swKJapGBLTGrFQ/yauK0/9TAuu6vdlrA78Qos
	 zfGCfeDwO7EFBPZ0xkWnuDEzE3SMSZ1eONCKq2YlSaEgPCJT9dsZlZKBpeyt8FlN7b
	 aPrQKCbQZfOBvb+zN7umiNgZgbO2AeXCB735x+jLzIHHouFVlJR1HYTF+uFvGRBVFT
	 YL83lNfcPSO3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	syzbot+edbebd898142ee5e24ce@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] NFSD: Complete a cld upcall when the daemon closes the pipe
Date: Fri,  6 Nov 2026 07:52:37 -0500
Message-ID: <20261106125227.15863-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106125227.15863-1-sashal@kernel.org>
References: <2026110456-scribing-radio-40c1@gregkh>
 <20261106125227.15863-1-sashal@kernel.org>
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
index 2b7aafca359bf..b2597a7c72311 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -937,10 +937,34 @@ cld_pipe_destroy_msg(struct rpc_pipe_msg *msg)
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
 
 static struct dentry *
-- 
2.53.0

