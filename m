Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473CF428841;
	Sat,  3 Oct 2026 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791032214; cv=none; b=UNe0PzAbOzOdhOadFRp/ayWsdzWn9bvf1PY5ZcfnDs0m4IMKRCZqGiNP16WjzEdzdqjxze/Q5VApBy1iX3SQ1OATfxDEfiDnPCX5NY4p5T0xi5PRUhx8+rFdG3WWr6ZWRxuNWlBv1euaZRWSPV8PjDPUEMBXUwgnetXF7GOa8j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791032214; c=relaxed/simple;
	bh=p9KBndfJifaFFuhOMcXL1zzOi47/U7Is+z4v8jXQSs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLxTk8pAd1JEdhlHMm84gbp1+tP2eK9RgYM6uhhMkjH86yPIS9PDy9+WgUgiv0LUigUTSCPW/tpzKxQ2av7JQvZiDQ+GUhri/VTilXXYdTRJABnTf5e87bdZ9W5vsUYptAqLL4xPaltN7LJwVY2Bj79kzVFTqTgK52IMdmXrA9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=R/x/1CfW; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="R/x/1CfW"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791032204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrDqGEDFS9PJUruoqe7wYb6mREdg1nvyru7UqXae+/0=;
	b=R/x/1CfWJGFK8/Cpv0SHV2/QljsJG+fz0l10KNZKI2irNJ4wAcNNyBEtlufW1cKoU5QInj
	Fz405Mif9gwapsvzTh2xzKI/+TTQEdBdDP0yWt7KqzY91g4kQwXsdvmsDC+VDd92Bj9MlI
	gn+gydvXHcboEQJLSckDghuTt3NUAus=
To: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] sparc64: provide ptep_set_access_flags()
Date: Sat,  3 Oct 2026 14:56:23 +0200
Message-ID: <20261003125627.3419702-2-stian@itx.no>
In-Reply-To: <20261003125627.3419702-1-stian@itx.no>
References: <20261003125627.3419702-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic ptep_set_access_flags() calls set_pte_at() and then
flush_tlb_fix_spurious_fault().  On sparc64 set_pte_at() already flushes
the TSB entry and demaps the page on every CPU of the mm when the old PTE
was accessible, and when it was not (a PTE made old by clearing
_PAGE_VALID) the translation itself did not change, so there is nothing
to flush.

The next patch turns flush_tlb_fix_spurious_fault() from a no-op into
that same flush.  Without this patch it would then run twice, including
the cross call to every CPU in mm_cpumask(), on every first write to a
clean page.  Provide an arch version without the second flush.

Cc: stable@vger.kernel.org
Link: https://github.com/sparclinux/issues/issues/108
Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/include/asm/pgtable_64.h    |   3 +++
 arch/sparc/mm/tlb.c                    |  10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -971,6 +971,9 @@
 void mmu_info(struct seq_file *);
 
 struct vm_area_struct;
+#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
+			  pte_t *ptep, pte_t entry, int dirty);
 void update_mmu_cache_range(struct vm_fault *, struct vm_area_struct *,
 		unsigned long addr, pte_t *ptep, unsigned int nr);
 #define update_mmu_cache(vma, addr, ptep) \
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -22,6 +22,16 @@
 
 static DEFINE_PER_CPU(struct tlb_batch, tlb_batch);
 
+int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
+			  pte_t *ptep, pte_t entry, int dirty)
+{
+	int changed = !pte_same(ptep_get(ptep), entry);
+
+	if (changed)
+		set_pte_at(vma->vm_mm, address, ptep, entry);
+	return changed;
+}
+
 void flush_tlb_pending(void)
 {
 	struct tlb_batch *tb = &get_cpu_var(tlb_batch);
