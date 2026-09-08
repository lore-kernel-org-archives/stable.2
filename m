Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E1B4B4873
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907043; cv=none; b=qyeX4sktdhJ8G1OBcB1VtNmEk6MLeqoUApRL7rE6u0RDjaaHdQ3pn4oH/0T5/Zb2P2bqD4HihSGOyO+CpqzbkK93xllgG/G0ncaGGtn6m6+f509e7Qo4JXjSoR1eacT6u2kiDaf7kLuY6mKbFMUyCWz6V9n8NJWe5ig2+H11Oqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907043; c=relaxed/simple;
	bh=4Qri6XFepD7FV1En7rdZxh0NCCvD3UZcOBQUllVx1TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKMo93/IN+/9lcLjJVEJPKzOTqNdU+F6VybW2Qimlyl7toLX9d/cZlVGhcnXIdRl1UVzXsFZn3mvrwBp3AoOM2Ri+oLsA+ASUbgLgLESzmWxpTOGo4GZoDGeUNbfpHUMjFmlBPRqdK7inrIZ+wHOp6GWcUhPN3bkns/bM7Y0LGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6Cbw1g+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6Cbw1g+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9011F00A3E;
	Tue,  8 Sep 2026 22:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907037;
	bh=YdaZg5ERQx1QhCz9VomVMGc7WZihPk2/yH2U4jFH58A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h6Cbw1g+7RSmZNt5rTqhYDIySNkG+Ng1cU0ipPh/31KbYoJz3BsgNX5wbzYEdIjA9
	 xrkFTmkRZlsz7WCNeq4kZ8N5ZLtpDKgnyISXitSad/zi4Tcj3Wem86G32KkKEDnpZH
	 /sGOfQYRPnXFCQKAgo2z9V90L9zT2EybZdAQxMx88hiGoi4MLBTvYSSroPgQ4Finsd
	 WEK0KHkPEeCFIb5EXEJCnJtcV+r1KL2/0Y5qZhx+o/ht/54rJqL/h55kn6L3Xvt1yJ
	 J1I3jitVJMsogJr4hgcZNUjKDnH9U4S09DjFiT2lsgWFeulKBEjlvhxShQKdq4ANXe
	 lLBidQLA7ad2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] rpc_mkpipe_dentry(): saner calling conventions
Date: Tue,  8 Sep 2026 18:37:13 -0400
Message-ID: <20260908223715.507115-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908223715.507115-1-sashal@kernel.org>
References: <2026090317-curled-track-17d1@gregkh>
 <20260908223715.507115-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 19a6314a997f6adde0c100ecf9224d1ab43c9603 ]

Instead of returning a dentry or ERR_PTR(-E...), return 0 and store
dentry into pipe->dentry on success and return -E... on failure.

Callers are happier that way...

NOTE: dummy rpc_pipe is getting ->dentry set; we never access that,
since we
	1) never call rpc_unlink() for it (dentry is taken out by
->kill_sb())
	2) never call rpc_queue_upcall() for it (writing to that
sucker fails; no downcalls are ever submitted, so no replies are
going to arrive)
IOW, having that ->dentry set (and left dangling) is harmless,
if ugly; cleaner solution will take more massage.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: 932a8cf6abb2 ("sunrpc: fix use-after-free in __rpc_clnt_handle_event and __rpc_clnt_remove_pipedir")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/blocklayout/rpc_pipefs.c    | 41 ++++++++++++------------------
 fs/nfs/nfs4idmap.c                 |  8 +-----
 fs/nfsd/nfs4recover.c              | 37 ++++++++++-----------------
 include/linux/sunrpc/rpc_pipe_fs.h |  2 +-
 net/sunrpc/auth_gss/auth_gss.c     |  7 +----
 net/sunrpc/rpc_pipe.c              | 31 +++++++++++-----------
 6 files changed, 49 insertions(+), 77 deletions(-)

diff --git a/fs/nfs/blocklayout/rpc_pipefs.c b/fs/nfs/blocklayout/rpc_pipefs.c
index d8d50a88de04f..fda75dfe97b79 100644
--- a/fs/nfs/blocklayout/rpc_pipefs.c
+++ b/fs/nfs/blocklayout/rpc_pipefs.c
@@ -141,17 +141,18 @@ static const struct rpc_pipe_ops bl_upcall_ops = {
 	.destroy_msg	= bl_pipe_destroy_msg,
 };
 
