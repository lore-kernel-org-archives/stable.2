Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321094;
	b=RWgffBkQGm3KcMVFer9CGV0FE/tzCdF2t8depdsqmJrokfxX+lHhxSeMhZAhgWd5mAyg
	 GJFX2mFyEmnTYXvgfzStzTIZtNgkJKdZG2KA1bS8LOqBhBWBerx9zeVhmaHF71mbgSx1M
	 /OEn3Q4aOT13I7x139oKqBJBj6V/xPjFHqdhU02vofwmjFNGomo4qqb48q9d2e6GtBdap
	 JlTdkBVKjLUcSCq7BgQzeL63Qzq7xZ6pnsTjMFlID325M3SnYffCa3giGxkjJBnTGgOIb
	 vv+qkzf2KIpnbXTVTDeJN+ZacZtA5xk9FGc6wnmiKho1zMhoBqKS3UYHVmn32nCCPrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321094;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IZj9hO0atgmY+Pew+owQr5FkJxvGPz9iPbpp0g61+p8=;
	b=UllQWksgYuEe7mv3wws4Xl0Rdoue8pHxHMqvFEFECMW6tu7+8U4N3gPzq2RrNhjDFBAd
	 G8W7zwXKfR5gXUMODivLKf/861Y4TkWZY8D4pZLoMIpiraUeRtNMCU8nVPLctjxfx9Zo5
	 Se/kwqxgPMvJTbiJ2t/UDP9ICbryCknkJciNyaZhRf/xle13OATBjccM7WgyfbMX0V+VT
	 o8SGjI2LIqr0ZU33hap+YkU0f1tjGt7t+s5C9hjPFx1yxyuJAgRNC8SAAooFuL+lvpugI
	 Rkk+m+CT5FrmhkJCqOZ4Dl2rj61e7uojN84r7bC2jIMTZ9zSkwGXaGyeQoJWh7LkpJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oK03H5xP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D470606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oK03H5xP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072B71F008AB;
	Tue, 10 Nov 2026 14:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321093;
	bh=IZj9hO0atgmY+Pew+owQr5FkJxvGPz9iPbpp0g61+p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oK03H5xPK4EoZrCZG/DXijPF3JUBtJj7H/OOI0Iz3JClYoJhh2DeEdM2m1H+Xkuj2
	 WeBjdk+NjCr2JubCQt+FpUvBs++Yunx3Hw+ijTbrBJpLbCd+zZ58BDTfQos1w2ukPc
	 Nm8p3yg+k9uvWhPWgTo9AJ+P4aNhm+OeWd4xS+ff6+2EnCt6xqHwAgGzCF7TJjTwHU
	 h6latD3ymDxWWBXCxLTWnAlwHK29PIVx/YGhk/1iLN85LmXfRgvuFvweYccyn/TZTV
	 1Ib8MYXoOoIPtXrbAI4OAZwZprzc3gteHnPrIPHwL6ctDclZgbV9vMGJfoTKz3v0En
	 wYPXX04XgYISw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	Eric Biggers <ebiggers@google.com>,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] ext4: Move CONFIG_UNICODE defguards into the code flow
Date: Tue, 10 Nov 2026 09:31:30 -0500
Message-ID: <20261110143124.1907093-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054551-failed-6.1-19e16597f9ba@kernel.org>
References: <20261107054551-failed-6.1-19e16597f9ba@kernel.org>
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

From: Gabriel Krisman Bertazi <krisman@collabora.com>

[ Upstream commit d98c822232f8642960a69caedeb7909471127939 ]

