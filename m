Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558672046BA
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569194; cv=none; b=rciNpxN5Kq886co1dkmrjVwyITEMbsgQj7x2qD4qFZ1/Y2p70Td1w6fdLZWVEmtt70VSTnW/mvVK9eCBT2Uj3VMxgwi3g3JfnPQ0Vq3bCdIQaEbyPl32OExPo8Htd3CXJEXmCi9nkRO4Vcd37j8V6WK9dN7iEcA/yf8JIvixfDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569194; c=relaxed/simple;
	bh=hdOA6lCIKuE2WuAIRdVYonUn1JQn3aSzNYqnfzz7BlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDQiNFuGrO98DBUIxw27DsLzB9GdRuIhucQk3NwkZaQ3+5e9AUB9Ggag72ZE5s6keXkPh7ePDrYXj8bY2drG8o5aF26VnyM4FVw/HIxCmLUc0SZU4tjXujgHtby2glZAtb03B7UBdh4BesO71O5gMa/jv68I5MiUsgI6WMi2UCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWHHho+7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWHHho+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC341F000E9;
	Tue, 16 Jun 2026 00:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781569192;
	bh=xb+KA31RS8b4riYY+6qbj0+Km82UKqzDD+KdrYjYeu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kWHHho+7oNbSm8I2F4q1gm6H+RAKlaCc2imr5Lmmr/9IrwYRG8F2pQ4PgI21NtjqC
	 gHZFGLB7oN6NKa10jPe4td1l7kC5sdz8gnoy7TXAVJl8stc2PXuLYzhE5wuE5Y/aKj
	 uAfn2LysIemrLymvVMdCPV8dzdgD++Oq65EX0SeU5dKn2Gc1bCzLsgHs6ABvTSTv/F
	 EtUNxxsEfwdYnTx2k5UrgNd5yiRIalIfjSf1PrdUmXM1QnpbceWHiHB7eBf9nuOuvy
	 gF0HVfXgV0ZDtrFJJttQVaEOnDIwUWY2NMxU4L6nHl7DsiZLbBkZj6cMd4/iiW2k9G
	 zbbjDFCY2UUjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] RDMA/umem: fix kernel-doc warnings
Date: Mon, 15 Jun 2026 20:19:48 -0400
Message-ID: <20260616001950.2587230-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061510-undamaged-opulently-daf3@gregkh>
References: <2026061510-undamaged-opulently-daf3@gregkh>
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
index 77b83ea62dd69f..a18ece7d59a861 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -90,6 +90,7 @@ static inline bool __rdma_umem_block_iter_next(struct ib_block_iter *biter)
 /**
  * rdma_umem_for_each_dma_block - iterate over contiguous DMA blocks of the umem
  * @umem: umem to iterate over
+ * @biter: block iterator variable
  * @pgsz: Page size to split the list into
  *
  * pgsz must be <= PAGE_SIZE or computed by ib_umem_find_best_pgsz(). The
@@ -117,7 +118,7 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
  * ib_umem_find_best_pgoff - Find best HW page size
  *
  * @umem: umem struct
- * @pgsz_bitmap bitmap of HW supported page sizes
+ * @pgsz_bitmap: bitmap of HW supported page sizes
  * @pgoff_bitmask: Mask of bits that can be represented with an offset
  *
  * This is very similar to ib_umem_find_best_pgsz() except instead of accepting
@@ -130,6 +131,9 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
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

