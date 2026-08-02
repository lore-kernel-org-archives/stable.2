Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B7D3B3BF2;
	Sun,  2 Aug 2026 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785679654; cv=fail; b=u17kFm1GtbJU+bPNjEp857qsYJtB8fYxt/AZm7Ch7WFJ/tP9H/eaPOWlfbpWdSfUlYkb4GYuDM0fyuU7zvymcJAKDdtFSV4A1bWNb9ZIcbLWF8kjXD/jcIkzJVdcz1Auc87YuQfa96G0wdWQO4Ti+A5OFoIm7Fvz8wbgUXeXEMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785679654; c=relaxed/simple;
	bh=a23YIHrnYRvcaty93RzgVoIfaJ/zbo0is+/FSUXN93U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SQGZ607VylLYMx3xSzh9kX9bxJx62rEIuY+EFbh/GRY74IjVkDY6zdvZ5/oWczJbr7RMcoSfDa0AvaHWcB4xZjGlSXhgZE3FK+DWSn+Qu/yuUJwhNsEqm92eN56rjFUcbNVQutJd4fpf/sj2BpHY1RrJVtUYWGMSIb9is3uWl4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sAqq0CZu; arc=fail smtp.client-ip=52.101.52.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sAqq0CZu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gwzgeqex15Z24bllSh39hL02ohb8878EI9RzXi7p3uOJW31T6l1DOqAOOAfgE4FgEapmV6ozfZjMV9Tl42GHGBHbzDbgWgBHiBZIq1kZHJjeSFOKLxRq+7TECotrMTyktcWreyXiCBKw1U7iyeRnYxkNYuWIp1641cLoXfVqtLBqa52QumnyQz4MedkwH5e+EdSyA1gP9QZh7lN7Czn6snJXZH+VgEwG5h9CRJ+seiXYV1rhbhzJ0qycHoz9E+LTaE38j8afjK4WPnLHmZEqUPOHP4Bg3vi7rTnDgqIe2hfZsdjVsfZHu9wYprzt3ZnSozejpfyOYQWnz7GedkkNrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9H8VY39uLl6d8k3eAyJ+cn8AGYRgavzAlVvafpqKAk=;
 b=vdIibguXJT3VIfy4389jqso2p5fTIsxJ6gahOh92+O17DT99LFEDKjQMDh798bAibzqFRKkEMPJOomrJBgO4UIOKBy9QWRfd0oTYHlh/Ho1mbYsQ56RgI7TkJj2ZPwRhrXMyEFZDZhMyXfG4Xafulmgfh1VUBbfYM4vQEv4C+n1dDrqX8KDoehrztR87kKgXBAZutS5vmX51F6ChJQP21Zrrj628AX77Dxm46ZWxU11gVRcnxtA5zlS1xEkkw7rx8GYs9r3j2+80w6OPCYKcYFLcjMEMnzR/IahRQkFCR816m82IY4W7Soxq7EKYnE7EydmYlx6iZFNlKTL83b6UFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9H8VY39uLl6d8k3eAyJ+cn8AGYRgavzAlVvafpqKAk=;
 b=sAqq0CZujzEcgbjJhULZ+vvWqJpg0SVZeEyKWpDVqPKJBBScZzsCU0Tw2xWExYEqD0bafB3UgzLxwPsftNE66i2/wrnbqlTnMqTRuvpasOp9RE5sfobr7L6kiu1FBkjd7+WWKFrI2hbDHeCwlX43HR6G+4wEhDgo/vkqScVsY4eqgxzGL8hfvzIb3lS8L0p1clw6e5ttjYUqQkcTNdL7UzBkeTd2vG74z7JaEd/BAZqnMg6GiJJpYY5kHkRmXoEk13lm2NgY9MhftlmkXhGaW+gWGbeSQkRfv8cc8mByWNJpbINXkYclH1jPHDw+9jL/IIsbWkChzsOxWfUhd7lZGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH1PPFDA34A4201.namprd12.prod.outlook.com (2603:10b6:61f:fc00::625) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 14:07:27 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 14:07:27 +0000
Date: Sun, 2 Aug 2026 17:07:18 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: Jakub Kicinski <kuba@kernel.org>, dsahern@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yangyx22@mails.tsinghua.edu.cn,
	wangao@seu.edu.cn, fengxw06@126.com, qli01@tsinghua.edu.cn,
	xuke@tsinghua.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH net] nexthop: account nexthop allocations to memcg
