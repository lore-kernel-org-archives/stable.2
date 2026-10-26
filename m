Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792983087;
	b=e1Kpr96vilywDFeC5t4qE1wZphoCPITZQXx2KvTNfL11v9sQf0wtTHfYx276BLrk715h
	 ygABRm7TscyJywZmRfSGxqRVXnhhNRrLZy1JcUQGl02zBGSvBW9syo8ZZjRsoKWqS0O7y
	 dJdhfGHkCpli8V0OY2h4M0MUcViv2CmNqWnvFcaY46kO7cdQKcUNksgwpSVJ4wU9XN+p6
	 Tjut8aEEAmoAeT42qgsLyPhRSpuT1nXLMe90FLNzYRhF6wxChiK+VowSDzFPJZl1I40l9
	 RJ1O2IRpUaeXI3oSACQFiJ1RBDU7bn6+/r+mn+AYKWSh9vphvi9ebyRep0V8lB3+XTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983087;
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
	bh=G6OsTiixpt5M1jc2jalslJkV4KaBfj1Z1QWDgxtaVRk=;
	b=r9KXb3tDMI1a5Oxk4XqqDuYfYbFdVXtQZOfZScTBR+lepncMewWk21KvV4PtpvrwNQOO
	 s0/GwDOipK+qGWraXQE4XxDkCXvx2QeOgmshdVf2xMo2IEqY2XiG4VrPUionAB98BNP+O
	 IQ8vooDdxqIEE86nBOGzlzpY9oIa6mR1xt/piGzlbgccMz1O7nQcJMnkY5k6381f/VCTY
	 pFjPrtC+el414NyTiT9mtBrxU6DkRJIc6D5jHS9nnXdJ0ISudlSozk92TRKoEi7sVcdOr
	 ZHaKshtJkdsGBTyRq7YyjAXXG+Y4sIi2zxUo1N0KvzEVdurvbevze+XPz6UdQzmSEYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DuUyw8yv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.46
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013046.outbound.protection.outlook.com [40.107.201.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF340606A31E;
	Mon, 26 Oct 2026 02:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF340606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DuUyw8yv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLhPOmKK2pFh6taEYCBp8CK0feicZ7JlcI3SAcPjUiZ3hWjzOkdzEmaTzpOkyu3Sa7WcXcyRRKXzEZ3cYN51NKgsymmn/qjTpb5aqP3DDeNBsgjuYsjU4Yt7Jzi1+gjokSn5iz13yEIvbvhiKrGI7spiu94DVIAlmCDkbuKZ6CTSVgJHR27OvAE0XKD1Dg1IwPKijiBonbkIpVa1UObbPPHuiyFnVM4iLrPRo7O7OfNyzgSmJ31nXUIlgNSZG31fvJ+gNuxX3NOB4R3hgreUPn3GV34KVsFXr/RMPIOdQbStWIyOwStq7fcVIdFbebmoOY7wAJ6E5OVJAcK4eOh00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6OsTiixpt5M1jc2jalslJkV4KaBfj1Z1QWDgxtaVRk=;
 b=UaD+feoDSRNARHxbxBhLVtsJGfHVc8NY2IMPFBHnx4h7RMMoJ7NDBdM1Zsx6q3o+pVn9lHMZdTWPYPltjlBh/2UJo45eRPeKG9TEGHVtxjLYJV/ynoCIaHNmpl2Wlp+0cgz232bwIxM79d09vlmhp1RT9FAXg0VzqO2EofkPrenfpT5EPGGXRApa3lTsA3934k9q2EiGifQeyT0lsku1IMpJdcCcjmr5qrZ+2cz1e+dCxQp08gnyk8YU3y3DTtJjPzShRUbTtTK5i/Um9D2tmvvJe1co0pQ32WkzQVG9bF9/fuxAuEZpZIad+wUqaAzseUSAq6yw3gWKweocc+nU6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6OsTiixpt5M1jc2jalslJkV4KaBfj1Z1QWDgxtaVRk=;
 b=DuUyw8yv0+5if86sHxruuu4tlL5u4V8B3TR72BaNHQIPD3/ASZT/xdI6O4LKBHupqWqR4F+lymkWuMvEbC2ldmHqH51u64tTe8FNJGMuP2KrfghABjmZqe+3C8t1Ew7TmSLAem0ZOW7obwOwbhPfAH9ZPNtwkc9nEtHRp+i2dpI3ppvf0asKLAqW2CvnG2ey4gp5GxlygMh4XVSfn6yciEhXhC53NX+dxZsGMkCZHkswc1RCIi6trBugrYCgDp4W7EfAoEO5oecBGlNGFWFfRm2biiXld4USdD30M1EhlIfhvJiXcvkfY0G2hZ5FxMo+khhGOcn5d5Iz0F3bNUjvdg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 02:51:21 +0000
Received: from CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128]) by CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 02:51:21 +0000
Date: Mon, 26 Oct 2026 13:51:16 +1100
From: Balbir Singh <balbirs@nvidia.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev,
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com, hannes@cmpxchg.org, david@kernel.org,
	mhocko@kernel.org, ljs@kernel.org, dave@stgolabs.net,
	roman.gushchin@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: reclaim every zone in per-node proactive
 reclaim
