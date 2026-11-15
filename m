Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794753180;
	b=x7BFwCzVZZvE2vpiHP00+5VH7pnU6QR84Jy2y7teoLwBhjA29/ddT8gCSiqYtFYtm7OC
	 dtC6jC93TN6IcpREAqBNXyMP36iPaihMd9TEXn8pAucKO7Sdk/Dv23fNaKP8adzdEz1TR
	 Tw0MjT/Oaq/61TekGvnBhCkDQtyoubnOWkDOU/7m6W5fs576fG4CCcJYhBn2OCBVAthCi
	 32T20J/RSjA743B4Y6D74HWWWQc5zrJOQHXf2FeUeJ2C3LuQldms8Z8F79eH+7PsG6yDE
	 U3oeiK/t/U+KmoNGqu88nqd5JJ8BXyTSZ8J3nnIYHLkybIN68/Ug18h6YMEkvQAH8dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794753180;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5uwYvg6aL1vioaKaYYDk8bpN9zxS7Jdk8MpZyYrgeNA=;
	b=1SWeZG593iiY8NBWSbxLTroq96C9DOnHPiL/dgMwm+KUETO0DQB3hn0ItII4NQRLLRLp
	 xKlyiB8Nxxe5zTHwx6YQWXJUlVH0LBOI1c0iqLw+ifihhe/4tzt1E27bBOZinp6Fz6xaC
	 ucOM1A03G3BUCcuPD8VpD4GKaFUiE/1MPQCtlPO88APsvigiF2k4HX0AvGqmokxcB/M46
	 PJ/NufvPANo904whou7EWtJnkgYN3Z58DHgeFVKfZ48KZ6NUL5glCI9Sf6hyWYqlEgtbT
	 7riAKwXOFtvLYDXKnXmJjahzEX/bG3vWDHbvMqYVK3pxPoVvEMB+BbsdMzvRPJQfTrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhUAuRPj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBE4606A31A
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhUAuRPj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD561F000C4;
	Sun, 15 Nov 2026 14:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794753180;
	bh=5uwYvg6aL1vioaKaYYDk8bpN9zxS7Jdk8MpZyYrgeNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lhUAuRPjcxPTZvOnqw0UYbHRqO7namUhtMkMhz58uOspGHSHFPDgnuFYxi8ingmvp
	 KjdSC7tAl2atsE/k8DMmOz2X+gngP/6lQLSZVhNSSvBg+Z932wRcK6LxEikjx+uf3C
	 VAbKgGjWzU0OeQKvVl/RTLZRO71RZ4UMilLlj3GfrGSIurGf0R50DB+dou/sTMfzlR
	 ORln5HyApsscmyZA4eIwjczdqkoPFyWEyhLizctZEJP1hZ8zXFuB/wm+3rWcIWMD3u
	 cNoPQSHspK5Ecw+7GA/qmgmxd2rA2GonhFrQWm8FCyUWz5zurCP0Ho3tS+ybtzTtHF
	 NQDimBv0ADOJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] xfs: add a flag to convert unwritten extents without allocating blocks
Date: Sun, 15 Nov 2026 09:32:58 -0500
Message-ID: <20261115143240.1217756-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201743-failed-6.1-f3ca3498dfe6@kernel.org>
References: <20261109201743-failed-6.1-f3ca3498dfe6@kernel.org>
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

From: Daejun Park <daejun7.park@samsung.com>

[ Upstream commit f3ca3498dfe624f9b604c934263538a3acd55af5 ]

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
[ sashal: adjusted flag context to follow XFS_BMAPI_NORMAP because XFS_BMAPI_EXTSZALIGN is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 14 ++++++++++++--
 fs/xfs/libxfs/xfs_bmap.h | 10 +++++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 14b0d230f61bd..c715e03020d41 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4333,6 +4333,8 @@ xfs_bmapi_finish(
  * Returns a negative error code on failure, including -ENOSPC when it could not
  * allocate any blocks and -ENOSR when it did allocate blocks to convert a
  * delalloc range, but those blocks were before the passed in range.
+ * With XFS_BMAPI_CONVERT_ONLY, it stops at a hole or a delalloc extent instead
+ * of allocating blocks, and returns -ENOSR if it stops before mapping anything.
  */
 int
 xfs_bmapi_write(
@@ -4392,6 +4394,8 @@ xfs_bmapi_write(
 	 */
 	ASSERT((flags & (XFS_BMAPI_PREALLOC | XFS_BMAPI_ZERO)) !=
 			(XFS_BMAPI_PREALLOC | XFS_BMAPI_ZERO));
+	ASSERT(!(flags & XFS_BMAPI_CONVERT_ONLY) ||
+	       (flags & XFS_BMAPI_CONVERT));
 
 	if (XFS_IS_CORRUPT(mp, !xfs_ifork_has_extents(ifp)) ||
 	    XFS_TEST_ERROR(false, mp, XFS_ERRTAG_BMAPIFORMAT)) {
@@ -4439,6 +4443,9 @@ xfs_bmapi_write(
 		 * that we found, if any.
 		 */
 		if (need_alloc || wasdelay) {
+			if (flags & XFS_BMAPI_CONVERT_ONLY)
+				break;
+
 			bma.eof = eof;
 			bma.conv = !!(flags & XFS_BMAPI_CONVERT);
 			bma.wasdel = wasdelay;
@@ -4526,10 +4533,13 @@ xfs_bmapi_write(
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
index 524912f276f87..bf51d7d428156 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -86,6 +86,13 @@ struct xfs_bmalloca {
 /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
 #define XFS_BMAPI_NORMAP	(1u << 10)
 
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
@@ -97,7 +104,8 @@ struct xfs_bmalloca {
 	{ XFS_BMAPI_REMAP,	"REMAP" }, \
 	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
 	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
-	{ XFS_BMAPI_NORMAP,	"NORMAP" }
+	{ XFS_BMAPI_NORMAP,	"NORMAP" }, \
+	{ XFS_BMAPI_CONVERT_ONLY,	"CONVERT_ONLY" }
 
 
 static inline int xfs_bmapi_aflag(int w)
-- 
2.53.0

