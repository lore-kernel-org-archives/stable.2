Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795269437;
	b=OJYW+UDjVfrxP5xpDxmW+LzcZAzwJdvbUp7MqOrZl5yClktMCILQP8uKGGFiQl795uIw
	 KuwLVTW0+WF42dObI3KmyQRRGFepTgdfGFJ4v9VM9hj0yNQDqAjK6ktwJpzPymA55I5P4
	 HK4z1XRYQepNFrrdb9GRAr+8B43dP+0Uxv8Dx82Ag5f/sfxETMXFv+VOS7kM4ym3vVqTc
	 d+VRagJizNrU/M+lMeFM+t78rp+VOKZIvxM7d/J5GCAn4mugST3nYeBhOwzcMAap7Uo7L
	 5Ugt/LKlFUFRGvtwNRZ0FrBW4XzJ1LJv1ZiXkOKCqNT2JNKDqGlF283JWL+jMZfXFhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795269437;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=E+bCGGaXI56bRAFLO3X/96lwwLPLxDHKB8yvttf2LdU=;
	b=a38raw95ZrzTA2bGfq1TkTa+LiZt3stPLWK2a3wyX3oCsQiGwcDgoAMR8gCay2YVguI4
	 tvulDe+KNkYIckbTMIf17ntA1N5vU0fW/m3dK3e99G73gNez5pK+53tsRyMxe7H3A97mi
	 d/5d4RdGp5wfAoVwRGx+p5zKr0oHRwMVzvFazFFSHTLxs6SztXZwerBed38s64Gdu2SAH
	 XyuA64qE0hKf5+o/ItUsvaRRW7H3/Fd56Ii/dXWdUVAzvmF9lYlWla/GKo1PZBtJ1qK8y
	 dQg5Pq2A2uCe+PDohMff0suAUD17cr6+i+2FhpLemWejmQSlO+2tm4jz85ptuQ7eajg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JaywyMtv;
	arc=none smtp.remote-ip=95.215.58.164
Received: from mta1.migadu.com (out-164.mta1.migadu.com [95.215.58.164])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E572606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E572606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JaywyMtv
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QWuXn4TXtK7Vw9zOxmzJ39yO4rsJaI/6FPjzguwkHSk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795269434; v=1; x=1795874234;
 b=JaywyMtvrNmU1UklcnYq3JPkvPIDvWxMkuoov2Uq+L+xXxmOdUr/Uu0WduQ1EjRGM2Hp3MQk
 k0UIlpo3PfasZknypScQ8ue7KifjE9dPUy4HpqstEAkeJRnvLnMqZqV/v4W/qIQYTlmR+7NL/f/
 i/Q3df3bCgN67sWzIbZ4pHtQ=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f3afde95cbe555ef;
	Sat, 21 Nov 2026 13:57:14 +0000
X-Mizu-Trace-ID: f3afde95cbe555ef
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: stable@vger.kernel.org,
	sashal@kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 6.1.y v2 2/3] mm/ksm: fix KSM COW breaking with userfaultfd-wp via FAULT_FLAG_UNSHARE
Date: Sat, 21 Nov 2026 21:56:52 +0800
Message-ID: <20261121135653.3466-3-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261121135653.3466-1-lance.yang@linux.dev>
References: <20261111105034.51632-1-lance.yang@linux.dev>
 <20261121135653.3466-1-lance.yang@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

Let's stop breaking COW via a fake write fault and let's use
FAULT_FLAG_UNSHARE instead.  This avoids any wrong side effects of the
fake write fault, such as mapping the PTE writable and marking the pte
dirty/softdirty.

Consequently, we will no longer trigger a fake write fault and break COW
without any such side-effects.

Also, this fixes KSM interaction with userfaultfd-wp: when we have a KSM
page that's write-protected by userfaultfd, break_ksm()->handle_mm_fault()
will fail with VM_FAULT_SIGBUS and will simply return in break_ksm() with
0 instead of actually breaking COW.

