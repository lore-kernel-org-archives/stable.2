Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596636;
	b=SuuahkoGmqXaqaRdrIkAHmmp061x0y77PLOZv6bQXvsnyYLP8mImQvtP5BOK7FlMKt1Y
	 lhcel4aa2NndgX+MSjpFFuTmHJ7BmGhm9MfJjXsD26PtX3W/QxYP/vrRUJR7pDUezMUpR
	 CXZ5tmpWZXjmw5pgWebipgQ86sAtFxH0QNGNYy7IOrtOb2jLkJWTHWqkmFevFsHp3UzZX
	 p6bl7ks78rRl1hT6/ezbM0VFkEpS1HwKaZkRbhFn+VYnnQCxgaMLmYw+Vc0AjhjEwyN2y
	 RmFDVctdIvbMzbxnPrHpGYyNK5KremkjC0mDBA1UV1VPEgdmZ4dxd41cql3h1fq6dGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596636;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4bLFbiTWAFbC+CnsXiWscrEeefK8YxYRUFBB/L3ErN0=;
	b=oFYKrqNx1pWh9tayITX/UoIbBrwEYGuJ8BvvQBIrYc62zGMPxI6UuxIwGksQFkQLix68
	 7RxxMKkg3uUraRtWD3zqi9pfLxzmlewpKKpprjSKCf9W5TBAGMTSz0RpDtnsZ7138fLZj
	 8peFdCMgYvKqdsIGs2hdlKxJ8YAGRqd2XE6KXWLLdES+0PCtIXgWYpskjovV2ZvzF/t0E
	 KoZDINRMmiItbBWmEsdFnMIShzeN7RrauE63qA3v86Yh/FQIzNI0fl8KTd2FWY6TQhliz
	 wYC9mykhIOmXDxl2hOMl9oMnJLZaUzHjjeamDDKI7vZizytwXV7daZjjWvDMS8LPlxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cKTG/zAH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2958606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cKTG/zAH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB7E1F000C3;
	Wed, 21 Oct 2026 15:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792596635;
	bh=4bLFbiTWAFbC+CnsXiWscrEeefK8YxYRUFBB/L3ErN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cKTG/zAHe+51iV/s5zQxxvIl6TcvdwkpH55r9lgMfZpu6Q2IF6Y+F4jA7A727zuu3
	 AgLFxrZ0sD3eMxwO50o35NduARbt83EYNuaDWeAAlFqu37VovNPfY9B5LQa+5nn1EP
	 nGkaBud9QvYvGh7HmISNom1KgZaVdV7InLsLcNv41vfyGBgLktv3HIxou95poMnr4+
	 bGZdi146GnQoBOg23WW/PcbGuHAALDhOgZ/WfD3N9Pn5NB0+0kOXx2rv7vxRbJLM7+
	 ckImX5z0pan8kDzMm0gzA6ssiKlU5udaW56XI0zYMkuQz3SGxVL6EgrtZVGed/e2/B
	 RwVlVYVhahFvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: YangWen <anmuxixixi@gmail.com>,
	syzbot+d77c546c60db651a389c@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] ntfs3: fix use-after-free of sbi->options in cmp_fnames
Date: Wed, 21 Oct 2026 11:30:30 -0400
Message-ID: <20261021152930.293677-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102157-deuce-giblet-3fc8@gregkh>
References: <2026102157-deuce-giblet-3fc8@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: YangWen <anmuxixixi@gmail.com>

[ Upstream commit 02f312754c873efe076888a2fdca982e56617929 ]

The root cause is that sbi->options points directly to fc->fs_private.
If fc->fs_private is freed while sbi still exists, sbi->options becomes
a dangling pointer.

This patch ensures that sbi->options is a separate copy of fc->fs_private
and duplicates nls_name if present. On superblock release or error,
sbi->options->nls_name and sbi->options are freed and sbi->options
is set to NULL to avoid any dangling pointer.

Reported-by: syzbot+d77c546c60db651a389c@syzkaller.appspotmail.com
Signed-off-by: YangWen <anmuxixixi@gmail.com>
[almaz.alexandrovich@paragon-software.com: remove syzbot logs from description]
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Stable-dep-of: c01b091b0641 ("ntfs3: free the sbi after a grace period")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/super.c | 47 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 346c52f952076..ec4bdaae14114 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -703,6 +703,14 @@ static void ntfs_put_super(struct super_block *sb)
 
 	/* Mark rw ntfs as clear, if possible. */
 	ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);
+
+	if (sbi->options) {
+		unload_nls(sbi->options->nls);
+		kfree(sbi->options->nls);
+		kfree(sbi->options);
+		sbi->options = NULL;
+	}
+
 	ntfs3_put_sbi(sbi);
 }
 
@@ -1221,7 +1229,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	int err;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	struct block_device *bdev = sb->s_bdev;
-	struct ntfs_mount_options *options;
+	struct ntfs_mount_options *fc_opts;
+	struct ntfs_mount_options *options = NULL;
 	struct inode *inode;
 	struct ntfs_inode *ni;
 	size_t i, tt, bad_len, bad_frags;
@@ -1238,20 +1247,35 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	ref.high = 0;
 
 	sbi->sb = sb;
-	sbi->options = options = fc->fs_private;
-	fc->fs_private = NULL;
+	fc_opts = fc->fs_private;
+	if (!fc_opts) {
+		errorf(fc, "missing mount options");
+		return -EINVAL;
+	}
+	options = kmemdup(fc_opts, sizeof(*fc_opts), GFP_KERNEL);
+	if (!options)
+		return -ENOMEM;
+
+	if (fc_opts->nls_name) {
+		options->nls_name = kstrdup(fc_opts->nls_name, GFP_KERNEL);
+		if (!options->nls_name) {
+			kfree(options);
+			return -ENOMEM;
+		}
+	}
+	sbi->options = options;
 	sb->s_flags |= SB_NODIRATIME;
 	sb->s_magic = 0x7366746e; // "ntfs"
 	sb->s_op = &ntfs_sops;
 	sb->s_export_op = &ntfs_export_ops;
 	sb->s_time_gran = NTFS_TIME_GRAN; // 100 nsec
 	sb->s_xattr = ntfs_xattr_handlers;
-	set_default_d_op(sb, options->nocase ? &ntfs_dentry_ops : NULL);
+	set_default_d_op(sb, sbi->options->nocase ? &ntfs_dentry_ops : NULL);
 
-	options->nls = ntfs_load_nls(options->nls_name);
-	if (IS_ERR(options->nls)) {
-		options->nls = NULL;
-		errorf(fc, "Cannot load nls %s", options->nls_name);
+	sbi->options->nls = ntfs_load_nls(sbi->options->nls_name);
+	if (IS_ERR(sbi->options->nls)) {
+		sbi->options->nls = NULL;
+		errorf(fc, "Cannot load nls %s", fc_opts->nls_name);
 		err = -EINVAL;
 		goto out;
 	}
@@ -1668,6 +1692,13 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 put_inode_out:
 	iput(inode);
 out:
+	if (sbi && sbi->options) {
+		unload_nls(sbi->options->nls);
+		kfree(sbi->options->nls);
+		kfree(sbi->options);
+		sbi->options = NULL;
+	}
+
 	ntfs3_put_sbi(sbi);
 	kfree(boot2);
 	return err;
-- 
2.53.0

