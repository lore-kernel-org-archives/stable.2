Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793935661;
	b=F0U25/PaRoGrweA1XMghHQGF9UChbUSnGqPHA/0LdotFJpJ7anp73I1DuIOE4CpDSFCo
	 ilsAFGpOvi7E3cMEXWeszFMQJiyV49LJo5+IaFXHLxzP453zEGVbBlOj6VmCpND6Hof2f
	 P7tT+mH7W7i2zV17ARWIRsNaPm1C6d6QHdXMUuRY3LAXFtzeKP7u5l4Qn6x87wVCkDGh8
	 EzpVZ0h4J64LOXjvtpydcP1j0Bn4yTAjCo00jg+BnxdVQo0WwKyo3R1RXSDCCrqwHoukh
	 bqbs6mz9+tCTq97G98xUZhi7gYeZz4ixVo5ijIGLBYt3LhCSDqEVaRue/Lye+UoeXBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793935661;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JhoR/fSrFG5Bl+D/S34kWTtE6s30HX1R6IW7XSJeqxo=;
	b=JRRxZWzm87m8gyDfWKoHMmgzPNuIi8WMDhO/2+fNVlsROW1Hv3rfWi0/n5wn9meJSlkA
	 1g90XNX3gyvRTo5QC2sqX8uV/IH2JLilCt3k7Ls1/1NaGTYRx0VtMOjkaGkqKHJDsTgMm
	 7jmiwWzJWEKnMTosewPsaQRClBT1MatSxI8a+V/SI7cfCtrXKFS2qAEilWZQJ1YPbqnCB
	 cXpqBFn/PMarvcWhsFMltzycC3uz8XpyCgbCJuSgJbnmFdRO6VdGlYV06Chk8mVVvxItf
	 GJOx+pRmtiXGGOPrxqDyEHU6SX7o21DFf8Bb1x5Lw/kdRagVHUySmqxKJcH9kBY1c5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SysInatS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97EB606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 03:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SysInatS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10CE1F0089F;
	Fri,  6 Nov 2026 03:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793935660;
	bh=JhoR/fSrFG5Bl+D/S34kWTtE6s30HX1R6IW7XSJeqxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SysInatSvd6p9MMYs70Zg9GmRnosvzEbp8TC8iw83wjGuy8/XfNJIJjsOKN071UXf
	 HtSXq2+eYHnIE/2zXnfTNVMIPRMhm5eJgVRLqs+114KAZHaxSKbGtNmSvaQFkSs8au
	 H7rMOW4jdEc41j/eV/hOa1p90JHl7wOgmjC+okblaL6tlpGv2VTm7u+k8OYZUocrNZ
	 TXs8LN32F2pi3RNjuVU7rRjY9sZwTZkmL0/5i/3gxFKa7oZ2dxwUM2zlpGsP4Zr3vT
	 wpz3yWnH56geeWFV+egtKuAKjahTewd8OdRw7l0u4CopRJNMOabYXl8qjLDp96LcxO
	 rbNG4Nh94rlpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	syzbot+d5c77cabf7a3492aa650@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] NFSD: Move the cld upcall message out of the caller's stack frame
Date: Thu,  5 Nov 2026 22:27:37 -0500
Message-ID: <20261106032728.4021201-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110455-splice-wrongdoer-64c7@gregkh>
References: <2026110455-splice-wrongdoer-64c7@gregkh>
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
index 2eebde725f71e..1255851179eef 100644
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

