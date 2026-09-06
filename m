Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695137DE9F
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788735004; cv=fail; b=MUdjx0bOEqI3iccwLixEqmenTkht2cQ8cqkBJqxfZRVStoRL0Dfq2aF5sKsw9R8CIW6bqFwnUu2faKWFIVUZJYJdWiV+VAk/K7hlEKiC97qOlbNQuGtlc2FuoosRhQM4a4QIBT/8OFvanfG2mTiZZhtgGyepWS7eANtQVRoCQkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788735004; c=relaxed/simple;
	bh=j2GCGCRTpj3kbrn3PLJriPKraq7AGc6qOZABQaZ+Dzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UnvQO4t7niCXbJH2EjKqZJXEYJdwjam5wjyRb/4/E1AXDtjkzDQBiP4bU91CQGl686l+ss3zK1cbdwCfwOt0ovYxTEzK1Ky967ha1hqOfCtNSAhDfPCOTgrQMMNbKeRFGj7GkpNaNCPpT/w5B0xL9lrjPz9crc7ReU7za0G54hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JhAl6Gi7; arc=fail smtp.client-ip=40.93.194.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JhAl6Gi7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zG13VcYMMW3ULSzF33mkx6NTtcRlkjSCFDmHPRbvn0vZGj5LBe7Fa9eXe5fQCnhXT2RIdqtN+fjs83rXLN+Tt7M49IhXTDP9lxZUooIl/34a5wQXKiWq3SZGIvMmF2iBm3zky1rnHxly8uvUOrJfZWo+rmvFCU2yDUQasEuaWFRbZ4dDXhLZAM1K8btNUgFo1LLtfXe9yE3MrfDmXzATA0aMP6UMyUsOaglMhnow36SR9qFeTb4YUROUMX3KPLJkqhoD3DqxgqW/9Id6kNGfabZl/L9QSQcKoNEOdspoThe7JrdT6VTGYbh33fHf+Pq++h5Hzl6WW1eGZOhBBu3StQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2J4pXr+bvoAFfjiAnvF4bBbEGzza05tUbCCFzLmGwAs=;
 b=jaj/Z2KCTUevXXatwjc/oAI6XF4JlO05hSzCAJnSXTg1iqc/t8Dy8ZR1Bk5XChbR7nDDFRpKS9zGjqWF/aVkGsgnb0F7iCDa51XBAizABO6KlwyP/K66+IRMBNf6DeoEth1ym+ZIabojrP1Uk3WlHUErp/qslhRlHXg9HJl1KYygl+dA2kP/9M/E9E3mmqzTp/qqJ6fGhG6EkfiIpy34NBM/mteMsR7j3hmfB/aj91MkhMYnS1Jt8mF0eGJgu6oIsH4DdttqMidXXv5xWyZk9U5c36gkh07vrOz485D4qSdOdfRltZasE5E3urweszuQfapu/JtOuIk0KCWWjyvGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2J4pXr+bvoAFfjiAnvF4bBbEGzza05tUbCCFzLmGwAs=;
 b=JhAl6Gi73LzNFoA9UWVlLztfS39W3TTCN3k9R75MMraTSLqpcrxBIBZNFqwJ9oKY4GIrteEbyIFu0Hz3cIdeKbwcGtLADYmWit1n9Aztpu5w//ACvZTxKbZ+UsJkdusH/HHAHbrl58fVEz96e/2lipm3MdHqt/PRY6Qwf5jTg3hFrSAlKMG2WpIR2Cd/Saxmb3M3cGXpsiXwDy0oGeeF8EfSvRa1tpvzZZpGaGek2Olyh2sHOYiAODW2aXkzsjoLv6tC96ko6TXaYILAFOyTwIZPlBYVoKsdU5LejYmU++aoOU0y8oJ1P8m0g087zWAKL9kFGsAYb9MHUmJ3KPV2XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 22:49:57 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 22:49:57 +0000
