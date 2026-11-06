Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934671;
	b=xZ+aJz44X1US4otdv5AR9jE61aTjNVGlCrB7dm3KoA2GjYgkkK1MCYDwkQrhJ7y6ZxR9
	 fzT3bUClrg9aDgIy6HbOM6ADNdQQXiRASY6VttNQJpEVRcmTPRABxJpwgOsFVc9aHczwE
	 EcYcBXxMV6uHu7kyl8/8e61AoWUGiK9/48H+Pa36fTskoiyb4XWPX4vQhyDKabbYGcNUx
	 z1irjez2ubywlaO86/Gm+4gQV431AMjf+Pcjq8pnngmIBOcJNKMR6+ASGddBG3M4WgIJc
	 WT7XrizUNOoHqSIyWz+KKRIut5ZF6aIW31NR99+yGvR8NPUOxnIRAD88O6K0ksbdHfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934671;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T3lIOpr/GCoIrygqMrURvcdk8UIYby13eFOnpOMxq4Q=;
	b=MtrMffRwu4zzcjuMrcVhL4rayvh/Yoti4i6hCn9W/S0I0NFK1sRB/u3XHq/itEGwFWEM
	 1SpXvzMo3qWSxOpH4s2J+foVYdJY4Ix/lCMzDvZcrRn+9KyiAPB3clS5eYcVEGxWTs84s
	 /bNQb81Y2zzVRqyA/P+T79RhSdo8NLUVPbGFd1xq3GZmh5lBPOZPuZqXfx6uo0myx3D0K
	 yYK6dzOUlu8M4z+8WFNBux4PaTM5P9hDQeM/GUVN0ylCLRQXtl3G9xvlVcvsYtdc3+xVH
	 nhvtusyc6yv+P9wxbRYYnoL874Gnk6Fpm0w29c16hum9nQyN2xRLZ+OgGk7bZ7O1Z1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPmu0qaf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A58606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPmu0qaf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94541F008A2;
	Fri,  6 Nov 2026 03:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793934671;
	bh=T3lIOpr/GCoIrygqMrURvcdk8UIYby13eFOnpOMxq4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dPmu0qafeBf39uoDgPbkvvvU3D/ChG3NvSliGQJpewLy1r+uLoRLlT1zqvVTRY4SS
	 u6eMVouDpodgC+9akEIGcYBnVZCoKLs4aOrcrzFOniIDmlVVqnbYRa5z5cx7miEjJj
	 BcyD6b2XfUQPDKRcoM2LmJn08b/krYavVfxZPbewn7qWueaTbDwOSxk2v/W68jZUId
	 ssgAPvphQrdiTyJ/5nrOmJI89NIijLmSN9ya0Wqd1+8zsoIqqtdKn9YRLulL+GdLCO
	 JKEAkdpNZma3ADXE34Vx2y0AcL+UaUMbCeSjwRWCeVa2cnrX2obI4uEk0pgIuIvZEX
	 0Fe+4rrOo6O8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	syzbot+edbebd898142ee5e24ce@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] NFSD: Complete a cld upcall when the daemon closes the pipe
Date: Thu,  5 Nov 2026 22:11:08 -0500
Message-ID: <20261106031101.3999663-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106031101.3999663-1-sashal@kernel.org>
References: <2026110454-freefall-tapioca-21ff@gregkh>
 <20261106031101.3999663-1-sashal@kernel.org>
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
index 2c75871f3c479..89441b5cb0603 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -943,10 +943,34 @@ cld_pipe_destroy_msg(struct rpc_pipe_msg *msg)
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

