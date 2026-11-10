Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273730;
	b=QEAzNccf3bleus0AJhXN96Rre+KrAAJ+wB1C64+xf7ZjMLuHmZM9s6lLAs3QJvidJPrR
	 BjbieMxusn2qdw+Fc54Bheh7aNPSNzhJPITtJmUw5PRlpwHRdtkvbwRppjK3Cnwfu1gbr
	 9W3mwfgSPTYezLVhceYUQ008eO4iwtngm5kowRPVE9dfOYqoiAVWOwxKNne764y62OTY0
	 cvEPv/EoNnP5VFGDSEl774poc69RMFuA2m46DUu3V6vSG0cMQgJQbdApMHyiAPkNjXSZX
	 tME+jLOSlMfNu6sqaXsosidi+h3SG2kr57Qm9Ew+HcFl3bgL1AkgLFVWDqhbYC+2fFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273730;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=R3vushXl5xazX80+wP7aysI50fWZSdm7qjJJiW+F3I8=;
	b=BszROAmiTFKvIWKAf2qZ6l32csW89detsXXZCgj6dVi6VT5UFap2CORPgI2QIuaghKW9
	 LqKMUSTTTkwc0E3oCC9YZTrDUMxcPUXxi2b7mjsW5rWa8Ib8NMf1AhCsaCJenEnGignvM
	 iDTbXtKHTXr67l+JD6PioaoMv89fXG+bMgL2Szyv81lh9F2wjlAvaxuk1SScZPc84Ggir
	 NfgcQj15dKBOUQXDplEgzQAYnMsk4B6bfpvzz8v7YZr7fD77/a34CDyVXW5LI3yfVnJ2V
	 oe0G32vJM2zG4k0PTOrjXp/1Grx5PdJWePjzYIMLj1dKjR5EpxHDkdOVmW9q6vmRmOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWYdATWo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5746460A383B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWYdATWo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1F61F008A1;
	Tue, 10 Nov 2026 01:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273730;
	bh=R3vushXl5xazX80+wP7aysI50fWZSdm7qjJJiW+F3I8=;
	h=From:To:Cc:Subject:Date;
	b=NWYdATWoSdxt1odVE2eELbzqNYloRFtvU6OGSuUCnWsNl7Ayz77LoZQs1N/2e6TLW
	 a8OaL+ohfvR4GtrqZ7bF+I+lX0HovI+IXe4xoB8KNT8rYUTYD0qrzSj4V0Hbc4VTE3
	 53jh5Chnw0A8xIMJlP6ylN5gXl/7aYD9qmcNduJB1CLhnr0qoNoSzOeIcrx2R2DaOd
	 Pvk0BI8hHh75AlmGk7FtDYKBjbYPgzdIB2EcS6pgZEJlb7H04P19Ed/b46IYOOmVDX
	 m7d0XK1qTzIJ1Bj2PBxGP29Q07p21n1wTfI/c7zLJoaoT5ztJwXOTDQgnM6KEKNsND
	 8zrEVKiIaAXqQ==
From: Sasha Levin <sashal@kernel.org>
To: lance.yang@linux.dev,
	samarth.colleges@gmail.com,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	kas@kernel.org,
	david@kernel.org,
	mgorman@techsingularity.net,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jglisse@redhat.com,
	aarcange@redhat.com,
	peterx@redhat.com,
	bobbypowers@gmail.com,
	bgeffon@google.com,
	dplotnikov@virtuozzo.com,
	dgilbert@interlog.com,
	hughd@google.com,
	hannes@cmpxchg.org,
	cracauer@cons.org,
	mcfadden8@llnl.gov,
	gokhale2@llnl.gov,
	xemul@openvz.org,
	riel@surriel.com,
	shli@fb.com,
	jthoughton@google.com,
	corbet@lwn.net,
	pbonzini@redhat.com,
	seanjc@google.com,
	sj@kernel.org,
	ziy@nvidia.com,
	med08elkadiri@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/ksm: fix userfaultfd protection during merge and unmerge" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:22:05 -0500
Message-ID: <20261109202205-failed-5.15-990d6c2194a9@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 990d6c2194a938a19a8cf94c6cfd75171345089b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202205-failed-5.15-990d6c2194a9@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 990d6c2194a938a19a8cf94c6cfd75171345089b Mon Sep 17 00:00:00 2001
From: Lance Yang <lance.yang@linux.dev>
Date: Mon, 26 Oct 2026 21:00:54 +0800
Subject: [PATCH] mm/ksm: fix userfaultfd protection during merge and unmerge
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

