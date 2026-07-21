Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E373376490
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 11:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634423; cv=none; b=VdwmcdbcDBB6M/E3ZPgUoN0QGLkzXi1acPWjzuVJA55GniCwTrVR0bFzOxwUNbFKP1TyEAsiukHQZbocDUbBoQAVXmYwEEKbeSeMXcEZ/DSU7EYY62Yv0N+EDxozk4iXljOYlOpKrUyiEq0I33RCwqfRY6OCOJMRRX1EKZgc8DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634423; c=relaxed/simple;
	bh=d+HeNzdFtXzogEVtVcQciAatcXFDKF5GKuQTw1OyRJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeltPzeg34aNxX302WoEvJ+owAdoEPGojiV4FGIN0etAqQHxTfmSoOHt+0JrH0jDBq6wY7B4Ohks+QwHZoLrlKW5nk66vYl7zBnIP6xRM5NBcv8RPYANKF3YsgkfnFvKOVN67lkTrS73V9ysUrBOtMZ6Y2PibWkmo4KWFq01wRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3MhRHNW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3MhRHNW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39231F00A3E;
	Tue, 21 Jul 2026 11:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784634421;
	bh=WJ2pngFr2oPaawjiccuMD6+ANlNGWQmzXYjEdX0SUVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V3MhRHNWzcPagM5QTCuHZiHLJZBamjX6X0mwneW9tjwANGDT/GOIoGK4LHmPCG1g0
	 j3VWq/YZ3I8KxTpCJH4nuync8PshHbfGyhj+JJxVQBIyHTJJzULZdE6ncjzHp4ms4Y
	 AOK14hnDbvMZejifKlHwUdmzDjS78NDZBu8/O4jWJo9E9mYG4ql+h1QXPZrFbPt6hI
	 YMT4hQ2nMVFAvF6phP2SFwMZ5iXjSbMliJ1wMnoAg1IWVQdeDfLfWxl5gWe9Y0vIDB
	 KgQJKyMtzAJO1xBp0Ee0NyhrfSqO9ipfZKmZakUbuHPZK2S0pG2HhvaIlxvI7+PBTb
	 yLs7dcIUgXWnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 5/5] iomap: consolidate bio submission
Date: Tue, 21 Jul 2026 07:46:56 -0400
Message-ID: <20260721114656.3687966-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721114656.3687966-1-sashal@kernel.org>
References: <2026071548-sinister-joystick-e062@gregkh>
 <20260721114656.3687966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 044472d5ee7d71f918fa3f61bd65e4933a0c006e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/bio.c        | 13 ++++++++++---
 fs/ntfs/aops.c        |  6 ++----
 fs/ntfs3/inode.c      |  5 +----
 fs/xfs/xfs_aops.c     |  3 +--
 include/linux/iomap.h |  2 ++
 5 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
index 4504f4633f1759..0f31e35567b4b4 100644
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
index 1fbf832ad16540..f2bb5650604657 100644
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
index 42af1abe17f883..f9600aba1548a5 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -609,10 +609,7 @@ static void ntfs_iomap_read_end_io(struct bio *bio)
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
index f279055fcea037..a93d8e2cef402e 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -753,8 +753,7 @@ xfs_bio_submit_read(
 
 	/* defer read completions to the ioend workqueue */
 	iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset, 0);
-	bio->bi_end_io = xfs_end_bio;
-	submit_bio(bio);
+	iomap_bio_submit_read_endio(iter, ctx, xfs_end_bio);
 }
 
 static const struct iomap_read_ops xfs_iomap_read_ops = {
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 2c5685adf3a97c..45b6888af4c6e7 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -615,6 +615,8 @@ extern struct bio_set iomap_ioend_bioset;
 #ifdef CONFIG_BLOCK
 int iomap_bio_read_folio_range(const struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx, size_t plen);
+void iomap_bio_submit_read_endio(const struct iomap_iter *iter,
+		struct iomap_read_folio_ctx *ctx, bio_end_io_t end_io);
 
 extern const struct iomap_read_ops iomap_bio_read_ops;
 
-- 
2.53.0

