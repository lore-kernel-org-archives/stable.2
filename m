Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969559;
	b=I0DcPuMi8bMcbIJcBEfWhE0Rz5IjF+wtz0+3yiA0kVKUNRWCoTgwQZZeYUvykBgh/6Zb
	 rY8qIXDX3lD75rP0JNznwekB7QnRPi11MakDP+cEpsNgJO1e1rcQlcomzdakSyIJ9Wlt+
	 8PLlJFeKQPHxxQ8e1sztmmwcj0XhDMlrrn46xqu6iYY2761nb7YU6JXnpbheBEpYEL5+c
	 JL/IXUwNKrVM1TJo4cDkJYH1z0UUwE6nqniMNXbjrFjV6KOx+vY603drTHeA54BsExOBE
	 MgWWsIVXmOhapAgHUfS5ouYgJhNQ10FX0jsrIFpUDQWj6JvvuJgmIAeNcUocpAVX/vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969559;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=g1N7oPkaUr4OyIHwgWCC2H5lB3PKxea8tMt0yTf0o8Q=;
	b=tbJtmDjxizcsdgeruUMFwxDrnDjn1KEq9E0PBJrRd7xjDD4PpMEAIz1CI5OA7QQLuNLq
	 GUR0suixZ6BY60dzq3tStF5BH6ZyEkKCZQewFeeQr64xdQ6sfNKf/mIhxy0M45xszV05q
	 VogwSxIpAtc0XqOeysfIUorAcR/JC7mfEmHS2bw/QEcBC7qpyXUewxnHZew3xAoIKEISU
	 vColHgOAm5MM1qs9QZ4lLIy8Zso4LCxYf/wgQiztk+Jpxc2bmszsNtspN1ZXDCq6bgdh/
	 CZbamasltCPUbZpgXWRswqHP00mlGbw1p0mwn72HbIN5FYHopw2A9Ypd+NcR3CSkChA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nl9P03A6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA278606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nl9P03A6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455771F0089F;
	Fri,  6 Nov 2026 12:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793969558;
	bh=g1N7oPkaUr4OyIHwgWCC2H5lB3PKxea8tMt0yTf0o8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nl9P03A6mm0D3cbK/I0rDYO42BBhVS5QxejqFk1le5YrWoDJuGiWcR7hBma6CROdF
	 VWMfj7HzEXbDMUX5NqLFCGdWdMvIhaUje94p+Z3Wtwj3HgjUP9v20EWUnxz8d6JRHU
	 sEUVskDEZYVQnwJdGlwc/9Hdeqzk7mc5ddJen1Eb8tKvgZE848EGEA4zzmNFUktHGG
	 yiS+IKoFgNJQw11TCOA51zm5FsClp6TPoR6gxPdaMe01+ZtoXfoSt0IqLecJIGAv+x
	 jB9WDBQJuN7eWV6IzPDVzShpqScJsRzV1zGLeN001cpmbKcJQjrSoPaKxX49OeqS+N
	 ven9vigsQx9/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	syzbot+d5c77cabf7a3492aa650@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] NFSD: Move the cld upcall message out of the caller's stack frame
Date: Fri,  6 Nov 2026 07:52:36 -0500
Message-ID: <20261106125227.15863-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110456-scribing-radio-40c1@gregkh>
References: <2026110456-scribing-radio-40c1@gregkh>
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
index 742e93f15c8f5..2b7aafca359bf 100644
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

