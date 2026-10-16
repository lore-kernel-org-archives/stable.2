Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023131.outbound.protection.outlook.com [52.101.83.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DC64A5EDC;
	Fri, 16 Oct 2026 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792155932; cv=fail; b=FMahr/m7pUmCS20R8q9+cjQ33PFiA16Yh2Sxr3V7iWyFD9DjfkL6jPJ1Vy0WwYAnXrYgMencT0jJxN6vi1Pk/FCNq4h/6BZIrflBhw8AWki7IY5AY+h4w0/seJ5xGFuqSyCCPcuX5qx5mxrvbeHWh0vcel0MwdN5ApgtkrhFk1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792155932; c=relaxed/simple;
	bh=Yl4J1RXoD/FD1XBsLH3wGgkeOqLeFOXB25gcApW+JUE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aOFu9U3j90FX2YiFpE8+zysDVchLGp0hH88dATWbjpbvtfCtoToldEuIXOwow2BrgiqwG/bBGpFCgUP+BKWXHoHRC8Hvmmnyz+z9nxmk9zgkc3oAuEZrWC6YqSAw3tys4wwWPaJCGnjoSdV1iUq5rHisg1/syUK9svWTKpT6ZRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=fAAZRWQ+; arc=fail smtp.client-ip=52.101.83.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fAAZRWQ+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxDp/6U72eDhmpp4yBJQh3WS/HOXwFZE4Dg9uy1nzpz6qzj6zARunwnq2izxwnwEQdQkwhY/GGEOO0ggvMyfq1nqj3bqk0bygGqnMHPIZtpZ2xtEyWXKGBRtVmLlLLJXxm1HZsM5SwD/8uUueNfn5RR52423XrLZRXuMqL644ccNIcmubHqvYeY+ktTz83hqy/TtNfXxDbGh3GmvgUGCtxp/YnpYPxQWqAFUyM8MeXwRMKYxGIBJ2DMVz5avMvhrNOY+TgCeuXGKTauc10Ac9qVklbM++VsFUsdJa4Q4QH7P8im2k6tzT1tTyAl80d/c+XGmxdCHp8u0YpZI7YMXvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qwltEA+LdaFLY9jWzx3NBsq/jKxvBN588c+pmAnkFo=;
 b=s2RIgFgPdAN3Eikea8zJezdf5rfYeWdFvayw75gP2hxRV8g7CozkxEcJB1EShZ3zu6OAtSFnO4UJfYSQkyUYx1ias6is3yTTwR9w3qtW5seDVhBUiPzybI9lDFi5sAQ41FjX17rVr/oIsnfuVY4bv17Uf3ofzEXjK+K4N4UvbYevk7Tsv6/KcUcusaN7yTmb6IUSpzDjRZTPHQJaLl2kIPCKuiPOuJfSA8sBLqQTvh9j9x7VeuXOIEyobsIM2q68WS2/fMc0jbwMoHpxq5e9PKtQkD4EuYWbXsfBXxIEY6gWTGbsaKOs0rWVTt5KPfpEWWNmPbvOQDxPBPYhY4MEuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qwltEA+LdaFLY9jWzx3NBsq/jKxvBN588c+pmAnkFo=;
 b=fAAZRWQ+EG9llF3zMeswlJ96b3Wbb2hbAiEE5OF8arT2qnww+ae11SVWz+vanSuccjwnAx4YAGi8X6ouK9LzZ+eQA7cG6n3yC8iw3Vc/FBDT5exzLOtVfwh7jWZROfAZXDMxgB/gLLkH+EdyFEMoZ3YJhapSoQ70H8XGJV3/NBxiTrHIHEMLlTYTnolfnGWmOuhmRRe3hphCbpfvnMIr7A0EX68N69AL+RWcZeqpdbmSyTXJ6kZxCrDHWBDVvva6FkyzBkUU8Iy72L5WJbX42hXHsetCtbwWrHDdYyBadZ+4kqokcfe+GEY59m3nLij+WYO7U3rL3CJ/b0QttbqfFA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20) by AM0PR08MB644083.eurprd08.prod.outlook.com
 (2603:10a6:20b:7fd::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.11; Fri, 16 Oct
 2026 13:05:21 +0000
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a]) by PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a%5]) with mapi id 15.21.0546.006; Fri, 16 Oct 2026
 13:05:21 +0000
