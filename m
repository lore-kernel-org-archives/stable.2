Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA5C1F8691
	for <stable@vger.kernel.org>; Sun, 31 May 2026 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780187038; cv=none; b=gUDgvvqMhIQcxlO3lfmvHTgPuCUmMdiiDYFGAlCmRmV0aAGNZIc+90ZPC7v99orgNSLn0ZWNXM9fDQtL2WVFbWsyEUsL8AQT1qdgBbAHWeot1kkAfreJYDdcMBZacOZYb1i55nCUBIAOyR3GEpy1yJrL4MuW5uJTUkgkplcn12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780187038; c=relaxed/simple;
	bh=ZYudhCCjaYxEfzORu3Vdq4+rPczRgH+7D3f0GFTxNKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6sUQI90TOdli8SwCFmHUyIHSSvlFo8Q09ds7+3BuPyfqhhshAahK8Ts2uyHttnzBsJ6oWU7XcLjKanh6YU4DsGceOxnkwqEtFe0gYGnKktCXEVKRGfunUCzY8KbGjW9tFroUjpolK/ObtQNpqfz0ulH5ha6bcP8vEbAfGZCKro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ah6B7tVz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ah6B7tVz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D661F00893;
	Sun, 31 May 2026 00:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780187037;
	bh=UVsuE+3+HQ7LKlksRFBf+SrA82HSzQ36XJw/h/pehLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ah6B7tVznHlEoOVjZnbN8qeClmCxFIyT00zj90RfEhqfs+WHWwr4lw56NZVasoDPv
	 xqP8Bx4qRg8/xm479dF2PR8soPD59f6NjUI45JwUnUsavFc919UgH+Ug6EGMqQTt1f
	 /lena0v34a5Y1TRayOsWCNhth0gnABFlvhuRE4bArGxkwDTIrTJg004u6K3lHoP2k0
	 fC2u93hnwao1qzCff5xQQG7AfHa8b2iAnZkzjKr5nPYNFjgByuIZgByV4v7Fpl6pwd
	 zi94YswbdYcsp7ry4oLeDnv4WuvsYammKrF+gBWIIy89we9k7q9k91dwBuqyr9dMZZ
	 wlJq5b8CbEVnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zeng Heng <zengheng4@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y] arm64: tlb: Flush walk cache when unsharing PMD tables
Date: Sat, 30 May 2026 20:23:54 -0400
Message-ID: <20260531002354.3659423-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052831-stammer-jaws-339f@gregkh>
References: <2026052831-stammer-jaws-339f@gregkh>
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
index 8d762607285cc..b3b863c919fea 100644
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

