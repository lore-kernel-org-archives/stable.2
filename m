Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EA45592F5
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907041; cv=none; b=EEpt9cL4ga8hhYoBQep8+S0VsRH9QtFhGP5GX12pbFygQ3qsx/gx6H2ESaaJdUxh9urRKUsS9ML4b+V1zmLjDhWehrKzcr/mnZBuyjRKPII1+ExUX5Hz8Usv8dP+GVNfULo8Q6uJ+VR2MFo/LE9pq1uZ45DyIVQ9WX3/u0sHq10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907041; c=relaxed/simple;
	bh=olTPT+kqZ81Q3CGkvdEA1CPWtUC+1vjUfFEPqgYJWP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxTY9YbU8r2kRUkqLlIQUuFrnRwHJlC9QoZ4m5+IRWp16U3x2K4NmxkrbcNNo5JGzkwAq55YiTxUcBOOO8bczc/bYrHc+LKDJ+hfIMFBYKoS8eR8rrcag+wQ2+STR+5Fdm4Ph9LcK0A3UqwYMSXuQ4o154nLfbB4A1JP0trkLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx/x9FgK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx/x9FgK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB151F00ACF;
	Tue,  8 Sep 2026 22:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907038;
	bh=WMVXXWvPX1mbYhaXPBTiFZN/BQfaPqGI8F2Q7LWaINs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xx/x9FgKOFaRYsgyEmF/ZFhVbkCjoGF3PuoBSu8HD448MobmpbRnwPaoAY9nNU61l
	 sbb7yO9cf2SP3vVAu46wFqE4XQzIhPDG7LGAf3qbvZ5uJR89eGwCzcWFYtZJWOmSrd
	 jN3itgHG7cnbPJ4Of7vg1aO5exovSAJgehUV+BxFPTQaxveorYXq+1o6YCCklaFRqo
	 YHrLlwTT6WqYI6tSysPPZyco77dG6YZSx80cSiqbej01G+v9oLRb3hfhu15rm9yrzQ
	 jPqjhNASEQuS0XUlvdDIG4zhAUomaVmma3zw1GNICClYJiTFcedLjFXgUagWwXkmUm
	 6MCDD6TsJUpqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] rpc_pipe: don't overdo directory locking
Date: Tue,  8 Sep 2026 18:37:14 -0400
Message-ID: <20260908223715.507115-3-sashal@kernel.org>
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

[ Upstream commit 41a6b9e52b21544c334830bfe68fb78d6677caa0 ]

Don't try to hold directories locked more than VFS requires;
lock just before getting a child to be made positive (using
simple_start_creating()) and unlock as soon as the child is
created.  There's no benefit in keeping the parent locked
while populating the child - it won't stop dcache lookups anyway.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: 932a8cf6abb2 ("sunrpc: fix use-after-free in __rpc_clnt_handle_event and __rpc_clnt_remove_pipedir")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/rpc_pipe.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 5556e25ffc35a..76a9d86ab8ac7 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -698,12 +698,14 @@ static int rpc_populate(struct dentry *parent,
 	struct dentry *dentry;
 	int i, err;
 
-	inode_lock(dir);
 	for (i = start; i < eof; i++) {
+		inode_lock(dir);
 		dentry = __rpc_lookup_create_exclusive(parent, files[i].name);
 		err = PTR_ERR(dentry);
-		if (IS_ERR(dentry))
+		if (IS_ERR(dentry)) {
+			inode_unlock(dir);
 			goto out_bad;
+		}
 		switch (files[i].mode & S_IFMT) {
 			default:
 				BUG();
@@ -712,20 +714,20 @@ static int rpc_populate(struct dentry *parent,
 						files[i].mode,
 						files[i].i_fop,
 						private);
+				inode_unlock(dir);
 				break;
 			case S_IFDIR:
 				err = __rpc_mkdir(dir, dentry,
 						files[i].mode,
 						NULL,
 						private);
+				inode_unlock(dir);
 		}
 		if (err != 0)
 			goto out_bad;
 	}
-	inode_unlock(dir);
 	return 0;
 out_bad:
-	inode_unlock(dir);
 	printk(KERN_WARNING "%s: %s failed to populate directory %pd\n",
 			__FILE__, __func__, parent);
 	return err;
@@ -741,25 +743,22 @@ static struct dentry *rpc_mkdir_populate(struct dentry *parent,
 
 	inode_lock_nested(dir, I_MUTEX_PARENT);
 	dentry = __rpc_lookup_create_exclusive(parent, name);
-	if (IS_ERR(dentry))
-		goto out;
+	if (IS_ERR(dentry)) {
+		inode_unlock(dir);
+		return dentry;
+	}
 	error = __rpc_mkdir(dir, dentry, mode, NULL, private);
+	inode_unlock(dir);
 	if (error != 0)
-		goto out_err;
+		return ERR_PTR(error);
 	if (populate != NULL) {
 		error = populate(dentry, args_populate);
 		if (error) {
-			inode_unlock(dir);
 			simple_recursive_removal(dentry, NULL);
 			return ERR_PTR(error);
 		}
 	}
-out:
-	inode_unlock(dir);
 	return dentry;
-out_err:
-	dentry = ERR_PTR(error);
-	goto out;
 }
 
 static int rpc_rmdir_depopulate(struct dentry *dentry,
-- 
2.53.0