Message-ID: <03a10e8e-f14e-4612-9c23-70f94137a29e@virtuozzo.com>
Date: Fri, 16 Oct 2026 15:05:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm/huge_memory: recheck a special PMD under the
 lock in copy_huge_pmd()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org
References: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-0-85eaec8417f6@virtuozzo.com>
 <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-1-85eaec8417f6@virtuozzo.com>
 <5800bc6e-7671-41eb-bb09-7fbc8f2d085c@kernel.org>
Content-Language: en-US, ru, sr
From: Konstantin Khorenko <khorenko@virtuozzo.com>
In-Reply-To: <5800bc6e-7671-41eb-bb09-7fbc8f2d085c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P192CA0009.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::14) To PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR08MB10708:EE_|AM0PR08MB644083:EE_
X-MS-Office365-Filtering-Correlation-Id: de8ddfb5-f6df-4cee-67dd-08df2b86222b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|921020|56012099006|4143699003|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	YjlHwmXJs7lL3lqZQfueXROKTu6rLm9F68uG0SnigR9ntYSIq0Ai380uc4wiu27KGSQIQrucprrzPvWLnpJwTv0gDLdpCeKAFsAwJrmSgUAudT1tD97NCwa/xTFZNn++YY9jmA07uqN90e2fe1hKWqrzEF+GFemO/aM3RHBQuzcM9UswAdz06sTmVwyDUe1z5h2KcRbQqaY4UjD4bLhocB2GmSLIFnlF1uo3sHlwuE//DghDHPeIBRO7RXxk1+4nmHpv4kWinblsPVGhDMcJt+QjBLHUrWG9O/nQNVVW9QeywGapHiSkQ+dYm+jinywc2KHHpeqsMusjp3jMaXEbkt6M0L2nvkDA8AjGQNbiVQMB4bs0QQIwaZJWcDASoyoa4CfMJ0yxAivvg2B5nC4nhu6ZEBPGWZ43FLw1SzfOWuZA7UJ8lyVhMaK2s0FUv/WWGhQXkCLnd7uJad2uith8J9oZtzc3mfeRRBlODAs+uhrEAyOjsU4u/oMxBPe8ts4fdfoq9T56lUvwXeriQY2CkcOGK68FZJ9FCowZ92YflVO9G4jaFjrz+ipHp1CaAfDuJj7hubo8bWPtQRWsiovbWc1SDZG4hWddKw4cNqZF0yzn+deTz8pwTAreQwECgsAJX2OYeeI0fSltKvEuCIt4kriqo4/YuH+DbTTN8suNP10+bDAaE/m5FjWOMrEsG65srUjfGq/sEXbbGxpskHD/WQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10708.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(921020)(56012099006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z00rMzNUbG5ZeDNCbHhjOWFTUnVBMm9qN1JwdkNJbCs3RmZqYSs4U2NVcUN2?=
 =?utf-8?B?T2lrbjVQQnFhMmVlRURzS1gydFJBa3A3SDdqcjhaUlg3WkwxWHNxYTJDODc0?=
 =?utf-8?B?bUFKNllwVDIvSllieGRsRGFQVkRpSkNQOUhaNDFvRlF0NTV5TFphcXRua2da?=
 =?utf-8?B?Q3FrUHpsS3l6YkQ2SXNSdWNaVnZMQnNyc1d3c3NIZFlXSk1pc0lxY21FeldH?=
 =?utf-8?B?U1NkSFlyOGdveTJXSDhhNnpFbXlJYTNLRHJ0UStYb1dWQ2x1Z2xwVjZIR3Yw?=
 =?utf-8?B?dlVHazU2cW4vc3R2SFpMUWZDR2FVR05ycjJIdDhPdHJNbDM5ZTdORGRFUUNt?=
 =?utf-8?B?UDB3Wmt1Mnl3cHBQb25tUUV3UVc0bEJUcGY2WDUxZU51ZVR3bUIzUGpiU3Vk?=
 =?utf-8?B?ME1QMHBtVlladDhHalBCTjZDQ0FsR2V2WlRJcUJ3NHN2ODIvT3p1VkZUa0FX?=
 =?utf-8?B?WlhsVFZCQXN0U1NPekNKTzFodG1pZmJYUkZFNVRlVVFMc1BzUXhvbVBpRThz?=
 =?utf-8?B?aUl3b0RQQzgzZWVwRkxiM1J6ZjE3VTRsd2NvbjBySGU0ZGdoR1d5dGh3anli?=
 =?utf-8?B?NXlUY3pvUzY5UGdXWlBsd3JOYVpGN0JGOCtUdVg3VGJyUklUbHBNK2MvcVNu?=
 =?utf-8?B?L0pxTGd3OXdlclV2ZHJFeE1Xc093akZNVXE2SWJYOEl0T2xqekNHdFJ1blRj?=
 =?utf-8?B?cmNlRG5zMEFLNW4rODVrczU4M0piL2dUU29XQ1dMckZsMXpqSVc4OVZoNWpF?=
 =?utf-8?B?WWFvUTR4WnNjaFg1QjJtQkdrYTBtZE5adklkMnZLN2c2K3ZTandKamZKVmxD?=
 =?utf-8?B?SjRIZm1xWGdHL1FydVdGM0xGU0NyM3JnUlg5dzJQL0p3WGt3NEQyRDMySDBX?=
 =?utf-8?B?MjNSSkxkZVNCRm9udXZXZXZYZVVud0k4MWdBVktvUXgrTUovcTFVV3E0Tk9J?=
 =?utf-8?B?SVR0dXJid2M5QUJMemx0aTNBTFhLM296UkdFc0RQdGpoNEFYb0pYSHplSHdX?=
 =?utf-8?B?a2p1bEJLazQwaVpSN0FNVndLUmh6MUxNbGY3c1VrQkJuZm1sT0sxcHVuRTE5?=
 =?utf-8?B?VVFZenIrSGd5VGdodDloTUNpbi9HUDlpNi9PMDc0Z1JJczJxcmN6OTYvWE5k?=
 =?utf-8?B?U1lNWnRsaHF3Zk5qVkNubWdGUFpnekIvYlFTcTUzd0JUTDYvamhXTjFoc3pq?=
 =?utf-8?B?TXNzRmNFUnNXd1hMUjVRSWhYMmJoc1Z4QzZaQkJXUjlqMzlDeDdlOGVmYkRs?=
 =?utf-8?B?b0U5UTdKREJ6N0I5QXV3bjJxTnROSS8yMXBxNGVtTE9LU1pGS2VxaWJGM1l2?=
 =?utf-8?B?T0E5WCtXYmprNGJRZ1h6a1pmTGVrMXFkMTQxY2FGRkRLTWdPVkJIbU10UVhy?=
 =?utf-8?B?ME9icmdBektTMUEwcmNPeVVFQUhVN2VjRGpGdjJsWGJwM1U1K3J2NnJCKzY3?=
 =?utf-8?B?TktVbEU5bUYrN1RFSUh4VFRLNmpvTHpTdlBibkZWdGM5Mm8wTk9TbitPeXRk?=
 =?utf-8?B?TFl0eUJIanh1akpWU283Z25pWVZKTE4raW00UFVoVEdYeEZMSSs0cnFmOUpE?=
 =?utf-8?B?TXJObG1FV2pQaVhnVW4xcTFlMVgzbGh0bXFSQmUzYXNZUyt2SWorNHRIaXJ4?=
 =?utf-8?B?NmZTZ21VQlcrK0FWYnBQSXNNam9YQTVmdmRYRi9VTkxUWVRVRUQ2dU1jWXV5?=
 =?utf-8?B?NjVHK2FUNlBoU1Bkd0Q2VzdacG9iOGZnQTREMFE2a25NM3IxZzAvK3o2WXFM?=
 =?utf-8?B?cjExZUlJT1h1ZzIxbE9jWVNlejRjb3M2akNQcWtVVGpkUGY4SURUMCtPYTkw?=
 =?utf-8?B?anF3Vk9nUVNGZHJMdmJMU2NsN0tIcGxYTU5Tckd0enJlM2w5T3FuUWpJMHd3?=
 =?utf-8?B?aC9GZjhyQ2lKM0huOEc0L1dmVVBobHp2Y2N5Si9leWlmU2IrYkdGck1HSm01?=
 =?utf-8?B?ejRXZnQ1TWVmakRwQUEzWVF5ZWR1c2JWUjNZdWhVcmpobzVpeng1VUxxa1Yv?=
 =?utf-8?B?SmZBelBEb1Bra3JJM2YrUlBPalk2M2o5RXNqU1pncmZnKzB1MUJ3SVErMnlk?=
 =?utf-8?B?REQxMlp5RUJzeXVFTW5MVW1MbUFYdm1PWlQ5QUZDTjFNODdiRkRQSEd1dDNM?=
 =?utf-8?B?SWVCVlJELysyVlBYZE5Rc0ZzWVdoNWwrTWFlWCt5cDJuUDJyTUQvMnBKVXM2?=
 =?utf-8?B?YkNyWkxFRWw5UHhiMW42OVVtaWQwb21VYWpxVXBZVzNiaGIyRVNwVGJTVlVk?=
 =?utf-8?B?TFNjMHphOERVU2pTcjlpdEhSOGhOTk9PT3RsaVlweXZCeFNQNjd1alNVSk50?=
 =?utf-8?B?T0hXek9wU3JJQm1JK3g2d0hIdXMyOTNhaU85MGtTWi9KcEhlWlU3Zz09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8ddfb5-f6df-4cee-67dd-08df2b86222b
