Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F0C244694
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914194; cv=none; b=Nlixoj7NLmKNQgdFSz7TnykTb+wz9EKtRpnI0NqQ8V/5A6N+WRoeVkpvuDg/Lu7QxA5RNo2wavShuJylreClceKfaTw+ReEWYy9P0QzpaET4B5+yptacMXiAhoFYgpKDBBxdE3yogvlZWFIr0wGAkE03z8LrRY18TGr3XIXDqCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914194; c=relaxed/simple;
	bh=855poAZfwArhK2dxgV3Y15n/ZsEhIzaVQHtbA1Lv03A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCtF6mRYoQGibmzbWpyECCU4IP1q9FxuI6ZLk57NzTvoUZJbb/JFc1CNMsbLqZtofjMPL5E/PzSQUKLbrOkM0/lcSefmdARvfGekmySFc7ODyxwYw8VlSFUUUKzpXTEIhlguYaoh26Ep6p4FG+SxZ/IrH3gs/gSucFtjdwXOtew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DONeRwUI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DONeRwUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E658B1F00A3D;
	Wed,  9 Sep 2026 00:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914193;
	bh=HE+8jyg4JMptjYRG+43/1UXQPWnHr12H653zmAPok4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DONeRwUI/jSLf1Yyc40KNnk+LXtzhEYTgkkO10bFktRkVJuDumjKLUj3myDZIcscA
	 5aL7qON8YZhfhlm4DdX125h1yG6d6gjpI2r1uyCa/t4yH0dS41w7H8sum55KTp+AAS
	 /VIjFhtfsuig+CkSS9IiGYMX4ewjFhB15Mh6aSQhywafFdePoNxW4/7RZnjdD4LRwX
	 /V30xlZUWMrecTtLI44utiIB3AOAXSgxyLpJ7F/mZKaoJFWQ6DaqDawTu2gLtBuTkQ
	 jwvyGC+L/D2bkwWYUSijHRzYLhaCj02OW+7fGJK7HSxMvGjZY1/yvWp2zzU+CuFcdo
	 +TUojmHWm3Uig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] rpc_create_client_dir(): return 0 or -E...
Date: Tue,  8 Sep 2026 20:36:28 -0400
Message-ID: <20260909003629.747283-3-sashal@kernel.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 350db61fbeb940502a16e74153ee5954d03622e9 ]

Callers couldn't care less which dentry did we get - anything
valid is treated as success.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

For the 6.6 backport, retain rpc_mkdir_populate() and its existing
rpc_clntdir_populate() callback instead of depending on the newer
rpc_new_dir()/rpc_new_file() helpers. Convert the returned error pointer
to an integer error and return zero after recording the directory and
creating its pipe objects. Directory locking and failure cleanup remain
in the existing helpers.

An earlier dependency backport already converted rpc_setup_pipedir_sb()
and its callers to integer status. Keep those changes and simplify the
remaining rpc_create_client_dir() call to use its new return type,
including the existing -EEXIST retry. No functions are added. This leaves
target 932a8cf6abb2 applicable without conflicts.

Stable-dep-of: 932a8cf6abb2 ("sunrpc: fix use-after-free in __rpc_clnt_handle_event and __rpc_clnt_remove_pipedir")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/rpc_pipe_fs.h |  2 +-
 net/sunrpc/clnt.c                  |  9 +++------
 net/sunrpc/rpc_pipe.c              | 16 ++++++++--------
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/linux/sunrpc/rpc_pipe_fs.h b/include/linux/sunrpc/rpc_pipe_fs.h
index a8c0a500d55c0..571020651817e 100644
--- a/include/linux/sunrpc/rpc_pipe_fs.h
+++ b/include/linux/sunrpc/rpc_pipe_fs.h
@@ -98,7 +98,7 @@ static inline bool rpc_msg_is_inflight(const struct rpc_pipe_msg *msg) {
 }
 
 struct rpc_clnt;
-extern struct dentry *rpc_create_client_dir(struct dentry *, const char *, struct rpc_clnt *);
+extern int rpc_create_client_dir(struct dentry *, const char *, struct rpc_clnt *);
 extern int rpc_remove_client_dir(struct rpc_clnt *);
 
 extern void rpc_init_pipe_dir_head(struct rpc_pipe_dir_head *pdh);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index b2419d57df146..00c2d37cb8f50 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -123,7 +123,7 @@ static int rpc_setup_pipedir_sb(struct super_block *sb,
 	static uint32_t clntid;
 	const char *dir_name = clnt->cl_program->pipe_dir_name;
 	char name[15];
-	struct dentry *dir, *dentry;
+	struct dentry *dir;
 	int err;
 
 	dir = rpc_d_lookup_sb(sb, dir_name);
@@ -134,12 +134,9 @@ static int rpc_setup_pipedir_sb(struct super_block *sb,
 	for (;;) {
 		snprintf(name, sizeof(name), "clnt%x", (unsigned int)clntid++);
 		name[sizeof(name) - 1] = '\0';
-		dentry = rpc_create_client_dir(dir, name, clnt);
-		if (!IS_ERR(dentry)) {
-			err = 0;
+		err = rpc_create_client_dir(dir, name, clnt);
+		if (!err)
 			break;
-		}
-		err = PTR_ERR(dentry);
 		if (err == -EEXIST)
 			continue;
 		printk(KERN_INFO "RPC: Couldn't create pipefs entry"
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 68546b81c215e..79ee87a62426d 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1049,19 +1049,19 @@ static void rpc_clntdir_depopulate(struct dentry *dentry)
  * information about the client, together with any "pipes" that may
  * later be created using rpc_mkpipe().
  */
-struct dentry *rpc_create_client_dir(struct dentry *dentry,
-				   const char *name,
-				   struct rpc_clnt *rpc_client)
+int rpc_create_client_dir(struct dentry *dentry,
+			   const char *name,
+			   struct rpc_clnt *rpc_client)
 {
 	struct dentry *ret;
 
 	ret = rpc_mkdir_populate(dentry, name, 0555, NULL,
 				 rpc_clntdir_populate, rpc_client);
-	if (!IS_ERR(ret)) {
-		rpc_client->cl_pipedir_objects.pdh_dentry = ret;
-		rpc_create_pipe_dir_objects(&rpc_client->cl_pipedir_objects);
-	}
-	return ret;
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+	rpc_client->cl_pipedir_objects.pdh_dentry = ret;
+	rpc_create_pipe_dir_objects(&rpc_client->cl_pipedir_objects);
+	return 0;
 }
 
 /**
-- 
2.53.0

