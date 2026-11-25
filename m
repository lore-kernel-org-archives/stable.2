Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604593;
	b=h2srxJJJh3VVRASibPzuNFaYYyLK4n2iR4yJ+WtkbRC+naexT5IzbLTwdOILFhRdiCwf
	 Sf+78ZV7qtYXc/BiNR7UFkJreeZn5a0QaHUCKLnd8n49a8OBQzV/L9Ge9CyF4obtTH54F
	 hoWr93SgcYY+tV54p9r6fK3f6vTZgUQHMJvm8vfhBrtpSW/1N3XxV/V9ctMdc38oxLeGJ
	 MomuJsdbCaozuKmGKL9pd8KgYlpcZFIuPF+IsNwnYHGbMaDbczYPgvnE5MpJRy7ZjdFWY
	 9qSao+JM1FQ8XTWs3fTo6KRibDmLLe+F36MW1KR6uVSRwIYBImIB2anvH7nNI/QgaSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604593;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=k99rKRDT83iELUxXs0zaOb7FxHBcdY4M2y/ZtEjoJCw=;
	b=SOMwoyE1YMVax1l3NwBdeJ0mrfmcRuux0Fh1zpL3zIB/T+c2FjUj6NnRPspjayhInfKQ
	 ZNWmZ2kGWhXmiD7ccUaLlGixsL7Ue03OoIV2CCi9CGnh1GOsgKnfNp+boG+8ZHjQyFaiC
	 M79xfeSo/gDqxxtGXmmbCpb91IQPNYcrQOPiMNyS1LiKN2ZowYUuXoEFFkjsK3vH6bMO1
	 ut0izgb1mPI1XoU1foRp4hsluSB1tpV2j3I3B+vxRRVDjMYtSxtjoqJHdtSjnWycbTo1N
	 mpDD/YlZ09CrhG5pVztAZXLWXyuLKj8nni0JzW4IpPKrKQKa4h7+hhdoKPnlo5zK39Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="w9b/p5pA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466B1606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=w9b/p5pA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862291F000C0;
	Wed, 25 Nov 2026 11:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795604593;
	bh=k99rKRDT83iELUxXs0zaOb7FxHBcdY4M2y/ZtEjoJCw=;
	h=Subject:To:Cc:From:Date;
	b=w9b/p5pAUJc3qXdmAIPN8Ew9mW0GQIjRFebR+vqtgiqvhNh/FzUOe6tud4FMV375a
	 YMNYr2TBaJYi+UNAw48lJo8NKyoMMX0BORqjo/KdQcCPQrt9+EGBAoNj6hfmRO2Kcf
	 IhL9OSu7ZYY99NdJm4NaDq404CeUvr40L3QEUqrk=
Subject: FAILED: patch "[PATCH] ovl: do not check the deferred lowerdata redirect on index" failed to apply to 6.18-stable tree
To: amir73il@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:45:02 +0100
Message-ID: <2026112502-iguana-shallow-f1f7@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 011f67b2b5c366679af023261ee02e284d534a96
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112502-iguana-shallow-f1f7@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 011f67b2b5c366679af023261ee02e284d534a96 Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 7 Nov 2026 14:40:10 +0100
Subject: [PATCH] ovl: do not check the deferred lowerdata redirect on index
 lookup

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

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index e25858c8dbcd..b7fb5bb2e597 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -27,6 +27,7 @@ struct ovl_lookup_data {
 	bool last;
 	char *redirect;
 	char *upperredirect;
+	char *lowerdata_redirect;
 	int metacopy;
 	/* Referring to last redirect xattr */
 	bool absolute_redirect;
@@ -1250,6 +1251,8 @@ static int ovl_lookup_layers(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data
 	if (d->metacopy && ctx->ctr && ofs->numdatalayer && d->absolute_redirect) {
 		d->metacopy = 0;
 		ctx->ctr++;
+		d->lowerdata_redirect = d->redirect;
+		d->redirect = NULL;
 	} else if (!ovl_check_follow_redirect(d)) {
 		err = -EPERM;
 		return err;
@@ -1366,15 +1369,14 @@ static int ovl_lookup_layers(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data
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
@@ -1427,6 +1429,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	dput(ctx.index);
 	ovl_stack_free(ctx.stack, ctx.ctr);
 	kfree(d.redirect);
+	kfree(d.lowerdata_redirect);
 
 	if (err) {
 		ovl_free_entry(ctx.oe);

