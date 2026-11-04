Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803060;
	b=Hf2jak+pFch0q9BNyEG7EhsKkWLTo6D/47zI3/ALgR6tVMOvR33GNxnTgI6gvU1/dGRG
	 L1w7If6UsSFGp0amEpUOudErM7Yo3xi9/WZpwTR/zghrEfzgjgKfs7+wl4KCbahOtjHAx
	 LVFgc+iWb9H1BEM4jYF00GxIgHIjKWmzys13KyBq0JMi9NIWxdba1ZgGrqMllOWiB7IrB
	 DS1ka3zrkDic4FVo60OU70EyE0bfnADewBuF6KcF4XAF+DQylDDNBLd9V9ayiAx0uyCGN
	 epIsKOf0VZovB4Mpx9sfL0g0qZqVurKfP24XPQtgSjbJw0m4VOHVX56cBvRPwDKZrmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803060;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zonf7dO53XWxwJrdfSJIR44ldDf0d7rA0MysAOlXNBw=;
	b=1QXzKchG1GmbyFWMjZ+74El/CWTXylqfo3ETPn9H/153Uxa3MpXT3UoxsDwp3kgfn9zB
	 lhyw7Cb4Dv6a70IG+H5ACYZ9z0BONT2qXDp0Pt8+mS8gAW7Vi+T3IL6jWIzMpkCOHpLDy
	 PfoE2jc/FS+xVjLQus8WD3lD2R23gnCbyFyf8jYb5pJOlK/LPAzEusGvAsPUzgat7uXqp
	 Ial5JZcSGiBl+VdT2Hnksrs1GQfMh3iEDovwH0PlQM9VsobzxQu6ryEBXnqc1P43VMZYO
	 drf5qD6/9E9Z8R2t+HxvZafB2bTyJWGaBLBLpeQD3UI8BqxkGs/JyNlCenj3vttvM3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="GCDN/59j";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F929606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=GCDN/59j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DDF1F000C1;
	Wed,  4 Nov 2026 14:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793803060;
	bh=zonf7dO53XWxwJrdfSJIR44ldDf0d7rA0MysAOlXNBw=;
	h=Subject:To:Cc:From:Date;
	b=GCDN/59jCdth4P0u9peY35eolGDmDSDr6YRjCqumuIb7ur08hlkNGm/sBxXXMYTwL
	 OOj393zYYl0dLHswCR1w202dZMElsaKe+r4+6QQtYoGiXiZvYsp5GWs8ef2oKahl8N
	 /Qw79exNuiusRt0xYjn+nK2pZkcRG5qfQ9ieAjvE=
Subject: FAILED: patch "[PATCH] ovl: set the revalidate flags after d_instantiate()" failed to apply to 5.10-stable tree
To: mason@kernel.org,amir73il@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:37:30 +0100
Message-ID: <2026110430-explain-dedicator-cfef@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 75e89c0055c1d7f7eeb462995f11253ca5864f79
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110430-explain-dedicator-cfef@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 75e89c0055c1d7f7eeb462995f11253ca5864f79 Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Fri, 16 Oct 2026 21:17:23 +0000
Subject: [PATCH] ovl: set the revalidate flags after d_instantiate()

stat() of a file on an overlayfs mount triggers a kernel warning and
fails with ECHILD if another task is creating that file at the same
time. This happens on an overlay with a FUSE upper layer, which is the
layer where overlayfs creates new files. Write access to a directory on
such an overlay is all a user needs to run the two tasks.

The revalidate flags are DCACHE_OP_REVALIDATE and
DCACHE_OP_WEAK_REVALIDATE. They tell path walk to call ->d_revalidate()
or ->d_weak_revalidate() on a dentry, so that the filesystem can check
that the cached dentry is still valid. An overlay dentry only has one of
these flags if a dentry in one of its layers has it. FUSE dentries have
the first one.

When a flag is set on an overlay dentry, path walk calls
ovl_dentry_revalidate_common(). That function only expects a dentry
without an inode in RCU walk, while the dentry is being destroyed. For
such a dentry outside of RCU walk, it hits a WARN_ON() and
returns -ECHILD. So a negative overlay dentry must never have the flags
set.

ovl_instantiate() breaks this rule. When a task creates a file, the
overlay dentry for the new name is hashed but still negative.
ovl_instantiate() then works in this order:

- It copies the flags from the new upper dentry to the overlay dentry.
- It calls ovl_get_inode(), which can sleep in a getxattr request to the
  FUSE server.
- Only then does it call d_instantiate().

A second task that looks up the name between the first step and the last
finds a negative dentry with the flags set and revalidates it.

Reproduced with a FUSE server that delays its getxattr reply: stat() of
a name that was being created hit the WARN_ON() and failed with ECHILD.

Fix this by setting the flags after d_instantiate().

Fixes: bccece1ead36 ("ovl: allow remote upper")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index b3f6d4b82f68..f716ac13badf 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -304,7 +304,6 @@ static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
 	};
 
 	ovl_dentry_set_upper_alias(dentry);
-	ovl_dentry_init_reval(dentry, newdentry, NULL);
 
 	if (!hardlink) {
 		/*
@@ -335,6 +334,13 @@ static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
 		d_mark_tmpfile(tmpfile, inode);
 
 	d_instantiate(dentry, inode);
+	/*
+	 * Unless it is a tmpfile, the dentry is hashed and a path walk can find
+	 * it at any time.  Set the revalidate flags only now, because
+	 * ovl_dentry_revalidate_common() does not expect them on a negative
+	 * dentry.
+	 */
+	ovl_dentry_init_reval(dentry, ovl_dentry_upper(dentry), NULL);
 	if (inode != oip.newinode) {
 		pr_warn_ratelimited("newly created inode found in cache (%pd2)\n",
 				    dentry);

