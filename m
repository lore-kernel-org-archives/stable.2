Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CB51DD0EF
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788488827; cv=fail; b=DBHUvvINIr93rfINC7ORtLVH9DNvvarDiAaA01X6CeC0dQHbk0W/aAZBim1wNG5ZpTECcbnP+YkdGERLl4S1Z7tyM6tDQBA8T13exu5tzmr3hQuLXyn0mqXDXyOJQjC1ERTcz86xv1jqjpyDMWF9sCeLnfj2UzS2R93/cSn4Sew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788488827; c=relaxed/simple;
	bh=opsMhhEBl6iTuVUK5v2T7sa0fE9Jlz5geCtyY3xKYIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XG+U5CDHdqGH3o2ngC6K1J2uQmAdjK1egioTxgLzuBgqima8fXxHGVFcQjphjX15JZb6iXKJ06rmboEqZCraM81/r8WYXdJeBLSjV83fkYtJs7rzNPJRhzJRdDMYeJ6UqqjuuN0dzhQnLlIaTSIBKanOAnSggGoS/4XGUIM/1/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UjchBHqK; arc=fail smtp.client-ip=52.101.53.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UjchBHqK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMHFa66h9gpxhibfddaqtBjGBfwlWH472jV/NM6bUDFOntOGp6KS8rC09yxlxeiUr03li+C/2uLflA40E9NuoJAuthvhLqLJlt96qIbPOfW+MxIqvPRHPQNFgYstvg56HhHs9eyK+57ZG3sm1szT1RlNlkxb/Bhkgsbs5+W9kD6ghwGB5VyRjnrcSOROEYRGsKCu/FyIEfVfIHFJbE9ikRPMowOyq+iuT/BjdtF79E9rVMAJYrkErZSaWYUZTKRsQNS7lAblfSkpEEfvlWFwI9FfxbxgOCFjRFhZG2tQikLZPzQ9yiDHeRIhl158p6Ss7EUE3Gwb+qLrj9VEs4BLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLjg05m/Sv7xxQqbSO8CFbohWYXDC0y9/jMGg7x0hFs=;
 b=fSIEns9EaUGKrdJR4RxLjbD8tBPmDUS7NljxTEFD3+yYh9cR5hwwmluDVe+uvN2vq9na7HlTQGewyC6duHFMH8b7WSbQSvfx96bEeBB7jsmgyQydYwls2PqvBs82MStQOZWNIjMoCbZyLckW93g9csijDPPBjmnId7ptt5dugVeh6vnbaNAohpwvr87dRFIVPH0ZM/74IKRqFiLsT3cP+vdqZIOvuDAlwI9OG/ZgMm0gI9Wy+H9M3QaSfpTmFufdlnAVKsCt9R+AAq6jzPDEYW5sVHklpOEfWe/p5nZNr8iwCqg0aOCfgwBg4NKlrCFEz+03i1468SXCtPiaK080ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLjg05m/Sv7xxQqbSO8CFbohWYXDC0y9/jMGg7x0hFs=;
 b=UjchBHqKVTaAPf0FNJ8rXBRBgLTihGdQ/dH/O4ljpeuLRhkr80PV8A1Hv7VQNiCLWH1AWWXDe2KTCTNdIkQrRl9AYgkqMWIAbwsVk/5DaEm8CZvNR55+EniId5O4mx5IZZlIcTCYC2+T5Mq87y3eaEC6Wu2pFYf7Bq7Ll8BLbmYcHBISLV595hlp+LokFkvkXLMvhqx1O2b2v4F3K0J85SLVgQ+iCYCTB9DCqFaRCmsXT/AxB3nTFsMAYeveEZbjKBIVC91AuANUbAgtuM1FFV8puAMIKcz87roLMH323FJQHzGos7g+rbEJ5ItB8FuGNdxpXWlhMbOnN52RQZ+OGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 02:27:00 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 02:27:00 +0000
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
Subject: [PATCH 6.6.y] mm/huge_memory: use folio's memcg inside __folio_split()
Date: Thu,  3 Sep 2026 22:26:57 -0400
Message-ID: <20260904022657.2656810-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090357-daybed-breach-27b2@gregkh>
References: <2026090357-daybed-breach-27b2@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:408:ea::31) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: a4095eb8-0cd3-4ca6-fe9a-08df0a2bffc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|22082099003|18002099003|56012099006|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	4nQKZQ4tbLa3Mo1Pcy4vkVI2/mLLwpgFActiX1zEneXC/2Af6CiTE3ELpBhqgqvk/7lP4odAakXpgHkGjHPMpfWb07HrqeruIJQAVD52mKzfj+yA94387irgQQTrLMnEZyr+AG0AOhYEA9WUFpTkA44tDgPsFzyhlZMpOw/6FOp6gv2nsdBNge8KnsmSoavcb3Fa/gqjIo+2SImb3bg9AeslVleNN6I0zzg59z2jSb27Jx2FU9Egz1pTaw7AvmMKlvAjrSjxqrC8ftNbpd9Do0ckv3yf2RtNzCbJuh0+bzYFXRHeHbjA0BcIiSRkCNEdcn8LM3+CZDNWusT0TQyxH/uXVWbXCfudstlw5IWiWNZyUbTR7daNsuD4ztkvlR7aFjCgD6NvXGe3tkARohZhF3clCOOJNCqHmLweEu0fvtnqH0XhxD8yAYj9g1XH5zjB/Q6WaguclnqhZm/oybBEIOTjaoKvJ700GY0UExRMjvmB+/QD27eEpdAJ+85ypYbCZJGMwDoL4+iewk00Yzs2yZNl1oGf1hIRXulTp89UsxPicMdsxFIcksvxAYiPg7pbtm1Uopg1gAceFrI/QXGG3qNhrQjug0BdMS07bHaLGq0qkVbSyGsChfP5kR8bFAqjmGcGzxQpzKiV/JO9zDjrYZACxzf24sw35mXO4EEOm6s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CvO9wBj4sKYpvhTliAcOwhh+IdZks+wEiy9f9Hbc2iNwO/GDrIGd2NC9SmAV?=
 =?us-ascii?Q?+X5tp8Zi0+tNAsw7U4xhRaQsfHr/rH6hNprBzx3vuq9Wdl8QkcDXYJY51m8W?=
 =?us-ascii?Q?K6XNhgwMfoCWQuW8Gziqieq5pLBVFqmAr6WNXeFh9YPv83sD8a0bQSYa0jIV?=
 =?us-ascii?Q?sO+fTLe91ke+QVqzSFpQsXyZa8B8Jwv+IuJc1LBIfw3HEBb7CcYEPoSDEftF?=
 =?us-ascii?Q?kOcyxPiKKkHF3gFFT/Sfj57j8idq0k3T63d6SV82IKfm7NViD+VrZlA6Cth8?=
 =?us-ascii?Q?/69JTS7c/TCAo07PZq5pJsDwCPxWl2RorYsF+ckty8R4QgzEGsSrHgzTtlNk?=
 =?us-ascii?Q?iGU8ePYYEpRR67tXHaYq8O6HYK4aaQdkU3sUqNg700CF/yntCFYoMFvL3w8o?=
 =?us-ascii?Q?HS2T8iA8io62hGKnSxO1+rnvzw/PNYmgO0+vh4njQpNey/vjHFja8+1XAZL9?=
 =?us-ascii?Q?z8StkGIuV97j9kgGwl7VZBNlxgj4pcVmLqqQgfIZB5QtQ+Ss9irZGfDHlr44?=
 =?us-ascii?Q?BuKrYczebCViQaNS6g8cCpdLhLaDoiIX5WXF7BvPb1UcgE283KS75dxPimp/?=
 =?us-ascii?Q?jma53+tbkR4hteFBR9tn42kTNq/UNcaoFIAbRxhQpRQdkf/uqp0HNSV8AJLB?=
 =?us-ascii?Q?gO55TJjRIbmBTMH1oUZLjRy/IZU/zQN8hwEctzvtm24THbz/dgcDUpWfLMCC?=
 =?us-ascii?Q?vLeSXS2SWD6auuGYTYr2BCHQxCLht0c+hguUVQI7AEySRcugUGFWpg/V3jnD?=
 =?us-ascii?Q?6/eJb307W6IttaXHLe4w4Iu/zdXRAQanV4iVHMgApVFyYUNrMm9VlgzeTiU+?=
 =?us-ascii?Q?fDLA4sD3nUp2istU8od1+CLIifjRItQyr4miJiOYLjLivd13RXzd8PC5Pr0+?=
 =?us-ascii?Q?XhCXbi5xX9Z01UYk/Bp8TZX9seLU9dBvhgo8WwqyZzBcUvczKYdagPKH6XdE?=
 =?us-ascii?Q?kRyr/jlZt79tKBdUeH53JWCDbY0R2A7lRvALFlob9R8qNWKCPFwo8F51+HO5?=
 =?us-ascii?Q?sxN+fdAkmxnisTIqnj/F32tQC1KEjC+pzkT8esfie0/9JyEkP/J2ME5yXY/Q?=
 =?us-ascii?Q?X1tpOaTzoOgWuYb/iAyDg3XfbIrcTrj3XF6tJxHGBpLhs42u3KTtqsiPcWIs?=
 =?us-ascii?Q?45c/oNCCxl9SmKixy0E52ku1L3UengPhZGEHNKAlbxbMSguRFR7stOjSIOrW?=
 =?us-ascii?Q?VeNAcrdBlhzxw/NPlAb4VbeaCdGcMZvl//ucKlZ8d4qyeYx3iFfyBlW0weWb?=
 =?us-ascii?Q?r+HCBU2W9FpVQQGD3CW8IdjrYayM6J1Q2DdHy00vXD86USsHMxYvx240VUeE?=
 =?us-ascii?Q?LyIs6FbaZac8xy/I4kwRYFnl2+ha0PIizhqROy6GZn5EezOXA00CjkmCwFSR?=
 =?us-ascii?Q?KeqVoi39u6koyDpKzOcjOM8pQ+N4PG/XFgVnOIhrdNRbCs95i3xBPvamFigs?=
 =?us-ascii?Q?CqZ/iTimiI4hLNEA0P6g2IOUI08jfsEdz7mxBvfegmsF0PuCGpkiNF4emAjv?=
 =?us-ascii?Q?gljjhsDYqSWg6aTdbbTqedTGeSKkoXyKdUFcoQxoJuvfQRVk7iqKxg7fjJSo?=
 =?us-ascii?Q?aZPDhfyQNo7uX5FsEtH+igcbMMKQImW6GlANLHpibNOZiykc2OcVVdsg6kJ6?=
 =?us-ascii?Q?KMyEFqY/ABMelqB3QbMFsWoJQp5hqYhzwj5zsQlNYM//leeGCOc88c+f6ojZ?=
 =?us-ascii?Q?7JSXlwVhCgm9+Emr3CSR4ASuhyFydF02UcHHnA9zRREjz6qN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4095eb8-0cd3-4ca6-fe9a-08df0a2bffc8
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 02:27:00.2327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WTDl48eaGAvpwm4fWtr42xnq7f4dNh3zTuQuQ3W99+Sb4TiA/TTjfFYBKN+WOCa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723

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
index 7ab6779849243..8df057bbe1bca 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2646,6 +2646,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	struct folio *folio = page_folio(page);
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
+	struct mem_cgroup *memcg, *old_memcg;
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 	int extra_pins, ret;
@@ -2664,6 +2665,13 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	if (folio_test_writeback(folio))
 		return -EBUSY;
 
+	/*
+	 * switch to folio's memcg as xarray node allocation can happen and
+	 * needs to charge to it.
+	 */
+	memcg = folio_memcg(folio);
+	old_memcg = set_active_memcg(memcg);
+
 	if (folio_test_anon(folio)) {
 		/*
 		 * The caller does not necessarily hold an mmap_lock that would
@@ -2792,6 +2800,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
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

