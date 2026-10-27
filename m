Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116002;
	b=DF97Oqf5HOGxxqQmiyg7K7wOBlW6SiLmMmd0TM9s2wy4GEaXVsIntdptBfxfrDlxXv1+
	 GrHRs0+dhQ1xjwK/UrIE1MhJR2tGy6pqc4HgpB3hBMnLpGEql8lHZYUR4iGBN2ybKixvr
	 OUrIre80G/IN2XL/tPCk3aKXbHqqLhfp3MR46blVvSZSp+mFjl+VmKJTNm2mEeiQ9Agf7
	 aiT/el+3RO3YgGcwFlQl/3qcb9/3PcDuR8kVnCXHrtNOFP4sb2Fjh8/Qt2U2XYi8ZzJyC
	 f5vdunPRuiopwEBecyi6Nyby7QswGFYyru13i3+A+NflRVFD/x6q15V8L6zILGpGnWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116002;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=JZkvBXJ1M4cprmGAnU9nv4mrWfliu5LNDxbLf5XaiBg=;
	b=naNSG6KuGwxOY4OMu6RqjhUCniUad7qYd4/HTekJkvQ4Q4PIirRdHmLx6QvBIAdiX8nY
	 uEUWjxtR4ZdZMAj49YcV4KIul0Y0jzlLuSxw6iwirf+8U2tcQr/rrRYYxt8xx2brRRYzv
	 e4Fbpi1Gat1IZ2x1AH8k0M61Nmcmxzs9ElwqUJrNlnZArFV7RADu8xdFUObq5g6/tc5mf
	 JZFTegWZAOkYe2M6TrjmVcx4Y4Tl1GSUt5m8REK1f+32BSoXBVT1lLVuMPzmw81lLYwlg
	 hOwlV2dOQBOrYPlfS9+uzke+dnZZ0Se6J4Knn2o0U5FeMHwsl8f6XFZ5urhVhhS+7VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wi3ycDQp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1669606A325;
	Tue, 27 Oct 2026 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wi3ycDQp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17F91F01829;
	Tue, 27 Oct 2026 15:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793116001;
	bh=JZkvBXJ1M4cprmGAnU9nv4mrWfliu5LNDxbLf5XaiBg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Wi3ycDQpHF+2DIQxiDwQjdSsO80VWcpydnlA755H+EKJMGT8hFyb11qJN+Gseajqt
	 Byo+QhM5RwKb2KaoAkOnY8OD680CD011e5np2eh5OvSj9jNHK1VSl96bA92YWs81BZ
	 yX3UDHGZs7N7CIsp2y4BIuKhbks1JtLfBADzO6vesqXSur5M5wM3ZruF6VCFjA/T9s
	 mGBc39SYbWerm/Qh9VTg2baNXgVabajJy3pjqmbOJOLzT6yK5buRJ4WXMmUbWSOLi+
	 84B7Yp5bQkRwVMiqoZcMxHGwGPo8lfgIOsv6f/Koddk4FP7pNe1Pu1J2b9ZxMjMxIT
	 Z60vbzB3zih/A==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 27 Oct 2026 16:46:28 +0100
Subject: [PATCH 2/9] mm/page_alloc: clear ->private of deferred free pages
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
Message-Id: <20261027-pgalloc-ai-hotfixes-v1-2-9c7d1aca801e@kernel.org>
References: <20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org>
In-Reply-To: <20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0

From: Josef Bacik <josef@toxicpanda.com>

free_pages_nolock() and free_frozen_pages_nolock() put the page on
zone->trylock_free_pages if they get neither the pcp lock nor zone->lock.
add_page_to_zone_llist() keeps the order of the page in page->private.
The next free_one_page() which does get zone->lock passes these pages to
split_large_buddy() with ->private still set.

__free_one_page() writes ->private of the head of the resulting free page
only. If the deferred page is merged with its lower buddy, it becomes a
tail of that free page and keeps the order in ->private.

All other free pages which are not the head of a buddy have a ->private
of zero, and since commit 819bfbd47e49 ("mm/page_alloc: remove
set_page_private() in prep_compound_tail()") the allocator relies on it.
When the stale page is allocated again as a tail of a larger page:

 - prep_compound_tail() hits VM_WARN_ON_ONCE(tail->private);
 - with the page checks enabled, __free_pages_prepare() reports
   "BUG: Bad page state", "nonzero private", and leaks the whole page;
 - without them the value is seen by whoever uses that page next, e.g. as
   folio->private of a folio which is split off a large folio.

Only pages of an order above zero are affected. Those can be freed
through _nolock() by the stack depot (order 2) and by SLUB (a new slab
which cannot be added to the partial list by kmalloc_nolock()).

Clear ->private when the page is taken off the list.

Fixes: 8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
Cc: <stable@vger.kernel.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ee013db45ed1..9a4d3352c037 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1562,6 +1562,8 @@ static void free_one_page(struct zone *zone, struct page *page,
 		llist_for_each_entry_safe(p, tmp, llnode, pcp_llist) {
 			unsigned int p_order = p->private;
 
+			/* It may end up as a tail of the merged free page. */
+			p->private = 0;
 			split_large_buddy(zone, p, page_to_pfn(p), p_order, fpi_flags);
 			__count_vm_events(PGFREE, 1 << p_order);
 		}

-- 
2.56.0

