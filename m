Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794753016;
	b=ufp7PYQFrOX2IFMh8vclMQCD6hPTBl0EfQeKnjS8dLKEIZQ8tLvNkTwLcC3m6N4vQVQ1
	 9iHt7O2KbvSUl5mf91stIIEI2CM515/yo9WmGZXsmYG/xTgOqJu6zDW9Jqdsia90E+DF5
	 V8spQwr7vfXqmhgBjZDmvqL7QGM2ULncWBgbAd4YtPdw4vdQAZyp3ZRYfFr1yQTY0wTsq
	 0aJB0Vzj6pFCH8tg/nL0TYXIzvWMLoHiy8h54G17AnI2mTQCsz+f2qsxiyTFeyUttLqUr
	 lifZc7s/jJo72pJ74MG4jkMR76+0UNWMlTnUp+SddcuHfdsUim8RdlUDm5kyj8P4q3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794753016;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zEtffmCmDe9Gn+/P3IRk3/1c0xowv35GBpCPd/aPMFk=;
	b=cofFavBn7GUwXkGJmsTo+eIYnHPxbrcWOE9F+q+2U55ag76LsHhaORicxTbW3H00Oq8M
	 AyH0yLzymT8SY1prPILv6m7puyWoek6kH0/HH/2Q4U/gi8gjA4YJBDIWs7kJd4YLnQ2pN
	 jJpqXTDGahFqJqXtrvCELYHvFOLJF4T9WRjW2bgYD9btq/gcOoHQ/S9hzThZyZpZKPPK2
	 ydxBq15HNZ/ekjOUNGjFYDY5QQrTmAJgreAHUzL93Y18qMNCKSZhM47Zc1gQaBDI8+jOV
	 4P/LAAuJcdxxdg47xkrVeTzEMDqBk6TpaHMg+xK1Pn6mCCfbQCiNeFnYVHeXUjaZYyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJkvrn8x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686F9606A323
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJkvrn8x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626931F000C4;
	Sun, 15 Nov 2026 14:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794753016;
	bh=zEtffmCmDe9Gn+/P3IRk3/1c0xowv35GBpCPd/aPMFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PJkvrn8xu5LJXkN5IsqHBZZmTsQXBL3bTuBzhYRyaKIWAUJ0bFCyEjdS6wP04Ibkg
	 aVXB93ZM8sUrE9FBex/A8dDCnoXgdrbMuNPoFL7/I+bLUGXgUJkvYZ1UktzuN2bCTW
	 vozw6uk6If53lOnIYGcvspLm+eBTu99EDXqHu6FaKX+JHLoXbJuJs+6KVMuPmxnpI9
	 7wV6pJJAsGQUgPebWIl9ZJKnICLUbI9PsHbFaygX2Hhu6C5TdUFKy3qsASdKSJzZ8c
	 5vyN51UN2iPbIWIIaGYSefYEt+IvXp3gZIzM0bEEqsKm23TK06fBEIiahTUxj3XG2N
	 3LVgXZTsSIs7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: add a flag to convert unwritten extents without allocating blocks
Date: Sun, 15 Nov 2026 09:30:14 -0500
Message-ID: <20261115142957.1213907-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201254-failed-6.6-f3ca3498dfe6@kernel.org>
References: <20261109201254-failed-6.6-f3ca3498dfe6@kernel.org>
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
[ sashal: adapted flag insertion to follow XFS_BMAPI_NORMAP because XFS_BMAPI_EXTSZALIGN is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 14 ++++++++++++--
 fs/xfs/libxfs/xfs_bmap.h | 10 +++++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index c111f691ea51a..974dd4cd38e50 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4296,6 +4296,8 @@ xfs_bmapi_finish(
  * Returns a negative error code on failure, including -ENOSPC when it could not
  * allocate any blocks and -ENOSR when it did allocate blocks to convert a
  * delalloc range, but those blocks were before the passed in range.
+ * With XFS_BMAPI_CONVERT_ONLY, it stops at a hole or a delalloc extent instead
+ * of allocating blocks, and returns -ENOSR if it stops before mapping anything.
  */
 int
 xfs_bmapi_write(
@@ -4355,6 +4357,8 @@ xfs_bmapi_write(
 	 */
 	ASSERT((flags & (XFS_BMAPI_PREALLOC | XFS_BMAPI_ZERO)) !=
 			(XFS_BMAPI_PREALLOC | XFS_BMAPI_ZERO));
+	ASSERT(!(flags & XFS_BMAPI_CONVERT_ONLY) ||
+	       (flags & XFS_BMAPI_CONVERT));
 
 	if (XFS_IS_CORRUPT(mp, !xfs_ifork_has_extents(ifp)) ||
 	    XFS_TEST_ERROR(false, mp, XFS_ERRTAG_BMAPIFORMAT)) {
@@ -4402,6 +4406,9 @@ xfs_bmapi_write(
 		 * that we found, if any.
 		 */
 		if (need_alloc || wasdelay) {
+			if (flags & XFS_BMAPI_CONVERT_ONLY)
+				break;
+
 			bma.eof = eof;
 			bma.conv = !!(flags & XFS_BMAPI_CONVERT);
 			bma.wasdel = wasdelay;
@@ -4489,10 +4496,13 @@ xfs_bmapi_write(
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
index e33470e39728d..8bcb1a9b5fed3 100644
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

