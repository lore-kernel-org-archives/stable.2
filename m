Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECEB3749ED;
	Sun, 12 Jul 2026 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783853071; cv=none; b=jQqMdwh1ESUVIK2FAXRpJtwaJ7L0ZaQwmHUFDIJ7jzPCskGNUd8fd4ZmAg/o23BQVHgebJYrozeRl4L3n7JSMVdMHacvCVEDKTcCtyJ8tNpr/ACwEWSTcpBory05zb6YeBh6zrwoJqApGLTNePleW9j626bcjUV+s3tyQlgo6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783853071; c=relaxed/simple;
	bh=sQJwBcRAluqgPNbXUgxA0+sFptVnbX0UWpL7em1s+OU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uM/7C1x3sjWzRx+7BtEVapDVa/9/DEVEDTWEmHKBqOxlGl79snIXHWntKz67Aj7eqwH8WGxPTfRhDRZoVgxJ4QMI+Wz7TBO7AzT2iNvBw7Ex5chQ27Hrrf1R51BsgUdRJpewZe56uGXloIrEgphHJ2exDLymyXA45A1olZrSuPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OG39gJMG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OG39gJMG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7AF1F000E9;
	Sun, 12 Jul 2026 10:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783853069;
	bh=vGAlEpRQYRhrbsbyFqevUzGTrHwI86sKZ3VuDai3N60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OG39gJMG3+GR+z2BP91RhW1g0+wE49EpUq3bCYDPV/qd1d16HjQxfaa5OvRrLt4t1
	 ScfsqVHBbYXGzWg1Ng0Uj61vjOdBG8skAeWgfl7mfu6l7WzjPmPBw5s3GsYjHbHBlI
	 P/6KwDeXesk2Y9ik3ih48WxLLm6+kKD93yq/NveeZMCdB6kOcqbl2f9rI+pyDoYAwd
	 CRwwmI70HYUvVJv4l3pVq9XKKrd27HOgHknKzrBrcIU2KRSA+jkHv+eoW++NJrOfuW
	 3YfKKI6vu+vOm3Kuy+pv3wszW47DA7g5awhjYFtsysatnbJHTTMialqgKQOD3Jfw5R
	 1t1JytAS9BmOg==
From: Lorenzo Stoakes <ljs@kernel.org>
Date: Sun, 12 Jul 2026 11:42:25 +0100
Subject: [PATCH mm-hotfixes v2 2/4] x86/mm/pat: acquire mmap lock on page
 table free to avoid ptdump UAF
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-series-vmap-race-fix-v2-2-ad134cc3a12a@kernel.org>
References: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
In-Reply-To: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Dev Jain <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: David Carlier <devnexen@gmail.com>, ljs@kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2980; i=ljs@kernel.org;
 h=from:subject:message-id; bh=sQJwBcRAluqgPNbXUgxA0+sFptVnbX0UWpL7em1s+OU=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKC8z/859bu7Nn3SrLd4LHMIr6D0jnXY99ZKqtbpX9kV
 OT/stito5SFQYyLQVZMkeX5F/H9QSJh8zov+LvBzGFlAhnCwMUpABM5/Ijhr6Dyad2m2Y0q1/o6
 318LY3hTsNKyT3Nhxsk5k77/Ot/rfZnhv9vCUB9Bu4mFD7RKpLdoGlw2+/rkXRibwL4ZEbMTvv2
 yYAMA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

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

However, this is problematic for ptdump, as it walks ranges it does not own
and thus runs the risk of a use-after-free on page tables freed underneath
it.

This patch resolves the issue by acquiring the mmap read lock on init_mm to
provide mutual exclusion against ptdump, which acquires the init_mm write
lock.

It is safe to acquire a sleeping lock as all the callers invoke
set_memory_rox() from process context and in any case,
change_page_attr_set_clr() calls vm_unmap_alias() which ultimately takes a
mutex, disallowing atomic context here.

We also include cleanup.h in order to use a scoped_guard() to implement
this cleanly.

Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
Cc: stable@vger.kernel.org
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index d023a40a1e03..4c4b8244502f 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -22,6 +22,7 @@
 #include <linux/cc_platform.h>
 #include <linux/set_memory.h>
 #include <linux/memregion.h>
+#include <linux/cleanup.h>
 
 #include <asm/e820/api.h>
 #include <asm/processor.h>
@@ -436,9 +437,16 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
 
 	flush_tlb_all();
 
-	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
-		list_del(&ptdesc->pt_list);
-		pagetable_free(ptdesc);
+	/*
+	 * ptdump might read these page tables, so avoid a use-after-free by
+	 * acquiring the mmap read lock on init_mm (ptdump acquires the mmap
+	 * write lock).
+	 */
+	scoped_guard(mmap_read_lock, &init_mm) {
+		list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
+			list_del(&ptdesc->pt_list);
+			pagetable_free(ptdesc);
+		}
 	}
 }
 

-- 
2.55.0

