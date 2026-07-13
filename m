Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012051.outbound.protection.outlook.com [40.107.200.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368101F3BA4;
	Mon, 13 Jul 2026 03:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913949; cv=fail; b=OYfpLq9AueLeIU+5vQiO3h+Pp+ol/orzuiKJJNRKbj11CyGRQWLVBkmoL9b0AmbfN4uT424zf5EqRJ8Rt0IRTF0pWcSt0FeEjhfDvuQ8mhpsmaDcriCqSrVpVbGQU3DQawLKhKgO7R4hrQA9gcK9/Aaz2A8ERLm9aryayHo1UD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913949; c=relaxed/simple;
	bh=TvUQ2s4lS1MGkHUYBtEQlGKm/VKkWD/n9WNr2oGghCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UIx0JgHxaWcMi3ToPtX1FOgnda7B1+8Xs8LrXS2mp1ON2r7a/2KX9aWxIXRaBF/pGwYQpOwKQPMHxAWwI1GywkzOB6pWjPQzOcq/Sr4LRzCr/ua2bMoxDpSFSy/Xa7ZUY6X41F9d+e+Mtv6lRHBC6Yna7XnHeZbumaLKPKd1sGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VnUzuhzA; arc=fail smtp.client-ip=40.107.200.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VnUzuhzA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luKDnQaj0GyoC1lmy0cU1KvHTzOQCvajPf3WIx+H4ShhIkpf2kSk8SfuncYxImHFAmKSRe0bjZG3vYQb9ToFAJMw/y+H5NWeXMTSkoHiTuUJ+mEjX6ctDNTY/uBN6ZNUD2fdHvEop4GreJ/TLXR/9X+BPoHWgDkptNBMvDAHsRfV+/wsP9F7X//TmFPBzWtkhzlXaCjXHB6fgAInnUBVdTQyMqW9Cyc5ypUGtnPXkKUlz/D+vKhWA1miGSfgs7himNpSuedhaiCBH3eAfTyIcBVyfgVvEOSRYWr/sg82RqJiFNW5zdOtLiO3xbF9k0EdS9Sx0D9pqz83K7p84vgCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNa9qIiKhIOr3utpxmBrWEX1h2v+nBZWK5oNzswzf/o=;
 b=Lz4Xm8IvaNzHZg8J6CA3VUoWiz2igmoR1lRN5ITBysUPLJbA0+DMSqdpGOUWM+XgMim/HVKg4cOe6bUf6VcleJUBExU2LXUWy97MLna/HIjVM46+TPK0UsKwpHzPoWL7sKx3sd/8jG2qRfc90jwjY7d7OxJFfa0Tr39k/4VDXBHJACvj3yaX4CBVpGyMjmw0fL0+DYYtOEmxvtT+8DwjUmh8KmpNM1pNgKUkepL+I3S2T24XKnGeuArRJ0HSj4XQnPsm5+I9OZaS3pIrpkiYvh43EXUHZsBBt9Mt4SpTfGrkY63rwhoqnaUQHljtWP90E7omTuRxeqY6aCEHEbHgVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNa9qIiKhIOr3utpxmBrWEX1h2v+nBZWK5oNzswzf/o=;
 b=VnUzuhzAyrnpW3NmnPQXcbxrl4y92dFj6j4nx/i72n5L6rgXAR28qMBxOXxpOLFPB0/8dTzPQsNgwHWuPV8xtm72IwHz1ZvBMu6GQ8LBtYk34/sSyMKmNGPQEIoD2mqwzxigX2kCQox0mJxqtavZI1QXrAq8JQfI+6OOXTQyWLlrLZLAJHxGhtoxTKrazm2oXqjnBc4oWhL4RqsjtMQeQLZ/Mql+j7HgQrB5VMSzFoS/N8Ltc6n7Ml+srynZXxgYStK8fxt/XA2ikE3cKeS6UYiAQrANYlJ9kHX4p8JmfNrRCxe6CZadbCb5W4V5Uhd2BNGSAlTEEhfdy5gVZ15MCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.23; Mon, 13 Jul 2026 03:39:01 +0000
Received: from CH2PR12MB5001.namprd12.prod.outlook.com
 ([fe80::89e3:6df0:de90:8dfe]) by CH2PR12MB5001.namprd12.prod.outlook.com
 ([fe80::89e3:6df0:de90:8dfe%3]) with mapi id 15.21.0181.014; Mon, 13 Jul 2026
 03:39:01 +0000
Date: Mon, 13 Jul 2026 13:38:56 +1000
From: Balbir Singh <balbirs@nvidia.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	david@kernel.org, dev.jain@arm.com, gourry@gourry.net, jannh@google.com, 
	joshua.hahnjy@gmail.com, lance.yang@linux.dev, liam@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, matthew.brost@intel.com, 
	npache@redhat.com, rakie.kim@sk.com, ryan.roberts@arm.com, vbabka@kernel.org, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm/mempolicy: skip non-present PMDs when queueing
 folios
Message-ID: <alRdvU1CGaqGn7re@parvat>
References: <20260710105557.1987433-1-usama.arif@linux.dev>
 <20260710105557.1987433-2-usama.arif@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710105557.1987433-2-usama.arif@linux.dev>
X-ClientProxiedBy: MEWP282CA0177.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1cd::20) To CH2PR12MB5001.namprd12.prod.outlook.com
 (2603:10b6:610:61::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c6c419-16e0-4a01-6bf3-08dee0904768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hr3zG1iDw1J+i/KqSMXfmzgDRumblVNJwmIwtYQ5sJ4JUOqISubN0sE2t2ZGs9ZBLr6OQiAkEshhc4Uk8kZhilm/RQhFDP7QPFYLYIeinnyh1D4Fe+flZbacUFmLZ3TTc/1CSWRXAldNGa9jmqVOl5TEGHK2OJCDYTWYB/QFv2n2HE+6fcAUtP5CXFNsPs8hjCskEyu0mlfIDZkzmAuloHH0554pWnDkKsWCTSbNy49IKIfXotkzN4th5SCvgkSriLa6UvV6CCpJPQXwpV/VLny+tAK3Oe8BSsJ4f63hvcp25uhmML4OjP9HxDTHnoDvE1fgNAphA4NB6Bd58d8XkXCFGbCXuZvVKM7nWDkPNptM+TIiCgCGXD+r43xQWHIjOEIZXEawcEkBqj9zpAlvFU3iZ6KQctsI12+EWaMyXThcxKKQlFlbSyEtdVMZUKx8zrtfEnoF13M9m1zvD1ng6AiM8AoPXbM7FSNjfD9M6SZx1d3s1a+pOTuIqEg/GjQ45jyuVNgQLk9DNxytH9GvHdGSba9n65Zsa4TMewfrdLknfkGpnox8E5yqT133HJGY5JrNrNd466pQ54Johv5SxDFjt2MxbE8yyTKHeAnC2p4KqXR2ms+ve0sqTVve05RgyGNQZ6hQ6DBFZOgwoK2RjPkONL+L0rxEdMOEwRe/ONg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB5001.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v+ssguYM1DA3lsOxuKft6ajVbw3zi0tr3Ji2KMF8FTdeDL6pYwstsTa8SAfe?=
 =?us-ascii?Q?dw2yEUdqZ+07TpUE34TVK7U34K/mF7PXOKYmtPt1ajLP17AiGsUl5D2+/9lR?=
 =?us-ascii?Q?r6DhTbQwPXAdlwKP/lrAa1GguoPQtF6wdZPbWGaS7f4o8zgdxyUx1SNILygR?=
 =?us-ascii?Q?MVQztiujRU8c1n8E9BY2cPo+UAQIgG7Jhov68MGYg4BZBeN4e25RN62nrbge?=
 =?us-ascii?Q?NSxHR4hTShNDOkCgy4SwYUewJHMgeOytyIarh3N07PjkdZHtOIskqzGo5Dsq?=
 =?us-ascii?Q?2WbUMcgO4+33hh5eSXsdJcJ8Gy0q/GCznqSpfvZ/86FjU6Psq3RDJPn8mKD6?=
 =?us-ascii?Q?rmh4066xORjVCPDEDJKuiL5gqxrie+e4//1VtfnOtikiu28A3634k/jCv4FZ?=
 =?us-ascii?Q?Ha7b5o6jOvDnhAoQtZ74XDO5ExJbAFK+4dbzZxAfdUA+Qtt82Kj1C1AoSjNh?=
 =?us-ascii?Q?AfmFbF5marX/pXYdtk/rCNEtNJpLhsHTuGaC7PZI9bsKxWA0J44wSy39Zb+D?=
 =?us-ascii?Q?5Tik5XVTvJjzbxUB4+WA4WH2R7Xdu9Sz/GXQHvbqso4uUH/UlpMiiNdChvN/?=
 =?us-ascii?Q?yRCKVu+bYBv7rpxCdJEuVFXC/GigvSBpUMgzK06YNLgEeEA6XDLMSnHmjDX3?=
 =?us-ascii?Q?yWtgFt4fX9oAICTwoOmn2PqFMw1/LQ1idMeK9XnGxM/SsuRm2BF82vKH1iUL?=
 =?us-ascii?Q?NKiTqa5bJf3vJU+3uN6bepRwVZawOei7JAgcDvNQGSGwWhraq65TGsbK2xYN?=
 =?us-ascii?Q?rYrKoeq+CLo00qAjMw/t4YhPOjfoKRQivy0g0cp0dm/xeN3yTbEURgTUTzP0?=
 =?us-ascii?Q?gLtTwuzlSsvDtFoOK4mo0E7kPGfgiCxU3OnKI3HvwNhTCPuGjQ7ppXu7NVs3?=
 =?us-ascii?Q?qe3F19ONXSUKYZfA97gDbxeWWO7XBwMD5EJOts7px8XGVYu11sYSIc6FGeg7?=
 =?us-ascii?Q?JL38apfdnniTRd71GisYew/iJKf00/5zreH1PUtbadX+LD1gPyj0c062noFt?=
 =?us-ascii?Q?A79XoKMeB+pbSwHJclFAkpYqPzMlsKnmIV1z+jM+wiP7+astcu+hxwvrhm8d?=
 =?us-ascii?Q?PXIABQ1m7UkydYsI2cFxiIvsP+MYQXkFXz6Rl+aiyxGNQJ0jXOz6UkkOYo5K?=
 =?us-ascii?Q?ZiMcJnMlEKmr7BCsXj12h2YHMHqwTomAbtfu47YC43HaPwTtBPbun57afoYt?=
 =?us-ascii?Q?Ky/Yujp1x3IuBR74zRuBy8aXVrz998wV9CAGoubeyT4p/AxP/1qnZjOeuba0?=
 =?us-ascii?Q?lcoe36ULVDDRZkPuZ18Z8t7j22iJDpNVLRBEAj3D6FY8bf2cC1C+w1Nc7vyG?=
 =?us-ascii?Q?aZ0pOWiR8jWo0EQUehgGJwxrM8k5CJ88nEJ+zwozf2474rIPIBR0VNthYx1r?=
 =?us-ascii?Q?lFuSatR7KdJkhtW3otsGnsInyyD/e415/maOHgy+3apFzXlJHWuJ+fhfusMy?=
 =?us-ascii?Q?Pf3ZQlZYSZx1iUZNJSQv5anFcRXJINWdC7F2SURYPRFtIys4W5FEC0NPWxnY?=
 =?us-ascii?Q?RN2yHLn1zCwj/7dTUFfeWRk1suRsKPdJ+gpW7XHAo31/iAdN89t9ZiIYXn9w?=
 =?us-ascii?Q?iG5hvCjU6CQtaeJg0VzIcttWgg1O7nJvLjgU4R8kjTWi6vh9f6y8NJ+GReqA?=
 =?us-ascii?Q?554RJlS3WACPy5oTrEPNzKEsyytTepKNG1p0AXmyq291I5JeMJ1IDVsz6VlH?=
 =?us-ascii?Q?Olm7XM4JKDPC9fiZVdALnxH2B50YAZ3yeS29dBUvK09Q3vy9a1ALGGP9Hccq?=
 =?us-ascii?Q?mGxnFbUANw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c6c419-16e0-4a01-6bf3-08dee0904768
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5001.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 03:39:01.3071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYT7IWLpWLkIaPYw1woROCil7jvMwIR8iyU4cDHDXh02/hQiyygcneNlw65GdO8nhPGREiKuJGYbgW/4SCgbJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327

On Fri, Jul 10, 2026 at 03:55:21AM -0700, Usama Arif wrote:
> queue_folios_pmd() is called under pmd_trans_huge_lock(), whose
> pmd_is_huge() check returns true for any non-present, non-none PMD
> softleaf. Passing such a PMD to pmd_folio() treats the softleaf encoding
> as a hardware PFN and can return a bogus folio pointer.
> 
> Mirror queue_folios_pte_range(): handle non-present entries before
> looking up a folio. Keep migration entries counted as failures, but skip
> other non-present PMDs such as device-private entries.
> 
> Potential trigger: an HMM-based GPU driver migrates an anonymous THP
> folio to device memory via migrate_vma_pages(), leaving a device-private
> PMD. Userspace then calls mbind(), migrate_pages() or
> set_mempolicy_home_node() on that range.
> 
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260703173903.3789516-1-usama.arif%40linux.dev?part=6
> Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  mm/mempolicy.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 914f81863db5..69a00a324ef5 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -654,12 +654,14 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
>  {
>  	struct folio *folio;
>  	struct queue_pages *qp = walk->private;
> +	pmd_t pmdval = pmdp_get(pmd);
>  
> -	if (unlikely(pmd_is_migration_entry(*pmd))) {
> -		qp->nr_failed++;
> +	if (unlikely(!pmd_present(pmdval))) {
> +		if (pmd_is_migration_entry(pmdval))
> +			qp->nr_failed++;
>  		return;
>  	}
> -	folio = pmd_folio(*pmd);
> +	folio = pmd_folio(pmdval);
>  	if (is_huge_zero_folio(folio)) {
>  		walk->action = ACTION_CONTINUE;
>  		return;
> -- 

Reviewed-by: Balbir Singh <balbirs@nvidia.com>
