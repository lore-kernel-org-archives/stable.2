Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127FF134CF
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514957; cv=none; b=cb3sAOqUXsYVaAMV2vhITYonLmWfZ1soAppQJwNTSjU2wDzatsW+RCIxfuQoZRxDycZSSt3kWnEXY+cPsEc1kwzNuavEb0OszFDz6Aq9uoInK1Yu+yM7XuGZnDzA5UJorhnu+keaIeuiSWd4XKyYoADyhc1W8zs6JlxZWHr0+7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514957; c=relaxed/simple;
	bh=FR0n8Yvs3v7Gzj1m/oOePmjX/JxKhGAV+zOcxKMUzgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h65fHElKZtAOOIeHcm10FmIxvWlOQpbOSJDY13paRn4JlIj39kRChiugJ72ES2aiAQLBGf294C2k6RsGoeu2kT3/9CfeY8SroWANdCfep8k0JlYflckLpOMVMGUSJLcYZ6oDV+EBBjGxtfbUX7rAZmGDWKs/vNsTwwoW8ubEYdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBynfB4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBynfB4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BC91F000E9;
	Mon, 20 Jul 2026 02:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784514955;
	bh=Y6WMS2NT3APqPW6jhpY1FQBzHzVS9HK1YtsMPB61obQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gBynfB4iGTfNKlbhuMUal/lLisJbr6XkG+gj7F/lr4JBqh/l7qyo6rNQoAwMxUcXl
	 mHT+dwBIGk350oZVPy34aa/XsnQONeKorIinvnwOJwL7BXJX7tfNswHrRuN0o2Qqif
	 iXGjChwg0gl1AKkzsuszTn5fFzOikvjO8/CGmaoUBsAOty3F2Qnjxlh51BdeffoBdy
	 X+8y39NBScLy+E6qB/mu1xRGIsrWSVDtds+ERyhABSnMITt60CWdNV6U4EGYntZ0wF
	 AbYf+mFeOSW0JdTq/JgJpIcFsoMivQ3pv1OnDCssVCE/HjQ1mRAa2or1ZiDUjsZUkp
	 7Nwxc+gbCShuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/6] new helper: simple_remove_by_name()
Date: Sun, 19 Jul 2026 22:25:46 -0400
Message-ID: <20260720023553.2928009-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071455-cultural-frenzy-db69@gregkh>
References: <2026071455-cultural-frenzy-db69@gregkh>
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
Stable-dep-of: 3137b243c939 ("usb: gadget: f_fs: initialize reset_work at allocation time")
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

