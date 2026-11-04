Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802916;
	b=mvQiyTb/htDw3kkjeiaw7lYhsJJGhBr1lSAEyk4lVgXhKxfJEU9gSaprS4IrqqO2o+2l
	 gnPfFshcgPydbxQu7RnNvvN0BUbr/wtyIj/3Y+p9u0JDzPjJKWIPia5CxBpJ7Lj+tMbsF
	 I+3AzFXXaoJTpGtotHTzvEBgCePeg4lYptJcGwI6OYtUMKTRKQMp2jXlsEFmzOtY/9dvc
	 QqifaUkg4y8/ad3fiFA8ih0nFS/NC2roFq8PxYqUtNm2S1iHcYp81jU1QDzHpdBBy85d+
	 Y3ZFYWuLMZOCL9UAjG7Mzpwz1UyIiYRGpz0sYP5mw5waQLaMfwpM4xIUByEtlHnnvig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802916;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZJzRPIIoYzHeh/hFcxgjVYlQ4Zr3AOy8SynW9BTCo6g=;
	b=kX0nmKroi16kSlT9Y7YtdVLPVKoBk2/Q39VIZ6dZmK8dS6EMrUwGUJieNBVgT2aPQ3it
	 MGtA4QRV6be1M0VBSi2CVSPAFbY8Wmklo8uKHuBoI0UezapZocwJTMwywR4ECScAuf+3Q
	 UE5ZJXN3uzd595YFY7bZGhD2QmmLJdAh64ZaedZdP+AablBoygSWMDvzRq4r2olrblEou
	 ci18RzsAkSOxKgQeCou+oIM3fJUOvemmY2awbHrLJBNbdskHiT1NarT1gsBY8YAo5UyMV
	 Q9vvZkdJ329dBCcYnsvzqLgs5zsRcyjXId77pwfdtq/5+j6V4fwv/gWkOjynOvzQ6lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RZL13BM+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ACC606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RZL13BM+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD7D1F000C1;
	Wed,  4 Nov 2026 14:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802915;
	bh=ZJzRPIIoYzHeh/hFcxgjVYlQ4Zr3AOy8SynW9BTCo6g=;
	h=Subject:To:Cc:From:Date;
	b=RZL13BM+61KYcvOJ+PczaHZgmxfHAunTGpfeP0LEfECrje96cyYc38MMg49C9Gq4g
	 qIkpkvBvQ++m0sZav3y/7/m4q7izz4UMjqecnWT1JKp/1QCqmmIH3Qxr+xsnAMZ9cu
	 VdN7DF4uCWYnxxMHxZlcyAmRAwcvcXJV+USMbDWM=
Subject: FAILED: patch "[PATCH] ovl: take a snapshot of the name for copy up" failed to apply to 6.6-stable tree
To: mason@kernel.org,amir73il@gmail.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:35:14 +0100
Message-ID: <2026110414-plexiglas-angelfish-3128@gregkh>
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
git cherry-pick -x 65bf000962a33ec9d2488e4e1797b6cf630abcbb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110414-plexiglas-angelfish-3128@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 65bf000962a33ec9d2488e4e1797b6cf630abcbb Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Wed, 7 Oct 2026 10:34:08 +0000
Subject: [PATCH] ovl: take a snapshot of the name for copy up

The copy up of a directory reads a freed dentry name when a lookup
moves the directory at the same time.

A pointer to the name of a dentry is only valid while something stops
a move of the dentry. ovl_do_copy_up() keeps a plain copy of
c->dentry->d_name in c->destname, and ovl_copy_up_start() only keeps
ovl_rename() away. When a lookup finds the same directory under another
name after a change to the lower layer, d_splice_alias() moves the
dentry and frees its external name.

With a delay in ovl_do_copy_up(), a chmod of a lower-only directory with
a 60 byte name raced with a rename of that directory in the lower layer
and a stat of the new name, and KASAN reported a use-after-free in
lookup_noperm_common().

Fix this by using take_dentry_name_snapshot() for c->destname.

Fixes: 829c28be9bb9 ("ovl: use d_splice_alias() in place of d_add() in lookup")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 92b3d08a0234..12000e45fefc 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -920,6 +920,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct dentry *origin = c->lowerpath.dentry;
 	struct ovl_fh *fh = NULL;
+	struct name_snapshot name;
 	bool to_index = false;
 
 	/*
@@ -957,12 +958,15 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 		goto out_free_fh;
 	} else {
 		/*
-		 * c->dentry->d_name is stabilzed by ovl_copy_up_start(),
-		 * because if we got here, it means that c->dentry has no upper
-		 * alias and changing ->d_name means going through ovl_rename()
-		 * that will call ovl_copy_up() on source and target dentry.
+		 * ovl_copy_up_start() keeps ovl_rename() away from c->dentry,
+		 * because ovl_rename() calls ovl_copy_up() on source and target
+		 * dentry.  It does not stop d_splice_alias() from moving a
+		 * directory that a lookup found under another name after a
+		 * change to the lower layer.  That move frees an external name,
+		 * so take a snapshot.
 		 */
-		c->destname = c->dentry->d_name;
+		take_dentry_name_snapshot(&name, c->dentry);
+		c->destname = name.name;
 		/*
 		 * Mark parent "impure" because it may now contain non-pure
 		 * upper
@@ -971,7 +975,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 		err = ovl_set_impure(c->parent, c->destdir);
 		ovl_end_write(c->dentry);
 		if (err)
-			goto out_free_fh;
+			goto out;
 	}
 
 	/* Should we copyup with O_TMPFILE or with workdir? */
@@ -1005,6 +1009,8 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 out:
 	if (to_index)
 		kfree(c->destname.name);
+	else
+		release_dentry_name_snapshot(&name);
 out_free_fh:
 	kfree(fh);
 	return err;

