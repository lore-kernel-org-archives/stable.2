Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9088D3EC682
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544896; cv=none; b=GReJOX+6eao0PxUd8sqWtkOjUfUHgiL+W9j9YQVnkXjpCIbqpyZfQ/HPEhKJUwR7xoOt1+gJ252w2cdWNjTO+tLjb6ckPbRyRzs/chaSRDH+QVmVs6R+B8lwXBNpZ7FFhT/eHDvgqi8clXvaUAEGrjcahGoZjfK5iXclzho6A+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544896; c=relaxed/simple;
	bh=fnHBUEJ7nxpJpGVD5rA3Z/nskW7hnicfn/X9ne1w9/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElCSRjdIC9lrNqVMLsV9GdLoeAJ0WfuOdTzXLbdkaEOgVA7PAsum8Pa/X+/xtuWTK3y6yjHrDcd6b/+TCagAsp3J93FU/cU8uPrgLUjRAhjGPTaH0rw19f/2nt8T/BfMj9QA6ZgQCWRSATwa9KUybxf6m54hwTuPZKvhQSpxzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvqHUcI+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvqHUcI+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C6C1F000E9;
	Mon, 20 Jul 2026 10:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784544895;
	bh=CrchYgl06DOZzOY7vDJPqUd2z0dRFYMXzW6dvjAnoc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HvqHUcI+RGH038bCIQf4NX4hRzq5jcAT3KpDLAg/iaLC0gNZIHTfH1wpB4Mw22OX+
	 apfnWouhw7Pomqj+J/z1H6Mbg5iy4jkc8OwBoUGvJZ11q0I2A/g/SSkTrBvdIrdsSL
	 OZpdKyW99HK2hecct7U7TabI1mUzPT3jylOGsAzHQaVMn5qs4wg+0t9EPfyglkZwUH
	 CdnvWvg+xAPuOzLxqPTIt9RnIgNp28d5nbVZd2qoHuzHQwVM7a4+auv12lBcgCOtkp
	 aXrG+rc1eOPigxkoKPe6T55JHGAOGoYzMWMF+/6cQgtlg/coU9v8wffYgr65wQQHVK
	 xWZX4goMB95zQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] new helper: simple_remove_by_name()
Date: Mon, 20 Jul 2026 06:54:46 -0400
Message-ID: <20260720105452.216179-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071425-shield-overhung-4ba9@gregkh>
References: <2026071425-shield-overhung-4ba9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 4051a9115ad24bb9a691774730ca9c1dd56de665 ]

simple_recursive_removal(), but instead of victim dentry it takes
parent + name.

Used to be open-coded in fs/fuse/control.c, but there's no need to expose
the guts of that thing there and there are other potential users, so
let's lift it into libfs...

Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: 8bdcf96eb135 ("usb: gadget: f_fs: Tie read_buffer lifetime to ffs_epfile")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/control.c  |  7 +------
 fs/libfs.c         | 13 +++++++++++++
 include/linux/fs.h |  2 ++
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index ce11f4b427c281..2e300f6d646c31 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -290,18 +290,13 @@ static void remove_one(struct dentry *dentry)
  */
 void fuse_ctl_remove_conn(struct fuse_conn *fc)
 {
-	struct dentry *dentry;
 	char name[32];
 
 	if (!fuse_control_sb || fc->no_control)
 		return;
 
 	sprintf(name, "%u", fc->dev);
-	dentry = lookup_noperm_positive_unlocked(&QSTR(name), fuse_control_sb->s_root);
-	if (!IS_ERR(dentry)) {
-		simple_recursive_removal(dentry, remove_one);
-		dput(dentry);	// paired with lookup_noperm_positive_unlocked()
-	}
+	simple_remove_by_name(fuse_control_sb->s_root, name, remove_one);
 }
 
 static int fuse_ctl_fill_super(struct super_block *sb, struct fs_context *fsc)
diff --git a/fs/libfs.c b/fs/libfs.c
index 96551deff8e501..52f00bfc8f7baa 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -647,6 +647,19 @@ void simple_recursive_removal(struct dentry *dentry,
 }
 EXPORT_SYMBOL(simple_recursive_removal);
 
+void simple_remove_by_name(struct dentry *parent, const char *name,
+                           void (*callback)(struct dentry *))
+{
+	struct dentry *dentry;
+
+	dentry = lookup_noperm_positive_unlocked(&QSTR(name), parent);
+	if (!IS_ERR(dentry)) {
+		simple_recursive_removal(dentry, callback);
+		dput(dentry);	// paired with lookup_noperm_positive_unlocked()
+	}
+}
+EXPORT_SYMBOL(simple_remove_by_name);
+
 /* caller holds parent directory with I_MUTEX_PARENT */
 void locked_recursive_removal(struct dentry *dentry,
                               void (*callback)(struct dentry *))
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 39269c7d167e6d..95986609923592 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3654,6 +3654,8 @@ extern int simple_rename(struct mnt_idmap *, struct inode *,
 			 unsigned int);
 extern void simple_recursive_removal(struct dentry *,
                               void (*callback)(struct dentry *));
+extern void simple_remove_by_name(struct dentry *, const char *,
+                              void (*callback)(struct dentry *));
 extern void locked_recursive_removal(struct dentry *,
                               void (*callback)(struct dentry *));
 extern int noop_fsync(struct file *, loff_t, loff_t, int);
-- 
2.53.0

