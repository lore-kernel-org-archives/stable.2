Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665291;
	b=P7a7sxcqPJ7NZ8+TpRFzcgbg1XQtFg1DvM3qyqwiKbUlZdgj4luxxIkdy6wZBK7PaXbT
	 t1w8jEIGeJhI3MDYhIiP3tvup9e2UJ6XMGM7FL4RxY4PTcDS4/tUg7CBLQXbwXoM8Ho4V
	 +w1L8PjmAL4qprQvXPsz3OtcnieDSJ9Z2r3uqsXhhDMFVHNuT3zvnPXryLrwAUboxz4Ia
	 nxSndxsyverCi1Ra2+iQWQ4MMGAQn5h/3BYt4TvP3bV7M+VVilfYBve3ci0PFZBoBHKTe
	 6Nq+OaDTtjuYIrE9PrLYcc7aUDlAZ6hOgB4dQku37ac0ypuxi63vBLPv0gS8qv09pzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665291;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7K/O6ORjqT/d8s5XLgPv14j44TBDIl9QGrANYZTYtnQ=;
	b=5mmWNKzJ5TIy4pNZgVOPG2hTTl5J+J7uxHNJKaRMm+vPr7hpxEYt5ycASyyPPWWc9BkB
	 /6vz4sYiTLty2bjZV3hrOGhrk7AI3cbN6xtJ6oYg4VZigscTsTJ2rglzNCjrJB4BEPSij
	 hyozhbkfNY2HOkGFmdq7nvd8qGBbDgLneUXqaJYL4TfTLEwDqs++u0Ne9qlNcHIU/xoNS
	 F+4anQ4XaxJ7LIDAOPJTN1juxo12Z4VA4vnzWRUXHEKHH2RD0vJkhQi+m3WS6AhjNspgB
	 ta+wVfLkelXcEb5yjYRZJRj57KZt9qBY6yTjxxrphdNRugIsJeo5m31dcR0Imstp/TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g07hjfrz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D42606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g07hjfrz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806521F000D2;
	Thu, 26 Nov 2026 03:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795665291;
	bh=7K/O6ORjqT/d8s5XLgPv14j44TBDIl9QGrANYZTYtnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g07hjfrzNLkYFBJFBm/e0Fs15ncqpNw86Xa4c5vErKk0BOnqoK3XQGmP/ua3bZ2D0
	 7xESoTmCrzT+i9T3dvWEfa32s53kfhkc+BAMl1bIRWkMDS+lUCsCfjYxizLfaoNMkZ
	 OoI1Qdi/xy05v25u9vezot2GmrF7mU6+Tl1qhlmVEEYJHasF4MCeyW6v14BBPKtcUg
	 K6BPAjvsCoMDqQuiKUkS+dYbeN5rlhD7Rqz6tsrNoGhsfYDU/VgMhtQHOBCooO/bEL
	 tUXcsQACVxMdyTm1J7FDGnaYooDHNRqi+fl/M77wrYGpZsb3JJuDeXIKcW1Mv6XrWb
	 TUoIrbefdspCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] ovl: refactor ovl_lookup()
Date: Wed, 25 Nov 2026 22:54:47 -0500
Message-ID: <20261126035423.1749648-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126035423.1749648-1-sashal@kernel.org>
References: <2026112540-grandly-twelve-b524@gregkh>
 <20261126035423.1749648-1-sashal@kernel.org>
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

[ Upstream commit 15da486ad3bde6119d9b6353bebc2ffb6e9165c1 ]

Split the core into a separate helper in preparation of converting the
caller to the scoped ovl cred guard.

Link: https://patch.msgid.link/20251117-work-ovl-cred-guard-v4-37-b31603935724@kernel.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: f1b7e5534854 ("ovl: fix leak of lowerdata redirect on ovl_get_inode() failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/namei.c | 313 ++++++++++++++++++++++---------------------
 1 file changed, 160 insertions(+), 153 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 27c0700a0c509..2deddbad64d22 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1069,56 +1069,43 @@ static bool ovl_check_follow_redirect(struct ovl_lookup_data *d)
 	return true;
 }
 
-struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
-			  unsigned int flags)
+struct ovl_lookup_ctx {
+	struct dentry *dentry;
+	struct ovl_entry *oe;
+	struct ovl_path *stack;
+	struct ovl_path *origin_path;
+	struct dentry *upperdentry;
+	struct dentry *index;
+	struct inode *inode;
+	unsigned int ctr;
+};
+
+static int ovl_lookup_layers(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data *d)
 {
-	struct ovl_entry *oe = NULL;
-	const struct cred *old_cred;
+	struct dentry *dentry = ctx->dentry;
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_entry *poe = OVL_E(dentry->d_parent);
 	struct ovl_entry *roe = OVL_E(dentry->d_sb->s_root);
-	struct ovl_path *stack = NULL, *origin_path = NULL;
-	struct dentry *upperdir, *upperdentry = NULL;
+	struct dentry *upperdir;
+	struct dentry *this;
 	struct dentry *origin = NULL;
-	struct dentry *index = NULL;
-	unsigned int ctr = 0;
-	struct inode *inode = NULL;
 	bool upperopaque = false;
-	struct dentry *this;
-	unsigned int i;
-	int err;
 	bool uppermetacopy = false;
 	int metacopy_size = 0;
-	struct ovl_lookup_data d = {
-		.sb = dentry->d_sb,
-		.dentry = dentry,
-		.name = dentry->d_name,
-		.is_dir = false,
-		.opaque = false,
-		.stop = false,
-		.last = ovl_redirect_follow(ofs) ? false : !ovl_numlower(poe),
-		.redirect = NULL,
-		.upperredirect = NULL,
-		.metacopy = 0,
-	};
-
-	if (dentry->d_name.len > ofs->namelen)
-		return ERR_PTR(-ENAMETOOLONG);
+	unsigned int i;
+	int err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
 	upperdir = ovl_dentry_upper(dentry->d_parent);
 	if (upperdir) {
-		d.layer = &ofs->layers[0];
-		err = ovl_lookup_layer(upperdir, &d, &upperdentry, true);
+		d->layer = &ofs->layers[0];
+		err = ovl_lookup_layer(upperdir, d, &ctx->upperdentry, true);
 		if (err)
-			goto out;
+			return err;
 
-		if (upperdentry && upperdentry->d_flags & DCACHE_OP_REAL) {
-			dput(upperdentry);
-			err = -EREMOTE;
-			goto out;
-		}
-		if (upperdentry && !d.is_dir) {
+		if (ctx->upperdentry && ctx->upperdentry->d_flags & DCACHE_OP_REAL)
+			return -EREMOTE;
+
+		if (ctx->upperdentry && !d->is_dir) {
 			/*
 			 * Lookup copy up origin by decoding origin file handle.
 			 * We may get a disconnected dentry, which is fine,
@@ -1129,50 +1116,50 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			 * number - it's the same as if we held a reference
 			 * to a dentry in lower layer that was moved under us.
 			 */
-			err = ovl_check_origin(ofs, upperdentry, &origin_path);
+			err = ovl_check_origin(ofs, ctx->upperdentry, &ctx->origin_path);
 			if (err)
-				goto out_put_upper;
+				return err;
 
-			if (d.metacopy)
+			if (d->metacopy)
 				uppermetacopy = true;
-			metacopy_size = d.metacopy;
+			metacopy_size = d->metacopy;
 		}
 
-		if (d.redirect) {
+		if (d->redirect) {
 			err = -ENOMEM;
-			d.upperredirect = kstrdup(d.redirect, GFP_KERNEL);
-			if (!d.upperredirect)
-				goto out_put_upper;
-			if (d.redirect[0] == '/')
+			d->upperredirect = kstrdup(d->redirect, GFP_KERNEL);
+			if (!d->upperredirect)
+				return err;
+			if (d->redirect[0] == '/')
 				poe = roe;
 		}
-		upperopaque = d.opaque;
+		upperopaque = d->opaque;
 	}
 
-	if (!d.stop && ovl_numlower(poe)) {
+	if (!d->stop && ovl_numlower(poe)) {
 		err = -ENOMEM;
-		stack = ovl_stack_alloc(ofs->numlayer - 1);
-		if (!stack)
-			goto out_put_upper;
+		ctx->stack = ovl_stack_alloc(ofs->numlayer - 1);
+		if (!ctx->stack)
+			return err;
 	}
 
-	for (i = 0; !d.stop && i < ovl_numlower(poe); i++) {
+	for (i = 0; !d->stop && i < ovl_numlower(poe); i++) {
 		struct ovl_path lower = ovl_lowerstack(poe)[i];
 
-		if (!ovl_check_follow_redirect(&d)) {
+		if (!ovl_check_follow_redirect(d)) {
 			err = -EPERM;
-			goto out_put;
+			return err;
 		}
 
 		if (!ovl_redirect_follow(ofs))
-			d.last = i == ovl_numlower(poe) - 1;
-		else if (d.is_dir || !ofs->numdatalayer)
-			d.last = lower.layer->idx == ovl_numlower(roe);
+			d->last = i == ovl_numlower(poe) - 1;
+		else if (d->is_dir || !ofs->numdatalayer)
+			d->last = lower.layer->idx == ovl_numlower(roe);
 
-		d.layer = lower.layer;
-		err = ovl_lookup_layer(lower.dentry, &d, &this, false);
+		d->layer = lower.layer;
+		err = ovl_lookup_layer(lower.dentry, d, &this, false);
 		if (err)
-			goto out_put;
+			return err;
 
 		if (!this)
 			continue;
@@ -1181,11 +1168,11 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		 * If no origin fh is stored in upper of a merge dir, store fh
 		 * of lower dir and set upper parent "impure".
 		 */
-		if (upperdentry && !ctr && !ofs->noxattr && d.is_dir) {
-			err = ovl_fix_origin(ofs, dentry, this, upperdentry);
+		if (ctx->upperdentry && !ctx->ctr && !ofs->noxattr && d->is_dir) {
+			err = ovl_fix_origin(ofs, dentry, this, ctx->upperdentry);
 			if (err) {
 				dput(this);
-				goto out_put;
+				return err;
 			}
 		}
 
@@ -1198,23 +1185,23 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		 * matches the dentry found using path based lookup,
 		 * otherwise error out.
 		 */
-		if (upperdentry && !ctr &&
-		    ((d.is_dir && ovl_verify_lower(dentry->d_sb)) ||
-		     (!d.is_dir && ofs->config.index && origin_path))) {
-			err = ovl_verify_origin(ofs, upperdentry, this, false);
+		if (ctx->upperdentry && !ctx->ctr &&
+		    ((d->is_dir && ovl_verify_lower(dentry->d_sb)) ||
+		     (!d->is_dir && ofs->config.index && ctx->origin_path))) {
+			err = ovl_verify_origin(ofs, ctx->upperdentry, this, false);
 			if (err) {
 				dput(this);
-				if (d.is_dir)
+				if (d->is_dir)
 					break;
-				goto out_put;
+				return err;
 			}
 			origin = this;
 		}
 
-		if (!upperdentry && !d.is_dir && !ctr && d.metacopy)
-			metacopy_size = d.metacopy;
+		if (!ctx->upperdentry && !d->is_dir && !ctx->ctr && d->metacopy)
+			metacopy_size = d->metacopy;
 
-		if (d.metacopy && ctr) {
+		if (d->metacopy && ctx->ctr) {
 			/*
 			 * Do not store intermediate metacopy dentries in
 			 * lower chain, except top most lower metacopy dentry.
@@ -1224,30 +1211,30 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			dput(this);
 			this = NULL;
 		} else {
-			stack[ctr].dentry = this;
-			stack[ctr].layer = lower.layer;
-			ctr++;
+			ctx->stack[ctx->ctr].dentry = this;
+			ctx->stack[ctx->ctr].layer = lower.layer;
+			ctx->ctr++;
 		}
 
-		if (d.stop)
+		if (d->stop)
 			break;
 
-		if (d.redirect && d.redirect[0] == '/' && poe != roe) {
+		if (d->redirect && d->redirect[0] == '/' && poe != roe) {
 			poe = roe;
 			/* Find the current layer on the root dentry */
 			i = lower.layer->idx - 1;
 		}
 	}
 
-	if (!ovl_check_follow_redirect(&d)) {
+	if (!ovl_check_follow_redirect(d)) {
 		err = -EPERM;
-		goto out_put;
+		return err;
 	}
 
 	/* Defer lookup of lowerdata in data-only layers to first access */
-	if (d.metacopy && ctr && ofs->numdatalayer && d.absolute_redirect) {
-		d.metacopy = 0;
-		ctr++;
+	if (d->metacopy && ctx->ctr && ofs->numdatalayer && d->absolute_redirect) {
+		d->metacopy = 0;
+		ctx->ctr++;
 	}
 
 	/*
@@ -1258,20 +1245,20 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	 * For metacopy dentry, path based lookup will find lower dentries.
 	 * Just make sure a corresponding data dentry has been found.
 	 */
-	if (d.metacopy || (uppermetacopy && !ctr)) {
+	if (d->metacopy || (uppermetacopy && !ctx->ctr)) {
 		pr_warn_ratelimited("metacopy with no lower data found - abort lookup (%pd2)\n",
 				    dentry);
 		err = -EIO;
-		goto out_put;
-	} else if (!d.is_dir && upperdentry && !ctr && origin_path) {
-		if (WARN_ON(stack != NULL)) {
+		return err;
+	} else if (!d->is_dir && ctx->upperdentry && !ctx->ctr && ctx->origin_path) {
+		if (WARN_ON(ctx->stack != NULL)) {
 			err = -EIO;
-			goto out_put;
+			return err;
 		}
-		stack = origin_path;
-		ctr = 1;
-		origin = origin_path->dentry;
-		origin_path = NULL;
+		ctx->stack = ctx->origin_path;
+		ctx->ctr = 1;
+		origin = ctx->origin_path->dentry;
+		ctx->origin_path = NULL;
 	}
 
 	/*
@@ -1293,38 +1280,39 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	 * is enabled and if upper had an ORIGIN xattr.
 	 *
 	 */
-	if (!upperdentry && ctr)
-		origin = stack[0].dentry;
+	if (!ctx->upperdentry && ctx->ctr)
+		origin = ctx->stack[0].dentry;
 
 	if (origin && ovl_indexdir(dentry->d_sb) &&
-	    (!d.is_dir || ovl_index_all(dentry->d_sb))) {
-		index = ovl_lookup_index(ofs, upperdentry, origin, true);
-		if (IS_ERR(index)) {
-			err = PTR_ERR(index);
-			index = NULL;
-			goto out_put;
+	    (!d->is_dir || ovl_index_all(dentry->d_sb))) {
+		ctx->index = ovl_lookup_index(ofs, ctx->upperdentry, origin, true);
+		if (IS_ERR(ctx->index)) {
+			err = PTR_ERR(ctx->index);
+			ctx->index = NULL;
+			return err;
 		}
 	}
 
-	if (ctr) {
-		oe = ovl_alloc_entry(ctr);
+	if (ctx->ctr) {
+		ctx->oe = ovl_alloc_entry(ctx->ctr);
 		err = -ENOMEM;
-		if (!oe)
-			goto out_put;
+		if (!ctx->oe)
+			return err;
 
-		ovl_stack_cpy(ovl_lowerstack(oe), stack, ctr);
+		ovl_stack_cpy(ovl_lowerstack(ctx->oe), ctx->stack, ctx->ctr);
 	}
 
 	if (upperopaque)
 		ovl_dentry_set_opaque(dentry);
-	if (d.xwhiteouts)
+	if (d->xwhiteouts)
 		ovl_dentry_set_xwhiteouts(dentry);
 
-	if (upperdentry)
+	if (ctx->upperdentry)
 		ovl_dentry_set_upper_alias(dentry);
-	else if (index) {
+	else if (ctx->index) {
+		char *upperredirect;
 		struct path upperpath = {
-			.dentry = upperdentry = dget(index),
+			.dentry = ctx->upperdentry = dget(ctx->index),
 			.mnt = ovl_upper_mnt(ofs),
 		};
 
@@ -1333,77 +1321,96 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		 * assignment happens only if upperdentry is non-NULL, and
 		 * this one only if upperdentry is NULL.
 		 */
-		d.upperredirect = ovl_get_redirect_xattr(ofs, &upperpath, 0);
-		if (IS_ERR(d.upperredirect)) {
-			err = PTR_ERR(d.upperredirect);
-			d.upperredirect = NULL;
-			goto out_free_oe;
-		}
+		upperredirect = ovl_get_redirect_xattr(ofs, &upperpath, 0);
+		if (IS_ERR(upperredirect))
+			return PTR_ERR(upperredirect);
+		d->upperredirect = upperredirect;
 
 		err = ovl_check_metacopy_xattr(ofs, &upperpath, NULL);
 		if (err < 0)
-			goto out_free_oe;
-		d.metacopy = uppermetacopy = err;
+			return err;
+		d->metacopy = uppermetacopy = err;
 		metacopy_size = err;
 
-		if (!ovl_check_follow_redirect(&d)) {
+		if (!ovl_check_follow_redirect(d)) {
 			err = -EPERM;
-			goto out_free_oe;
+			return err;
 		}
 	}
 
-	if (upperdentry || ctr) {
+	if (ctx->upperdentry || ctx->ctr) {
+		struct inode *inode;
 		struct ovl_inode_params oip = {
-			.upperdentry = upperdentry,
-			.oe = oe,
-			.index = index,
-			.redirect = d.upperredirect,
+			.upperdentry = ctx->upperdentry,
+			.oe = ctx->oe,
+			.index = ctx->index,
+			.redirect = d->upperredirect,
 		};
 
 		/* Store lowerdata redirect for lazy lookup */
-		if (ctr > 1 && !d.is_dir && !stack[ctr - 1].dentry) {
-			oip.lowerdata_redirect = d.redirect;
-			d.redirect = NULL;
+		if (ctx->ctr > 1 && !d->is_dir && !ctx->stack[ctx->ctr - 1].dentry) {
+			oip.lowerdata_redirect = d->redirect;
+			d->redirect = NULL;
 		}
+
 		inode = ovl_get_inode(dentry->d_sb, &oip);
-		err = PTR_ERR(inode);
 		if (IS_ERR(inode))
-			goto out_free_oe;
-		if (upperdentry && !uppermetacopy)
-			ovl_set_flag(OVL_UPPERDATA, inode);
+			return PTR_ERR(inode);
+
+		ctx->inode = inode;
+		if (ctx->upperdentry && !uppermetacopy)
+			ovl_set_flag(OVL_UPPERDATA, ctx->inode);
 
 		if (metacopy_size > OVL_METACOPY_MIN_SIZE)
-			ovl_set_flag(OVL_HAS_DIGEST, inode);
+			ovl_set_flag(OVL_HAS_DIGEST, ctx->inode);
 	}
 
-	ovl_dentry_init_reval(dentry, upperdentry, OVL_I_E(inode));
+	ovl_dentry_init_reval(dentry, ctx->upperdentry, OVL_I_E(ctx->inode));
+
+	return 0;
+}
+
+struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
+			  unsigned int flags)
+{
+	const struct cred *old_cred;
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
+	struct ovl_entry *poe = OVL_E(dentry->d_parent);
+	int err;
+	struct ovl_lookup_ctx ctx = {
+		.dentry = dentry,
+	};
+	struct ovl_lookup_data d = {
+		.sb	= dentry->d_sb,
+		.dentry = dentry,
+		.name	= dentry->d_name,
+		.last	= ovl_redirect_follow(ofs) ? false : !ovl_numlower(poe),
+	};
+
+	if (dentry->d_name.len > ofs->namelen)
+		return ERR_PTR(-ENAMETOOLONG);
+
+	old_cred = ovl_override_creds(dentry->d_sb);
+
+	err = ovl_lookup_layers(&ctx, &d);
 
 	revert_creds(old_cred);
-	if (origin_path) {
-		dput(origin_path->dentry);
-		kfree(origin_path);
+	if (ctx.origin_path) {
+		dput(ctx.origin_path->dentry);
+		kfree(ctx.origin_path);
 	}
-	dput(index);
-	ovl_stack_free(stack, ctr);
+	dput(ctx.index);
+	ovl_stack_free(ctx.stack, ctx.ctr);
 	kfree(d.redirect);
-	return d_splice_alias(inode, dentry);
 
-out_free_oe:
-	ovl_free_entry(oe);
-out_put:
-	dput(index);
-	ovl_stack_free(stack, ctr);
-out_put_upper:
-	if (origin_path) {
-		dput(origin_path->dentry);
-		kfree(origin_path);
+	if (err) {
+		ovl_free_entry(ctx.oe);
+		dput(ctx.upperdentry);
+		kfree(d.upperredirect);
+		return ERR_PTR(err);
 	}
-	dput(upperdentry);
-	kfree(d.upperredirect);
-out:
-	kfree(d.redirect);
-	revert_creds(old_cred);
-	return ERR_PTR(err);
+
+	return d_splice_alias(ctx.inode, dentry);
 }
 
 bool ovl_lower_positive(struct dentry *dentry)
-- 
2.53.0

