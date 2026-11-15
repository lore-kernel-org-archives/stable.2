Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794753830;
	b=UZco8xLwU4R6cVR8YKNPFw/i7oPgG8kfipIZKq36/z7M+utLZa/xmGsD54DgFm7R9pxD
	 uMNci6cTLomYdYF6oML4LkQZ/OlVl3LfBVupYXNZkJxK2uMlQ77N8nYFxGW841ayrCzq0
	 ELm4/J3scCSNPAus07iLXNw1ySMGEoTPNM4g7rx4JF89W3BpQKz4VJNFWhbyEYV3J3olV
	 rtuUb9jojtHQ3sTys+AI91LUBVu8xQxAJank+C8i1ea/JlRKV9cSTsvoSkh7jHBdL9SOv
	 S/3UfdgsTNldaa+XDD9TdRFDS1Mps/9W86btIQQGOXQ0UwVQqxjR2UjckL0KNah5eHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794753830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2GCYpsTag/VY8yMKbJ2aXvL7HmUwewJ+rgMaOJ9EzpA=;
	b=oWURQSZ/F39C2EUW5aneldoIn8hlvojIsqbWDzROJtPkIPAFhbzj4PQxJuS6DeOm8Zes
	 VIDYBrjM9kZWhR17QWGVIH1o5/7lQyp0qna6W93KIaY9AgwUYgpQfq3q/e0AzCTNXe3F6
	 LlGuIWHFzHksY8LWsWs1EyFxm0DY9PZ4lvuQVGhTzxJ9/gpzqF+Q0dhsfLqpOYGTG54Pn
	 NWh7WxIlkh+7zYMjjlFUyvIypMJtZ60y+a1+oEhxVhj6F9NqoW6vvHNLDLnvqwqC6Wd9K
	 gCQdOmWS74UtUmi+UIy6i0tQG9/VFK7GODzT5PqyyUL0ld2Ctq1j7GLhUQPXITVzeCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oH6nGhiJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F009606A31A
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oH6nGhiJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD611F000C4;
	Sun, 15 Nov 2026 14:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794753829;
	bh=2GCYpsTag/VY8yMKbJ2aXvL7HmUwewJ+rgMaOJ9EzpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oH6nGhiJH+wSK1PwaV2sKF81hC3oXw9aYDslyvedSKANKjyvX7moVI0TQiYpgMAV/
	 PfZ04uzp9tZKgd8xnf0mCC4MPTHSXF201U9BMBgwIFIdafcaqwv0ydSqRfiJEH1gwF
	 uRXlU66r3YoZaiGATy8WShyXQTsjQjsSQ8Cy1dz8tKGqzYIvmRDcAYOvPVoGuzaDhi
	 iN8ADCD+1fJyjd1vgFTM982zvTrNKTuDDVkfRmw5jszMWL+vrPg6NcYRmnyHy7RxLi
	 8QATUaPjauUtWsnlpgB196fsbOxAyPssQRPiguI8GBYuogueqk5Qq9q8AAegXXPtwb
	 hUy3Vs8RPZ+7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xfs: add a flag to convert unwritten extents without allocating blocks
Date: Sun, 15 Nov 2026 09:43:47 -0500
Message-ID: <20261115144325.1223466-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202240-failed-5.15-f3ca3498dfe6@kernel.org>
References: <20261109202240-failed-5.15-f3ca3498dfe6@kernel.org>
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
[ sashal: Restricted -ENOSR returns for empty mappings to CONVERT_ONLY requests to preserve existing callers' behavior. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 12 ++++++++++++
 fs/xfs/libxfs/xfs_bmap.h | 10 +++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index b48230f1a3619..80208265dee57 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4355,6 +4355,8 @@ xfs_bmapi_finish(
  * extent state if necessary.  Details behaviour is controlled by the flags
  * parameter.  Only allocates blocks from a single allocation group, to avoid
  * locking problems.
+ * With XFS_BMAPI_CONVERT_ONLY, it stops at a hole or a delalloc extent instead
+ * of allocating blocks, and returns -ENOSR if it stops before mapping anything.
  */
 int
 xfs_bmapi_write(
@@ -4414,6 +4416,8 @@ xfs_bmapi_write(
 	 */
 	ASSERT((flags & (XFS_BMAPI_PREALLOC | XFS_BMAPI_ZERO)) !=
 			(XFS_BMAPI_PREALLOC | XFS_BMAPI_ZERO));
+	ASSERT(!(flags & XFS_BMAPI_CONVERT_ONLY) ||
+	       (flags & XFS_BMAPI_CONVERT));
 
 	if (XFS_IS_CORRUPT(mp, !xfs_ifork_has_extents(ifp)) ||
 	    XFS_TEST_ERROR(false, mp, XFS_ERRTAG_BMAPIFORMAT)) {
@@ -4461,6 +4465,9 @@ xfs_bmapi_write(
 		 * that we found, if any.
 		 */
 		if (need_alloc || wasdelay) {
+			if (flags & XFS_BMAPI_CONVERT_ONLY)
+				break;
+
 			bma.eof = eof;
 			bma.conv = !!(flags & XFS_BMAPI_CONVERT);
 			bma.wasdel = wasdelay;
@@ -4535,6 +4542,11 @@ xfs_bmapi_write(
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
index 67641f669918f..1c234d587c516 100644
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

