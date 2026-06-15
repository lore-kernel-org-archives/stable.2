Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EFB36A373
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567932; cv=none; b=reNZ3LguKVx/WRD+XQJSv1FwITeaQEhZPmpJpL1qC9nwvgIvBNyT8JvkCE5TVwLCgqrKPkCY3ii9fd0rRlnVvAfTzGs0cnOmbGgLTnsKwrAHBZB4a9Lg89oOIYUAIxHUwUX0CZVEGPRr62niml2NEEbn/llIQKWSvPL6YiRGQf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567932; c=relaxed/simple;
	bh=H8MmZnleVXladOY9nVYx3Xyf6r23IflLN3SX3KF++/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoFcIOZY9vD5X+q3B+OWz/hzOoAy50agQT44/FgHIoTltpTeOpaLFGTi3kPRMzVQ09Ow1+9M1qldYps8khGsb8qFZIP9AdChcdiGr+Bl5u8yLRqA120CaTNDr8ttGIfPH2nsK9ysZprSMdFtn8cscUs29N4UviaEGPbRQmgKh5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nggqKwJ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nggqKwJ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7241F000E9;
	Mon, 15 Jun 2026 23:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781567930;
	bh=zdvTmUoY4RdAjtYgzIemCuyRj97zeirSzFgf+Zj9mA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nggqKwJ94YGlGNafuBI4XN7XsWd4vteflVO7ZseWx1+iAzducVFqGTdz5/RtIipdi
	 xGIJlYFh2huJ3f4G0Gdr6Jr83g3gb6VabQc2AnukRH25UL8QJlpIecrD9eTJy3PqKH
	 ATFFMKhxqZy2x54bqBAJmJUMqK4H/nvALWBJC0pcVTLh7vfkLMVpApXx2vjZfZSDtV
	 tH2RA1lAukNU6xsKU3VH49zynRSqLqhTef+khTBcOFkquCtp9L5fD9iBr+ebWkjpqN
	 nj7mLzob7/NbKGir0NXt2NsuuiH/369TQqHDyAw4G6ODHnm0cO9gkNmSImtE75kvSm
	 CP9XSAcwF2/Bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] RDMA/umem: fix kernel-doc warnings
Date: Mon, 15 Jun 2026 19:58:46 -0400
Message-ID: <20260615235848.2562462-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061508-amuck-winner-adaf@gregkh>
References: <2026061508-amuck-winner-adaf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit ff46d1392750444fab5ae5a0194764ffdc4ac0d2 ]

Add or correct kernel-doc comments to eliminate warnings:

Warning: include/rdma/ib_umem.h:104 function parameter 'biter' not
 described in 'rdma_umem_for_each_dma_block'
Warning: include/rdma/ib_umem.h:140 function parameter 'pgsz_bitmap' not
 described in 'ib_umem_find_best_pgoff'
Warning: include/rdma/ib_umem.h:141 No description found for return
 value of 'ib_umem_find_best_pgoff'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://patch.msgid.link/20260224003120.3173892-1-rdunlap@infradead.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: 15fe76e23615 ("RDMA/umem: Fix truncation for block sizes >= 4G")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/rdma/ib_umem.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 565a850445414d..d64b42ffd04b32 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -89,6 +89,7 @@ static inline bool __rdma_umem_block_iter_next(struct ib_block_iter *biter)
 /**
  * rdma_umem_for_each_dma_block - iterate over contiguous DMA blocks of the umem
  * @umem: umem to iterate over
+ * @biter: block iterator variable
  * @pgsz: Page size to split the list into
  *
  * pgsz must be <= PAGE_SIZE or computed by ib_umem_find_best_pgsz(). The
@@ -116,7 +117,7 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
  * ib_umem_find_best_pgoff - Find best HW page size
  *
  * @umem: umem struct
- * @pgsz_bitmap bitmap of HW supported page sizes
+ * @pgsz_bitmap: bitmap of HW supported page sizes
  * @pgoff_bitmask: Mask of bits that can be represented with an offset
  *
  * This is very similar to ib_umem_find_best_pgsz() except instead of accepting
@@ -129,6 +130,9 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
  *
  * If the pgoff_bitmask requires either alignment in the low bit or an
  * unavailable page size for the high bits, this function returns 0.
+ *
+ * Returns: best HW page size for the parameters or 0 if none available
+ *   for the given parameters.
  */
 static inline unsigned long ib_umem_find_best_pgoff(struct ib_umem *umem,
 						    unsigned long pgsz_bitmap,
-- 
2.53.0

