Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046141;
	b=yHoSm7dtrV5TeoHJCDouiDu25MnQrxSlSWfKTD9EMDGbkkxMI9csDH6Bdsb/25NDUZ9I
	 X98rbwFhYqd6eAt36fSunnHqGAXHLeG7362hihqEzt5IS27fZLtebzpnglHcIkSIdJeK9
	 ie3vQUf4A2xGfaociZL94+sFx4SG87/Cgh1Bqvst9S1YoWfgftnDqmwQWM1F9Ceog7fTM
	 yZG2fcEcBi5+lgDOTrSbViq8yxdA4M7swzycjO1wnWLZn6PXpSoMKWAq9Rg2VOo0PQru7
	 ntqOZ/XoUmpTvchUxfDkK28BlfN3oqvorHzBiZYGxvPGaAEWwFP/3t0/Og0TiUa2r2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046141;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NGazPAm3F38YYvtUUM+56I0Md9q0G5iKM09J8x1w1o4=;
	b=WIcJEYsio3lSCnDOOfKSWS4JWGOMT6pjd91HYBktSKHKhU2oIRraH9HWzdWDOt/VzDGr
	 YJf0Uy2zWPdfEEWhyhES4OwJWx+Tgd5Fz6kr4HWbrMiC4zXzvJ1nQpmIavw1IJnusQgPD
	 eXuGXH1o/PbodXY0IzumzYzjnyec0GLIGWJ21x+VWt2pkQmgpbr7GdsJ4qyrS8V1HQ+jd
	 WLIDQ66Oxv6bXlyFxN6qDY79omFQyz9HMPQzDexmgpWFUqEdS7cIdskijPocAY0g544CS
	 bsA1hFEAyX4aJ0WDSjgqYxbPSKhN/RwvdToe69vDiftBAqqLNY8gooSgcRF4YD6WACw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKm005T5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3242606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKm005T5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD2A1F0089F;
	Sat,  7 Nov 2026 10:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046140;
	bh=NGazPAm3F38YYvtUUM+56I0Md9q0G5iKM09J8x1w1o4=;
	h=From:To:Cc:Subject:Date;
	b=OKm005T5kzxSrPZB2dZ8La6Uiw+QsKgVrKptI03txjgH0orQc5x0ts6HAcMkRon4v
	 FEn5BOVAO9XLxWOs5rC7Vh+szo6jVjvXhDRFd4PPVrgeKa9IEb76rRaw/kO98XX9JC
	 HGJ8yMPPgJewCT+QWf3/Avkp9fZaRX5RgSHP+x8LIaTl11rTJc8tYe+5POjQrJxr1d
	 C3GLdskvqxEjNjXGc5ni/5LaqV3GNr0CNftXInUfph58CwFJs0QXRKzv4ww21wnsBu
	 S7G5akMNkn1JZbFo4Lc5MItBepuZRtUOP7rV2a1kzmu5bCg5a0SUK8OVm3lhlN9Fsn
	 w55QPqSu7haEg==
From: Sasha Levin <sashal@kernel.org>
To: ackerleytng@google.com,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	joshua.hahnjy@gmail.com,
	alexs@kernel.org,
	david@kernel.org,
	rientjes@google.com,
	dzm91@hust.edu.cn,
	fvdl@google.com,
	louhongxiang@huawei.com,
	jthoughton@google.com,
	hannes@cmpxchg.org,
	corbet@lwn.net,
	liam@infradead.org,
	ljs@kernel.org,
	mawupeng1@huawei.com,
	linmiaohe@huawei.com,
	mhocko@kernel.org,
	rppt@kernel.org,
	nphamcs@gmail.com,
	osalvador@suse.de,
	peterx@redhat.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	surenb@google.com,
	vannapurve@google.com,
	vbabka@kernel.org,
	si.yanteng@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm: hugetlb: return -ENOSPC on memcg charge failure" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:08:56 -0500
Message-ID: <20261107050856-failed-6.18-956aeff185e7@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 956aeff185e7e16b989202bde0bb29859adba99d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050856-failed-6.18-956aeff185e7@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 956aeff185e7e16b989202bde0bb29859adba99d Mon Sep 17 00:00:00 2001
From: Ackerley Tng <ackerleytng@google.com>
Date: Wed, 9 Sep 2026 10:11:00 -0700
Subject: [PATCH] mm: hugetlb: return -ENOSPC on memcg charge failure

Patch series "Fix bugs in HugeTLB allocation when
mem_cgroup_charge_hugetlb() fails", v2.

In hugetlb_alloc_folio(), when mem_cgroup_charge_hugetlb() fails, there
are 2 issues:

1. free_huge_folio() expects a non-refcounted folio and will
   VM_BUG_ON_FOLIO().

2. -ENOMEM is returned, causing an infinite loop retrying the fault.


This patch (of 2):

When mem_cgroup_charge_hugetlb() fails with -ENOMEM, alloc_hugetlb_folio()
currently propagates this error.  This results in the page fault handler
returning VM_FAULT_OOM.

Because HugeTLB allocations are high-order and use __GFP_RETRY_MAYFAIL,
they bypass the OOM killer.  Returning VM_FAULT_OOM to the #PF handler
without triggering the OOM killer (or having it make progress) leads to an
infinite loop of retrying the fault.

Avoid this loop by returning -ENOSPC when charging fails, which maps to
VM_FAULT_SIGBUS, terminating the process cleanly.

Make mem_cgroup_charge_hugetlb() fault handling use a common error
handling path, the same handling used for
hugetlb_cgroup_uncharge_cgroup{,_rsvd}(), which also don't trigger the OOM
killer and hence opt to terminate the process with a SIGBUS.

Link: https://lore.kernel.org/20260909-hugetlb-alloc-folio-memcg-charge-error-handling-v2-1-4b4a8a19a7f7@google.com
Fixes: 991135774c0e ("memcg/hugetlb: introduce mem_cgroup_charge_hugetlb")
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Alex Shi <alexs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Dongliang Mu <dzm91@hust.edu.cn>
Cc: Frank van der Linden <fvdl@google.com>
Cc: Hongxiang Lou <louhongxiang@huawei.com>
Cc: James Houghton <jthoughton@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Ma Wupeng <mawupeng1@huawei.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Yanteng Si <si.yanteng@linux.dev>
Cc: <stable@vger.kernel.org>
---
 mm/hugetlb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 84552c993cbbb..a16d04aae6196 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2851,7 +2851,6 @@ void wait_for_freed_hugetlb_folios(void)
  *
  * Return: A pointer to the allocated folio, or an ERR_PTR on failure.
  *         -ENOSPC if cgroup charging fails or no folio is available.
- *         -ENOMEM if mem cgroup charging fails.
  */
 struct folio *hugetlb_alloc_folio(struct hstate *h,
 		struct mempolicy_interpreted *mpoli, u8 alloc_flags)
@@ -2924,7 +2923,11 @@ struct folio *hugetlb_alloc_folio(struct hstate *h,
 		 * were committed to the folio and freeing the folio
 		 * would have cleared those up.
 		 */
-		return ERR_PTR(ret);
+		/*
+		 * Return -ENOSPC, since retrying the fault is futile:
+		 * the OOM killer is not triggered for HugeTLB.
+		 */
+		return ERR_PTR(-ENOSPC);
 	}
 
 	return folio;
-- 
2.53.0




