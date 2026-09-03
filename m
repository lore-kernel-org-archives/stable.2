Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92314457A6
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788454769; cv=none; b=rPaHE4lrShIRA/7cSvV34Nh+J4KrrGHHy5xcVhMFpI8YOGtD0Wl2nLiXKw+2J5BuX19bldDALYOqSpSbUWd5MB6PlgHme6EK+ljy3BOe4YBEmvPHTIhEetr98U0n2kLCPD3N85ojKb7vRHIgy0KZoYVKq5G5G7vBpQ4Jif1BYXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788454769; c=relaxed/simple;
	bh=pqBUpKO9RuobgoPBnBbbON59ufC1xI/K26lpi5/cmiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjhPUOz7wUVYik+VhX5RpHVju/agnEEiQRkPuvOlkJYf6GP/fjoxyPuJpJvKuzK/1u92S8naVinq4qu3EnhSQis7U5PCeKLYCdpXOSKb2w53uAUVU9qWExtvLq3jl0cnBt8sBVGtYZVKTa8a2iLz3jxuSjwY8rHtDXe+3x1ZzMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUsdki0E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUsdki0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A765F1F00A3E;
	Thu,  3 Sep 2026 16:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788454767;
	bh=lh+2guTtP83su1Wt56D+kO8kCRt6Dlnf2TXILka9pF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZUsdki0E0JXSnTkeYxgk2am+tf/WjLSYCnp/IOMjeeHYZq19cDpb2h85p3uHWsADH
	 CzQE74El7pVamlhRlfVwn9AaePejK6K9a7vViW9zHVGyxk4gwZdBID6RGAJHsjkp5U
	 yUTGgPnrVcykKILoqrGLXZaBWVOZAs1rs8yJQKRkZVFuDyrYDCngwboEFWc3chGtdj
	 FKy9s/POcdRC7n1idIiOJc7vZLWQ0GfDf7v5v/lQ9eygbC7CrA6xjCY4H5ZSyJgiYY
	 RHHI5TulR6lIPYg9Fp4XrpKlMeBUEcfBkZsEfkQgFty9zDSGKQ2UsUyaWioxRQsrRG
	 WTW83Oxf7XH2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kiryl Shutsemau <kas@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Baoquan He <bhe@redhat.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Frank van der Linden <fvdl@google.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	WANG Xuerui <kernel@xen0n.name>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/5] hugetlb: remove VMEMMAP_SYNCHRONIZE_RCU
Date: Thu,  3 Sep 2026 12:59:13 -0400
Message-ID: <20260903165914.1085906-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903165914.1085906-1-sashal@kernel.org>
References: <2026090320-cufflink-ambitious-4582@gregkh>
 <20260903165914.1085906-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiryl Shutsemau <kas@kernel.org>

[ Upstream commit 01b1d0ffb6f7f37f466033cf167959946309ed3d ]

The VMEMMAP_SYNCHRONIZE_RCU flag triggered synchronize_rcu() calls to
prevent a race between HVO remapping and page_ref_add_unless().  The race
could occur when a speculative PFN walker tried to modify the refcount on
a struct page that was in the process of being remapped to a fake head.

With fake heads eliminated, page_ref_add_unless() no longer needs RCU
protection.

Remove the flag and synchronize_rcu() calls.

Link: https://lkml.kernel.org/r/20260227194302.274384-15-kas@kernel.org
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Baoquan He <bhe@redhat.com>
Cc: Christoph Lameter <cl@gentwo.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Frank van der Linden <fvdl@google.com>
Cc: Harry Yoo <harry.yoo@oracle.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 6e25c6a9c7ef ("mm/hugetlb_vmemmap: fix __hugetlb_vmemmap_optimize_folios()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb_vmemmap.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 1f1c2ccca3159..f96d00a3ef2ee 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -45,8 +45,6 @@ struct vmemmap_remap_walk {
 #define VMEMMAP_SPLIT_NO_TLB_FLUSH	BIT(0)
 /* Skip the TLB flush when we remap the PTE */
 #define VMEMMAP_REMAP_NO_TLB_FLUSH	BIT(1)
-/* synchronize_rcu() to avoid writes from page_ref_add_unless() */
-#define VMEMMAP_SYNCHRONIZE_RCU		BIT(2)
 	unsigned long		flags;
 };
 
@@ -407,9 +405,6 @@ static int __hugetlb_vmemmap_restore_folio(const struct hstate *h,
 	if (!folio_test_hugetlb_vmemmap_optimized(folio))
 		return 0;
 
-	if (flags & VMEMMAP_SYNCHRONIZE_RCU)
-		synchronize_rcu();
-
 	vmemmap_start	= (unsigned long)&folio->page;
 	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
 
@@ -442,7 +437,7 @@ static int __hugetlb_vmemmap_restore_folio(const struct hstate *h,
  */
 int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio)
 {
-	return __hugetlb_vmemmap_restore_folio(h, folio, VMEMMAP_SYNCHRONIZE_RCU);
+	return __hugetlb_vmemmap_restore_folio(h, folio, 0);
 }
 
 /**
@@ -465,14 +460,11 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 	struct folio *folio, *t_folio;
 	long restored = 0;
 	long ret = 0;
-	unsigned long flags = VMEMMAP_REMAP_NO_TLB_FLUSH | VMEMMAP_SYNCHRONIZE_RCU;
+	unsigned long flags = VMEMMAP_REMAP_NO_TLB_FLUSH;
 
 	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
 		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
 			ret = __hugetlb_vmemmap_restore_folio(h, folio, flags);
-			/* only need to synchronize_rcu() once for each batch */
-			flags &= ~VMEMMAP_SYNCHRONIZE_RCU;
-
 			if (ret)
 				break;
 			restored++;
@@ -521,8 +513,6 @@ static int __hugetlb_vmemmap_optimize_folio(const struct hstate *h,
 
 	static_branch_inc(&hugetlb_optimize_vmemmap_key);
 
-	if (flags & VMEMMAP_SYNCHRONIZE_RCU)
-		synchronize_rcu();
 	/*
 	 * Very Subtle
 	 * If VMEMMAP_REMAP_NO_TLB_FLUSH is set, TLB flushing is not performed
@@ -582,7 +572,7 @@ void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio)
 {
 	LIST_HEAD(vmemmap_pages);
 
-	__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, VMEMMAP_SYNCHRONIZE_RCU);
+	__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, 0);
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
@@ -610,7 +600,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 	struct folio *folio;
 	int nr_to_optimize;
 	LIST_HEAD(vmemmap_pages);
-	unsigned long flags = VMEMMAP_REMAP_NO_TLB_FLUSH | VMEMMAP_SYNCHRONIZE_RCU;
+	unsigned long flags = VMEMMAP_REMAP_NO_TLB_FLUSH;
 
 	nr_to_optimize = 0;
 	list_for_each_entry(folio, folio_list, lru) {
@@ -664,8 +654,6 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 		int ret;
 
 		ret = __hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, flags);
-		/* only need to synchronize_rcu() once for each batch */
-		flags &= ~VMEMMAP_SYNCHRONIZE_RCU;
 
 		/*
 		 * Pages to be freed may have been accumulated.  If we
-- 
2.53.0

