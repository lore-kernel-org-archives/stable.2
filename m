Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3A143C041;
	Tue,  4 Aug 2026 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877485; cv=fail; b=IxmvEArSZ0QiJvFtGloHgcbvZ8Bcyw0aCVoyXQ3gUEPYCBTzpbih3GHXIrpwmp6+4tgSK0gkOu0COJBDeJACMn1Gpu1MOQyr97efBeri/MkoRVLpYFqh3JtEmLDl6wiUJPuIzMOsKIvt4KH2Am0CLCqx9fWiCUUz2elEK+YITd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877485; c=relaxed/simple;
	bh=rgtYSwXHwksjqXwGlijJogfFcMwi7Y30iUeGkonEpNs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cKoFudYyoDDwp5ldxe2492EjRPJJNuMATki1DZO+9pW0eHWF3iXKx3GLEpN7ZIw5wBoi30eLRsizW59G5Xjz0vly7Njlt5tq/GmocZSL838dj921NetWSDf4BdsOgyQ+iiNV7oTH9X8btw8ukFF8+zSHvriUy2trxEMjCvuje0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EW4FO1hf; arc=fail smtp.client-ip=52.101.46.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EW4FO1hf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1uTLntJmy59JBtzK/uzI8rwWE72A/Ht00t3TS2ftj5vyRQtd2O1s+3ukLYdHDjm4cZE7qpBuRPZB9WJdR/rug4b7FC6Sqo3tOBlFihezAi1C/EL6FBRXBb/N3oEu4SQJdlKkYPAkxUGjQUxM34Ecn4iR0AEnse1jg+ZMTAfSO8MZ2T9KKhUmNSkds1w71DG9yIThME+QOb7QGqnpDmqTSmDgraLdJVYCunyxtK9JMpTREY5qRT7LaoFWb851DSkG0Pl4oSYvpd0s9UXoQGKJSHlJwFwpsMTT+i5ohDPoPG+m4VfrPJDWxP7OCT9l8vj/9mFcmqbdltUYJ2PEn5M3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M65fuUMw2++PfxGntXu9MinzCJClkKf2AuF4s0zZYRI=;
 b=wdL8XEfEkiF3GvdHSjfpZIGsp9rgbMgH17RFlFgFCFoQ4krlX6LoSUmUOl64HW2q0iVfimm+WYgHBHqDDRl9Fc8lymNvGqCLRFuGImZzZza3lYiAbBMoawyn9Bwv2cobs/FJCwkLBJxBHT8g/Jmnci22HvyUNa9a1KckbFqCvzAP+0lIBRzK+mnytRJaREyZ+F38wN1AhlcW5z6pN3/FSdo03fBrp8BfIMHWMEMXYjMsOsFAobLKH5MInnL0ldwp9sQicRXq5J6nXYt6UqjjFq+cvNBbbvV3L/e7t4mrdJ365dq9Kh2LxeeeDpCry19FC/HTJTi9W0gIX9LQURmCgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M65fuUMw2++PfxGntXu9MinzCJClkKf2AuF4s0zZYRI=;
 b=EW4FO1hf5AQCOlGC6dmEutP9FrhCS0DMYvpUl+fT+SjyoEd+WL6V6nDIrpeM4spcMKk6ASDg5YA/m04WZ0kHu8iUXaQZUIq2c+KP61o3j5IPVqB+7wEoqUO9v+vFItzNhK7UL7u6MVrt59Wz3qANftJMM9J+qtMmTkYdauyZTplgc+QP8E/JV/TwZWZ62wDUcxCWYhk4scGXaZl628e1qx5388f00YNRrS9tEWBsEbRbk/h+D5AsTjJN/A2uV3wC668HxtfrjofX46rT4kULI2l2bphmlytc5pLauWu8wttdXVZvM33PeBlNQIGZ0WlpdjoXazhHNlePojT3CrNtZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) by
 MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.15; Tue, 4 Aug 2026 21:04:38 +0000
