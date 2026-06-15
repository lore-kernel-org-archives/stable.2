Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5B73B9D9A
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563938; cv=none; b=kOmBlC/CQLLfwVaGsRyQfvuTCbq6XExNye+tXco+fdZlU+PH2vl5txiw9MHALfPCH8uDmARu31qUwGzYevwr9y5/DOyK5KvD+rQCL1BXGxcGcbE03piNDm0mbKZ7HZZq4rZ/TBjETyWnMNts9t10wmVYyUBlgZT1zPIV3/RgSrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563938; c=relaxed/simple;
	bh=7qS9zWkwxQpz0Ms4u1RgKh5mhS4m9tzjoZVasw3qUvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fi2usDoyMjdxAl/kS1Oo12cDy/26Gk+EWoyw0LojTZ+MydN2sU0AhmoFD7anSZKhD5mHzeJ0Xxj+HlrzS2Q6OZCVZ1vxiiWlnOAlofqz3nmaIMXg4HEWC4hBXA9fuCEEw83fQVithrFE2XiPan27ZaZS5P1zibet4teAwySypMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+IWaDXQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+IWaDXQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C998D1F000E9;
	Mon, 15 Jun 2026 22:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781563937;
	bh=549ZOjlvgk8hsNoEM/23/QTpAIPc+86GqFzek8T7pCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a+IWaDXQBDi9OmpuJbxcO/JD+I56nQht6m2846/01kaGcZE5rcSbASpFm2e6ZOOhN
	 e2bIyq2lgIRZl1/0+3drGo8i8WhnOY1zXgj2sNF1wmDnGvXz0n43R2Zy8D7nWNX377
	 zJIvYAXbG/MqMc1dveYcwKyNqBzFiZ18VNPC7wK5cTTSXxXSg9JiM9Lnyo2M6YIf5n
	 A60+kTFhiZVq42wmA1jHEYZ6UsVfcpFZ8GojSa3swovb9nMk2ZziI02MDt0esPrMXL
	 Jg9ALjb5C/5MdvblsD7Pie35YuAvS5FNe2bWUt6GT4jF/1Gjn5Fv09R74rNG9+WGQ/
	 Ll/7Q4oCs7a6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] RDMA/umem: fix kernel-doc warnings
Date: Mon, 15 Jun 2026 18:52:13 -0400
Message-ID: <20260615225215.2520173-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061506-unfiled-breeder-73e4@gregkh>
References: <2026061506-unfiled-breeder-73e4@gregkh>
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
index 7dc7b1cc71b5ab..305214754ef449 100644
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

