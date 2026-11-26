Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795666223;
	b=dZkTDHLMWMbXwpApQ7+wOG/AO33R3onszGZ0oQl33skjxXwDAVSzD7utoJT85EyuhhMX
	 Lh96QmYCnmFQoOEsFsnr9xOfyr8UoQJfxP2ExToxxH1KpJPHpZXE4zdU8jKGOK/oJ+4e0
	 OK5tXfdO679+J4LdUItNIuX5K+WvZ42pmCOKFX7gNnPAzoQIJV6YPPbk1+8ITjh4i/b9T
	 YK3/T0Ps/tMEBcWpBdP5ATfjs+axXViKzw5lIRJTBrnbsv42ATUhS0yTk+mzxVaTJB0Tr
	 +gG/l2CMqoeWWRTKSHLAg563PzWX4aDPAOklMw54P4Bo+obm7yHibzAhdUwSuclPqMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795666223;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6hM0I1K5MTw53Ep9mmuQghYvMkoRbXh4q18JqKGpZaw=;
	b=Cw90pmO3a8WKheUjVRgtwgzZ2l4xXdap+jbepqHpSyu+FPuKbch3ndfPU9VSkKkoTRt3
	 TEKOeIiqwGXI9Rj77S+/QOz6cCIQFSgqQhNVmGEjohikBPOYr1tPjIoCVN6K20B7c2B0Z
	 jvlIBlgwq2X/rLuMHPSD9HJ1Ikz9pXF8vsBr0hJ5Ztv+FI/wbzq+VevgbObmfZUYlzPkS
	 Z3XZowco/ECXtIABOwqiQCrQrVzeEGR1Fad9Z+c5Wlzu6FU66v3embNawpMMGhMe9IEQA
	 Y/q7duIyGmYgcalqroBHK93r074FPVT5Xjg0DtKqSRncOaK3zwHKBACd5VuHNeqG6PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjp7PF6L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C209606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjp7PF6L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F6C1F000C4;
	Thu, 26 Nov 2026 04:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795666223;
	bh=6hM0I1K5MTw53Ep9mmuQghYvMkoRbXh4q18JqKGpZaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kjp7PF6LhYISXueTeveiCsRDy9xuhAeI0tCc/GE1/bXlNc33HTe2q6xjpmsc5cRYy
	 z2SG+RSMBGUUGta7EqDR5RfdaZXanx5BJz5TQw0IZAw+9pLS/WhqD8cBrmIktvOPdf
	 XIR2x6yTaihxzYEVgZ5LM3hHuY+famJ8nMLSMnuZ2uEOl4plsT9qTKCOsrsgCtKUVk
	 1tFoqNwLd0dB4h0WPUW99FlCklb+A6mywKKIgfWArRcfWLNOsXJolzWYgJo43J7zGD
	 9ZdH3jOD9MSLlO/gS3WEmENFRkslWVGOPuUHlErj3ENNjcz0b5ne2w8NlbYf2CVJcL
	 bbLJF8r8kzHqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ovl: bump the impure dir version when linking a file with origin
Date: Wed, 25 Nov 2026 23:10:21 -0500
Message-ID: <20261126041003.1937810-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112549-strangely-cardboard-25d9@gregkh>
References: <2026112549-strangely-cardboard-25d9@gregkh>
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
[ sashal: Adapted ovl_instantiate()/create helpers to the older signatures (no ofs or cred-override classes, no extra NULL argument), passing the origin flag through ovl_create_upper/over_whiteout directly. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/dir.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 5f35ac80b38b2..f5b62a9eacd44 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -257,14 +257,14 @@ static int ovl_set_opaque(struct dentry *dentry, struct dentry *upperdentry)
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
 
@@ -316,7 +316,7 @@ static bool ovl_type_origin(struct dentry *dentry)
 }
 
 static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
-			    struct ovl_cattr *attr)
+			    struct ovl_cattr *attr, bool origin)
 {
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
 	struct inode *udir = upperdir->d_inode;
@@ -341,7 +341,8 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 		ovl_set_opaque(dentry, newdentry);
 	}
 
-	err = ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink);
+	err = ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink,
+			      origin);
 	if (err)
 		goto out_cleanup;
 out_unlock:
@@ -454,7 +455,7 @@ static int ovl_set_upper_acl(struct dentry *upperdentry, const char *name,
 }
 
 static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
-				    struct ovl_cattr *cattr)
+				    struct ovl_cattr *cattr, bool origin)
 {
 	struct dentry *workdir = ovl_workdir(dentry);
 	struct inode *wdir = workdir->d_inode;
@@ -539,7 +540,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		if (err)
 			goto out_cleanup;
 	}
-	err = ovl_instantiate(dentry, inode, newdentry, hardlink);
+	err = ovl_instantiate(dentry, inode, newdentry, hardlink, origin);
 	if (err) {
 		ovl_cleanup(udir, newdentry);
 		dput(newdentry);
@@ -617,9 +618,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
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

