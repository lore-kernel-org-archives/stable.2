Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971444;
	b=3XkcCmNJEfj1QadkFOQ7HIukyJ9OHj/nNUhN87hyTa3YkYJl0niiH0Ww06hZKkVhYs1C
	 ewUERfjby9fROk20a47yJnshSG4eHG54ncYly1nML060/W2TSm9lZupIw3JL4GRDY30Tc
	 EXlFTSbMY3+WBoGHTo9T9+UIsy0AUwzufZqBXXu8YFWfeQaiIONTh6gDEZyA/BsMxs1Oi
	 +PShKoRzxm+27471MXMBqNJ3hKCy34wZvBenLrj3Vv7GpIPHM0+mwt9t01cQRL7XDczHV
	 w/kslrBnHUpcMhsknFqew017Y7v7fCs+vZvdgwY7u6mhcZsAMJcSdN65dP5nT334KUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971444;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=W2iRppWdOcDn6YXFpkYw6b8mtawCsiDtOZWeV06xEIM=;
	b=fmXvAuivHwLPPueiQBuxpsKkmsFKxVgBm2MKbQF2t4fp24+hRmvW5HPhH0WoV4uEwR7H
	 CTKHGFr7c1ELbfHK9iQ66QiwfgUoJtbtP+v2gt3WF0nZbTdUTYfEAZbGfeMojrjGux93y
	 lCmMlsjDf6Z+bs17EKluLC82oVg3ghFCCwwFDEQQgfDP5xogQU1eEsKAbOUMaroGbyYzD
	 iRN73UfRrXAzpWCnrGMuo5pQjn6uBkhKI8rDXbjPj1slxJRpWEcORLiAsmuxPYBWtrHIu
	 NQZdGcRkAvgoZICMXyef6iWuf1+1STTWMQar3KQyUd3aVEaZ4ZB5HrUkYdheoYm9gvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpOxt9PP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EB2606A337
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpOxt9PP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227371F008A1;
	Fri,  6 Nov 2026 13:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971443;
	bh=W2iRppWdOcDn6YXFpkYw6b8mtawCsiDtOZWeV06xEIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MpOxt9PPGvjUahpsPQXDC19sGQTonu3G4gcGX22Z0FVUbxwfunqa1OO57Fftp/2ri
	 Cq45ZF7nrss49NGHRBGwUXw67ZvKIZus2ZOUoQEFjZBH1QAwk92pWu+UmyOCtD/cOE
	 g/sVTXyhk2h4sg6gZHO1F6P4dmgNOsbKYQ5gz3MoklFCF1j69yiY+a1A98LOobqSie
	 4KdQnRBZk9hyzJn+XIjq87f7/cUZqZyZ0G5igJ1YYPKyk2McsKLMZ4isPi8ScX86r9
	 e9C6RzQKz/Ony/VwCdwXoN0vUoJJ0gWYVXVixFLpUNNKaLf71ydab6I3ZLcrx5dwjR
	 3SKvT6DpCAcNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] NFSD: Complete a cld upcall when copying its reply fails
Date: Fri,  6 Nov 2026 08:24:01 -0500
Message-ID: <20261106132302.63251-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110446-dubbed-cabana-493a@gregkh>
References: <2026110446-dubbed-cabana-493a@gregkh>
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
Depends on <20261106125227.15863-1-sashal@kernel.org>

 fs/nfsd/nfs4recover.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index b2597a7c72311..1b19e8c087bf0 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -909,8 +909,11 @@ cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
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