-static struct dentry *nfs4blocklayout_register_sb(struct super_block *sb,
+static int nfs4blocklayout_register_sb(struct super_block *sb,
 					    struct rpc_pipe *pipe)
 {
-	struct dentry *dir, *dentry;
+	struct dentry *dir;
+	int err;
 
 	dir = rpc_d_lookup_sb(sb, NFS_PIPE_DIRNAME);
 	if (dir == NULL)
-		return ERR_PTR(-ENOENT);
-	dentry = rpc_mkpipe_dentry(dir, "blocklayout", NULL, pipe);
+		return -ENOENT;
+	err = rpc_mkpipe_dentry(dir, "blocklayout", NULL, pipe);
 	dput(dir);
-	return dentry;
+	return err;
 }
 
 static void nfs4blocklayout_unregister_sb(struct super_block *sb,
@@ -167,7 +168,6 @@ static int rpc_pipefs_event(struct notifier_block *nb, unsigned long event,
 	struct super_block *sb = ptr;
 	struct net *net = sb->s_fs_info;
 	struct nfs_net *nn = net_generic(net, nfs_net_id);
-	struct dentry *dentry;
 	int ret = 0;
 
 	if (!try_module_get(THIS_MODULE))
@@ -180,12 +180,7 @@ static int rpc_pipefs_event(struct notifier_block *nb, unsigned long event,
 
 	switch (event) {
 	case RPC_PIPEFS_MOUNT:
-		dentry = nfs4blocklayout_register_sb(sb, nn->bl_device_pipe);
-		if (IS_ERR(dentry)) {
-			ret = PTR_ERR(dentry);
-			break;
-		}
-		nn->bl_device_pipe->dentry = dentry;
+		ret = nfs4blocklayout_register_sb(sb, nn->bl_device_pipe);
 		break;
 	case RPC_PIPEFS_UMOUNT:
 		if (nn->bl_device_pipe->dentry)
@@ -203,18 +198,17 @@ static struct notifier_block nfs4blocklayout_block = {
 	.notifier_call = rpc_pipefs_event,
 };
 
-static struct dentry *nfs4blocklayout_register_net(struct net *net,
-						   struct rpc_pipe *pipe)
+static int nfs4blocklayout_register_net(struct net *net, struct rpc_pipe *pipe)
 {
 	struct super_block *pipefs_sb;
-	struct dentry *dentry;
+	int ret;
 
 	pipefs_sb = rpc_get_sb_net(net);
 	if (!pipefs_sb)
-		return NULL;
-	dentry = nfs4blocklayout_register_sb(pipefs_sb, pipe);
+		return 0;
+	ret = nfs4blocklayout_register_sb(pipefs_sb, pipe);
 	rpc_put_sb_net(net);
-	return dentry;
+	return ret;
 }
 
 static void nfs4blocklayout_unregister_net(struct net *net,
@@ -232,20 +226,17 @@ static void nfs4blocklayout_unregister_net(struct net *net,
 static int nfs4blocklayout_net_init(struct net *net)
 {
 	struct nfs_net *nn = net_generic(net, nfs_net_id);
-	struct dentry *dentry;
+	int err;
 
 	mutex_init(&nn->bl_mutex);
 	init_waitqueue_head(&nn->bl_wq);
 	nn->bl_device_pipe = rpc_mkpipe_data(&bl_upcall_ops, 0);
 	if (IS_ERR(nn->bl_device_pipe))
 		return PTR_ERR(nn->bl_device_pipe);
-	dentry = nfs4blocklayout_register_net(net, nn->bl_device_pipe);
-	if (IS_ERR(dentry)) {
+	err = nfs4blocklayout_register_net(net, nn->bl_device_pipe);
+	if (unlikely(err))
 		rpc_destroy_pipe_data(nn->bl_device_pipe);
-		return PTR_ERR(dentry);
-	}
-	nn->bl_device_pipe->dentry = dentry;
-	return 0;
+	return err;
 }
 
 static void nfs4blocklayout_net_exit(struct net *net)
diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 25a7c771cfd89..86d1e91f1e3bd 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -436,14 +436,8 @@ static int nfs_idmap_pipe_create(struct dentry *dir,
 		struct rpc_pipe_dir_object *pdo)
 {
 	struct idmap *idmap = pdo->pdo_data;
-	struct rpc_pipe *pipe = idmap->idmap_pipe;
-	struct dentry *dentry;
 
-	dentry = rpc_mkpipe_dentry(dir, "idmap", idmap, pipe);
-	if (IS_ERR(dentry))
-		return PTR_ERR(dentry);
-	pipe->dentry = dentry;
-	return 0;
+	return rpc_mkpipe_dentry(dir, "idmap", idmap, idmap->idmap_pipe);
 }
 
 static const struct rpc_pipe_dir_object_ops nfs_idmap_pipe_dir_object_ops = {
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index a8182962a2861..5ec98a95db8f7 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -926,17 +926,18 @@ static const struct rpc_pipe_ops cld_upcall_ops = {
 	.destroy_msg	= cld_pipe_destroy_msg,
 };
 
-static struct dentry *
+static int
 nfsd4_cld_register_sb(struct super_block *sb, struct rpc_pipe *pipe)
 {
-	struct dentry *dir, *dentry;
+	struct dentry *dir;
+	int err;
 
 	dir = rpc_d_lookup_sb(sb, NFSD_PIPE_DIR);
 	if (dir == NULL)
-		return ERR_PTR(-ENOENT);
-	dentry = rpc_mkpipe_dentry(dir, NFSD_CLD_PIPE, NULL, pipe);
+		return -ENOENT;
+	err = rpc_mkpipe_dentry(dir, NFSD_CLD_PIPE, NULL, pipe);
 	dput(dir);
-	return dentry;
+	return err;
 }
 
 static void
@@ -946,18 +947,18 @@ nfsd4_cld_unregister_sb(struct rpc_pipe *pipe)
 		rpc_unlink(pipe->dentry);
 }
 
-static struct dentry *
+static int
 nfsd4_cld_register_net(struct net *net, struct rpc_pipe *pipe)
 {
 	struct super_block *sb;
-	struct dentry *dentry;
+	int err;
 
 	sb = rpc_get_sb_net(net);
 	if (!sb)
-		return NULL;
-	dentry = nfsd4_cld_register_sb(sb, pipe);
+		return 0;
+	err = nfsd4_cld_register_sb(sb, pipe);
 	rpc_put_sb_net(net);
-	return dentry;
+	return err;
 }
 
 static void
@@ -977,7 +978,6 @@ static int
 __nfsd4_init_cld_pipe(struct net *net)
 {
 	int ret;
-	struct dentry *dentry;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct cld_net *cn;
 
@@ -998,13 +998,10 @@ __nfsd4_init_cld_pipe(struct net *net)
 	spin_lock_init(&cn->cn_lock);
 	INIT_LIST_HEAD(&cn->cn_list);
 
-	dentry = nfsd4_cld_register_net(net, cn->cn_pipe);
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
+	ret = nfsd4_cld_register_net(net, cn->cn_pipe);
+	if (unlikely(ret))
 		goto err_destroy_data;
-	}
 
-	cn->cn_pipe->dentry = dentry;
 #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 	cn->cn_has_legacy = false;
 #endif
@@ -2132,7 +2129,6 @@ rpc_pipefs_event(struct notifier_block *nb, unsigned long event, void *ptr)
 	struct net *net = sb->s_fs_info;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct cld_net *cn = nn->cld_net;
-	struct dentry *dentry;
 	int ret = 0;
 
 	if (!try_module_get(THIS_MODULE))
@@ -2145,12 +2141,7 @@ rpc_pipefs_event(struct notifier_block *nb, unsigned long event, void *ptr)
 
 	switch (event) {
 	case RPC_PIPEFS_MOUNT:
-		dentry = nfsd4_cld_register_sb(sb, cn->cn_pipe);
-		if (IS_ERR(dentry)) {
-			ret = PTR_ERR(dentry);
-			break;
-		}
-		cn->cn_pipe->dentry = dentry;
+		ret = nfsd4_cld_register_sb(sb, cn->cn_pipe);
 		break;
 	case RPC_PIPEFS_UMOUNT:
 		if (cn->cn_pipe->dentry)
diff --git a/include/linux/sunrpc/rpc_pipe_fs.h b/include/linux/sunrpc/rpc_pipe_fs.h
index f4b9ea5c83ea1..c3bab2313e8cc 100644
--- a/include/linux/sunrpc/rpc_pipe_fs.h
+++ b/include/linux/sunrpc/rpc_pipe_fs.h
@@ -127,7 +127,7 @@ extern void rpc_remove_cache_dir(struct dentry *);
 
 struct rpc_pipe *rpc_mkpipe_data(const struct rpc_pipe_ops *ops, int flags);
 void rpc_destroy_pipe_data(struct rpc_pipe *pipe);
-extern struct dentry *rpc_mkpipe_dentry(struct dentry *, const char *, void *,
+extern int rpc_mkpipe_dentry(struct dentry *, const char *, void *,
 					struct rpc_pipe *);
 extern int rpc_unlink(struct dentry *);
 extern int register_rpc_pipefs(void);
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 759d1e03f8c31..8407a4464680e 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -902,13 +902,8 @@ static int gss_pipe_dentry_create(struct dentry *dir,
 		struct rpc_pipe_dir_object *pdo)
 {
 	struct gss_pipe *p = pdo->pdo_data;
-	struct dentry *dentry;
 
-	dentry = rpc_mkpipe_dentry(dir, p->name, p->clnt, p->pipe);
-	if (IS_ERR(dentry))
-		return PTR_ERR(dentry);
-	p->pipe->dentry = dentry;
-	return 0;
+	return rpc_mkpipe_dentry(dir, p->name, p->clnt, p->pipe);
 }
 
 static const struct rpc_pipe_dir_object_ops gss_pipe_dir_object_ops = {
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 43119907010e3..5556e25ffc35a 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -799,7 +799,7 @@ static int rpc_rmdir_depopulate(struct dentry *dentry,
  * The @private argument passed here will be available to all these methods
  * from the file pointer, via RPC_I(file_inode(file))->private.
  */
-struct dentry *rpc_mkpipe_dentry(struct dentry *parent, const char *name,
+int rpc_mkpipe_dentry(struct dentry *parent, const char *name,
 				 void *private, struct rpc_pipe *pipe)
 {
 	struct dentry *dentry;
@@ -814,21 +814,19 @@ struct dentry *rpc_mkpipe_dentry(struct dentry *parent, const char *name,
 
 	inode_lock_nested(dir, I_MUTEX_PARENT);
 	dentry = __rpc_lookup_create_exclusive(parent, name);
-	if (IS_ERR(dentry))
-		goto out;
+	if (IS_ERR(dentry)) {
+		inode_unlock(dir);
+		return PTR_ERR(dentry);
+	}
 	err = __rpc_mkpipe_dentry(dir, dentry, umode, &rpc_pipe_fops,
 				  private, pipe);
-	if (err)
-		goto out_err;
-out:
+	if (unlikely(err))
+		pr_warn("%s() failed to create pipe %pd/%s (errno = %d)\n",
+			__func__, parent, name, err);
+	else
+		pipe->dentry = dentry;
 	inode_unlock(dir);
-	return dentry;
-out_err:
-	dentry = ERR_PTR(err);
-	printk(KERN_WARNING "%s: %s() failed to create pipe %pd/%s (errno = %d)\n",
-			__FILE__, __func__, parent, name,
-			err);
-	goto out;
+	return err;
 }
 EXPORT_SYMBOL_GPL(rpc_mkpipe_dentry);
 
@@ -1326,10 +1324,13 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 		goto out;
 	}
 
-	pipe_dentry = rpc_mkpipe_dentry(clnt_dentry, "gssd", NULL, pipe_data);
-	if (IS_ERR(pipe_dentry)) {
+	ret = rpc_mkpipe_dentry(clnt_dentry, "gssd", NULL, pipe_data);
+	if (ret) {
 		__rpc_depopulate(clnt_dentry, gssd_dummy_info_file, 0, 1);
 		__rpc_depopulate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1);
+		pipe_dentry = ERR_PTR(ret);
+	} else {
+		pipe_dentry = pipe_data->dentry;
 	}
 out:
 	dput(clnt_dentry);
-- 
2.53.0

