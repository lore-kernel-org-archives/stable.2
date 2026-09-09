Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E3A212550
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914194; cv=none; b=RXmtdpHUaRmJ9vQ0W/OXLrO9PHS/K8OzAIM7rz5ttE1v4BNapLT85wR66IODDbHaG/NVhWcbAQZFSK/9cXepKTxZwChJts3m09ES3KrypzWn7/mEmy83D6rr5q/04yTGXCTzI6NxKjYujmDqg0zDV0w/9pfvPbNE9QrXrqfVIMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914194; c=relaxed/simple;
	bh=o+Q0NLBmZC0irD1NPxkdsnyVqlLeEFPyO6pYhsQ555k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWoSs86r51zrf+eGSFzBSN77uwKhc5tm0HiyqGfYgqo59pU6wF1GnCos1k6eoFGC1QOZIoXD0x2X5SAZCFb/VoW+e2vDUMqole7sGdu5K3in/AO3w/GOg+0dF0dtCLTaRSeBz/Ohpn6T7DLdGKrpe5mUKfp4v576UFTvIlea/3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNum/xaB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNum/xaB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321691F00ACA;
	Wed,  9 Sep 2026 00:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914192;
	bh=FsZsJikq3R6U3nGPFibaQhahsR3OYKxzcVncuvpiSU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eNum/xaBrufPx+FQB440Fz6bmzEysPOOkYzHaWbX919H/1Xtnhl6Cq2mVTTPB6Rao
	 chsQDVcFvVMGIfRufHfbVJuvqeoky2FKYQH7dDQy/DRn1jNOTwqqQ5HVSJLAvccQhN
	 tfYqROnrRKot8uVMOPvlVgce+VTTzKzAhNzQAOAGZFcqIhvYEZ9M7lnbrkJI9oYEpw
	 Y+8kTBhjF7BgmnYLZCN75WMPIng0FTbfw5k8Tgpk+CIwe5oHYmuDZJhe1BMqKLVlsa
	 sVLH+755Ua5PJva9s+3ZW/rGZTVqkarpEwxgFrt/qfpLo+bApeEPv6b9eOBmYznvae
	 IeBvnhIK8utJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] rpc_unlink(): saner calling conventions
Date: Tue,  8 Sep 2026 20:36:27 -0400
Message-ID: <20260909003629.747283-2-sashal@kernel.org>
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
index 6c977288cc288..9f3155f40ce71 100644
--- a/fs/nfs/blocklayout/rpc_pipefs.c
+++ b/fs/nfs/blocklayout/rpc_pipefs.c
@@ -154,13 +154,6 @@ static struct dentry *nfs4blocklayout_register_sb(struct super_block *sb,
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
@@ -188,8 +181,7 @@ static int rpc_pipefs_event(struct notifier_block *nb, unsigned long event,
 		nn->bl_device_pipe->dentry = dentry;
 		break;
 	case RPC_PIPEFS_UMOUNT:
-		if (nn->bl_device_pipe->dentry)
-			nfs4blocklayout_unregister_sb(sb, nn->bl_device_pipe);
+		rpc_unlink(nn->bl_device_pipe);
 		break;
 	default:
 		ret = -ENOTSUPP;
@@ -224,7 +216,7 @@ static void nfs4blocklayout_unregister_net(struct net *net,
 
 	pipefs_sb = rpc_get_sb_net(net);
 	if (pipefs_sb) {
-		nfs4blocklayout_unregister_sb(pipefs_sb, pipe);
+		rpc_unlink(pipe);
 		rpc_put_sb_net(net);
 	}
 }
diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index e3fdd2f45b01f..f6cdc0340837c 100644
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
index 4f1f4d2c6bed1..9109da399f217 100644
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
index 85e6f6b3c6d8e..0a860525770be 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -874,12 +874,8 @@ static void gss_pipe_dentry_destroy(struct dentry *dir,
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
index f3248ac830f27..68546b81c215e 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -835,26 +835,28 @@ EXPORT_SYMBOL_GPL(rpc_mkpipe_dentry);
 
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

