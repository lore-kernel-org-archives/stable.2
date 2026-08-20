Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C445D3C1984;
	Thu, 20 Aug 2026 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255867; cv=none; b=GutNJLljzgnVME9Ki7/NxptHL991yGcxYdaRe9/6GnK6aSxKAXNAoajy/GwZGWCecIJ69B23Y14zzHhtThHF9a/5at95MH9l5mG1YNKf7P1R5qdB49u6jWpClwDiJihTddHzJDLUNFi8JngcvQTUG4/vkKotavX5M59QhbEGqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255867; c=relaxed/simple;
	bh=d4vqdYbj9b2hrPnscr1QVmRNMVefmWPItS6E5i98Lmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szbzyC2oOIF4i6me5WVPKjOQa87LXgaf2fBRdDJ/hU7MJ7DTlPWaJm0ReuFS7qydVUOKTfRHX6eWre3XziXtwi1MmrBbVcf/dn5pM4nQ1g7cxzjFUNyK3MurhUprlfLqw53JaA7oQfMyQBngyJdAX80ckNTiQo5G6YGbXhHxu50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=yO420BjP; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="yO420BjP"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hQvP40vbGzlfvpW;
	Thu, 20 Aug 2026 19:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1787255859; x=1789847860; bh=JQYjO
	qxpqzIAaOuFzqo011oCvPLgBWHzscJawBCJVfM=; b=yO420BjPFKDAtJXhuGi+Y
	rKpxzQNuS8dcUFboxEazZ5KCaTiamBFuKwcH/i7t/+dgm56kcUp0XWe1NbbCX/TV
	oDIVYGlGhgcG8fTOhy6EhyZlioVk/E/tYd2Z5B+9EIMOV/ASsK2+DMlSAWvOewpj
	8GBpn4HUbwwowTQk6W/9SMNOIh5bLFT3uD3pUDYP27vAx/w9BRWZNhnawdYzjvHY
	KDzPsUnSSl5z4BQGblDDgssF41w9UV4mP1dckG/OUAAsExSX6eQiGEpE7Ne8hr/7
	PFvmJmULkvSxDGDryb7bebSNJY+T6i3Lywj5NWslW92r5jiiOG01jv1T05a+df1/
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9ATOFFnV2Kgh; Thu, 20 Aug 2026 19:57:39 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hQvNx2H8dzlfsTm;
	Thu, 20 Aug 2026 19:57:36 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Theodore Ts'o <tytso@mit.edu>,
	stable@vger.kernel.org
Subject: [PATCH 01/13] loop: Fix the code for recursion detection
Date: Thu, 20 Aug 2026 12:57:09 -0700
Message-ID: <0c8a65b8870b2ef09119093b485e37896b80e2a4.1787255652.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
In-Reply-To: <cover.1787255652.git.bvanassche@acm.org>
References: <cover.1787255652.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The purpose of loop_validate_file() is to prevent that the file descripto=
r
of an already bound loop device is changed into a file descriptor
associated with a file that depends on the loop device. This must be
prevented because otherwise infinite I/O loops could be triggered and
filesystems involved in this loop would become impossible to unmount.

Fix loop_validate_file() by comparing gendisk pointers instead of dev_t
values.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Fixes: d2ac838e4cd7 ("loop: add recursion validation to LOOP_CHANGE_FD")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6f12976035b0..36deb08ee463 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -481,13 +481,26 @@ static void loop_update_dio_alignment(struct loop_d=
evice *lo)
 	lo->lo_dio_mem_align =3D SECTOR_SIZE - 1;
 }
=20
-static inline int is_loop_device(struct file *file)
+/* Returns the block device that underpins a file.  */
+static inline struct block_device *loop_get_bdev(struct file *file)
 {
-	struct inode *i =3D file->f_mapping->host;
+	struct inode *inode =3D file->f_mapping->host;
+
+	if (S_ISBLK(inode->i_mode))
+		return I_BDEV(inode);
+	if (S_ISREG(inode->i_mode) && inode->i_sb)
+		return inode->i_sb->s_bdev;
+	return NULL;
+}
+
+static inline bool is_loop_device(struct file *file)
+{
+	struct block_device *bdev =3D loop_get_bdev(file);
=20
-	return i && S_ISBLK(i->i_mode) && imajor(i) =3D=3D LOOP_MAJOR;
+	return bdev && bdev->bd_disk->major =3D=3D LOOP_MAJOR;
 }
=20
+/* Returns 0 if and only if @file is not backed by loop device @bdev. */
 static int loop_validate_file(struct file *file, struct block_device *bd=
ev)
 {
 	struct inode	*inode =3D file->f_mapping->host;
@@ -496,12 +509,13 @@ static int loop_validate_file(struct file *file, st=
ruct block_device *bdev)
 	/* Avoid recursion */
 	while (is_loop_device(f)) {
 		struct loop_device *l;
+		struct block_device *f_bdev =3D loop_get_bdev(f);
=20
 		lockdep_assert_held(&loop_validate_mutex);
-		if (f->f_mapping->host->i_rdev =3D=3D bdev->bd_dev)
+		if (f_bdev->bd_disk =3D=3D bdev->bd_disk)
 			return -EBADF;
=20
-		l =3D I_BDEV(f->f_mapping->host)->bd_disk->private_data;
+		l =3D f_bdev->bd_disk->private_data;
 		if (l->lo_state !=3D Lo_bound)
 			return -EINVAL;
 		/* Order wrt setting lo->lo_backing_file in loop_configure(). */
