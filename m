Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817924;
	b=41ELVCUlvjS2EDHSbhLT8cSmEgBqRGhmCEo9QHKtj1OukpQncSA/zvrg/VxnFzDhdlEy
	 4Nco2OpRL2+1fpnxbtqcjB9ouxV1KBWJkYqec0whe2GFOSmAlJYow2mcsx4qQKHvQmczE
	 xmpMeuTfa6/Nt1YgNa/AbC0K3aLuT3bHkjEK7511Tp0LfaAephii1JublqBeRPPkevwLy
	 A2LUm2nrO/LBR4lmzGhk0YIppvloDU7OtGcyo0u6qbtfkTtcpf28sB3wBkjj+BcdFJwVO
	 NRk0IgsAe1wRKeZwo6I4e5seITcJnHB5Jn2TANYz42RkeSMkOby81PiXdYU8emzTtdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wxCuP/mVVd3/tUFeKBS42VApE63zISWYoolf3I3TANY=;
	b=ipenFOAD4yzT4mrdcS6yD4wCIURdHlCQvk3SLrc2LiqtlFW4Gy4pLiUHv+UHyglgK8Ep
	 MclWGvBzswG5J4Jgc+3hkpIOJJLBqEYfLNmWhbAFOyOTF6MhDrM6hPag48DpHbIOXQ7X5
	 QAhIoMf0VBFTIjblvkpiPmCzuSlTb41/QOS9sKC/Cdbu1AjC5fjdjr67MJW4iNf+qkFJ5
	 jprrTKcP6152GvB239bRoMlu1VjtxNJ2cTEBXFgEA/XyMIozSZpCIXLZ5Y3cFfhQQ6c2r
	 1tBHhp+8USV9I/OSUixlhRhmpi/O47Na4bcphNC/BrSe4o3XxEsqTwKIkluEa713bDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="m/1zcr2I";
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB42E606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB42E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m/1zcr2I
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so9520795e9.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817922; x=1794422722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wxCuP/mVVd3/tUFeKBS42VApE63zISWYoolf3I3TANY=;
        b=m/1zcr2IWs467uG8vqx5CkIonSgiCX9rqWz14Hokoikyly0/X5UtzpVipUGD6QaMzS
         hPtP5v6PNW5WL5rqiK8GhRBZxBnILTY0NzqiAQKv1CWbJ8CBlhxzfjS/3g1u2h3nPdtb
         dqtrn0EYDet1bBEpTv/sP2bFHGcrD4mC8ZARBJbRaGKwJudeolbhzUoe98cznPBb2LRn
         dax7Ipof/m0FEViRZsdMKWFs4XocXbmfhPp97BYMnlTkxk7iRkTnnp+VznG+6axFmNRO
         c+OyB/RHjukcTkqer957GlOzjbufzSaj/53QOqMdJF25wm9BIYMBV/Axp84xPryoJDEI
         lhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817922; x=1794422722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wxCuP/mVVd3/tUFeKBS42VApE63zISWYoolf3I3TANY=;
        b=aH6RFA1V/ojg1hXED7WIx2nayGmh/wuOV823XiUGPfNQqlfGRrYInd1OR2SBtUpX81
         ja7ZGkCqy7R3V/O3peFlvvomA9ZVMs3713lciuxmBNNbSkpRNW5gvV82fG/zY1QLUsmH
         3Sbs1I4yVq5uTrSszTLHhfH8XD8dLBGeabve3MJJCZRY35emptz9J2PDKBk8oORq3tbk
         09JhcRxpwWjFc20Mkn783KMkwf8khFyXRZX1x159kFac+1GiHlzqRNdqtcI0gI7qFtDu
         RtHDBzapEZvR38SIdsnfSi5rqfMQpNjfRsei1vWJhQMsHlxxxu1GhKtTfnIyy2Qf8GCJ
         Kzsw==
X-Forwarded-Encrypted: i=1; AKwUvByGx1Ka+1Z4e46+GvDjppIyKT7JfYsUVS2gL9V6qh2/eoVVd6lJ942gFpoLlwZTR86AoQ/mblY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8JVqGPjEoNIe9yfdkoPy2BmhIIf90eX5t2gvweLsBZfNf32w8t
	0i3wm1seCyydh16iqtr74pI3y8y1mv0CZhZ7Srr4TmQMH/CmaIMcNThs
X-Gm-Gg: AYBFou3p02jR/l+zvSQ0ypM8QHgRsR09jNi/wfOltRYuwt3geXaoJOGFiKw12IeEeMU
	QciEuYVQTbBLhEotSt3va39C3kebeBvH9RodzKr96gWkADH8T4K1GiYrR3heTWcBrun9aNcU6Rd
	Grmp8ShwwP94jLXmzrq2j53HRLOlsi7aHjW3lI5zchKZg+kAE5n4KdN+Vhxiwzc82lcFeEtW1s7
	NZDNCMKQ8o7wEldQsHzfwBdWWhi7ga4Amq65aOq4Yvr+T4I0XYR+kwgIgkahETlQrpMLC9nIn1A
	mBwyvaZ/b2x5g9pBCE85/NRK1tLfSg5NPij9pXIWpnm1HrBzJSr3DgKCGumhnnZyKJ8ZSL4mHmy
	ZH/5+Myr/Fwj6hnFDLT58/3XBJ1VcVdcXWgbF9VeCyJCQCIHeW74M8Zp6ujzv6f+dOSxDRU86h1
	UySLakqrcbRp1HtbMYc9sD9364hA91VRERS9CD9hOEwix0fUjf2y58WjZ5F9uBHLhgYEx4isumk
	rFXa2ldl7xcUlulHtARuN9u6GP4pIjU7SqVNsTg400/+d4SxsyCQT7jw/wNocA5xXrYw5iEiJ1Z
	ZX9WyxJr2FTWKvCrMV4D7UU6NPUbhakDsmHke4OuiMmM/TpwqlziaNpVYFQeRAHuRIeY0y21mxW
	8b4cJBnsXbCgt
X-Received: by 2002:a05:600c:6095:b0:4a3:7344:13b5 with SMTP id 5b1f17b1804b1-4ac182dcb98mr337976365e9.16.1793817922428;
        Wed, 04 Nov 2026 10:45:22 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56ef2e968sm4420255e9.8.2026.11.04.10.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:45:21 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 6.18 2/3] ovl: hold a reference on the parent in readdir
Date: Wed,  4 Nov 2026 19:45:15 +0100
Message-ID: <20261104184517.3630089-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104184517.3630089-1-amir73il@gmail.com>
References: <20261104184517.3630089-1-amir73il@gmail.com>
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
@@ -572,8 +572,8 @@ static int ovl_cache_update(const struct path *path, struct ovl_cache_entry *p,
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
@@ -802,6 +802,7 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 	struct dentry *dir = file->f_path.dentry;
 	struct ovl_fs *ofs = OVL_FS(dir->d_sb);
 	const struct ovl_layer *lower_layer = ovl_layer_lower(dir);
+	struct dentry *parent;
 	struct ovl_readdir_translate rdt = {
 		.ctx.actor = ovl_fill_real,
 		.ctx.count = ctx->count,
@@ -813,18 +814,26 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
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
@@ -852,16 +861,19 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
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
