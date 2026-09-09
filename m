Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE3A2E7396
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917484; cv=none; b=vBX7Y/yUJn8jyv+2TFUNJ5tWUh+mig8ip5ouO/i2w8axIrA/raewC9cukYLU5eW/2Jx7LH1eAevnlA2sy/A9t7Fud2khuJzuLbVUN9iR9+nQHR9Kz6AuHjlXf+Z4wS7RvUpH/ZMvJpYXyh9+7KzHWAkbA51Y5C8//jE+Pp/DvWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917484; c=relaxed/simple;
	bh=5yyA/76nOiHihPDikdDE+B8djmUb+tewEAFz7yY2e9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfevlORPYqKQGIYR2bxSTqbS1+ap6LD2vGRLf4JCDDxRItJf1M9KOtmxptt00imjBP/cFEoElhlD923VfTodHxNBo9HtPwW/qsN0K6oC7uFxLlAoCnQCBC0p+8y7pwxlGKOqfWdjJ6+U4rBTcNU4hCXj1WbY5/PE00qGKqqXEN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1mQO0DF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1mQO0DF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041EA1F00A3E;
	Wed,  9 Sep 2026 01:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917482;
	bh=ItIWrmHtTb77fW+sn1GNa4hV8rOaYAmc5uTlNTewuks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D1mQO0DFEMw8dqFLIb1fxZBLcN5LfcuzymU8sNuwp2WYXlfo6YzxaoCVMt3eegLfh
	 Rl8Ug4vMmWjCLlKeWOUXS8Kwv9yOD8n/UBUDOFrR8bxRYK9T+yQVbmjVCNaBykHuve
	 8/4UM15bdrxF7Q38pGum1stzFzccv10zxZG4/mgoGTnmL5Rr2wIAAxUuHN0hh4DTmU
	 bUWIc6eK1GVE4+HMBjsYuyF5JoqdNzsMNrvQg1kC56OebiLpM2fsKMTAufToolnkPi
	 g+WEzZZZFbNZHSeEBWytzw041AEX6cD6de2QiwXqtzgftAvuGeKHHcTDsVebKDu+hz
	 Stz8OP7kHBTsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luxiao Xu <rakukuip@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <dstsmallbird@foxmail.com>,
	Ren Wei <enjou1224z@gmail.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] sunrpc: fix use-after-free in __rpc_clnt_handle_event and __rpc_clnt_remove_pipedir
Date: Tue,  8 Sep 2026 21:31:18 -0400
Message-ID: <20260909013118.888220-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909013118.888220-1-sashal@kernel.org>
References: <2026090318-cardiac-animation-cfbb@gregkh>
 <20260909013118.888220-1-sashal@kernel.org>
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
index 4b2a717a915f3..2f976a49c56fd 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -99,7 +99,10 @@ static void rpc_unregister_client(struct rpc_clnt *clnt)
 
 static void __rpc_clnt_remove_pipedir(struct rpc_clnt *clnt)
 {
-	rpc_remove_client_dir(clnt);
+	if (clnt->pipefs_sb) {
+		rpc_remove_client_dir(clnt);
+		clnt->pipefs_sb = NULL;
+	}
 }
 
 static void rpc_clnt_remove_pipedir(struct rpc_clnt *clnt)
@@ -180,19 +183,28 @@ static int rpc_clnt_skip_event(struct rpc_clnt *clnt, unsigned long event)
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

