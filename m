Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658262;
	b=jOHZt5jwNAjfKPWHBmT2AQGTXW6Mkyu+tuIATG8dokjEA3GKnlYfsCayVv1rBVO9CB5Y
	 Cs7+onYc7jMrg7Xs0SCuC6lzYSXzsA4LDg8I0cElIlcENX1n/BY44Z+1ztCLjMXmNIufQ
	 RYRk5i5qX+EXxtgex0F27EpJ4QZpRn4j0T/LE/8wZyaFrCeHny+Z3JZnsU9OeU5o1QRbg
	 OE2Scj995mAk2tcl5boGKEH6aaasdr0meY/LxSDXCdEuiQu11fbAPOGGuWoInRR/Ne7Pp
	 /POm8sCH45cwYZg0Uqv0CGKXNve2Cq7TO9NKvxnnhDBlJ1aqkl7/dWbln0QBCU9KpCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658262;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d3ueETMmsD30qNjvPeyjq8nXaBCbVd6Zwj/Ag4rJlM4=;
	b=wUioTVB+35yIyTtNxYqfGbSC4s4Fc4Omr8i+JULWWKxFc+UY1Qj3srdzmL0kT0qGETG4
	 MkTJM6gYMlzevYQEhSoEj04UgHp4+rgFAbp/jhX+QzsWNggfBAPdv70wYv+F6eFPEFYQ0
	 TDP05Ohb/8oXdnsmOGvCLYpwKYxPjUKYrzgXOgYVvd4yBvFdpyryVlHr/xP9u+JGNItOg
	 YbAG6NWmAU0JQqKJhYU+d03c4iQbYGeBCPaAt3u+LnaxK+QiDF9LOL0j6jzU7Woo1MdP1
	 28Zs1WwNkQYmewsr806NtSCKDbhWo4v5hzxss8M75BtHR2NRYWIQDtM8xT77/ei2RNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dl3peGsC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0927F606A33E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dl3peGsC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F19F1F000D0;
	Thu, 26 Nov 2026 01:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658260;
	bh=d3ueETMmsD30qNjvPeyjq8nXaBCbVd6Zwj/Ag4rJlM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dl3peGsCYMbVmC+xahPp+GQmf5I5PcTujGjef4d4x0UTJRHUTGHDzWfPbbmALRwNG
	 JwdNYaBt76CBIdnTNe2uUIxSuTI2CX8mLxx/kR885G4Tjqeei07hkfd4Cc/KsSHR7v
	 1mdCTP4vDtBEAOBgxd3a/AFifqq3T36S1FVkhyTi0rqDlK2u7hpXLsEIbUuPwzLFWV
	 Vvp3G4XXbyKXXER31hu4K3Bd8ZVd0s/ZmfcFeTfCyJERvpgXNGeMAUZvbFbpU1Z7Dm
	 B5wF+OXk1f0uj9NfxM3IfVB7Cal2AMU1ueoafYxz/R7qVBbRTGRF1PPSr4Yma/3+LI
	 LzsLLToZHcYSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] ovl: make redirect/metacopy rejection consistent
Date: Wed, 25 Nov 2026 20:57:35 -0500
Message-ID: <20261126015719.1731625-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126015719.1731625-1-sashal@kernel.org>
References: <2026112530-preplan-eldest-5662@gregkh>
 <20261126015719.1731625-1-sashal@kernel.org>
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

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit a6fcfe9bb26df18ba7b5c4d064edd13c80ea2466 ]

When overlayfs finds a file with metacopy and/or redirect attributes and
the metacopy and/or redirect features are not enabled, then it refuses to
act on those attributes while also issuing a warning.

There was an inconsistency in not checking metacopy found from the index.

And also only warning on an upper metacopy if it found the next file on the
lower layer, while always warning for metacopy found on a lower layer.

