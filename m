Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF4448F85D
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789237786; cv=fail; b=XYZ49Xpr1t5cQlQabhYjobojXBwyQtvzywIJN/+VUxi89GH0SUoBLi3AgEzV6H8Sa23ZJAz2+/gjEA5iMRIY4W0VlhDdiw1+sD0yWON+o/42mRwYrTRsrmESeZSSHOZ+8HXNtmxuGkXcmQ6psXdfK/6akYKcMDVAhWmCGq7h/zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789237786; c=relaxed/simple;
	bh=Eqv9SMToPJndlBt1REPf0Jf5fBWNp7QXjlRXL1HO2IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XklDYLwBNtgeh2JhtpZw6KgN4y1oeC4o0G3iZB00VNUJppJwyIQcSdnqq1YgZNr7HlUfJoNk8M7FszhxotFjVBh9irO3tcpwfu0MPp4hbj1mlYKs1z2jhOPCUIJAdKpV/pv5wxcdc7DWLle9uglCunvGu2m/j3Lo4pIp6/KJ8EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kpmc+mCa; arc=fail smtp.client-ip=52.101.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kpmc+mCa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOQegND5wOXHQTIH8s140DTCJoLB0RuEcwOmTz/qSYsbZqKkIsDyLNFtKxTooyQtUdV0vX8tG+gueKcZ042Tv/SUgDeMwe2u9iw0PKhgYy8p/PkqRzN0Ms53L8Ue4CtB0E44FNHHZ6pwvHokTLUtK/vn0ypc0Jhfg4q6KwVqfc1TWKK1Gw1MGQuwKp05C/yND+U8k5BllLr9Vxkz7zMYwm9+pDcrrUY1pMmU5R8MokqPp3Ql+xuAnQO4pkXrjGvgC4WHZrqXuEGfAF2Phl5kEREsXy+vvQ8V00zhP7261egElqXNxc6byz86uAh/ynn5SW/i+qQjvYu+pHIGDgh8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1tFbj4nI5aR7EwugDirHTzJVfpS3EVL8S4TRVjt6ZQ=;
 b=rqA4k71UjgZohIunKwY7WaXxZywS1JnEF9hXQ9Xww2i9IolucEJfIrxDmc6WAm4OF27N9XDQ53X6hoRHYTPi2fJeZ0OzWDgveiXQM1MKQ1nR6B4pIdRmM53308PqYyJ2whARfy0k5RcBc3/CDNF/jljJMcpWr2K2RRdfTlEsqXj7l8pgENmOcUM51pH7f6H11X+HqQuGL+8U8xX8O5rEYgJMaq3hMo+zt74NZOD09lI9pw4OO/JXn9M2Pps7dycw5ivja7daLdZxm1DEQHd/sBk6Y7MyVrjbMd2bePjhtw/by+6Egm12zU2yZXeuMG9iY8Sp2QVVHExTkAxkEuaHqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1tFbj4nI5aR7EwugDirHTzJVfpS3EVL8S4TRVjt6ZQ=;
 b=kpmc+mCa2NFy9f+GOoVX9F92LIxv6xiQJ83Mdb1BKLEcVq3FnL4TZB9D5/HLyBt0W8sMqy76oQ9EX4OuOnuCMb801lKn05LsR5GpIkX6EV2dP0Z7pGSTO3WFLSzUyDDCR3S7FdbPVydHfT1vHv39KGgcyTvW5oHE5qd12gFgPc5RNQpgg0iZRgNn5vA+LCB+xxFh29+HgGpypMOYyLVDN2AHYwNS8fB1281x9zrivsgCt4dsB+9og6uSYf7jrilXTHVqlwfA+d/6eSWhzsNvUqRIw8gPwc8KPhD4VQNcDYNzO4HMTopO8rQvK/IObfIwoxMnzvg2wuf9nIXf/cggvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 18:29:38 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 18:29:37 +0000
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
Subject: [PATCH 6.12.y] mm/huge_memory: use folio's memcg inside __folio_split()
Date: Sat, 12 Sep 2026 14:29:26 -0400
Message-ID: <20260912182926.1326147-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090357-tidy-granite-4a68@gregkh>
References: <2026090357-tidy-granite-4a68@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::9) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: bf49c973-f3d6-4046-3c1f-08df10fbcd58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	HrlgGCKUwjnyfe7DS+6tYBX9KMVb82Nk3vlgINYYgIYWHB2ACo/D9CZRgT3S9NkuvbWsg5xQ9EiU/WMZ9SyjeCWNqtSnSHNNarYLKwukzReJ0oH8iXMWIp7QA5iDd7ph9+1/H9ezWV21Zcyvr2b7ENwwjEPrZr+rElfZTW99+UXPHA4MDiUKcSrx9kU/Q7dTlEYVeWl1vDc5HCXDZIBF8e4ov2OP1WE9GfAqGicyUyA+vhdS69Uu4lfHx5w7NtDKbl7F4OpGTuArtTXM2U2stiQm6o/M6z1n7MFC47mTQNwbHxmChQNC6Ehzs1bL7W/5GYuv/NdZ+MjNgyjc7xxcRagDasZAxC35KtosQ1ljJxu3yZPaVqC7vpPFqTyT9QcCCr/pFDvHZBlU20XL9IrOEwum0xsB2QDJKMGctB+6p+txzWVeXlpdrL2yf+ArkkMCZPCgATENFB0s86VCxcvY2ZbLGo1zJO17FR8kq+CiHR/VBms0r9M9tEO3gFHc49reqwMhFE0hJQwj9NwokFLr+5FX5ePg0NX/eJbun+Jbe6ekLe4zqkZLdwEWSfnWk23YU81mJ7VYLnnlgKuw7P2/9Yc1qIx1nh3hMeixO1t6Z9I8yJCD8EILW0SljO6jIH37m+vgQ5V4NapAY3PQJnlLPGsCIVstV5bbhTnrGsiFyH0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dxFNR/H0X87tI6CO4cZtI28A07UMOJyK+MXp5g6dT4pqCZLs2DkBj8iijLyc?=
 =?us-ascii?Q?JDV2aIjGBbiaHnlCRP2NAT3lA36VjiC+kMr5Ik2SUBb8pWVAGXIohObM9TNF?=
 =?us-ascii?Q?6arc2O44cUcGGNEUnKygPhNVu3RIk/BY0vzdzmha1TbxJzu3Gdi7KRSoxdxE?=
 =?us-ascii?Q?t0vPpbfRkY6Ojd9ETBtTUzQNyYKoy4jCMVfZ+I82gBvHAB58EQYKX2lG+GQi?=
 =?us-ascii?Q?qOOgGeKa3rRcm5iEC/ibi8mKg+Zj7E71yMj1vFRLDn6horDTfsMWCKxyjONP?=
 =?us-ascii?Q?iwNdrZXTMbmHSS6IAK2wtdH/Wc9nn4avBnIgVvSFuW0cBuuOxYY2sJwV79DY?=
 =?us-ascii?Q?xpIwIKsJ9PhHAsXQkN0M6/VzhcsWKdB1i85U5YD91xALlqZyqTFUKKJZZ3zM?=
 =?us-ascii?Q?GQuDXYeeqPSwgVWhwWmsZ49+5o3htUdz56x5cyzm8T7ACMPuNFLW0zTbNNNL?=
 =?us-ascii?Q?4/Ed6xQ264N5frxANxOyvPQ2afUZJL+6T0+HkQkZ7t7XqDaBRewCoICerLCy?=
 =?us-ascii?Q?8QCzv8LZ7Wi5geDCFRKtDzDusS/opVOAO7zrpZFtq1VvpnKNT9Da9RG9WE9l?=
 =?us-ascii?Q?wmPmWKHILaiPqnWmKl848McMGCSJauAnB63Xpdp6fZXNwL0odapory99GY1G?=
 =?us-ascii?Q?MkYCLRH/rDsNZv5yc4nHC6/p8B7n5zmxNxo+4NDJiA9gp/gsehG10rJkR/B6?=
 =?us-ascii?Q?ETaJ1MYIbeHd9G9rZ5nOKVTkj1WYjyjYTCpf1sPs4m8lVa0/IezFw/49CHbp?=
 =?us-ascii?Q?rgVKtM5EtlMOlfQ0S36aTb6zOfZgWlDHIuDdem9/GAP3nU2pxk/sjhUkK/fM?=
 =?us-ascii?Q?/Aq8GuFWbcpz0vHpsUth3OY6y2zuozYq8k0D73ot6jDOwzQ6c32fko7f9L8y?=
 =?us-ascii?Q?KZqALXclTuL74RtocpNd/creuloKwmRqRhzBWmqmiKNgQJ08WP3Dr8WXm2HU?=
 =?us-ascii?Q?89aAxXPQmjQ/Z0Y33O/Z72+6l8XdsjFS1XZS4Ju3oys4ff2DSzstx/BAor+m?=
 =?us-ascii?Q?XTIOKwLpoMVkHoyyX//JPGGdygcAX4+L54wD5UbJ1xCFtvSSSsZhB5RQL5q2?=
 =?us-ascii?Q?YwdlxNZ/Jz5+vGtY/fYDGCa4O4cf8Guv5AUKWblNdRsCxY8uMHm1D+6Bn/A2?=
 =?us-ascii?Q?RV/ypMp4qaNB+jny4uQrsK43MGqhZ0mFRiOaMOBPEVelsBFOg8+qUe4UT7Ow?=
 =?us-ascii?Q?pi23lOO3RYehMz3iujfKYbSN5DKLYnXSTVZDdwaMBAxJkZV5oJP+9X5zERc6?=
 =?us-ascii?Q?/ms3lwQlsuVRHcYCXYm6l/mNSmDfbOypN4r60OX+cSC3XEbfgZeywXu8tUeT?=
 =?us-ascii?Q?fLwDycGEF3nKVWahget7ocZ/CEBxF4O51+iT5Mnvwr4qONQkPH14HTo3ZlwY?=
 =?us-ascii?Q?L9flZ1XODo+FbDQ9dBeHDdTDhxQUWK2ElaU3loHX5gs6FaeodEq6YMgcxCzk?=
 =?us-ascii?Q?TPu0X5mj1aMHIpS09083Tim4ROVUaNVXdsN9RrehAPzdm+z9Em9ccfkRzq4i?=
 =?us-ascii?Q?GRfWtEgq26+/WZRGJbMIsNBuSuS/TEZJ+hrkOTnU2hfH0QAood20cvrkvfvv?=
 =?us-ascii?Q?YWQDO2s+mHA7h2MiQWf8AtQ1sjfb/CW54IL1WN62VVa36PxymqNgdtS7WIYV?=
 =?us-ascii?Q?mdcD8JhIEk6SukLmqJluAoCxeSgL1gBtF0Pv41qfsUjA2GCGKskcELc6GcEo?=
 =?us-ascii?Q?iJ4wmw3jcKRhhlCyUT+ApCeZtm66FWxIMVqgi3MIB5VkEiF8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf49c973-f3d6-4046-3c1f-08df10fbcd58
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 18:29:37.8760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSJBsS1xg8JmFFlAE9jfc9dCz/L7wmHEfN6Cm81SMrddO7+0qZISyGQpC+Hro4ku
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610

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
index 6fc4e1fb88ae6..1a76a21724d40 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3420,6 +3420,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	/* reset xarray order to new order after split */
 	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
 	bool is_anon = folio_test_anon(folio);
+	struct mem_cgroup *memcg, *old_memcg;
 	struct address_space *mapping = NULL;
 	struct anon_vma *anon_vma = NULL;
 	int order = folio_order(folio);
@@ -3483,6 +3484,13 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	if (folio_test_writeback(folio))
 		return -EBUSY;
 
+	/*
+	 * switch to folio's memcg as xarray node allocation can happen and
+	 * needs to charge to it.
+	 */
+	memcg = folio_memcg(folio);
+	old_memcg = set_active_memcg(memcg);
+
 	if (is_anon) {
 		/*
 		 * The caller does not necessarily hold an mmap_lock that would
@@ -3629,6 +3637,8 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	if (mapping)
 		i_mmap_unlock_read(mapping);
 out:
+	/* restore to caller's old_memcg */
+	set_active_memcg(old_memcg);
 	xas_destroy(&xas);
 	if (order == HPAGE_PMD_ORDER)
 		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
-- 
2.53.0

