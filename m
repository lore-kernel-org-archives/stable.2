Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793932853;
	b=R4SFApwp4TMmq8m3haZB3MJownXabe26u4TTpM/30y6RWdYlGFJ+bmI1uS0ZDgcLhM+k
	 cQpnD1oxRHJy0PNPDzT9XbHs2PUAI2q4qr98vOKutVQBJRlkQc2S3X8c79FIQORqW64V9
	 IpQGxFbf9MIYUo4iGIvNbbTjbZD3kcLop3/u5rYxT4z6mZekq2nFahbq4bwUZ8XjynUVo
	 5YujnBXyc1n42Nm93uA1SUjl1ZujbFRI80rhim4NdFlGpfEGOlqfkoDdKWyxa1zFE0Vuk
	 wpkUKjfB81nzVBMSgstPtG6toa3YXvqsWsY/xF2WH5uBA8GV8C98H2kqiKkwq0fPEBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932853;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LkqvWr3Ge/g38b/LBI4x6E6q7p8JfFZ/vQOaR2B+x/g=;
	b=hWQOVyxexNGN8xaPj2Qt+7JvQPGvhRfxVrQSMCW+0x6ExvVj5PniktCPKoo22JwggaQM
	 3gV0CJdlnrSPjCUBSx5mHaKHeriLd0lgcsIv20W9S3Yt1HDDBmjKQrIcTxj25QVZL2Ka4
	 7l93jZMjZjNAqIn1XxD9H0I/XrCjYT5seeur2nncV4GW9/l5vIc3W03V4b4ozGdKurAJB
	 JfEJnx+MoXKe2AgkVOB+aGsc/l9sho0NWEhZu4swfZ/E1HJP+eqHqaRhqISmlVKIAirv2
	 tWAtCpv3O5y2XzkFP3/E1jcgUAqOKyiXHU4SOzrHDOMQMSxB0FZNN3+8tYS671aWk3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y49phaiA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A76606A328
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y49phaiA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847FA1F008A2;
	Fri,  6 Nov 2026 02:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793932853;
	bh=LkqvWr3Ge/g38b/LBI4x6E6q7p8JfFZ/vQOaR2B+x/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y49phaiA6iIMyA220I8zbpn4gtwcBA6As3XaZmfqKztMijaVpqoXy243IkwFLYYHR
	 ERKL/gs6AXtPsz9RjuQLQ2FEw/3djLk6vO2IGrSvt/UhMMUBBTtFMHs5YwEXi4omE+
	 CDySdWlgSaxW3JvztPCvu1bAQE+/EuaDIJK886ZOWUdEoYz3JhRMP6xnSPMBuE7ieI
	 iR3Gxniaus5pe9XRMXMrO1IK7vDn4M7uenCslcDEVYnOtyoP6c8mlOcU0U/30N/Vu/
	 ZyewXUNmF1KP1nrIxmp9o7ZH0IfbKaYQO5DZ4BREFBK022RnFTs+3oT3ols14mwnzb
	 Ecr5oSWUYlWnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	syzbot+edbebd898142ee5e24ce@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] NFSD: Complete a cld upcall when the daemon closes the pipe
Date: Thu,  5 Nov 2026 21:40:50 -0500
Message-ID: <20261106024045.3935499-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106024045.3935499-1-sashal@kernel.org>
References: <2026110453-musket-ludicrous-f264@gregkh>
 <20261106024045.3935499-1-sashal@kernel.org>
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
index b001d3277b9f9..e810ecb144950 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -929,10 +929,34 @@ cld_pipe_destroy_msg(struct rpc_pipe_msg *msg)
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

