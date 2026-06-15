Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8812EEE68
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558020; cv=none; b=Dv9BmZj059/m/RHNXLAp+KVfweK3eKWWgcckMMmMd93O302Lyd95TMkFMdgADOGD+EDTX/8nYSZZGt2TtLSLUOesd8sYrYSMuqFVLD7BPmjE5850qmWw5vkODc1R8I4UH2d4dgtJyjoHcyqcdo5qP59g3hN1Goc/QA5TMFLG9yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558020; c=relaxed/simple;
	bh=VKNxnaRsLFZX8HipbUp84acZs6cSq+REqlkKxek4WJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4JafPmmB377TB3YGyB5dp3SsnUrpKJ0fJiwvPItXNQ0XYX3vdJXsqk7vdfp/NalDeGlm9vEN72ebE8i2rDLg8NlKywe+Ck+JVO8e3abGXky3xEoKuojbFmW7DfOlnzaWi3C7cv8kQk+79FXis8jCWiNIg/P2likoogr+dBeync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJgm4Dxg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJgm4Dxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186CC1F000E9;
	Mon, 15 Jun 2026 21:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781558018;
	bh=LOq+flbfLis4j8w7xIx/ebRahBTuZLivjeOyMQW82Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kJgm4Dxg9wosJe1Aa6dbW2tM3kzXhqMeDFe2c0mn3RnjQTEOAdzkn5Y6u1BzCWHlC
	 RB/6U63BliT7u+nIQjB5b+nyD3zezSeMK4S8gqrutheaCYx7bABfBl9iY4HAq0x1J+
	 p496tiQ2jDVK9yyWq42micT6RicnWf327cBMlSWCoKcOMlP1+Ns4eJxsJFynhO5e6+
	 BP3ofTzx+R/4zw1Rf1SeCHuUY8jPKWc9HZiv+6ccPG5/Md2J0/DnevxwLdqB2AueXd
	 PWR+ExXQlL8U1pKGn1sGhTas/3kpGWszkdXyNVrhbZpXdZ9bnWIomFFedAKUaX2eAw
	 eNy2iQOsLGS0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 1/3] RDMA/umem: fix kernel-doc warnings
Date: Mon, 15 Jun 2026 17:13:34 -0400
Message-ID: <20260615211336.2459359-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061503-brunette-twelve-6cba@gregkh>
References: <2026061503-brunette-twelve-6cba@gregkh>
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
index e426d451b89329..f11275e2cd6f04 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -95,6 +95,7 @@ static inline bool __rdma_umem_block_iter_next(struct ib_block_iter *biter)
 /**
  * rdma_umem_for_each_dma_block - iterate over contiguous DMA blocks of the umem
  * @umem: umem to iterate over
+ * @biter: block iterator variable
  * @pgsz: Page size to split the list into
  *
  * pgsz must be <= PAGE_SIZE or computed by ib_umem_find_best_pgsz(). The
@@ -122,7 +123,7 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
  * ib_umem_find_best_pgoff - Find best HW page size
  *
  * @umem: umem struct
- * @pgsz_bitmap bitmap of HW supported page sizes
+ * @pgsz_bitmap: bitmap of HW supported page sizes
  * @pgoff_bitmask: Mask of bits that can be represented with an offset
  *
  * This is very similar to ib_umem_find_best_pgsz() except instead of accepting
@@ -135,6 +136,9 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
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

