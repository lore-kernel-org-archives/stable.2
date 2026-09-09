Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4CA2E7BD3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917483; cv=none; b=A+qt8dS/AEh365HDQGNRS9hDzr+E+DUZaltDdw1ZL0IZ7mpYPj3cZDwRqLZg8zgrZRfKZiBRhzxWo8jmD1mw274Bjw2Qs9WujOA+szhcXNGbohlPqjLgwNQuos3vHzBNpTYl1dhsLV14oVfnZRDEBqyPVYRRuDTDA4GVlbh1iro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917483; c=relaxed/simple;
	bh=VIH/XdOeVqaCAWWSLdgwbOX6hYphre8x8zDeDAMKpS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASrUEa8Ftt9uFaD+Y/1meepz8qNSAD8q6LD+Ld2uCi3SXwQZyIKza2zaIx0AJ4g96i1wWerXI0oGoU6F3UJAWx3q2AVbOyMMXp1TdWtHJRnMB+We+EH6uxZ3zU5QKcROJnqPHBPNqJeKNj7LFAfC1cR50YTa30CnHnFs8dPjunw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLXWbhCu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLXWbhCu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E2E1F00A3D;
	Wed,  9 Sep 2026 01:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917481;
	bh=bnkormakouFnyo8R9WZ9yxUQH1gnDxqJB52uk/81MDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hLXWbhCu32I20OsufHoIjU7GIdAnO2EoboweoRfmuPiwmKFW0yZumI2M+Sroqe6OR
	 B/3rEw08Pet8fwxN/WcYWEkJT5PE7xS0cZjeMAVVhfMcCjx/r4NWQxF+Rm5qjdn76w
	 u4zmmmubAe2InV8gHkHm400JjttfD5vkFhcwNXCXW71I15DtKcS9e2rNmYVD291sTJ
	 rcE4e3inV//VoA3LMXb5wpJJZnmX+SHOihQh0MyJtsgzzTN+GXQh5mgxfS+g4mDxS7
	 1Zb+9ruorXqlArb54pmqBzCtB6Qwu2iJDPg0P8JVs2NWybEF3+QmVB+P4KodBAAT2k
	 hx80dCVtzIUSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] rpc_create_client_dir(): return 0 or -E...
Date: Tue,  8 Sep 2026 21:31:17 -0400
Message-ID: <20260909013118.888220-3-sashal@kernel.org>
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
index 23536d3826bb3..4b2a717a915f3 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -121,7 +121,7 @@ static int rpc_setup_pipedir_sb(struct super_block *sb,
 	static uint32_t clntid;
 	const char *dir_name = clnt->cl_program->pipe_dir_name;
 	char name[15];
-	struct dentry *dir, *dentry;
+	struct dentry *dir;
 	int err;
 
 	dir = rpc_d_lookup_sb(sb, dir_name);
@@ -132,12 +132,9 @@ static int rpc_setup_pipedir_sb(struct super_block *sb,
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
index 449eefa9f7c11..5d08680da6a61 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1048,19 +1048,19 @@ static void rpc_clntdir_depopulate(struct dentry *dentry)
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

