Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273177;
	b=D67GHC4cUUWwOrBMcB2MbA0Wkm+gI4yaoHTQv1JARgmN82vrJ+QH2jNou6dyHP4fldUy
	 xLqKlQH2oSkgA/Rj7nyOJMVKrjHGilRNffJwgiDs+VdDLz3jTF4G096JHbzYX5KpYAWk5
	 JHmzgJ8kGLyeIiUb1YCAJRTJZOSvmIgwTyQHSkIoDDVqGeHK+JDHs1DEDAFxS66ItLO1R
	 nBWRBD4gXLiQjhXklsJtkJm1WDcYO78q9SXEwxfe3MYvN9w8hJL7lnp/W5BLnj/Krn7qI
	 GFaGHzihfM1g+sMXZyeFS0Pn+z67liABZT/etlnRELD/qp7xP3wq+I/8bIHxKDKenkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273177;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6r3/BDoK0oTWpyJdUMjF2v0f9obqA3mJRNB82oNAVD0=;
	b=js5GuxWuUBWZ0uTd2sQCDkxdwxIWV8iOB6Sugp/HFety3FPZgVVcPzIkkHNn6Sl+PQPL
	 4QMG2jLm7TxRTkHe4q5c6dVTzesf5KFSWlGmxvUyP/rdW0xqPilyFiGKT30n8iSkhQPUL
	 LUaiyY+h6gJ1iQ1nd7fOA7XbAWPQKGeA1JkZQlkjpf9PIG0q2yYVj2cTN8112DIi0+fH+
	 ghacaaTOTJ8Ky6wyK8wOnKDPYSDHhm2LabLav6dmYSCA5dhLSfG6ROlkgd676srqK8nbQ
	 w8wUQAhbRF+ANPCTtYjYfjw01dockPx86FV7F1K0Dt5bHR/N6VjXAAPefe8NlwyWvIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCLTZPJB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CFE606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCLTZPJB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED82D1F0089F;
	Tue, 10 Nov 2026 01:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273176;
	bh=6r3/BDoK0oTWpyJdUMjF2v0f9obqA3mJRNB82oNAVD0=;
	h=From:To:Cc:Subject:Date;
	b=oCLTZPJBl7G4x5r2y5Gp8mBetaRsjt6hOMfchcI4n7iz5rA/4fMCsl0CraVzu2kxa
	 k2GBLxPQbE3ZgnMobgjU49b2vGyhalzpBGb+7P1uuorQmCVxbhBkavd7Ht/glGTLZT
	 VytCmLdiYixLEQSs7eFkTBQKDKgTmCxDlXpDdKbT0jknWciXREXhF7MKtEWR2NQWwh
	 3gVThBobTJa/rFE2i8L5/m7YJrepCbLXQUZpUnhze+pLAlhmQi+KWVASxwtiJehcxM
	 BQaLrEzBAcphWYnY5gFM7CiwR9mfJt3FzJwYJfrmXWT7F8HNgar/Pf5PP896N9JIVb
	 4Kr4xhipQjXEA==
From: Sasha Levin <sashal@kernel.org>
To: daejun7.park@samsung.com,
	hch@lst.de,
	p.raghav@samsung.com,
	cem@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xfs: add a flag to convert unwritten extents without allocating blocks" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:12:54 -0500
Message-ID: <20261109201254-failed-6.6-f3ca3498dfe6@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f3ca3498dfe624f9b604c934263538a3acd55af5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201254-failed-6.6-f3ca3498dfe6@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f3ca3498dfe624f9b604c934263538a3acd55af5 Mon Sep 17 00:00:00 2001
From: Daejun Park <daejun7.park@samsung.com>
Date: Thu, 29 Oct 2026 11:22:59 +0900
Subject: [PATCH] xfs: add a flag to convert unwritten extents without
 allocating blocks

