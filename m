Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7E43EC692
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544897; cv=none; b=XWqnllDWDqHFPqnH/lS6lojC3iR9llQZUxfPpSst0wGQnXU7lA8wQmBXrd7kuX+XGZibxqAxlkto6FR5VG3ktKKeQpG5iLiKk/sHfEC/v+e/4bIe63iCSv0+WloC6TgbPTpWd/lfoRywsWqbJoK0AKr4DscxI1bshPCACVI7ytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544897; c=relaxed/simple;
	bh=wnaTmItyaP2k0D1H1320nmDO9M2d2BdMrv9JYPAzwY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rT+J5irS+pkOGJ/cluKWF9WqAA4NOrOXq27mtwjFzyx5v/xMKEsJtb20jx/L7DLS8vviyN9N4JNdI6RJA7lm/Gw3fyNOB+exyjCeE29JLeXjIvUYC3ohD98dLzfmlPUdP+j0KazaZ7+0YJ5WT3JFC6opHRZkjKynV+WPig1qiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6lyMGR3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6lyMGR3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D251F00A3D;
	Mon, 20 Jul 2026 10:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784544896;
	bh=Ie4R2j+7B1T2nDcKhwa9nnxbyQxGkAGue85wc2BjyqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b6lyMGR3AdSUgNXqaFoMPsNfrT9yq9M3k9eQK6/5BoSOde+QqMdLh9GlVhzcwz6Dr
	 YD2Aq+BKjYCKIUle/7iEBzkUC0qqmNd/h2dEmaUfNpg3VrKrdkwgzBmPZyFNeFXLy5
	 WmBf3qA45OqNRdhCA3ob13OLMWbpl62kErBDOUV1EwrGhJofZSms8h2cjNnZPdl4zN
	 DKq3u1Pr48eLbFzWNwj+SrRHlTnKdSUYAHO7R9M97rNsOxisVpp5ZZ6pfHYvAUuytL
	 Iafqm5QsO9zp3hjuJXB2Z7kjgDXBJLDu7VgZ4+6zjdBKt/ft07SJdkWnR4SAGZWzDy
	 0v6xAR7hwYa1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] functionfs: switch to simple_remove_by_name()
Date: Mon, 20 Jul 2026 06:54:47 -0400
Message-ID: <20260720105452.216179-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720105452.216179-1-sashal@kernel.org>
References: <2026071425-shield-overhung-4ba9@gregkh>
 <20260720105452.216179-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit c7747fafaba0dcdad3d7da240e961927b4865f98 ]

No need to return dentry from ffs_sb_create_file() or keep it around
afterwards.

