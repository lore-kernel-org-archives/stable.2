Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665290;
	b=DHuuxu7z60O/EGrxcYz5pOkzB0fNq6SvvLdNq4mPswaU1xVLCtFjP0sRCV+bZoCVaPo+
	 0p5aWOYlfRCOH1Wk+l2ndjrl4/NRYjS2ZqNCFg35UMzr4v+h44xGCG8UhagkcawWKG+Yu
	 YnzXKlCat5chOfmJgDHV0j10d4Wfk04s+uqCilxNjL8Qv9hXu369F3QXBFfIrJCi8QL3B
	 avvjfJ/gauNxI+Tk3zuEXKjyk+WA/PohE0o4DEbP0oD26CjPI1HeQgqZ/rs7GLQhvfZr4
	 Cz2tVZyTxSDR28fO0uOBvQeVYfF+fzFLSpDm/aeo0ZZSCdwEG60t4C+qQFI5JUNohrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665290;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=S04pqpnw7W1vJNhiECDMT82//pL9Xs/M7EnXM1PhcWA=;
	b=lrCTV3Jkti752IShi6bTqv5kdY9VH8gKZh7ctt8e0auve9MD70dEm+IJr7SgG5pasVdj
	 aZWlpEMMkeVtpsPRePK4euq4prQoUxijWt1WLw/sEbWuEm2vUXo/vM1lSB8LEwLwJPdp7
	 IwUtpoo31/tbTEs3vigx+aIuCGkfKSmjphl9gBfHyy1rPOkDu6KCFYM2OH7PDRYe0x8Wv
	 uhpxGMGnMe2FgKrnLJA4Sl2uQibDN/GdDRbZmiZzscGl/K3zVDFs5RBWXau31S0DcCPty
	 hRE9+fohCeNLIaUXQ6r7zkApuDknw2+OhD7i0odS7PafAAyUekztJBHsE+nYCOpINgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7oQ490N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D77F606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7oQ490N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A11F1F000CF;
	Thu, 26 Nov 2026 03:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795665290;
	bh=S04pqpnw7W1vJNhiECDMT82//pL9Xs/M7EnXM1PhcWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j7oQ490NVHA0iwN8gXcJjAJx6c8Hgq45QRIjVuf81aX2N/fYad915FMNhJfc+GbK6
	 4O2uZ4gXuLMccGkwUclB3wpckQ+u+JF8oCLlH6okCo87sfFt8tyyOAJ3xFAcEIp7zB
	 EetxnUFjpCLYcIjQSN5bAn/gymkf3R+s+Qhz1FqBBL8AF/S0tmMskKZahrP+5H0qj1
	 G7yiBF+suX7wBxU+DlgOVjpM1432gXNPB440vo9ZTF+VYthiyRdAnnHTH0Ko1bw/Dv
	 pbwrSwIig/uOZyVt40PqC//pkfEAIqcyJnqDjYE5acS8NDfInnQYzVelNHV9Cdz2tn
	 ax3WaKcu0I08A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] ovl: make redirect/metacopy rejection consistent
Date: Wed, 25 Nov 2026 22:54:46 -0500
Message-ID: <20261126035423.1749648-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112540-grandly-twelve-b524@gregkh>
References: <2026112540-grandly-twelve-b524@gregkh>
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
Stable-dep-of: f1b7e5534854 ("ovl: fix leak of lowerdata redirect on ovl_get_inode() failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/namei.c | 90 +++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 35 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 86fab9f051b4f..27c0700a0c509 100644
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
 	revert_creds(old_cred);
-- 
2.53.0

