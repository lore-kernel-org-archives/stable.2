Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793359931;
	b=uhxDmt8O9j1UuEoMaOLnH6Y/Qv2IkiHjjgWvA1l0cDdp0IaKryyXAjmPE1dN3LGTk8Ss
	 7E7+OE1eEdhAqgSzai/tfF+PqW4FiKdVF38pROLWzypMQcoUdhyFRQs5yQsr8JpuzCXPt
	 XKpLQOBTPU8YG+bcJzbNFe7p8+++NpSMjsTVlQ6f+Nr+o66DgmDb035vdLMV1obgAiXEK
	 doBw+rhlyH+cNmW+oGsfUHSgMEJqai9ZmZr8e+4FzSk+NbjvVCI4lNg6pNi7YLVcPoDqk
	 2sCnQlGsEi8zpmFCZgDEqqyHalY8PnEB5el3cB0tkFd9MRVC9LPuBNfqXA3apsmeaig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QlRS5/CrpVvxhUZoAuXRCTXXO2Y4bwCefOuE14TzNwQ=;
	b=efN+X4HBWIs0Mf1MZi4m9WGrFdyWfevM0KfSigzSQIhk1eoLmVcI2NC6dTEmOZsThgA+
	 5YqhlEfLTtLcUmKJXQGHkGzY5lQO9fnRoAvTqAEmrNK3Q7Rg94YkIYWf7zmrVWOWc5DaX
	 J3kKI83QVCZlbVgrwlvkzZKj5NP8FgRSihrrnoP7w+IS1vUvuwE7ZP2tBhGxHKsyWrobI
	 dyCk4QD6feg6hvTpQ6Q6VJNpNx8vdqQ6pujTBd7SaICnH4lOsQtV6xhvI5Fsy9oJ3UfgP
	 ZmXVxxr9XvcuXDBfQu+2i5r0601F94+u+cPcTXPqEBGxUv+miynU7IS1aglNq5+G2+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jribXoF9;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B11606A320
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2B11606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jribXoF9
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso3927305e9.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 04:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793359929; x=1793964729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QlRS5/CrpVvxhUZoAuXRCTXXO2Y4bwCefOuE14TzNwQ=;
        b=jribXoF9yhV37AHa/V9T2sD1QK7epMpsBCYEJ08aha2ZKpOGlFwYoGUHeb7NahTZOi
         f3a278vT9o8Wmhc0UiwnYmc1Z3TA6xGnYXtsoFxl6FQY0HjwG4Ff6LJ3qrBODQxeqRJF
         +LmJ+IYgl/eVuKDR9ZSzSd0FJIkuyRt+LMB3F+vkE+R4inpNk43UeRkRMoaadzi6O3ro
         apTCxAqTbDlw8In2su2jdqsEVeA2Q3407MpZDX9px/I45LQH/eQiSTIVorqsMwP/T0pX
         0ZtESf4m7VrOHppB7I6WRLtImXkfqF7RQx+rbMQa891fLE6tT0Y7gqf1gJtZfIaxPZEZ
         f0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793359929; x=1793964729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QlRS5/CrpVvxhUZoAuXRCTXXO2Y4bwCefOuE14TzNwQ=;
        b=A3jTgY5yvDU2kgohXn0+pKWCqo/VfORjIhmhREliQnkXn4XNgOLfKKuoIOJN/kuqd5
         w7yFMhtZ5TbhJLRKtRz4WMPXzxuExy0UmPMNy4hsNkNPC/tZAUMB6/L9A89ql/4krOJf
         AGRmm1JnV0k57QkspesgZKjGrlBW17WO2bC/fj2nVvQmC6yWHNXE/02HOmtoUD6o3YE4
         OuNqxCOl0rFsbfBwLHi+17V6gGS66PaAHtdjjq8pr3XGFqfg8j6JQKbGMclYnSSXP4xu
         HfNN0ShUKiZSvexr0/SesUToE0kC8e1ymCc9Uxd7kjCHrHdFrXdx0B9H2mtyTE7SEIlG
         rE7Q==
X-Forwarded-Encrypted: i=1; AKwUvBw11uMCY+nozq6BF+4YhNQEis4e8qpkmFbkpImMUQuUGcU+uAjEUbgMLQpfsfllwy5hj77Tznw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJZKvV7F4BGOTFV0sIdxmsxETt4emsD92ajDA7wX+gvL8XVJMC
	QngQVx740criHqeK2WFFklNShSlav9KYZ+p5RuPth0ZnJNxxkqXe4kHw
