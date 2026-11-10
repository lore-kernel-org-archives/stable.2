Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311499;
	b=Ytecdh0OgGzl/+sh1zR5nFDgAGc5Jdcbdkvxoq5H9kW6NGbf1gehfJKxKo1yOUFte8O5
	 677Fp0UDuhXKCiFIY+n2h/x96XFZW8KHAcvGGwhRVqAhBQctOYx8RhRtd09CHuZf2pWX8
	 HwHrS+R+yfPRYHAICL9WwBokiX/PUnwbt43p3Zk/kHl0bE0nLdJ898WlGQU6hZiXtEtc8
	 0Muxm7+XWuFy6pRNlgDiyTvPISIWwPPaXrmJUOjFJoggq3o0uL/tR+XaGxKs4WaeP+vYn
	 Pq8pMgmPKis46aLLLuO/9crWdrmH/Jg/aOclgDJky9GWwcx9Snh2ODgjNFuBC/vXW/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311499;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bdcJHbcMqJuwQrgxqKJoVDct8dTsY2WZV2zQTS/1CKI=;
	b=HfudXJgPdYA6q48z1mKHmes5uIsr8qJjwIvjmBvTDJJFlq1jSw6mZMyaif3T3HXy36Ue
	 Ah93BNUvTSFpLZ8S+9Wtx1jmBPEcm7sTS8BYUWk5f4QWMbbGHqK5NuKx/E2sJXw/k+cUw
	 uwuRPWKzYoBgFBgatcBzF5xq9JbtLxgRNZ7N0ljv94+AcgdwgSyC/G6a6KlwWR1rng8Te
	 9/tUCLSaTVLHUlv/YGEGyOaoPITF8E5Pg7SpKDXimf42/8apWbkuvlYe7fbDje1aQl3ZD
	 4Db8K3gE1oQyCyPviU0UYeydCNDqsoJCZQIWF20FkaPOHsTvy2lvQJ1iGWeZ5syQC0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFoM2RqL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CD860A383D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFoM2RqL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C961F0089F;
	Tue, 10 Nov 2026 11:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311498;
	bh=bdcJHbcMqJuwQrgxqKJoVDct8dTsY2WZV2zQTS/1CKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZFoM2RqLvU9431g2RumK9tilWDrR2HacSU7puXf0YiaSNAcfrT9vOeXA3y2ZEKOyw
	 7xVlfnhlw0p3xzkWAUduez8CzoKgXtfmYjYTH2r465vyAvrneuyBAhThWNWgRjcso7
	 9GGphM9d8Dd4VRO5SG89Am0RjMBH/6IrMNMlgFZRmX5XOc/pG3Wp1EEmAfwfpUMQbp
	 Z0n9W+K7Al1QxYrnp+DrL4z8KSGwMBd3zNtxhHEm2vyfvUHLOJVYLmgRI0JzzWR0YK
	 P7rw/9EcBzBJMgLeoSKgVkatkUxdkEd3/I6Ztwk02IRXa2oVE2TAwVLqM2ExWmzi5M
	 WTa2mYsH0aMWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	SeongJae Park <sj@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] mm/page_alloc: reject unreasonable folio/compound page sizes in alloc_contig_range_noprof()
Date: Tue, 10 Nov 2026 06:51:35 -0500
Message-ID: <20261110115129.609167-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051925-failed-6.12-4c767c5dd9bc@kernel.org>
References: <20261107051925-failed-6.12-4c767c5dd9bc@kernel.org>
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

[ Upstream commit 0bf2edf041dcb0b304a8dbda8c699771d5a245d2 ]

Let's reject them early, which in turn makes folio_alloc_gigantic() reject
them properly.

To avoid converting from order to nr_pages, let's just add MAX_FOLIO_ORDER
and calculate MAX_FOLIO_NR_PAGES based on that.

While at it, let's just make the order a "const unsigned order".

Link: https://lkml.kernel.org/r/20250901150359.867252-7-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 4c767c5dd9bc ("mm/page_isolation: guard compound_order() against racing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mm.h |  6 ++++--
 mm/page_alloc.c    | 10 +++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1728dc3356089..f05962963e28d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2058,11 +2058,13 @@ static inline long folio_nr_pages(const struct folio *folio)
 
 /* Only hugetlbfs can allocate folios larger than MAX_ORDER */
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
-#define MAX_FOLIO_NR_PAGES	(1UL << PUD_ORDER)
+#define MAX_FOLIO_ORDER		PUD_ORDER
 #else
-#define MAX_FOLIO_NR_PAGES	MAX_ORDER_NR_PAGES
+#define MAX_FOLIO_ORDER		MAX_PAGE_ORDER
 #endif
 
+#define MAX_FOLIO_NR_PAGES	(1UL << MAX_FOLIO_ORDER)
+
 /*
  * compound_nr() returns the number of pages in this potentially compound
  * page.  compound_nr() can be called on a tail page, and is defined to
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 480579d7d59e4..887dd3f06a86b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6685,6 +6685,7 @@ static int __alloc_contig_verify_gfp_mask(gfp_t gfp_mask, gfp_t *gfp_cc_mask)
 int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 		       unsigned migratetype, gfp_t gfp_mask)
 {
+	const unsigned int order = ilog2(end - start);
 	unsigned long outer_start, outer_end;
 	int ret = 0;
 
@@ -6699,6 +6700,14 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 	};
 	INIT_LIST_HEAD(&cc.migratepages);
 
+	/*
+	 * In contrast to the buddy, we allow for orders here that exceed
+	 * MAX_PAGE_ORDER, so we must manually make sure that we are not
+	 * exceeding the maximum folio order.
+	 */
+	if (WARN_ON_ONCE((gfp_mask & __GFP_COMP) && order > MAX_FOLIO_ORDER))
+		return -EINVAL;
+
 	gfp_mask = current_gfp_context(gfp_mask);
 	if (__alloc_contig_verify_gfp_mask(gfp_mask, (gfp_t *)&cc.gfp_mask))
 		return -EINVAL;
@@ -6786,7 +6795,6 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 			free_contig_range(end, outer_end - end);
 	} else if (start == outer_start && end == outer_end && is_power_of_2(end - start)) {
 		struct page *head = pfn_to_page(start);
-		int order = ilog2(end - start);
 
 		check_new_pages(head, order);
 		prep_new_page(head, order, gfp_mask, 0);
-- 
2.53.0