X-MS-Exchange-CrossTenant-AuthSource: PA6PR08MB10708.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 13:05:21.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8JBA2rEgGR4ilCt7G5NvslYlUpsRfoTgGFalXVK+SnVMW55QEGNQIVAbXmQg32yPLkr1E3plBmRhbJwjL/w5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB644083

On 10/15/26 16:14, David Hildenbrand (Arm) wrote:
> I would have thought that unmap_mapping_pages() is only called in
> corner cases when we would have concurrent fork().
>
> Like vfio_pci_zap_bars().
>
> But yeah, likely there is a theoretical race.

Agreed, it needs a zap such as vfio_pci_zap_bars() racing with fork()
of the mapping owner. I only hit it with a delay injected into the
window.

> TBH, I think we can drop this comment entirely. That's just simply
> the right thing to do?

Will do. I kept the comment on the CoW warning below it, which is
about something else.

> But why do we do this early copy dance *at all*? I think I
> complained about this vma_is_anonymous handling in the past.
> vma_needs_copy() is the one deciding whether something should get
> copied or not.
>
> So, can't we just get rid of the vma_is_anonymous() handling and
> perform the weird special-pte check (that I hate entirely) when
> already holding the PTL?

I tried exactly that first, see "try 1" below. The early
vma_is_anonymous() return is gone, the locks are taken for every huge
PMD, and both the special check and the skip of non-anonymous VMAs
run on the value read under the lock. The lockless read is gone, and
the race with it. The skip itself has to stay, as the anonymous path
cannot copy a file THP.

