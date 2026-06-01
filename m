Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20AA72621
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 00:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780275182; cv=none; b=XYO1i4y7/KgxH4vvL5YkxtBLwK4sQChv4E8m8f0I8KJYKV81uFrj55ngw5Faw58SKwFXJ3ijxFt2JOEKIZewHgW/YSODcFu/qq3d4C4kzst0opbBlw1/710ic7e5eRBOxTBgYsFPr/dSXvxCLs4rwEclPEicjEGMeXV1qx4f9kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780275182; c=relaxed/simple;
	bh=T/ChJ/0Mfu7oVLu3/rQ3gr7MxZ4wRZ0Ujw08lxle8Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XERIYDeN0BuPz/udqhhNWpAR7wo31CUbh5IZQURt8SpbkI1bqNQBYFdFMt99tQP+L6KthLwBNNI69PR7oo21wIoeCQwdJChlguWisWrnX3EC5cEY+2rbePAeq2b1Um6t4yLyNbRdF7GLeVbdHyvb2Ekk3WfM3cTPQpjgaR6ra3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idlxLpzu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idlxLpzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7E31F00893;
	Mon,  1 Jun 2026 00:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780275181;
	bh=PU1syLbz1ubwprfBzNPm/gY/FrveEetqCvs8Ks2Ib/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=idlxLpzuE6CBQAqOdIszNKXe5MWpHkg9g8fQuioasd5/NFXZsVqCybNzgTvmGQYQx
	 Mt63347nNrRjJYBkkpeEH8mImIwWawCEPg5mGF8ftgCPKoATTAf7VBABchBvAmvVRJ
	 fXVY8gnxW/X8IHNvSla1KGMc8fyum+SLVJ8tqaARXmORV26+HO4+ASkUkr9l4X6LaP
	 nkd9HJW+dikMiwHyDoBF7nH0Y60QdOJDlTxt1AKWGCLh/e2V401AKiJVNVBOLx5KKc
	 laXVFNpVyHEltgxiQzuFYilA1rfw3xx+p/jahnNXGE1kKrEo+KO73wi4sOt3X6c6f0
	 MetrFIP7nQTkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zeng Heng <zengheng4@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] arm64: tlb: Flush walk cache when unsharing PMD tables
Date: Sun, 31 May 2026 20:52:59 -0400
Message-ID: <20260601005259.101534-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052834-supernova-parched-15c8@gregkh>
References: <2026052834-supernova-parched-15c8@gregkh>
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
index 2c29239d05c3e..a1528bdd1f38b 100644
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

