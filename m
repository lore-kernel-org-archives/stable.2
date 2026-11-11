Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439445;
	b=0Fo2tSux/W0F2yKatw2GL/dGZlFjjJ+HdVKKnmPIGMjS4f0duVfjnmBLBN32rTs8g2SQ
	 xOjGjGxh9ex8kl+NkJXUe4/YqKD+YoUhiMD9ZLDsN4g7tzqsXjvwzeW63nDTi6b1/8Ytm
	 XtuFcjopKeHTajAQpIF7uWkCaYrCa4Vz/dS01Uokpe+IThTTtEV0jmB4f7dnWvAW2zban
	 qVXeFPjWWPN2VYlXemwHVovmNcmbn1Bck7HOIAMRPinIrfcYqG0gTKoAa50Fql6NEm8fC
	 goWKDLVfylPUfFMNeHSptwSrESqPTOqjnOBDxntokpFDSeCd7OTEP1LluDBkoqWFrQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439445;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Pzj7/9EShhIscsdSH7OqKldqnG9+28gt2htGJFAbmXQ=;
	b=Ao98jVXchkIm0hFufIq1tZJALDcM0QzUQiR3x6hAfvLGWYA/DYsDbupKiu9eYca4SUM7
	 IMjHsVLEI+KNO09IrDgXqi0kMi2fljlgCpNrVeOwpaTM4ffDM4X72YK82vF2hQRgqck1E
	 bwhlwzE3c/7mspWJe3jLnx9gQ87+enqE9HuKQJIuLuPeJ8nBlB+AFgiHKcnrRfKHBXpq7
	 8nq/6QaldW3cCwrFJKH2AWrL6l0FSgSYCEmAWHPumyyWj5qD/uwHFoutQGGO1svSPdFMh
	 UmSQ/vC5AdG8hJjCM6PNa0d2+fex4fJ2hjAvf5pXj2fKpD6f/0BXfYghqZlXAcmUdRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOW6t4rr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16EE606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOW6t4rr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300F21F00A05;
	Wed, 11 Nov 2026 23:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794439445;
	bh=Pzj7/9EShhIscsdSH7OqKldqnG9+28gt2htGJFAbmXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WOW6t4rr/oO9IgCNXlY5yJAog0dMPgMfWuxIWNG23BRkeXJNdJGHXUD602xoZOjJ3
	 PQzlZoFfLx1VrViIf8Zl8CwGJV/udGLqXCX3K+mNu+3w6WvBxhd+4h6x3Me4fuFPQ3
	 ewbxjcIW3K8ef+rZ1ybT4Dl100HqNfD3YxbcMpDTopYTkxcQ46RckyAzO/PhKvq/Ms
	 rjZExPBJoesTwrxnjiKD73gm8X6IP/uTfG7kz7sI9vtVgGUpt9IDl05uzA6hJz0D4y
	 pgdbQM8/ot1LUjkyij5hmbPBGooyrGbhZinzTp/v9b++/Y5Xgnfs4n79BG5Kiil4MS
	 jZwcurINKY/KA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Mason <mason@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Adam Litke <agl@us.ibm.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rik van Riel <riel@surriel.com>,
	Peter Xu <peterx@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/hugetlb: fix endless write fault on a leftover uffd bit
Date: Wed, 11 Nov 2026 18:24:01 -0500
Message-ID: <20261111232336.406571-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055428-failed-6.1-f61e1cf15fb4@kernel.org>
References: <20261107055428-failed-6.1-f61e1cf15fb4@kernel.org>
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

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit f61e1cf15fb44f9cf89d43d8ef01f926322bb1c4 ]

hugetlb_fault() resolves the uffd bit on a write fault only if the VMA is
registered for userfaultfd write protection, and hugetlb_wp() bails out
for any entry with the uffd bit set assuming hugetlb_fault() has already
resolved it.

When a read-only hugetlb entry with the uffd bit set is mapped in a VMA
that is not registered for uffd-wp, a write fault to it never makes
progress. If the access comes from the kernel, e.g. read(2) from
/dev/zero into such page, the task spins in the page fault handler,
ignores SIGKILL and keeps holding the locks taken by the system call.

Such entries should not exist, but an unprivileged user can create them,
for example with MADV_DONTNEED of a page protected with UFFDIO_RWPROTECT
or with UFFDIO_COPY in MODE_WP racing with UFFDIO_UNREGISTER.

Clear the uffd bit when the VMA is not registered for uffd-wp and let the
fault proceed to hugetlb_wp(), like do_wp_page() does for regular pages.

Note that a FOLL_FORCE write to a page protected with UFFDIO_RWPROTECT in
a private VMA that was made PROT_NONE now drops the RWP protection of
that page.

Original fix generated by an LLM and sent in private by Josef.

[rppt@kernel.org: massage commit message]
[david@kernel.org: convert comment into a TODO]
Link: https://lore.kernel.org/20261015-urgent_fixes-v1-6-42796911043b@kernel.org
Fixes: 60d5b473d61b ("mm/hugetlb: fix uffd wr-protection for CoW optimization path")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Chris Mason <mason@kernel.org>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Adam Litke <agl@us.ibm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: <stable@vger.kernel.org>
[ sashal: Adapted userfaultfd write-protection handling to older synchronous-only interfaces. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index de805b385d06b..9280e3d0cedd4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6180,23 +6180,33 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_ptl;
 
 	/* Handle userfault-wp first, before trying to lock more pages */
-	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
+	if (huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
 	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
-		struct vm_fault vmf = {
-			.vma = vma,
-			.address = haddr,
-			.real_address = address,
-			.flags = flags,
-		};
+		if (userfaultfd_wp(vma)) {
+			struct vm_fault vmf = {
+				.vma = vma,
+				.address = haddr,
+				.real_address = address,
+				.flags = flags,
+			};
 
-		spin_unlock(ptl);
-		if (pagecache_page) {
-			unlock_page(pagecache_page);
-			put_page(pagecache_page);
+			spin_unlock(ptl);
+			if (pagecache_page) {
+				unlock_page(pagecache_page);
+				put_page(pagecache_page);
+			}
+			hugetlb_vma_unlock_read(vma);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			return handle_userfault(&vmf, VM_UFFD_WP);
 		}
-		hugetlb_vma_unlock_read(vma);
-		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-		return handle_userfault(&vmf, VM_UFFD_WP);
+
+		/*
+		 * TODO: fix all cases where uffd PTE bits remain in VMAs that
+		 * are no longer registered with uffd.
+		 */
+		entry = huge_pte_clear_uffd_wp(entry);
+		set_huge_pte_at(mm, haddr, ptep, entry);
+		/* Fallthrough to CoW */
 	}
 
 	/*
-- 
2.53.0