That makes fork slower when it walks a VMA full of huge PMDs that it
then skips. vma_needs_copy() sends such VMAs here, for example a
MAP_PRIVATE file mapping with an anon_vma. fork() of a process with
4 GB of shmem THPs mapped MAP_PRIVATE and an anon_vma on the VMA
(2047 PMD-mapped THPs), median of 2000 forks, 4-vCPU KVM guest:

  v7.3-rc7     86-87 us
  try 1       131-148 us

That is about 25 ns per huge PMD, spent taking and dropping the two
PMD locks only to skip it.

So "try 2" keeps the early return, but decides it from the VMA flags
instead of a lockless read of the PMD: a non-anonymous VMA without
VM_PFNMAP or VM_MIXEDMAP cannot hold a special PMD other than the huge
zero one, as vmf_insert_pfn_pmd() requires one of the flags, and the
flags cannot change under the mmap write lock fork holds. Everything
else is decided under the PTL, as in try 1. fork() is back at
86-87 us.

I also tried vma_is_special_huge() for that check, but its
vma_is_dax() test on every huge PMD made fork cost about 17% more
kernel instructions than v7.3-rc7 here, against about 1% for the
flags test.

Both diffs are against v7.3-rc7 and leave out the deposit fix from
patch 2, which goes on top as before. If try 2 looks right to you, v4
will be try 2 plus the deposit patch.

Try 1:

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1958,39 +1958,36 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
        pgtable_t pgtable = NULL;
        int ret = -ENOMEM;

