Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697EA2E22B5
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917482; cv=none; b=mWbODZR6ilYhEQx00CxPguI6iM2VWx2M2UkRFx6v1/a1X6N+EomLG7Qg8RUTaZ3LPN71c4K2P6Pd70FDLBle7ArIwIZoDQNXSOoBW9jP5nEXim9nSSuLgWedcWdDix7I4+jAe0ItMPaeO0XczOnh6//dFKrw8R2BWuSOTg32nUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917482; c=relaxed/simple;
	bh=aR0wKcLFb/axm+bJhaYk5oVU++wQNeHry7NfGiLpzCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mylc4dFafxXryM4M45ujVeclj5zM3+ZbSj2pRHLZsMlbEfSm8wt6Cx+bSf3LwMMM7h6thfhjmbm4SQ7KAlGTiYf47YL+WiZXHRfnqIoaZbd1ZIcALXXjSWfuL63OSD6ehF5v58YHDuGgZvRHI0SS8XNccAJyfo2KGm0mDJCL/J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARuAjTrs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARuAjTrs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DE21F00A3A;
	Wed,  9 Sep 2026 01:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917481;
	bh=xtuZtJzmxE037Ada/UInV/O3jmx+uaROPYPFqcTh2Ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ARuAjTrs3lnKNKwpY8GD4MZSTSXfU6PA5OpzmkrmySZr61nf5smBeNN97E/0EJ2Qv
	 53o4ABgHXdiJbAFqrXQjWkFlww5KaMuoH9DPIvq7FiVIO3AY1nNMtP8UVAIdbGOs04
	 m908XtnoKeBU/Yox9nF02mxT+Roc2VxXr0KIsanU3fvDkWWkIKyiWhJDesnomjx3VY
	 6FqFNJJoSvGDCF+WfyBGseArfv14/Ry+UdcDFx5okiCkboATCLdq9wwSGiw7DxDgNw
	 anrYYVzoBAdgwgrI1zQ56Sj5/htE/hrKYdqwNjf6WHX6Eg4jsz9BTWb9LSKt+QBh56
	 0YwoYhTy10v5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] rpc_unlink(): saner calling conventions
Date: Tue,  8 Sep 2026 21:31:16 -0400
Message-ID: <20260909013118.888220-2-sashal@kernel.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit bccea4ed060f1f6476ac7a0649ffa73f77d6e94c ]

1) pass it pipe instead of pipe->dentry
2) zero pipe->dentry afterwards
3) it always returns 0; why bother?

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

For the 6.6 backport, retain the existing explicit parent inode locking and
__rpc_rmpipe() removal path.  The latter reaches rpc_close_pipes(), which
already clears pipe->dentry under pipe->lock.

Stable-dep-of: 932a8cf6abb2 ("sunrpc: fix use-after-free in __rpc_clnt_handle_event and __rpc_clnt_remove_pipedir")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/blocklayout/rpc_pipefs.c    | 12 ++----------
 fs/nfs/nfs4idmap.c                 |  6 +-----
 fs/nfsd/nfs4recover.c              | 12 ++----------
 include/linux/sunrpc/rpc_pipe_fs.h |  2 +-
 net/sunrpc/auth_gss/auth_gss.c     |  6 +-----
 net/sunrpc/rpc_pipe.c              | 14 ++++++++------
 6 files changed, 15 insertions(+), 37 deletions(-)

diff --git a/fs/nfs/blocklayout/rpc_pipefs.c b/fs/nfs/blocklayout/rpc_pipefs.c
index ef9db135c649c..32411c8bcd89f 100644
--- a/fs/nfs/blocklayout/rpc_pipefs.c
+++ b/fs/nfs/blocklayout/rpc_pipefs.c
@@ -155,13 +155,6 @@ static struct dentry *nfs4blocklayout_register_sb(struct super_block *sb,
 	return dentry;
 }
 