For now, the KSM unmerge tests can trigger that:
    $ sudo ./ksm_functional_tests
    TAP version 13
    1..3
    # [RUN] test_unmerge
    ok 1 Pages were unmerged
    # [RUN] test_unmerge_discarded
    ok 2 Pages were unmerged
    # [RUN] test_unmerge_uffd_wp
    not ok 3 Pages were unmerged
    Bail out! 1 out of 3 tests failed
    # Planned tests != run tests (2 != 3)
    # Totals: pass:2 fail:1 xfail:0 xpass:0 skip:0 error:0

The warning in dmesg also indicates this wrong handling:
    [  230.096368] FAULT_FLAG_ALLOW_RETRY missing 881
    [  230.100822] CPU: 1 PID: 1643 Comm: ksm-uffd-wp [...]
    [  230.110124] Hardware name: [...]
    [  230.117775] Call Trace:
    [  230.120227]  <TASK>
    [  230.122334]  dump_stack_lvl+0x44/0x5c
    [  230.126010]  handle_userfault.cold+0x14/0x19
    [  230.130281]  ? tlb_finish_mmu+0x65/0x170
    [  230.134207]  ? uffd_wp_range+0x65/0xa0
    [  230.137959]  ? _raw_spin_unlock+0x15/0x30
    [  230.141972]  ? do_wp_page+0x50/0x590
    [  230.145551]  __handle_mm_fault+0x9f5/0xf50
    [  230.149652]  ? mmput+0x1f/0x40
    [  230.152712]  handle_mm_fault+0xb9/0x2a0
    [  230.156550]  break_ksm+0x141/0x180
    [  230.159964]  unmerge_ksm_pages+0x60/0x90
    [  230.163890]  ksm_madvise+0x3c/0xb0
    [  230.167295]  do_madvise.part.0+0x10c/0xeb0
    [  230.171396]  ? do_syscall_64+0x67/0x80
    [  230.175157]  __x64_sys_madvise+0x5a/0x70
    [  230.179082]  do_syscall_64+0x58/0x80
    [  230.182661]  ? do_syscall_64+0x67/0x80
    [  230.186413]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

This is primarily a fix for KSM+userfaultfd-wp, however, the fake write
fault was always questionable.  As this fix is not easy to backport and
it's not very critical, let's not cc stable.

Link: https://lkml.kernel.org/r/20221021101141.84170-6-david@redhat.com
Fixes: 529b930b87d9 ("userfaultfd: wp: hook userfault handler to write protection fault")
Signed-off-by: David Hildenbrand <david@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

(cherry picked from commit 6cce3314b928b2db7d5f48171e18314226551c3f)
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/ksm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index b35485868d5b..99147df91a69 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -422,17 +422,15 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
 }
 
 /*
- * We use break_ksm to break COW on a ksm page: it's a stripped down
+ * We use break_ksm to break COW on a ksm page by triggering unsharing,
+ * such that the ksm page will get replaced by an exclusive anonymous page.
  *
- *	if (get_user_pages(addr, 1, FOLL_WRITE, &page, NULL) == 1)
- *		put_page(page);
- *
- * but taking great care only to touch a ksm page, in a VM_MERGEABLE vma,
+ * We take great care only to touch a ksm page, in a VM_MERGEABLE vma,
  * in case the application has unmapped and remapped mm,addr meanwhile.
  * Could a ksm page appear anywhere else?  Actually yes, in a VM_PFNMAP
  * mmap of /dev/mem, where we would not want to touch it.
  *
- * FAULT_FLAG/FOLL_REMOTE are because we do this outside the context
+ * FAULT_FLAG_REMOTE/FOLL_REMOTE are because we do this outside the context
  * of the process that owns 'vma'.  We also do not want to enforce
  * protection keys here anyway.
  */
@@ -456,7 +454,7 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
 		if (!ksm_page)
 			return 0;
 		ret = handle_mm_fault(vma, addr,
-				      FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
+				      FAULT_FLAG_UNSHARE | FAULT_FLAG_REMOTE,
 				      NULL);
 	} while (!(ret & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | VM_FAULT_OOM)));
 	/*
-- 
2.49.0

