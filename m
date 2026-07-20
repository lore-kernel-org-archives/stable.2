Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949AF434E43
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560256; cv=none; b=V4mhPrbK+cNLThHNRIQaQyhhYrqAyCG1QuAoXuny9f1AFlsU5CHb0veC1FTML4QAE6cJ39VL6OayuJB0JEB+xkFXufyAoQxpyufikEuIZFJNPX13yGrNNBW5kKs5PrYUL3FpE22AWot/z9zwAU+tgvMnTTynNgHmMFcGujl2x6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560256; c=relaxed/simple;
	bh=ono7fOJTiFiaIL0f51sKsYItbJtA0gmS5OYWfFOlekg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bAM4JHlq2NuHh2VWMTPtlm0VRDAcNy6S4/tUvpyuZDqCpsrHIAS4/plprAm5pMzTdlZAsW7xd8HJ9gO+OZgF3vW6iIH65UAtSprg58anBLnSWqZ42JQY2YRU1CjUhicW0xxqftQWD6nIwZg2E0vYikvZuKR9+mTnTP5TzAwg5ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y/SIJG4G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y/SIJG4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02DC1F000E9;
	Mon, 20 Jul 2026 15:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560254;
	bh=JMXaHahd3sL4aZ66XQW2cFTEcq1GxdYbvbK0aRqYXtE=;
	h=Subject:To:Cc:From:Date;
	b=Y/SIJG4Gv+jP8nLcpItUR8HfvsegXr6F86142rtN0t5Za84GO9ITlz+fryT1VBr6z
	 O+nqlV0NUymHErOPdr2fyP2iRpBlpis2bk1LcwX4tvdJpWe3eiDIJMoONQ8rD42zMQ
	 JssKWMOx8N2IYQfiYq5PBABPoQjAMHPmDDVVRrq0=
Subject: FAILED: patch "[PATCH] ovl: use linked upper dentry in copy-up tmpfile" failed to apply to 5.15-stable tree
To: souvik@amlalabs.com,amir73il@gmail.com,brauner@kernel.org,mszeredi@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:10:34 +0200
Message-ID: <2026072034-passage-ebay-b6c7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e348eecd4d8fa8d18a5157ff59f7be1dc59c5928
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072034-passage-ebay-b6c7@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e348eecd4d8fa8d18a5157ff59f7be1dc59c5928 Mon Sep 17 00:00:00 2001
From: Souvik Banerjee <souvik@amlalabs.com>
Date: Fri, 1 May 2026 23:27:35 +0000
Subject: [PATCH] ovl: use linked upper dentry in copy-up tmpfile
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ovl_copy_up_tmpfile() stores the disconnected O_TMPFILE dentry as the
overlay's upper dentry reference via ovl_inode_update().  vfs_tmpfile()
allocated this dentry via d_alloc(parentpath->dentry, &slash_name), so
d_name is "/" and d_parent is c->workdir.  Local upper filesystems
(ext4, btrfs, xfs, ...) immediately rename it to "#<inum>" via
d_mark_tmpfile() inside their ->tmpfile() op; FUSE and virtiofs do
not, so both fields stay that way.  Neither identifies the destination
directory and filename where ovl_do_link() actually linked the file.

When the upper filesystem implements ->d_revalidate() (e.g. FUSE or
virtiofs), ovl_revalidate_real() calls it with the dentry's parent
inode and a snapshot of d_name.  The server tries to look up "/" inside
c->workdir, fails, and overlayfs reports -ESTALE.

This causes persistent ESTALE errors for any file that was copied up via
the tmpfile path, breaking dpkg, apt, and other tools that do
rename-over-existing on overlayfs with a FUSE/virtiofs upper.

Before commit 6b52243f633e ("ovl: fold copy-up helpers into callers"),
the tmpfile copy-up path used a dedicated helper ovl_link_tmpfile()
that captured the linked destination dentry returned by ovl_do_link():

    err = ovl_do_link(temp, udir, upper);
    ...
    if (!err)
        *newdentry = dget(upper);

and published it via ovl_inode_update(d_inode(c->dentry), newdentry).
The fold inlined ovl_do_link() into ovl_copy_up_tmpfile() but dropped
the dget(upper) capture, and rewrote the publish line as
ovl_inode_update(d_inode(c->dentry), dget(temp)) — where temp is the
disconnected O_TMPFILE dentry.

Fix by keeping a reference to the linked destination dentry after
ovl_do_link() succeeds, and publishing that dentry at the existing
ovl_inode_update() call site.  The non-tmpfile/workdir path continues to
publish the renamed temporary dentry.

Reproducer:
  - Mount overlayfs with virtiofs (or a FUSE fs whose server advertises
    FUSE_TMPFILE) as upper
  - Run: dpkg -i <any .deb>
  - Observe: "error installing new file '...': Stale file handle"

Fixes: 6b52243f633e ("ovl: fold copy-up helpers into callers")
Cc: stable@vger.kernel.org # v4.20+
Signed-off-by: Souvik Banerjee <souvik@amlalabs.com>
Link: https://patch.msgid.link/20260501232735.2610824-1-souvik@amlalabs.com
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 13cb60b52bd6..e963701b4c87 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -853,7 +853,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 {
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct inode *udir = d_inode(c->destdir);
-	struct dentry *temp, *upper;
+	struct dentry *temp, *upper, *newdentry = NULL;
 	struct file *tmpfile;
 	int err;
 
@@ -889,6 +889,14 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 	err = PTR_ERR(upper);
 	if (!IS_ERR(upper)) {
 		err = ovl_do_link(ofs, temp, udir, upper);
+		if (!err) {
+			/*
+			 * Record the linked dentry -- not the disconnected
+			 * O_TMPFILE dentry -- so that ->d_revalidate() on
+			 * the upper fs sees the real parent/name.
+			 */
+			newdentry = dget(upper);
+		}
 		end_creating(upper);
 	}
 
@@ -903,7 +911,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 
 	if (!c->metacopy)
 		ovl_set_upperdata(d_inode(c->dentry));
-	ovl_inode_update(d_inode(c->dentry), dget(temp));
+	ovl_inode_update(d_inode(c->dentry), newdentry);
 
 out:
 	ovl_end_write(c->dentry);