Message-ID: <at7AJCoQCLPjUv7Y@parvat>
References: <20261019185002.3428594-1-gourry@gourry.net>
 <b7aab691-ae63-498c-8d0c-1696592eea60@nvidia.com>
 <atbZyUYli9Ioy5O6@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atbZyUYli9Ioy5O6@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: MEWPR01CA0269.ausprd01.prod.outlook.com
 (2603:10c6:220:1ed::7) To CH3PR12MB9730.namprd12.prod.outlook.com
 (2603:10b6:610:253::9)
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
X-MS-TrafficTypeDiagnostic: CH3PR12MB9730:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d70899-23c5-4e52-ceab-08df330c041e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|4143699003|11063799006|56012099006|261022105027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	xgcORFdlXCEyeKKspQE+Pxj2MZ8OjE1WwjyWfJP/2Tg1Fg1GEn5r+a4AmNUAwP7UV1BVKCbdAZgZLe57B3aWuKM3rlQep604d7neaOQUhU3zahv2YHCm933L/fcCkYD3WiyJFR9siL5aTfV9KFfMsAQOAeVA/qRSbtwsG1AhZju733I0vB1ydmZRM1Q0qSNeodgLRz7Px02Awx5/pDS0CaoY9Fc+871BupXKgjdjoUkCxqdrH3FS7ojnSrIzPqaDI8KbFKjzpHgXRrTJCgaBxfBcUTv4Q1aXh/cssQ4BJtLtiFlVOlx1e6Fh/hB8tfbzRhWy0rxsuyhTWLLw+3iZ2RoZMtVwIGb2sOZiE4awatYzp8XmpVvQMvEFHaWmne1vKvhnhU/bc6nbkT2FkfrV08wXvBOBVKF769ioq1hXe6jBxKvpO9upHeloXpkEQC2W13iq0yGLLzP3luuHGPk+83iqZgXB7WfenawiDn29jNqO2x4wUgtjduGzRAOV589aEQ4qPJPweRlSblR9/YyA8puZXxUV3QFR1zATflAvDPv983ThzoBt7OqGShW9UE4KY5SIywa9xz7uBQg3wl+e0Z7gnQgRqGKK031IY7Eka9UWxqPBiRxECp204MoFmJwP8II1pBsLtC2gI/fHRakrFIdgGcQuLgpN9FuCLd+V6UM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(261022105027099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gv8wOjyvcmsYlIGzLYb9/MmEBHkzaxevBVQxDFVE6Gb/p6uysy+Y5vpIEOTj?=
 =?us-ascii?Q?LScn0EmyyBwmb76Zz7+q7ODIXLjN9eTDLyXZalolJak+JR6WmmOjMSUedwIW?=
 =?us-ascii?Q?49WUr980xh3YibgSeK8re4yi0BT/0UNRzTivwrA2lfeWtgLbeufJ+EgUJw/r?=
 =?us-ascii?Q?HqmJSEeMv1LazCGBni1ceKeqSzohf5gs6Q2iny8z0+O+4IsJwwsjXc38OkOx?=
 =?us-ascii?Q?ZRp3NuTbxGJAj9+VOi1qV7i1yjmenG01fydxOQjW8wHb/2R+8e5b57h1rjV6?=
 =?us-ascii?Q?O5oqq03s1iu55oahLSeNLur8GNxQnYNtkE4Mwzh1j4BHQaDYRQwVcVAtw6gV?=
 =?us-ascii?Q?H/JPx5mjNZyXuGNo/InAJ4L7Ywoh3qxDGj2ekjoLPJr+cTz1ocYSg+78yj4v?=
 =?us-ascii?Q?qEMnRnh30947smLDqSghNY2S3H/tjhL15oxVdQdvfZqm8xKIezVwJu2jgFW/?=
 =?us-ascii?Q?XRhgqTicsaLTaI0k22t286doSmNOSpM8nxt+Nth7vIW+v24iXwolWnrJdkXV?=
 =?us-ascii?Q?GrBRwnxLlV86kVmKc7HvwXvjCZGCdbLreMx0Miarr+nspaGQYKXwAzJuhC/A?=
 =?us-ascii?Q?ziafET382902TpZnZMG55ntZYS5FIYrcSreuF9jqvlsbLRBt7+35OU5uI2R+?=
 =?us-ascii?Q?GUAhH8/9BJy35Nta6txAKT5ygKkvewGuqqj+c3bbzMv5rg990jJkmflIPHDo?=
 =?us-ascii?Q?H7AWNYHxhWEqowlriweXfcA09YR6UxPtlwRzKhYftU8+j4AOT02tK6SPPAUg?=
 =?us-ascii?Q?TDPJOSfPWHGf7qvFSZqmyO/jpB84J+avzk/bp6Pps2/m0FmbS1Jqo6sfFLuf?=
 =?us-ascii?Q?Jp0GN+pIal7znVdH3rXdElWpAv/VZQp3mIMoheSVefBcVXN9Hs8xDjSp1/0a?=
 =?us-ascii?Q?YHXNsDzPu2ZSoymPg3dxCM3lJT2rw8sirGk0XAtMbDtRaws2Mfioc28h/sKd?=
 =?us-ascii?Q?K6voxTlprJk1E9M4VZ4f0n7kqC1hQ8FGCUFk1LeB57bWc63SaP4Llr5rpY4z?=
 =?us-ascii?Q?8Llm5tyNEjYozrPm5kI7ZBrDS+SePJuXlrKRjU2EA+vF0nL2fatPdhvLCSUr?=
 =?us-ascii?Q?+jwg2J0vddVSl8XTRboLWQ/QBp5HCgx/9sL52/1xU9UoeTHJrlr9L7KBo4Xc?=
 =?us-ascii?Q?HA4gF7psnAJo4LbCXwbQD1407d0M46ncW+SSaufNLH3SYlWotiMvHvHjbZq3?=
 =?us-ascii?Q?0hQQXIInfPJ+W1EsXw8o/XUnRpsWWAmAlMeCFedFECY9Ap9h1KNtzQUpPj9Y?=
 =?us-ascii?Q?9MNBJhvmfC5f+pQIRkTQ2r7PkzoDdHcMFEQr8AjZ78Cft6dS/ROlNaBlydHc?=
 =?us-ascii?Q?BGjnxQSZ3lrEmIM/7EqcKV02KJKUpVaqtJUYKbGBeVYtO6mshZfIKqklLX/k?=
 =?us-ascii?Q?C/4B81I0NCeCu5VmM3jkqItcRtYY77Iib+QRjY+4wOFnFWAO/7AaT+0ynStE?=
 =?us-ascii?Q?envcWY5spC1XgwaC9BG3jRv7uIqCy/c+WaCtrmpSZe7BJRozsCB/4ATIiCH5?=
 =?us-ascii?Q?q1/c4dbM4P5EJhGDpT+4nropSRtvE43Z/bg48h5UuNSyyZll8OdiGO9pMC02?=
 =?us-ascii?Q?NnZslnby33HV6bXGXCOQrKITc4+Nupc4ekIaZl4ehfCDBqOo3CAmEqVPgysc?=
 =?us-ascii?Q?7HLeKexfTTERBLK4cNEvACtdVV9OL1CnFUYN3tNOEKyng2gDJeOfwT6Te0e7?=
 =?us-ascii?Q?qxsIWn0gwhJXaaggD/3NupCQaz3qEwb+E0dmkoHqXTII7l7Bs/Dy9Fvxdwdl?=
 =?us-ascii?Q?iMb8g94RpQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d70899-23c5-4e52-ceab-08df330c041e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 02:51:21.5647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJQMiPXki5ufOJ/+QQYlxSKDB4ARNumN6QoZOJfihiQHteO/v2PCpQEuMXIcHa0jjdgeSTTxjMMgB4PMEuKZEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483

On Mon, Oct 19, 2026 at 11:04:12PM -0400, Gregory Price wrote:
> On Tue, Oct 20, 2026 at 12:49:37PM +1100, Balbir Singh wrote:
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index e82ba737c028d..90f7a7bf4e426 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -8180,7 +8180,7 @@ int user_proactive_reclaim(char *buf,
> > >  		} else {
> > >  			struct scan_control sc = {
> > >  				.gfp_mask = current_gfp_context(gfp_mask),
> > > -				.reclaim_idx = gfp_zone(gfp_mask),
> > > +				.reclaim_idx = MAX_NR_ZONES - 1,
> > >  				.proactive_swappiness = swappiness == -1 ? NULL : &swappiness,
> > >  				.priority = DEF_PRIORITY,
> > >  				.may_writepage = 1,
> > 
> > 
> > I just noticed some other issues with this code, in terms of honouring
> > zone_reclaim_node (not related to this patch). I'll send out fixes, for
> > this patch.
> 
> I'm shocked, I tell you, shocked!
> 
> These are all things I accidentally ran into by just uh... using the
> interface.  I'm absolutely positive these interfaces are full of bugs.
>

:)

I was looking at making may_writepage and may_unmap align with the
constraints of node zone reclaim, .may_writepage = !!(node_reclaim_mode & RECLAIM_WRITE),
and .may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP), which may
violate the contract for proactive reclaim. Proactive reclaim itself
tries to be compatible with cgroups reclaim interface, so it sets these
values to 1. I still feel it is a violation of default node reclaim
parameters, but not sure if it needs to be fixed up.

Balbir
