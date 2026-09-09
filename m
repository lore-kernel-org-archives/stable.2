Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17862931E9
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915137; cv=none; b=WAPUrTQl9Zom7i54W9dND/o7E6p8hUKzLIQT0EbYKxH1RD6YxjMpW8w30BCjU3b/66OBSFbP++vHsiQ/RSacqTeWmHhz1fBTefvS2cYa6a7mtltoc8N5Q0O0elvCPqxo/fsnLjdiKk42abzN9xmQ6E/CWmBk1ulJFs+WOYCSGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915137; c=relaxed/simple;
	bh=AqHWVAj+1D3e2Dw0LcO5rqv8DR0KiPxjOZPeb2DBoeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1EFvp1kwfrYbbJxF4yRSm8HfW+bU0rHO8nQ3Qu6Dtq909tDnHR6OmtExUSlEh5aMAcEUsjObQy+qwDpELEYnyAAEE+H5cN3+KAwHCjhRJCZ5HS6X9WNE5p8Oep1jV5IrlkSNlGmoAt6Lo2zgqeqYIbfSQW0KwonYxMaU/OjLVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejgvaqzN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejgvaqzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18071F00A3F;
	Wed,  9 Sep 2026 00:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788915134;
	bh=xpvTA6tE6RJE0npD//qCDla4gSbRdcNLhbeEYfKmWhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ejgvaqzN7iLi4Qq+anUeBevAgM2YyIQp5AxdB5k/8bEcUSR5TosoKlF6UPaw/86tC
	 Sas76sWo5Y8kwaXzbsIAzgARHVYdIw0oyfM2MJvDlC+xWm+EFrEgY6BFApwCgCn5jJ
	 ZHNHvtMhkcQByFbel9yHDJ63rpFh9xFt96BDOpXuMu6ym4G6A6aRGPy0TKR1XRrk1Y
	 lUB+OW5Fim/vciEKRVKlo6D5HONtSaWz7XLGcORWSaneFBGskprcwRKRCQOZuRUo1X
	 4hkn8mxVbH3nea2+Czlknt4u+6GBeyoxVxw86pdVCUaeVpIDumqKAaodIhFEW9ojY8
	 kp5YJffmf3MFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] rpc_create_client_dir(): return 0 or -E...
Date: Tue,  8 Sep 2026 20:52:09 -0400
Message-ID: <20260909005210.805789-3-sashal@kernel.org>
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
index 48c372c676b5e..458c0eb9fa52e 100644
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
index d436ba5370d8b..e40e6d0cee7b0 100644
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

