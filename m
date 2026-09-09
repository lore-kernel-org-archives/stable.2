Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5265C2BE7BA
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915137; cv=none; b=J06qmtEU7PkmcF2qxfZcmmilEkAEEe8D6Tcm42PwVT7DlpDiH1QD2OV1GZFpWc8OXTvKWTdOCQj0xM8ORr5gooOPbMpB1EoWm+K5zCcMANGwXVgKEr5c3LJi3azEKR0iuXmYZ2/Oa8TKhdLkv1EkXf5yW7pcnSMsCH51+MLA3Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915137; c=relaxed/simple;
	bh=JMYJ/aEAb6LuM4CWYhQp4/nVB4BxLkqDZsDO+kJUWq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDDdnaFcn+btnjuTZsZ2IXl11yHgouAvUF1Owc2EcLigI6CHt4ATkoBJ/NXuFW8Ug/mF6se1/v5pk1JzPzBWO3V8kAnIEHO8Nl0b2ZzI3jX2tnaG9GUf9X+XAiYUAzSQEibGcrPZF2UnHllPUPjRHHsn4nxXchXfxOvnNWdjC0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdKAqmeu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdKAqmeu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9471F00A3D;
	Wed,  9 Sep 2026 00:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788915132;
	bh=v4X/GHsWQX11gHvuUs+QZQANqGpUz/Y8MIB0osXYWA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hdKAqmeuLjvtvznGjLSs2vdeekOQlf0G+l4HGYyh5VYlU1W0erxMEmspHBWl7TM3d
	 4fokrmGT8Rrbf0/Qka15zOZ76pKnz36tSI1w4edEgg51gzYSmoVgs7L5iHXwrdCjf9
	 10RT4nRkRKijdTPmpAILJuW0MBLX/ESE33pPjY/r+N/mu/3V8biG/NRRcCgO9+Jqau
	 h9rgpFmrHTtMcAY6EpuJGkhktmXDHO4ELRlWbMNqsFd5J04fI/B0j+ikSsZF45LcAQ
	 Jm52yIGXokI71aRpZMv6Rj5Pe1Idi+jHQzeByjzDSU4TMApyccuhcGFnO1pC7fCAii
	 Fjd5i981r513A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] rpc_populate(): lift cleanup into callers
Date: Tue,  8 Sep 2026 20:52:07 -0400
Message-ID: <20260909005210.805789-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090318-squad-abnormal-f798@gregkh>
References: <2026090318-squad-abnormal-f798@gregkh>
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
index 48ffdd4192538..48c372c676b5e 100644
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
index 35588f0afa864..7f31ed28c8d3e 100644
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

