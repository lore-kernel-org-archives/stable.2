Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39A94E8DEB
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962706; cv=fail; b=ir85nAfbng7okBs7r+qt4XrMctzjg2XR3Cdq2naVV5j0dhsIHIzix2ieHZFO8miZX0nfCrGptrxhRopghs87p8U0cACiwW7OMFmM74qPj/yuIr6jVj2LZiu/k6xzb8EasT7UWUjApV+Tia28qA7gf5oJj91qDzZqSihGXprqKSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962706; c=relaxed/simple;
	bh=55ZHiz8agjguIdhC+sM1seTUl6q6M/RwaPV8zqLc0P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G6vk9FMWvBQXpz47ifdxl1ume/jS7+nhtRWgUqSIjytboR7yVrc4LYR9Ojb+K3n+jnqYZQ/Xa9SSw7Vj1AZhkUN0E35Mat2EL+K9z7xXwu046bexC5d8J3Z7AphtTQKjnuztUl13REiC/2FCZh4ztaQn/ySNfmJKm/zq99jfvHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jxqpAEX4; arc=fail smtp.client-ip=52.101.56.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jxqpAEX4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlzwUStYIfXjAmGXwpaELZq7tWtxOjU3nKsIjEtZS7+/qIks0rVoVD2rvdOOEb4j+aP+YEQV/YFpD3qkCuZ0l4YfjiYOX/PqCM3LHJUHnxZ7LQFqWBFrDZ22VHh+mad/0RwkCuzA0ZJnj2e/u9GoFUluEBVRPj5Y2GoE5Xo80WZe7oJ8KdpQr+1jS/xDpDKRThYhIoayekdGWJZ92oreL7NjjUuDIh2ZD7vkL/+4wj26hHXO7DWYZg6nPYw+UfUJo+cA8zvAW6rl66SrF5DICODlo3o2wCeDbnvBjL+/GQAu4zjh+ypF+bYfaua1nBOjGo9Tr+1orsllgVsB/8yMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eusm2qUj3bdWuvs1uNzZuR/lTu7FhPFrqDla3jF+o8k=;
 b=uxYCC4aHCuonfttHwiSvPfF7xHW/CCRln5VzWhygxm74YM91/ePe/mq7hwG+sclRgGYk8kCNclEKftJELbAbEsWltPs/rDO16ICKydYwVlQWHxa66Gb2J/2ugf8VMq2m90bPxXzM2XVH7vQCk/+9YLKvhZMPU/3j1cIXb7jQZlLimSRy0bA5CbpKGBd8GIEwzeWKd19Ehv3PtLWJ8USfXTcUNIBoRKwJsv78zCfWI6Ydeo04iVzsaaT5snEtfqc1ngGuSHZ6PEQYkGcQ5hX9E2PCaYHgzKbyn5Nis69jPXjzQhpO8R4TdZLcRxy2kBP56Te1LYYhfYpE4BAqnl/72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eusm2qUj3bdWuvs1uNzZuR/lTu7FhPFrqDla3jF+o8k=;
 b=jxqpAEX4wipi9wgvfCJyoy57H3f03Z/OcQiyxghVecbSswIkkj7IAapBMGlAD0dnxulGsb6gz/+KjzjzPxM1Ixc0iEOUwtST5H2csrPbAKgWAKYTzo9lPlSdz1GT1iTPT2pwmsu9iuw1dr9MuHcBnC3M5eJj+MyWmuIA02P6oTWHm+80jcglE0GitvuRnDzYCN72t6xb8Mg6vf1V4FIaT2ajGx7L68SdXFxYMRw1/gsRnX/3aHKzVMLmUX5iQiF6fwFTnC2QH71oQXr956NT1iXuiXCJLovEq3Ll4i5OgL51BwY0dsZKD94e7BilhmxgNs0lTe9MiVqwf1r6QTsL6Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Fri, 2 Oct
 2026 17:38:08 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 17:38:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: Deepak Nagaraj <deepak.nagaraj@baseten.com>
