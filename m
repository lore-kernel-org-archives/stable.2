Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585FF3AEB26
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195837; cv=none; b=qzotmfjafZ9ssRgcgFtEu3NI3wWtDBC4GXg+I151TRHeTahATwlwvORg4apZrlk6qhJPs/v0b4r3dTNH2zu2ogJQYRiWOhJUgvx5GbcFZ6gJ/YixedleLLfCvy8Eh9XmCIPaSO1EIipyA3q9Ze/mB5GbShKQ2YnwZdYZNqN7WRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195837; c=relaxed/simple;
	bh=SuMCWHNc0O2q+uzuZ75bra8oVxMiLPrJ90t0Swn7bEs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Vj60majdJASUkfAeEjzHJ+8tD+deoAeh8ZOt+PY+h+zIMYEwKprGYdxsaRy9OPHBUfm+0sT7Hju/tGmtdSe4Z3YDqUr4ZabpqGRmjE/SzLSxssnvAvGyrq79SolH+ErUxXU1wCSQ94xozAJhdmXNnk7d3CZtPDR6g8mN1GJbMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T/RMej25; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T/RMej25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693661F0089A;
	Mon,  5 Oct 2026 10:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791195836;
	bh=4qzDEZTQFLvKaEsJ78Y+/MTSvZzOfxN8pbDqYIFFb+o=;
	h=Subject:To:Cc:From:Date;
	b=T/RMej25q2vBLsiHyEvhiCwLswIugaTJ7flGemGaKw4ZvArLlGNF4yCRul1bmSMaJ
	 BwfNgR7Y8aK22QOiL720PERAW4398mPn4kk1YwXfMjYvdkKZ5rcNsQtzfFMLXPQdHm
	 uT38jpLLPpqZNX6YlAVnEJLr9YZAb/L9CaEl2YRM=
Subject: FAILED: patch "[PATCH] arm64: mm: Fix the break-before-make flush range for erratum" failed to apply to 6.18-stable tree
To: parri.andrea@gmail.com,dev.jain@arm.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:23:52 +0200
Message-ID: <2026100552-severity-animate-dbb7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1fef81669147d63eb8c5d3627d54eadc21173a0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100552-severity-animate-dbb7@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1fef81669147d63eb8c5d3627d54eadc21173a0b Mon Sep 17 00:00:00 2001
From: Andrea Parri <parri.andrea@gmail.com>
Date: Wed, 23 Sep 2026 16:36:32 +0200
Subject: [PATCH] arm64: mm: Fix the break-before-make flush range for erratum
 2645198

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

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 79d90226fd5d..d4384131e10d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -2295,7 +2295,7 @@ pte_t modify_prot_start_ptes(struct vm_area_struct *vma, unsigned long addr,
 		 * in cases where cpu is affected with errata #2645198.
 		 */
 		if (pte_accessible(vma->vm_mm, pte) && pte_user_exec(pte))
-			__flush_tlb_range(vma, addr, nr * PAGE_SIZE,
+			__flush_tlb_range(vma, addr, addr + nr * PAGE_SIZE,
 					  PAGE_SIZE, 3, TLBF_NOWALKCACHE);
 	}
 

