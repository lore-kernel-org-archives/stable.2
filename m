Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439880;
	b=iDC6/TAktLN9xTk6WUgqP7mdQoODX+OFSRQiDdAG7IyE7FCCfsvsKXtL4yyo60HImExJ
	 WUIN+sOGSYGM0aeZhB7Qu8b0H5TNA+w53igwN7bj26e4qHAyiAKP9P2okVdpdile7/OaO
	 VseRusC+gPUY3AsnQ4AzTmcEVDdUUQs2tdawC73kSKcoNfMBYuJUAjhJFDWj+C4Jfv6k5
	 3rF/uIq0yBWzIHjzUCvZIRlqfJY1qkbVe5XyyKjjnLFa74nXu6eJuxR+OPc6wz69drMfc
	 gmuVhT/3nd45CaDolj+083rbb4K2hIDJ12FNzadzJSSlK930+Ib+Xum6ZxDZuQyc0mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439880;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5Wa3C2xG00DqQeoX0IE5SZmfSUJ/EgLcgZVnEIOFPnM=;
	b=hzA+lU2lyBHoydRE+HuC0rWsOHhtTcDxXVESu8PMT6sihKifygOoYTIS8bh1YgmeYX/y
	 ip0oW3y8WIf50cD8n5SqxcbXs9MSz7GGIbWllDMGumuW7jHItALOmRKjXHtzlI41HPgW1
	 Lbx+5zOt85C2Lt1Aev6P6UnkaZfWpocPkVM1B/ACtKjyBKJxNGKZZtDE9YJrnFY2dpHjU
	 wU5Yw8jsYugiJViJaYajKaIG+h2hRaZl2g3RjKXKATBUJW6EYqxOF9NvVxUgeQ3G1zHJK
	 SULQttTVEa/2vtjquP6YrvwegtYdsGfV9cyC5nQBolTTPMRmUkjI1k2LGeAOAzXzsQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2bzvm+r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799EE606A31F;
	Sat, 31 Oct 2026 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2bzvm+r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349821F00A16;
	Sat, 31 Oct 2026 09:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793439880;
	bh=5Wa3C2xG00DqQeoX0IE5SZmfSUJ/EgLcgZVnEIOFPnM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=T2bzvm+ru2+7cwP8E0yxMJ/sp9KoxH0UYhdJNE8wXIhEoHwEm4mcCdf26VhVT2JNn
	 3IoDZ6z4lCxSnRa0L+FZqLhwbyJVD/4rB+3H/Fwa05CWLxjF2qFsPDelKb3ATmPyCs
	 Rp4ztACMJM8u1YQoWDvGJ3PTuh0O8Xt4Z7ysQdttuehVHPZlb2xY3vs8DKkIBwk662
	 ugOc3Lz8ba1yqU+0LbKJG8u/9hguctyosLs4GOHr6My5vBXYNOyndRlVIslPoTFJxb
	 aSFSC05l6z8juO6thj5l3QfzlxswhtM3zGzYkMO6kLxw0eKoeFEcmanqwZTaogJbn9
	 l4OOmIXTldeVg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:46 +0100
Subject: [PATCH v3 17/47] mm/khugepaged: preserve dirty bits when
 collapsing PTE-mapped THPs
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
Message-Id: <20261031-fixes_core-v3-17-d6437171ecc3@kernel.org>
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2246; i=david@kernel.org;
 h=from:subject:message-id; bh=837bmTNyZDFxi4Sf80pnh4aEoyUZxI11ZPuZCTv9/sQ=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebk8X+frqeqH38feda3+b/Xdb3PvmIzvf120fqh8tl
 rJgmnVhS0cpC4MYB4OsmCJLUPB9g5cv19VWu/Exw8xhZQIZwsDFKQATmcDD8L/CrmbqlZiH9snp
 x18rs4nt6a6WOTlVRyG7dsGrgtN3DjsyMpyNMjTUy8thmW7Vd9yP00f+/9l4ywNMNv/uvZa1ubr
 kAQ8A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

try_collapse_pte_mapped_thp() clears PTEs without transferring their dirty
bits to the folio. A shmem read fault can map a clean folio writable, so
a later store only dirties the PTE. Losing that dirty bit allows reclaim
to discard modified data.

The assumption that regular files are read-only is also obsolete since
commit 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse
for writable files"). In any case, transferring PTE dirty bits to the folio
when removing mappings (and while the folio is still mapped) is the right
thing to do.

Use get_and_clear_ptes() to collect the dirty bits and mark the folio
dirty before unmapping it. Update the comment.

This was reproduced with shmem using MADV_COLLAPSE followed by
MADV_PAGEOUT.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 27e1f8273113 ("khugepaged: enable collapse pmd for pte-mapped THP")
Fixes: 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse for writable files")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: adjust comment; simplify description; cover file-thp as well ]
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/khugepaged.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 34ebb37c862c0..ce794d9760a87 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1995,9 +1995,10 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 		/*
 		 * Must clear entry, or a racing truncate may re-remove it.
 		 * TLB flush can be left until pmdp_collapse_flush() does it.
-		 * PTE dirty? Shmem page is already dirty; file is read-only.
 		 */
-		clear_ptes(mm, addr, pte, nr_batch_ptes);
+		ptent = get_and_clear_ptes(mm, addr, pte, nr_batch_ptes);
+		if (pte_dirty(ptent))
+			folio_mark_dirty(folio);
 		folio_remove_rmap_ptes(folio, page, nr_batch_ptes, vma);
 		nr_mapped_ptes += nr_batch_ptes;
 	}

-- 
2.43.0