Cc: stable@vger.kernel.org, mfleming@cloudflare.com,
 Kaz Kato <kazuyoshi.kato@baseten.co>, Stephen Day <stephen.day@baseten.co>
Subject: Re: 6.12.110: kswapd NULL deref in list_lru_add, possibly related to
 xas_split_alloc backport
Date: Fri, 02 Oct 2026 13:38:06 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <A90F7E87-80B5-47AA-BD31-0F0CA5A17862@nvidia.com>
In-Reply-To:
 <CAL3JwHPX_fJpg_Az3Et4-xrTdkcdtT20xw7Bhjz1FZSLW_xODQ@mail.gmail.com>
References:
 <CAL3JwHPX_fJpg_Az3Et4-xrTdkcdtT20xw7Bhjz1FZSLW_xODQ@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: BL1PR13CA0082.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::27) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BY5PR12MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7fba94-4bc8-403a-cfd8-08df20abebd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|10067099003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+Tstfam5nnrg1iryqfxIn54uNAnMTxbtYRwIkkGuS7WON69Qb1jH3mpIDoZbTakbpjC7wQsDo8OOeoH5NaT0MJUTKGx6H/zt7qLts4ltKLO9AebQE0urHHXhZtATTzV57k94DZAmuK/0c32++X7EeYwwGBwv97dyb+E+OMXa88cARt2Xl7CdU1/PmZJp0I55PBtrrrr5GpmNlWzQR2LvpAX5Ouou5f+Hwb08Djzb/GtLAjFb96cmUZ1L5tUUtT4di2CcC49iv9tckPSMx8Qp5UrTektDTk8Dn5BHlQSxc4YNrWVYVUXxt3shbI70dyx+DcR7qp9keEOPCn3qD5+QKOpUxmINYTcsqghrMnUi+woBEO/eEZXzcsJoHyB3AFCAPvluMARCwISQ6koL0Umhq25AGIVpwm+cfZ+9mVXv4CmwLrAHWMdMDDVA+dxYZhx3RTbB5rJnugcgyMFErdaMvjCv+ZRlmz8mZaCWxkEVwPnrWJKbd4MpL7Iwh/arThW54dyf7OtJDFF/m5l5uHzC4XE5NuPiwURjvhCBpl6PeuIp8c60es6crlkFf2hKUTCqPPBLWhseTLFllhQln1BwmZMY/u8GPfZtGU88WXMEt7C3LguoaAlrhyYpVIH/aEB59TE3jWCbEixJ8cqSrjb/ogncYwZrBHse97mQTe7ujG0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g9h4Wt0bCZdeG1OCPLgmeaPmjdqwYRe3AirTku6aRF4LV5c825T+Gql2Wdx5?=
 =?us-ascii?Q?8doszZ2KJZUdadYg0ef5u9whjulPzhmHAYULPj2++ME+6jqlzuPw8YsF1HOv?=
 =?us-ascii?Q?mqVELQyRcVVWQFyUOKAxf+ljAKNFFbvn0IEq6mhmmaC1Hd/K4pZVoNvz/MoZ?=
 =?us-ascii?Q?OtWxGza64KR/jYR6LKKifiUJLWMHZwBI0fU2TX3bblkPy+x6XxEZ09gFp7P1?=
 =?us-ascii?Q?q7X0fDxJdJgboaYZn2mtuEAQNtsTUQ8nUK9Fztmqthyd88bso+qNIAqNbZwk?=
 =?us-ascii?Q?er/uSb/tLUioJWv8OcLrVorowJgALNMN1trb9nJIOEQ1QAGty4529L9SqbPr?=
 =?us-ascii?Q?185A6uq4dwpIhNlsU0Wl85Xh3EwSb5b+txWkhYIz8h58TCkRSZ8bw3fW4FRw?=
 =?us-ascii?Q?2qsBW/3NZxuFh/1gqE9UReZsQjuAUGVb7QXxmB5KxrJqPDPRMDryB6Hbp09C?=
 =?us-ascii?Q?pP5/1mpsOZhz5eo7rT73HYvlpDb8kEblXjczKd1UgXifupr1XB/nUYULkLWI?=
 =?us-ascii?Q?SazAzYEI4rWNUn5osOVRzr2qnt1rcsc75h+w4nXCop9CBRFSCitCCb9FdUWJ?=
 =?us-ascii?Q?Yu2FLANMvlXB8PWGkCMqI/QjvWNksfK21LX9sWmcnfyQrI+9BRm8cb3Z1+l0?=
 =?us-ascii?Q?iTiyKCA/YyZgmHLk9F1wOn9z3vyEwXgyd0VoUzHNshPbaL1HKwaj59rlevpc?=
 =?us-ascii?Q?Z88uoXo/TI9Cvdqx9oHnCkBvYFu4inoRuVTzBbsNhtOqgVXIBQzU6tNKyKz5?=
 =?us-ascii?Q?2qyGtHNdUOdsZhv+dAGVasQKTXUiAgJ1mFi8Bm3GOq5RQ7RY5K+wg3y4p+2F?=
 =?us-ascii?Q?7Qw8P7d1v94gBtBLNq7C7cybSWsEcBIUbO7qiACxoFTVh1nOCLKFRC+aLnOu?=
 =?us-ascii?Q?uaTvtQofESPvDmVXKArzHuYy0WlrJiCqlVm2+XRZcqEmj+L8YTwHiiWgUaNa?=
 =?us-ascii?Q?r2gSp1wxjk9muWVk65JOmHklYOLTCVK4Jz5BHYzzUNDrvsWQBVXzwrKZQIX8?=
 =?us-ascii?Q?smD5H5nGhnIQfOe3WUFIghf6D5eC1SyXMhgFJBUuOML268y2qfbRxtnQQcRH?=
 =?us-ascii?Q?Qe6qQ6YDqV1kjUL5y3n9ldEjcMV6Ye/FP9YuQ8Q4yRim5+YpeDY2eu+SylgY?=
 =?us-ascii?Q?0NfW35SEhcuz4XmhOqJEilZBdsbwmfU0LjGhVzVEezI7783GAKFzphleYzGH?=
 =?us-ascii?Q?WR2p9bYEYQKzAJLkP1drTNhiVu5kzYH29aGaIY7E8yIfFgRWViBgNXpdrMj5?=
 =?us-ascii?Q?mF8LMrGcxYAyYXAEu1QH8Ecl8XhQDcHNPwstD8NCWOgC1z5VaqAJIx0iWnvw?=
 =?us-ascii?Q?A11tFL85WDPv97cxv4mADSUrz/JScn017xaKRa2QVCINUIob4lXSGljQrxeq?=
 =?us-ascii?Q?nZkYZEoXg5J3Cis8TOqU52EZVdEpepPngHlFPzsHFD9XDw0U3NJdfQephjAQ?=
 =?us-ascii?Q?Z+M9QMM3ejvBxUCKy5HVGBxRHmcBAQpj5szxbQtYNGR4HCYaRUYfiIGSswLO?=
 =?us-ascii?Q?3DpcVBiwyWbwD4FIz9seYrAbEW6+nQZY1/rBjlu67M3WO8CVxhYNAhjjnBOw?=
 =?us-ascii?Q?AEFGLMCGFulyumiuJ1KMRgIDdBC9i1WVEggufyPziT6+QVGm4tpZ0PfXavS9?=
 =?us-ascii?Q?9s1E25oKGJnsYOEhqwxanz8uXUtnj6PpTnnZ9d56/VzD+hwVc4yzglgobOtI?=
 =?us-ascii?Q?sYD2i9GUP6Kh2KRhrshOSie/eBRO/6mOHwD+FhM+aNZjjBIRpMdbuCBKqVeo?=
 =?us-ascii?Q?14hzELw1zg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7fba94-4bc8-403a-cfd8-08df20abebd2
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 17:38:07.8808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8J9p2GKfX1i6gwvOOHtsQGQ/JWXXL7r0Sb6v+LLpG1YAj6QgDHo9hAAxznkOKJjN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308

