Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992CC1465B4
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 00:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780274660; cv=none; b=Qr54OrjIg6cmoKumHgCGn7YFKcEu+gpYwsr0TPYL9WuNW9fqhuP4J6qjKXcBqGok1rY0B2ckq7/IpprEjogkmk3IiWzMxfOwsxgNNhSua1Glww7bMTeaE7gUXiKGfgKS/iLrcegqFZSU4135lYkKSx83fTMFw2bpTGxy+F4+gsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780274660; c=relaxed/simple;
	bh=MB9u9jjLsohfYVPymqmHma+qjODr9B1H4UcJR6k+KBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFKW7uG31t8s+ZFsdGdp9Vlf98YhqIKCb6/0QLKBksJJvSPtcHZfOUtW6dHLswqKVWFBp9bg0mY1XIDB0WACSFERjQpt9oBtrat+1mfG3AcjfavSoC2o+Apgf0pW7GhxxcfNcbNm7vaRtYIZhNaaNOM39qh5DCn30Dm5JbZnOgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsQ0qtBz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsQ0qtBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9971F00893;
	Mon,  1 Jun 2026 00:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780274659;
	bh=Lz1UC4afwI6xbTP+Q1mOuhJIW7et4efxhRwj7TMQAIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GsQ0qtBzk7SoNTBowC2Y57PMzY0wZRdu18NoNmz5MqIZArKZQ90LjbZMswYpcwLmV
	 ZrbOsaEbl7qBdim4o/03EIHS0KQbWDS9fDoGAWDRyfM9BwZ4RsN36ogxRvrsABlBs9
	 ylnl8znoJOUHhN2eOzd5ULz1fR4Yv0OYnibOhTlY3SW5MKFlLw8oZc/rNsDo6ydljE
	 hEOQ0gLUkwemaZHjniC6HIjiv7O0/b2YUsF0Rh5vVtm/a1k7LmxglTrSiodm7C6zJs
	 uOhnMSFa/78NCmUnW41gmDLnREsAD052LtcMGnRPDO38qJ+PuVAMaXNhsEOOqK2XdG
	 jr3CF78tnQhYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zeng Heng <zengheng4@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] arm64: tlb: Flush walk cache when unsharing PMD tables
Date: Sun, 31 May 2026 20:44:17 -0400
Message-ID: <20260601004417.90834-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052833-matter-helmet-c510@gregkh>
References: <2026052833-matter-helmet-c510@gregkh>
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
index a947c6e784ed2..d29a3b842b105 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -58,7 +58,7 @@ static inline int tlb_get_level(struct mmu_gather *tlb)
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	struct vm_area_struct vma = TLB_FLUSH_VMA(tlb->mm, 0);
-	bool last_level = !tlb->freed_tables;
+	bool last_level = !(tlb->freed_tables || tlb->unshared_tables);
 	unsigned long stride = tlb_get_unmap_size(tlb);
 	int tlb_level = tlb_get_level(tlb);
 
-- 
2.53.0