-static void nfs4blocklayout_unregister_sb(struct super_block *sb,
-					  struct rpc_pipe *pipe)
-{
-	if (pipe->dentry)
-		rpc_unlink(pipe->dentry);
-}
-
 static int rpc_pipefs_event(struct notifier_block *nb, unsigned long event,
 			   void *ptr)
 {
@@ -189,8 +182,7 @@ static int rpc_pipefs_event(struct notifier_block *nb, unsigned long event,
 		nn->bl_device_pipe->dentry = dentry;
 		break;
 	case RPC_PIPEFS_UMOUNT:
-		if (nn->bl_device_pipe->dentry)
-			nfs4blocklayout_unregister_sb(sb, nn->bl_device_pipe);
+		rpc_unlink(nn->bl_device_pipe);
 		break;
 	default:
 		ret = -ENOTSUPP;
@@ -225,7 +217,7 @@ static void nfs4blocklayout_unregister_net(struct net *net,
 
 	pipefs_sb = rpc_get_sb_net(net);
 	if (pipefs_sb) {
-		nfs4blocklayout_unregister_sb(pipefs_sb, pipe);
+		rpc_unlink(pipe);
 		rpc_put_sb_net(net);
 	}
 }
diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index ec6afd3c4bca6..aba248fee440b 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -424,12 +424,8 @@ static void nfs_idmap_pipe_destroy(struct dentry *dir,
 		struct rpc_pipe_dir_object *pdo)
 {
 	struct idmap *idmap = pdo->pdo_data;
-	struct rpc_pipe *pipe = idmap->idmap_pipe;
 
-	if (pipe->dentry) {
-		rpc_unlink(pipe->dentry);
-		pipe->dentry = NULL;
-	}
+	rpc_unlink(idmap->idmap_pipe);
 }
 
 static int nfs_idmap_pipe_create(struct dentry *dir,
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 8ff61f6184e24..9878a8ee5e151 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -934,13 +934,6 @@ nfsd4_cld_register_sb(struct super_block *sb, struct rpc_pipe *pipe)
 	return dentry;
 }
 
-static void
-nfsd4_cld_unregister_sb(struct rpc_pipe *pipe)
-{
-	if (pipe->dentry)
-		rpc_unlink(pipe->dentry);
-}
-
 static struct dentry *
 nfsd4_cld_register_net(struct net *net, struct rpc_pipe *pipe)
 {
@@ -962,7 +955,7 @@ nfsd4_cld_unregister_net(struct net *net, struct rpc_pipe *pipe)
 
 	sb = rpc_get_sb_net(net);
 	if (sb) {
-		nfsd4_cld_unregister_sb(pipe);
+		rpc_unlink(pipe);
 		rpc_put_sb_net(net);
 	}
 }
@@ -2130,8 +2123,7 @@ rpc_pipefs_event(struct notifier_block *nb, unsigned long event, void *ptr)
 		cn->cn_pipe->dentry = dentry;
 		break;
 	case RPC_PIPEFS_UMOUNT:
-		if (cn->cn_pipe->dentry)
-			nfsd4_cld_unregister_sb(cn->cn_pipe);
+		rpc_unlink(cn->cn_pipe);
 		break;
 	default:
 		ret = -ENOTSUPP;
diff --git a/include/linux/sunrpc/rpc_pipe_fs.h b/include/linux/sunrpc/rpc_pipe_fs.h
index 3b35b6f6533aa..a8c0a500d55c0 100644
--- a/include/linux/sunrpc/rpc_pipe_fs.h
+++ b/include/linux/sunrpc/rpc_pipe_fs.h
@@ -129,7 +129,7 @@ struct rpc_pipe *rpc_mkpipe_data(const struct rpc_pipe_ops *ops, int flags);
 void rpc_destroy_pipe_data(struct rpc_pipe *pipe);
 extern struct dentry *rpc_mkpipe_dentry(struct dentry *, const char *, void *,
 					struct rpc_pipe *);
-extern int rpc_unlink(struct dentry *);
+extern void rpc_unlink(struct rpc_pipe *);
 extern int register_rpc_pipefs(void);
 extern void unregister_rpc_pipefs(void);
 
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 5f6d67023a1b0..2acd7052bedc9 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -873,12 +873,8 @@ static void gss_pipe_dentry_destroy(struct dentry *dir,
 		struct rpc_pipe_dir_object *pdo)
 {
 	struct gss_pipe *gss_pipe = pdo->pdo_data;
-	struct rpc_pipe *pipe = gss_pipe->pipe;
 
-	if (pipe->dentry != NULL) {
-		rpc_unlink(pipe->dentry);
-		pipe->dentry = NULL;
-	}
+	rpc_unlink(gss_pipe->pipe);
 }
 
 static int gss_pipe_dentry_create(struct dentry *dir,
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index e726821983f24..449eefa9f7c11 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -834,26 +834,28 @@ EXPORT_SYMBOL_GPL(rpc_mkpipe_dentry);
 
 /**
  * rpc_unlink - remove a pipe
- * @dentry: dentry for the pipe, as returned from rpc_mkpipe
+ * @pipe: the pipe to be removed
  *
  * After this call, lookups will no longer find the pipe, and any
  * attempts to read or write using preexisting opens of the pipe will
  * return -EPIPE.
  */
-int
-rpc_unlink(struct dentry *dentry)
+void
+rpc_unlink(struct rpc_pipe *pipe)
 {
+	struct dentry *dentry = pipe->dentry;
 	struct dentry *parent;
 	struct inode *dir;
-	int error = 0;
+
+	if (!dentry)
+		return;
 
 	parent = dget_parent(dentry);
 	dir = d_inode(parent);
 	inode_lock_nested(dir, I_MUTEX_PARENT);
-	error = __rpc_rmpipe(dir, dentry);
+	__rpc_rmpipe(dir, dentry);
 	inode_unlock(dir);
 	dput(parent);
-	return error;
 }
 EXPORT_SYMBOL_GPL(rpc_unlink);
 
-- 
2.53.0

