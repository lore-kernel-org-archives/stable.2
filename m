Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA78339372
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445872; cv=none; b=Afeo60KfxBxpldA662+DMWAo5xMh5OnstxfoGFJeB8HLxh8vVAmz2SSD51wnusmospXtG9s5BrdJd7RVElWgfzHx3FaiO9QodNi/zNu0ghbnUiQP/l25+QJH2SuOkrM/DgGbRb5z1XWyXf54UkhPE37W2OSABYfFbY8poKwnPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445872; c=relaxed/simple;
	bh=1p6gIkfSmvmnOLK66aFzeAnsr7Q4h2Vs0DRY6VJNHIw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T6XIQN09MlXuQ20NmvIAOVmBtqNosGmyPg4vFUQdwzuLh7dMEF0n8XqhmT89XnZ/TMeqrqxx8VTPdULefZOulIQeA5GeJIQqvWA6mB3BU9FlRRii26f/PvL10klVmlxOS1qQoLaXoqZxaoQQM0vofbxCkLTE+TzsDuodd+fhX6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h1NFzbyo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h1NFzbyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8013B1F00A3D;
	Thu,  3 Sep 2026 14:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445844;
	bh=yfAyfa+1ajafARbfuVQ2aGg93E9xGbLYImFLdWvf6BU=;
	h=Subject:To:Cc:From:Date;
	b=h1NFzbyo8YQzjnAzpcjjsG0kk82Hf+BvOsoRjyd/ygJlTiIYQ+zonXeS7tmkjYyhF
	 851ds5MUvkSH2ozzXlqr5btEhZ2ipU1f3es1JtaTLNj4xFdBQvBxLDgWbDsoEXHN2g
	 kWyvMXcbaOAgjEwPERWoFb5JLBg7NmIBQ5rEBKpk=
Subject: FAILED: patch "[PATCH] sunrpc: fix use-after-free in __rpc_clnt_handle_event and" failed to apply to 5.10-stable tree
To: rakukuip@gmail.com,dstsmallbird@foxmail.com,enjou1224z@gmail.com,trond.myklebust@hammerspace.com,yuantan098@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:07:18 +0200
Message-ID: <2026090318-cardiac-animation-cfbb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 932a8cf6abb2b2f8677b79153a823108d8861fe2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090318-cardiac-animation-cfbb@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 932a8cf6abb2b2f8677b79153a823108d8861fe2 Mon Sep 17 00:00:00 2001
From: Luxiao Xu <rakukuip@gmail.com>
Date: Tue, 7 Jul 2026 13:20:47 +0800
Subject: [PATCH] sunrpc: fix use-after-free in __rpc_clnt_handle_event and
 __rpc_clnt_remove_pipedir

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

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index efa26899bc7d..6cedc824cf82 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -96,7 +96,10 @@ static void rpc_unregister_client(struct rpc_clnt *clnt)
 
 static void __rpc_clnt_remove_pipedir(struct rpc_clnt *clnt)
 {
-	rpc_remove_client_dir(clnt);
+	if (clnt->pipefs_sb) {
+		rpc_remove_client_dir(clnt);
+		clnt->pipefs_sb = NULL;
+	}
 }
 
 static void rpc_clnt_remove_pipedir(struct rpc_clnt *clnt)
@@ -177,19 +180,28 @@ static int rpc_clnt_skip_event(struct rpc_clnt *clnt, unsigned long event)
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

