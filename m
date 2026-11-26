Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658419;
	b=ImJkjErP2galeVPZeIiQdMXLAVoEzNgDn+CEpJBj2bVTbOwlh9JQcNa8nveNJYQejXKj
	 wc8xEcJPEndHfsNTOJ6aOMml0fZDhEiPwz4+FlgCp5vMxWI4xK0DIQXc+ddbwUKRhpwop
	 kzH2ksi9SrhyBSCacVKM9Jy9WtPA1fyh2qtlf9HsEzQUJkFbYln2LACQRgsCDMdfa4PbB
	 u/upI6uZj/t8jYt+WrKtNVLD7sSZJXHL65V8kntx/8vI1mBiBawzphqtPDkS/92x+i2l2
	 OWw2jRP5Z7nnwomwLaSUUuArvZOvnue4meRrTZVTjEP92Y0ldyE0YTl4l29+owkkDuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658419;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qk8znxdq9DU7uU0AMwKMWUtGO/FqDNm2FBMc/YFRj1Y=;
	b=j5a8aMcov0klEYEGUbV1kV8YjaUb/ZEQC8drBedhXKFmK7AULfHgZcvKIT6X+O1p7HR5
	 QXLgYUiA3spnPhq7UqAEEy37lolZORrGx8LZzpLu1KnQl/iRNdA5ouPAE72bNc+5HgTdP
	 9PM7mEFayfxu8YIWCIeg2thk+ggqKgPGDidWFcMXIST/Ueaey1dCyGbmyf01kcAmW5ylK
	 y5tCWcapC8c1oaMtnBA+5X9KcU/9qk360yaCcauyHoh9BEKmaXYxDX5s7zzY9UWLa4kHH
	 2UF90dGvcqFklG1mmuyDsnRy32OX0NdsWG4hyWM9A50C4434Lbm/V2HVPT09JeXJU6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHTZRl4v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4A1606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHTZRl4v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D9C1F000C6;
	Thu, 26 Nov 2026 02:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658419;
	bh=qk8znxdq9DU7uU0AMwKMWUtGO/FqDNm2FBMc/YFRj1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BHTZRl4vuDvadeAcKWXYCTreUXBKvidwEzTzgy3a0qgnLyjgeXa0IFPU3iNZHLyMf
	 hZjKK785oDOQxdlWRkDmR9lj7gpfv1BFZ4TUG2u4dS0DdocmnIqzXqzxHLxdXZcMAb
	 rPwpzG6ndHIXnx4stqOUIjLC18P9sLuauWNiMXU8GElOpH0ibCcSp7K+4Cr32zr4pV
	 TVoKseCTpfypZ9TjZXjnyHdedN5u9kW+6PkIhqb/FYBtXmpw6/GJHPthUsZ+MVMZ40
	 9vQbBbmIW+GbzBIu7qwGPQndRFhUFD/d5qzXLRlzrYLfLe3a7CUYA+U8byOVd5H1P7
	 ZNPGnTUm0xajg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ovl: do not check the deferred lowerdata redirect on index lookup
Date: Wed, 25 Nov 2026 21:00:17 -0500
Message-ID: <20261126020008.1696970-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112502-iguana-shallow-f1f7@gregkh>
References: <2026112502-iguana-shallow-f1f7@gregkh>
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

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 011f67b2b5c366679af023261ee02e284d534a96 ]

When a lower metacopy has an absolute redirect into a data-only layer,
ovl_lookup_layers() defers the data lookup and skips
ovl_check_follow_redirect(), but leaves the redirect in d->redirect.
If there is no upper dentry and a sibling hardlink was already copied
up to the index dir, the index branch calls ovl_check_follow_redirect()
again and, with redirect_dir=nofollow (e.g. forced by userxattr), fails
the lookup with -EPERM because of the lower data redirect.

Take the lowerdata redirect out of d->redirect at the point where the
data lookup is deferred, so that the index check only validates the
redirect and metacopy state of the index entry.

Fixes: 5ef7bcdeecc9 ("ovl: relax redirect/metacopy requirements for lower -> data redirect")
Closes: https://sashiko.dev/#/bug/linux-29bea9ea-5376-4e54-88f6-04dabce4db70
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261126014412.1696101-1-sashal@kernel.org>
Depends on <20261126015323.1696322-1-sashal@kernel.org>

 fs/overlayfs/namei.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 2903f17cfdf91..313ffc2d51da1 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -26,6 +26,7 @@ struct ovl_lookup_data {
 	bool last;
 	char *redirect;
 	char *upperredirect;
+	char *lowerdata_redirect;
 	int metacopy;
 	/* Referring to last redirect xattr */
 	bool absolute_redirect;
@@ -1259,6 +1260,8 @@ static int ovl_lookup_layers(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data
 	if (d->metacopy && ctx->ctr && ofs->numdatalayer && d->absolute_redirect) {
 		d->metacopy = 0;
 		ctx->ctr++;
+		d->lowerdata_redirect = d->redirect;
+		d->redirect = NULL;
 	} else if (!ovl_check_follow_redirect(d)) {
 		err = -EPERM;
 		return err;
@@ -1375,15 +1378,14 @@ static int ovl_lookup_layers(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data
 		};
 
 		/* Store lowerdata redirect for lazy lookup */
-		if (ctx->ctr > 1 && !d->is_dir && !ctx->stack[ctx->ctr - 1].dentry)
-			oip.lowerdata_redirect = d->redirect;
+		if (d->lowerdata_redirect)
+			oip.lowerdata_redirect = d->lowerdata_redirect;
 
 		inode = ovl_get_inode(dentry->d_sb, &oip);
 		if (IS_ERR(inode))
 			return PTR_ERR(inode);
 
-		if (oip.lowerdata_redirect)
-			d->redirect = NULL;
+		d->lowerdata_redirect = NULL;
 
 		ctx->inode = inode;
 		if (ctx->upperdentry && !uppermetacopy)
@@ -1439,6 +1441,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	dput(ctx.index);
 	ovl_stack_free(ctx.stack, ctx.ctr);
 	kfree(d.redirect);
+	kfree(d.lowerdata_redirect);
 
 	if (err) {
 		ovl_free_entry(ctx.oe);
-- 
2.53.0