Message-ID: <20260802140718.GA368318@shredder>
References: <20260728060112.30367-1-zhaoyz24@mails.tsinghua.edu.cn>
 <20260730003845.4166255-1-kuba@kernel.org>
 <C62F834F-2E10-423F-9A2D-F5454184237B@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C62F834F-2E10-423F-9A2D-F5454184237B@mails.tsinghua.edu.cn>
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH1PPFDA34A4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 69021aab-0c9f-4313-e0c7-08def09f6246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|3023799007|11063799006|10067099003|5023799004|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AeWZ138frbR23zXpOUUjjpTC+aam8VrG09QrZhGyEPFW3Xv4tXPGgZ7LrLsIcv9byqBbcaIdQpDJIgDwq+XIepjwSGAeD+AK5eTh+nhBf9sBA0/1djNhxGdbT95e0jzF361LjzDVL83wWYBWLGZMtN6jnwMfdYjHOuelJeC4JtcPC+CNMxNDQJDbCmo8R9pOO77sEaQskVfmjbgV1hY3xSPu9/FE1HtTHA+waVtNTFowtZ1mUba5LSHRv4zuUuVdvZzEvUb2oYxKIgfmUDjg8rlj342kwhxMh5ejIKW94jGWSTTOAJQREAqPM1u4+qvaQYAdSWjxALiFUw+Gf0VGjZniSSqf7iaNIGQJFlUevFkmXjzZSuKEpZ/fIsOn9TIS2eDfFzBVNCgQoErP8XL7sSckoKgLY3leHxcnH5//dpTJAwx755VX9W3FDu0et2XpCZxrxlo1beUKTvTavvoUk6YMt/TKIV3b9LMipDFhlLjg3cSeoH8e+OQd33yW1C2HMK1vms9QodjNhAUQu4BMS5uf+UdW1e2mw6yBW4gsf64x1IwhT/wMLNEShq9OQzvA4bcRsKHQ1HJ1GONfB/APnzPDCc8BPKpIl0D3iD75OaBO8JIFUg5QPJP0ZoiMV7Zbsv8HhVDMHy2YdSzkzHp05hARUB8o6WXfuhBDznsDB4w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(3023799007)(11063799006)(10067099003)(5023799004)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N4oX+0BBo4sN52vJVlbF5enmEPFnM+cGIq3Atc2Yk9hVCropj53Z1U1ou/j3?=
 =?us-ascii?Q?x/4M1MUyC4S+KoI7mSIRBll3i9nH5EZMLslNWzfhwZkgfJYMv/OQTnMvZJ5E?=
 =?us-ascii?Q?+ZPspB6OUHeRri5uXJjLvUb1dnJog5hQVd0i7DC5nmon4Tjzz2yOEQ6fJLU8?=
 =?us-ascii?Q?to7PpYDuSj/+fklY8PVv0HTj7iglQtNfFf4Afh1SlKAQWD+Nyj9Sqj97/ZNq?=
 =?us-ascii?Q?oHFBtxSj/BzBa02R1Zp2IYIqysTpodAZ2V9FnBPEZvE0i2uqjEtyW8etUc0j?=
 =?us-ascii?Q?2X6CiabI7Qo78bLvWMvjBkkdVHuoDYzHkCTmYRaAllVDxHUgo9FvwZdtt77P?=
 =?us-ascii?Q?gH5PlEXyJRf7dgOVQExGchMo9H5mfWor0sT+Qx5CvXjCblJa+l3XeB3IsO2A?=
 =?us-ascii?Q?RK3lwNz7kyxiC45z8I3tf+Ow9GlHzVFukbbF7VG9HAKlL4//iLfSvqYdC0sb?=
 =?us-ascii?Q?U0KK1/v21u+7pZ7fAyFuxc4jr2+GUxmpQ/NKye+xwKVDaax35bmKEKY9y+Ew?=
 =?us-ascii?Q?nX+IJtrNYvOqJN0HHty7BqJRRE4ifvAyVoWH41Iv6U5ebhn/MdQq4frmU9Xa?=
 =?us-ascii?Q?oqzMbP5wbAV0N931T5xfV1v4PO55BDsxUGPf7DO04DBTgF03ayxhHVevwWvZ?=
 =?us-ascii?Q?46rM9UHE28EuncJ52nWchYNXRlhRb7JRuD4Z/7oBQhukXB0RbkisQHZkfqRy?=
 =?us-ascii?Q?lMZNdzVEhg3fk8aYSQNUTJAklD/EWmvu7pRnM9DY1ZIBEWOWIdXrKVAMzx+e?=
 =?us-ascii?Q?jWfhS4kqzCZ/RYXWiS4e7QUbF86O+kKUWAVMRUjuaicNF3hTcJPuR61q93GO?=
 =?us-ascii?Q?n8xq5K2BkPopi0J13tCI7BWslAkc6soD0hngngYnlWSOTjtArxoDFVKdjXZr?=
 =?us-ascii?Q?AjYsV3LkFv6BYK4dsYrUVCw7fQ+afhMW4EoGrDCN31s7GBxr+h7AG82iQAeW?=
 =?us-ascii?Q?Lg3Cix2xVEOgTyZriGOWFALAFwQMemPniewpDiB4pY7KplfGEoLsXp8l12Yh?=
 =?us-ascii?Q?muB2XqX7cHOAQVI8A3y9CPAHxMeJ35SRacAg2Wmgyy4CgI28o5ifQb9uiU5B?=
 =?us-ascii?Q?GRuyN7Qp+37E4hdU6saebfWfO8Wt2/BQ8xgrK21Bto3QMOI9K1L6AzBr4UhT?=
 =?us-ascii?Q?egZmW4jhsqhoC23SugmbkbScDWUCHoDQ5Onet5bf6y9VT1d0suq9+S/Mwy8g?=
 =?us-ascii?Q?TmVgZckV79VicedKHYpm4/eGm2FkTgrfJAdMST11VTHi5LC5ArjtcuBIkoZc?=
 =?us-ascii?Q?lUQ9NX2fYiFf8clYSX9ADtpW23bdQEdQ/YSysTGEqwhVzP1id8nWLW/MfGIm?=
 =?us-ascii?Q?xm+ivkrkxiqZxMksLF8Sor3cQnHrOEKnk1YG6dUiKR17xMraTjBrpw7c2vKl?=
 =?us-ascii?Q?qBlIa8q3l+o8PCDodwgIOiREn7aJtDJrN8hylTzBT0J0/gZJyY+7w/oFKUrX?=
 =?us-ascii?Q?n9bUIC6cLtW/7yjF82PZQklPdJSOIxjDWoJ/8d2BZ0x4wGIGicb3ivYgKPkG?=
 =?us-ascii?Q?nCP7wpr/iRJnTicUS2ARJ3pRSU5Me9Wwrz5mfNXc3lvVkADzgoVoEElsHP9m?=
 =?us-ascii?Q?f6eq+RaVwKijZu+cLHTtozmZWMYI1LvIBYC4TCSNdkYhJqbEBzldyMzXPvWC?=
 =?us-ascii?Q?/Br3MqywNhQ1Gzy+GPIXodjgAC8dL4MEfFQmgWht1xDqpeOkybtZ8HGeNzmt?=
 =?us-ascii?Q?5A7K0H33BJcITtxTWcZGLVyeNxfeFez2UzRsc6EjD1Xu6JSU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69021aab-0c9f-4313-e0c7-08def09f6246
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 14:07:27.5027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNjeQUzunBaSJQZ5fFXR5sjE269lcTjUG067GtU9npSeHVq5eBipcZxCvlpAQ3oXrtEo58BRggaeSW5PomDwPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA34A4201

