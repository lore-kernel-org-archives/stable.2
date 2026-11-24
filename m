Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795513406;
	b=UJvF2mNIadg1v7apD8Jrzf0b1zo5g9BCoFUsWwihFUNs/2BZjecNob8tsAoF8mrGxPjw
	 dMWi3UfNvHf3kJb0Rz1M9QFy7Hu6UW3Cf1DvArhbVk+HJfIiE3VvFI2cd7spszH5qZnPw
	 IefO7iHMoeaxZTz2Nas30/PvBde7nIsAQ3SRS6d9l7XzCEcdadWpOZ3Asz0cbTihMj1YL
	 NxHYmU84Pk3SxAE8QoPQ/f2BHIgtgB/9yDP1KvQo8LMhzSw7ZUP4Wb24UC07mWa9o6/TU
	 N4Jl9DlN1tMIBuYeQaCjQS4HCqDKdctcbUcgqIxoO2XDe8o2Oux1q+RmKF01PChzfGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513406;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=KU8Dr3J60PmTanKiFFbUDhLRx/eyKakjPN6r5APrkko=;
	b=ok1tOz6cvUzKvTp6Mul23p6p5csA4Q8QhGLm8rJ5IvlF6EBm73srdm3YS27eTs3j4OSK
	 eXH3Psx0Im1TVXZt7rCO2ffsS4opkyHfHPukA3dUHmlmfmkEjWQXj0L2WfQYkgLMQZhKN
	 ZBeuuoGgy2cJvvW4nJARz8tvmUDkEHrog6AG8u6Op02kvESdrBs09lsxqod9J9+5rYzDc
	 P89i/p3noMuuIPQjcIA7Y2iJYtiZLQTZVB1eAaPTyVsQP6Q+UYvKuOSTp35AzRDWzHGP1
	 W4MwKlssK6fmOCyoQufGlKk1s4JAz+wfHEnfJ6AB3CKFqiSLaXVioXcSptiat+83xkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=feYB6ywp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.59
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC18606A6A9
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FC18606A6A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=feYB6ywp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vf8MEz7SrF2K8/Eokt0XUce73HmFRxn9H1q3PmBcnDUhK+gdjF86q/3/BpRY3zvu8cIThtV4P/miqF0e99F9VMcVkRFZq5XnbEIyYDWKI5deX48j47wsmsqRPMmIIuF3FH17rJn4X87JyBafb9D/oHUuQwhv5PDFNDuFTUGMxBOTSZ3mIrOmeRUXm1V28JSmuPM0GZNncbQfhQKhAEJ8KnB8BNxLRSMd2z/bhk3M9crP1p+baVTtVjzjTw31RKMUqm7mYOlgnxRSaiJcPam2gl7ZNn35iadQqh30ra8gn25Qj6gbBAWjRHnhtKnWKK9FWuVbI2f0aR6TJAePMS8rLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KU8Dr3J60PmTanKiFFbUDhLRx/eyKakjPN6r5APrkko=;
 b=kP71IvQ62csX498fBeOpCAz+x0NntwrSmaj3AyhxbFEu1Y5UwCulSPNm6gyhG5pJW/5lojj6KzkDOYS6zYoyTLBB63AY7LGCW8Tx2glrfTFcLsAoQMnKPezxyck3oGD7cKhSW8Rop335zrZMBuA8/054Kdfl2TbHCOkYLfZz0vzs9w9FVlv230zs6cmxZ6T448BCKxzwj5YzrUtGN+Jw0cUVN/s/H8T5xXc1jrfurmCy0/YFbGb6b3oLr3JMEHW96s/yPCuJkqDUErUiRFaCvw/g+rmwyTcQFguWF7L1OJwn4csmbdQWkcXbrg48FEv7Vr/mfW3GVZCE17I6Oxj0sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KU8Dr3J60PmTanKiFFbUDhLRx/eyKakjPN6r5APrkko=;
 b=feYB6ywp+fh5OtSHU+Z6a2Iu1BwOiCkw1gljP+fKtOvvsphXUI1i6e6QBHOg8q98+5q1ZpGG42EZJtSjJEGFg/vPxugSpHSYS+iGYCwf3JzcwKO8/fsmVa/Q/dhmngbQ47Zkq/CcSqyhdX+khsFNyrAJlzO/Xg7FIrBnUgCm3X88XnfzK6f2GTl/QpBqOgcz187cw3YLm32EZ0mWBfmMkVmwb9qxO04+bAbRGqx9dy6FRTX84sVp3BOpn+9qz3dAzncSV9RuKnM+5Tr0V6ekwxPFXtn8JklycRGyB2M6DaXeKMA5W3kWp0l0MsLLv9BWVuNKlKB4sdejSD7soeVCYw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 09:43:14 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 09:43:14 +0000
