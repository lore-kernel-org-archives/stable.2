Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793932684;
	b=g2Ab3Y5zdZ9tKTErm5mThV0OCBcHc/Vp5D4HV36+5tiylvTqEz8MybVQvaJiGLFFYHfu
	 oWIUELXegXTfovlvUD9r4U8Zut/78pbR7Wf333sAd1RPYFyUyDtHcq6TpHhFssgfF0c9c
	 o2XdHyfrGfZQbX8KyqUcltLVBdKZgPGiZ8anzZA99WMOfG/1uvb7Vlk6XVyPYNSNDy8tz
	 ZDUpo3AwAfxJzqjEU9oNc19N1Avzvlz73Hz7rqScHimK3D5FIXgHSVOB0CAupWp+gKDrI
	 ArMDKGGVzrsMj9ROr/Qu5DcTifiao1luuutQyOWZsIcNWlBE3vbTN9Ii2bWnaPt1wqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932684;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=w3VqbDHHeTff0hi3d8s1zwaJ/46xh6u98b9+QW4VLBE=;
	b=by6tnK26S+47PFq+v/hydFnhiEF4c8Z+M5wAaZAUsk2V+5lM4EJ5aZqzZnslipaz/xE5
	 fuqtZQMI3uxR7lNIeHd6Jj+p/6jf870tx8w7+Gk1EcJpTp8pZb87Qe99I0hwoYs3mRSql
	 vbj4X2fHtBCb4CqzHt35ICgDtp9lxP4JO5YRd8pK9Oq0LAi+6jy6a7MKHz6QkKnRtzsYw
	 nWoRtQyKz8gTdDpYZZvAI7js3FtPUC0QBBpOEvxojg+d9ZVsTBAgnvbvFUPmpSIkFMkZV
	 f4D/prY5art6owCdKB5RSLMCduqFNxNBKWFr28y0fNpr7Q5fvVREZyNI/2GnU7SSNXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lmemfl+U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF3E606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lmemfl+U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316E21F0089F;
	Fri,  6 Nov 2026 02:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793932683;
	bh=w3VqbDHHeTff0hi3d8s1zwaJ/46xh6u98b9+QW4VLBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lmemfl+UmJJt9m2LAnIG4ZSRxmDFPcCXEdyPXFGXzstw8gJq5ab5mgJ2ETycUFE9F
	 6AllOGR+g7TeQ+aeKjusSxana8rzsAZI6/TnrXkZ57Qu8O1TXUcW3aaOO5inbyjRpV
	 I6x3Wv6TPaKja/Gm1N5coawJCPRrkGWjISHzKcPxYC+JEYz7FLCv7jlbFkH0nOmq0x
	 7BPphlGyPpImYUYuBx1oCs56GpMhatW/7SwwQv7kM19Oiuo2Z47YaUs84v5xAjet4n
	 v5wkVh9l0YP+WA31oSvUKw++478GDxD224Xkv7Y12hUi3s+dCrhPv+++eWbbrhTf7W
	 1X+y7F/B5ON+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] NFSD: Set nn->cld_net before registering the cld pipe
Date: Thu,  5 Nov 2026 21:38:01 -0500
Message-ID: <20261106023715.3723680-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110432-unearth-superjet-be12@gregkh>
References: <2026110432-unearth-superjet-be12@gregkh>
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

[ Upstream commit 14996e662f3b734427e2d645cacffc27b779f7d1 ]

rpc_mkpipe_dentry() instantiates the pipe's dentry before it returns,
so the cld pipe can be opened as soon as nfsd4_cld_register_net() has
run. __nfsd4_init_cld_pipe() does not store the new cld_net in
nn->cld_net until after that call. cld_pipe_downcall() reaches the
cld_net only through that pointer and takes cn_lock without checking
it, so a write() that lands in the window oopses.

Store nn->cld_net once @cn is fully initialized and before the pipe is
registered, and clear it again when registration fails.

Fixes: f3f8014862d8 ("nfsd: add the infrastructure to handle the cld upcall")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260901-alemi-v2-6-e163f94a3a6e@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
[ sashal: Omitted the CONFIG_NFSD_LEGACY_CLIENT_TRACKING guard around cn_has_legacy initialization. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4recover.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 2eebde725f71e..d91b912fb7d0b 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -1020,6 +1020,13 @@ __nfsd4_init_cld_pipe(struct net *net)
 	}
 	spin_lock_init(&cn->cn_lock);
 	INIT_LIST_HEAD(&cn->cn_list);
+	cn->cn_has_legacy = false;
+
+	/*
+	 * The pipe's methods reach @cn through nn->cld_net, so set
+	 * it before the pipe can be opened.
+	 */
+	nn->cld_net = cn;
 
 	dentry = nfsd4_cld_register_net(net, cn->cn_pipe);
 	if (IS_ERR(dentry)) {
@@ -1028,11 +1035,10 @@ __nfsd4_init_cld_pipe(struct net *net)
 	}
 
 	cn->cn_pipe->dentry = dentry;
-	cn->cn_has_legacy = false;
-	nn->cld_net = cn;
 	return 0;
 
 err_destroy_data:
+	nn->cld_net = NULL;
 	rpc_destroy_pipe_data(cn->cn_pipe);
 err:
 	kfree(cn);
-- 
2.53.0

