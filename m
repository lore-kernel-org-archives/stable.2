Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546153B4E95
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166882; cv=none; b=XNKMF3laBNQFlcy5UdimmLAOyPVLABgQFdb64vpM+dYE2so96EA+BVSJSmJwIcRJkBCHPjZSpFBMe/1AJP6KZJBj6MCeNScB7eN4MxJzdvfMFDpAus3J64PpRf2uyHuR6RBs4i5UukVNseMKV3WsucyNClHYeGmI3POSpoEJd9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166882; c=relaxed/simple;
	bh=dhgzeUXB4Lu2AzNQLiYi/hiR1an6qEvsBafLFvZwoRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOWjr4hjad0+Dcfq7b+eW43O1q1hPhKu0Dwxmb/SFl14zIy/t7+vwjKEzGmZfcMqSxbJZ2Rh7KQxBGJOOQXNl/l32nSleUwPpOA3RN7ZFMOKCYXtgHuvz4t5oImPyZ9PGPIFj290uRkTUGq+l2A4CxwufO4RK6tAci5HeLBOhCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vdm9+c9u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vdm9+c9u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD5A1F000E9;
	Mon, 27 Jul 2026 15:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166880;
	bh=6FaJEduX6Ip6kfBFx2wJl0XAAzJJIWdHVAc60KhxYSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vdm9+c9u484z9gCw1XQv97sW6Gf/hkNzPQcQLF/G920LFHSMIPfo+7O9LfFbqoEGx
	 bw+pwAlLyP7Lsk7jD2dQ2hI31inXQZO0IowcW3WK43hlYbX2ErysC7Pql+7v1KAHCC
	 RTwh9WA1NHExsZmtdU8tvIg+TLStaL1KSpKcsgiqAgsVtt+5BAXray1uS1/XhfazRX
	 PKZhng7fFsdpagG0yQ90K0P8YVC8X4Dm7qvsSFSSr71oGzPMwkQk91EokYn2L8oTng
	 WAKlcPaeM9VhVsm2MkcR327jJcUFFdHQ4A78nF/zZdZIq9AymIGD34uNB7jOdXjyUI
	 EKKxA4XoakO8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Souvik Banerjee <souvik@amlalabs.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ovl: use linked upper dentry in copy-up tmpfile
Date: Mon, 27 Jul 2026 11:41:17 -0400
Message-ID: <20260727154117.1516979-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072032-dyslexia-eradicate-638b@gregkh>
References: <2026072032-dyslexia-eradicate-638b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Souvik Banerjee <souvik@amlalabs.com>

[ Upstream commit e348eecd4d8fa8d18a5157ff59f7be1dc59c5928 ]

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
[ adapted scoped credential and creation helpers to explicit credential, locking, lookup, and cleanup handling ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/copy_up.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index dbf7b3cd70ca5e..7f4fdf3f2b09ec 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -793,7 +793,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 {
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct inode *udir = d_inode(c->destdir);
-	struct dentry *temp, *upper;
+	struct dentry *temp, *upper, *newdentry = NULL;
 	struct file *tmpfile;
 	struct ovl_cu_creds cc;
 	int err;
@@ -826,6 +826,14 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
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
 		dput(upper);
 	}
 	inode_unlock(udir);
@@ -841,7 +849,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 
 	if (!c->metacopy)
 		ovl_set_upperdata(d_inode(c->dentry));
-	ovl_inode_update(d_inode(c->dentry), dget(temp));
+	ovl_inode_update(d_inode(c->dentry), newdentry);
 
 out_fput:
 	fput(tmpfile);
-- 
2.53.0

