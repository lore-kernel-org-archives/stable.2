Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793935915;
	b=d+nvsXyQXfi1PYIK3Kr5z/Wqha/5Eok+iboub5gzgbpxrvjUl+k1S2DeyTI7q+r+tueH
	 lRnhuXGZHMPuFv2LZkdIdWXmnuafZ7AYK6m7K0dIoROYAD86pQus7R2B3JR1DtZ0PavzG
	 THwM5bN8EFGgnpP0NSQYD+ZdHqdkPsoq8L8w24w/Tj30T5Z7b6Fq6Dlhl2Ydo5hvoGMey
	 R7fdD6fHscey3p+O0eNvM37H6NXa0KW5c5bbsfeuv917O0prZA8XAnjcxr9Xhw3QSXOPE
	 c0rtlRv14tty02yKemP2M0mQgt3ij9g+VFCHIQfmyu35x0RhpmFriluhOTVG1qr2CTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793935915;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tVtdl8bfJp+7JcloG04326lojEnMFL1fTVf/YJLBlcw=;
	b=ZYceKdidOAZ2wQy6RojRuHnYetz7qJpuqavEhyf4NmW690wfluMlWT0w40Cb5pU4MGwD
	 QwN7KiHRyRfPE0gWyReftptZRP80ZuHB4RF62PvRYLe3t8waK38R+B0aZzzREZ+QZjdTF
	 zJno3ioAYjsO0oeOGH4+IAEs8/j2Rfkmx5UNPzG/CGCGV5Tm5KOnbtfdwE2HSyUAr1Ro9
	 j1cmokdbs+9AN0m6iHQ+hnfKdWVExNszxE8NkMkWpFqhIvkAtSRDuu4fw84OBE7m3JOj6
	 zMce819ANy+9r3BCtvkl9D45fPRUEQi7u6972FHvf4yId5g32FNVRvwMns2NQgxY0/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWyWn4iE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566EE606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 03:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWyWn4iE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2CC1F008A3;
	Fri,  6 Nov 2026 03:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793935914;
	bh=tVtdl8bfJp+7JcloG04326lojEnMFL1fTVf/YJLBlcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IWyWn4iEfbG8p3/9ohvpf2rrcaXFM2wi2zYRMcBHqwx24AVRfZsKh1/p+qFkYzOOi
	 iAQJDtoSe1j+UFWbJSzb7cVparJ81tzhT1WILzxU8PkhB0yVg768zPybNeQryqzW4G
	 vEFP8Y3VZPVSO5J4dc4GSbSL4C1SECmt3EqLUtE6ajpdR2PHlT+VJjRIwd2hAAOo7u
	 mDMJLVSxIDQG63h9r/x+JLkFg9/2M0GQRg3m0DAvQIWCQi03DJPtLXrCRdlUmE90zL
	 jzr7P4aq/lPdoz84xseMaqxmwBeGRRjJrDEFYUIwFzoBxELWZY3Nup2jTsCTUhVX+E
	 mzYqX9oOCIA/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] NFSD: Complete a cld upcall when copying its reply fails
Date: Thu,  5 Nov 2026 22:31:53 -0500
Message-ID: <20261106033145.4029374-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110445-revenge-computing-e665@gregkh>
References: <2026110445-revenge-computing-e665@gregkh>
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
Depends on <20261106031101.3999663-1-sashal@kernel.org>

 fs/nfsd/nfs4recover.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 89441b5cb0603..c570b2fdd9e65 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -915,8 +915,11 @@ cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
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

