Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794465628;
	b=1aTBjSyG2eBNViZwN9gbxnOtUG9+0+tcNqaY8j78+v9+7ILldANl1iEsR+vgmVb7WNn3
	 BebsE2M/SyDPESyWXzEk/1r1dZMqlu4VcMFUsnKf6vFNT5OxXzwRWFbaDQxrxqzve8AFN
	 RG9YtpWVDL0OeR2I3BleH2MEq3XxvlDKBVDy17gPHO4/ywkW/S6W64mE547273IK4lkzy
	 e7z/EWfm+AZdRPnpyTjwZAn9khmT/0lm5Xw+Kh6y0IduYnjWhk70g6cWichYQMP28odyn
	 0gGZiHMSzHJ7AygWxtkJU8NmNePKIIK/HEoUA9YeEzTTIoEvF0IbXRsSKoQCwnDoELQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794465628;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0ft+TXLgJCL4hhI7O5a1y8TkaMoQ4TfRIWV29SmFEE0=;
	b=C+tD9I/2/19XxBCSPcSWtMSXpds4EWrimZR1YSY//I6MgxuKi0e1qNkcORZ07Fqc86oO
	 Euo3n1mVg1ghBcytgRcl+pbk7HbVH6gU7gfarA2Y6uF1gaLgdQuluzYTZxIoTIuaPIpiY
	 v1A2EHFlWMFvaS3IA8WPwiVxk2STnBHgyrdiehBoFTU2ZVw2ext7pVuztKBnrGXDmdSuR
	 532GYNJpH7BYob3a+dCtkgP7Uby+S/XN/8eBzUoKVhdO39TK25rLCA3XNB9L8y1NXKJA+
	 kbluIZeYogPHJlxC7ohwXt0HvmnvRUnu99lYaF5QJRX2I78/21a4JlQmdFNcCqjWmrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="g+4Ns/3Q";
	arc=none smtp.remote-ip=115.124.30.112
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BDD606A31C;
	Thu, 12 Nov 2026 06:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36BDD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=g+4Ns/3Q
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794465614; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0ft+TXLgJCL4hhI7O5a1y8TkaMoQ4TfRIWV29SmFEE0=;
	b=g+4Ns/3QQh/bnSWBOP2atACLX870Xg1GxYMeOEuIiEZ/GIfbnn3Y6qdFl6sGiqGIaXa71icHZPkj2Buar0tgezGTHY/iplB4zxWmbXuejr9ySmRFRG5Q5zN6ohFRHDh9mOTOvy9tNMXafVUBV9eUoM8NXpKt9BUyYa0/cqEWqX8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0XEb40u8_1794465613;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XEb40u8_1794465613 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 14:40:13 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ufs: free cylinder group structures on late mount failure
Date: Thu, 12 Nov 2026 14:40:09 +0800
Message-Id: <20261112064009.2313455-1-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20261104090923.540863-1-joseph.qi@linux.alibaba.com>
References: <20261104090923.540863-1-joseph.qi@linux.alibaba.com>
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

ufs_fill_super() reads the cylinder group structures before it creates
the root dentry, and the two failures that remain after the read, a
failed ufs_iget() and a failed d_make_root(), jump to a label that only
frees the in-core superblock information.  generic_shutdown_super()
calls put_super only inside its if (sb->s_root) block, so with s_root
left NULL the s_csp allocation, the s_ncg buffer heads behind s_ucg[]
and the UFS_MAX_GROUP_LOADED s_ucpi[] entries are leaked, once per
mount attempt.  Neither failure needs an I/O error: ufs_iget() rejects
a root inode number outside the s_ncg * s_ipg range the image claims,
and s_ipg is not validated.

Move the unwind that ufs_read_cylinder_structures() already performs on
its own failure into ufs_free_cylinder_structures() and call it from
the two late mount failures as well.

The helper also clears everything it releases, which fixes a
stale-pointer bug on the remount path.  A read-only remount runs
ufs_put_super_internal(), which used to free s_csp, s_ucg and s_ucpi[]
without clearing them, and a read-write remount then re-reads the
structures.  If that re-read fails before reassigning the pointers,
the unwind frees the stale s_ucg and s_ucpi[] values a second time.
Have ufs_put_super_internal() flush the loaded cylinders and then call
the helper, so that every teardown clears what it frees, and reset
s_cg_loaded along with the pointers.

Fixes: 55a4c98abb96 ("ufs: create the root dentry after loading cylinder metadata")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ufs/super.c | 72 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 3569ac92b065b..7b0a9929e7594 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -448,6 +448,37 @@ static void ufs_setup_cstotal(struct super_block *sb)
 	UFSD("EXIT\n");
 }
 
