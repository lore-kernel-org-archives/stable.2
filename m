Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665913;
	b=IriKEDc2DngtEHjO9Hi2ldLnTSb24l8KzW+N0zX6Z4BwX6KPlnf74N0ww5Kx5E8QN51O
	 Q7R5S/NxLyscLRHZs+vTB3uKELpB/WTOgOVH3XyLPfwtMprOIA2dZ4jcx3ZTw11mSw/70
	 7MfdAmfCBW+osQoWaMvMCIx6E4oeUpeWHXUrlgUrlDs+zpnfGso+fnR3hzOmQayHidr3N
	 MqVUkHXluj7xplanzhbE8FteM+PnrBL/ukKs+r6Y0cszUknLiuvgNyZpB9PGiDJVmTcgg
	 mM3Xj1m3umCkFUW1C6KnQw+kSx2zq5CLPXgEQ0uSq3E7+2m8S5veL4j4uj74DDq1YCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665913;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CS7JV2kgUnixntemUGE65AUA7DOKdI8JPSvOm4ISsPc=;
	b=L2jrUhaDDi1hakv224P1LwOnyVU2hTkIYn70maOn+d9muElfNedgc1N4BbXKMEVM6j0G
	 k95PKq1AtQ7Ytzl1vvckhjFUwjkDQJtHiqypI3Ga4r4xp/sdGwmR/zrScvLfSgAamTpLt
	 9d++eEo1N62V9kTA6b3rGNrCnqspQ36oT7+G3tz8ffEE5TiOqClWK4TGzY4tT1B6pNCUe
	 be6QU5ya+PuR4TSqUwJnzUm9Ty8gnua2vlbdK6wJufiNtzwBu6Z0u+HeMpsh9lY3brCU8
	 mK2Gyn26LrGPZvln4LiTnNpS4H9bZCBFO3p6Xercb+Co5lRDwdqp10MVQ91k3+E2eaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mox8CZFR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDA1606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mox8CZFR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B231F000C6;
	Thu, 26 Nov 2026 04:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795665913;
	bh=CS7JV2kgUnixntemUGE65AUA7DOKdI8JPSvOm4ISsPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mox8CZFRqDrg193MN6rdAkQBx5MhoshYJyDeyfI4LBVTETWc82je9OWmvXz+Tq5U2
	 DlxVcoFDcLZQnaVNmTtAen24t3Y3+jhA7Z67m1GxNruDDMGoyPuCEFhUSz19zs42Pf
	 wzMHxwlQ8GtyrSxnMDMfL9zui4DNIVwvdWk1eUriUR2Wi5eP1M4OHt8HgZ2SjfTnNc
	 0Yr+412D/sj6MfripODq1tDGjRMY8gVitvms8czOedQcRnC1Lrz3Tka4qU3vRrFyiV
	 LhQGxx5/w0KnlZSI7Oq+xq8f14ZnQHphUntGETgZG2Wmx/zvGz/zhl8BmGt8zRRLbl
	 u5YkSEgxeUh7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ovl: bump the impure dir version when linking a file with origin
Date: Wed, 25 Nov 2026 23:05:11 -0500
Message-ID: <20261126040500.1902221-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112549-spearhead-donor-ab3f@gregkh>
References: <2026112549-spearhead-donor-ab3f@gregkh>
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
[ sashal: Adapted to older code: ovl_instantiate() gets an origin parameter instead of the dir-modified call moving out, and the create paths call ovl_create_upper/over_whiteout directly without the whiteout helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/dir.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index d2f7b68f8ee63..cb53cb58bdd19 100644
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
 
 	if (!hardlink) {
@@ -324,7 +324,7 @@ static bool ovl_type_origin(struct dentry *dentry)
 }
 
 static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
-			    struct ovl_cattr *attr)
+			    struct ovl_cattr *attr, bool origin)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
@@ -347,7 +347,8 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 		ovl_set_opaque(dentry, newdentry);
 	}
 
-	err = ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink);
+	err = ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink,
+			      origin);
 	if (err)
 		goto out_cleanup;
 out_unlock:
@@ -461,7 +462,7 @@ static int ovl_set_upper_acl(struct ovl_fs *ofs, struct dentry *upperdentry,
 }
 
 static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
-				    struct ovl_cattr *cattr)
+				    struct ovl_cattr *cattr, bool origin)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *workdir = ovl_workdir(dentry);
@@ -547,7 +548,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		if (err)
 			goto out_cleanup;
 	}
-	err = ovl_instantiate(dentry, inode, newdentry, hardlink);
+	err = ovl_instantiate(dentry, inode, newdentry, hardlink, origin);
 	if (err) {
 		ovl_cleanup(ofs, udir, newdentry);
 		dput(newdentry);
@@ -625,9 +626,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
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