X-Gm-Gg: AYBFou1GRJh4CSfk/ugBQzRYhiJjh0dgQiV81OCmrlJFQupbBuIP94ppUieybQ2hu4j
	k3er49KEc+TvBytiEi7F6fpOQeFcWd5iAXbnN1IXxrYN1efjudK8QcBj56ji4UBeb53NFS6zh3C
	HItgWHndBqyrIAqMSHqJPrqtjDEHnfIG4zYGi1BHT/z36Y6wn6XjphmhHNdCGbacYGfrM7Rn6Wi
	g6hZN/ITzUhC40gIVvCncQmyvRZ7aDKZHvn1nkQyUtIbg4D5Th/2RZTVziW18oJCALQE7HB2Iy7
	ygIOHajRe75PiWgdxpkXbP+WuSIfNz92haYz48JzOoHO3i/t+eDNBv4pCMth7TCjIGYG8GuDhgf
	OM76FA8qHC2K2WsIb4spgtX8DtH5RRdajiQLeSTyTDlPLRVl+c3J/LEuRxGbe63Kvz4tFElSCaf
	ocJn96ib5oyNj8EAkSK0wSx1hXGd8+NQ/0JFNGf1DdchMK5ZmPB+m65v0qKIKDaE0K1kfjrI/Yf
	esNMG9KgcpWaA+XNGq1YB5S7Htq+zzg030ysFrN8jXp1E9GB8DIJh+8Wd9TTVCXaWtNuwMoTEUq
	p/YdkiVcn4QtXRmLcJbzehMVC2oytFnNPyEXEC3Q3nutDwGjzfLQ2TYBdJhY22JNm01QQEz5+CW
	pqYnBVZwDY1Jy
X-Received: by 2002:a05:600c:470a:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4ac16acfe61mr41713985e9.5.1793359929277;
        Fri, 30 Oct 2026 04:32:09 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b286a0sm45174765e9.4.2026.10.30.04.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:32:08 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] ovl: fix whiteout creation in casefolded directories
Date: Fri, 30 Oct 2026 12:32:01 +0100
Message-ID: <20261030113201.2921633-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030113201.2921633-1-amir73il@gmail.com>
References: <20261030113201.2921633-1-amir73il@gmail.com>
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

unlink and rmdir fail with EINVAL on an overlay with casefolded
(case-insensitive) layers, if the name exists in a lower layer.
Casefolded layers need CONFIG_UNICODE. Root can mount such an overlay,
and so can an unprivileged user in a user namespace, with tmpfs layers.

Overlayfs does not change a lower layer. To remove a name that exists
there, it hides the name with a marker file, a whiteout. It creates the
whiteout in the work directory, a scratch directory on the upper
filesystem, and renames it over the name in the upper directory:

- ovl_whiteout() creates the whiteout with mknod, or as a hard link to
  an earlier whiteout.
- ovl_cleanup_and_whiteout() then prepares the rename with
  start_renaming_two_dentries(), which returns -EINVAL if the source or
  the target dentry is unhashed, that is, not in the dentry hash table.

With casefolded directories, both dentries can be unhashed:

- The target. Lookup in a casefolded directory leaves a negative dentry
  unhashed, so the rename target is unhashed if the name does not exist
  in the upper directory.
- The source, which is the new whiteout. tmpfs hashes a dentry when
  mknod or link makes it positive, but ext4 does not, so on ext4 the
  source is unhashed as well.

The cleanup after the failure also refuses an unhashed dentry, so on
ext4 the whiteout is left behind in the work directory.

Reproduced with rm and rmdir on casefolded tmpfs and ext4 layers, also
as uid 1000 in a user namespace.

Fix this by creating the whiteout with ovl_create_temp(), which repeats
the lookup if the new dentry is unhashed. Prepare the rename with
start_renaming_dentry(), which looks up the target name with the
directories locked. The caller looked the name up without a lock, so
return -ESTALE if the name now refers to a different inode.

Fixes: 833d2b3a072f ("Add start_renaming_two_dentries()")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[amir: pass the name used for lookup instead of taking a name snapshot]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/dir.c       | 46 ++++++++++++++++++++++------------------
 fs/overlayfs/overlayfs.h | 10 +--------
 fs/overlayfs/readdir.c   |  3 ++-
 fs/overlayfs/util.c      |  2 +-
 4 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index f716ac13badf3..c77af9a79d883 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -74,39 +74,34 @@ static struct dentry *ovl_start_creating_temp(struct ovl_fs *ofs,
 			      &QSTR(name));
 }
 
