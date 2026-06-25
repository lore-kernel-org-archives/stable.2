Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8229935028D;
	Thu, 25 Jun 2026 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385958; cv=fail; b=Qky31d0IJx6ndfDnRgThJzNebkOrRJOXv4/b8WW7XnXQhEvfrSlROb/rxFcx3190FQM71k9zgHBTGKAQoGQRkxtRHczJlGYsiC7n470CvrPz6PzI3aSJNUurjEA0w0je2ap/D3QFKcn4JgdyQ8TuSdvgXzwxUjXF9ZLNYdvtuQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385958; c=relaxed/simple;
	bh=GXz6mMHulq0Vquxz3T/aupN6dZGTxJzmkJa3lnK5mxY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DcttXfeQPbsFvbAxG91gNNt/A+Rq6WD3F07byDEbzghXFZOJv1Z86AbrhP2TbZEUAnRst8NPlpIZurwJmuvqLMo/SyyANA2L4vbooVTFpLGL45UEW845CAIUWzw9i7QK9VCcyIvm0JqZmNJK6RjSxA8hkmqWL7TaofO3/3IPyO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UY4uf/3V; arc=fail smtp.client-ip=52.101.85.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UY4uf/3V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NODjIl51ZYoMrYQEJlD8Jeapju0l0RQHm4vg+uxPWR4gFhNx3FD0qaTeXjtWIGftx8Mdo1VSgKVmCTqva4TtQFNrwEZ2+RAu8Si+Ac/UcoaGKdTNlrWp728+OymqaeXSH2JPXlN7GS1NsGB9kmfjvDbvxAWUycNgHITCK4DnFYgwbcPIg2EPKD3RptTPV8Eta5kRloWEsYYZrrNCBBATwgzgCXOYvvmWiq/NSHC0Qvk7dKuXSLULpOkPTFBIClckdgV4gnh/sUGEvdWjQBZMnSHya2tNexul2y/ePXX3vW2IcJSD3DGxn7FUr9qtb+/vDPFLUuhDFtsWYnIZDPPJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CYPBIXzR592n+h3Pk2QJtmy6IYcxT6NJi/h+xWT3kA=;
 b=X+6DNLU0SAOaBjUrMwlmJOewAX8LLtaunmPut2TilqISdVqPFMufcH5Gl2vZuou0UeLXQcqz0PTY+z77Kse6hNHxL/+997QNdFXHBj9vC2w5ttEx5LK3FMaWt0m15vZpUZGQQZYJDnDAKOB9RkAtXJArUWzP9ZEFTiiETjtM/uDWMsTBUAZ3/AP7RO/pKXRdqDAmQWO4jnrYzA13unF8XiEk2cPjD9p8It4c+y3/VUK4Az6CMZI7GAARW+XteEXbSbauByDMU/9SMO4VdbBb01dzNRZBF1fPMxP1OO+PUNMu9U1kVOmki5j6qPkMqNQdJJb2lTWT/1aWpdsY+Se7CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CYPBIXzR592n+h3Pk2QJtmy6IYcxT6NJi/h+xWT3kA=;
 b=UY4uf/3VXS7Ch/xX1Hy+qTgITl2KsZxjIdwuuszCuDz/+S5A3Q/j00a3KVSm7ZYKJYUMNq62LPZ0tH5GJ8+/LOkpiHhLifErfg2GqpFiBmKu/wSkEBVDuGORir8qbOetJlSz9DuZ1dX9vFEVpPlyGtN43a4ZLUNHcsIzcyZQ/VIJbVlRRaUundHYTYvsqVMYO3ipkCq2bmVSrvw3UE+SFsINwBI/gVVxZe66U0TrgSJ0VF+NB5a93EEE/J6d5TkdtuJXymseacOzdrkzyghCtGI7o6il176SsxQDzo3ZM2S0UcGaU+pYtd0CB4GkoKQkunLmpoDOxFKkljAD6dYoAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 by SN7PR12MB7155.namprd12.prod.outlook.com (2603:10b6:806:2a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 11:12:31 +0000
Received: from CH2PR12MB5001.namprd12.prod.outlook.com
 ([fe80::89e3:6df0:de90:8dfe]) by CH2PR12MB5001.namprd12.prod.outlook.com
 ([fe80::89e3:6df0:de90:8dfe%5]) with mapi id 15.21.0159.016; Thu, 25 Jun 2026
 11:12:31 +0000
Message-ID: <38410976-ddac-4848-a4ff-e6a9f7d9c828@nvidia.com>
Date: Thu, 25 Jun 2026 21:12:23 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private PMD
 handling
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 david@kernel.org, ljs@kernel.org, riel@surriel.com, liam@infradead.org,
 vbabka@kernel.org, harry@kernel.org, jannh@google.com, ziy@nvidia.com,
 sj@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Lance Yang <lance.yang@linux.dev>
References: <20260624065353.1622-1-richard.weiyang@gmail.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20260624065353.1622-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0056.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::20) To CH2PR12MB5001.namprd12.prod.outlook.com
 (2603:10b6:610:61::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:EE_|SN7PR12MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: af4f5937-0f84-4a48-cd0b-08ded2aaa635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	Q3Ewusi07GuDY1TtPvncyUPvDi7uBLcv8FS8olFLQXInKlYiv9XCRj4IyM2eN90iL37akFubUGMaLYn/Q06kwirRn9rt8oeASMTIpldPF/hFhJKUdAE6KwORMZn2pHoBJuh1vp4fdvSlN8GQiW1axdbw7Qr/czZC91xwHTgRgaelYW5C4FNNRsHmJAAC/9KkknRCFGw83Du+4JupoEb37SyaLKYDRYmu6SgxMphxBfYaaw0G0jC6JgnfG/BrLqBQUNpbTES5wD6CiKOjj6SoXevBF057N2CS9FxEtJl8TVjqz8qO2sqoS0HpGXsV9sLY8Ul9/5VqGH479AlODp0AJpAd9YIe1Fl1xSc5A7myiieftQsYcBY/hcHQLXUWX0FuugzXQv3pc7T0sWGTXLK/awBM3YAP7KOdHaYED6mwLRCd1NQszXqN18WCIbP0RIvwnDld/OyS27u4M/oAFdX+QE/DG83SP4EBnLKo5eWEtddIT01JNqXhoWVAX0jUb6TZnspdq/WWPPICKbjLyVeOBkiMl5k8AmMrtsB/nzmKu3CCY6zF6slM9UqHNdy/GBXPy+r3+ckDrk5vN5HbGxQOR6pD/rUSkSd3VI1gawzIO4NLD9NSzjANMTw8TIwUkr/PmwESwOToJpzEzDY3owY3ZkhTvlp+5VqCCQJa5zbIFvx6WXCYi9qqHFpbe4kyMP6zsIUNcWR9akOtOu5vJ6vahw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB5001.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEZsbVNCK3FlTTVTYng1RjQ2dTVhOVRmVjhoWHdIWHF2eWtoZnRsR1JBQmVU?=
 =?utf-8?B?QlpxL0RzZGtJelhkZmNqMEJlK0tCQ0FpTEVYeHdTQkRJSFp6eWR5cXFyZ1Ew?=
 =?utf-8?B?RzZzcXZPakdYZDlYTEhRZmRYMEcrVkFiL25hSWlIRi9WQU4rU0tZZmpZQTR2?=
 =?utf-8?B?TitxUEhuM1RERUpJeEQyb0Z6UVhMSkZpOVpnNlEySmtCaEdGZ3M0cml2N1Vh?=
 =?utf-8?B?d3o4K1JUZmd4QUh0empVRmQxWnFWeDBUalBjMktYeVdidjl3ZHBrWlZYQStC?=
 =?utf-8?B?TVl3dGhZYmZwb04reGdhdFc1RXlIcWFjZ1FKM2JuNTYwbmg1amkxcStNVW4w?=
 =?utf-8?B?VTVoY3M3dzhvdFRIZEFUUmU1bktWTExndnBRNloxN0RRaVNwcXNiWVZJSzd6?=
 =?utf-8?B?Q1A3Q2hrWnh4M1EvcEVSa0VXNEcyY0pQQmFpNW96ZVJ1cnd4Z0t4cVFISFMv?=
 =?utf-8?B?RnRtdklUM3hSaS9XazIveGpCcmd0MnBCU08rcjUyNmpHUXNCNmExOVlRL3Ez?=
 =?utf-8?B?dVlSU0xuZ2xsTlFBdHhyRm0wbVd1VVI2MmNRQWVnUURqS1pGZ1Y5aDh1bWN5?=
 =?utf-8?B?R3hRNm9hSnQ5U01paGltZ2pGTzlnbEYyMm5YVTE1ZnNuZDFxV0xCZWQ3RjYz?=
 =?utf-8?B?NmN4R3lrTTQzRDVuMmdoeFQvYVhZSVQyaWtmUk9TcjhXSkRjakgrMERWTUpp?=
 =?utf-8?B?bFUvVE95OGFUbldPUk9wTkpSdmlreG9IRzBUWXBaSC9QZW85c0dGdnR1dkJa?=
 =?utf-8?B?LzUzM3Y2VElqdFVKOVhwMlBWMGxoR2h1ekZDK1NIamNqV0UrTjNUK1ZHQUpj?=
 =?utf-8?B?UFh4b091TzVKOW5QK204Zkx2OHlScUw2Tjh5QVU2ckUvTjRVVmxSd2JkTTEv?=
 =?utf-8?B?MzhQUnUrbnhwUE5tRmJ1dXFhQVNOYWgvMnNRdEJJR0FiSHp4bUcyTy84OXRs?=
 =?utf-8?B?NmNJd01UOUxzMFIrU1J4ZjhVQ3F6UWFUV3ZoSUtoL1JwRmJRSXlwcDdxeFVY?=
 =?utf-8?B?UGRRbm5PZ2pPWkpmdUMvRGRHcStVT29sRVRzalU1NkpHaVg4SDZJSjJOY2hq?=
 =?utf-8?B?TDRpYVRRdmdPWndMUjYvUmRPbFhBS1N0ZllmSFN6K2g4TmVla3pZZmQwZ2hh?=
 =?utf-8?B?ZHI3SjBHSUkxRk4wNDcyMXF2eFI5R3lEQVpvdTBZNnRRUnp6dElkMVFYVDdj?=
 =?utf-8?B?cGwxMWtvVWVqUWpzeTY1SDVMcGU2SkJUcmxqdXN0UWdqMzJENnFBNC9FSi9D?=
 =?utf-8?B?Z2tPT2kxMGZWVDJOejZHY08vTk55UXJXcWVvR285MCt4Y0E4WGhCSzNVak1V?=
 =?utf-8?B?a1JTNWx1VU9LdDBLS0g3WVVwNjBHbHl4Y0M2d3RPVWN6TkZTbTU5UXNJMWFk?=
 =?utf-8?B?RFdtYUdYNjdINm1TU0lTbDNGbjRITzFPTWM3TlFwek5VUWY1eFBkcW9NMlBK?=
 =?utf-8?B?TzhvLzdUdllNajR2bFRSandzK0x0RFB3TzdOb1NiUFhUd3Bsa2psNWcvOXZy?=
 =?utf-8?B?bWNpUysvZW00U285VStERVRZNDNCSHJnQ1VnakNjeUo0elNYNi9uaXdiV3A2?=
 =?utf-8?B?QjRyZjN2aS94KzRCbTlFTVFoTEUyVVFUaEpjdlRMMVJuZkViejN0WVd2OTZB?=
 =?utf-8?B?ZkxqSUJlRlFtbExLblQ3enJrYUVaT042c0xtQ3dIc0xNREZlQ1hxM2xYV0U5?=
 =?utf-8?B?Qk5GaWN3MDRjaEZRN3ZQanh1N2o3UjJTemkwNEFlRXBEU1ZTcXJvUE83TEdk?=
 =?utf-8?B?YWFUOVFnSyttVFVkWUtvUzB4bTN5cEhGTGRsd1N2cGdwa1NmbVVHcThsSzg4?=
 =?utf-8?B?cS84a3lramJSVEcycmxSQW5GTElpVVB3TW5BdjAvWkRuOHlPK2RaYmZubXMr?=
 =?utf-8?B?YVZuZUxvUTVDMDNiUTVRYlB4V29XVnZTT1dBa0p3eGQ3RmdJVEZCL1VMRkoy?=
 =?utf-8?B?aUhFVEtRMVZ6Tk5NeENWM0txV0ZIaEQ5eHBPLzdBcnc0RFZ6dW1vLzl1L1Az?=
 =?utf-8?B?UTVHRDBscmFuT1BCbDEybzNtU2dhcGgvcTIrZkdHM3AwUGl3alV1QnNjdCtz?=
 =?utf-8?B?bUxLMjFXRE1nUDRlZHBTa0RIcHpxZTZWQUs0SFZqYkZDeUc4R09NcDhJQTFx?=
 =?utf-8?B?Q3Y2NVk2OXlsTi9QT0VTQzRIUFIwdFpVSktqWUxRU2thODJNRVZ4M0tPL3M4?=
 =?utf-8?B?d0dOSWhVYkhDL1JDNG44T2tWSk5IUE1ML1E5R2FDNFR5L0RnanlqcHdhVE9W?=
 =?utf-8?B?YmRxTWJHNHZ4Wnk3NWZQRzdWYlNMbEhHbXBMc0dRa0ZSSXNpK1FOTmFuYmhr?=
 =?utf-8?B?TjBqVS90OXhQRWF3RTh3eWcyR0Y5UCtLVVl6bUpoWndZM0d3L08yQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4f5937-0f84-4a48-cd0b-08ded2aaa635
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5001.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 11:12:31.2519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrFEyVLrBSwZ+aQdGYktkGQpWLwCN+fuOwGHpPKec/rxGE6GLtrZ1CIcM4lff77C0iW9qDxZMSiYYylenWhm3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7155

On 6/24/26 16:53, Wei Yang wrote:
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

Should be PVMW_MIGRATION and "us we do" -> "as we do"

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
> v4:
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
>  mm/page_vma_mapped.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 2ccbabfb2cc1..17dff8aab9f9 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -269,14 +269,24 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  			/* THP pmd was split under us: handle on pte level */
>  			spin_unlock(pvmw->ptl);
>  			pvmw->ptl = NULL;
> -		} else if (!pmd_present(pmde)) {
> -			const softleaf_t entry = softleaf_from_pmd(pmde);
> +		} else if (pmd_is_device_private_entry(pmde)) {
> +			softleaf_t entry;
> +
> +			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> +			pmde = *pvmw->pmd;
> +			entry = softleaf_from_pmd(pmde);
>  
> -			if (softleaf_is_device_private(entry)) {
> -				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> +			if (likely(softleaf_is_device_private(entry))) {
> +				if (pvmw->flags & PVMW_MIGRATION)
> +					return not_found(pvmw);
> +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
> +					return not_found(pvmw);
>  				return true;
>  			}
> -
> +			/* device-private pmd was split under us: handle on pte level */
> +			spin_unlock(pvmw->ptl);
> +			pvmw->ptl = NULL;
> +		} else if (!pmd_present(pmde)) {
>  			if ((pvmw->flags & PVMW_SYNC) &&
>  			    thp_vma_suitable_order(vma, pvmw->address,
>  						   PMD_ORDER) &&

I looked at comments from Lance on "device-private PMD <-> PMD migration" and had
the same comment as David

Balbir