KSM loses userfaultfd protection when replace_page() builds a new PTE from
vma->vm_page_prot.  Dropping its uffd bit lets a subsequent write go
through ordinary COW instead of userfaultfd write protection handling.
For RWP, a merged page also becomes readable without faulting.

Keeping the uffd bit and restoring PAGE_NONE fixes merging, but we also
have to handle unmerging.  An existing KSM page can be protected with RWP
before MADV_UNMERGEABLE, so unmerging already needs fixing independently
of preserving RWP during merging.

Unsharing replaces a shared page with a private one and should leave
userfaultfd protection in place, as do_wp_page() already does for write
protection.  Currently, an unshare fault reaches do_uffd_rwp() before it
can proceed to do_wp_page().

- With synchronous RWP, handle_userfault() returns VM_FAULT_SIGBUS.
  break_ksm() then reports success with a KSM page still merged.

- With asynchronous RWP, protection is cleared before unsharing.

Preserve the uffd bit when merging, and restore PAGE_NONE for RWP.  Let
FAULT_FLAG_UNSHARE skip RWP fault handling and keep PAGE_NONE on each
private copy as well.  Unsharing can then complete with RWP still armed
for a subsequent access.

Link: https://lore.kernel.org/20261026130054.91461-1-lance.yang@linux.dev
Link: https://lore.kernel.org/all/20261019010934.697895-1-samarth.colleges@gmail.com/
Link: https://lore.kernel.org/all/20261020055518.36087-1-lance.yang@linux.dev/
Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Co-developed-by: Samarth Narang <samarth.colleges@gmail.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Xu Xin <xu.xin@linux.dev>"
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Bobby Powers <bobbypowers@gmail.com>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: Doug Gilbert <dgilbert@interlog.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Martin Cracauer <cracauer@cons.org>
Cc: Marty McFadden <mcfadden8@llnl.gov>
Cc: Maya Gokhale <gokhale2@llnl.gov>
Cc: Pavel Emelyanov <xemul@openvz.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Shaohua Li <shli@fb.com>
Cc: James Houghton <jthoughton@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: SJ Park <sj@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/ksm.c    |  8 +++++++-
 mm/memory.c | 14 ++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 910a1307ac9f3..d6f736a1aa2f9 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -34,6 +34,7 @@
 #include <linux/memory.h>
 #include <linux/mmu_notifier.h>
 #include <linux/swap.h>
+#include <linux/userfaultfd_k.h>
 #include <linux/ksm.h>
 #include <linux/hashtable.h>
 #include <linux/freezer.h>
@@ -1463,9 +1464,14 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		dec_mm_counter(mm, MM_ANONPAGES);
 	}
 
-	/* Preserve soft-dirty when replacing the page. */
+	/* Preserve soft-dirty and uffd protection when replacing the page. */
 	if (pte_soft_dirty(orig_pte))
 		newpte = pte_mksoft_dirty(newpte);
+	if (pte_uffd(orig_pte)) {
+		newpte = pte_mkuffd(newpte);
+		if (userfaultfd_rwp(vma))
+			newpte = pte_modify(newpte, PAGE_NONE);
+	}
 
 	flush_cache_page(vma, addr, pte_pfn(ptep_get(ptep)));
 	/*
diff --git a/mm/memory.c b/mm/memory.c
index 916637e8381da..b65b56fe97148 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4125,8 +4125,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		if (unlikely(unshare)) {
 			if (pte_soft_dirty(vmf->orig_pte))
 				entry = pte_mksoft_dirty(entry);
-			if (pte_uffd(vmf->orig_pte))
+			if (pte_uffd(vmf->orig_pte)) {
 				entry = pte_mkuffd(entry);
+				if (userfaultfd_rwp(vma))
+					entry = pte_modify(entry, PAGE_NONE);
+			}
 		} else {
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		}
@@ -6662,9 +6665,12 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		 * VM_UFFD_RWP VMA, a protnone PTE without the uffd bit is
 		 * NUMA hinting and must still fall through to do_numa_page().
 		 */
-		if (userfaultfd_pte_rwp(vmf->vma, vmf->orig_pte))
-			return do_uffd_rwp(vmf);
-		return do_numa_page(vmf);
+		if (userfaultfd_pte_rwp(vmf->vma, vmf->orig_pte)) {
+			if (!(vmf->flags & FAULT_FLAG_UNSHARE))
+				return do_uffd_rwp(vmf);
+		} else {
+			return do_numa_page(vmf);
+		}
 	}
 
 	spin_lock(vmf->ptl);
-- 
2.53.0




