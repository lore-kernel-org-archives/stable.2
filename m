Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045972;
	b=hNDvwb5HeiLdCcfXJ2AGmCmxUBuNjDTbd56z9wre5t7QY294vDQU1EiBSX0WJMJCUtus
	 aZXtOKTKSu0it61Q08qv1aHvyRh0pABaVe8V1ZnizO7YzGYYJfmTjKzHCqb8Dso6YpaEC
	 6an7dc9ms7vmjm6msGdHUNfaTGIEcm2ecmRPV2b/yNVDnHtdFYHAlxO1hyaFUCZfAjtt+
	 tvfSh39kQVG7eYOoHiaNDq0CbX+CQliVb6OsaM1uGrycQbaAfyw+J1VY3DN7j/eVhnGQo
	 KWwdskOoYvjtnN3fcPAiPh2pOCkocJ4Wdaj/QMJA0jWRkMP+GTYn/zUmac55xDdldRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045972;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uWokcYWNePnhRU8EsbrANlY08838ph7axx1Q+G1UKgY=;
	b=ZWz1mioQtZyFp8iZUM4+lYO3kyQHjSP7kRAy7cWXx1iyClkLlzkk0V2x1JJUEYFpPij8
	 EtNl/hDh1CMJJan1M3VDBYwXYsunITAkYNW2WAcPvdFap/TmP1Jb0iEHMwaVhvdbcvISz
	 lijeUVO/zqKDAQmUqBEMy6GLZomog8JVYvzOzLorN8LNFUYepFYFsMFhR8PsR4qGxosbP
	 As3+NoSS7Lj2RYi4lsRS5LgcO81aIp93PlbaKYQ8xK2XlEBfpn6NPdEiXNyH2dB3D3o4A
	 NC3A7rEwjuhefAQ62TXUhg1PcRGYLTh74X1F6fnyt+qpZanpUQvZXEgbULdh9CAuGKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="e5qpQc/3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB07606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e5qpQc/3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C747E1F0089F;
	Sat,  7 Nov 2026 10:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045972;
	bh=uWokcYWNePnhRU8EsbrANlY08838ph7axx1Q+G1UKgY=;
	h=From:To:Cc:Subject:Date;
	b=e5qpQc/3J5H2hp/1n2vpNG24H0r+8rVumL+qxIaKQ032KIV7LK2tqgZjaH+cteXff
	 Z8tSmQWT/xxvNzU4HG9K4nXBhvJrA193T7TwKI2ET5TIwFKfGddPoNOj9t4VV00FUv
	 DI9ggfLYe/dFTgj4Yw9GVPn5XFtyHIJFqb6hEDB9QestBPkOQqMGLRGBxJSrl/P2ko
	 mQnpBF61NeHcmjP9lXDAKPnkY/bwatT33Hn0ab1LYt2ER7iUhnauhSn028fbC6dIre
	 syqrLiDii9mJAoDnmI3wMHYA7iZ+BhatfaoDigEkID1BSsAMQjTtd/F5ZPaKxDL9yC
	 i42hvZhxlQdXA==
From: Sasha Levin <sashal@kernel.org>
To: sandeen@redhat.com,
	simonlie@amazon.de,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] devtmpfs: restore mount option reconfiguration on get_tree" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:06:10 -0500
Message-ID: <20261107050610-failed-6.18-1c7df6fa838a@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1c7df6fa838a46f0d5090ef134f67511f0592f33
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050610-failed-6.18-1c7df6fa838a@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1c7df6fa838a46f0d5090ef134f67511f0592f33 Mon Sep 17 00:00:00 2001
From: Eric Sandeen <sandeen@redhat.com>
Date: Wed, 12 Aug 2026 16:44:38 -0500
Subject: [PATCH] devtmpfs: restore mount option reconfiguration on get_tree

