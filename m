Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658634;
	b=v7WIYsOFSujfC2gG8o04L/hTxehn4Emy0AJdLG7NnAmR62cibWnj6Vm0itkm8qfEeWRv
	 r8GSHaatKOejj72vnomDSyjl5W0lC8kBcWF473ULy/EL843Q4oy+rXN405CaPDKBv9+h+
	 WZmm/5aeHm4r/nnHlwHAoh9aIW5CCjNIhIalI16+Rj8egooUph2CHbvjxNaJ4lGltAc22
	 nRn9c5A8z6lhV9IuDOo/HygyTmjIDkg0ZsGXJqy0jj5YSnOEBKLn9jAyCitiA3VdnRtqU
	 n/ooqkigQZaa+D9TCP3IYCEwlCC5V8QL1Ae/hRkBHdsiIn9fvMfzmVr7Sx6o3OxDMYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658634;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Fsd5GnRW/Jmd1cWtCxsJhf1rveejlCEcyaT5kRxuw9A=;
	b=EaILln+oqROk7B/xhvbcSIaSuomtt5YtRId9PnEVDWoKleemWyAxdLTNA6yeeViaGItc
	 a+ej8aq6GRiyBcCjtd3HMWlCQziSwBCiDi5wOM/C3BDUcQLGWMmoI21V1zHvTWZuHlyxv
	 PwOKLnUABBDTPONkWupvR/0Yrno14CM1QU5+EnZzI75B7OH01KoChiR80vi9HS/dDNf/l
	 RWtUYytqKFW8CsCEHLQKO3vXG0mk0GyC88fTA8+Rj7SEI8xSbRN3UwC1UjuXtajlTmroz
	 RYEaR6I/M7T9euvCz7L12LD5jaWuNfA4TcJkh3hoCU5llhmhvkgr/9XoTxOvPEEc71A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQogM17x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005D8606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQogM17x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB8E1F000C6;
	Thu, 26 Nov 2026 02:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658633;
	bh=Fsd5GnRW/Jmd1cWtCxsJhf1rveejlCEcyaT5kRxuw9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZQogM17xsaoJldRNM4a3ygB36WrXFstJgA3j/SQdx54VKvjWcEPUpeCIPfVtUUsHT
	 Cf1V4i8+XkQtdZJ+GHP3UVuoGWxGr2Tw484jnpv9xVz/xxnywRgRJC2HE3ajTmOXz4
	 bA4A8YXClX7ZF9CxA4JywaAzQLTO+tc1kp1FIuDFx6rn9fILExGLnqV0Ab+p2xY0ID
	 xqb4wq0g+6BmtEA61h86zzhxSPXeZPoOOMOufX7BOW/P3KYzYfLSzjOuUlGzqrUw8r
	 QhouqYeP5LHq3LnN9FwPSCsSYGn1fH0ZXvvjE04H5HyeGSfLlt5la7Op1BR+Hxdqpy
	 I0xU4Vz3Q+/ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/6] ovl: port ovl_create_or_link() to cred guard
Date: Wed, 25 Nov 2026 21:03:46 -0500
Message-ID: <20261126020308.1696715-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126020308.1696715-1-sashal@kernel.org>
References: <2026112548-vowed-carded-1ef2@gregkh>
 <20261126020308.1696715-1-sashal@kernel.org>
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

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 8c9531edcf60014b7e36739697f5cc15d5e853a1 ]

Use the scoped ovl cred guard.

Link: https://patch.msgid.link/20251117-work-ovl-cred-guard-v4-3-b31603935724@kernel.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 86e2facd8630 ("ovl: bump the impure dir version when linking a file with origin")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/dir.c | 70 ++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 8377f112feca3..935dc2187e6e2 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -617,52 +617,44 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 			      struct ovl_cattr *attr, bool origin)
 {
 	int err;
-	const struct cred *old_cred, *new_cred = NULL;
+	const struct cred *new_cred __free(put_cred) = NULL;
 	struct dentry *parent = dentry->d_parent;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-
-	/*
-	 * When linking a file with copy up origin into a new parent, mark the
-	 * new parent dir "impure".
-	 */
-	if (origin) {
-		err = ovl_set_impure(parent, ovl_dentry_upper(parent));
-		if (err)
-			goto out_revert_creds;
-	}
-
-	if (!attr->hardlink) {
+	scoped_class(override_creds_ovl, old_cred, dentry->d_sb) {
 		/*
-		 * In the creation cases(create, mkdir, mknod, symlink),
-		 * ovl should transfer current's fs{u,g}id to underlying
-		 * fs. Because underlying fs want to initialize its new
-		 * inode owner using current's fs{u,g}id. And in this
-		 * case, the @inode is a new inode that is initialized
-		 * in inode_init_owner() to current's fs{u,g}id. So use
-		 * the inode's i_{u,g}id to override the cred's fs{u,g}id.
-		 *
-		 * But in the other hardlink case, ovl_link() does not
-		 * create a new inode, so just use the ovl mounter's
-		 * fs{u,g}id.
+		 * When linking a file with copy up origin into a new parent, mark the
+		 * new parent dir "impure".
 		 */
-		new_cred = ovl_setup_cred_for_create(dentry, inode, attr->mode,
-						     old_cred);
-		err = PTR_ERR(new_cred);
-		if (IS_ERR(new_cred)) {
-			new_cred = NULL;
-			goto out_revert_creds;
+		if (origin) {
+			err = ovl_set_impure(parent, ovl_dentry_upper(parent));
+			if (err)
+				return err;
 		}
-	}
 
-	if (!ovl_dentry_is_whiteout(dentry))
-		err = ovl_create_upper(dentry, inode, attr);
-	else
-		err = ovl_create_over_whiteout(dentry, inode, attr);
+		if (!attr->hardlink) {
+			/*
+			 * In the creation cases(create, mkdir, mknod, symlink),
+			 * ovl should transfer current's fs{u,g}id to underlying
+			 * fs. Because underlying fs want to initialize its new
+			 * inode owner using current's fs{u,g}id. And in this
+			 * case, the @inode is a new inode that is initialized
+			 * in inode_init_owner() to current's fs{u,g}id. So use
+			 * the inode's i_{u,g}id to override the cred's fs{u,g}id.
+			 *
+			 * But in the other hardlink case, ovl_link() does not
+			 * create a new inode, so just use the ovl mounter's
+			 * fs{u,g}id.
+			 */
+			new_cred = ovl_setup_cred_for_create(dentry, inode, attr->mode, old_cred);
+			if (IS_ERR(new_cred))
+				return PTR_ERR(new_cred);
+		}
 
-out_revert_creds:
-	ovl_revert_creds(old_cred);
-	put_cred(new_cred);
+		if (!ovl_dentry_is_whiteout(dentry))
+			return ovl_create_upper(dentry, inode, attr);
+
+		return ovl_create_over_whiteout(dentry, inode, attr);
+	}
 	return err;
 }
 
-- 
2.53.0

