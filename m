Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F157438486;
	Tue, 28 Jul 2026 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244124; cv=none; b=Ci1e4tPNjzmUvR0wzhjMXVkChuSocos7BeSJ315ixwoTs6VsQu95kG0D2namHbW7ffvGzC2y2nrxw2s+xoY+I9hQ0g6g9N3MQ6LwZ5YwkWNcevRkv/atBav9I84jsURUD8RgnyW4F+OeJ18GcFG0F7iX9Ox+izu4+XzubcfIYdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244124; c=relaxed/simple;
	bh=rSQnuleIvcOPlMFU+OC0qOsZXz8MQZmx2AmTssaZ71o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lsCh7WSaNFyS4mlv+AryXC1r59Dm6eYeD4q6L0eiqJVKK4YU/dm+CFx75yXBiB1a2CiVYeMozGBRg2kxuhYitOdOJdLHkZxQbyT1H6Ke3flqst/zw0mhuNMZqFF2Yli1sUayGrL0y1mjpRl7QVKCq+8OukMkCvD6yn87aB2rKQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jarQQNfZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jarQQNfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B051F000E9;
	Tue, 28 Jul 2026 13:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785244122;
	bh=3sxlim6Jm3YtcLECKKEooguzj3UphetqkoUwty9M5B0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jarQQNfZ22qSDtdYLOxTo6gp1glpSKTDMwZLTumpSpou4pkARWfxuXW0DuYezdnxI
	 55l6PTEocmVCk9K6xmlrSUHC2LEsxlHfleAW0kpx5eyjBAjehHSRdwr4qAw3a8N2UW
	 up1JsYO0nEFjLX0TKB96knGccON9uyl9aMGQ+rm52v5U0Cbul/sAhSc4py+kIKozAm
	 myeiesn/+aSopbFgd2lqsMXmU00rMXpXPFzh5qU1gPmmtJ1/F+xaMy8mvMSlHXWScB
	 uV4spMcQaPfqHEYQqNvv4Lz3lbxD5/HYN0H8ZYaoAJf39wAxREkcJrXY4XFGPMWCo1
	 wp1qoELYYdhvQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 28 Jul 2026 16:07:48 +0300
Subject: [PATCH 5/5] x86/mm/pat: fix effective RW computation in
 lookup_address_in_pgd_attr()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-cpa-fixes-v1-5-2ed2352300b3@kernel.org>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
In-Reply-To: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 David CARLIER <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Juergen Gross <jgross@suse.com>, Kevin Tian <kevin.tian@intel.com>, 
 Kiryl Shutsemau <kas@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
 Mike Rapoport <rppt@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Toshi Kani <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 stable@vger.kernel.org, x86@kernel.org, syzbot@syzkaller.appspotmail.com
X-Mailer: b4 0.16-dev

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
index 1b63d4caba20..7d656520887c 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -769,7 +769,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
 
 	*level = PG_LEVEL_512G;
 	*nx |= pgd_flags(*pgd) & _PAGE_NX;
-	*rw &= pgd_flags(*pgd) & _PAGE_RW;
+	*rw &= !!(pgd_flags(*pgd) & _PAGE_RW);
 
 	p4d = p4d_offset(pgd, address);
 	if (p4d_none(*p4d))
@@ -780,7 +780,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
 
 	*level = PG_LEVEL_1G;
 	*nx |= p4d_flags(*p4d) & _PAGE_NX;
-	*rw &= p4d_flags(*p4d) & _PAGE_RW;
+	*rw &= !!(p4d_flags(*p4d) & _PAGE_RW);
 
 	pud = pud_offset(p4d, address);
 	if (pud_none(*pud))
@@ -791,7 +791,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
 
 	*level = PG_LEVEL_2M;
 	*nx |= pud_flags(*pud) & _PAGE_NX;
-	*rw &= pud_flags(*pud) & _PAGE_RW;
+	*rw &= !!(pud_flags(*pud) & _PAGE_RW);
 
 	pmd = pmd_offset(pud, address);
 	if (pmd_none(*pmd))
@@ -802,7 +802,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
 
 	*level = PG_LEVEL_4K;
 	*nx |= pmd_flags(*pmd) & _PAGE_NX;
-	*rw &= pmd_flags(*pmd) & _PAGE_RW;
+	*rw &= !!(pmd_flags(*pmd) & _PAGE_RW);
 
 	return pte_offset_kernel(pmd, address);
 }

-- 
2.53.0

