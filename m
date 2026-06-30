Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8B732FA30;
	Tue, 30 Jun 2026 03:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782791879; cv=fail; b=O6bQRUvBc13K8zCBfrfcPxd6zf5TfN/Kvdb3fmHBRQgLNqwK6KLSsWQN4kbLy8zcWf7W4C4BJRvKoCM9Pkh9jbhw1pikECFoVxnU55W45OGEY9eW7qyTENSDO/rLVoJeG7lkklli/OQYLNNhEXZyCFBgU+Ajy2EB7Y/voxNRImA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782791879; c=relaxed/simple;
	bh=YVMajCH39QGi4vqlNrryL6/ByKZJaykCYNp/4BcPSYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=haoVJpJYuKpaWMJHsS4aYK+id5OSX3QRIcAcWvyBNVb7v8mYXkq54iRhwJOriL1XQAIs89D43zPTE0rdWzQmIVUl2xp3I4iyzt5B+KEJ3Ui6gegyTh01i+saPGQKM27PF/p4EHGKp0/e1L3vghGTay15yUUZ8F4f6zOnWrxmBGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k0MKX4NP; arc=fail smtp.client-ip=52.101.53.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k0MKX4NP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcitB1OLzxbsycbURBR/EFovpgo6CkPu/gOgJiw28UA5CUHt0Az8pWrXqE5Hjdkx0C2DklcrzUuKAcg9PzyBOjM/0uHsGRttdoLE0y69eZNbwbpHyadx56qa4G+OORDfEpVcGyMdS3lMMKoEOTgX0tW5N+3sy6azxRKrO+IZ2snAOWlEHPFJh2blJqbd6rXgzxh95eCMmUhP5E+f9tCkbywwmDdseu33YlUR1T/WArQadWoE0LD4BOkEQUhYXgf+85HFn3EHuf93WNUG93MFBecH999Z1KMPKVlp8mXRWeV+1ebZrFKL0nXJ6wYxB6OmVa3KY97Zopd+znonlUJYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCzlq3HYj1zv2Va/BNBOyGd+88lyQA2ipflVEzC/yiU=;
 b=BAlpuNO7po7FrQe6/f85SqB5nBmyKuWrMEJHNTJO7ulJJl8HXNRbHjBdDEN9+Qo2KFCZAJ3qu0fAFvc8pQ76y25YZy1TANBWfyDV///SVhm0yOgDzubeTIZFZ1O4DfuwLdIr4IaItCK923XC9AEv//JdJgI76Y/UVvLGsYWQxw+RK5RIB6i5/WJZdL1Z/DACyu+SC2b2BwRn5TOzvqt2wXNuFzTuWQLvzltVs8OOmMCIAqfM0osSy5PcK7JA0Kj++XIaNOO2HdFpTxh0qp/5uNvLFQ/3ac7jXcSKCy/lO9UC0FLBpZUb5hUgsN8ZiM/hcLRioARQfQye4relZ3PRVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCzlq3HYj1zv2Va/BNBOyGd+88lyQA2ipflVEzC/yiU=;
 b=k0MKX4NPf3FaG/VvJYbBIA52fnTv8mvUVU+jzXV3kC1NLx6kqHdMjN+RmWbw05pZDw07KS/Kndi3Kqg8KZHLZJV+vhHd5D2tDtsvRM98vI3Qcb9l7jpqu/tP5M9kVKDIGlMD14XrC1srC7HHp6QJUjUAL2Yq5HfQWMQ0ySvtAiXZN1k60NRSKvq5QHQvmk8Mn76IFG3/ylxrD+8w+qRMl4Q5u4eDIszCNSdaXTk/DkOIpDk6DT5QcGe5gaNz2nG8Y7LHdMjW9NmuaDXwfYKcKD9SmLbuSkFHKe2aqkEnwatedAwmwDNWsrnyOdXSfthCX0QzDdqm8bLq4jyLa09ARg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4995.namprd12.prod.outlook.com (2603:10b6:208:1c7::23)
 by DS5PPFDB3A23D1A.namprd12.prod.outlook.com (2603:10b6:f:fc00::663) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 03:57:50 +0000
