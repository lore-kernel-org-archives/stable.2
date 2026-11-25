Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604570;
	b=J2CgvvlDNntzK8N/hLF6gE9XchjjPGREQE9PUBeh5Vy6cB3P0IkzB0lEV280RkBh6SoT
	 ajbG8uDDUB78YS7OjRjPLR9qN2azHsgUOlYrbZdjMLd6N8v8Ffy4UJMFNlmD/+M3ilyTk
	 ka6YqaecPNSd3s+JLxYtJYbqa1qaqM6nHj4r/z1LKTMYISMd5I7nB0DTdaJsuUU63AwCQ
	 6glW1c2oDAIqJdqsex760V/7BcYO/5OwkvqNEB4suS4oIDnaO2FY5CEkYyor8y6EBAhYj
	 7wnulIYam48jHix0nvWVhlfdGe+N6jlpw4rjTmlZGmB77WQtsgj8RWSqk2vfcdutPFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604570;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7XKhHKqRUVmQyd3GY0LNlfbhsf8pLg8zustHcvtS02I=;
	b=Ozy6B7KPoFDWWuFtFlBHK9SI6PO4EUMAImJ5b8+e4RXRZwBvVKolBYnkA7dpQ1pu1k9V
	 mdXUkbnPFHcBmXMdmdySfgdd8x7S1t7yIhCg07JF76v0VHjuKKMLBxlytL37T0/rhKLny
	 /OLo7gpQYadZ9ts9aLXPzJ3AvCu9uPJtpAsZNDNtKG9tatD9iDQC3D8OAtXEFMrL65s8+
	 I1FfNTanzWHb5hdSi7wr4JUJHzpkLM4wh5L7blGQedmlSQ7kpXlT2a8FK/cwRXqbtRH3r
	 ndFnSmmsqv3b3pIV/B08/HaAf+FZKWikSl0Br8nP81dVE24CBTylnzX5+U2zjcckb+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1GmFbTWS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969D606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1GmFbTWS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524491F00A3E;
	Wed, 25 Nov 2026 11:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795604569;
	bh=7XKhHKqRUVmQyd3GY0LNlfbhsf8pLg8zustHcvtS02I=;
	h=Subject:To:Cc:From:Date;
	b=1GmFbTWSheXE0XMnJbPc0vLuOG5PhuBJS+WHrL1Gwc5vHTbSmqDms6/GwxKJmcpnQ
	 7PpV6hhaU6BGqZ2CLqhJKw3aG78PijhQta1GMhNa9pW6djGAHL9tU6zTfwqeXhvaNn
	 iYNaPZuzdwLDkX8H2mh4S7qUdfLa7ZaVTy5NYUy4=
Subject: FAILED: patch "[PATCH] ovl: fix leak of lowerdata redirect on ovl_get_inode()" failed to apply to 6.18-stable tree
To: amir73il@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:43:40 +0100
Message-ID: <2026112540-carnation-surplus-b95c@gregkh>
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
git cherry-pick -x f1b7e5534854043077bb72afc8d87ad1e0b283e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112540-carnation-surplus-b95c@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f1b7e5534854043077bb72afc8d87ad1e0b283e0 Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 7 Nov 2026 15:48:36 +0100
Subject: [PATCH] ovl: fix leak of lowerdata redirect on ovl_get_inode()
 failure

ovl_lookup_layers() moves d->redirect into oip.lowerdata_redirect and
clears d->redirect before calling ovl_get_inode().  When ovl_get_inode()
fails, it does not free oip.lowerdata_redirect, and ovl_lookup() frees
the already cleared d->redirect, so the lowerdata redirect string is
leaked.

Clear d->redirect only after ovl_get_inode() has succeeded, like
d->upperredirect, so that ovl_lookup() frees it on failure.

Fixes: 2b21da920866 ("ovl: prepare to store lowerdata redirect for lazy lowerdata lookup")
Closes: https://sashiko.dev/#/bug/linux-dabbd363-9c71-4915-af72-e2b5e75fa58e
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index a27479a10027..e25858c8dbcd 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1366,15 +1366,16 @@ static int ovl_lookup_layers(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data
 		};
 
 		/* Store lowerdata redirect for lazy lookup */
-		if (ctx->ctr > 1 && !d->is_dir && !ctx->stack[ctx->ctr - 1].dentry) {
+		if (ctx->ctr > 1 && !d->is_dir && !ctx->stack[ctx->ctr - 1].dentry)
 			oip.lowerdata_redirect = d->redirect;
-			d->redirect = NULL;
-		}
 
 		inode = ovl_get_inode(dentry->d_sb, &oip);
 		if (IS_ERR(inode))
 			return PTR_ERR(inode);
 
+		if (oip.lowerdata_redirect)
+			d->redirect = NULL;
+
 		ctx->inode = inode;
 		if (ctx->upperdentry && !uppermetacopy)
 			ovl_set_flag(OVL_UPPERDATA, ctx->inode);

