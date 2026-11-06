Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793933968;
	b=V94zc5brbhjH2WrlTLjTlLy1UDy3OqkrMYjZgewjC1xGHbiuMHrQBnP6ntsBRqtW15Jf
	 PRKDBgowHksy/Rijp8nvip316rj8Z7ctIGaix8R4Gq1t9izRvpqrNuI3912ZOeRZ0HHj1
	 3xjmjq1xZyyCuvHwp2MAq9qHMtHZl9pMPlLHjOIN/8D33gEADFPmbMVWoijahz2LfsAUT
	 x8oFwqWyxihyAQshgyjccgPO+MN9zX8SSzVYK4xoNIx634WPFuhX/hOQLXn2E9uwzMO7h
	 OxLdYylaRFoH57MPBT0sX6WCN+vxPPAvP2VaUhqMTEXwnSIwojM62uvgO1DgAuSqE5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793933968;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2xM7ilbUrVl91JV0+ZiZ+00pPVP9keJyhUy+Qn21GNs=;
	b=xYHAohxcnkcikiwkqXI/TSf1qQ2q5sAmgvbYOLQjloYbySnQUf/X81ThkfVG+2OHLaC+
	 G1M8U/q+rYCzyPPkifxnJErNBHEHQw8d3a+L4hq62pU+5EGFSJXA05FTiBX0TtmTKOzq/
	 iFQKYsUSuJqpn65DTinEZQZZ3GQs7U3oAsdV31NdkaariXuOTygw8JdA0tXqJGd6jz3E9
	 jGFYy7TaydaIovYQjEOyheythss0E8GErtuM/0if2GWe6ir7ecC+pjqmuj4VeaMffHJ5L
	 G89emN7pqUg6MmiJqrOi4YsNlFaUo7bncGRmyzBfaF4A7HWlVyOnvH4o14/5OJHiBIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+0kVpFV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A743606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+0kVpFV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5D21F008A2;
	Fri,  6 Nov 2026 02:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793933968;
	bh=2xM7ilbUrVl91JV0+ZiZ+00pPVP9keJyhUy+Qn21GNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a+0kVpFVTThHzfxh9JAwBpxuSUNfJR465X4XFGAaBRvw4dmqtdAT14gmqt8X/tbhs
	 zn4RltPF9wmwMk95qZ9LV4gx/KyIkMAanE6cdcau9yPn3XtywSB028K9SsLGRbJp1t
	 z+3qLZq7dllf1dr8hGZHSy0MYD9M8rNpFmzPq+F0WCTYZsHyTFbVACm04IcNIlxmzd
	 6/euArQ1DVIuzghwQKqIYqrRDAdbjDhrd1LvrIXIYVWFd1c1vBYKFPNcN2PQL4M+me
	 zVUJPKMwdd/NR0kZTvbQc9ey1TlntsIVjn7QaJaL+hgK0QUAvye0nR2yXL/vg4MToa
	 zAP55RJKKr8Qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	syzbot+d5c77cabf7a3492aa650@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] NFSD: Move the cld upcall message out of the caller's stack frame
Date: Thu,  5 Nov 2026 21:59:25 -0500
Message-ID: <20261106025913.3959182-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110453-devotee-unsuited-ab14@gregkh>
References: <2026110453-devotee-unsuited-ab14@gregkh>
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
index 104dafbe881bc..b493bb059a8b0 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -730,6 +730,7 @@ struct cld_upcall {
 	struct completion	 cu_done;
 	/* daemon has read the whole upcall; protected by cn_lock */
 	bool			 cu_inflight;
+	struct rpc_pipe_msg	 cu_pipe_msg;
 	union {
 		struct cld_msg_hdr	 cu_hdr;
 		struct cld_msg		 cu_msg;
@@ -741,22 +742,22 @@ static int
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
@@ -929,9 +930,8 @@ cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
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

