Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929995;
	b=EFpL9jzuS/qNmKQI/P7cdV9s4hLWDugLLPhaI/E1wi5LmXeGnaIntEMeWZqQakok2n6g
	 LlawL4t27GBW8kFN7ZF3JGKDdU3wMaN/KvP4zhLG0RgqnmKAClQBwwyK3AoI13SGPEirG
	 xXLrGlPfbsAuKSksPuU+HHiIutk0xG9lxZE7dVOm8CQ/3zw+52TU3RS31lBX4YBFUUbf2
	 IKZyc6npIvfHsoNWKBMRJ0KjW8ATvyDtl/zq8BlSnIgC06PaRr5gw5i8JoBKN7k8xgSic
	 JxRfaVNNb0iENbsVVPlL/zVMtWkzo0qCvweo2NAQBjTSpKcaq4OJ3XG9RaIia3yMOHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929995;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mufJFxnO7hnapd1oRR/hzos8vAFCZBbkRUJ8MrpbzBo=;
	b=ow5bAGVlwN0NH/x6oQRqP4trmkNN8nkUkkKqKH+B6qEv+bnV1sl2PjjPuwSFeIebo6Tf
	 UxCAysIc5JioH6MryXivx5cMV1eIUX6S15Xtl7LJu4zES7UR89yB939EEeAMJ0PSGB1dl
	 UtHPmeqFtxdavclkYVtfezLXQyRv9oT/LmMgOpUH0ncjh4XcXkPoy3HrTkUIVtWDzSgva
	 5ch1WtsFLmwoEWoWEWTRKgydcjPaG0XAFxiU70IukLGNpsrZVElyej2ukk0kRQnlAAs7N
	 dLjTOb9+Zu63u3gBNMqiwRk0drsNQSSNDcaWNemb05gcA8WoMMB5hozMK9FMNPVYH9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0VXuqPC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E26606A332
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 01:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0VXuqPC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DF81F008A7;
	Fri,  6 Nov 2026 01:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793929995;
	bh=mufJFxnO7hnapd1oRR/hzos8vAFCZBbkRUJ8MrpbzBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K0VXuqPC83qSFgGpoAVOMWjOnT7QrASGaKm9IIlPqE2yoPoksIx5pYMddNS3VbZ2A
	 5WzLO97DpIrJBVFPr9Em4mXEflVPXdDNYVabe+aidOU1Xh9UtetwyQRmUZwkox7hSD
	 y/3OxVwxLn3DC4HzHiERx0VPo7jPT+J/yK+5pIa0ElJn+i3OEGd3T0Xz6D8HklwIvI
	 7pVrqP+SgiCQrd9Ng+oL8CHJ1B1fDGFMOZxZWU/dHduvQN6OYfhTXpPYyi3KEjcRG/
	 PpxygkJJ6IqTF/BjIVwD2gL35ANRaGomveRF+YNAoGB/olamLuQvSUyRXIIOL5joIB
	 +DIeyT0tPtAQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] NFSD: Set nn->cld_net before registering the cld pipe
Date: Thu,  5 Nov 2026 20:53:13 -0500
Message-ID: <20261106015248.3616655-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110431-crudeness-dreamboat-14d3@gregkh>
References: <2026110431-crudeness-dreamboat-14d3@gregkh>
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
[ sashal: adapted to the dentry-returning pipe registration API while retaining unconditional cn_has_legacy initialization ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4recover.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index f48cd56840942..c6e8a853bf5f5 100644
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