commit cb0e0a8bf4e1 ("devtmpfs: replace ->mount with ->get_tree in
public instance") converted the public devtmpfs instance to the new
mount API but broke the ability to reconfigure the shared superblock
options via subsequent mount() calls, as had been fixed once in
a6097180d884 ("devtmpfs regression fix: reconfigure on each mount")

This makes boot-time defaults permanent.

Fix this using an approach suggested by Al Viro: at init_fs_context
time, create a reconfigure-mode context via fs_context_for_reconfigure()
and save it in fc->fs_private. The devtmpfs parse ops can then use
this context to parse options appropriately for the underlying filesystem.

This also removes the devtmpfs_configure_context() one-time ops-copying
approach and the global mutable ops table it required.

Fixes: cb0e0a8bf4e1 ("devtmpfs: replace ->mount with ->get_tree in public instance")
Reported-by: Simon Liebold <simonlie@amazon.de>
Cc: stable@vger.kernel.org
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Link: https://patch.msgid.link/b1bd3b15-78ea-4487-b6a8-aad0b05dd3bb@redhat.com
Tested-by: Simon Liebold <simonlie@amazon.de>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/base/devtmpfs.c | 108 ++++++++++++++++++++++++----------------
 1 file changed, 64 insertions(+), 44 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index aef0fcc6aba1e..11c70888f38be 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -72,39 +72,90 @@ static struct file_system_type internal_fs_type = {
 	.kill_sb = kill_anon_super,
 };
 
-/* Simply take a ref on the existing mount */
+struct devtmpfs_context {
+	struct fs_context *fc;
+};
+
+static void devtmpfs_free(struct fs_context *fc)
+{
+	struct devtmpfs_context *ctx = fc->fs_private;
+
+	if (ctx) {
+		put_fs_context(ctx->fc);
+		kfree(ctx);
+	}
+}
+
+static int devtmpfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct devtmpfs_context *ctx = fc->fs_private;
+
+	return ctx->fc->ops->parse_param(ctx->fc, param);
+}
+
+static int devtmpfs_parse_monolithic(struct fs_context *fc, void *data)
+{
+	struct devtmpfs_context *ctx = fc->fs_private;
+
+	if (ctx->fc->ops->parse_monolithic)
+		return ctx->fc->ops->parse_monolithic(ctx->fc, data);
+	return generic_parse_monolithic(ctx->fc, data);
+}
+
 static int devtmpfs_get_tree(struct fs_context *fc)
 {
+	struct devtmpfs_context *ctx = fc->fs_private;
 	struct super_block *sb = mnt->mnt_sb;
+	int err;
 
 	atomic_inc(&sb->s_active);
 	down_write(&sb->s_umount);
+
+	if (ctx->fc->ops->reconfigure) {
+		err = ctx->fc->ops->reconfigure(ctx->fc);
+		if (err) {
+			deactivate_locked_super(sb);
+			return err;
+		}
+	}
+
 	fc->root = dget(sb->s_root);
 	return 0;
 }
 
-/* Ops are filled in during init depending on underlying shmem or ramfs type */
-static struct fs_context_operations devtmpfs_context_ops = {};
+static const struct fs_context_operations devtmpfs_context_ops = {
+	.free		  = devtmpfs_free,
+	.parse_param	  = devtmpfs_parse_param,
+	.parse_monolithic = devtmpfs_parse_monolithic,
+	.get_tree	  = devtmpfs_get_tree,
+};
 
-/* Call the underlying initialization and set to our ops */
 static int devtmpfs_init_fs_context(struct fs_context *fc)
 {
-	int ret;
-#ifdef CONFIG_TMPFS
-	ret = shmem_init_fs_context(fc);
-#else
-	ret = ramfs_init_fs_context(fc);
-#endif
-	if (ret < 0)
-		return ret;
+	struct devtmpfs_context *ctx;
+	int err;
+
+	ctx = kzalloc_obj(struct devtmpfs_context);
+	if (!ctx)
+		return -ENOMEM;
+
+	/* Each mount will reconfigure the shared superblock w/ new options */
+	ctx->fc = fs_context_for_reconfigure(mnt->mnt_root,
+					     mnt->mnt_sb->s_flags, MS_RMT_MASK);
+	if (IS_ERR(ctx->fc)) {
+		err = PTR_ERR(ctx->fc);
+		kfree(ctx);
+		return err;
+	}
 
+	fc->fs_private = ctx;
 	fc->ops = &devtmpfs_context_ops;
 
 	return 0;
 }
 
 static struct file_system_type dev_fs_type = {
-	.name = "devtmpfs",
+	.name		 = "devtmpfs",
 	.init_fs_context = devtmpfs_init_fs_context,
 };
 
@@ -442,31 +493,6 @@ static int __ref devtmpfsd(void *p)
 	return 0;
 }
 
-/*
- * Get the underlying (shmem/ramfs) context ops to build ours
- */
-static int devtmpfs_configure_context(void)
-{
-	struct fs_context *fc;
-
-	fc = fs_context_for_reconfigure(mnt->mnt_root, mnt->mnt_sb->s_flags,
-					MS_RMT_MASK);
-	if (IS_ERR(fc))
-		return PTR_ERR(fc);
-
-	/* Set up devtmpfs_context_ops based on underlying type */
-	devtmpfs_context_ops.free	      = fc->ops->free;
-	devtmpfs_context_ops.dup	      = fc->ops->dup;
-	devtmpfs_context_ops.parse_param      = fc->ops->parse_param;
-	devtmpfs_context_ops.parse_monolithic = fc->ops->parse_monolithic;
-	devtmpfs_context_ops.get_tree	      = &devtmpfs_get_tree;
-	devtmpfs_context_ops.reconfigure      = fc->ops->reconfigure;
-
-	put_fs_context(fc);
-
-	return 0;
-}
-
 /*
  * Create devtmpfs instance, driver-core devices will add their device
  * nodes here.
@@ -482,12 +508,6 @@ int __init devtmpfs_init(void)
 		return PTR_ERR(mnt);
 	}
 
-	err = devtmpfs_configure_context();
-	if (err) {
-		pr_err("unable to configure devtmpfs type %d\n", err);
-		return err;
-	}
-
 	err = register_filesystem(&dev_fs_type);
 	if (err) {
 		pr_err("unable to register devtmpfs type %d\n", err);
-- 
2.53.0