On 2 Oct 2026, at 13:25, Deepak Nagaraj wrote:

> Hi,
>
> On 6.12.110 (Amazon Linux 2023 build 6.12.110-135.201) we see kswapd
> panic about 1100s after boot, on many hosts, same trace each time:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000008
>   CPU: 6 PID: 131 Comm: kswapd0 Tainted: G OE 6.12.110-135.201.amzn2023=
=2Ex86_64
>   RIP: 0010:list_lru_add+0x82/0x120
>    list_lru_add_obj
>    workingset_update_node
>    xas_store
>    __filemap_remove_folio
>    __remove_mapping
>    shrink_folio_list
>    shrink_inactive_list
>    kswapd
>   Kernel panic - not syncing: Fatal exception
>
> 6.12.103 on the same hosts does not panic.
>
> I am not a kernel developer, so please treat what follows as a lead
> rather than a diagnosis. It is source reading, done with an AI
> assistant and checked by hand against the gregkh/linux tags. Nothing
> below was built or run.
>
> One change between 6.12.103 and 6.12.110 that touches this path is
> 789763523fb4 ("xarray: honor XA_FLAGS_ACCOUNT in xas_split_alloc()"),
> which landed in 6.12.109. The v3 posting of that patch carried
>
>   Cc: <stable@vger.kernel.org> # depends on mm-hotfixes-unstable patch:=

