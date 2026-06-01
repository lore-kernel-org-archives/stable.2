Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCEB41C6A
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 01:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780276316; cv=none; b=KzNbvqrQtHInVKKI4YPnJJQEouKdZUzQN4TZHDdHCmnoPZfs6oMb2m0kmZAiMaMyG6yYcvtDsHhTKMpwujQB8Ur33fpf1DQMVuzsf5xnphYPATChc4RKbfpL7RK02oq9qwL/baKknbeWh14oga/qK53M8qEi9quNoyPPcWnW2iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780276316; c=relaxed/simple;
	bh=udRDF6zeiGkU5umSayP5uorMCFVseskk2kqNEmW5zpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D92/IAlqB6ucLU6lfbuntHB9Lrc5urOnMFkxC6SZv2KX16kwo6B/Q/RdBVVOCKBxOwvZO/3/y9YNINAm1Sd5PBUlcufDFuFp27wEuVk/tmLKGyMPIQhITcm0UQe0v+hOcKq+wFAs2hj7l4ohssaFuHU0mvc+zNZmT+0KOcwW/M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JW1I/KUu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JW1I/KUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F80B1F00893;
	Mon,  1 Jun 2026 01:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780276315;
	bh=KO2RAXo3WUG9VMi5tHyfSUjk9hjT1G2iDXSFXtS37+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JW1I/KUuFoNafxGvTx6s8PbBdUxs1LAUQFWd1J8u54Hwh5nm6FkU4w3UIiJnfm/Fb
	 vdOKWGwZ4voO0GFpvxvc/B7xzsnffgDQGLICP45WEXR2QK6eEKLLZQzo5F6GmMFD2g
	 HywYdUcyWuNDm8/TtcKX1bFxgn7MyZtSaud4xCRJYUFZtCD0UxIDLTH/Ect91wqYOH
	 OEhhmLWEJie9blAhpcLIxkdpdNlVEBBYQOf7v8TUNL+8gfcWqH2OdD6aOvtROJ1ibS
	 bYdIlnZufLuYF4cqTXGfn/WmoAPENGdDUsVATnUWV9e5AxuRFJ7LMq/7zsHTRkE7z2
	 6649g4XlOqxSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zeng Heng <zengheng4@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] arm64: tlb: Flush walk cache when unsharing PMD tables
Date: Sun, 31 May 2026 21:11:52 -0400
Message-ID: <20260601011152.135244-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052835-overpass-idealness-fdef@gregkh>
References: <2026052835-overpass-idealness-fdef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zeng Heng <zengheng4@huawei.com>

[ Upstream commit c2ff4764e03e7a8d758352f4aceb8fe1be6ac971 ]

When huge_pmd_unshare() is called to unshare a PMD table, the
tlb_unshare_pmd_ptdesc() function sets tlb->unshared_tables=true
but the aarch64 tlb_flush() only checked tlb->freed_tables to
determine whether to use TLBF_NONE (vae1is, invalidates walk
cache) or TLBF_NOWALKCACHE (vale1is, leaf-only).

This caused the stale PMD page table entry to remain in the walk cache
after unshare, potentially leading to incorrect page table walks.

Fix by including unshared_tables in the check, so that when
unsharing tables, TLBF_NONE is used and the walk cache is properly
invalidated.

Here is the detailed distinction between vae1is and vale1is:

| Instruction Combination  | Actual Invalidation Scope                         |
| ------------------------ | --------------------------------------------------|
| `VAE1IS`  + TTL=`0`      | All entries at all levels (full invalidation)     |
| `VAE1IS`  + TTL=`2` (L2) | Non-leaf at Level 0/1 + leaf at Level 2           |
| `VALE1IS` + TTL=`0`      | Leaf entries at all levels (non-leaf not cleared) |
| `VALE1IS` + TTL=`2` (L2) | Leaf entry at Level 2 only                        |

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
Cc: <stable@vger.kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/tlb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index c995d1f4594f6..cd6997187104d 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -53,7 +53,7 @@ static inline int tlb_get_level(struct mmu_gather *tlb)
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	struct vm_area_struct vma = TLB_FLUSH_VMA(tlb->mm, 0);
-	bool last_level = !tlb->freed_tables;
+	bool last_level = !(tlb->freed_tables || tlb->unshared_tables);
 	unsigned long stride = tlb_get_unmap_size(tlb);
 	int tlb_level = tlb_get_level(tlb);
 
-- 
2.53.0