Date: Tue, 24 Nov 2026 10:43:05 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com,
	stable@vger.kernel.org, JaeJoon Jung <rgbi3307@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched_ext: Don't request private
 stacks the JIT can't provide
Message-ID: <awVcKS_leVA8gmix@gpd4>
References: <20261123145450.12725-2-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123145450.12725-2-yphbchou0911@gmail.com>
X-ClientProxiedBy: MI3PEPF00004EA9.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44d) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: b74b98f4-fab9-40e7-da7c-08df4a0f5bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|11063799006|261022075727099003|261026121527099003|10067099003|261009223027099003|56012099006|261022105027099003|261021121427099003|261102123227099003|261026140227099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LOBX+iw5X0zXiYZutcNNStLczlHdFweXtUUPf6HPt9//2y+7z/CNFlal/Qe/zSBLA+MS9+SaCbit0xh3rv+GDUC2p4WfRcTHM1RPf2SJzxaKmdJVdPnV4s+DEFYQqQjGXZoH0WXnKMnx6dGUyJ/f0Sdz+sQg/cIsnEdlw8hmClbQpm4JH/33gPABiLBKqkuP5KU6n40DVOMk6Nz9XkEpeGbjRfogft0xBeRgQiaUAX1o0bvLGAkEHzf9mkHYop1a5dXQ1ZMfvHp5BaF2rSzUASFwz9pOGYXCFIuh4CZozp9LGYv0XYTEd+tqODbJ4sv+SlJz1YLRMM3WEBRp3kTRDKecpg6JAEZf5JsoZc9KbrOqb7FdF9Mu3czmEABgzSjUVEldR3ezn4wmIB90NYNcEPfooT8K2Oh8go/AatYAk+8rImjPzp4xlkARL41+Yzg+Rna+fvykZaJJf33OhkGJDA71Pzq1r0WCBfiwy9n/7xVZYT6oE7NRZoV11+WGPvzs77/BWG+BTejZ3WojQUEmNVuaImt1L4aqxSeLecAE9ZDSWlT8bMwAM3wstabps8kxUsI+bs44SNay9+JJVq9rZhe8E5mgor55J3e3clKfaK05oRlstLjZX1zZn/K3LCwxoZ+g/hZ9N4pagxVTZGeVFfJYq5uDruGEWWr2Mv5Nh0M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(11063799006)(261022075727099003)(261026121527099003)(10067099003)(261009223027099003)(56012099006)(261022105027099003)(261021121427099003)(261102123227099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CFUPXRdMMjzuoAqG+WjQfpDI7xqVB0DWe9SDBDNbemdYCcqrDn6nD3dnc+Hj?=
 =?us-ascii?Q?cOrkwy/PMkoUT3DoJxo36LNONS/iNmdsdo6mEnvfKR7ZyOC5ps5MND34xDqF?=
 =?us-ascii?Q?yZubZC9+v/Vbo36JNi2sKCk5Vftrt8uQ2lzSjL485mTVgDuG0+jnLqPIYDWg?=
 =?us-ascii?Q?UrzPlnTDMV8YL2OncrWqyHdQ9Jee9mGx/jx/WRn9ilEMtVhayjp4G4E029FE?=
 =?us-ascii?Q?6Ye5PUgdspZd8jEvJvlpzBeaPfpC/KR/MO3ASknpyO1gO76rfEdqAVF+9MBU?=
 =?us-ascii?Q?BYlvRFuw8XvQHA+3xcSTJCoSjG2sUFUPEnkDidVtn3fKn61dZfR81146jkR2?=
 =?us-ascii?Q?0PpCuzf/QcSq0A+8mkXce+TiSYPsIBsPnRRwMrUzT8lJ8A21ti8Ef3qo8mOD?=
 =?us-ascii?Q?z6kQiwx4T+o63Gonr6deOzZwflWR+RPgwkzO/DDjT/EJf6pHHoTHH2IYTddY?=
 =?us-ascii?Q?beNs9jlwbSPsfLHP72o4Ql6RkhU/6YNqNWN2kNeHnE46Vd5MXqggHP8J4gC1?=
 =?us-ascii?Q?0uFbEaroff7MP7bKY3HunLvGp+3sjXBAqXQEGI/eevcD/y8INnPvr+TqzKqc?=
 =?us-ascii?Q?3zfX/BnU3U5HSt5J+vjs/tTlU15VaFEfRuOYj8Uj9FX03MbJzjf3Zl5518Wb?=
 =?us-ascii?Q?X94k+bkXe2bQXtsAnteK2uIuVbRFaFszareG9k6nnwrlNMB4m/17C+cegg1C?=
 =?us-ascii?Q?jKqDYrJK2E9/UYn7VoKFyEjUG4xrXaoo1azTys4cUZ0IcvaM4Bko2To+14jT?=
 =?us-ascii?Q?Tsap33JbIVtKAydo8JI6gCUCWAm3Z+xNQ2TlNHCr9kUdgT2CPn56Aj/xCvr/?=
 =?us-ascii?Q?ldxoHDSGyO+Oz68t8QfsKiOQZcMPg8IvGQZo7I1Ovw9SaaZBfhgnVE6zISGq?=
 =?us-ascii?Q?8XFNI8OZPsxNItcCua3WE62OzNwqYp/uLIjPFtGU2yV0Tp4IH+mFo0N6GxbC?=
 =?us-ascii?Q?oSQGX4AAe9VhxjsykPy2jy45zIPKFEnh9TcV1wdSBjtIE5MOKQTx+qB13Y59?=
 =?us-ascii?Q?0+vrUToYZ9YizFvL8y2JMoMUfG58ph2sRSljfxCkUFW7HzSK8Q2lAmUM4Q1N?=
 =?us-ascii?Q?sEAC2oHyFvmqqe9K7zE1xBUSj9uqdaT+T0OdBQUvRSC8+hOUNgayLbN+Juu0?=
 =?us-ascii?Q?S/p51ozueqiBqhFVU5nhhz9U3dzrON31BD3C8tNEnMHpV0FBflSLDFC5ZHra?=
 =?us-ascii?Q?ljfX7qz1XByLC6FRr+z80iTmfoJp+qQZFLqWWu3B4A5RicTJHsUhjr0GWo2Z?=
 =?us-ascii?Q?gVg59nS8b0VcHz1i4KJwMMJIP+aPNfm/EXIAFE/4fLUoqbbR0jXnIs/lwNGT?=
 =?us-ascii?Q?rQlYvlsUBXA4iTAYsadxgBhd2q0QPCRB700RgOtAoJV2+Cjnu7paFID0SUuQ?=
 =?us-ascii?Q?aw0Oo4g/b1WvJQ9h0ZPh0CmssfZ0s5lRLQjVDUVq8VZC3nUddZp9kzm0gcbE?=
 =?us-ascii?Q?/jKh029qZatAbB35Ju7DFYXAxHF1TntfBUNXasHUl4/17PYPs1kpbla9zaVu?=
 =?us-ascii?Q?abf5sm8V86G4f92V2MlyD7o3nNJUPOwdvyVIqYHRnUtHEQXXLYddoNOcH9M+?=
 =?us-ascii?Q?rRmJK5TI13lUlkVbwznmZ1lFcj0qh4zG9gOFvSVd2Ht3W773w+8yywzJory1?=
 =?us-ascii?Q?BOTo3ecBIGhi3cebHYJ5RnZiBNftyzhLwNz99aDDYuQMOJ0zwYVf3v2Ppl5G?=
 =?us-ascii?Q?NFtmMl253ijlo+6A9GFr/SBJRM6Ogcc4uYYKzwxVLdDVpE+e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74b98f4-fab9-40e7-da7c-08df4a0f5bfb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:43:14.1012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naBdBWBZsdcoNzNnDZyIHfSgarTl9XbGg6qUdaUajGfqk6nbp2PSLTKg6jo4NJC+taYQfEOz0G5p02v98lvAxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054

