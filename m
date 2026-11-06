Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793932852;
	b=fyBvivtQ9p597RLRLOmdmAx0+QEU6owzqcJAejROx3TVgW1ay4NjzUDE4VohIXucJ54M
	 0TqpCUqnUuNGBrQLXl5gIPCCzssX0rujFYk27wqude4wKtyT1Aro/fXrt8YtWKcsH21bY
	 G1n0u5IsoH4lsQLCNPOvYQ0bzdZnyuKxBx4UxhrramG90EBpuCVhBdCJZgcM6HIp7pqBn
	 1okHgZpHKHrGWddTzxDEodX5nm1sEdC2R7lqyrpgSFgWV6DgXK0jyAfkyZfkWIoztZkaE
	 AjrDWm7f77OJteh5RDUqPV2lrZEmWDiCtatxJsgFJY5STm55bGQb8vv4YwMvhbx5aAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932852;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hVqFXu/XEMzvTBG/91kWJiYmOzNs4PawsTsnxwvB+zU=;
	b=hDEqdyNEB4VjqTybDFXKtT748LbL5+mg6zlFjDyPuAxkfYaP5d6Hki9VaI9VtXNHpi+X
	 Pj2lVwKdFqisRsmAXu4v0yk0JckFzxEsow1tHLuJoKiOpObbR25KjSTbNLJYTFcFIbZVa
	 eoh5XMXrZt4nddSnQayCfHuhcCEM8NZJ4xVBBjKXE9ltYsi25PbofJTVcOVIWiSLibBkL
	 MhZUJINEbp9GpFQ2VkAn864bVsh8WwmEyy4gx8W8F4HTy/3+f670Qktfo1+N/uZh7lk31
	 Nyx+NjtNDvXjcVmkqFPaihlburxlCHF+wfvFenIqXSavDDlP6+ZOoZVpWGlP1N2cu3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K7ByaxGU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E2F606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K7ByaxGU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61491F008A1;
	Fri,  6 Nov 2026 02:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793932852;
	bh=hVqFXu/XEMzvTBG/91kWJiYmOzNs4PawsTsnxwvB+zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K7ByaxGU9VsFu6a3iageNUnwARaX3mVZCiJMHjbBWRMCJ5UP5XNoKjJrQwehznz1A
	 p/ZJHbB/xxqqcEqXsbS58NxN6CaLZt0cTZUldFzfc3wxy3r2X+r0sqjGY716MscKhB
	 lVfD+p6s12np75yzEZNpJKU+/2BZagBS4UExgZvaGfV/FGngtYNs5HowrZxmp6dMxq
	 2uNpKyP8XWhbhVtopF/26Bbxg1GgSmGSdYt5B2RV7TrgowBtcYxCUYJNZ67jWVgAXE
	 LYx4reVt2uOiSd/Lx69gJAZBJV9Kr3fW9RxVchPEZZVVsT2Sc3sdGBcH7qk2iuUSHj
	 RTfIHKqnHEXUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	syzbot+d5c77cabf7a3492aa650@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] NFSD: Move the cld upcall message out of the caller's stack frame
Date: Thu,  5 Nov 2026 21:40:49 -0500
Message-ID: <20261106024045.3935499-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110453-musket-ludicrous-f264@gregkh>
References: <2026110453-musket-ludicrous-f264@gregkh>
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
index d04a7d3aabbc8..b001d3277b9f9 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -711,6 +711,7 @@ struct cld_upcall {
 	struct completion	 cu_done;
 	/* daemon has read the whole upcall; protected by cn_lock */
 	bool			 cu_inflight;
+	struct rpc_pipe_msg	 cu_pipe_msg;
 	union {
 		struct cld_msg_hdr	 cu_hdr;
 		struct cld_msg		 cu_msg;
@@ -722,22 +723,22 @@ static int
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
@@ -910,9 +911,8 @@ cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
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

