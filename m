Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4B14086A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915137; cv=none; b=OKv2yk9zSr9DhG7CoFQvz/tufa03jWMRrYhUDMgr5udNiD1uxFH2k3oIDrbeb8TU/GzPHz3XxtzY7s3sFLl4OB/lVZHjuDpI5Cj1D3GnA+UPaHpq9ydZ03Dhl7H6pVSor2/zksmJhPUtxK/BAi3Z3GDRD8I+RnDjio0mB2x41WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915137; c=relaxed/simple;
	bh=gkbcMsXPf3VLBm8ZY152fGe/f7tv/lxEbM5BN4IZlFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WouFdengLdbkoG0y73zlYNNipK8ikYKHoTsYFVhSu91q4V3hpWdUo1NJ8CyNOj5zoy/H+R1HR6VpD9Mszosu4wDIrxIe6an/ZesCd0ATXvFbs7EeZZpnTm9Bj+Ni6WNePsYIyJMxTvXSkXeO6i5xXEIOwvPBtwjiMgJRX3CePRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBLI7y+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBLI7y+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D791F00AC4;
	Wed,  9 Sep 2026 00:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788915135;
	bh=33d1uM9j9QuYZSDprE2nbShZH2Ok6VWgV63TVY4HKx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hBLI7y+FqeytYpJ580nC4sw9XTq5eTFdE7sim9tPhL/Ywnt8v8Aj1wUwXP2u/32NS
	 mjlM4raE5Z+51XSEpr3ysUGdUQbXLSMQphiQwNIK+bkEnRUHWUdkq+VCufcdZL7PJC
	 aDBUQpSG9RYLeZkb5LG33ZXYEe94J6eiygaIRZ3oL9zmb+0eYfsMTw6AVCXtx1qlK0
	 3OG6cIfsUATrIm5Ej5hSF9t8nkILCBeaA0JXxXxOOwB48WKII7ahrepx9FMw2HysB4
	 Lb4foUZqvXC7RzGfG7PlFgjZHK/ulu6oZxmcweumGy3ty35Fvp95Rcz5SILHIOd4UM
	 bjCx70XLEOUKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luxiao Xu <rakukuip@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <dstsmallbird@foxmail.com>,
	Ren Wei <enjou1224z@gmail.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] sunrpc: fix use-after-free in __rpc_clnt_handle_event and __rpc_clnt_remove_pipedir
Date: Tue,  8 Sep 2026 20:52:10 -0400
Message-ID: <20260909005210.805789-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909005210.805789-1-sashal@kernel.org>
References: <2026090318-squad-abnormal-f798@gregkh>
 <20260909005210.805789-1-sashal@kernel.org>
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
index 458c0eb9fa52e..82ecc1e9dd13b 100644
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

