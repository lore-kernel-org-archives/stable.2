Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794786553;
	b=nyy1FwoReMXRAfOf/zLX1m/w7dZKdHc8MLhmDYvJL3Cs4rD0ektouQVRFj03exoOlF8x
	 3cBXWNy0UGeOVtI1U9vNAfYNpZq9fRoX9921tvjSBqHZyT/AJAj0WGh9hbVnkVkKKNg4o
	 I1tQBoerun+N3qG0lWwiQhhpQOZs4yF+kKsKXMRkl03mj0Dv2wAvgL8u9Jerlu7dNxGXI
	 JWXJcKlpmh0M8rXE0TMDpQ34oKvVPpa7yaaEasyQ1KbyW4w6i/2TFVo2aH9J1JbzuTuww
	 zGMnip2ulLoxmCWHOVfLo5Ooap7UXR6KS0rzIDtLqHpXCF49M/34B4EA9vphXL5U+7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794786553;
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
	bh=rAH8JM6NZ0zdeFisTCf5uq/tJ8oR57fktyT32kq7utw=;
	b=2NTWFNHJ86MOw7ZV4nNUDdMIv5fSltweQzpEwDKKsiju7c/9elC9fetW6povNhh6A7ox
	 Y05B9Sj6SgwZQRSaxFjlV9OVQzr/ENLvdFOGRUMmrFKRwmqloRFvzF0OJCzkBq+gkIXRd
	 dLiZ0c8PjsKExlQ2o62CTFFwhJTzUVsPQ9BDSPmh1sSaBwK0tIW5KUxyX0EKoaauBNDwG
	 b0uppxOo7KTUsChi7OeLKL05Tp5KlEcKiywKEl5BsLTjdZyPazz2Eukf8jEFcbmBhLlnL
	 6AN/6kt9wG9YgKKfSIgvBe0Y3X5YCdC6wZUJV5YBQ3FTpXJBRk7PqFJlDm4LoqzEq4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SxjhGWKg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.45
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E78606A31F;
	Sun, 15 Nov 2026 23:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63E78606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SxjhGWKg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kG7wBJ068FXBgfedEDks3VPvVLgo0WgjCGNoy7KzeAmYt87RGrgbyyIC2tOR322MEUzAIhXH2NsqBFs2s8aViepyLm4zdQ9Gec0VfFPAGR4gdfn00xQKYIMM1UDJcc5LG2dl9IDjp5TRHU0Moo7b7wqApZ9rjsQnaO7HRH2p8+1sK3TYbeLJt8hD4BUVng7wbX6/lqeMO3BMlGUs9uEfB+wjUDKU3m0wkMz0Z1wktbBCjOAS2GeaqDTAm+bbnlELo1SxM0esC1MdjuRWlipWvaAXINo8Dbm6NzQ2qeEeFSLMVVXCAjXYwpfntVs16gFTJcS0JijYslJwI3i7WRf28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAH8JM6NZ0zdeFisTCf5uq/tJ8oR57fktyT32kq7utw=;
 b=Jz7HBciyxAdYR4l0mLrlfS02yVX/G4WB1EddrLavWYHYAwIR6+iZixT08+v5ua8sgNxlhEDoLu4ghjuGs0byTN1TlEyNBpnKEZHRDcnD+1D3pZZQ/4wLbRi609mJOETmWge76LeFt3CKxD/EL1pIWpayboDskKt4wFYoumiK1mLJ6JzBdwxLgj4tDOgRXXYkwB19Hm7go2ZX18SZFwLMqnl0EFSJI+sfvg31rzNxTp8B7ia5n68m/wzX0H0ZUm0dAtQTPh/tG6W9BMKSkys5k0xDPQ9d/uj0tYduisJE30jkAI/eNKHdqpX/Yv0TwFzuj7liGP/IrHyD62ewAIfMaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAH8JM6NZ0zdeFisTCf5uq/tJ8oR57fktyT32kq7utw=;
 b=SxjhGWKgaUj/4DpuQNzsTni26P9Cyz7a0FuXQiftRWIF1zya8XB0qOME9nYLJHLgnCsSE4kgtRm0VCVFyKHiTScdDszHHk5H0Vpw47Z4PcApqxiL+88mQ0i9jmNm+RS1+KpaCyb736SqEI09uZ9M75ijJqldU2BqWKAGeXZLmSUhects4qJftL0SaKtGfBcJmfsDe3NNyiPB/LL9a7QnUeMlgB5VfU+UAt4BpzkkVYcmbC9/pxjWDwdq1wpqIJQ9Ck7mYLm8LsteLB6BUELboJeRDFm3cK65wOw2DaFuBz2rqxTRr8yuwRLKHfv3etvwDGZHM25/SwzzWfL5NNtBDA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by BY5PR12MB4148.namprd12.prod.outlook.com
 (2603:10b6:a03:208::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sun, 15 Nov
 2026 23:49:08 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0615.013; Sun, 15 Nov 2026
 23:49:07 +0000
Date: Mon, 16 Nov 2026 10:48:57 +1100
From: Alistair Popple <apopple@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, 
	Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, leon@kernel.org, akpm@linux-foundation.org, kas@kernel.org, 
	dave.hansen@linux.intel.com, bp@alien8.de, rppt@kernel.org, stable@vger.kernel.org, 
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH] mm/hmm: reject shadow-stack mappings
Message-ID: <avpAQyLCpJPKSpT-@nvdebian.thelocal>
References: <20261113195536.2660763-1-gourry@gourry.net>
 <20261113200303.GA395967@nvidia.com>
 <179460249376.482102.14669935557901467762.b4-reply@b4>
 <20261114002027.GE3706007@nvidia.com>
 <179464112539.482102.8723246686117488051.b4-reply@b4>
 <2fc85df3-cffc-4786-a7a8-0f0a6347fd59@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fc85df3-cffc-4786-a7a8-0f0a6347fd59@kernel.org>
