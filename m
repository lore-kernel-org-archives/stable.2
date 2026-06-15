Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC1C382291
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558951; cv=none; b=VN7urzXE7FhLI2UMslaIMDHZWRBQZPizsPhsx61UinuMeG8VZu8Z/EFnsIUoG2NQ2bziMjwUbK7KBDAD9oQ0weubZ03jmOzhjWizj1+vvorE2GZUS7KctyP7Ym8RbGU1jV/IViOnIclGWajkKtDa1udcgOamF3wAgUIGZq6BQX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558951; c=relaxed/simple;
	bh=BVtQSTbZn9qQeiD9coQMOmRjYT1CZAmryXniwgObwjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfDs4B2wfWtQ2CJ3ov3SAikbsNatce/mNwnudNBOF1CAT3WHa1wSonBByyJlFgOj+y5L0a/ly2MknbgEHlhmqSgzZCdcUZF3asUf/k+IzG+hKnZ04o81fxBZX45E5q2xcp8drbPbZv589TpFNvrvP85b2aCGefA6r5x9DV5/8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbZaYvpo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbZaYvpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D2C1F000E9;
	Mon, 15 Jun 2026 21:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781558950;
	bh=EFThBJyyuUgbznb+7mRryU2JzT3KXzCNZAADHjmG5NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JbZaYvpo6x5vEMrtM8sBtHzx9yVcJLeic6yi+Xl7psPi5gZTHtgQr7trGR+Y79Sgt
	 CAtfx4LUP5Cihc9pBr1H4tfVYEYYTIFUF8uegpvHBy1ANuMup+Ejn4yfInq2S7UT1j
	 Y4bH95OM5smA1TL58G09LmGIrOsEXSQ8JO+fSEdZ4mfKDX8AE54qg+k/P16H+E0+VK
	 /1dynOVxope4/zPFt50aDj+0dkiVo8JZFCORgswCYghvivGIaXE5g0I9/8dY+sLzB6
	 CBj3NU10N1oqlS5rY0lhA2tGidvpp+0RtKHtZn6B1GvNlJKI387wrWEeKGVOsI+x7v
	 vbH5+KN+7jJfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] RDMA/umem: fix kernel-doc warnings
Date: Mon, 15 Jun 2026 17:29:06 -0400
Message-ID: <20260615212908.2473687-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061505-frayed-clergyman-65f9@gregkh>
References: <2026061505-frayed-clergyman-65f9@gregkh>
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
index 0a8e092c0ea878..09b7f7d4685ed8 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -94,6 +94,7 @@ static inline bool __rdma_umem_block_iter_next(struct ib_block_iter *biter)
 /**
  * rdma_umem_for_each_dma_block - iterate over contiguous DMA blocks of the umem
  * @umem: umem to iterate over
+ * @biter: block iterator variable
  * @pgsz: Page size to split the list into
  *
  * pgsz must be <= PAGE_SIZE or computed by ib_umem_find_best_pgsz(). The
@@ -121,7 +122,7 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
  * ib_umem_find_best_pgoff - Find best HW page size
  *
  * @umem: umem struct
- * @pgsz_bitmap bitmap of HW supported page sizes
+ * @pgsz_bitmap: bitmap of HW supported page sizes
  * @pgoff_bitmask: Mask of bits that can be represented with an offset
  *
  * This is very similar to ib_umem_find_best_pgsz() except instead of accepting
@@ -134,6 +135,9 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
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

