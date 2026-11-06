Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968642;
	b=ejSqKb4E/ayQNvsK6Nf8tAWTpsh809gv38dwK1uftcTCLU7VvBfa2Uu6mfXAAWn3OpsX
	 GZc6JyI0+qMJloEDK8YCF88OEg/6TjZWbseKVU6VVWoKdPi3fmJlf24EnOMfeJP33o/om
	 SSQ6jcPlIDexAO8gXXaK2wdEcVPPpu6Eg4xQ+CFO4AOqK9hsQuFcX6+7oWrb0JzEJln4R
	 4LH3y59T5gXG/orWjZn36bT/nr0lfu3HNpd9/2m87kG+h0I8bKZqEnsznN4Z6/eKRsIBK
	 gemJlFu3DZbgyE1rohxIAjrV+1Ekxbf0RIwUiHiqodhT+N/do4XWO2nU3kZXtER7pQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968642;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DEkuHzeqdAOf5ibe6j0Ym28Fkv5pK9E1qx2ZtvrLrXE=;
	b=rhCPehEckvnKOUKPb7Yzh3ngJTxGiTsOSW9wzrQ9JbNABmzQcy0xHL7k+3RFnM8g9+j8
	 GBv3DAmDgaukog8FmFu1MPq4lohZC+1Ymzhq+zcoMQvqlSlO5bGW6/cS71cpt9ccZGHCB
	 JNNoreDAxBCqEO+/W6YjiItLWJmFdZPOvFL75o7XjkWNlZm3VxSXS4PAegyUAmET5d/e7
	 kBImPdBXnn6ue7A3uSazMG29obWcsEiyuzjb1ioSisllD23va703wfxrALxBAANGovR3J
	 4vz5QSLZ7g0ssrNITt6XvRjYcVkgmGZ3ChkZmSnccf5g+bxENjsW5bXItPjjZZMPkEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nz7bnszW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0B5606A32F
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nz7bnszW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467E31F008A2;
	Fri,  6 Nov 2026 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793968641;
	bh=DEkuHzeqdAOf5ibe6j0Ym28Fkv5pK9E1qx2ZtvrLrXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nz7bnszWOjZPsZwGiW4wy2KvkPEFpjHU7RaeAfYdNKy65hWmUsU1E2T29A9BrPNjd
	 VLz5AGhsYHpTcWYgYZpkXHCkKmhb3rgEhfzciylNFE2QtSYMh/JmmaM/ilBd7ydKPW
	 p3Cjd5GAES1BfMDP229MMKOpSvcar4UdXVshaXZYiuQv5PLudc8DwGi8tyjxTe6Y1k
	 4XbQ2nBBOf+6OTqtxciVX1nox2dmpa36DzZjwTSXvEioU7zUqJn/UBW6UDu/25Ujsv
	 kszsHEbEXb+G32Hkem6D5ubimfEML6bvxF7XJA4WazngskZ/+694VWTH+5RSdDoW0n
	 cSAnklM1iHxaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	syzbot+d5c77cabf7a3492aa650@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] NFSD: Move the cld upcall message out of the caller's stack frame
Date: Fri,  6 Nov 2026 07:37:19 -0500
Message-ID: <20261106123630.4042374-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110456-hypocrite-villain-ea3d@gregkh>
References: <2026110456-hypocrite-villain-ea3d@gregkh>
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
index e0cb4856ca565..274c6e0aa60f2 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -720,6 +720,7 @@ struct cld_upcall {
 	struct completion	 cu_done;
 	/* daemon has read the whole upcall; protected by cn_lock */
 	bool			 cu_inflight;
+	struct rpc_pipe_msg	 cu_pipe_msg;
 	union {
 		struct cld_msg_hdr	 cu_hdr;
 		struct cld_msg		 cu_msg;
@@ -731,22 +732,22 @@ static int
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
@@ -918,9 +919,8 @@ cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
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