Hi Cheng-Yang,

On Mon, Nov 23, 2026 at 10:54:51PM +0800, Cheng-Yang Chou wrote:
> Since commit 4f8b122848db ("sched_ext: Add basic building blocks for
> nested sub-scheduler dispatching"), bpf_scx_check_member() requests a
> private stack for ops.dispatch(), and later also for ops.sub_caps_updated(),
> whenever CONFIG_EXT_SUB_SCHED is set, which is the default.
> 
> The verifier fails the load with -EACCES if the JIT doesn't support
> private stacks, so on architectures whose JIT doesn't, like riscv64,
> no BPF scheduler that implements ops.dispatch() can be loaded.
> 
> The private stack is only needed when these operations nest, which only
> happens with sub-schedulers. Don't request it if the JIT can't provide
> it, and refuse to attach sub-schedulers in that case. Root schedulers
> then load as they did before sub-scheduler support was added.
> 
> Fixes: 4f8b122848db ("sched_ext: Add basic building blocks for nested sub-scheduler dispatching")
> Cc: stable@vger.kernel.org # v7.1+
> Reported-by: JaeJoon Jung <rgbi3307@gmail.com>
> Link: https://lore.kernel.org/all/20260810031418.95364-1-rgbi3307@gmail.com/
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
> On riscv64 in QEMU (-M virt) running for-7.4-fixes,
> 
>   # echo 1 > /proc/sys/net/core/bpf_jit_enable
>   # ./scx_simple
> 
>   libbpf: prog 'simple_dispatch': BPF program load failed: -EACCES
>   libbpf: prog 'simple_dispatch': -- BEGIN PROG LOAD LOG --
>   Private stack not supported by jit
> 
> With it, scx_simple loads and runs.
> 
>  kernel/sched/ext/ext.c | 3 +++
>  kernel/sched/ext/sub.c | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 10de6bd865e8..3248ed57c2bb 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -9294,6 +9294,9 @@ static int bpf_scx_check_member(const struct btf_type *t,
>  	 * sub-scheds and sub-scheds themselves but I don't know how to access
>  	 * struct_ops from here.
>  	 */
> +	if (!bpf_jit_supports_private_stack())
> +		return 0;
> +
>  	switch (moff) {
>  	case offsetof(struct sched_ext_ops, dispatch):
>  		prog->aux->priv_stack_requested = true;
> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index d2a20114eaa2..7c069a289766 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -2246,6 +2246,12 @@ void scx_sub_enable_workfn(struct kthread_work *work)
>  		goto out_unlock;
>  	}
>  
> +	/* nesting ops need private stacks, see bpf_scx_check_member() */
> +	if (!bpf_jit_supports_private_stack()) {
> +		ret = -EOPNOTSUPP;
> +		goto out_unlock;
> +	}
> +
>  	cgrp = cgroup_get_from_id(ops->sub_cgroup_id);
>  	if (IS_ERR(cgrp)) {
>  		ret = PTR_ERR(cgrp);
> -- 
> 2.56.0
> 
> 