Received: from DS7PR12MB8371.namprd12.prod.outlook.com
 ([fe80::23d7:9e07:1de8:d80a]) by DS7PR12MB8371.namprd12.prod.outlook.com
 ([fe80::23d7:9e07:1de8:d80a%3]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 21:04:38 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Tue, 04 Aug 2026 17:04:27 -0400
Subject: [PATCH v3 1/2] mm/huge_memory: use folio's memcg inside
 __folio_split()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-add-gfp_account-to-xas_split_alloc-v3-1-38cb3ff325c5@nvidia.com>
References: <20260804-add-gfp_account-to-xas_split_alloc-v3-0-38cb3ff325c5@nvidia.com>
In-Reply-To: <20260804-add-gfp_account-to-xas_split_alloc-v3-0-38cb3ff325c5@nvidia.com>
To: Johannes Weiner <hannes@cmpxchg.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Matthew Wilcox <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, stable@vger.kernel.org, Zi Yan <ziy@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: CYZPR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:930:8d::15) To DS7PR12MB8371.namprd12.prod.outlook.com
 (2603:10b6:8:e9::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8371:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: b18329e3-2af8-401e-db03-08def26bfe6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|6133799003|56012099006|11063799006|5023799004|18002099003|22082099003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	5vNNY5tC+kTm0WcbXT7p8Vwtvb/RP2wGNj3DWezNfkt2KF7hO74nh4P/Va2e5QfiF7/WXn34TSMKxsc9X4PpiBdWSgn+r1cXWlGJ3aZ1S5fqjaa0E7lXi7/75MiMM4VDBW70l8XAKXkAg5/XYMiKhplC51vizqj2m3RyzzHFfiXMaVBcTrJF/rPcUaUZ6c45ILeoAnoZ8zHBlcHeBydxBk7OpmO42zyqPCIdNyn6s3T5bsxBgWkG99Mqe1zYHDdcRk6qiX8w9BwmbhzU/WQItoiL4w1ltMkHkQICFBhU1/1saQkwk6zw5yc/NurcSJ3DRH9g/TlacHEPH549ggI461V3kxAwP8La7v9esERV5raVRH7T5wieC8ejVsrmS3XYTCo2ITAfF+RJ+9Dew3J9ynFshNCSPa6kEPD1bxEvOGNlEW94Xz0EQMrumZby+t3giD/dDq/dGOAgNIHcxbcNFXG64eB+CCll/FApP+Hbly9PxMi6tygLdpC1hkaaEaxDs8KrA9llB8WO7LsutBm+FXGDMOt8KS37axcUKb3mOqeGFCIUINEjF6mCA74jLvNRI7GXMnQju2HZ1I9CJmcgQvU4Sex9JrH36VCHxLd4p1dW3ipF5dhKDrS/6ZnfqXVPTmRnd1L39fvEEcK/CCa6XMivjFM1NoolxrXNE8ApR5sLE1PpYcDwjszlL3TJRAWfiS1O1z/VvyNFHfA7g/SWrg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8371.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzJkK0c3alkyRmdWN3FoNGlwN0dZdjVncGxoaE16RlJWL1JNbDdjS05La3l0?=
 =?utf-8?B?eUZaalUzc1ZUbkFzYldKUC96VzdVQm56bEdXTzlBZGxNeWc3WFlyazZaR3VE?=
 =?utf-8?B?c0ZQOU03cEtGNkllQm9SdFd2dnJNL0I2d0lHODRiN2czWHpEODNHdk5zbEVY?=
 =?utf-8?B?VUF1S0ZjSlQ2djY1WWxacmU3QTRMeVZoK0pLVnlkQVhkalp0dXcweEtWbUU0?=
 =?utf-8?B?MW55Rk9EUmdOeDRMWmpodTJyVU1jREFDNTVYSW8rd2Fia01iT21MdG0rcG8z?=
 =?utf-8?B?S3hYVTFyYXdQRDhQaStsbmluZVF4NjdqQSt1aVBBN2hZd1lHazJEUjBFS1RL?=
 =?utf-8?B?T29TaVBmWlV3S2xKdnNSNDhlTW05bE1pMTNJdTJmOWlBKzErUk90d3l4ZGxT?=
 =?utf-8?B?cFV3WkR5Qi9YQlFYODZ2TEI0aDFQdnlUN0tNTVY0TXMwWVdpWENjVkxZMTlI?=
 =?utf-8?B?YmZ6OHMveTNYVHVxVmlQL0U1ODNtWWllaktLY0FWTkFOTXFsTldnK2NjUm1a?=
 =?utf-8?B?L1BSRzJCWnp5T0dIZktiajFKdGtid2JVWFVQRGxoQStxOU9paGtDMVd6OXVx?=
 =?utf-8?B?RXdCQ1I3RWNEWHU3M0plRkhUUnF2YjVPYjFXbGpoNGo1SjdFNmQ4UDFxRFF2?=
 =?utf-8?B?QjNrOU9SN3ZTd3o3bUNBejRmcy9pdzk3eURiM0xHV2F6RG9vdEhJbTYyMU1C?=
 =?utf-8?B?bVJBSTRCMk5ubHF3cUowZ0E5Umphd2dsdThxb2ZySFgrcGJOWFoxcE9UcEJR?=
 =?utf-8?B?ZCt5U3AxVWxEQkQvb3Q5Y1pqSkxacVRZaXJOVEhzU1BGd1ZGclR5YzkrVU1P?=
 =?utf-8?B?YjhsUmljYm5FajdKTzh6bWNic29jS0tMUnkvVjJ0bVROZDg2VkxMY3NSTlBz?=
 =?utf-8?B?aWNFcm1RKy81NlBiQzlLTTZ0eW04Y2ZZeEdpaTMwM0plNmVKQWhWNitKS3RH?=
 =?utf-8?B?M0QwU1YvckNIbDNvSmZsTUZlKzl2TytHTzE4LzY0OEs2MUM5Tk80cllRejFV?=
 =?utf-8?B?QWY1MUE4dnF6NzZ6K0NEMFRhdFl4SUhtM1hzZkcwTlZyL3hyNDJSd3ZnQ1d0?=
 =?utf-8?B?MWJ3TkxHRzVSMHgrd3hsR1ptZFU0MTdCRFJJV3phdk4ybHJIZ3ZnUTM2enhj?=
 =?utf-8?B?ZmtoQ0pmcTRPNEd2c0hJWFVZN1BtSVA2amphQnhaTXpVN002TEZ0UU9XWjJH?=
 =?utf-8?B?UWl0SkNQbkROODBOMlVCTUw2Q1YzM0VuaXIyWTB1bWFpZGplWk5JZ1pQWFkz?=
 =?utf-8?B?WWVHZkNWN1h6cmlJUFRWWWo2VkI1eUxXSFo5S3JxdGVReHU4WWkvRDN1Unhr?=
 =?utf-8?B?ZktQZ2tHM1Y1NU5NNWJvczFzMnNMSjVraHJXNnRmZHBTRVFrcVByOU1VZld4?=
 =?utf-8?B?RTJJWGJxVFlObm5rZnVldjI4WUY2UElkV3d6MGtIeWQwMVpQd3RzRlhtME5l?=
 =?utf-8?B?VC9tNm82LzVXMGpvRXQrZ1FrdHc4YWxLWWpDbys1NTRTSGE1T2dpeitJMXBq?=
 =?utf-8?B?ZXdITktsWHBoZ0UxRXFEQkJqVWZITEtRSHhFbTlXTXhHbUpqYWk5T0ljcXhM?=
 =?utf-8?B?dkg0M01HWTZHbzBQZ3lRMDdtaUlCd1VmaWVndFJQa0R4d3BQTEsvL05uVnNV?=
 =?utf-8?B?R2hia0ZKWVRpYjBqd0RYeUs4a212V3p1bEppT0hvZldBZUhPUndsV3hGSER3?=
 =?utf-8?B?K3RNVXV0MmVUdzBray9FcDB5TmtDamtGSERjSVlqV21SNVZnNkVDQnJlTEQ5?=
 =?utf-8?B?VXd4cTFhaHdzVlNVUVZEd3dCL1JXOCtDMDRBdFZRaW40c2tKb2RmYnJWeUlB?=
 =?utf-8?B?NVVMQ011Tm1lRktZVE03SWVzalhnZ3F6ekdwZUg0R09TTk42d2J0QVk3TTYw?=
 =?utf-8?B?a215Z0lXUHRKR1NseHhPYnRrVTg5WGtBK1l3d1U3bDMwekRZczNYclZ2azha?=
 =?utf-8?B?aksvdlFFM0xqZW55czVoUUkxemhsZk44MVc3YmRWak54TGRYWkhENUxTSyt4?=
 =?utf-8?B?SGRvTEFLRzNKTzNyWlM5SVN0NDdkTmZIYWMxaERIdkhDY0d3SzhjR3h2bjNF?=
 =?utf-8?B?di9SUUx2c1VYTVJLaHRIeDFPVlgxdkJwbVQ2Yy9wT05jNFhUR2NJdXJadXdH?=
 =?utf-8?B?Yk5MZkxucThWNldPNkN1cDFLVytWK3dTcEFTbEI3YWNmSXN2WWFRb0hBOStO?=
 =?utf-8?B?Z0pRNXd0aG44Q1hUVzlVMHBoN29UTTIrSmlOZGJnR2RKTlJnSVlkUDhHckZj?=
 =?utf-8?B?ckhSZXdSWURCQUY2T1I5SHFBbStmMGFzU2FPeWFVbEp2NzVXNXExay9WRzFk?=
 =?utf-8?Q?KcLZwn0vW/ETFIu2PB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18329e3-2af8-401e-db03-08def26bfe6e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8371.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 21:04:37.8855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ir32UyVCNyra+rWI7HCTMwLE/mUtWTUGoAhl9NGkcjNF1fA5+O2wznI/2v46lPZr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269

During a pagecache folio split, an xarray node allocation can happen and
needs to charge at folio's memcg instead of folio split invoker's memcg,
because for example folio split can happen during reclaim and reclaim's
active memcg might not be folio's memcg. Switch to folio's memcg at the
beginning and switch back afterwards.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Fixes: 6b24ca4a1a8d4 ("mm: Use multi-index entries in the page cache")
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org> # depends on mm-hotfixes-unstable patch: mm/huge_memory: initialise workingset state before folio split
---
 mm/huge_memory.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 04e8a6b553435..b9c2d8908e564 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4063,34 +4063,42 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
 	struct folio *end_folio = folio_next(folio);
 	bool is_anon = folio_test_anon(folio);
+	struct mem_cgroup *memcg, *old_memcg;
 	struct address_space *mapping = NULL;
 	struct anon_vma *anon_vma = NULL;
 	int old_order = folio_order(folio);
 	struct folio *new_folio, *next;
 	int nr_shmem_dropped = 0;
 	enum ttu_flags ttu_flags = 0;
-	int ret;
 	pgoff_t end = 0;
+	int ret;
 
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
 
 	if (folio != page_folio(split_at) || folio != page_folio(lock_at)) {
 		ret = -EINVAL;
-		goto out;
+		goto out_no_memcg;
 	}
 
 	if (new_order >= old_order) {
 		ret = -EINVAL;
-		goto out;
+		goto out_no_memcg;
 	}
 
 	ret = folio_check_splittable(folio, new_order, split_type);
 	if (ret) {
 		VM_WARN_ONCE(ret == -EINVAL, "Tried to split an unsplittable folio");
-		goto out;
+		goto out_no_memcg;
 	}
 
+	/*
+	 * switch to folio's memcg as xarray node allocation can happen and
+	 * needs to charge to it.
+	 */
+	memcg = get_mem_cgroup_from_folio(folio);
+	old_memcg = set_active_memcg(memcg);
+
 	if (is_anon) {
 		/*
 		 * The caller does not necessarily hold an mmap_lock that would
@@ -4231,6 +4239,10 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	if (mapping)
 		i_mmap_unlock_read(mapping);
 out:
+	/* restore to caller's old_memcg */
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
+out_no_memcg:
 	xas_destroy(&xas);
 	if (is_pmd_order(old_order))
 		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);

-- 
2.53.0

