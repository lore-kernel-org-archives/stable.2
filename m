Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832854;
	b=sd/Ltasc3oNnpDT/eaT/HAyOAS+gfmHIiA68BWuIKxQdPyZlPoJjAb6bUXO4BLc9VMaL
	 aP2Hp02yofHw3VgllLqA/yMNG2+XjkHLj0Dcw9cKihirh52YMmdHqD0WN+UTsB//+asZY
	 AibS0sA4ROAvZFJ8+X3zHtgfVDsMUVb8oIp+um444RgOzykTHMItz2Fo+SvmDK77GCAJN
	 j6vNAo+MqxCUGKfverK4m+epUo/1UHNj2swpmZbuetXVoqDjC0VFy/pteSybvSjqJmVuu
	 4+qHjc6/JyhIR3dmE1br917zbdekGHhDJdG+KBB1ulY+qQEWVCkGGpyALldkKHxDQ9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832854;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AJxJW64brnfqY5WaIVwBzjPhZWOifxw1Ma+QZJjvFYs=;
	b=KHXkJx8T7h9JHTt5npjlqlmPVPyfG7lvjdbBMY+NQvhQB2H3djIxYJ5VEdQQgnvkCrN3
	 y0Oy2y1xVa4vKD0pu8cQFmJvJ1VsNpH3aUnRFrvts5YTaDLYaBX71dQQ8r9KHH4VT4M85
	 NzTtSTQy8HXQAsJYuXM/jYv4dypuOX6NmH4JvHrTEnsjYHsb5IOqT0kh2Hn1vH7MC5Z69
	 7oqc41rQ0Mns8lAKxuKV8OnHQ3FjrxypbhR8tsxi7gRpDYUFhqYI4gUfPxCApX5aY9eC0
	 c4/B3AHOXpdyjtbL6AOcHfoIaEMcEFFVN7i9GSwMjVP75wyuCpRHTbbwtw0esCnMnKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I7gXEs4H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F94E606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I7gXEs4H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5091F000C1;
	Wed,  4 Nov 2026 22:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793832854;
	bh=AJxJW64brnfqY5WaIVwBzjPhZWOifxw1Ma+QZJjvFYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I7gXEs4HICnhDKUEkgp0Vshz6QWWwsxLdgquopwIOI6oJ22zKLg8MPZP9fbJRZ5bR
	 FUw8Nh/jncmPvFJ6sjIxFKlTuRyNNAuwvNeUQoFb1VN7dc69VoIvMYNk1oufx577Ma
	 tkDLawiiKh/B0LBwvQjHc5yEsMCwlGKsemeBujaD22TAv17XrFkE8kwiPB9UJpMUPQ
	 d4d4cy3kmYxLMC3wzOmyCT/lXGspew7UcpdD72l4h2QKYQmsAA3svQFUclcY1/vlYm
	 YVTQqgMtRwwM7SJ23K59+Rlnji4K89zh5+bPcvty+eU2U6+ssmMHQTg+BQxPPjkW7z
	 xUUv77Y9wJfPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Oscar Salvador <osalvador@suse.de>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Adam Litke <agl@us.ibm.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rik van Riel <riel@surriel.com>,
	Peter Xu <peterx@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/hugetlb: fix use-after-free in hugetlb_mfill_atomic_pte()
Date: Wed,  4 Nov 2026 17:54:11 -0500
Message-ID: <20261104225336.846864-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110447-friend-unmanaged-5374@gregkh>
References: <2026110447-friend-unmanaged-5374@gregkh>
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

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit d8a9cd7fd2fb01211430c933932da58839b8ca65 ]

Let's fix another instance where we use a folio after dropping the PTL,
where someone else could e.g., MADV_DONTNEED it once we drop the PTL,
making us trigger a use-after-free on the folio.

Link: https://lore.kernel.org/20261015-urgent_fixes-v1-3-42796911043b@kernel.org
Fixes: cb6acd01e2e4 ("hugetlbfs: fix races and page leaks during migration")
Fixes: 1c9e8def43a3 ("userfaultfd: hugetlbfs: add UFFDIO_COPY support for shared mappings")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Adam Litke <agl@us.ibm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: <stable@vger.kernel.org>
[ sashal: Adapted folio-based hugetlb_mfill_atomic_pte() logic to page-based hugetlb_mcopy_atomic_pte() without continue support. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b23c8b2699b58..da47b6d218e01 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4806,10 +4806,15 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 
-	spin_unlock(ptl);
 	set_page_huge_active(page);
 	if (vm_shared)
 		unlock_page(page);
+
+	/*
+	 * Hold the PTL until we're done with the page: the page table owns the
+	 * page reference now.
+	 */
+	spin_unlock(ptl);
 	ret = 0;
 out:
 	return ret;
-- 
2.53.0