xfs_bmapi_write() with XFS_BMAPI_CONVERT also allocates blocks for
holes and delalloc extents in the range. Add XFS_BMAPI_CONVERT_ONLY for
callers that may only convert already allocated blocks. It stops at a
hole or delalloc extent, and returns -ENOSR if it stops before mapping
anything.

Marked for stable because "xfs: refuse a pNFS LAYOUTCOMMIT of a range
without blocks" needs it.

Suggested-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20261013120359.GB2944@lst.de
Cc: stable@vger.kernel.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 14 ++++++++++++--
 fs/xfs/libxfs/xfs_bmap.h | 10 +++++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index ca49bf4a50c5f..050522c58b168 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4130,6 +4130,8 @@ xfs_bmapi_finish(
  * Returns a negative error code on failure, including -ENOSPC when it could not
  * allocate any blocks and -ENOSR when it did allocate blocks to convert a
  * delalloc range, but those blocks were before the passed in range.
+ * With XFS_BMAPI_CONVERT_ONLY, it stops at a hole or a delalloc extent instead
+ * of allocating blocks, and returns -ENOSR if it stops before mapping anything.
  */
 int
 xfs_bmapi_write(
@@ -4189,6 +4191,8 @@ xfs_bmapi_write(
 	 */
 	ASSERT((flags & (XFS_BMAPI_PREALLOC | XFS_BMAPI_ZERO)) !=
 			(XFS_BMAPI_PREALLOC | XFS_BMAPI_ZERO));
+	ASSERT(!(flags & XFS_BMAPI_CONVERT_ONLY) ||
+	       (flags & XFS_BMAPI_CONVERT));
 
 	if (XFS_IS_CORRUPT(mp, !xfs_ifork_has_extents(ifp)) ||
 	    XFS_TEST_ERROR(mp, XFS_ERRTAG_BMAPIFORMAT)) {
@@ -4237,6 +4241,9 @@ xfs_bmapi_write(
 		 * that we found, if any.
 		 */
 		if (need_alloc || wasdelay) {
+			if (flags & XFS_BMAPI_CONVERT_ONLY)
+				break;
+
 			bma.eof = eof;
 			bma.conv = !!(flags & XFS_BMAPI_CONVERT);
 			bma.wasdel = wasdelay;
@@ -4332,10 +4339,13 @@ xfs_bmapi_write(
 	 *
 	 * To avoid a successful return with *nmap set to 0, return the magic
 	 * -ENOSR error code for this particular case so that the caller can
-	 * handle it.
+	 * handle it. The same goes for XFS_BMAPI_CONVERT_ONLY stopping at a
+	 * hole or a delalloc extent at the start of the range, in which case
+	 * nothing has been changed.
 	 */
 	if (!n) {
-		ASSERT(bma.nallocs >= *nmap);
+		ASSERT((flags & XFS_BMAPI_CONVERT_ONLY) ? bma.nallocs == 0 :
+							  bma.nallocs >= *nmap);
 		return -ENOSR;
 	}
 	*nmap = n;
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index e9f5416e4c050..fb7481e8190c6 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -90,6 +90,13 @@ struct xfs_bmalloca {
 /* Try to align allocations to the extent size hint */
 #define XFS_BMAPI_EXTSZALIGN	(1u << 11)
 
+/*
+ * Use with XFS_BMAPI_CONVERT to convert unwritten extents without allocating
+ * blocks. Stop at a hole or a delalloc extent: return the mappings found so
+ * far, or -ENOSR if there are none.
+ */
+#define XFS_BMAPI_CONVERT_ONLY	(1u << 12)
+
 #define XFS_BMAPI_FLAGS \
 	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
 	{ XFS_BMAPI_METADATA,	"METADATA" }, \
@@ -102,7 +109,8 @@ struct xfs_bmalloca {
 	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
 	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
 	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
-	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }
+	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }, \
+	{ XFS_BMAPI_CONVERT_ONLY,	"CONVERT_ONLY" }
 
 
 static inline int xfs_bmapi_aflag(int w)
-- 
2.53.0