On Sat, Aug 01, 2026 at 02:56:29PM +0800, Yizhou Zhao wrote:
> Hi Jakub,
> 
> Thank you for both reviews. This is the reply for the first one.
> 
> > On Jul 30, 2026, at 08:38, Jakub Kicinski <kuba@kernel.org> wrote:
> > 
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > ---
> > --- Patch [1]: [PATCH net] nexthop: account nexthop allocations to memcg ---
> > commit 186a5b6499e65039b5037906ec518baac2833b1d
> > Author: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> > 
> >    nexthop: account nexthop allocations to memcg
> > 
> >    The nexthop creation path allocates struct nexthop, struct nh_info,
> >    group storage, resilient bucket tables, transient notifier tables and
> >    per-group stats without memcg accounting. As a result, a task with
> >    CAP_NET_ADMIN can create nexthops and resilient groups whose kernel
> >    memory is not charged to the task's memory cgroup, so memory.max does
> >    not constrain this part of the workload.
> > 
> >> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> >> index 44fe75004cacb..c8685c5835794 100644
> >> --- a/net/ipv4/nexthop.c
> >> +++ b/net/ipv4/nexthop.c
> > [ ... ]
> >> @@ -2943,7 +2945,7 @@ static struct nexthop *nexthop_create(struct net *net, struct nh_config *cfg,
> >> if (!nh)
> >> return ERR_PTR(-ENOMEM);
> >> 
> >> - nhi = kzalloc_obj(*nhi);
> >> + nhi = kzalloc_obj(*nhi, GFP_KERNEL_ACCOUNT);
> > 
> > [Severity: High]
> > This is a pre-existing issue, but does this patch miss some per-CPU
> > allocations in the nexthop creation path?
> 
> Yes. I confirmed that the original patch misses these allocations.
> 
> With only the persistent nexthop objects accounted, IPv4 and IPv6 nexthop
> creation can still allocate nhc_pcpu_rth_output and rt6i_pcpu without memcg
> accounting, so memory.max does not constrain that memory.
> 
> We will fix this in the next revision by passing GFP_KERNEL_ACCOUNT through
> fib_nh_init() and fib6_nh_init() for persistent nexthop creation, while
> leaving regular route creation with GFP_KERNEL.
> 
> Please let me know if you would prefer a different split.

What is the reason for the split? Why only charge the nexthop when it's
created via the nexthop API (e.g., ip nexthop add ...), but not when
it's implicitly created via the route API (e.g., ip route add ...)?
