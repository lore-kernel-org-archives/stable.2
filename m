Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C563B95E3;
	Thu, 13 Aug 2026 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611712; cv=none; b=Ctv5hlOs9i+A5M2Zpru3FMtrzF2Yw/+RfopSMRlhJ7oc4l/uw+aldULik9g2dbk5VyANyiCrfQF9c4ShbVrZjVWv6t8YaK8UVKjhbt+Ar4nKdQ9ImrJKMpBrZMVVyzITqxAtquwj0cGZjt+1Xf3Zt9NmScFfUYDGn0cB0x0uN30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611712; c=relaxed/simple;
	bh=Mjrsg1JU/mJdl1NQFbdbtQ8yw6hXZhbIGt1umXBnvD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GGuPDfZjjSsIAywcRCaYqGJeo9N1TZxBkxBtw0y/ucWMXfgllhknew2wxiUCu7sjwv5VkmTLGfEnIAbQQ8n2E139z+3fLaKZk7ZO3Dnq/VAXqUoKwGJ7+5ODoA1Bar8bKXRFWx1jLAtRY2r4++P0vmNyjoEyM6MgBaxxI3f8CWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PH2JAqBI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PH2JAqBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6581F00A3D;
	Thu, 13 Aug 2026 09:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786611708;
	bh=CRSJV6+wHMCp/NANau/roLEK+lDHPucZMiMPxBMKL5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PH2JAqBIaEBKerWzSh1Dt4eMzbUkBQlgGpe8Iwq8jlPTpKtSGwCa7MMcudT4pyKdb
	 m2SP9Zyw4VfKA2fYBdSvAE8xpn1sJ7+yjEOUVNRh+M8FA5uUlX19MD5iPybqbOygZH
	 pHzw9NcRz7HVK43LC/p6b71fHO2zdidVMPtdlpZfvlT5T+26dEYfe3iH1OHBYxC8Ic
	 FIuwIqjq4lWbS3HVvSm+cDUjGKf/1scH974kVr0txKC9FAa8ZL1Nz7WJPHwaTHp1KN
	 eC0V9tjfcJpKdwj6famWSz4jdYfd2EuxwkAcCVF8nhMInbu/gdamdyYhdpBBB1mM2P
	 3gjX+Vb6NoUeQ==
From: Mike Rapoport <rppt@kernel.org>
Date: Thu, 13 Aug 2026 12:01:24 +0300
Subject: [PATCH v2 1/5] x86/mm/pat: acquire init_mm write lock on collapse
 to avoid UAF
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-cpa-fixes-v2-1-39b4ff90f91d@kernel.org>
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

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>

x86 implements page attribute modification using its Change Page
Attributes (CPA) mechanism.

This tracks properties of ranges such as cache mode through x86 page
attributes, and as part of that logic manipulates kernel page tables.

Since commit 41d88484c71c ("x86/mm/pat: restore large ROX pages after
fragmentation") ranges of kernel page table entries can be collapsed into
huge page table entries as part of this logic.

As part of this collapse, it frees the page tables which the collapsed
entries previously pointed to, and it does so without any relevant locks
being held to preclude concurrent kernel page table walkers.

The only way this code can be reached is if CPA_COLLAPSE is specified, and
this is only set in set_memory_rox() via:

set_memory_rox()
-> change_page_attr_set_clr()
-> cpa_flush()
-> cpa_collapse_large_pages()

Notable users of this are execmem and bpf when manipulating executable
mappings.

However, this is problematic for ptdump as it walks ranges it does not own
and thus runs the risk of a use-after-free on page tables freed underneath
it.

In addition, concurrent CPA collapse operations are possible which can also
cause races.

Resolve the issue by acquiring the mmap write lock on init_mm across the
whole operation.

It is safe to acquire a sleeping lock as all the callers invoke
set_memory_rox() from process context and in any case,
change_page_attr_set_clr() calls vm_unmap_alias() which ultimately takes a
mutex, disallowing atomic context here.

Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
Cc: stable@vger.kernel.org
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Will Deacon <will@kernel.org>
Reviewed-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 15 ++++++++++++++-
 include/linux/mmap_lock.h    |  2 ++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index d8d057f44417..c18b887ee4c2 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -22,6 +22,7 @@
 #include <linux/cc_platform.h>
 #include <linux/set_memory.h>
 #include <linux/memregion.h>
+#include <linux/cleanup.h>
 
 #include <asm/e820/api.h>
 #include <asm/processor.h>
@@ -409,7 +410,7 @@ static void __cpa_flush_tlb(void *data)
 
 static int collapse_large_pages(unsigned long addr, struct list_head *pgtables);
 
-static void cpa_collapse_large_pages(struct cpa_data *cpa)
+static void __cpa_collapse_large_pages(struct cpa_data *cpa)
 {
 	unsigned long start, addr, end;
 	struct ptdesc *ptdesc, *tmp;
@@ -443,6 +444,18 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
 	}
 }
 
+static void cpa_collapse_large_pages(struct cpa_data *cpa)
+{
+	/*
+	 * Take the mmap write lock on init_mm to:
+	 * - Avoid a use-after-free if raced by ptdump (which takes its own
+	 *   write lock on init_mm).
+	 * - Serialise concurrent CPA walkers.
+	 */
+	scoped_guard(mmap_write_lock, &init_mm)
+		__cpa_collapse_large_pages(cpa);
+}
+
 static void cpa_flush(struct cpa_data *cpa, int cache)
 {
 	unsigned int i;
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 04b8f61ece5d..f4ceb968aeb3 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -621,6 +621,8 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
 
 DEFINE_GUARD(mmap_read_lock, struct mm_struct *,
 	     mmap_read_lock(_T), mmap_read_unlock(_T))
+DEFINE_GUARD(mmap_write_lock, struct mm_struct *,
+	     mmap_write_lock(_T), mmap_write_unlock(_T))
 
 static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 {

-- 
2.53.0

