Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A713CCA12
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179384; cv=none; b=KX6Cls2z16c/g5ACTyi00FrDOG2HpF5+UtSvvmKKJ1a+rQHwm6DukVrZ8oNjwSdNTe6d2gMXBM2voXJ46xMx6S1tFPCPqffIbFnNQy6SM/4Aip4C4taViVRsA3ffhNjp8kV/SdNNa5zOWSbjAr3H2xH8MaPMciMzoCG70QvqEus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179384; c=relaxed/simple;
	bh=UTQVjs++AfPnw5vqJ6Jrv70x/rsLzA8gvZmQYYoQUPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l51ZkfCcHAFaGEiciHxguDZTqPft4AHsVNb7/RRw+yxceyA0PKCd+DI0lTAZZzMN4VPxmKDXMLYXfFkv5ChPd1TUzKosZgnVN/id3KVG+N5yF8fWh4ePQ+jg8dCqGz5q1APt1cPa3Og2GhR7ESxVK/aiFYKu1ZM3pVHB2cZpb1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsQzKyXi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsQzKyXi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2FA1F000E9;
	Mon, 27 Jul 2026 19:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785179382;
	bh=pkwreEwcqSx9IGhf2/THrz5/Sdl0vKUOoB34e847gnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LsQzKyXi+TcTOYrjSOrdYxy8xMwMKhlriYVkZzA/XfmCyre4tSudGy9WnEDPQLw2o
	 GyxpyrvemVZxDlUF2ZLNWu+rmIuuayC1wyQU3fzZr9DhDuVexZtsK66koldbwR3oOQ
	 mSaMO+OCKbxadAVcoblf2CNBZYdW/QCmUEm+qWt9w56WoYW+NLFq4jlBJK4Pba0JLN
	 tUgrtSCJRfo0JDxyXW3VcORErw++bHi9GWqto+DkLNPbXU6cmU9SQhFiYDKvoN30DC
	 4FT91mzIGCap4awSLnt3zwoaTp/NEVsc14EbP15/qqI5SQLWBap5pYcTeoAyxBeWKU
	 dGhUNY9opiHxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Souvik Banerjee <souvik@amlalabs.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ovl: use linked upper dentry in copy-up tmpfile
Date: Mon, 27 Jul 2026 15:09:37 -0400
Message-ID: <20260727190937.1618998-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072034-passage-ebay-b6c7@gregkh>
References: <2026072034-passage-ebay-b6c7@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/copy_up.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 5fc32483afed89..4c7ef60dbaac03 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -730,7 +730,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 {
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct inode *udir = d_inode(c->destdir);
-	struct dentry *temp, *upper;
+	struct dentry *temp, *upper, *newdentry = NULL;
 	struct ovl_cu_creds cc;
 	int err;
 
@@ -754,6 +754,14 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
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
@@ -763,9 +771,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 
 	if (!c->metacopy)
 		ovl_set_upperdata(d_inode(c->dentry));
-	ovl_inode_update(d_inode(c->dentry), temp);
-
-	return 0;
+	ovl_inode_update(d_inode(c->dentry), newdentry);
 
 out_dput:
 	dput(temp);
-- 
2.53.0