X-ClientProxiedBy: SY5PR01CA0073.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::10) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
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
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: dae7b820-964c-4c1a-d507-08df437309ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|4143699003|11063799006|5023799004|56012099006|261026121527099003|261026140227099003|261028144727099003|261021135927099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	BJQuXzVbfplEGGPdBqo5vQPRr60Jc+bMVTL+P0tQUjDaBoFnL7a1a7U/SPWJSWmtIIF85hdCTpZHBNRCb62Ggc1Q4UNjraeYtPwmiryihqJxrfouA7lVX4P7+qIu+CzOuuDzHWkQQT4gyODfm0bL+ydXVATRknqu0G5T0+zlMZfZBZi8oj9wI+UQdi63ohEZ7QgrmCJeaLsGglVpStN4SD+tpB/ykuMlhWbQzH1UM62jbIx2x7NHngaY7bCh5IFTLMRBh/Zy3sYzcykA3CqEdwDvYK1d2NuP7bKfRbtkCvXX5u6LAwKPSWfxv4873F4Xc0e4aST5Cq3IOyjBaYpCokPqqD8NPk0YkA+AfIUFlVJm0G5tsk0J2WnYID3oMc9E+sFkF7lvFTTFWkuHmG/y0YTu+d/BWx7ejIGo1Pn6LuoLxBnU7Z11ziUHK81pipMhh/CiK9ckQ60/OInwWm1GXNrh4OqAZDo+jGwZITMhOGk3chlxwfHbxpgR0ZtdYzJmjoDqXP+dcEjIdf21mX2k6xWkZCGu8t6R72Op9CUZaxR+SICpw+9SMQZqmi05HEJzDuuwa5w8RQyw8uVq2BnSqO3e1iww5IFujUVR5SU4oxMcdFGKP9bzNdqNs6mVEjUemXGOcaQq+4v4PD4WoCQRz1+JyZt9//i8oaSCTxmKYlw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB598757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021135927099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bDDv3VV5W/WTETQsTlWiptL99PcTIaHjxjnNKSlmlcLX0i64ANCQ/GpjVAgT?=
 =?us-ascii?Q?DxNl681OF5NipIDfwqUzSLUzYMlKXW7Y+P9AP8069PUucXDXAl2cmlhhlWCS?=
 =?us-ascii?Q?CyDA6pbbAszw8xJZ3XPRjAs6eByrTQhVSFWdrtVEjLLEPbkRTmCtJs1Resca?=
 =?us-ascii?Q?Y+g9qukUFEKyr8x0gvH7/9NzPpPLyv5dLtBwODWNPGxeOWPfnb0cmM1l0i8w?=
 =?us-ascii?Q?tAKv5fjAKqa8FaRMERetxhUyrHO3iIyIPkLbUACr58QYbZO1U8e7CrAFgVtc?=
 =?us-ascii?Q?Y5RDjzW5wkR+Ehpk5bMMaB+FylYf9LIvovDpGE5S6/Y+KhJ+/MZOqcy9h1oA?=
 =?us-ascii?Q?H+5C7bG1r2GS4N0nhxCZz5voHXkY666ETsoHhPWFI22LrgtsYj/QRQcsjLR5?=
 =?us-ascii?Q?lb6Fw3CedPXomx2Nth7XOu5oTPwtVTJUY3l3rF7VqWtnuWheFoealSHKzEGL?=
 =?us-ascii?Q?UVWmrLXAwGWvHBvVVKg3jUuB8g0ttMsthnWLHduY94ksFAPLYmlORtZclrxx?=
 =?us-ascii?Q?TTACINFvzhk2Y4d93V4EOzJeS2ecV/SCk9GHvkCDRVrQFrLZfPKApxDkJ5CC?=
 =?us-ascii?Q?N38qEspn8ztQuG1aONpH+qCWaF1oYafTRJV5OtJJ7Rxio7667dBrIj+tE7fH?=
 =?us-ascii?Q?Yj2elyneVzO25hv3MJQaa4cy5fJG/TALGm1eAETJTt7gX2+XN1OZIt4nUVKk?=
 =?us-ascii?Q?d7XzGtAxmfRRYYgWKVaSE8rChVNkYHa+a0D8mDVIzYD2Ot/BH7th92p9gZgx?=
 =?us-ascii?Q?T0v64qcnjwNZZEjYBCz9m10lJyqNFgrfLUNrWuZjGHHBO9aYb8yis26eMCQX?=
 =?us-ascii?Q?1t/tkXZkXyHZkv47Lky4/YwCgiRypUGFJMQsiNre50rkir9fP5H0yqmyzLXy?=
 =?us-ascii?Q?zxq7OflzMNd91are+iNLgJ8DTkizqc88snKzSbh3sXMRoAanBbIwbpH/XFS1?=
 =?us-ascii?Q?E1Qk5QTtjD89uGjToocVSgFdArN9scRrLYqlBc9yM0nyXNYfAKHkqtXgsykb?=
 =?us-ascii?Q?JzqzTRtN89wfDbAGbmLNGAd7MMaGgbdqs/kwBflGUTxTRtkvDFbBC5ALFrbj?=
 =?us-ascii?Q?0M/wwbnrEqeATqeTVRi2EGF61QhSdavDSjh4rRnKeNCwKVJLA9kBYODnxS3B?=
 =?us-ascii?Q?sly2tKixd5pRrboaeybi3Qo2uKvV5dVgTLUGlfjaUFEUM4C4i7h6ZtZkmwF/?=
 =?us-ascii?Q?xkjImCMDfXU4LoKPMOMN0zRlX8L1zkcPZq6uBaOljsHuuQwUe1kic360SM0H?=
 =?us-ascii?Q?XtHSwKo7r63VXqKM0bkZD+BwpkheixXr2+d5CtdlJFf8ap0prFptok4roQmc?=
 =?us-ascii?Q?TD14oZc5s4ngAEcpzYh3dM8V5070A/CUNblPXoinbjB4eJc0kvDOSYOhJAbR?=
 =?us-ascii?Q?m19wQ8lcoA6ulH9VCUpbCbOHU+zE7GUNkEIpNU9Obq3/rLR17LcnzMm2c2Od?=
 =?us-ascii?Q?0ZILbc0FDQX6UoeNkYCeK/T9Rq4RE/v7HSHrs+9LTMJxm+fejGYAbIL8vCRy?=
 =?us-ascii?Q?qXSlU+jAHRsIH5AIq4RKfv74kzBWksT2O7Xwa3rv+oY0CNsbJ5PSU5XJJAfc?=
 =?us-ascii?Q?ZZEyqfG9a7nJi/fXWnp3kCm6r6DwAOCBQrgGBsYWuk2+rPH3scuTSFPElYiS?=
 =?us-ascii?Q?sJpzbmGbV3Q+8dfMKKdAQqDFX5CCjenfiaCXnJoddxjcYVJ7vS96SR7BbzS4?=
 =?us-ascii?Q?DBZMUsirxg4oBhv7DekpTn9+HeoNeNGs6ackDfKegfRiFnJCm+cigrqwnHh3?=
 =?us-ascii?Q?QLg/sEmAoQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae7b820-964c-4c1a-d507-08df437309ef
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 23:49:07.7567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1eVf0OoDK4fCRmffcZFm7k/OwtueGSYPH8qQfFyks1d5UPX3KKM2wxCUZKuR2sTlHr80a4jWsB/odBfAhkMnow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148