From: Zi Yan <ziy@nvidia.com>
To: stable@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	William Kucharski <william.kucharski@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/huge_memory: use folio's memcg inside __folio_split()
Date: Sun,  6 Sep 2026 18:49:55 -0400
Message-ID: <20260906224955.3049045-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090358-bouncy-state-b521@gregkh>
References: <2026090358-bouncy-state-b521@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:208:256::27) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c181afd-57ea-4129-b8e8-08df0c692cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/5qJPbd2nq2XuvGS4wDGXjG6Rsl4MZ7xBhG3eWdXaHPWseJehfumIb7hoF7L/qCb0FIADP7AHXanBMspPJpw+z6pOXqTxFvWa1iNiisKIc6JluublQS1xoMQZP5PBAj8Kb4RMlXVoV1ORqCEByzO6HB3O6DFW4uKbo7D8XQonSHibizahdwkoRPjf1Ieo3wQq+TgJvPBYmdHEWWANlLFJWuSlA5P4j7agLaeR3fQxX1wXvs4r5MRrZ312CqRi9ZJk5IqxTyE81YhMPF9ZHqMbqO1ZOlGJWbaxRRlAin2vgj8cYiympbFFh++sQo4YGkhd/xt/TL2Tb1Q0aFb6e0ka1jH/mSIOO8tGn+ZWHnsRb76/pvWWEdMcPdfwzhj0eef3OXipWktbCPGqvf/O9lIfMcuwm53tM6SVe5M8uGZHLsFxPeoqh24wS8XjV67ShmE0kfvCjRL9MjgKjRGYPhZUo3FUV/BphYTvJ7fKUlM/0qtm0J4E2lPcQFlLCzn93lHb4cX6jth/c55zldBlZBUaG0lzBpbrZkf3xVHbeaBHkrziex9eGWMKK2TQTLqufrCwVkmrcnlc52OIwouCm1buQCLgr2FD1R9bCjbAh+8QaKdUXncqTYGAm91fKs1x2PRfHOS3C8AzMKd41Jn5S3pFv8i7TSZluWABL+o0eORFTQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WAVnm0RY6OR2Tu31pfQBzye+N6XOYkR5mtumSR+RqEZOMdFzTu2YN0Na/q4Q?=
 =?us-ascii?Q?lqM9tZAo+ez6UFBYn9jPv4LvIIqij+rZuAO/bBdf2bUC+IEZUlaZtPc1Y35K?=
 =?us-ascii?Q?R4txORIqUgFBAN2wgzGnGMkMIWtDG5ZX8XdL93qmj1Qu/mtZC3uEpkwOB2hv?=
 =?us-ascii?Q?7cuU3qkOO7BGbs6aEV7v/ZuN0tPBwB3J1YYeek0FNxXUIVKBhqf43b3sX9N6?=
 =?us-ascii?Q?sXfQ3EJ3jaPzASAw07klVwOevE/dAigyZndWgRTG/DJyDKeaYYBVsdCDL7Tr?=
 =?us-ascii?Q?YrBvxnxxdLpt4SxPgkZ69iEsAoZ+lrrGEkU12pNGPGY4Mj2EZurxuXiALItD?=
 =?us-ascii?Q?OoHS9BlizK3bFNNIRUUij7WDZKnuWyUsByU31CGCkHgByihbpehIt87uQabL?=
 =?us-ascii?Q?qidxPrSuO96th+2VoUd6JtxyGsYFQhMi9eBTLPMjNiSzdvKe7qxoCPynhHQe?=
 =?us-ascii?Q?SWh2T/BWiAKf2/yd4FkOJfOTSdPaGAl2SSJkvEXxZo17c8MQdRTn+O7H9Cvg?=
 =?us-ascii?Q?yvAhQi+WQsU5Xdx2JwHgUDpJSAXzoKxg9+SlrYugq4nJvJhQVJuzvmmOPzPb?=
 =?us-ascii?Q?gT0ZQIUjjqv6WZP7WjlugolBdrLCKXj7WiMm1FgKPw6hHR3pqW8z6RlF2VFg?=
 =?us-ascii?Q?KN+qW8Z4y8yXgAFdF+Yplk7d8y/XEm7xP2J39eGH1xoSM0JaxxeGum+teL0I?=
 =?us-ascii?Q?chcWIbqDt8kdmr8rEvP+LOtCbsnuTDd+1ZtaiCWHe69/MqAi908XWRiFa/Kz?=
 =?us-ascii?Q?F+EoGf4zEJXNUy6zxJ8c0rc6iqngwDSnyyTAC4AS76qtcCZuIYxMIvtXdOGM?=
 =?us-ascii?Q?ElPqXlZ+K5UcN+2pAgezHezZLYomg0pEcbAXltJf29PLTVCwfmhKczhJP0d8?=
 =?us-ascii?Q?ScKQkEQdTwokcQLPXTTlHSofh5YkN7JC1wQ51TOQr1DtLKQUAEzqPLCBlXfg?=
 =?us-ascii?Q?vuX3xocEJLYzHCLuEarOznQl6H6HaiVsnwD7SGiCwPT5RXl+U2svcclBKtgI?=
 =?us-ascii?Q?n3dN0Fzyoy6nQvMwxuUZy0d8yLuA0uaq68Ipd7v8dI9gnZJM0aH0nMM9Liic?=
 =?us-ascii?Q?b/ATpN7o1zKmj0rerkzu4XA6ByDExUCyLgSWhx+QZfA9oN1haVFibgGICKfM?=
 =?us-ascii?Q?K306/xxBwxMhPizh8YcmzGTxMLZqm0gfBZOXA2XFswTW+yqNIegUSJKggL9v?=
 =?us-ascii?Q?VSW22HMVyUSXGjwPnTbJ1t+SBBYrTwluqtaQqxQ0z6XQCwFw0QYCc822loib?=
 =?us-ascii?Q?pGlD1MuahOuIuQLnC+KwG1mQSaJCYx/nUKabuhPgSn5N/5VugxgaHwfAPURb?=
 =?us-ascii?Q?UvyS9XP3rcw7iCAks3j8Xcv+l+8u3bKC1LwlCWZAgBGgjaTDDcq2qzEAbVDZ?=
 =?us-ascii?Q?6O+qtxxGvYOySqYG3iifqdYo3kKGCP79LiwGoTqYvW5nYtj9qyMgYEostz6h?=
 =?us-ascii?Q?DylBv7j2m5mH4+pvyoQLeQltcHwrSWOqJ27Ys6k8RZz3m4HGzrZcKArM4bT+?=
 =?us-ascii?Q?kMxFih+2uWJRt9ghKnU6pqzRst9etihdOVEiuZkZpAnC0kyFGi1TwSJRyE0E?=
 =?us-ascii?Q?oknAOu7wo4d1fmZjdmL+2wenywgFoXoP55jr+chy6+eQWYVmYVAoo+zP9iLO?=
 =?us-ascii?Q?LxkA3wZX8J1ehS1fX6zouWh1Ptknzp2wI8MV9bvdW9WDO1RwpPi+k8W33tzF?=
 =?us-ascii?Q?M2aqrwH+zpMRwIJQhLr4Tro4U4BOL5z9sbyNMFc7qIMZVNN5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c181afd-57ea-4129-b8e8-08df0c692cce
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 22:49:57.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kh8IfeARfsphXZivJSn4TE2HtOPLNSJjCzhAU/NbCZtG9l4QomS1E8vd4ok0+nUH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935

