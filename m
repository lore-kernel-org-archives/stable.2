Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95307212550
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914195; cv=none; b=JoSNRd9g3ikhMdCG2PxXtO2fn2k5kUT1YgHiKHAC4e1sKaAsCMphF8KOttUdHS99fsBzFY/xA5DQjoYtHlYHb7xQEFasgS7bDGxmMus7Kd6RrYrWMxg3aHKkRr4XO3127JDWUjykRmN56Aeku75MIloDz385q51uVR7bnVI8MnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914195; c=relaxed/simple;
	bh=UbwuO5GR+XQh4Jpdjv8aneTuCTX/chBTnxDo5IQ2tK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4dvQgY5obDgHhWK/QJX0m0dSUjU+aMcVkqobLzGVQ0rZtdqxKV9BUSzkWLHPqLmtjuyN1EOWf3SC0ZRPvdGu5IAqvfpnV/EOgFzooxDqp6cETDS5Ouidv9L4ZQA6fYmn253uzZVXEmllBCzcqFGy4fWH3mcIW74ksiuP4qR8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nK+wVwsz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nK+wVwsz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0581F00A3A;
	Wed,  9 Sep 2026 00:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914194;
	bh=pOIvj1EVA/a5M77hLqbqtvoCZrcSoPFjOCr/0k/20ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nK+wVwszE0LHQGvepWM+4aqbj6ZrsO8eThjbXKGZgaOHwOxFEWsYRJbmX+rCSsavW
	 ecBF8tjaUdQBO8yfPwGNYZz6XoCuPJ4/vieAfukb8S6bL4GF3utyQV/QGXWC6Yar2T
	 b4UyAN1Qi8joGg+NWNtW7Dl5hus/GeVopldYuYxo7wfE0Ri93gZ05SwAg3QURGeZl1
	 Su8+M544Xu7TeU+qg+1GKNLb38AxlMKo1i1U/k89D5h7hT+7ABArJ1Z9pIJnxHC/FS
	 GpTWRli8DL3y/6sV4N/afvTpplc72/+p5QMe4p5Sfityc8J00x8jy8HCuAR709ZkKV
	 f7meRpPPTdROQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luxiao Xu <rakukuip@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <dstsmallbird@foxmail.com>,
	Ren Wei <enjou1224z@gmail.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] sunrpc: fix use-after-free in __rpc_clnt_handle_event and __rpc_clnt_remove_pipedir
Date: Tue,  8 Sep 2026 20:36:29 -0400
Message-ID: <20260909003629.747283-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909003629.747283-1-sashal@kernel.org>
References: <2026090318-shame-passenger-1c99@gregkh>
 <20260909003629.747283-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

[ Upstream commit 932a8cf6abb2b2f8677b79153a823108d8861fe2 ]

Normal client creation goes through rpc_setup_pipedir(), which records
clnt->pipefs_sb, but the mount-event path in __rpc_clnt_handle_event()
calls rpc_setup_pipedir_sb() directly and never refreshes that field.
The umount path also removes the directory without clearing
clnt->pipefs_sb.

After a late pipefs mount or any remount, rpc_clnt_remove_pipedir()
compares the current superblock against a stale pipefs_sb pointer and
skips cleanup, leaving pipefs dentries whose inode private data still
points at a freed rpc_clnt, leading to a potential use-after-free during
subsequent rpc_info_open() or rpc_show_info() calls.

Fix this by properly updating clnt->pipefs_sb upon mount events and
clearing it during unmount or failure paths.

Fixes: bfca5fb4e97c ("SUNRPC: Fix RPC client cleaned up the freed pipefs dentries")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <dstsmallbird@foxmail.com>
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/clnt.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 00c2d37cb8f50..adfef480a9fa3 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -101,7 +101,10 @@ static void rpc_unregister_client(struct rpc_clnt *clnt)
 
 static void __rpc_clnt_remove_pipedir(struct rpc_clnt *clnt)
 {
-	rpc_remove_client_dir(clnt);
+	if (clnt->pipefs_sb) {
+		rpc_remove_client_dir(clnt);
+		clnt->pipefs_sb = NULL;
+	}
 }
 
 static void rpc_clnt_remove_pipedir(struct rpc_clnt *clnt)
@@ -182,19 +185,28 @@ static int rpc_clnt_skip_event(struct rpc_clnt *clnt, unsigned long event)
 }
 
 static int __rpc_clnt_handle_event(struct rpc_clnt *clnt, unsigned long event,
-				   struct super_block *sb)
+				    struct super_block *sb)
 {
+	int err = 0;
+
 	switch (event) {
 	case RPC_PIPEFS_MOUNT:
-		return rpc_setup_pipedir_sb(sb, clnt);
+		clnt->pipefs_sb = sb;
+		err = rpc_setup_pipedir_sb(sb, clnt);
+		if (err)
+			clnt->pipefs_sb = NULL;
+		break;
 	case RPC_PIPEFS_UMOUNT:
-		__rpc_clnt_remove_pipedir(clnt);
+		if (clnt->pipefs_sb == sb) {
+			__rpc_clnt_remove_pipedir(clnt);
+			clnt->pipefs_sb = NULL;
+		}
 		break;
 	default:
 		printk(KERN_ERR "%s: unknown event: %ld\n", __func__, event);
 		return -ENOTSUPP;
 	}
-	return 0;
+	return err;
 }
 
 static int __rpc_pipefs_event(struct rpc_clnt *clnt, unsigned long event,
-- 
2.53.0

