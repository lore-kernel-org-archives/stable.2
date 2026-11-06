Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934671;
	b=mJUk4M7fBJB84vg9vsTYCO5UCxRT6qh54E3d1rIg9S9wcivCpteSGRwreMA6ul8MLOh6
	 iH5ood/AQ4IQUUhRrZipv34dI36U8J9L3EOSzZhHGCKh9Iblw9Uk0pPgMhDaK9M+FaTot
	 733+t4SqYbV6dG0p8TPjBOPrd1NWNh3F27r1ni0zgWoAXAV+DgehS2kSMRpunaexCZscN
	 v6nxIMmPAXy6VLQSCJwGH+2viJlI3HTiRV2hdwf4Gyo5Sg3tOmORJfi/TXD2PATds3CaN
	 HpE7cnnL1zukFGDR0EMnLRFVIN8vBTvSBKAh3DdRMmBvdomJhXe3vg7YuYsA++D5TkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934671;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=H12mOsT3QCWuCNSC+GJzkEVF8Ip/09AKylnsNXXah4A=;
	b=GCSrx1ChRUsnPjEPUaL9cP6CJliCLHB7XaoSxxIgGQ8OxKREVpqRjR2YmCRCP0yZMOQo
	 by5RJiSj7gIykKYDCmYGrMW0DOkyxcnDIk1tTrtpmJPlj21rLnNnAsPb048LhpTrI0hct
	 WOSvWsl5kclefShh+v0eQwQSOqr9tqHSEyL6XAC1e4caIOiaO7dbY/XOXnJ0lAQssOnQ5
	 4eXcwGmRRpsDkVAb3rac4l+8lFT9Z1Ilt8E4IJx5WjfFOhjsb27UrpcH3HNczmEZe5mdA
	 iqEX3x0tPbql0rgsjFnIE37Y79/caKxDHjCK3byiHAS8hpp7ps3//nFPp2TlHw8Axvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cY1tcGU5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F4606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cY1tcGU5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1629B1F0089F;
	Fri,  6 Nov 2026 03:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793934670;
	bh=H12mOsT3QCWuCNSC+GJzkEVF8Ip/09AKylnsNXXah4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cY1tcGU5iBKzQ6cVfv2GROFz5DCqWeheJ65ztxJpQgvARNeutAAiMQM+kt+jymIgH
	 mcKq6jx2pxfP/8wyzhs3kQXpYf8l4YdDEVWYY6GYx0TIjfNvZKq3JWQ9mwKkCtDkus
	 6yfpvKo8YUap8Scsnlx3AFU+macF/ZX5PdEw8+xR442hwN3VEkH572Ux3Yky+b2RtF
	 9ynxQ4uGn2BsW5bCqMcS4x0elp03vtOaFOt503lxBagE5fT9ERN69VAHlsL7LRUnfa
	 mxtm1QXPjXILJzLOYj8B5jvdXoTmoOpKUrYmeMJ/EpmSgGnDYIUblstXCAFFbD9Z0M
	 Di4PJFJJ07/Xg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	syzbot+d5c77cabf7a3492aa650@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] NFSD: Move the cld upcall message out of the caller's stack frame
Date: Thu,  5 Nov 2026 22:11:07 -0500
Message-ID: <20261106031101.3999663-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110454-freefall-tapioca-21ff@gregkh>
References: <2026110454-freefall-tapioca-21ff@gregkh>
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

[ Upstream commit c559b05610557fa3c6c30259261f6dae523b3f23 ]

__cld_pipe_upcall() builds its struct rpc_pipe_msg on the stack and
hands it to rpc_queue_upcall(), which links it into a list the pipe
owns until the message is released. Only the completion rules keep that
frame alive for as long as the pipe refers to it, and the peer that
drives those rules is an untrusted userspace daemon. The gss and idmap
upcalls do not take that on: each keeps the message in the object it
already allocates.

Do the same here and put the message in struct cld_upcall, beside the
reply buffer it carries. cld_pipe_destroy_msg() then reaches the upcall
from the message directly rather than through msg->data.

Reported-by: syzbot+d5c77cabf7a3492aa650@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d5c77cabf7a3492aa650
Link: https://patch.msgid.link/20260901-alemi-v2-2-e163f94a3a6e@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Stable-dep-of: 2a83fcb50f3c ("NFSD: Complete a cld upcall when the daemon closes the pipe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4recover.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index f48cd56840942..2c75871f3c479 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -726,6 +726,7 @@ struct cld_upcall {
 	struct completion	 cu_done;
 	/* daemon has read the whole upcall; protected by cn_lock */
 	bool			 cu_inflight;
+	struct rpc_pipe_msg	 cu_pipe_msg;
 	union {
 		struct cld_msg_hdr	 cu_hdr;
 		struct cld_msg		 cu_msg;
@@ -737,22 +738,22 @@ static int
 __cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg, struct nfsd_net *nn)
 {
 	int ret;
-	struct rpc_pipe_msg msg;
 	struct cld_upcall *cup = container_of(cmsg, struct cld_upcall, cu_u);
+	struct rpc_pipe_msg *msg = &cup->cu_pipe_msg;
 
-	memset(&msg, 0, sizeof(msg));
-	msg.data = cmsg;
-	msg.len = nn->client_tracking_ops->msglen;
+	memset(msg, 0, sizeof(*msg));
+	msg->data = cmsg;
+	msg->len = nn->client_tracking_ops->msglen;
 
-	ret = rpc_queue_upcall(pipe, &msg);
+	ret = rpc_queue_upcall(pipe, msg);
 	if (ret < 0) {
 		goto out;
 	}
 
 	wait_for_completion(&cup->cu_done);
 
-	if (msg.errno < 0)
-		ret = msg.errno;
+	if (msg->errno < 0)
+		ret = msg->errno;
 out:
 	return ret;
 }
@@ -924,9 +925,8 @@ cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 static void
 cld_pipe_destroy_msg(struct rpc_pipe_msg *msg)
 {
-	struct cld_msg *cmsg = msg->data;
-	struct cld_upcall *cup = container_of(cmsg, struct cld_upcall,
-						 cu_u.cu_msg);
+	struct cld_upcall *cup = container_of(msg, struct cld_upcall,
+						 cu_pipe_msg);
 	struct cld_net *cn = cup->cu_net;
 
 	/*
-- 
2.53.0

