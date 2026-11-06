Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938296;
	b=rkBlADfNqEQFmOpbeRS5ew9UMo7J5jtCPhCbK8kMIE3uaHVEJxw/VpresgLxUOdx1N64
	 XFDcRd77UsgYGdiUzqfnsxDm0pCZ79o9FsXTQ2cAF7ktGQZYO4jJyCXNZey9Tgl9C2Wwe
	 TUGg5v5ZFVXl9nROpnWqodGquSFiELNJ4Tz/wDuzghOenCQO3OqV0yVTU4qtDpNJTTCy7
	 E3QZ5TGlC/fettUhxOv1fXn4uSpt+HTqLafiKImBkz0mbwZyNhvPg7u9Uuqaabxr5oLvZ
	 Opgu2Y/hDHBLK+eEZ+JcHCJosOqz+FF9UeGV9YGCd90ACHm8e5x0tsYNGbiuczOV7sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WUIEHHvgJu6AKNx1OIs6XPQelm1ukBDQnSIMfYRhhQA=;
	b=XemlPSEFhUGFqrcPFmIOYNN2dk/39xy38bo3gE5t/XtosTupqClnY1HZqH17MduYg3bS
	 c0yYETlRhAF5hvwSAGfNAHLOJmObxTUNkNVFXwkD/IxwlnRWp3lpQDtBtSHf0jMQuzfkg
	 MVk7zGwSPzDt6/5v3ebca3I5+F+IAhlOZuvCB8P58I1Pa/NZa+NCSwFu/FKyo3KswFJcP
	 mDGI5bcIsp9VRE4rNQ0kGo1z1oEypmrDMI832waklUAcixu3j1pfsgpEzOeZgo6OkcaPy
	 IbhKUNHu+8pilNZkAJht3j7ONfSXXDJb8o1B6ZkIJPcF6QuGYJXq5vI41uf/eLuvB2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fwt8j2qO;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239FC606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 04:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 239FC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fwt8j2qO
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b56c428212so193045a12.2
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 20:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793938294; x=1794543094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WUIEHHvgJu6AKNx1OIs6XPQelm1ukBDQnSIMfYRhhQA=;
        b=Fwt8j2qO64PdpG/xjMNDuRQDbCXFYisp6XTHdM3ffEk542SKTrPBNsWypLM76mgWnR
         VKARqYK/Cce+t+hZzizrVh8nDHDMwEYcFhCKVD/2p58grUwjFnCfsooodu3TJB19bBGZ
         VGF/cOFnyCxB5blNvHVTFnkjfQ9vAivXXxvHi0weLv9dfkVuMB2Ph8nByVh+NegmyIR6
         n4zpwTKt1n5xBRQha3x0gWrDOyisjKFJ6yFBDOL3gokGf5xGvVA8PceFdRp1E417NqUz
         ubYaYKlnHNgaQ9grA0XFtv9euU0mC9LkfGfntpWlTRqyQAQVElslMbOh3yPNqnongWsP
         1DBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793938294; x=1794543094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WUIEHHvgJu6AKNx1OIs6XPQelm1ukBDQnSIMfYRhhQA=;
        b=DiVkeEw4Vk+P5fIO1chr8u0xCFOWp8vXQvGOOqQbezY0Q0KxZL1hcrTDh43tl985M9
         irHv40v+xAltEfQZDkQcoz0kZnENblAbOhHlHo7wZayxRxMcCrnbk5nsKTeJX91/Vf3c
         g0Ajkj3DbZh2VB9Z7TkO8EDmZr668s6kUy7bCsRTcfVFNaZcJhpAankjwb8FoOrM5IQj
         pbru/zk+0FpQ+5cHxDCd4yxrprKGNojHEbHn2SeTECTG1drzFWjc4DvuTVp/UYbc21p+
         0f8I51OVgsNFReAzcjaTWtpGJjjEh5UshZ6CPItrN1400jp3sHSnMmKLNjTDGQ96Y6oP
         ga+g==
X-Forwarded-Encrypted: i=1; AKwUvBzk4sLcYX/fdMpF5VV7WCpOq9TX63HJN62nA/oNEB1nOyHIKGOOUptjusSwPjiIv9EKwAJntpk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9R3o7WDdOzqz2WaBQiCh+Fp3ZVhd0hiS8KSJIvnPj28VarUUJW
	urO8lTqumGbLEvG/T6uhXGWyIV4w3HhxzTbXJKHmW3ITcVn1a6XkP4zK
X-Gm-Gg: AYBFou0K/xc0IVeV8oAlck3Rtj2h1mtIpbc2pDtJAS1By8/tkmVoTGO+iF5C8/VbA3x
	K7GO9QSYwhP33LjK5f1eKzv/ErXHi3F8+Bnxn0ygxXulu7o7giUhKOLX8GLN3kDtqAX1Cd29p87
	C0qHlSq6PIdjvHNcqIqEzgJqUOutqNRCyMDUSONN4WLhuwoj+Kkbkt+J7HWyY9E74fylWERwO+Q
	oFkY1Xr4VHvcAqA6eQ/LgzzwHLHvEZFNjsI8tLSkTzhItu7NvW9bv7dayRz9ilmx8UriZf4Az5p
	1hAK61pZk/3BIsv1MG5aXctaEeCwFM1Yu1M1XmwZpyRC+SyqSgtMKPf0Mj5GmDkJ27kCjsdLP2e
	syxkuAS/ZBCMrNVj6A+PHNlaUj5otO+7pSnqNmOIB7GQl1ZjNOjTc1Q2Z/DR6PO3R4iEdwgI1/5
	L1A6wZQwvo5m2d5y0sLrncBBci+ium07tcS1ROwcxVHfzC8WLzsaLFdL98XhL5VEGvvX6QxysUN
	8JUmuZrXRYECDe09QZwAbcL4HyU1ksbQxtEW/Kuo4kDSUZfxEjzoQcHAbXOzN1Q60EDoMNKgX6F
	16k2nuj8Yr1lvL3Vx+wRQj+4IFjZ/xYXJbPj+Tr3s5wMDymdQ+k4N6G+MXoJp+Kv9Cjpp1N4cE0
	GuskDK5o0wK72