To avoid subtle issues with getting to ffs from epfiles in
ffs_epfiles_destroy(), pass the superblock as explicit argument.
Callers have it anyway.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: 8bdcf96eb135 ("usb: gadget: f_fs: Tie read_buffer lifetime to ffs_epfile")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 51 +++++++++++++-----------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 5ef9a7a7f3bc30..bd82db001c7250 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -162,8 +162,6 @@ struct ffs_epfile {
 	struct ffs_data			*ffs;
 	struct ffs_ep			*ep;	/* P: ffs->eps_lock */
 
-	struct dentry			*dentry;
-
 	/*
 	 * Buffer for holding data from partial reads which may happen since
 	 * we’re rounding user read requests to a multiple of a max packet size.
@@ -273,11 +271,11 @@ struct ffs_desc_helper {
 };
 
 static int  __must_check ffs_epfiles_create(struct ffs_data *ffs);
-static void ffs_epfiles_destroy(struct ffs_epfile *epfiles, unsigned count);
+static void ffs_epfiles_destroy(struct super_block *sb,
+				struct ffs_epfile *epfiles, unsigned count);
 
-static struct dentry *
-ffs_sb_create_file(struct super_block *sb, const char *name, void *data,
-		   const struct file_operations *fops);
+static int ffs_sb_create_file(struct super_block *sb, const char *name,
+			      void *data, const struct file_operations *fops);
 
 /* Devices management *******************************************************/
 
@@ -1881,9 +1879,8 @@ ffs_sb_make_inode(struct super_block *sb, void *data,
 }
 
 /* Create "regular" file */
-static struct dentry *ffs_sb_create_file(struct super_block *sb,
-					const char *name, void *data,
-					const struct file_operations *fops)
+static int ffs_sb_create_file(struct super_block *sb, const char *name,
+			      void *data, const struct file_operations *fops)
 {
 	struct ffs_data	*ffs = sb->s_fs_info;
 	struct dentry	*dentry;
@@ -1891,16 +1888,16 @@ static struct dentry *ffs_sb_create_file(struct super_block *sb,
 
 	dentry = d_alloc_name(sb->s_root, name);
 	if (!dentry)
-		return NULL;
+		return -ENOMEM;
 
 	inode = ffs_sb_make_inode(sb, data, fops, NULL, &ffs->file_perms);
 	if (!inode) {
 		dput(dentry);
-		return NULL;
+		return -ENOMEM;
 	}
 
 	d_add(dentry, inode);
-	return dentry;
+	return 0;
 }
 
 /* Super block */
@@ -1943,10 +1940,7 @@ static int ffs_sb_fill(struct super_block *sb, struct fs_context *fc)
 		return -ENOMEM;
 
 	/* EP0 file */
-	if (!ffs_sb_create_file(sb, "ep0", ffs, &ffs_ep0_operations))
-		return -ENOMEM;
-
-	return 0;
+	return ffs_sb_create_file(sb, "ep0", ffs, &ffs_ep0_operations);
 }
 
 enum {
@@ -2176,7 +2170,7 @@ static void ffs_data_closed(struct ffs_data *ffs)
 							flags);
 
 			if (epfiles)
-				ffs_epfiles_destroy(epfiles,
+				ffs_epfiles_destroy(ffs->sb, epfiles,
 						 ffs->eps_count);
 
 			if (ffs->setup_state == FFS_SETUP_PENDING)
@@ -2241,7 +2235,7 @@ static void ffs_data_clear(struct ffs_data *ffs)
 	 * copy of epfile will save us from use-after-free.
 	 */
 	if (epfiles) {
-		ffs_epfiles_destroy(epfiles, ffs->eps_count);
+		ffs_epfiles_destroy(ffs->sb, epfiles, ffs->eps_count);
 		ffs->epfiles = NULL;
 	}
 
@@ -2338,6 +2332,7 @@ static int ffs_epfiles_create(struct ffs_data *ffs)
 {
 	struct ffs_epfile *epfile, *epfiles;
 	unsigned i, count;
+	int err;
 
 	count = ffs->eps_count;
 	epfiles = kcalloc(count, sizeof(*epfiles), GFP_KERNEL);
@@ -2355,12 +2350,11 @@ static int ffs_epfiles_create(struct ffs_data *ffs)
 		else
 			sprintf(epfile->name, "ep%u", i);
 		epfile->in = (ffs->eps_addrmap[i] & USB_ENDPOINT_DIR_MASK) ? 1 : 0;
-		epfile->dentry = ffs_sb_create_file(ffs->sb, epfile->name,
-						 epfile,
-						 &ffs_epfile_operations);
-		if (!epfile->dentry) {
-			ffs_epfiles_destroy(epfiles, i - 1);
-			return -ENOMEM;
+		err = ffs_sb_create_file(ffs->sb, epfile->name,
+					 epfile, &ffs_epfile_operations);
+		if (err) {
+			ffs_epfiles_destroy(ffs->sb, epfiles, i - 1);
+			return err;
 		}
 	}
 
@@ -2368,16 +2362,15 @@ static int ffs_epfiles_create(struct ffs_data *ffs)
 	return 0;
 }
 
-static void ffs_epfiles_destroy(struct ffs_epfile *epfiles, unsigned count)
+static void ffs_epfiles_destroy(struct super_block *sb,
+				struct ffs_epfile *epfiles, unsigned count)
 {
 	struct ffs_epfile *epfile = epfiles;
+	struct dentry *root = sb->s_root;
 
 	for (; count; --count, ++epfile) {
 		BUG_ON(mutex_is_locked(&epfile->mutex));
-		if (epfile->dentry) {
-			simple_recursive_removal(epfile->dentry, NULL);
-			epfile->dentry = NULL;
-		}
+		simple_remove_by_name(root, epfile->name, NULL);
 	}
 
 	kfree(epfiles);
-- 
2.53.0