>   mm/huge_memory: initialise workingset state before folio split
>
> https://lore.kernel.org/20260804-add-gfp_account-to-xas_split_alloc-v3-=
2-38cb3ff325c5@nvidia.com
>
> The commit that landed has a bare Cc: stable, so it seems the backport
> came alone. The dependency, aca1f2d5de17, does not appear in 6.12.108
> through 6.12.111, and I do not think it applies there as-is: 6.12 has
> no xas_try_split(), and mapping_set_update() is static in
> mm/filemap.c.
>
> If I am reading v6.12.109 correctly, split_huge_page_to_list_to_order()=

> calls xas_split_alloc() at mm/huge_memory.c:3524 with xa_lru unset, and=

> now with __GFP_ACCOUNT. My guess at the 6.12 equivalent of the
> dependency is to inline mapping_set_update() before that call.
> filemap.c skips DAX and shmem, and shmem can still reach this path for
> an order-0 split, so I kept the same check:
>
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3521,6 +3521,10 @@ int split_huge_page_to_list_to_order(struct
> page *page, struct list_head *list,
>   goto out;
>   }
>
> + if (!dax_mapping(mapping) && !shmem_mapping(mapping)) {
> + xas_set_update(&xas, workingset_update_node);
> + xas_set_lru(&xas, &shadow_nodes);
> + }
>   xas_split_alloc(&xas, folio, folio_order(folio), gfp);
>   if (xas_error(&xas)) {
>   ret =3D xas_error(&xas);

Yes, it is probably needed.

>
> I have not shown that this hunk fixes the panic, and I may have the
> mechanism wrong. Matt's report for aca1f2d was
> VM_WARN_ON(!css_is_dying()), which is the same area but not the same
> oops. The distro kernel also carries out-of-tree modules (the OE
> taint), so I cannot rule those out either.
>
> Does the missing dependency look like a plausible cause? And if so, is
> the inlined mapping_set_update() the right follow-up for 6.12, or
> should this go somewhere else?

Why not just export mapping_set_update() to mm/internal.h like mainline?
split_huge_page_to_list_to_order() then can call it directly.

Best Regards,
Yan, Zi
