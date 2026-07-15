Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0180638C2A7
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126456; cv=none; b=l3arL2NsUD5ruYhus/0uPdNueEUaWNdka6JDOO3/TzuE89EKBZ64O1FRn2KkHgHzhT0kQEGUs1PYdiJdfukbww+8/s96ibmgSKOUdeJ9m1nuIAI1qSjP6YYVMEnkxAKHwW8N/KZ6YT7ejSNruuMrvT2qrPoaiJQgczklTZIVdcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126456; c=relaxed/simple;
	bh=08N/Mx89mm+34lTDbW+TqEt/Wy0iFn1m8CSMmU5AQ+A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=huxf2WmKQFw+r5wLTGqxH8WepvFa6976bgEl0DjmJuyjCDk6UjDL6x68AYV4Mj5hXp4n9aW6JZcO+W1wCmh4d6tX5fLVt4ps3SUiitkHFJYOpti1FjfcfSUDcIChOkMvBLkL3pAixdE0WJxXGCLZyhUOamW+R9HbJJ7zbWxW8b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=scYKG06k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="scYKG06k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3B31F00A3F;
	Wed, 15 Jul 2026 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784126454;
	bh=HgMADTCclYLOPFFZooxh1/24OFixl03wz7Q24/Ot57I=;
	h=Subject:To:Cc:From:Date;
	b=scYKG06kulkVz/4dLymrMNa+YhxVpDSBWnoaGuDE/OgCndWSCy4sggRwHei5KHYo7
	 F+Bs/W/kUaMlyEyIa/cxVm5eVYKLq8wgKVwXOQniPgqFw7NOCytaDWy1Y6dJq5XZFI
	 GakHBYr0N4a/M1aiLMy3F3eYagYoTIB3HmnUpFS8=
Subject: FAILED: patch "[PATCH] iomap: consolidate bio submission" failed to apply to 7.1-stable tree
To: hch@lst.de,brauner@kernel.org,djwong@kernel.org,joannelkoong@gmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 16:40:48 +0200
Message-ID: <2026071548-sinister-joystick-e062@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 044472d5ee7d71f918fa3f61bd65e4933a0c006e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071548-sinister-joystick-e062@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 044472d5ee7d71f918fa3f61bd65e4933a0c006e Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 29 Jun 2026 14:17:38 +0200
Subject: [PATCH] iomap: consolidate bio submission

Add a iomap_bio_submit_read_endio helper factored out of
iomap_bio_submit_read to that all ->submit_read implementations for
iomap_read_ops that use iomap_bio_read_folio_range can shared the
logic.

