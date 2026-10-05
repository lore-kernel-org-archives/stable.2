Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA253A1693
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791238619; cv=none; b=ANaWBQqSMJffJAryOX6VZ6EX/N/XGWtb5pDT9qwmQtn/JF6zvGN0TIEnLMEnl/Sw9K/9ijgfNc1MN+9aOcRdr3WGEUAeLHlnlaHr4OOFF4cGexhnxf3uJaC49Mph6FvomUme8l01RTu9Siv5Ij+OobLyDH3nUaPFJvfue7EQmr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791238619; c=relaxed/simple;
	bh=SB2MGnZnKalAuAJJyHqZXrrjL5/TPtmctY2c8+pbRdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fwd8DEoKCHw/nEDip2I6cvHRVLjJ5iq9h1LzcLkru75z03bd8AfVHXfpneL4oh7OYXzOCv6CTkAlkxmpldoLRkumOaiXlYhS1g8uMFIe6l2P9urpRYRiacysHgIJT9oL3HaHIIAtCE9P7lbf4o2SW15rBzPV8QYaY45ri8RFrRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLZ7JaPr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLZ7JaPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6AB1F00893;
	Mon,  5 Oct 2026 22:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791238617;
	bh=Al0j51QZGSMSI9Zf6iBe7gxtfeGwO2PwZ2DVuVJCQKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jLZ7JaPrtF47/Hz4ypiq0b+V0Rue5t0S6F0ZVbVIXYLCdh2hBlJV8ImvBp263APir
	 wZifseD2HuDmPv+ZJZBvrYDx5egVaczL82/4Uaan1QiSG1i62bmM54X5BSwTY0yidN
	 vTq7qh2Ue9/p10XrU04cEOonjKCc5VbaN4OMlTIz6lxFK+rT3atdaW32DUef8/bccD
	 NBSDOmiE6tA9iiVxQrHunVI2g1kzse2Myfss8yd5WjmsZZ7WDJr+OiSdFzCfuuW3rx
	 Xxyk0j9slqeYdSdFxnwm4DRPgapL26AdXi+5vFrDTYf7qDkoMolF4jWUHWwVBNYX6v
	 NUQL2cuL0TXjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] arm64: mm: Fix the break-before-make flush range for erratum 2645198
Date: Mon,  5 Oct 2026 18:16:53 -0400
Message-ID: <20261005221633.3438428-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100552-severity-animate-dbb7@gregkh>
References: <2026100552-severity-animate-dbb7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrea Parri <parri.andrea@gmail.com>

[ Upstream commit 1fef81669147d63eb8c5d3627d54eadc21173a0b ]

modify_prot_start_ptes() performs the break-before-make TLB invalidation
required by erratum 2645198 with __flush_tlb_range(), whose third
argument is the end address of the range.  It passes nr * PAGE_SIZE
instead of addr + nr * PAGE_SIZE, so __do_flush_tlb_range() computes the
page count as (nr * PAGE_SIZE - addr) >> PAGE_SHIFT.

For addr > nr * PAGE_SIZE that subtraction underflows, the page count
exceeds the batching limit and the flush degenerates to flush_tlb_mm(),
so a single-page mprotect broadcasts an ASID-wide invalidation and a
full-range mmu notifier call.

For addr <= nr * PAGE_SIZE only [addr, nr * PAGE_SIZE) is invalidated,
and when the cleared batch starts below nr * PAGE_SIZE the tail is left
in the TLB.  The workaround then no longer covers the whole batch, and
for addr == nr * PAGE_SIZE the flush is empty.

On affected Cortex-A715 CPUs, this can corrupt ESR_ELx and FAR_ELx on the
next instruction abort caused by a permission fault.

Pass addr + nr * PAGE_SIZE as the end address.

Fixes: 7efa1cd5f89b5 ("arm64: add batched versions of ptep_modify_prot_start/commit")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
[ sashal: Adapted __flush_tlb_range() arguments from PAGE_SIZE, 3, TLBF_NOWALKCACHE to PAGE_SIZE, true, 3. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a4503910afb8b..71841b5c31928 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -2150,7 +2150,7 @@ pte_t modify_prot_start_ptes(struct vm_area_struct *vma, unsigned long addr,
 		 * in cases where cpu is affected with errata #2645198.
 		 */
 		if (pte_accessible(vma->vm_mm, pte) && pte_user_exec(pte))
-			__flush_tlb_range(vma, addr, nr * PAGE_SIZE,
+			__flush_tlb_range(vma, addr, addr + nr * PAGE_SIZE,
 					  PAGE_SIZE, true, 3);
 	}
 
-- 
2.53.0

