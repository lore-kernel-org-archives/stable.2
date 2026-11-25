Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604566;
	b=ghkgFIkYi+dScYlKI9+yh+eitukGU8ic6He8t4wyi1T3jLKss5ic/2kWYd0fFQ8rt288
	 y1CMDNzajlYzUIDS5ElBUNI80AdAZ+ddJEig5NHrtpXHCQ7sLlsYxwFHXbKzal5wBIK8k
	 UD4CH+fwnhrjt2nKr4orS/dXxb64lWYtDlwyW8XWcYpBYpvpirJ6ZnDzM1gJ8qTF7IwTx
	 5rGrmjPJqnK5nDZG7nhWTt49rvhIOSsM3FxUhGUAfFeG5B7SdZ5Im0eC23ChFUn8breNS
	 HhFy6WSOYNAla+I/tzVf4d0xdSjMPrzJrDCKbeX7qSxCTj0rKAlq9QJe8rVefTY5SLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604566;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/7lFCJ17I2kqQJ7no+mYSvG38q/cJJgy3ldFO17RvNk=;
	b=W9Oe7pqCcr1pwA4zIXxucP8jZrzvfy+gPz1PtUk4mMvZQc6iip21dLbtWCjKzeNxpKXS
	 G08MdwTiS1PwhcqK/jBCEf6A6f3pSvlfYzLtpm/Rhmwfap5jBBUjgRAFTzU3TVw8DgEns
	 sX/5MO1me9leORLA64s2/oZb7HrAzlXcFu7rRZh+UQ7xyorxwNBTAsRtVJq4Ku29Oz5A+
	 VK2wp4fB6IUquuPvgv9Ke+HktdnWCDpt0M64l6xKepDk3JoV18TCenoZeJVbz6GHxeV0H
	 rL+vvX18FOUt+qLABFt+hPt5ijMrSP+njise32eknVB7OHL+cDtHMOPjqAvqd8L4CdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Y1V0v4kT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7706E606A333
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Y1V0v4kT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8220E1F000C0;
	Wed, 25 Nov 2026 11:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795604566;
	bh=/7lFCJ17I2kqQJ7no+mYSvG38q/cJJgy3ldFO17RvNk=;
	h=Subject:To:Cc:From:Date;
	b=Y1V0v4kTZm9+8zYf7NWPyGC9X74NWTJgcN9HlT2NmxzOKMlMpIX5Gr5nENP20ztR5
	 UxkRXz4zcPmmBABMr0XMpwyKzGUlKw9VNazLc8oywsBJBh13nyEP80N2SrT8+e1l+K
	 +diQThbGtFZM7h9iSpjyIvPIkC4VTyvbLcomMaCI=
Subject: FAILED: patch "[PATCH] ovl: fix leak of lowerdata redirect on ovl_get_inode()" failed to apply to 6.6-stable tree
To: amir73il@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:43:40 +0100
Message-ID: <2026112540-ipod-frantic-30d3@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f1b7e5534854043077bb72afc8d87ad1e0b283e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112540-ipod-frantic-30d3@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