+/*
+ * The whiteout is the source of a rename, so it has to be hashed.
+ * ovl_create_temp() takes care of that for a casefolded workdir.
+ */
 static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 {
 	int err;
 	struct dentry *whiteout, *link;
 	struct dentry *workdir = ofs->workdir;
-	struct inode *wdir = workdir->d_inode;
-	char name[OVL_TEMPNAME_SIZE];
 
 	guard(mutex)(&ofs->whiteout_lock);
 
 	if (!ofs->whiteout) {
-		whiteout = ovl_start_creating_temp(ofs, workdir, name);
+		whiteout = ovl_create_temp(ofs, workdir, &(struct ovl_cattr) {
+					.mode = S_IFCHR | WHITEOUT_MODE,
+					.rdev = WHITEOUT_DEV });
 		if (IS_ERR(whiteout))
 			return whiteout;
-		err = ovl_do_whiteout(ofs, wdir, whiteout);
-		if (!err)
-			ofs->whiteout = dget(whiteout);
-		end_creating(whiteout);
-		if (err)
-			return ERR_PTR(err);
+		ofs->whiteout = whiteout;
 	}
 
 	if (!ofs->no_shared_whiteout) {
-		link = ovl_start_creating_temp(ofs, workdir, name);
-		if (IS_ERR(link))
+		link = ovl_create_temp(ofs, workdir, &(struct ovl_cattr) {
+					.hardlink = ofs->whiteout });
+		if (!IS_ERR(link))
 			return link;
-		err = ovl_do_link(ofs, ofs->whiteout, wdir, link);
-		if (!err)
-			whiteout = dget(link);
-		end_creating(link);
-		if (!err)
-			return whiteout;
 
+		err = PTR_ERR(link);
 		if (err != -EMLINK) {
 			pr_warn("Failed to link whiteout - disabling whiteout inode sharing(nlink=%u, err=%u)\n",
 				ofs->whiteout->d_inode->i_nlink,
@@ -120,9 +115,10 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 }
 
 int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
-			     struct dentry *dentry)
+			     struct dentry *dentry, const struct qstr *name)
 {
 	struct dentry *whiteout;
+	struct qstr last = QSTR_LEN(name->name, name->len);
 	struct renamedata rd = {};
 	int err;
 	int flags = 0;
@@ -139,9 +135,17 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
 	rd.old_parent = ofs->workdir;
 	rd.new_parent = dir;
 	rd.flags = flags;
-	err = start_renaming_two_dentries(&rd, whiteout, dentry);
+	/*
+	 * The caller looked up @dentry by @name without a lock on @dir, and a
+	 * casefolded directory leaves a negative dentry unhashed.  Nothing tells
+	 * if such a dentry is still valid, so look up @name again with @dir locked.
+	 */
+	err = start_renaming_dentry(&rd, 0, whiteout, &last);
 	if (!err) {
-		err = ovl_do_rename_rd(&rd);
+		if (d_inode(rd.new_dentry) != d_inode(dentry))
+			err = -ESTALE;
+		else
+			err = ovl_do_rename_rd(&rd);
 		end_renaming(&rd);
 	}
 	if (err)
@@ -847,7 +851,7 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
 		goto out_dput_upper;
 	}
 
-	err = ovl_cleanup_and_whiteout(ofs, upperdir, upper);
+	err = ovl_cleanup_and_whiteout(ofs, upperdir, upper, &dentry->d_name);
 	if (!err)
 		ovl_dir_modified(dentry->d_parent, true);
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 91cdd7e15696c..4faebb4c6825b 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -394,14 +394,6 @@ static inline int ovl_do_rename(struct ovl_fs *ofs, struct dentry *olddir,
 	return ovl_do_rename_rd(&rd);
 }
 
-static inline int ovl_do_whiteout(struct ovl_fs *ofs,
-				  struct inode *dir, struct dentry *dentry)
-{
-	int err = vfs_whiteout(ovl_upper_mnt_idmap(ofs), dir, dentry);
-	pr_debug("whiteout(%pd2) = %i\n", dentry, err);
-	return err;
-}
-
 static inline struct file *ovl_do_tmpfile(struct ovl_fs *ofs,
 					  struct dentry *dentry, umode_t mode)
 {
@@ -897,7 +889,7 @@ static inline void ovl_copyflags(struct inode *from, struct inode *to)
 /* dir.c */
 extern const struct inode_operations ovl_dir_inode_operations;
 int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
-			     struct dentry *dentry);
+			     struct dentry *dentry, const struct qstr *name);
 struct ovl_cattr {
 	dev_t rdev;
 	umode_t mode;
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 2018e31146555..b862309eba4d1 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1343,7 +1343,8 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			 * Whiteout orphan index to block future open by
 			 * handle after overlay nlink dropped to zero.
 			 */
-			err = ovl_cleanup_and_whiteout(ofs, indexdir, index);
+			err = ovl_cleanup_and_whiteout(ofs, indexdir, index,
+						       &QSTR_LEN(p->name, p->len));
 		} else {
 			/* Cleanup orphan index entries */
 			err = ovl_cleanup(ofs, indexdir, index);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index b41f4788e4f06..47734eeb97b75 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1118,7 +1118,7 @@ static void ovl_cleanup_index(struct dentry *dentry)
 	} else if (ovl_index_all(dentry->d_sb)) {
 		/* Whiteout orphan index to block future open by handle */
 		err = ovl_cleanup_and_whiteout(OVL_FS(dentry->d_sb),
-					       indexdir, index);
+					       indexdir, index, &name);
 	} else {
 		/* Cleanup orphan index entries */
 		err = ovl_cleanup(ofs, indexdir, index);
-- 
2.55.0

