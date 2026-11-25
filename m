Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646118;
	b=U/cI9Oe9uaLSISJZLuWKSC2V8D6uR0r3BKm9efvQSejNXTFWPz8ihzYD7FCrPZMwtpc7
	 BoYOVVCkizdJtkbJZYo1GFA0BEX5cOMbDOdQ8oCqm4udwK+/QcmtVo52YDXpfwLOniXK2
	 M85TDR3nikS8gT46WHqVPdjHGX8v/nVs/fkZBDVS8cgcOO8pUjgTSXuYAHDRto6zCulcZ
	 7ImH9sQfSPPQK0PDgh4EWHxPzjxEhttj6rg2hSOBs84S/VJ8/5fM0+MigQ+KiNSxh623l
	 cS2lRZ1WWCvtR0LUaJEDU5fBhkf+RvR8E5iISHcrlaQBl+msXMcpjc0+tbm+RGsOVUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646118;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=w5mNH968v323dmL6m4gmXpdiBkuKWTr3VPaky7Yir+A=;
	b=VlcvrqEGe8oKegFdaRD01y/qlROvnz53tfBCM+vhbBtgvt3M00I8OLfx3+9lJb1Sxq5V
	 dgULxwUNnRAWbg5KpkstrArg8lhcotSSglXktWfmssa3z0jD8ij1EI0kYhJXbg2WGHgv5
	 JC84ls82EQ8MW21C6sVc0Ipwt0xTZ6rfNbVb2j+hrKwSB7g26Km5Os/OVMlP2JCGGebZ7
	 Zva3YEKaXzTB2ZtLIJwcZC6IUmQm3HGK+FUVzpiAOad5lDIdEOZ1DDAdPhh5kdme+327v
	 VnsP6KC6ilJHXHB8onPb2WxicragmEbvCIrw/w9Ja/ujwnxdWVzptoZmHkmrlaaCJAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BzFioPWw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF6D606A321;
	Wed, 25 Nov 2026 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BzFioPWw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2721F0089F;
	Wed, 25 Nov 2026 22:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646117;
	bh=w5mNH968v323dmL6m4gmXpdiBkuKWTr3VPaky7Yir+A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BzFioPWwZxbExKLSe08Fa0ivlL6lHi7dvTOisegf5JPDpHT+Lq7ZPzanBnMs77+Fb
	 lGKn/KJ5YC/5v60dOgClKpw2/IxOHB7urFqM0XnGzzpGXTTNSDfJTpLeUvu9Ljb/XG
	 cljMVHxM52grhgfzhAVGzbFI+/0RB28n8ZcPi4+A6sQpPpbhN02ipGG4ebQfkHr/XK
	 55Ak56wAZEETfdTosBo/o3sO4+vHiGPhr5z0xPLyLHobAotHC2EFlUTWYuFItg3Vwg
	 C0JDQBvgWH46Xhe9+SoLZ/ryhXSJ4Z6YxTEEiMHE05x2E+BAjEJOpgHdcEVLBs58gd
	 /S7pvXq0tre5g==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:33:05 +0100
Subject: [PATCH 07/21] hugetlbfs: don't zero poisoned pages in a hole punch
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
Message-Id: <20261125-hugetlb_fixes_2-v1-7-db27fd2f71a8@kernel.org>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
In-Reply-To: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Jinmeng Zhou <jinmengzhou22@gmail.com>, Hongfu Li <lihongfu@kylinos.cn>, 
 Andrea Arcangeli <aarcange@redhat.com>, 
 Mike Kravetz <mike.kravetz@oracle.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Dave Airlie <airlied@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
 Mel Gorman <mel@csn.ul.ie>, Dave McCracken <dave.mccracken@oracle.com>, 
 Andy Whitcroft <apw@shadowen.org>, Adam Litke <agl@us.ibm.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
 Lance Yang <lance.yang@linux.dev>, James Houghton <jthoughton@google.com>, 
 Yang Shi <shy828301@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Wanpeng Li <liwanp@linux.vnet.ibm.com>, Andi Kleen <ak@linux.intel.com>, 
 Kenneth W Chen <kenneth.w.chen@intel.com>, Hugh Dickins <hugh@veritas.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Joern Engel <joern@logfs.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Michal Hocko <mhocko@suse.cz>, 
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, 
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, 
 "Kirill A. Shutemov" <kirill@shutemov.name>, 
 Sasha Levin <sasha.levin@oracle.com>, 
 Guillaume Morin <guillaume@morinfr.org>, Wanpeng Li <liwp.linux@gmail.com>
Cc: linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Andrew Morton <akpm@osdl.org>, linux-doc@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1724; i=david@kernel.org;
 h=from:subject:message-id; bh=Og+oDJ5oT+0Zxzn7RN40KfH9k0WlARjP75JU4QfF/So=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk1SEFvKmLbU4vGfeg6UVF95WvrSyu348uGB5ZFJ1e
 bHnA7/LHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEzkWiojwxNm3YrF/LPDXG89
 +V8bE9NV/lWU/6unmurxP7fbeu5bH2L4X7LnxZlLR+/+/sV2vPWkm3Jwd/MdMWG7jNrnU/5Y3+9
 4ygUA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Since commit 8625147cafaa ("hugetlbfs: don't delete error page from
pagecache"), a poisoned hugetlb folio stays in the page cache, and we
must not access its poisoned pages.

However, hugetlbfs_zero_partial_page() zeroes the partial folio of an
unaligned hole punch without checking for poison, which can cause
issues like machine-checks.

Let's fix it by simply not zeroing poisoned folios. We don't really care
about their content: the folio can no longer be mapped, and read() only
returns data up to the first poisoned page.

Only zeroing the pages that are not poisoned would need more thought, as
we cannot reliably identify the poisoned pages; that is future work.

Note that a folio that gets poisoned concurrently, after we checked it,
can still be zeroed, and sync'ing with memory failure handling is also
left as future work.

This has low urgency, as it requires a hole punch on a poisoned folio.

Fixes: 8625147cafaa ("hugetlbfs: don't delete error page from pagecache")
Cc: <stable@vger.kernel.org>
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/hugetlbfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 2e8672ae2fd52..5437a55d14f1c 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -656,7 +656,8 @@ static void hugetlbfs_zero_partial_page(struct hstate *h,
 	if (!end)
 		end = huge_page_size(h);
 
-	folio_zero_segment(folio, (size_t)start, (size_t)end);
+	if (!folio_test_hwpoison(folio))
+		folio_zero_segment(folio, (size_t)start, (size_t)end);
 
 	folio_unlock(folio);
 	folio_put(folio);

-- 
2.56.1

