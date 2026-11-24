Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795550943;
	b=h/MY2zMGwYrjAVoV7m/hD/ojX+soQmu3jXgo2iNDCgtORzB62AD78QP2h8/QnmYs6xKh
	 tFnlsNvBzZOvLLvZO2pDo4511zQ6U5AGuzXLViohEyShWoDlF+EJNmUlBXzPyLRxtawdt
	 fUnf/cI2T67NIlQvGLi7EFPMLyZfDYYRB7gOsqLB/EMGxZweCleOrJWB7if8NxuyMgnTf
	 2xvDADhKE+HImn4xuQNViLCAaNEoyYTOShPEfIH09JwclC85usgOMVe4RDnUeZsVwgNTc
	 8WfiLf4p3pN4hyBgT37C/YtKIayhew+HKZQ8vbIPobOmBSXjTwcsB9TiBQBB5SdUovw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550943;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qMUvLQ2nQ7/0zmgj4idh0ND9xyPWxYG5eDUiMY+8Kd8=;
	b=uOKt2z0pcVaZAWjJ9UKQE53AfCWzQJwVQYKcuVZLppAWcmJT9Z7kX3ppmKwspHQaSCWT
	 Hg/sWRrkKDsoJL4DHUFnPXBt7Wh3XARRTZ1jZf1wktQkXT7I+TCGRv94CF0zFB5twwJy1
	 3AWr/dWHNBhCorupm7tkei5Ni24QxyyHMBJwotKZADhKNAZCAOfVvs6N70RNOg2V1bUtG
	 wtp3mu41ihzegHiN7TH3opbNkTtJGi9hMGt52DTEtyyZNJU0AJ7gCdHIkuNWzRnAkHdY3
	 LLQmKY6DaA5u4+4tY/DFYGzInkNyYTCrgjWvqSz/eN+tw/QWICBuucMQpnDWXCqdvxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jn5q+ZPP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F257C606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jn5q+ZPP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9BC1F000D4;
	Tue, 24 Nov 2026 20:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795550941;
	bh=qMUvLQ2nQ7/0zmgj4idh0ND9xyPWxYG5eDUiMY+8Kd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jn5q+ZPPz1n/bQHWhwzWWeTV6JMPbD5fZqW4e7Y8UnWBOF0tOHXpnYyuCn0ZzFenl
	 eL9+Ghv63+jHrbFRt1/EPH5qf/q7nFbjUZZqlUFQvIhQUEmanmUAg37kuKQzU96hk2
	 +c+uDUP8Vc36K3xxkdcCxXvE98hKPxscXkpYOKZMSC/+zHk9FqJHisyYgSoZ3p+AV0
	 ASCUCSNYipcWX7QyeGA5i6EyO6XxYyEa5MWPewWIlF1E1A5AowQ5nKsN2hq6QI+jIR
	 nqRA2Ei5vNw9AZjtRhhoYCa2FFf4/zjzQrGjDrCqm+SKMsL95rOTDQ2elU/Eo69Ybs
	 uMCXNU6Bl7EHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] mm/memory_hotplug: fix possible race in scan_movable_pages()
Date: Tue, 24 Nov 2026 15:08:54 -0500
Message-ID: <20261124200755.2539343-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124200755.2539343-1-sashal@kernel.org>
References: <2026112414-subtract-calculus-aa18@gregkh>
 <20261124200755.2539343-1-sashal@kernel.org>
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

[ Upstream commit 89e69c7d187eca8a040d4db0e080f79b5b32163d ]

Patch series "mm: memory hot(un)plug and SPARSEMEM cleanups", v2.

Some cleanups around memory hot(un)plug and SPARSEMEM.  In essence, we can
limit CONFIG_MEMORY_HOTPLUG to CONFIG_SPARSEMEM_VMEMMAP, remove some dead
code, and move all the hotplug bits over to mm/sparse-vmemmap.c.

Some further/related cleanups around other unnecessary code (memory hole
handling and complicated usemap allocation).

I have some further sparse.c cleanups lying around, and I'm planning on
getting rid of bootmem_info.c entirely.

This patch (of 15):

If a hugetlb folio gets freed while we are in scan_movable_pages(),
folio_nr_pages() could return 0, resulting in or'ing "0 - 1 = -1" to the
PFN, resulting in PFN = -1.  We're not holding any locks or references
that would prevent that.

for_each_valid_pfn() would then search for the next valid PFN, and could
return a PFN that is outside of the range of the original requested range.
do_migrate_page() would then try to migrate quite a big range, which is
certainly undesirable.

To fix it, simply test for valid folio_nr_pages() values.  While at it, as
PageHuge() really just does a page_folio() internally, we can just use
folio_test_hugetlb() on the folio directly.

scan_movable_pages() is expected to be fast, and we try to avoid taking
locks or grabbing references.  We cannot use folio_try_get() as that does
not work for free hugetlb folios.  We could grab the hugetlb_lock, but
that just adds complexity.

The race is unlikely to trigger in practice, so we won't be CCing stable.

Link: https://lkml.kernel.org/r/20260320-sparsemem_cleanups-v2-0-096addc8800d@kernel.org
Link: https://lkml.kernel.org/r/20260320-sparsemem_cleanups-v2-1-096addc8800d@kernel.org
Fixes: 16540dae959d ("mm/hugetlb: mm/memory_hotplug: use a folio in scan_movable_pages()")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Wei Xu <weixugc@google.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 213268869301 ("mm: page_isolation: do not take slab pages for free")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory_hotplug.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index bdc064c026ec1..e62c196dfdfb8 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1782,6 +1782,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 	unsigned long pfn;
 
 	for_each_valid_pfn(pfn, start, end) {
+		unsigned long nr_pages;
 		struct page *page;
 		struct folio *folio;
 
@@ -1798,9 +1799,9 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		if (PageOffline(page) && page_count(page))
 			return -EBUSY;
 
-		if (!PageHuge(page))
-			continue;
 		folio = page_folio(page);
+		if (!folio_test_hugetlb(folio))
+			continue;
 		/*
 		 * This test is racy as we hold no reference or lock.  The
 		 * hugetlb page could have been free'ed and head is no longer
@@ -1810,7 +1811,11 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		 */
 		if (folio_test_hugetlb_migratable(folio))
 			goto found;
-		pfn |= folio_nr_pages(folio) - 1;
+		nr_pages = folio_nr_pages(folio);
+		if (unlikely(nr_pages < 1 || nr_pages > MAX_FOLIO_NR_PAGES ||
+			     !is_power_of_2(nr_pages)))
+			continue;
+		pfn |= nr_pages - 1;
 	}
 	return -ENOENT;
 found:
-- 
2.53.0

