Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795666066;
	b=2anhQCfjRLu8DbhKrJmg54Uq3+t+NB8j81obTaP0Z54wKuwlu0S4OBbMTNLPWZqZMDrP
	 3w0JEW6UtW3qwIgvSdjcGqkes6NUsEBmn/8ikNr2eV7egzoQw011TiPDETBZYdXh2whpm
	 X7skMuYb+qyOeplF60tPLIqA6T8rRBxkFiQuLBDjaM5S7/BNbOBwEArfw6wH0kYjKuiHB
	 xFaXXIJdnmvbuMw08TN2FDJhIXL8WdGX61s5OC08IgT8sEu7Xci7TGgqnqqFH0qPJgAoD
	 f8UPcuJgdTDkOjHkX88xS775G77wNitgg1IxQTV3jav6JbP2EtVVME8AojKrOp9IIUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795666066;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sZ6+4odUu77b7IM3WUbiIQbIeBDNEi74CDqiKa/cZLY=;
	b=1MGitvAXsnJmo1S1S+9zN2/8gbpxtmnyTg6BxnIc5fUYQtPWlTaHgOs8xCDEmhcVdUma
	 lDcbfwePOlwT0H3d3ZXtYluYHt0hmftgHyq/kXIkOb6fUHmIbNP7bbv4/XCLej7cbhh1o
	 FVCDhnpT/nUQwdnF/GRVgQzKXiEwx3fo6IA/H8ysYdM3eODeamNdYVC9CbCt+1ULa8jj9
	 LV4T3z5rRnGUGwSUpEqPuF+cbLf3SMBbpAgnl7SPjTMD8jFZVCtjYv+u8O0oz7js+HssS
	 egXCukYx21a3iq7WCLbN/ZD2lcnjldZM6XUFWxC/H5nsoW1JkkQcJvw1P0bcdWCJ3bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YhiNjvYT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB2E606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YhiNjvYT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5921F000C0;
	Thu, 26 Nov 2026 04:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795666065;
	bh=sZ6+4odUu77b7IM3WUbiIQbIeBDNEi74CDqiKa/cZLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YhiNjvYTexbb5+mWXlBH9SvMtUkO2mwR7RpY2KL2nXztbN4JX9gutZPjkER419ez3
	 92VWQq3ZKXxnZRz6UrL3zLwowHid9dQerwKBMoubqO9s4uY+2KYAn/IHZVTI8qqdPx
	 3+jiP9bDpJZm/5hMzPHiER+fJTq4+gCmeBAoA6avSlJxl1HIZmAkma5kgcVu13UheB
	 82EVz5OKZMlAfjeNyghs3IulPlWfAdlmBvU4ioFf2kggdiWIc0jKUIfZrQ1X/ZA9u4
	 ZzJCsaRbxCEVZeinBs9o+pkJSbhBgagp7pv2CrgfoGjQmZfV5hNohHg+i3BbQZxCgs
	 mH1xBo3mlFtHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ovl: bump the impure dir version when linking a file with origin
Date: Wed, 25 Nov 2026 23:07:43 -0500
Message-ID: <20261126040732.1923854-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112549-garter-shredder-8b5c@gregkh>
References: <2026112549-garter-shredder-8b5c@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daejun Park <daejun7.park@samsung.com>

[ Upstream commit 86e2facd8630cc2fdec6ea80c53e370b26b441d9 ]

Linking a file with copy up origin into a non-merge impure dir does
not bump the dir version. readdir then reuses the impure dir cache
built before the link. It reports the upper inode number as d_ino of
the new link, not st_ino.

Pass whether the linked file has an origin to ovl_dir_modified(), as
rename and unlink do.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-98f207b6-3936-48e9-a40f-88f20be4db7b
Fixes: 4edb83bb1041 ("ovl: constant d_ino for non-merge dirs")
Cc: stable@vger.kernel.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[ sashal: adapted ovl_instantiate()/ovl_create_upper()/ovl_create_over_whiteout() to the older signatures, passing origin directly to ovl_instantiate() and dropping the ovl_create_handle_whiteouts() changes. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/dir.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 0b89cbc4b018a..75a262f309b97 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -260,14 +260,14 @@ static int ovl_set_opaque(struct dentry *dentry, struct dentry *upperdentry)
  * may not use to instantiate the new dentry.
  */
 static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
-			   struct dentry *newdentry, bool hardlink)
+			   struct dentry *newdentry, bool hardlink, bool origin)
 {
 	struct ovl_inode_params oip = {
 		.upperdentry = newdentry,
 		.newinode = inode,
 	};
 
-	ovl_dir_modified(dentry->d_parent, false);
+	ovl_dir_modified(dentry->d_parent, origin);
 	ovl_dentry_set_upper_alias(dentry);
 	ovl_dentry_init_reval(dentry, newdentry);
 
@@ -319,7 +319,7 @@ static bool ovl_type_origin(struct dentry *dentry)
 }
 
 static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
-			    struct ovl_cattr *attr)
+			    struct ovl_cattr *attr, bool origin)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
@@ -346,7 +346,8 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 		ovl_set_opaque(dentry, newdentry);
 	}
 
-	err = ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink);
+	err = ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink,
+			      origin);
 	if (err)
 		goto out_cleanup;
 out_unlock:
@@ -460,7 +461,7 @@ static int ovl_set_upper_acl(struct ovl_fs *ofs, struct dentry *upperdentry,
 }
 
 static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
-				    struct ovl_cattr *cattr)
+				    struct ovl_cattr *cattr, bool origin)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *workdir = ovl_workdir(dentry);
@@ -546,7 +547,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		if (err)
 			goto out_cleanup;
 	}
-	err = ovl_instantiate(dentry, inode, newdentry, hardlink);
+	err = ovl_instantiate(dentry, inode, newdentry, hardlink, origin);
 	if (err) {
 		ovl_cleanup(ofs, udir, newdentry);
 		dput(newdentry);
@@ -624,9 +625,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 	}
 
 	if (!ovl_dentry_is_whiteout(dentry))
-		err = ovl_create_upper(dentry, inode, attr);
+		err = ovl_create_upper(dentry, inode, attr, origin);
 	else
-		err = ovl_create_over_whiteout(dentry, inode, attr);
+		err = ovl_create_over_whiteout(dentry, inode, attr, origin);
 
 out_revert_creds:
 	revert_creds(old_cred);
-- 
2.53.0