-       pmd = pmdp_get_lockless(src_pmd);
+       if (vma_is_anonymous(dst_vma)) {
+               pgtable = pte_alloc_one(dst_mm);
+               if (unlikely(!pgtable))
+                       goto out;
+       }
+
+       dst_ptl = pmd_lock(dst_mm, dst_pmd);
+       src_ptl = pmd_lockptr(src_mm, src_pmd);
+       spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
+
+       ret = -EAGAIN;
+       pmd = *src_pmd;
+
        if (unlikely(pmd_present(pmd) && pmd_special(pmd) &&
                     !is_huge_zero_pmd(pmd))) {
-               dst_ptl = pmd_lock(dst_mm, dst_pmd);
-               src_ptl = pmd_lockptr(src_mm, src_pmd);
-               spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
                /*
-                * No need to recheck the pmd, it can't change with write
-                * mmap lock held here.
-                *
-                * Meanwhile, making sure it's not a CoW VMA with writable
-                * mapping, otherwise it means either the anon page wrongly
-                * applied special bit, or we made the PRIVATE mapping be
-                * able to wrongly write to the backend MMIO.
+                * Make sure it's not a CoW VMA with writable mapping,
+                * otherwise it means either the anon page wrongly applied
+                * special bit, or we made the PRIVATE mapping be able to
+                * wrongly write to the backend MMIO.
                 */
                VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
                goto set_pmd;
        }

        /* Skip if can be re-fill on fault */
-       if (!vma_is_anonymous(dst_vma))
-               return 0;
-
-       pgtable = pte_alloc_one(dst_mm);
-       if (unlikely(!pgtable))
-               goto out;
-
-       dst_ptl = pmd_lock(dst_mm, dst_pmd);
-       src_ptl = pmd_lockptr(src_mm, src_pmd);
-       spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
-
-       ret = -EAGAIN;
-       pmd = *src_pmd;
+       if (!vma_is_anonymous(dst_vma)) {
+               ret = 0;
+               goto out_unlock;
+       }

        if (unlikely(thp_migration_supported() &&
                     pmd_is_valid_softleaf(pmd))) {

Try 2:

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1958,32 +1958,16 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
        pgtable_t pgtable = NULL;
        int ret = -ENOMEM;

-       pmd = pmdp_get_lockless(src_pmd);
-       if (unlikely(pmd_present(pmd) && pmd_special(pmd) &&
-                    !is_huge_zero_pmd(pmd))) {
-               dst_ptl = pmd_lock(dst_mm, dst_pmd);
-               src_ptl = pmd_lockptr(src_mm, src_pmd);
-               spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
-               /*
-                * No need to recheck the pmd, it can't change with write
-                * mmap lock held here.
-                *
-                * Meanwhile, making sure it's not a CoW VMA with writable
-                * mapping, otherwise it means either the anon page wrongly
-                * applied special bit, or we made the PRIVATE mapping be
-                * able to wrongly write to the backend MMIO.
-                */
-               VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
-               goto set_pmd;
-       }
-
        /* Skip if can be re-fill on fault */
-       if (!vma_is_anonymous(dst_vma))
+       if (!vma_is_anonymous(dst_vma) &&
+           !vma_test_any(dst_vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT))
                return 0;

-       pgtable = pte_alloc_one(dst_mm);
-       if (unlikely(!pgtable))
-               goto out;
+       if (vma_is_anonymous(dst_vma)) {
+               pgtable = pte_alloc_one(dst_mm);
+               if (unlikely(!pgtable))
+                       goto out;
+       }

        dst_ptl = pmd_lock(dst_mm, dst_pmd);
        src_ptl = pmd_lockptr(src_mm, src_pmd);
@@ -1992,6 +1976,23 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
        ret = -EAGAIN;
        pmd = *src_pmd;

+       if (unlikely(pmd_present(pmd) && pmd_special(pmd) &&
+                    !is_huge_zero_pmd(pmd))) {
+               /*
+                * Make sure it's not a CoW VMA with writable mapping,
+                * otherwise it means either the anon page wrongly applied
+                * special bit, or we made the PRIVATE mapping be able to
+                * wrongly write to the backend MMIO.
+                */
+               VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
+               goto set_pmd;
+       }
+
+       if (!vma_is_anonymous(dst_vma)) {
+               ret = 0;
+               goto out_unlock;
+       }
+
        if (unlikely(thp_migration_supported() &&
                     pmd_is_valid_softleaf(pmd))) {
                copy_huge_non_present_pmd(dst_mm, src_mm, dst_pmd, src_pmd, addr,

--
Cheers,
Konstantin
