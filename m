Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793935661;
	b=p5ALJ3Iyc5mCeKCZUENOakX5yLwYWEITmGBPf/KZB2qc6HPZM2+7c+UT626qgn5xKJSC
	 lCJ3icAKZuktjd40GF28iHf/pCiO1BaBtHT6MTkfiqe4x8AvPzd8jJSHrOHbz8tMD5Kan
	 B7gLYqtf7pHNJ7lSp045gDUk3apcphV2TBdi8NcVsRBPL5pD+9VZvVPpjdff1RlIkzgZV
	 +b68zB97iBt5rW2MhiT33X3fPgCA9bbbjLc1PTFKFzKcIOg3bu8iinOJptqU8asOvBHnx
	 y5juyH4NqbwzxHLoTHu3EkPNjGVxF49kthyc0bdYoGbx0rMTRi4ZNMZBpymzCXFC56Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793935661;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iImYxkcAnCEpOE2ZvmQnuxH62pxmxXfSM2SIhbUNvyc=;
	b=cbcvZCIXlwdqTfdeD331GiwZyTuUW3EaHE59UOy7oeYvKZfrrNEMGnR2xp/pi/isVPIF
	 mUR7JiA08vl7EkQwpYC0V3L6OI+ma0dFtrhUQuSolEIE7aydozTlMRBJoispGbK9qlcjD
	 S1ZUsMp+THCQTXTcUtauFXgJkVW3oAntSjyj2z0S1DJZzIgAI3rmyvw8W7Ax749No0Ofe
	 gFn7UjogZzTL7vCVdtpClnaFYugqM6CZGlrE5DRSZmsgTPlHq5iTY6DislBltVLIja81p
	 yr1e9sHfJ1lk4sX2nJBgOL9ai2+QiwLk3qwC6NuVsyr9XRyJZAKE12OzHRPqUIRPhUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TnNzLqOb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6011F606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 03:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TnNzLqOb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954BA1F008A1;
	Fri,  6 Nov 2026 03:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793935661;
	bh=iImYxkcAnCEpOE2ZvmQnuxH62pxmxXfSM2SIhbUNvyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TnNzLqObt1hi/IwXe7n/euANbwDxyp+TeRoEWUzE7JT8pgqKZ4s3QemmBhz7nt0Wk
	 9ByPuwWSR6J3l4ffmPsjiu2glIedxF+a+g7jJtV+qbnxKmP/3jsdTb4u+Hth921mqO
	 QPgcJdwWXT4xzOtDgNaSFFCr1IaUNv1vBVPFPQGaQ9iknRaMLysdLb1bxZE0WiEeFe
	 9Esd0qXkulJEpaCn1Te8PWtCkYjLkCCK362e3qarWUO8/6P6SuvBr5oaanxPbJf6mS
	 S3cwwpMv/2qhSr+3GuY0BZqDziV1+lcJHr7Y1Ld2uqOvdwWHPu25kGal6+uJcEjGp8
	 K0bMvuEIF4XVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	syzbot+edbebd898142ee5e24ce@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] NFSD: Complete a cld upcall when the daemon closes the pipe
Date: Thu,  5 Nov 2026 22:27:38 -0500
Message-ID: <20261106032728.4021201-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106032728.4021201-1-sashal@kernel.org>
References: <2026110455-splice-wrongdoer-64c7@gregkh>
 <20261106032728.4021201-1-sashal@kernel.org>
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
index 1255851179eef..2d6f15e2f9bd5 100644
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