Patch series "Honor XA_FLAGS_ACCOUNT in xas_split_alloc() and charge to
folio's memcg", v3.

__GFP_ACCOUNT is needed for xarray node allocation accounting when
XA_FLAGS_ACCOUNT is set. Commit 7b785645e8f13 ("mm: fix page cache
convergence regression") fixed a workingset regression with it.
xas_split_alloc() does not have it and needs to be fixed.

In addition, based on Sashiko's review[1] and Johannes' confirmation[2], to
charge the right memcg, folio's memcg needs to be active during folio
split. Add that before adding __GFP_ACCOUNT.

There is no workingset convergence regression related to missing
__GFP_ACCOUNT in xas_split_alloc() and the impact to userspace should be
minor.

This patch (of 2):

During a pagecache folio split, an xarray node allocation can happen and
needs to charge at folio's memcg instead of folio split invoker's memcg,
because for example folio split can happen during reclaim and reclaim's
active memcg might not be folio's memcg.  Switch to folio's memcg at the
beginning and switch back afterwards.

Link: https://lore.kernel.org/20260804-add-gfp_account-to-xas_split_alloc-v3-0-38cb3ff325c5@nvidia.com
Link: https://lore.kernel.org/20260804-add-gfp_account-to-xas_split_alloc-v3-1-38cb3ff325c5@nvidia.com
Link: https://sashiko.dev/#/patchset/20260727-add-gfp_account-to-xas_split_alloc-v1-1-9fae6bf64838%40nvidia.com?part=1 [1]
Link: https://lore.kernel.org/all/amtcBZ-_QVRgCd6b@cmpxchg.org/ [2]
Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit c299a2285d9d8bda4da024455de65e3d00de6f17)
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 35a9a0271492d..483cdc373a20c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2676,6 +2676,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	struct folio *folio = page_folio(page);
 	struct deferred_split *ds_queue = get_deferred_split_queue(&folio->page);
 	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
+	struct mem_cgroup *memcg, *old_memcg;
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 	int extra_pins, ret;
@@ -2694,6 +2695,13 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	if (folio_test_writeback(folio))
 		return -EBUSY;
 
+	/*
+	 * switch to folio's memcg as xarray node allocation can happen and
+	 * needs to charge to it.
+	 */
+    memcg = folio_memcg(folio);
+    old_memcg = set_active_memcg(memcg);
+
 	if (folio_test_anon(folio)) {
 		/*
 		 * The caller does not necessarily hold an mmap_lock that would
@@ -2821,6 +2829,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	if (mapping)
 		i_mmap_unlock_read(mapping);
 out:
+	/* restore to caller's old_memcg */
+	set_active_memcg(old_memcg);
 	xas_destroy(&xas);
 	count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
 	return ret;
-- 
2.53.0

