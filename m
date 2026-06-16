Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45C305E1F
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572061; cv=none; b=NHpGMqgDRZ74JJx9TdbWpLMwH/umeBzAy9+Yjiv66B6XLdywhr5CxIPw6YMT/rFZn4i8KcqEi5r5XN3ZimZezoYd5X95f0KIYGcNR6UeutUtAMd+5zzda3bKm43PVD/g4/Db/3Dpj8CFBZfrbsULHg8HFCOAl8Lcj7GO/cCnwGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572061; c=relaxed/simple;
	bh=pGOtwic0cl/R3mVv7XfNbH/65NXOf4x9lKML2K5BMu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuAH8/gp49WQwl08UwTIup/HOPZ0L3jjE4PeuJRzSKbf7bswUHH8pFx6OlWPicaQnRptQ0rI2Q0yl45a6ou1wxSJES0LnAIrLTkk3BnQLxYHgpNMNSHKUj7ejTn8YyJNtuCaMAXL06E0Q2PmL2m5PackbKo/DtN/cfAoevI4Xow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EM5vP3jF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EM5vP3jF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9C01F000E9;
	Tue, 16 Jun 2026 01:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781572060;
	bh=2NmJnvGDfWIAfLBMoJqDKegQiVRj5XZHes0J56KRBEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EM5vP3jFmGHoLJ2UnZENRLghPnKP+mks0y3h7xwKM3hXvwnZLa0GabwHJ98N8OoQr
	 q7J+PZB3sHkvC83ahRZGIBp0PLZ63asQ3Kx3QZk+GqFeH5Td7kQaaS12N/JVRJmczO
	 LE/8JdrxB0RYRRiENw8n7JXgkmZ4tvSVK3lCfNrm7NG+Kzk6uSkTWGDnODaW19vkid
	 PAud/HyYIATO/wNqbn8tOO70BvsEbg4Jc4lrx7sS8C5fMmS9SvzzM8a9xA0dQwp3rM
	 bS0StuBHVrlcVH6Gqsy5MmgtpqDnmK1AEd0o896Bvjz6Gz9sJpS9gTSDvnZfh8RhWl
	 8vrNgAuKR55ZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] RDMA/umem: fix kernel-doc warnings
Date: Mon, 15 Jun 2026 21:07:36 -0400
Message-ID: <20260616010738.2640782-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061511-anchor-wriggly-5b25@gregkh>
References: <2026061511-anchor-wriggly-5b25@gregkh>
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
index 2381e482fab346..424c86d8601a9c 100644
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