Received: from BL0PR12MB4995.namprd12.prod.outlook.com
 ([fe80::dde:9068:4b1a:53e2]) by BL0PR12MB4995.namprd12.prod.outlook.com
 ([fe80::dde:9068:4b1a:53e2%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 03:57:50 +0000
Date: Tue, 30 Jun 2026 13:57:44 +1000
From: Balbir Singh <balbirs@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	riel@surriel.com, liam@infradead.org, vbabka@kernel.org, harry@kernel.org, 
	jannh@google.com, sj@kernel.org, ziy@nvidia.com, lance.yang@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [Patch mm-hotfixes v5] mm/page_vma_mapped: fix device-private
 PMD handling
Message-ID: <akMsgZ1i0A6S5ewh@parvat>
References: <20260630021540.17297-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630021540.17297-1-richard.weiyang@gmail.com>
X-ClientProxiedBy: ME3PR01CA0032.ausprd01.prod.outlook.com
 (2603:10c6:220:19f::6) To BL0PR12MB4995.namprd12.prod.outlook.com
 (2603:10b6:208:1c7::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB4995:EE_|DS5PPFDB3A23D1A:EE_
X-MS-Office365-Filtering-Correlation-Id: 309840c1-a8fb-49cf-d95c-08ded65bc0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|11063799006|56012099006|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XkeZIM4zVoAuWt1mgT1GfaYY+kpeVipUgfA5buciNyC2Dj1jyGrC4G5ZUV8tLv1/n5OwfWoZBbYwsZ4g8SFNpe94zlCrkjbtuRPjfd8v4Ufij9QgxeRc+3ji4782D2bos0zNPEFI1ivAe/avTNp9Tp2j3+4Klsu++X5UOzTbbW7HLT9TsrWikxwJX6U7iDWwTqyT/g2SH9gy91/M6+b9j4mlbm07n5g/aHL63iXuSmbp3bXNq8EBoxjejLW2IaqbDA5h74PUTlzz3V7k5E3vSPzYlSKrGcvJxnunV1cPP8HKXZVEDg/acepDsLBrFlXJqN3RrzBfPI1h7u9aD5QgZLxX08fRewiU06wPOXlG57hx3qohXWAd4G1XXziAt4B6m23mw6Aj47+k4v1Ctf1+PAIRBq11QWjN4bnpRP6wlkXZ3+iRVWKRzP4uQODXwj6hplgp9DJchJ0KMav5Zm0Y8BhjUrzo0tf0A6DQTSWO9mhUlimmnRwRNJCntDIBc11/MgA2xEPGFc+87QVQJsV+RD0g/40KL4JbUdnky/tdxiid8bSwWQqOh+6K/+YUqJv6JMfZofBF5wKMZeF401SiZriESAQ4KlhjEANeRHqr4iqbd17x3hoM5c6weFGYR10qKSA1d2X5CnkfqvhocxLLnhO7SS9K7BvI6mpZQBB49J0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(11063799006)(56012099006)(13003099007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wJGvKtqwMDlGeJkUYqkCAsDANksaGxc4pdfYyWbsII4aZJUutAY2gUt4rUvy?=
 =?us-ascii?Q?NrkJP27CbWc47fIcCOPSBwfr7DTAF+Zd8oWXzybtoXSVv/DL3abKtTjwPKI7?=
 =?us-ascii?Q?NPDHWjLLejdouvssQwtFLyiw35Ihkm3UwX/xw+iH+TSzkmNxl3NDSzmnskYb?=
 =?us-ascii?Q?Arqha6EqVOjUV/TGMK2BLIT5p91fLDd84PhuiZUz1ZBzKFcxgeHfWaGmOw6k?=
 =?us-ascii?Q?wB9mqDtpyuQG+2vm50MqUT/2jbJMMLqkzBj/xILG8MZsfWW9afnhKkZJSpw6?=
 =?us-ascii?Q?7U/gF7KPJdObxd0kYtlu4+C1HAvRvvC5mf19NgGGobxuhR7e+Q0OErK3YENI?=
 =?us-ascii?Q?Res/V4RjtIHHZcjyX2a3KzWpqjG9mgFE6COBHJWXgYyOZWGLpVQAblVl0VxP?=
 =?us-ascii?Q?ROnUPjcSqyneNmiWqW0xbd9wGI8+iJQsituj5QpOv0X/NUAwmttGYGYvRywa?=
 =?us-ascii?Q?MODt6wwJNd3tBforlezujXXpAhBEMRkGBDWSHlYDJneWH25NKKWtrliT8uPa?=
 =?us-ascii?Q?4fwqbcyTK0aHG4nmwI+TqxVcV6DKl86x79gljSu9dc8QC8Qwe+07nCW30uko?=
 =?us-ascii?Q?XsnFPaiFnh2KneMtWK4QQnA6Enayojr8x9Qu87dd2CcZuUHilyxpN80Biu5X?=
 =?us-ascii?Q?E3SuXSGb+GQlOQZzcAIUYyv60cvrf3Mlny5yiKXfVDt1fVJj7YGuWCuTt2Ub?=
 =?us-ascii?Q?nkDtGtjMIWMxuKWIStlybRDp+NYP56kbQXr3rv7ka4ahpaXpFJIMn4XV5jUi?=
 =?us-ascii?Q?/8/4HHaH8Y8kdH9lNPUh6YUtQgDzsuWubQo7JQVxG2ZMqKsH40Yesh//jxQp?=
 =?us-ascii?Q?8nOljXjS/WXtZ6+PBPeLUbw5r/sgsEuE7mtrKPWbyFcBSYKwxauosWPHAdHJ?=
 =?us-ascii?Q?x/WkOOunv1OzGdAUYKm8tgkNIusVNF2GHa+ic974LhNCHu4lKqHvAgKZefYk?=
 =?us-ascii?Q?mFEjL3g+mUeiycb/HQDg7cf8lXi1NEzmx2W6gfcFos3vHQPMJ0wcFPaLPK2q?=
 =?us-ascii?Q?XS7IyQbHQSbXZRjFR+7gxkFS6KsLpoido8ghxiQjSYjoHI+bzQiSPEajLnrp?=
 =?us-ascii?Q?3Jb5XIHAI6fByp+ue9p/2jeRtX/MoYv7xMGs1JHWLHm8Iilt/CmGQAcftIM6?=
 =?us-ascii?Q?IgwtS6Nr0yxau9e8aXX1zRVm0fRdQPP4IJMsMiphu6FRGf/HS4RwDCBfvcsg?=
 =?us-ascii?Q?pbb3UyfWM7QM+2AQwWcHkwYYqLG3wh6XTUumgCllGUUy8ZuXzIBalbBb0iBl?=
 =?us-ascii?Q?X6wSdOEmYfeCpBKISP1xlCRGa5JqSkszXTDEOu2CVjACMSTD7ApvJQt7Ju1E?=
 =?us-ascii?Q?KSLWwQWjLG8irv5TcQiDcH+cbNNWUkzYsyH3YXINqXcejJ1t9JJdQSvaFgst?=
 =?us-ascii?Q?jhBBKqWOs20Wa+Z7JOF5KieHDHN2MoSNmV7eyQCWp8IKmoK2CUYSy094I8MX?=
 =?us-ascii?Q?h3um57b/EMGcDDTR3jLEq0nVfxOacRFFosJE65KnNihlQdfkY12biPhg2QX1?=
 =?us-ascii?Q?x2pefoq8sqeDRd91U9AXq5oJDhKg1En3NVUBOeg+8TFQVZDyzCSRSLra2DVK?=
 =?us-ascii?Q?RPnil7zDcaRknnOljIceFEcvcIDrRja0Q6QxNBfQM8CvBsoG1TVQgmzBGd1D?=
 =?us-ascii?Q?Evv8Wlpa2HRFv1YEGS2cx5jzLmiLEvJIMboKCx1aBucj0GCCkrDfAmcXNCKc?=
 =?us-ascii?Q?C6G4cd+Fpv/Ng8jAmKdTyNqpJX293RHIQy0xJ6l230IzbXJ1QoQNrwq6X6tv?=
 =?us-ascii?Q?F043hIA9TQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309840c1-a8fb-49cf-d95c-08ded65bc0d7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 03:57:50.1576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7K5JzleX2X7DbNjMRVpj+tWYt9hgySOXwDDHULAwCgeuuCPL3plAgFPqcY2QlrSkFxAnNLHt4rW01p615IiyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDB3A23D1A

On Tue, Jun 30, 2026 at 02:15:40AM +0000, Wei Yang wrote:
> Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
> device-private entries") introduced the concept of device-private
> PMD entries, but did not correctly update the rmap walk code to
> account for them.
> 
> As a result, when page_vma_mapped_walk() encounters device-private
> PMD entries, it takes no action other than to acquire the PMD lock
> and exit.
> 
> However this is highly problematic for two reasons - firstly,
> device private entries possess a PFN so check_pmd() needs to be
> called to ensure an overlapping PFN range.
> 
> Secondly, and more importantly, if PVMW_MIGRATION is set the
> caller assumes the returned entry is a migration entry, resulting
> in memory corruption when the caller tries to interpret the device
> private entry as such.
> 
> In addition, commit 146287290023 ("mm/huge_memory: implement
> device-private THP splitting") allowed device private PMDs to be
> split like THP mappings, but again did not update this code path.
> 
> As a result, we might race a PMD split prior to acquiring the PMD
> lock.
> 
> This patch addresses all of these issues by invoking check_pmd(),
> ensuring PMVW_MIGRATION is not set and checks whether a split raced
> us we do for PMD THP and migration entries.
> 
> Instead of checking for a subset of the cases after taking the
> pmd_lock(), put device-private along with pmd_trans_huge() and
> pmd_is_migration_entry(). Also remove thp_migration_supported() as
> it is already guarded by pmd_is_migration_entry().
> 
> Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Suggested-by: David Hildenbrand <david@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Balbir Singh <balbirs@nvidia.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Lance Yang <lance.yang@linux.dev>
> 
> ---
> v5:
>   * put device-private pmd handling along with the other two cases
>   * remove thp_migration_supported()
> v4: https://lore.kernel.org/all/20260624065353.1622-1-richard.weiyang@gmail.com/T/#u
>   * refine subject and commit log based on Lorenzo's suggestion
>   * put pmd device-private entry handling in its own if branch,
>     suggested by Lorenzo
> 
> v3:
>   * remove cleanup part, only fix the issue for device-private entry
>   * refine user effect description based on Lorenzo's suggestion
> 
> v2: https://lore.kernel.org/all/20260616063436.20455-1-richard.weiyang@gmail.com/T/#u
>   * specify the possible error case of current code and user visible effect
>   * besides fix, cleanup the pmd entry handling based on David's suggestion
> 
> v1: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiyang@gmail.com/
> ---
>  mm/page_vma_mapped.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 2ccbabfb2cc1..2d6c58488e3a 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -243,21 +243,30 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  		 */
>  		pmde = pmdp_get_lockless(pvmw->pmd);
>  
> -		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
> +		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
> +		    pmd_is_device_private_entry(pmde)) {
>  			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>  			pmde = *pvmw->pmd;
> -			if (!pmd_present(pmde)) {
> +			if (pmd_is_migration_entry(pmde)) {
>  				softleaf_t entry;
>  
> -				if (!thp_migration_supported() ||
> -				    !(pvmw->flags & PVMW_MIGRATION))
> +				if (!(pvmw->flags & PVMW_MIGRATION))
>  					return not_found(pvmw);
>  				entry = softleaf_from_pmd(pmde);
> +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
> +					return not_found(pvmw);
> +				return true;
> +			} else if (pmd_is_device_private_entry(pmde)) {
> +				softleaf_t entry;
>  
> -				if (!softleaf_is_migration(entry) ||
> -				    !check_pmd(softleaf_to_pfn(entry), pvmw))
> +				if (pvmw->flags & PVMW_MIGRATION)
> +					return not_found(pvmw);
> +				entry = softleaf_from_pmd(pmde);
> +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>  					return not_found(pvmw);
>  				return true;
> +			} else if (!pmd_present(pmde)) {
> +				return not_found(pvmw);
>  			}
>  			if (likely(pmd_trans_huge(pmde))) {
>  				if (pvmw->flags & PVMW_MIGRATION)
> @@ -266,17 +275,10 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  					return not_found(pvmw);
>  				return true;
>  			}
> -			/* THP pmd was split under us: handle on pte level */
> +			/* THP/device-private pmd was split under us: handle on pte level */
>  			spin_unlock(pvmw->ptl);
>  			pvmw->ptl = NULL;
>  		} else if (!pmd_present(pmde)) {
> -			const softleaf_t entry = softleaf_from_pmd(pmde);
> -
> -			if (softleaf_is_device_private(entry)) {
> -				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> -				return true;
> -			}
> -
>  			if ((pvmw->flags & PVMW_SYNC) &&
>  			    thp_vma_suitable_order(vma, pvmw->address,
>  						   PMD_ORDER) &&
> --

Thanks!

Acked-by: Balbir Singh <balbirs@nvidia.com>