Fix these inconsistencies and make the logic more straightforward, paving
the way for following patches to change when data redirects are allowed.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Stable-dep-of: 7031366be218 ("ovl: do not read the flags of a put upper dentry in lookup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/namei.c | 90 +++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 35 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 5a6581fc19da6..39ce3b5c8646a 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -18,6 +18,7 @@
 
 struct ovl_lookup_data {
 	struct super_block *sb;
+	struct dentry *dentry;
 	const struct ovl_layer *layer;
 	struct qstr name;
 	bool is_dir;
@@ -26,6 +27,7 @@ struct ovl_lookup_data {
 	bool stop;
 	bool last;
 	char *redirect;
+	char *upperredirect;
 	int metacopy;
 	/* Referring to last redirect xattr */
 	bool absolute_redirect;
@@ -1042,6 +1044,31 @@ int ovl_verify_lowerdata(struct dentry *dentry)
 	return ovl_maybe_validate_verity(dentry);
 }
 
+/*
+ * Following redirects/metacopy can have security consequences: it's like a
+ * symlink into the lower layer without the permission checks.
+ *
+ * This is only a problem if the upper layer is untrusted (e.g comes from an USB
+ * drive).  This can allow a non-readable file or directory to become readable.
+ *
+ * Only following redirects when redirects are enabled disables this attack
+ * vector when not necessary.
+ */
+static bool ovl_check_follow_redirect(struct ovl_lookup_data *d)
+{
+	struct ovl_fs *ofs = OVL_FS(d->sb);
+
+	if (d->metacopy && !ofs->config.metacopy) {
+		pr_warn_ratelimited("refusing to follow metacopy origin for (%pd2)\n", d->dentry);
+		return false;
+	}
+	if ((d->redirect || d->upperredirect) && !ovl_redirect_follow(ofs)) {
+		pr_warn_ratelimited("refusing to follow redirect for (%pd2)\n", d->dentry);
+		return false;
+	}
+	return true;
+}
+
 struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			  unsigned int flags)
 {
@@ -1057,7 +1084,6 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	unsigned int ctr = 0;
 	struct inode *inode = NULL;
 	bool upperopaque = false;
-	char *upperredirect = NULL;
 	struct dentry *this;
 	unsigned int i;
 	int err;
@@ -1065,12 +1091,14 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	int metacopy_size = 0;
 	struct ovl_lookup_data d = {
 		.sb = dentry->d_sb,
+		.dentry = dentry,
 		.name = dentry->d_name,
 		.is_dir = false,
 		.opaque = false,
 		.stop = false,
 		.last = ovl_redirect_follow(ofs) ? false : !ovl_numlower(poe),
 		.redirect = NULL,
+		.upperredirect = NULL,
 		.metacopy = 0,
 	};
 
@@ -1112,8 +1140,8 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 
 		if (d.redirect) {
 			err = -ENOMEM;
-			upperredirect = kstrdup(d.redirect, GFP_KERNEL);
-			if (!upperredirect)
+			d.upperredirect = kstrdup(d.redirect, GFP_KERNEL);
+			if (!d.upperredirect)
 				goto out_put_upper;
 			if (d.redirect[0] == '/')
 				poe = roe;
@@ -1131,6 +1159,11 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	for (i = 0; !d.stop && i < ovl_numlower(poe); i++) {
 		struct ovl_path lower = ovl_lowerstack(poe)[i];
 
+		if (!ovl_check_follow_redirect(&d)) {
+			err = -EPERM;
+			goto out_put;
+		}
+
 		if (!ovl_redirect_follow(ofs))
 			d.last = i == ovl_numlower(poe) - 1;
 		else if (d.is_dir || !ofs->numdatalayer)
@@ -1144,13 +1177,6 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		if (!this)
 			continue;
 
-		if ((uppermetacopy || d.metacopy) && !ofs->config.metacopy) {
-			dput(this);
-			err = -EPERM;
-			pr_warn_ratelimited("refusing to follow metacopy origin for (%pd2)\n", dentry);
-			goto out_put;
-		}
-
 		/*
 		 * If no origin fh is stored in upper of a merge dir, store fh
 		 * of lower dir and set upper parent "impure".
@@ -1203,23 +1229,6 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			ctr++;
 		}
 
-		/*
-		 * Following redirects can have security consequences: it's like
-		 * a symlink into the lower layer without the permission checks.
-		 * This is only a problem if the upper layer is untrusted (e.g
-		 * comes from an USB drive).  This can allow a non-readable file
-		 * or directory to become readable.
-		 *
-		 * Only following redirects when redirects are enabled disables
-		 * this attack vector when not necessary.
-		 */
-		err = -EPERM;
-		if (d.redirect && !ovl_redirect_follow(ofs)) {
-			pr_warn_ratelimited("refusing to follow redirect for (%pd2)\n",
-					    dentry);
-			goto out_put;
-		}
-
 		if (d.stop)
 			break;
 
@@ -1230,6 +1239,11 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		}
 	}
 
+	if (!ovl_check_follow_redirect(&d)) {
+		err = -EPERM;
+		goto out_put;
+	}
+
 	/* Defer lookup of lowerdata in data-only layers to first access */
 	if (d.metacopy && ctr && ofs->numdatalayer && d.absolute_redirect) {
 		d.metacopy = 0;
@@ -1316,20 +1330,26 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 
 		/*
 		 * It's safe to assign upperredirect here: the previous
-		 * assignment of happens only if upperdentry is non-NULL, and
+		 * assignment happens only if upperdentry is non-NULL, and
 		 * this one only if upperdentry is NULL.
 		 */
-		upperredirect = ovl_get_redirect_xattr(ofs, &upperpath, 0);
-		if (IS_ERR(upperredirect)) {
-			err = PTR_ERR(upperredirect);
-			upperredirect = NULL;
+		d.upperredirect = ovl_get_redirect_xattr(ofs, &upperpath, 0);
+		if (IS_ERR(d.upperredirect)) {
+			err = PTR_ERR(d.upperredirect);
+			d.upperredirect = NULL;
 			goto out_free_oe;
 		}
+
 		err = ovl_check_metacopy_xattr(ofs, &upperpath, NULL);
 		if (err < 0)
 			goto out_free_oe;
-		uppermetacopy = err;
+		d.metacopy = uppermetacopy = err;
 		metacopy_size = err;
+
+		if (!ovl_check_follow_redirect(&d)) {
+			err = -EPERM;
+			goto out_free_oe;
+		}
 	}
 
 	if (upperdentry || ctr) {
@@ -1337,7 +1357,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			.upperdentry = upperdentry,
 			.oe = oe,
 			.index = index,
-			.redirect = upperredirect,
+			.redirect = d.upperredirect,
 		};
 
 		/* Store lowerdata redirect for lazy lookup */
@@ -1379,7 +1399,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		kfree(origin_path);
 	}
 	dput(upperdentry);
-	kfree(upperredirect);
+	kfree(d.upperredirect);
 out:
 	kfree(d.redirect);
 	ovl_revert_creds(old_cred);
-- 
2.53.0

