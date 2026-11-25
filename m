Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604563;
	b=Bf+TiHEd7E4bQ5vAMErZOMjYLotlEl/GaOgNKEQ3EwQ25C3U/7TMCHw+JkPM0FTq9LEB
	 wkXMyzNJrlk35yciTRdQ4qKEPyC1szXAiGYZwnjp/oOkReue/3wJMMU4m4/W0fr+cKTAf
	 dAoC9vIzVXJR6uuziUTS1AXWqEDAPKS4B6LMk4VbY4gh3AZu3zVzpZogBQXES1AIqmHah
	 1aHoGcYfZ3vb9d7I5wyu+warteIr/isX/uhcLaMZEvCIlHvSmCne45rHjz6NMCLOzAlb3
	 45PJ5wGv/e99Rqo1y5twzc9sglCdW2SDEwLkXAsbjNoufFO9AHHoxyIMMo1ZpXjWNig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604563;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5BAQx2HqO3G1ruNSOnNWHo+UNkCe4g5DTAiyluSWPJc=;
	b=qCicxKFxHnSr+uKqdE6nh+oA5OjEAW+f26CQeZ/KK7p12UE50JBr2zbhp/AwuS1e7o6f
	 T3R7zw0eAdZt7L+Ie1xJ6BN1P/kyKP4RteXO6bqs3JLux7h0c0RVBkzJ0p8ipcoCOangh
	 E4RaFtYtxubx7+b66+BBzGs6BdLhJZJt7xJaj22S7eizOCt6M+724dJmXNBm8eMmpsIGP
	 d1s2dkSzWwxwxsTqvGffuGjbcOMEKVmAfn/uRrRNbw4X/+ThsHmL7/zL1NiABh2O7hD8o
	 2BnIplwJpPMuiVrt9Oa3YtiL3IegTjtO7ajmz8CKqO1l1bCBscbBLQ1FYa4hdN5Pj1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lg0fH1+6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B80606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lg0fH1+6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260E31F000C4;
	Wed, 25 Nov 2026 11:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795604562;
	bh=5BAQx2HqO3G1ruNSOnNWHo+UNkCe4g5DTAiyluSWPJc=;
	h=Subject:To:Cc:From:Date;
	b=lg0fH1+6wri8LZYhrjIq+SOYqA9LrMLb6Yoejkv0bD7YhYiHrhqKGRNV31e2kbRTR
	 FiVelg+o/Khw+0MJ+rUdWE9/a+42li9raMPn8Gb7KgpA33snSrjp06Gn25XTnc2waf
	 A4Ft2Gs9Z+roxRbPki98XmTMdykJK/mDj11SQo7c=
Subject: FAILED: patch "[PATCH] ovl: fix leak of lowerdata redirect on ovl_get_inode()" failed to apply to 6.12-stable tree
To: amir73il@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:43:40 +0100
Message-ID: <2026112540-grandly-twelve-b524@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f1b7e5534854043077bb72afc8d87ad1e0b283e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112540-grandly-twelve-b524@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

