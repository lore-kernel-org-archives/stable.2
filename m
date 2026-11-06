Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934116;
	b=PI3HWxgO+D5w5lz52NCXOP5ald6dFnXSiOl/+Im3jmts7f/J1mVkjSQ+z15NxAdXoZ0/
	 auwo1gHkmW8YWYybw1jJUqpRcfNqt++EgGThGVYDfeMjwgpigyzLiTT/SCUhjaR2kSvuS
	 U1c3sfwuLpzV2bOy8PXxe6f5+zpl/jRpRkwQm1pQtMtM4xGOhkhLj0f/xKSTuRXp3vlXm
	 M4b+JXnEzV8LfXhAOn2072buOJTtGDFsHF4GCJ0RLyuO3LG/L/+JDnnTpCnhVxqIFXdfp
	 fsNKVXotEhwPcXsuL5ZhnGAXBt4gP5aBGdN20fosf0Fu0314FWDy3+hORRnqjJOhGQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934116;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LiP+YjT/SZkQqZ1QpFK3jdreUCJrG4Baq0ucNMtq1oo=;
	b=e3Z0SCtFAN5FFwk6OQcOZFRrjbzb/uNPyyJLmFv8hpmPRQ4dhfKE4Lb6Bpv0pB3YsHQ2
	 Na4vUaw3B8sASv2e3LBPea0iq24UbujHbZX3PVZuwwaUiQCRWisewjIOVb2lFGQ9P4ZtO
	 TtisHeXxZDDQ3tMicFELMQOIBskDyokOpy26koc56+PbZ3dxelXySp0nzb+u+eMaMJ59v
	 hTYvkiX7QwlSke11NExmj5EHDdrG9sXbMdBOjd37vP8P/i3Q8gf2y8CxehPx2nyxXAiQx
	 Yf6veXilTstBq/LBZIuda1nzFyBN2R0TcDNb7wdXY5H3BJgcTjlli1wysCywSr4/5og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpzZZggq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59573606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 03:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpzZZggq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785151F008A1;
	Fri,  6 Nov 2026 03:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793934115;
	bh=LiP+YjT/SZkQqZ1QpFK3jdreUCJrG4Baq0ucNMtq1oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IpzZZggqj51mRP/0gDoWRAlruCcbRAY26ERWCmJWsZ4ZXiUC1XPjwUtG45qcQq941
	 /HKd6mOP1XW2Nhn348A5nuuHmsbxMs4mM7Xr2F2bCvld3DpVsnfdApcVjTEzanBqsL
	 o4Kmty6sklrARtA5NTvhX/5JDwp2te3LhF3EAerjnMlTSryfy6fnctAnOhd2Wyw5+T
	 3M/a0/UACP2Eiy/v+gmKQqzs2dShwmIFpfDsQcT3PqwJCARktf0YJSvuuHOE70idcV
	 kQK8fPcffmvFjIl/e1tLaAcU7DzwhvA6h10jpuBpZmNHq4Sdu36odSuDwm1Csbgkdu
	 XlSnfvGxKB9bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] NFSD: Complete a cld upcall when copying its reply fails
Date: Thu,  5 Nov 2026 22:01:54 -0500
Message-ID: <20261106030147.3979456-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110443-fifty-geometric-c564@gregkh>
References: <2026110443-fifty-geometric-c564@gregkh>
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

[ Upstream commit 8cef2b0a01d28647facc57501a3df7ccd8d13ccd ]

cld_pipe_downcall() removes the matching upcall from cn_list before
copying the daemon's reply. When that copy_from_user() faults, the
downcall returns -EFAULT without completing the upcall, and a
retried write cannot reach it because its xid is no longer on the
list. __cld_pipe_upcall() waits on cu_done uninterruptibly, so the
nfsd thread that sent the upcall is stuck, and nfsd shutdown hangs
behind it. The pipe is mode 0600, so only a broken or hostile
nfsdcld can trigger the fault.

Record the fault in the upcall's pipe message and complete it, so
the waiter returns the error to its client tracking operation.

Fixes: f3f8014862d8 ("nfsd: add the infrastructure to handle the cld upcall")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260901-alemi-v2-3-e163f94a3a6e@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261106024045.3935499-1-sashal@kernel.org>

 fs/nfsd/nfs4recover.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index e810ecb144950..83aba7ad39081 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -901,8 +901,11 @@ cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 	if (status == -EINPROGRESS)
 		return __cld_pipe_inprogress_downcall(cmsg, nn);
 
-	if (copy_from_user(&cup->cu_u.cu_msg_v2, src, mlen) != 0)
+	if (copy_from_user(&cup->cu_u.cu_msg_v2, src, mlen) != 0) {
+		cup->cu_pipe_msg.errno = -EFAULT;
+		complete(&cup->cu_done);
 		return -EFAULT;
+	}
 
 	complete(&cup->cu_done);
 	return mlen;
-- 
2.53.0

