Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794754015;
	b=JK6XgIAE+wXnVFRR3P7RtpfdAydBYSrgatyL325OhIAO392QY3nqZdudJRo1w0+YtumO
	 ogqp23i7lQtnM+dicO6HKuQUcfVg4Xs/1Nz6UMD+0pYtdRjn27OMcaAgk20PabhL7K3aI
	 yavXud5PlA3qOzH/1QbROyYN3fthGDw+E+XpK48EwH+Kq/zLSXAaGjmBjxs0JK7r0l/PP
	 ZLIl3a20U53U/A21rVKGy0keVPCLiRqwmVdYJvQjQCEpZsWoy9dMdv44sy6J22FdIjyrP
	 yeNSet0FU90Xn+00kmLAkV/nSyyHeYWqYhEjL/jzd86dmGjedCuUsaCeAJ67nHtB3sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754015;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qfzr8wUUUR/DONjn0vDRiQZPtomeGYZyJpuLJGk34x4=;
	b=hOsxSIbSwAwaM00MbzKFg5P66e1qT1pPNi+pckyR/yoOSNA85gDmgcVKbFkQ0n0+cfof
	 w0bOiyD/dQ3ngKHb3Zo88Vi5pbEQUCc8VU8R+c5/ell0uxLf25fbbnT1FniORnxj+J3qr
	 NaM3S9Cl8JnPXN//SpuI/KO8sEesZqagJkUHcT8wPW2wtz8S5HpY0DIjeVGuTD5syqLCa
	 2DWxwNWPAtdPtM0MXarmMMqCMrU27JvhAl7bGuoChgItr62jVDhdFvENMWYYrmjBIeKe0
	 j4V8v/UOZShlIEwW60jg9aBhgbbeeFrVJlIYVRHRfeod+bYLoORu+YG2sftVT4mjDsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NJeQ/Qlk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FEE606A31A
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NJeQ/Qlk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873FB1F000C4;
	Sun, 15 Nov 2026 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794754015;
	bh=qfzr8wUUUR/DONjn0vDRiQZPtomeGYZyJpuLJGk34x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NJeQ/QlkIaxAcMovNlVIjHfzhT3Gz55mJjBQMysmAjqZhd5Epxs+11/gI4qGlDCQY
	 n9BuJeiiForiF4R8cCmqQgXxUZXc3HUX2xtwcPvZwn6oMExmYXqTfoDaK/5MJZsCTo
	 YtquGTf2uMf+HvwFSEeNoVkb/4VHTiy66FQbGciIH0izS9KotTIrZ2vqURMjdGqva5
	 1/qOMNNon/d9oKohIFrbWeYkLHIMTToF/9KU5zQwJG0V1e+j00TmNhukmR30iNgOgg
	 yuweMD3d0J50DrhLlwz3ueaSnxRAAh3ZWY+A6bquSJeO86LKydGVZnceOAy56kDIxl
	 HG4eURmmJLH4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: add a flag to convert unwritten extents without allocating blocks
Date: Sun, 15 Nov 2026 09:46:53 -0500
Message-ID: <20261115144625.1269525-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202717-failed-5.10-f3ca3498dfe6@kernel.org>
References: <20261109202717-failed-5.10-f3ca3498dfe6@kernel.org>
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
[ sashal: used a separate conversion-only -ENOSR check because the general zero-mapping error check is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 12 ++++++++++++
 fs/xfs/libxfs/xfs_bmap.h | 10 +++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 5483572512edf..124c60176c612 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4304,6 +4304,8 @@ xfs_bmapi_finish(
  * extent state if necessary.  Details behaviour is controlled by the flags
  * parameter.  Only allocates blocks from a single allocation group, to avoid
  * locking problems.
+ * With XFS_BMAPI_CONVERT_ONLY, it stops at a hole or a delalloc extent instead
+ * of allocating blocks, and returns -ENOSR if it stops before mapping anything.
  */
 int
 xfs_bmapi_write(
@@ -4363,6 +4365,8 @@ xfs_bmapi_write(
 	 */
 	ASSERT((flags & (XFS_BMAPI_PREALLOC | XFS_BMAPI_ZERO)) !=
 			(XFS_BMAPI_PREALLOC | XFS_BMAPI_ZERO));
+	ASSERT(!(flags & XFS_BMAPI_CONVERT_ONLY) ||
+	       (flags & XFS_BMAPI_CONVERT));
 
 	if (XFS_IS_CORRUPT(mp, !xfs_ifork_has_extents(ifp)) ||
 	    XFS_TEST_ERROR(false, mp, XFS_ERRTAG_BMAPIFORMAT)) {
@@ -4412,6 +4416,9 @@ xfs_bmapi_write(
 		 * that we found, if any.
 		 */
 		if (need_alloc || wasdelay) {
+			if (flags & XFS_BMAPI_CONVERT_ONLY)
+				break;
+
 			bma.eof = eof;
 			bma.conv = !!(flags & XFS_BMAPI_CONVERT);
 			bma.wasdel = wasdelay;
@@ -4486,6 +4493,11 @@ xfs_bmapi_write(
 	xfs_bmapi_finish(&bma, whichfork, 0);
 	xfs_bmap_validate_ret(orig_bno, orig_len, orig_flags, orig_mval,
 		orig_nmap, *nmap);
+
+	if (!n && (flags & XFS_BMAPI_CONVERT_ONLY)) {
+		ASSERT(bma.nallocs == 0);
+		return -ENOSR;
+	}
 	return 0;
 error0:
 	xfs_bmapi_finish(&bma, whichfork, error);
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index 6747e97a79490..1d68bd3c2863d 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -101,6 +101,13 @@ struct xfs_extent_free_item
 /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
 #define XFS_BMAPI_NORMAP	0x2000
 
+/*
+ * Use with XFS_BMAPI_CONVERT to convert unwritten extents without allocating
+ * blocks. Stop at a hole or a delalloc extent: return the mappings found so
+ * far, or -ENOSR if there are none.
+ */
+#define XFS_BMAPI_CONVERT_ONLY	0x4000
+
 #define XFS_BMAPI_FLAGS \
 	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
 	{ XFS_BMAPI_METADATA,	"METADATA" }, \
@@ -112,7 +119,8 @@ struct xfs_extent_free_item
 	{ XFS_BMAPI_REMAP,	"REMAP" }, \
 	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
 	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
-	{ XFS_BMAPI_NORMAP,	"NORMAP" }
+	{ XFS_BMAPI_NORMAP,	"NORMAP" }, \
+	{ XFS_BMAPI_CONVERT_ONLY,	"CONVERT_ONLY" }
 
 
 static inline int xfs_bmapi_aflag(int w)
-- 
2.53.0