X-Received: by 2002:a05:6402:5d4:b0:6af:dccb:acbe with SMTP id 4fb4d7f45d1cf-6b597524728mr870455a12.5.1793938294522;
        Thu, 05 Nov 2026 20:11:34 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664ae569dsm226068a12.16.2026.11.05.20.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:11:33 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 6.12 2/3] ovl: hold a reference on the parent in readdir
Date: Fri,  6 Nov 2026 05:11:24 +0100
Message-ID: <20261106041128.3797453-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106041128.3797453-1-amir73il@gmail.com>
References: <20261106041128.3797453-1-amir73il@gmail.com>
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

From: Chris Mason <mason@kernel.org>

commit 16d319e12328acafeafd3eecdf09c46d7fb43452 upstream.

Listing a directory on an overlay uses a freed dentry and crashes the
kernel when a lookup moves the directory at the same time.

Code that can sleep may only use d_parent without a reference while
something stops a move of the dentry. ovl_iterate_real(),
ovl_need_adjust_d_ino() and ovl_cache_update() use the d_parent of the
listed directory and hold only the lock of that directory. When a
lookup finds the directory under another parent after a change to a
layer, d_splice_alias() moves it without that lock and drops its
reference on the old parent.

With a delay in ovl_iterate_real(), getdents64 on an overlay directory
raced a rename in the lower layer and a lookup that moved its dentry,
and after an rmdir of the old parent KASAN reported a use-after-free in
security_inode_getattr().

Fix this by using dget_parent() in the three functions.

Fixes: b5efccbe0a12 ("ovl: constant d_ino across copy up")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: fix comments in ovl_need_adjust_d_ino()]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[backport: no ovl_need_adjust_d_ino(), take the parent with dget_parent()
 in ovl_iterate() and test a local flag]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/readdir.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -486,8 +486,8 @@ static int ovl_cache_update(const struct path *path, struct ovl_cache_entry *p,
 			goto get;
 		}
 		if (p->len == 2 && p->name[1] == '.') {
-			/* we shall not be moved */
-			this = dget(dir->d_parent);
+			/* d_splice_alias() can move even a locked dir */
+			this = dget_parent(dir);
 			goto get;
 		}
 	}
@@ -711,6 +711,7 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 	struct dentry *dir = file->f_path.dentry;
 	struct ovl_fs *ofs = OVL_FS(dir->d_sb);
 	const struct ovl_layer *lower_layer = ovl_layer_lower(dir);
+	struct dentry *parent;
 	struct ovl_readdir_translate rdt = {
 		.ctx.actor = ovl_fill_real,
 		.orig_ctx = ctx,
@@ -721,18 +722,26 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 	if (rdt.xinobits && lower_layer)
 		rdt.fsid = lower_layer->fsid;
 
-	if (OVL_TYPE_MERGE(ovl_path_type(dir->d_parent))) {
+	/*
+	 * The lock on dir does not stop d_splice_alias() from moving it to
+	 * another parent, which drops the reference dir holds on this one.
+	 */
+	parent = dget_parent(dir);
+	if (OVL_TYPE_MERGE(ovl_path_type(parent))) {
 		struct kstat stat;
 		struct path statpath = file->f_path;
 
-		statpath.dentry = dir->d_parent;
+		statpath.dentry = parent;
 		err = vfs_getattr(&statpath, &stat, STATX_INO, 0);
-		if (err)
+		if (err) {
+			dput(parent);
 			return err;
+		}
 
 		WARN_ON_ONCE(dir->d_sb->s_dev != stat.dev);
 		rdt.parent_ino = stat.ino;
 	}
+	dput(parent);
 
 	if (ovl_is_impure_dir(file)) {
 		rdt.cache = ovl_cache_get_impure(&file->f_path);
@@ -760,16 +769,19 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	if (!ctx->pos)
 		ovl_dir_reset(file);
 
 	if (od->is_real) {
+		struct dentry *parent = dget_parent(dentry);
+		bool parent_merge = OVL_TYPE_MERGE(ovl_path_type(parent));
+
+		dput(parent);
 		/*
 		 * If parent is merge, then need to adjust d_ino for '..', if
 		 * dir is impure then need to adjust d_ino for copied up
 		 * entries.
 		 */
 		if (ovl_xino_bits(ofs) ||
 		    (ovl_same_fs(ofs) &&
-		     (ovl_is_impure_dir(file) ||
-		      OVL_TYPE_MERGE(ovl_path_type(dentry->d_parent))))) {
+		     (ovl_is_impure_dir(file) || parent_merge))) {
 			err = ovl_iterate_real(file, ctx);
 		} else {
 			err = iterate_dir(od->realfile, ctx);
-- 
backport
