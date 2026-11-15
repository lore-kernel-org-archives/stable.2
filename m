Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794752824;
	b=P2B7car8fCI3P3vi3e6nL9Ghjk67ymaFrNDrtBQjr3Xf8YRnxku1gzlbK5WlaLgnX5UO
	 /sFda8OBuf2s1XiNQG4WKtS/Gh98I7OkmP97gX7UHSOURQSt1JACdpzv/0WQPZqe4m4Ld
	 vEolCmLwSMafT2g5s4d7xAeqKiYFXRX0sr+l/nqOtefnB/qyO6hQc3bbEzlM2vE3aOwuV
	 7U6SBSWuwIm6W47UXJGtBwiUoF4U5l5qI4qbF9d+BMD+AhlctAB5WG4TNjpzT6oyeQ2EP
	 rzlf8lre+ImeUhNbq0J0Ge/ypg5P9vRXBUFot8DynfIMSIU2LhVmGzya5uItVlcU4KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794752824;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6NOQSlpg7/EiH2y2f3WgtHBefziaXZGPpHjlnrgYCRs=;
	b=sXnMG0xopBZsQtsSmL6DieWxhJoEaSpcoJFESTzqiZ/x0LQgI4+AIXQF29P/CQ4Wybcv
	 sX+/7oZ93nJMgfDp0K/9EToENXDvFRUHCypuArM1YOv7qLATc9A0UZnYlwAykZXW9ZaMY
	 yIpPrwN7d89ZEHCGXZpavPvTQzxKUWm5OATY/woPJnuPiuzlZlIogLQceAtlsnde2NTqX
	 TE5Z2NsMZ59cva8IAIEZzOnv3ap2+D1Tf+LCNBatzi+0jtD5I3DPsEiudRgcUUD8tBv0M
	 /l5wUtBGZtfhR51fGQKmcRGYlh8+52SbqBE+9vCOq1M654SLb6JpDc8FmucC0AUs9Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImZwmGyq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17737606A31D
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImZwmGyq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2F71F000C4;
	Sun, 15 Nov 2026 14:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794752823;
	bh=6NOQSlpg7/EiH2y2f3WgtHBefziaXZGPpHjlnrgYCRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ImZwmGyqfKVkVvbNW8z/czrsyG+bPSb732edv0uR1i/tdh+ura6AkVku0hZL2Zziq
	 go1UuHgEgtiWAqrcKjAGgzlDIN7ySNFrv3SVifHg+Gfqwrl1yShSSMeIpDzcisJs1Q
	 vwGeJDi+tjPgb57Lb3aJnOvumLEccgH8o4GVfArlJb3WRaSfxX+fjrmT6VxBVf13V8
	 m0PfNRnUcU9RMMxsJ5lNGjg4Rn0AKZUSBGv697kRQVseDiRO68FUrNsfScrLQxiRrc
	 AFICvRKg8teTlEUbF7gBP0OfUafnpGmO93VMQr/xWlwPXUYB5pe0Q1oIF8rNM3kjKI
	 83TzrOVKe6B9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xfs: add a flag to convert unwritten extents without allocating blocks
Date: Sun, 15 Nov 2026 09:27:01 -0500
Message-ID: <20261115142640.1196473-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200828-failed-6.12-f3ca3498dfe6@kernel.org>
References: <20261109200828-failed-6.12-f3ca3498dfe6@kernel.org>
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
[ sashal: Placed XFS_BMAPI_CONVERT_ONLY and its trace entry after XFS_BMAPI_NORMAP because XFS_BMAPI_EXTSZALIGN is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 14 ++++++++++++--
 fs/xfs/libxfs/xfs_bmap.h | 10 +++++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index b2b5a36ead97b..5a79ae2e2276c 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4380,6 +4380,8 @@ xfs_bmapi_finish(
  * Returns a negative error code on failure, including -ENOSPC when it could not
  * allocate any blocks and -ENOSR when it did allocate blocks to convert a
  * delalloc range, but those blocks were before the passed in range.
+ * With XFS_BMAPI_CONVERT_ONLY, it stops at a hole or a delalloc extent instead
+ * of allocating blocks, and returns -ENOSR if it stops before mapping anything.
  */
 int
 xfs_bmapi_write(
@@ -4439,6 +4441,8 @@ xfs_bmapi_write(
 	 */
 	ASSERT((flags & (XFS_BMAPI_PREALLOC | XFS_BMAPI_ZERO)) !=
 			(XFS_BMAPI_PREALLOC | XFS_BMAPI_ZERO));
+	ASSERT(!(flags & XFS_BMAPI_CONVERT_ONLY) ||
+	       (flags & XFS_BMAPI_CONVERT));
 
 	if (XFS_IS_CORRUPT(mp, !xfs_ifork_has_extents(ifp)) ||
 	    XFS_TEST_ERROR(mp, XFS_ERRTAG_BMAPIFORMAT)) {
@@ -4487,6 +4491,9 @@ xfs_bmapi_write(
 		 * that we found, if any.
 		 */
 		if (need_alloc || wasdelay) {
+			if (flags & XFS_BMAPI_CONVERT_ONLY)
+				break;
+
 			bma.eof = eof;
 			bma.conv = !!(flags & XFS_BMAPI_CONVERT);
 			bma.wasdel = wasdelay;
@@ -4581,10 +4588,13 @@ xfs_bmapi_write(
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
index 7592d46e97c66..0a7c32c6ce34f 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -87,6 +87,13 @@ struct xfs_bmalloca {
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
@@ -98,7 +105,8 @@ struct xfs_bmalloca {
 	{ XFS_BMAPI_REMAP,	"REMAP" }, \
 	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
 	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
-	{ XFS_BMAPI_NORMAP,	"NORMAP" }
+	{ XFS_BMAPI_NORMAP,	"NORMAP" }, \
+	{ XFS_BMAPI_CONVERT_ONLY,	"CONVERT_ONLY" }
 
 
 static inline int xfs_bmapi_aflag(int w)
-- 
2.53.0

