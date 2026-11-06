Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793936207;
	b=zkoXa4GQK/BkIqSPH4ULe7t+CO9jUyspw50b232orxHgRU5Fbf973NmskNbb2WAwkLf9
	 1RhJLUMEdy+5GTXVvooJXLvM/UJHRmyay/nqICnXbITRAvAKpDT+RT4RYaK3m2N4DPgFT
	 Q2OHSSuCZlpOb6N7f25tMLJ9z5BDVlq2PAhWQZ/wFO9zO0zAKhRjxL2GFUpGLHwJfqHzr
	 GrnPEbsd2s0jYPwK4+D3uy2OcFz2jkx2fPjaDhzWovguNZlxPxL/j1C0o0xQsvPHvvOoY
	 eQezSlary9Go9NJbKLO/GSSUSaeg0JpK4rUhuoB1Z8sjowIuiYFjS+Q5dPGUQS2D9LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793936207;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SosuF+31wEMZ8fB3d6DvKdqkcszn220sZ+xq5R3Gmvo=;
	b=CJaGLAc8wiq6FsnRMgent6yGyXaQT5A92+p8px035CxKuKubzWUkiXiHAJEZq1DsgWXL
	 jdlMGvGolWmqDBH614hhvnS9RCnAJ5ePRpf4bSS7TXUeJ0BSrJ11XqlJcQnO8MTgHdu0k
	 SjgdmMLfNFWivhB+xDnOaz/NGPz9zouIzD7q964KqIQ4zrqBKCst4B0RxZjPD2+xsT3DL
	 waQZw0YDt6MeD4B1qwmZll6NYJCc6CeBWUbIaU22pGMHZYIrBHfpKYZIYq8XEOGodlGXj
	 +cjFe7NGz/GCFy1ThrB/nCflL82IX1QG/eWvPdfNFrVqTIM1EANUTD4/yJHgts3K5/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MD4WCtqM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40A8606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 03:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MD4WCtqM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09BE1F008A1;
	Fri,  6 Nov 2026 03:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793936206;
	bh=SosuF+31wEMZ8fB3d6DvKdqkcszn220sZ+xq5R3Gmvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MD4WCtqMasg7xXu9Cln4AvMUIup7+oihgvUWqVKgPy2TvwiOY9MghMTaI+blQbF/9
	 K41ee8hqwhIEG85eL9MoC2nXKMVPCv8k3ht4jknMpoVsNSH0r9teAc8DKBNRB4r6BF
	 1gwoX5gtnhLJkG9r/PFqzdB5BLYNXXKsvAIerT+KDkD4JEPNlXqZ71LUwt7UahEtcI
	 lN7gERwfXuJTlAVvY3NgYXz6iW9JQU55JMKcfLxZPOa/WtRviGD0CNrZp2ydKnZXOK
	 sbOVeSCLFGF4swAZkQ3AKGxBRLFoiAMjKrdCLM3+AEBPEBeRTtIQ3oCI+LjoJlE5g8
	 GfFsFCAzd+iSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] NFSD: Set nn->cld_net before registering the cld pipe
Date: Thu,  5 Nov 2026 22:36:44 -0500
Message-ID: <20261106033632.3949276-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110432-spoilage-unseemly-ecac@gregkh>
References: <2026110432-spoilage-unseemly-ecac@gregkh>
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
[ sashal: adjusted context around dentry-based pipe registration where cn_has_legacy is initialized unconditionally ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4recover.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index e0cb4856ca565..21917c024fb20 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -1014,6 +1014,13 @@ __nfsd4_init_cld_pipe(struct net *net)
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
@@ -1022,11 +1029,10 @@ __nfsd4_init_cld_pipe(struct net *net)
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