On 2026-11-14 at 22:11 +1100, "David Hildenbrand (Arm)" <david@kernel.org> wrote...
> On 11/14/26 08:25, Gregory Price (Meta) wrote:
> > On 2026-11-13 20:20 -0400, Jason Gunthorpe wrote:
> >> On Fri, Nov 13, 2026 at 03:41:33PM -0500, Gregory Price (Meta) wrote:
> >>>
> >>> Some of the context is here:
> >>> https://lore.kernel.org/all/20261111-mason-migrate-et-al-fixes-v1-10-3d2454362e8d@kernel.org/
> >>>
> >>> We had a similar issue with migration, but this should handle the DMA
> >>> case as well.

Yeah, I asked the HMM question there -
https://lore.kernel.org/linux-mm/avT2FNTZoEuijEZP@nvdebian.thelocal/

> >>>
> >>> It's "technically writable" but the kernel is supposed to prevent that.
> >>
> >> Bah, it's not writable at all. The CPU PTE has write disabled and
> >> someone thought it was a good idea to make pte_write() return true
> >> because the CPU allows writes through a special instruction on this
> >> special PTE? So now all the places like this think its writable, when
> >> it really isn't.
> >>
> > 
> > I completely missed this, that will teach me to trust pte_write() I
> > guess... what a bizarre design choice.  I'm sure there's "reasons".

Yeah, that surprised me as well when I looked into how the shadow stack worked.

> >> You could also fix this by having something like pte_real_write() or
> >> whatever that doesn't lie about the write bit in the PTE :|
> >>
> > 
> > or rename pte_write() to pte_fake_write() instead and restore
> > pte_write() to its former truthful glory
> 
> It's writable by the hardware, that's what matters to core-mm, for example, when
> it comes to things like fork(), mproetect() etc.

Except they're not universally writable by HW, after all _PAGE_RW = 0. So
pte_write() is documented to return if it is logically writable, which of course
is what hmm_range_fault() also needs for certain values of "logic" :-)

So it's easy to see how this is confusing and got missed. Anyway this fix looks
good:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> *nobody* besides selected core-mm code should ever write to random PTEs. They
> shouldn't ever even care about pte_write().
> 
> We have GUP for that, which takes care of that oddity properly when deciding
> whether we can *actually* write to a mapped page.
> 
> Well, and we have HMM that reimplements part of GUP in ugly ways (sorry) that we
> missed.
> 
> -- 
> Cheers,
> 
> David
> 
