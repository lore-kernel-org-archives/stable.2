Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439912;
	b=5cU8DzAxMmcyNZU9EDqy2ohpWLSVZCjxF0F9gd11WyNvso020bIt0vhMRnDZo+MBuE9O
	 +6hdL5B0E7kHfAVwJqE+cHX3hO79mwNKAJB/nQVJ334G9Gxfy2Ja5GPsl1dySK/lmYoAS
	 ngYE7uTRze044th0iQ1okqc1cJlc53UqcEFm+ai6szg04/UWNkQPf/oFbqbXxpktYg8L/
	 jDbCfEMOpzuvgOx23O90AFCpV6NwL1kHnUrH9GF3i7QsFI8BwgD4clkLfAWODMOFRR8/g
	 2qxtM+67SFKohPffeg655iTjaN4kBxfpphwPJ0Zi1To/xIC2Ky7SnLSX8orxbwJ1z0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439912;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pgdswAlJ0tHrgdwu7xvdEotoJ4wfivizA8ZmpyMq/2w=;
	b=CUwdm3HT1VcDozY+Vip7pJKKDQHGsdJ/yhspb/IY28Y8e5J8wbpcCMWe3fcbpRpfKvFw
	 GknVyPTxAGlUgfxqN22SxXYcyrbBUdao+j6teh0onRfA4hj7YIT+71xBgwyiamhChcepS
	 fKjFgM3g8PH6/7RniWdBR4pAnjqlg4yl75ZrSRcW4poY/6e6pGYBN4o7Mec0l3yRcM8KS
	 rwz7z9tE3REaZxRLptLRjgbN+VK46mdbPO2xPK9rdKc+b9R8QX4R0eYn/fPyqUjxDabpL
	 LTQmoyYLIcfQWZjBmIJZLs9Gj4Uq4Iat8Fd8Z0HutYqBJP14EoeNeJOpgkRjpINw6XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuJTn2CD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7823606A320;
	Sat, 31 Oct 2026 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuJTn2CD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4351F00919;
	Sat, 31 Oct 2026 09:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793439911;
	bh=pgdswAlJ0tHrgdwu7xvdEotoJ4wfivizA8ZmpyMq/2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OuJTn2CDjkl/uIunKqHqMrRV00wX4O0o6oCMdWE9SY/BSDh/8zK6CFbafNYsWX3lh
	 Shr49y/05lbGdr26yIwqOrJ9MqkGi5jE9gI5Ghw9JU2zWQj7vKFsV4KqIBDUD++cdB
	 /+eT0L2pCCZHRoP/cFbj78tWpFoNeHoBXE8SLEsoOuWBfj3at07+hhSnqV+ugYvF3y
	 Kp5Qzc4oIRFJOCiQLf31cSKVfmv2r0a8R5GBvUmnuAbO6YCZePXCPPe+ZHSxz3RPX8
	 JN4lFv6aC4cOokc2Ii9d0yUZNMzdoAGLV0A6bc2LVPDtt/qISQhJ7YzYmbL/VKLPj6
	 W/2MeEvW/oU3w==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:48 +0100
Subject: [PATCH v3 19/47] mm/gup: recheck the PUD under PTL in
 follow_pud_mask()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-fixes_core-v3-19-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
In-Reply-To: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3852; i=david@kernel.org;
 h=from:subject:message-id; bh=T72hxHsP6c9yHdsWHqOEwt8fC5kOdXgBHBMzKN7/ZJo=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebk8vsLBP+Hq6ev6Ud+VsBTvXz2TlufK5LtSo0XnV5
 nUGi85P6ChlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAiu+IYGZ6VbvAuUKxW5zmw
 uC0la4pMZ5yxfmP1+4u7dq2daTCNJ5Xhn4px0+z2pZYnJt/QKFu3PtW2qXmy1fFTeo7t3AlLr5z
 g5AAA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

follow_pud_mask() reads the PUD without a lock. If it is a leaf, it takes
the lock and calls follow_huge_pud(), which reads the entry again, but
only tests whether it is present.

A leaf can be zapped concurrently and a page fault can fill the empty
entry with a page table.

This currently only applies when device-dax makes use of PUD entries,
and the fault after e.g., MADV_DONTNEED would find THPs to be disabled.

That requires a sequence like

1) Fault in the PUD
2) Disable THP
3) Have GUP race against concurrent MADV_DONTNEED + refault

Which is rather unlikely to happen in practice, which is why we never
received a report about such a problem.

Before commit 1b1676180246 ("mm/gup: handle huge pud for
follow_pud_mask()"), we performed that check in follow_devmap_pud() by
testing for pud_devmap().

Let's fix it by just structuring follow_pud_mask() similar to
follow_pmd_mask(), minus protnone stuff that does not apply and minus
FOLL_SPLIT_PMD handling. That makes it much easier to spot any such
inconsistencies.

Perform the pud_bad() check early in follow_pmd_mask() and just forward
the PUD value. We can drop the pud_present() check in follow_huge_pud(),
just like we have in follow_huge_pmd().

Even though we are performing more changes than strictly necessary, the
fix should be easy to backport.

Fixes: 1b1676180246 ("mm/gup: handle huge pud for follow_pud_mask()")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/gup.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 7d43ce717b246..f809361227e7e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -658,9 +658,6 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 
 	assert_spin_locked(pud_lockptr(mm, pudp));
 
-	if (!pud_present(pud))
-		return NULL;
-
 	if ((flags & FOLL_WRITE) &&
 	    !can_follow_write_pud(pud, pfn_to_page(pfn), vma, flags))
 		return NULL;
@@ -896,15 +893,17 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 }
 
 static struct page *follow_pmd_mask(struct vm_area_struct *vma,
-				    unsigned long address, pud_t *pudp,
-				    unsigned int flags,
-				    unsigned long *page_mask)
+		unsigned long address, pud_t *pudp, pud_t pud,
+		unsigned int flags, unsigned long *page_mask)
 {
 	pmd_t *pmd, pmdval;
 	spinlock_t *ptl;
 	struct page *page;
 	struct mm_struct *mm = vma->vm_mm;
 
+	if (unlikely(pud_bad(pud)))
+		return no_page_table(vma, flags, address);
+
 	pmd = pmd_offset(pudp, address);
 	pmdval = pmdp_get_lockless(pmd);
 	if (pmd_none(pmdval))
@@ -953,18 +952,23 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	pud = pudp_get(pudp);
 	if (!pud_present(pud))
 		return no_page_table(vma, flags, address);
-	if (pud_leaf(pud)) {
-		ptl = pud_lock(mm, pudp);
-		page = follow_huge_pud(vma, address, pudp, flags, page_mask);
+	if (!pud_leaf(pud))
+		return follow_pmd_mask(vma, address, pudp, pud, flags, page_mask);
+
+	ptl = pud_lock(mm, pudp);
+	pud = *pudp;
+	if (unlikely(!pud_present(pud))) {
 		spin_unlock(ptl);
-		if (page)
-			return page;
 		return no_page_table(vma, flags, address);
 	}
-	if (unlikely(pud_bad(pud)))
-		return no_page_table(vma, flags, address);
+	if (unlikely(!pud_leaf(pud))) {
+		spin_unlock(ptl);
+		return follow_pmd_mask(vma, address, pudp, pud, flags, page_mask);
+	}
 
-	return follow_pmd_mask(vma, address, pudp, flags, page_mask);
+	page = follow_huge_pud(vma, address, pudp, flags, page_mask);
+	spin_unlock(ptl);
+	return page;
 }
 
 static struct page *follow_p4d_mask(struct vm_area_struct *vma,

-- 
2.43.0

