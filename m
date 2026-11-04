Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802958;
	b=XIho+zOMHM/HsYiz/bRP6+fNuyFzqU3zP46611EtRIHRtx7sqJn2xMo4+MV5Ww2N+thj
	 /Fo0iNevCAT2NyDsey9V7HJvgEVYdPVPLUuCb1m7FxvYG5nOMZvCDBoK5uQ8Z2sbTYGyl
	 WlyC2UJGRbV+SqwJ4XV4vRc4ciaxTcFuiAM8PSDLRWUByMTmscU5kuA5kzsB6yVXMPHgz
	 DiP6qCI9i8MGGPDsTXZ1k2VCGQuAD1SOfI1ZTkAFo4QwQp9v6NYgAF1bg/QjPlPaB67DF
	 7P03R4RphR9gQ83Dhj3g3AAk75K0dc9k0AMRiV0S3AHWBwg+p1r2g5mySNST8X0mX2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802958;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nJsCLrDSyvo2XsvNXLsN+p408ivsrueD/lkp5Xhlc/A=;
	b=A1/+ioJFtN67iGEmyFM42BjJQMrJh5C4qkn+wnNOEarnuyngZaMj6IRwcYKZn7fua222
	 G8X0aJ5Qhhu1OE6HRhhKFajj51JfIG/+vu3KaisfdiJzqxYwpRKtwy6P27lHXXcCvR6WV
	 G9+aJdzPtTN8PdUwKmjhAi+a9quzMq2tpoZn5vmdfu8CH0IWGvZ8daqDp+enlkpi8dQI+
	 9L1iAyCGbvJap552Z7VnTsmK0vohRx/A49K4Vs8d5rViye0ZfQR4xU6+VuowyosDxw0U0
	 Ju34A3Gm+RkGL4DP9fGkwIqJO4bG0DbbyG7XGDJaqewTQxmnN8E5iNw9Yu9nAQjvppw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rqdORTvL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28CB606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rqdORTvL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611FD1F00919;
	Wed,  4 Nov 2026 14:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802957;
	bh=nJsCLrDSyvo2XsvNXLsN+p408ivsrueD/lkp5Xhlc/A=;
	h=Subject:To:Cc:From:Date;
	b=rqdORTvLmxW/Xz8C2MjrhWUCrPAof2KToVks+FgYsVH4RiJ6hlDITItWmE2JOhErT
	 gGYQnPx1ETe2EHXSQvykykDVyLkRro3Gq+VEl6tBUlkYHj4tReDy/54UAsrQ55kupN
	 H+ksdUUf3w+09IVMa2LW7lJJjBgPb2RxtFMPHhTA=
Subject: FAILED: patch "[PATCH] ovl: check that the parents of volatile/dirty are dirs" failed to apply to 6.12-stable tree
To: mason@kernel.org,amir73il@gmail.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:35:52 +0100
Message-ID: <2026110452-attic-confusion-b886@gregkh>
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
git cherry-pick -x e34d2ef818e4c7676d8d8e1bf43e6a1ed39efb2a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110452-attic-confusion-b886@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e34d2ef818e4c7676d8d8e1bf43e6a1ed39efb2a Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Wed, 7 Oct 2026 10:15:11 +0000
Subject: [PATCH] ovl: check that the parents of volatile/dirty are dirs

An unprivileged user crashes the kernel by mounting overlayfs with the
volatile option.

A dentry that serves as the parent of a lookup must be a directory.
ovl_create_volatile_dirty() walks work/incompat/volatile/dirty by name,
and ovl_lookup_or_create() returns an existing entry whatever its type.
A file or a symlink that another task creates during the mount becomes
the parent of the next lookup, which calls a NULL ->lookup.

An unprivileged user mounted overlayfs with "volatile" in a user
namespace while a second process created a symlink named work/incompat,
and the mount task oopsed on a NULL ->lookup call.

Fix this by returning -ENOTDIR from ovl_lookup_or_create() when the
caller asked for a directory and the existing entry is a non-dir.

Fixes: c86243b090bc ("ovl: provide a mount option "volatile"")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index bd0a3f9039d2..18f56d463572 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -621,16 +621,21 @@ cleanup_temp:
 
 static struct dentry *ovl_lookup_or_create(struct ovl_fs *ofs,
 					   struct dentry *parent,
-					   const char *name, umode_t mode)
+					   const char *name, bool is_dir)
 {
 	struct dentry *child;
 
 	child = ovl_start_creating_upper(ofs, parent, &QSTR(name));
 	if (!IS_ERR(child)) {
-		if (!child->d_inode)
+		if (!child->d_inode) {
 			child = ovl_create_real(ofs, parent, child,
 						&QSTR(name),
-						OVL_CATTR(mode));
+						OVL_CATTR(is_dir ? S_IFDIR :
+								   S_IFREG));
+		} else if (is_dir && !d_can_lookup(child)) {
+			end_creating(child);
+			child = ERR_PTR(-ENOTDIR);
+		}
 		end_creating_keep(child);
 	}
 	dput(parent);
@@ -652,7 +657,7 @@ static int ovl_create_volatile_dirty(struct ovl_fs *ofs)
 	const char *const *name = volatile_path;
 
 	for (ctr = ARRAY_SIZE(volatile_path); ctr; ctr--, name++) {
-		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1 ? S_IFDIR : S_IFREG);
+		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1);
 		if (IS_ERR(d))
 			return PTR_ERR(d);
 	}

