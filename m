Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0773C465
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914193; cv=none; b=e5QsRVgvOQvF8JP+xI9ryDaLFat05l/5PeCAQFyx3lS7im9DOGtldRZCA7LqL2PSmxj0hMiaaUw+9G0sazJhMbR22iD+Tp5WvVpbKYwRQsnCswVqGiao8CkFLnx+DVk2qD0mCglyTOLen44OaapC4i+U1byPxk9omrVqRrqyrkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914193; c=relaxed/simple;
	bh=XnkrzolCuoK+a7ajcOp5iJB89G4NebItral4WoxZhNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnTY2BZyuqjGIyFh18SFc46wfduEjlLiD66I1GdUkgd0eNBpxA8STUH+g8AkWnNs+o/GbaFmvPbzk3DnCES3OkQWl1S4BhApzSk5powLJBeEGAxWn42thhbeSf3UGkCrlolv8MwXdyMp7H/2Ow4IHmByeFT2BDc8BwKrvVaG0NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jL/wwkWQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL/wwkWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DCC1F00A3A;
	Wed,  9 Sep 2026 00:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914191;
	bh=i0aLQsG50oVJrKWSYupwwthLI/0X7cCBNrVsNVkZbL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jL/wwkWQqY6Fj4pGrNm9y2zN9P2Dhgb6gpBSDQNfncV6oVLWJvBPt2CDOyEab1ou/
	 IKj3wGyp21sjoh8s9h4hR362adWacD1FR9+h8/51AXDdGLpDIuzA8U2EpqulKw0M/m
	 EbHiVTZm+NkZiK/0eMKmIqnpmaxY9isZFiWtDz80ieoRCfKkvMe9x1sTeiiUDVhAMo
	 9KCKQa0x9+TmInss9uTz81Wo7rCqYEhPLXRB+sCgag+N38d2kQZ0GEnqrGkOaNl9aP
	 VMpZXm9DZzrEgZrz3GC75z574UGUd1LO+UFQfJOxh6fphs1jaTn+gblN9Rs09M/B5E
	 ijRsXmfCBbIQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] rpc_populate(): lift cleanup into callers
Date: Tue,  8 Sep 2026 20:36:26 -0400
Message-ID: <20260909003629.747283-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090318-shame-passenger-1c99@gregkh>
References: <2026090318-shame-passenger-1c99@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 8be22c49646e47452e74aa0b97ea50fb04c271ed ]

rpc_populate() is called either from fill_super (where we don't
need to remove any files on failure - rpc_kill_sb() will take
them all out anyway) or from rpc_mkdir_populate(), where we need
to remove the directory we'd been trying to populate along with
whatever we'd put into it before we failed.  Simpler to combine
that into simple_recursive_removal() there.

Note that rpc_pipe is overlocking directories quite a bit -
locked parent is no obstacle to finding a child in dcache, so
keeping it locked won't prevent userland observing a partially
built subtree.

All we need is to follow minimal VFS requirements; it's not
as if clients used directory locking for exclusion - tree
changes are serialized, but that's done on ->pipefs_sb_lock.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: 932a8cf6abb2 ("sunrpc: fix use-after-free in __rpc_clnt_handle_event and __rpc_clnt_remove_pipedir")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/clnt.c     | 35 +++++++++++++++--------------------
 net/sunrpc/rpc_pipe.c | 10 +++++-----
 2 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index a390a4e5592f2..b2419d57df146 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -117,47 +117,49 @@ static void rpc_clnt_remove_pipedir(struct rpc_clnt *clnt)
 	}
 }
 
-static struct dentry *rpc_setup_pipedir_sb(struct super_block *sb,
+static int rpc_setup_pipedir_sb(struct super_block *sb,
 				    struct rpc_clnt *clnt)
 {
 	static uint32_t clntid;
 	const char *dir_name = clnt->cl_program->pipe_dir_name;
 	char name[15];
 	struct dentry *dir, *dentry;
+	int err;
 
 	dir = rpc_d_lookup_sb(sb, dir_name);
 	if (dir == NULL) {
 		pr_info("RPC: pipefs directory doesn't exist: %s\n", dir_name);
-		return dir;
+		return -ENOENT;
 	}
 	for (;;) {
 		snprintf(name, sizeof(name), "clnt%x", (unsigned int)clntid++);
 		name[sizeof(name) - 1] = '\0';
 		dentry = rpc_create_client_dir(dir, name, clnt);
-		if (!IS_ERR(dentry))
+		if (!IS_ERR(dentry)) {
+			err = 0;
 			break;
-		if (dentry == ERR_PTR(-EEXIST))
+		}
+		err = PTR_ERR(dentry);
+		if (err == -EEXIST)
 			continue;
 		printk(KERN_INFO "RPC: Couldn't create pipefs entry"
-				" %s/%s, error %ld\n",
-				dir_name, name, PTR_ERR(dentry));
+				" %s/%s, error %d\n",
+				dir_name, name, err);
 		break;
 	}
 	dput(dir);
-	return dentry;
+	return err;
 }
 
 static int
 rpc_setup_pipedir(struct super_block *pipefs_sb, struct rpc_clnt *clnt)
 {
-	struct dentry *dentry;
-
 	clnt->pipefs_sb = pipefs_sb;
 
 	if (clnt->cl_program->pipe_dir_name != NULL) {
-		dentry = rpc_setup_pipedir_sb(pipefs_sb, clnt);
-		if (IS_ERR(dentry))
-			return PTR_ERR(dentry);
+		int err = rpc_setup_pipedir_sb(pipefs_sb, clnt);
+		if (err && err != -ENOENT)
+			return err;
 	}
 	return 0;
 }
@@ -185,16 +187,9 @@ static int rpc_clnt_skip_event(struct rpc_clnt *clnt, unsigned long event)
 static int __rpc_clnt_handle_event(struct rpc_clnt *clnt, unsigned long event,
 				   struct super_block *sb)
 {
-	struct dentry *dentry;
-
 	switch (event) {
 	case RPC_PIPEFS_MOUNT:
-		dentry = rpc_setup_pipedir_sb(sb, clnt);
-		if (!dentry)
-			return -ENOENT;
-		if (IS_ERR(dentry))
-			return PTR_ERR(dentry);
-		break;
+		return rpc_setup_pipedir_sb(sb, clnt);
 	case RPC_PIPEFS_UMOUNT:
 		__rpc_clnt_remove_pipedir(clnt);
 		break;
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 0b6034fab9ab1..f3248ac830f27 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -726,7 +726,6 @@ static int rpc_populate(struct dentry *parent,
 	inode_unlock(dir);
 	return 0;
 out_bad:
-	__rpc_depopulate(parent, files, start, eof);
 	inode_unlock(dir);
 	printk(KERN_WARNING "%s: %s failed to populate directory %pd\n",
 			__FILE__, __func__, parent);
@@ -750,14 +749,15 @@ static struct dentry *rpc_mkdir_populate(struct dentry *parent,
 		goto out_err;
 	if (populate != NULL) {
 		error = populate(dentry, args_populate);
-		if (error)
-			goto err_rmdir;
+		if (error) {
+			inode_unlock(dir);
+			simple_recursive_removal(dentry, NULL);
+			return ERR_PTR(error);
+		}
 	}
 out:
 	inode_unlock(dir);
 	return dentry;
-err_rmdir:
-	__rpc_rmdir(dir, dentry);
 out_err:
 	dentry = ERR_PTR(error);
 	goto out;
-- 
2.53.0

