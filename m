Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCA33B813C;
	Thu, 13 Aug 2026 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611744; cv=none; b=oMm9GxUAjAnvezYeQV2tylEpM7yOnywHK/1KldJREZoxcM25ChWL3iR3fImgROMUjsVrtvlunriKh1CXdNMPmztIQH42IeVZNXxNYZwVhPDdzXFzY7o7QlxQzaWWW4rqYdQE4DFYpOgw16AWaubUS52MjICMDIjiuGfp8F+GivM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611744; c=relaxed/simple;
	bh=10CIl+Hb8vhPX9MjJbLKvl8gjfb6BmZT4g3+HIsWfkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dVkUGEZyrBDrdO9o8se8rywXlYgrTE2V6OEy8gZEAXJL/kGKYiwvU48+1+waNlelVO7JL3aG16pfLkg9U4slSFCRtGOEqwU+i8feFrbYRoVlvVtuzY1LnYjSlr/tG5LXZvAqCh0knARnfHAIsqmGxf0zz4XIZKuib0rNDavQAEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cq9h/biY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cq9h/biY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3E31F00A3A;
	Thu, 13 Aug 2026 09:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786611740;
	bh=itFc+ei9wQ2AisPFkcdPDGQXQgvzV1zw/qg30HEZpkg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Cq9h/biYez7ZDggx1XDAyzOQtOqE3YYHzs46iGAd2rMJH+kJ6f4CsQzyDIQEKlHLL
	 qqxDLE7ZdCbpGYdokBQR6rehGnNDLU/HD1bmmhBJ17QiPWej9urwhBlftexAsFFhNP
	 PxXyIg49vQ57AlcYJtxGOs8kCJt53ADPmY/AJJpdxs3R2tElKhI2feDZARQdhtIplK
	 AYOxBo7dxrdwdhdm8Ro90htp3Ie1zkYOjil7DSKlZ4RVfOKZOPNFIQPSft63kM5oMz
	 7kpA6swRbGH4Z7d8HV8uBp67PYWfhkhbp5LPncNJO09xCKi6mIJNbMm6VDrVcuHja6
	 QWXfeu4J7BtBg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 13 Aug 2026 12:01:28 +0300
Subject: [PATCH v2 5/5] x86/mm/pat: fix effective RW computation in
 lookup_address_in_pgd_attr()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-cpa-fixes-v2-5-39b4ff90f91d@kernel.org>
References: <20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org>
In-Reply-To: <20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 David CARLIER <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Jiri Slaby <jirislaby@kernel.org>, Juergen Gross <jgross@suse.com>, 
 Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Mike Rapoport <rppt@kernel.org>, 
 Nikunj A Dadhania <nikunj@amd.com>, Pedro Falcato <pfalcato@suse.de>, 
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Steffen Dirkwinkel <lists@steffen.cc>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Toshi Kani <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 stable@vger.kernel.org, syzbot@syzkaller.appspotmail.com, x86@kernel.org
X-Mailer: b4 0.17-dev

lookup_address_in_pgd_attr() accumulates the effective NX and RW bits of
the walked page table levels so that verify_rwx() can detect mappings that
are both writable and executable.

The RW bits are folded into a bool with

	rw &= pXd_flags(*pXd) & _PAGE_RW;

but _PAGE_RW is 0x2. So consider the accumulation line:

        rw &= pXd_flags(*pXd) & _PAGE_RW;

where rw=0x1 and the right side evaluates down to 0x2. It'll end up doing:

        rw = 0x1 & 0x2

and rw always ends up 0.

This way rw becomes false at the first level walked, regardless of the
actual permissions, and verify_rwx() treats every mapping as non-writable
and never reports a W^X violation.

Add double negation to the right side to normalize the _PAGE_RW flag to
0 or 1.

Fixes: ceb647b4b529 ("x86/pat: Introduce lookup_address_in_pgd_attr()")
Cc: stable@vger.kernel.org
Assisted-by: Copilot:claude-opus-4.8
Reviewed-by: Juergen Gross <jgross@suse.com>
Tested-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index fbc418dfc597..430d0b448371 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -754,7 +754,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
 
 	*level = PG_LEVEL_512G;
 	*nx |= pgd_flags(*pgd) & _PAGE_NX;
-	*rw &= pgd_flags(*pgd) & _PAGE_RW;
+	*rw &= !!(pgd_flags(*pgd) & _PAGE_RW);
 
 	p4d = p4d_offset(pgd, address);
 	if (p4d_none(*p4d))
@@ -765,7 +765,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
 
 	*level = PG_LEVEL_1G;
 	*nx |= p4d_flags(*p4d) & _PAGE_NX;
-	*rw &= p4d_flags(*p4d) & _PAGE_RW;
+	*rw &= !!(p4d_flags(*p4d) & _PAGE_RW);
 
 	pud = pud_offset(p4d, address);
 	if (pud_none(*pud))
@@ -776,7 +776,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
 
 	*level = PG_LEVEL_2M;
 	*nx |= pud_flags(*pud) & _PAGE_NX;
-	*rw &= pud_flags(*pud) & _PAGE_RW;
+	*rw &= !!(pud_flags(*pud) & _PAGE_RW);
 
 	pmd = pmd_offset(pud, address);
 	if (pmd_none(*pmd))
@@ -787,7 +787,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
 
 	*level = PG_LEVEL_4K;
 	*nx |= pmd_flags(*pmd) & _PAGE_NX;
-	*rw &= pmd_flags(*pmd) & _PAGE_RW;
+	*rw &= !!(pmd_flags(*pmd) & _PAGE_RW);
 
 	return pte_offset_kernel(pmd, address);
 }

-- 
2.53.0