+/*
+ * Release everything ufs_read_cylinder_structures() allocated and clear
+ * everything released, so that no later error path can see a stale
+ * pointer: a read-only remount frees the structures through
+ * ufs_put_super_internal(), and a read-write remount re-reads them.
+ * Besides those two callers this is needed when a mount fails after the
+ * cylinder groups have been read: s_root is still NULL then, so
+ * generic_shutdown_super() never calls put_super and
+ * ufs_put_super_internal() does not run.
+ */
+static void ufs_free_cylinder_structures(struct super_block *sb)
+{
+	struct ufs_sb_info *sbi = UFS_SB(sb);
+	struct ufs_sb_private_info *uspi = sbi->s_uspi;
+	unsigned int i;
+
+	if (sbi->s_ucg) {
+		for (i = 0; i < uspi->s_ncg; i++)
+			brelse(sbi->s_ucg[i]);
+		kfree(sbi->s_ucg);
+		sbi->s_ucg = NULL;
+		for (i = 0; i < UFS_MAX_GROUP_LOADED; i++) {
+			kfree(sbi->s_ucpi[i]);
+			sbi->s_ucpi[i] = NULL;
+		}
+	}
+	sbi->s_cg_loaded = 0;
+	kfree(sbi->s_csp);
+	sbi->s_csp = NULL;
+}
+
 /*
  * Read on-disk structures associated with cylinder groups
  */
@@ -455,7 +486,7 @@ static int ufs_read_cylinder_structures(struct super_block *sb)
 {
 	struct ufs_sb_info *sbi = UFS_SB(sb);
 	struct ufs_sb_private_info *uspi = sbi->s_uspi;
-	unsigned char * base, * space;
+	unsigned char *space;
 	unsigned size, blks, i;
 
 	UFSD("ENTER\n");
@@ -466,9 +497,9 @@ static int ufs_read_cylinder_structures(struct super_block *sb)
 	 */
 	size = uspi->s_cssize;
 	blks = (size + uspi->s_fsize - 1) >> uspi->s_fshift;
-	base = space = kmalloc(size, GFP_NOFS);
-	if (!base)
-		goto failed; 
+	space = kmalloc(size, GFP_NOFS);
+	if (!space)
+		goto failed;
 	sbi->s_csp = (struct ufs_csum *)space;
 	for (i = 0; i < blks; i++) {
 		struct buffer_head *bh = sb_bread(sb, uspi->s_csaddr + i);
@@ -511,15 +542,7 @@ static int ufs_read_cylinder_structures(struct super_block *sb)
 	return 1;
 
 failed:
-	kfree (base);
-	if (sbi->s_ucg) {
-		for (i = 0; i < uspi->s_ncg; i++)
-			if (sbi->s_ucg[i])
-				brelse (sbi->s_ucg[i]);
-		kfree (sbi->s_ucg);
-		for (i = 0; i < UFS_MAX_GROUP_LOADED; i++)
-			kfree (sbi->s_ucpi[i]);
-	}
+	ufs_free_cylinder_structures(sb);
 	UFSD("EXIT (FAILED)\n");
 	return 0;
 }
@@ -585,7 +608,7 @@ static void ufs_put_super_internal(struct super_block *sb)
 {
 	struct ufs_sb_info *sbi = UFS_SB(sb);
 	struct ufs_sb_private_info *uspi = sbi->s_uspi;
-	unsigned char * base, * space;
+	unsigned char *space;
 	unsigned blks, size, i;
 
 	
@@ -594,7 +617,7 @@ static void ufs_put_super_internal(struct super_block *sb)
 	ufs_put_cstotal(sb);
 	size = uspi->s_cssize;
 	blks = (size + uspi->s_fsize - 1) >> uspi->s_fshift;
-	base = space = (char*) sbi->s_csp;
+	space = (char *)sbi->s_csp;
 	for (i = 0; i < blks; i++, space += uspi->s_fsize) {
 		struct buffer_head *bh = sb_bread(sb, uspi->s_csaddr + i);
 
@@ -607,16 +630,9 @@ static void ufs_put_super_internal(struct super_block *sb)
 		mark_buffer_dirty(bh);
 		brelse(bh);
 	}
-	for (i = 0; i < sbi->s_cg_loaded; i++) {
-		ufs_put_cylinder (sb, i);
-		kfree (sbi->s_ucpi[i]);
-	}
-	for (; i < UFS_MAX_GROUP_LOADED; i++) 
-		kfree (sbi->s_ucpi[i]);
-	for (i = 0; i < uspi->s_ncg; i++) 
-		brelse (sbi->s_ucg[i]);
-	kfree (sbi->s_ucg);
-	kfree (base);
+	for (i = 0; i < sbi->s_cg_loaded; i++)
+		ufs_put_cylinder(sb, i);
+	ufs_free_cylinder_structures(sb);
 
 	UFSD("EXIT\n");
 }
@@ -1211,17 +1227,19 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode = ufs_iget(sb, UFS_ROOTINO);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
-		goto failed;
+		goto failed_cg;
 	}
 	sb->s_root = d_make_root(inode);
 	if (!sb->s_root) {
 		ret = -ENOMEM;
-		goto failed;
+		goto failed_cg;
 	}
 
 	UFSD("EXIT\n");
 	return 0;
 
+failed_cg:
+	ufs_free_cylinder_structures(sb);
 failed:
 	if (ubh)
 		ubh_brelse_uspi (uspi);
-- 
2.39.3