Right now that logic is mostly trivial, but already has a bug for XFS
because the XFS version is too trivial:  file system integrity validation
needs a workqueue context and thus can't happen from the default iomap
bi_end_io I/O handler.  Unfortunately the iomap refactoring just before
fs integrity landed moved code around here and the call go misplaced,
meaning it never got called.  The PI information still is verified by
the block layer, but the offloading is less efficient (and the future
userspace interface can't get at it).

Fixes: 0b10a370529c ("iomap: support T10 protection information")
Cc: stable@vger.kernel.org # v7.1
Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20260629121750.3392300-2-hch@lst.de
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
index 1aac38e63fe6..190fc6471f84 100644
--- a/fs/exfat/iomap.c
+++ b/fs/exfat/iomap.c
@@ -253,10 +253,7 @@ static void exfat_iomap_read_end_io(struct bio *bio)
 static void exfat_iomap_bio_submit_read(const struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx)
 {
-	struct bio *bio = ctx->read_ctx;
-
-	bio->bi_end_io = exfat_iomap_read_end_io;
-	submit_bio(bio);
+	iomap_bio_submit_read_endio(iter, ctx, exfat_iomap_read_end_io);
 }
 
 const struct iomap_read_ops exfat_iomap_bio_read_ops = {
diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
index 4504f4633f17..0f31e35567b4 100644
--- a/fs/iomap/bio.c
+++ b/fs/iomap/bio.c
@@ -78,15 +78,23 @@ u32 iomap_finish_ioend_buffered_read(struct iomap_ioend *ioend)
 	return __iomap_read_end_io(&ioend->io_bio, ioend->io_error);
 }
 
-static void iomap_bio_submit_read(const struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
+void iomap_bio_submit_read_endio(const struct iomap_iter *iter,
+		struct iomap_read_folio_ctx *ctx, bio_end_io_t end_io)
 {
 	struct bio *bio = ctx->read_ctx;
 
+	bio->bi_end_io = end_io;
 	if (iter->iomap.flags & IOMAP_F_INTEGRITY)
 		fs_bio_integrity_alloc(bio);
 	submit_bio(bio);
 }
+EXPORT_SYMBOL_GPL(iomap_bio_submit_read_endio);
+
+static void iomap_bio_submit_read(const struct iomap_iter *iter,
+		struct iomap_read_folio_ctx *ctx)
+{
+	return iomap_bio_submit_read_endio(iter, ctx, iomap_read_end_io);
+}
 
 static struct bio_set *iomap_read_bio_set(struct iomap_read_folio_ctx *ctx)
 {
@@ -127,7 +135,6 @@ static void iomap_read_alloc_bio(const struct iomap_iter *iter,
 	if (ctx->rac)
 		bio->bi_opf |= REQ_RAHEAD;
 	bio->bi_iter.bi_sector = iomap_sector(iomap, iter->pos);
-	bio->bi_end_io = iomap_read_end_io;
 	bio_add_folio_nofail(bio, folio, plen,
 			offset_in_folio(folio, iter->pos));
 	ctx->read_ctx = bio;
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 1fbf832ad165..f2bb56506046 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -38,11 +38,9 @@ static void ntfs_iomap_read_end_io(struct bio *bio)
 }
 
 static void ntfs_iomap_bio_submit_read(const struct iomap_iter *iter,
-	struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx)
 {
-	struct bio *bio = ctx->read_ctx;
-	bio->bi_end_io = ntfs_iomap_read_end_io;
-	submit_bio(bio);
+	iomap_bio_submit_read_endio(iter, ctx, ntfs_iomap_read_end_io);
 }
 
 static const struct iomap_read_ops ntfs_iomap_bio_read_ops = {
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index c43101cc064d..0c9bd669117d 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -608,10 +608,7 @@ static void ntfs_iomap_read_end_io(struct bio *bio)
 static void ntfs_iomap_bio_submit_read(const struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx)
 {
-	struct bio *bio = ctx->read_ctx;
-
-	bio->bi_end_io = ntfs_iomap_read_end_io;
-	submit_bio(bio);
+	iomap_bio_submit_read_endio(iter, ctx, ntfs_iomap_read_end_io);
 }
 
 static const struct iomap_read_ops ntfs_iomap_bio_read_ops = {
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 2a0c54256e93..51293b6f331f 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -764,8 +764,7 @@ xfs_bio_submit_read(
 
 	/* defer read completions to the ioend workqueue */
 	iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset, 0);
-	bio->bi_end_io = xfs_end_bio;
-	submit_bio(bio);
+	iomap_bio_submit_read_endio(iter, ctx, xfs_end_bio);
 }
 
 static const struct iomap_read_ops xfs_iomap_read_ops = {
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 3582ed1fe236..56b43d594e6e 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -622,6 +622,8 @@ extern struct bio_set iomap_ioend_bioset;
 #ifdef CONFIG_BLOCK
 int iomap_bio_read_folio_range(const struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx, size_t plen);
+void iomap_bio_submit_read_endio(const struct iomap_iter *iter,
+		struct iomap_read_folio_ctx *ctx, bio_end_io_t end_io);
 
 extern const struct iomap_read_ops iomap_bio_read_ops;
 