Instead of a bunch of ifdefs, make the unicode built checks part of the
code flow where possible, as requested by Torvalds.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
[eugen.hristev@collabora.com: port to 6.10-rc1]
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
Link: https://lore.kernel.org/r/20240606073353.47130-7-eugen.hristev@collabora.com
Reviewed-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 19e16597f9ba ("ext4: fix ABBA deadlock in ext4_rmdir()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/crypto.c | 10 ++--------
 fs/ext4/ext4.h   | 33 +++++++++++++++++++++------------
 fs/ext4/namei.c  | 14 +++++---------
 fs/ext4/super.c  |  4 +---
 4 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index 8497f6125a8eb..c52971f62e525 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -31,11 +31,10 @@ int ext4_fname_setup_filename(struct inode *dir, const struct qstr *iname,
 
 	ext4_fname_from_fscrypt_name(fname, &name);
 
-#if IS_ENABLED(CONFIG_UNICODE)
 	err = ext4_fname_setup_ci_filename(dir, iname, fname);
 	if (err)
 		ext4_fname_free_filename(fname);
-#endif
+
 	return err;
 }
 
@@ -51,11 +50,9 @@ int ext4_fname_prepare_lookup(struct inode *dir, struct dentry *dentry,
 
 	ext4_fname_from_fscrypt_name(fname, &name);
 
-#if IS_ENABLED(CONFIG_UNICODE)
 	err = ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
 	if (err)
 		ext4_fname_free_filename(fname);
-#endif
 	return err;
 }
 
@@ -70,10 +67,7 @@ void ext4_fname_free_filename(struct ext4_filename *fname)
 	fname->usr_fname = NULL;
 	fname->disk_name.name = NULL;
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	kfree(fname->cf_name.name);
-	fname->cf_name.name = NULL;
-#endif
+	ext4_fname_free_ci_filename(fname);
 }
 
 static bool uuid_is_zero(__u8 u[16])
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0d4cb3cedf607..25750b97bbae2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2776,8 +2776,25 @@ ext4_fsblk_t ext4_inode_to_goal_block(struct inode *);
 
 #if IS_ENABLED(CONFIG_UNICODE)
 extern int ext4_fname_setup_ci_filename(struct inode *dir,
-					 const struct qstr *iname,
-					 struct ext4_filename *fname);
+					const struct qstr *iname,
+					struct ext4_filename *fname);
+
+static inline void ext4_fname_free_ci_filename(struct ext4_filename *fname)
+{
+	kfree(fname->cf_name.name);
+	fname->cf_name.name = NULL;
+}
+#else
+static inline int ext4_fname_setup_ci_filename(struct inode *dir,
+					       const struct qstr *iname,
+					       struct ext4_filename *fname)
+{
+	return 0;
+}
+
+static inline void ext4_fname_free_ci_filename(struct ext4_filename *fname)
+{
+}
 #endif
 
 /* ext4 encryption related stuff goes here crypto.c */
@@ -2800,16 +2817,11 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
 					    int lookup,
 					    struct ext4_filename *fname)
 {
-	int err = 0;
 	fname->usr_fname = iname;
 	fname->disk_name.name = (unsigned char *) iname->name;
 	fname->disk_name.len = iname->len;
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	err = ext4_fname_setup_ci_filename(dir, iname, fname);
-#endif
-
-	return err;
+	return ext4_fname_setup_ci_filename(dir, iname, fname);
 }
 
 static inline int ext4_fname_prepare_lookup(struct inode *dir,
@@ -2821,10 +2833,7 @@ static inline int ext4_fname_prepare_lookup(struct inode *dir,
 
 static inline void ext4_fname_free_filename(struct ext4_filename *fname)
 {
-#if IS_ENABLED(CONFIG_UNICODE)
-	kfree(fname->cf_name.name);
-	fname->cf_name.name = NULL;
-#endif
+	ext4_fname_free_ci_filename(fname);
 }
 
 static inline int ext4_ioctl_get_encryption_pwsalt(struct file *filp,
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 772dce1355e34..e38770a7ce444 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1875,8 +1875,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 		}
 	}
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (!inode && IS_CASEFOLDED(dir)) {
+	if (IS_ENABLED(CONFIG_UNICODE) && !inode && IS_CASEFOLDED(dir)) {
 		/* Eventually we want to call d_add_ci(dentry, NULL)
 		 * for negative dentries in the encoding case as
 		 * well.  For now, prevent the negative dentry
@@ -1884,7 +1883,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 		 */
 		return NULL;
 	}
-#endif
+
 	return d_splice_alias(inode, dentry);
 }
 
@@ -3259,16 +3258,14 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	ext4_fc_track_unlink(handle, dentry);
 	retval = ext4_mark_inode_dirty(handle, dir);
 
-#if IS_ENABLED(CONFIG_UNICODE)
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
 	 * invalidating the dentries here, alongside with returning the
 	 * negative dentries at ext4_lookup(), when it is better
 	 * supported by the VFS for the CI case.
 	 */
-	if (IS_CASEFOLDED(dir))
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
-#endif
 
 end_rmdir:
 	brelse(bh);
@@ -3370,16 +3367,15 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 		goto out_trace;
 
 	retval = __ext4_unlink(dir, &dentry->d_name, d_inode(dentry), dentry);
-#if IS_ENABLED(CONFIG_UNICODE)
+
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
 	 * invalidating the dentries here, alongside with returning the
 	 * negative dentries at ext4_lookup(), when it is  better
 	 * supported by the VFS for the CI case.
 	 */
-	if (IS_CASEFOLDED(dir))
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
-#endif
 
 out_trace:
 	trace_ext4_unlink_exit(dentry, retval);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index fa6d9260030aa..9be9c264a6977 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3601,14 +3601,12 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
 		return 0;
 	}
 
-#if !IS_ENABLED(CONFIG_UNICODE)
-	if (ext4_has_feature_casefold(sb)) {
+	if (!IS_ENABLED(CONFIG_UNICODE) && ext4_has_feature_casefold(sb)) {
 		ext4_msg(sb, KERN_ERR,
 			 "Filesystem with casefold feature cannot be "
 			 "mounted without CONFIG_UNICODE");
 		return 0;
 	}
-#endif
 
 	if (readonly)
 		return 1;
-- 
2.53.0

