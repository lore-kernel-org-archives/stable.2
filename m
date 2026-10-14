Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D2641F5D7;
	Wed, 14 Oct 2026 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011486; cv=fail; b=PzHdzmSJjQvTsToqPAW8Juj828QabDIbaAmhvNWdicHBsExiyTz8c9c+/YH0H21NUWO9dT4w1TgsoAhqiYjiOCKXlV647t2MKe2AQD8Wa51sQW7o2qjo1UGDzwxTWZixsyy5BSIFc4wjSX48qKHWApWATGfLqJ6ABJ/ay8dLMI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011486; c=relaxed/simple;
	bh=yl9svijwAXKna/pqlF6wMQIkq+NfnMPfBZb0x9La/b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RCj+DpdNB2mHqlMMGr15In5woj59nw6yXZFfzZD8rlTs83b7m5SjfaeuWVZzBqbLiBXgTYg2Chm4kU/9ri9yTpeOix40WNP8dje7SHnwfF9p7EBZ7FCLmv+mJD2WICO0VUMfa/XhbI4dmUpHaLPnveeMWfASNw4l/zdV+G8dXtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lhXqVhdg; arc=fail smtp.client-ip=52.101.43.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lhXqVhdg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B25HPaoeUNKgWx5UXJ7flPX6aTrKMm7MYBmeWXykMiFX9CVwRHsTVMHMVqfZc9kfcPZpQ2FHY8i0aSfIeRc4fnDSiWx0728XZ7B4WeHsmon2ZSZPGwCRoh1EHVnTUsTvItuQimluxzpS3u8x2oZU1lbZSzDr2wCDxTAXBpsvrP+C3xsEhegUThg3V94lX8D/BSOlgoohA8n965ATIwPxHIZDdNUppR3J2jPpykPnBVHCWFPXik+7nEqDhCE5krG8w2s2ydjkWqA0+3GisXVlPxfnANgON0b4teThGfBOxrn5SeH9ulN7txyLF1WTbime+eAD+pjiHwpk/iOW7HjnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0y/fKU2Ifrp4Fac4Ji+NMyyN41o2L8MsOiUCwLE9Nw=;
 b=jR7dYoBrF1N1jb2m/DK3k8eNF0pKrTM5rEhGuWCaKvjWyxG/y9GmjFfZarRngtFF8m2exhpCtColrJA2g1pviVQEpDEMhEpNV8oLUMP+PXRDOvC0hDPaChzMLDBfNtprAGYxMl0fryFusTY56Lst1WnyktnuvNL8eiyVajkQVtrSGug1K3BOYG5umyFoQAz9o7EXkvIv8jY2Ejd7DxdyrJ9ENfV8eXkAkeDWYNqlzW0iW72Xl23n6nN1Mbz8zeUSCicdiweKVFgiBbaNODDXw0/B6OZR+geO77sgKiI7uEeX496btgTgeMBrJ5f7NO8UTEJdXMOIhgacNadWGdWdAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0y/fKU2Ifrp4Fac4Ji+NMyyN41o2L8MsOiUCwLE9Nw=;
 b=lhXqVhdg98abOiPtuXDjPmzBIc6xG6RPBdfiFxWRgWYVx+90KcSY4NEUx6YryAFQwSTDgTQx5FXl/HErmrJiBUKbL1x71XZbsOdePmHdL+N7xPK8xQEkfSbRgIkRwyWAcs/7V0S8YgUlHgRnV2eLZTrbQmgccQqrQxYE2CZoCRde4sB9jTsZLoPNzlUyEruFlkjzODyQvzAU+RFS33kNldvbmVLZVeCgpUxZyESXiiQXLbg77PHSVLifS75Bt1Ad5NZ51B4NqZwZ4lTkBndd2M2jPO86tcadQK1Q1JD4Hc29N+zPe/+fDqpFT56D/M1stq1LfqKltUftDEWmMd6tpQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 14 Oct
 2026 20:57:55 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0472.016; Wed, 14 Oct 2026
 20:57:54 +0000
From: Zi Yan <ziy@nvidia.com>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] mm/page_alloc: count guard pages as free again
 when their buddy merges
Date: Wed, 14 Oct 2026 16:57:45 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <AD43E3BA-72CF-4066-83C3-9CF554AACEEF@nvidia.com>
In-Reply-To: <20261007021250.1665929-2-riel@surriel.com>
References: <20261007021250.1665929-1-riel@surriel.com>
 <20261007021250.1665929-2-riel@surriel.com>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: BY3PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:217::11) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8de088-0032-4609-abd4-08df2a35d064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|22082099003|261009223027099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	fRazT/53yoREXeNzCQi59EVG+tCoGWmuvJo5RXL/V4T8fPnHRN6I5ZiKMxJPwdm8Op94xkxoNBxLHfdJvmrJJv8K85NKptU6bbpgEo67urCehG2i7BBEsdMtGahUVKjW8FZH1jexojhd1DL6eamEI4uLsyfXDmRIXd2kzPZdJqx/LqnM9YuHeMjABYXLM/GK/U3s05d2aCR+vjETGTm93Hlr3EBmmtiVzWvfkGLm+Z7Yrr9rHi3USvsjK8wU7WSY4HNHXqNqsInh/xX7Llp5tF1dEpcGXngx+BkDafqfAWsItPsEbV6ChWzxuhU52o9Eit/sfPvzSW4meXMSeQ4Yts4rbstG+1+G42RcUkaiAjxwAHC3hixkKb0vFYo0jfcHIe4+i0cr0KTs94TEJS3FAKI3vg7UQS8/5J9N6rESww7p3cbkkZyiC8vE17Y/FA5JIqpP5QBP4KJApeY0w97SkuIkUgJNh2BcqCdESqRFOUuYfjA6rF5PhbmZFmGeNWT6fPH+f/LK9CS4VPI0riWMgmZWn4GwNQeu+m41O3Xn+CQtQPFf7cANnLMl7UUMUs9CcKNMpsarr5NpN6sblKoLFMSSfYUL+GBKI6CAS6yzWD5/YLFHYT7TquyLTVFLUvVMmRYrj5PpPQx4N1o1QZaP7W1yssH8e85/VSdYX8TPTPY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(261009223027099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NyosQfoIcR8EfmULEnEuNGI5euzHCcO9W6qEAECwNd83P66SuFqVof6xXpWR?=
 =?us-ascii?Q?Tt8eWnAcK14tXBDUMUmfbzxqokkTPLUIauvoISg3pG0+UxbNouSdBpqq0hW4?=
 =?us-ascii?Q?AFTM8VBIgBHbPFVTEEgHoiMzeHpnsXaRpn111DjWfm+f+xWpKadzePRrg1B5?=
 =?us-ascii?Q?KvlCtdTRBPwLFJU7+sbnxUpfDhMcomsjABYUhePjvwHhPrNU3h0dTpYiRD9M?=
 =?us-ascii?Q?xpTdeT/TkHiKLWEIyOwqB+DTS1Aw8iRKmPrERj5kuWkERTMVzxFPNx9S1lNX?=
 =?us-ascii?Q?1PZdX50QrLBXIGJBRPKRVkVzm1me8iMAw3uk3U7mVXVqhhSDb4ewAgQqB6oQ?=
 =?us-ascii?Q?x0OnLtSIataUvbu0o3ZiUvA9WmFXeNh6tcBGChnX9BAkApm5bX4ZRQLf8O7j?=
 =?us-ascii?Q?saOOlvLL0HICXOT7xCI6dyPdmhwhA9fWgDyEh8gBIucuayFClkdxeMjYXuJa?=
 =?us-ascii?Q?z6cYGziAmfEsZf6Ueo7lDQDGbdbL+RRoomA4xXv3E7Zh8toubizJplmYU86l?=
 =?us-ascii?Q?ctb+f9u4peOk6LM0B3EdXhKG5Fg75MpkWbghYiqAi21O6yXFYK3r/dgW3vbQ?=
 =?us-ascii?Q?fNNBsx3k3APfjxrYthAqzsCqdbI+59SIsecsa3RmJxPGtaCy/q0JsHj7Np8O?=
 =?us-ascii?Q?nq4LW9MbXuJ5pmpssz1+2rXJas9DopFZC0PRBXKD0Jf8kkqfUm1eEMY5+D0C?=
 =?us-ascii?Q?5u2Eh4EvfpnS3MgEipD9G4RRT1iPCBBwCR2iHwNmzNVlRc+bjwSWXfQsL4sK?=
 =?us-ascii?Q?4SGGM8/2QPxqNrvc8W1UsCzCvcfau6mNw/pNnIlwmrlYHlsPi3JahtX5rFAM?=
 =?us-ascii?Q?O/q8tk3ZAo+Bbh0/IL70jiPpUibFh3zdRnz/OT+A64NkyF6PYfNJR+gebOlt?=
 =?us-ascii?Q?nwu60obAAYGROntWj/KkPJ9B/2/0oejAJoEGlkrIsOc9/mHUHJd7EIpSqtW3?=
 =?us-ascii?Q?rFF6hjz18ggMkiCAZ4gdGn/vfOBb+t2NYpPONAo+z7mQNGUtlJ5N1uuI+15/?=
 =?us-ascii?Q?AjFkgS3MoP3N4o/0HSiUJb6Vya2Yxhsgjekk+G0aT/1IekoDRKjUFYs2VIOs?=
 =?us-ascii?Q?/7UKQNpewrB9niUIO/WVo9b1bBG5MIbBaiUkl/7ntX+EOdZ0lR1zYICQPizk?=
 =?us-ascii?Q?/EXs09lIBaOMVLZlXGTExSdUmozZfPToBV6ZBdUbIKrrUzA0RhGfdxYQLJ35?=
 =?us-ascii?Q?T4flZc4IEuvM1y7b6aWnJCLr7Lx7loO7eOmbzYdEYxjVkyNdcnUFk9rCDTOJ?=
 =?us-ascii?Q?sydBQm2E/QDFfzgGLeodJ/wXKR5gpfPE3Tle1gsoptEaZQg//ZoNGbvzZ99C?=
 =?us-ascii?Q?JqSovFMQVZLESlrobaRwDJBs5vxm6li8kX3n/2r7L4NWWoFKEDNma58As4ap?=
 =?us-ascii?Q?NLb/VhcHhvel2pJvXmUdTJ8UsK5j29tRDVmsvpNRWQ9osGygmpIX91PoYtRA?=
 =?us-ascii?Q?82XwvKaNY2X55/mi0qTSrtPbNOkLzwQKkI52+T/hu6dJycbJns7+mn2/hZIo?=
 =?us-ascii?Q?ube6jZXivx+jTxh7hvXdGJZS0SZYKxxjPbMUIBurCtxMzG3RSYJt08NMo5U3?=
 =?us-ascii?Q?/S8rN1SS9izv3WFL7qGIU7FT/JGfPls9ONMA47n+a0Td78Zou6fNr53j0+bt?=
 =?us-ascii?Q?LA4Whh3putd/MRgGG0rzuOsffbYQb2NV4i2tIB+4kAXsKnp3GA+7vkL2lzZd?=
 =?us-ascii?Q?keBqK3FNb8H9RHCnnpsDnzauTqE57f+RFMtUZJaHNq+KugzD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8de088-0032-4609-abd4-08df2a35d064
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 20:57:53.0550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdRfAHv88kMoDpDiAnBpovJRHucKyWAFyrHF2NE8css3sp917R1g+T3VxIQxJtMb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607

On 6 Oct 2026, at 22:12, Rik van Riel wrote:

> With debug_guardpage_minorder set, expand() turns the unused halves of a
> split into guard pages, which page_del_and_expand() leaves out of the free
> counts. Freeing the allocated half credits only that half, and
> __free_one_page() then merges the guard buddy with clear_page_guard(),
> which no longer touches the counters.
>
> The merged block goes on a free list with the guard pages never counted,
> so NR_FREE_PAGES falls behind the free lists by every guard that merges.
> Before commit e0932b6c1f94 ("mm: page_alloc: consolidate free page
> accounting"), __set_page_guard() and __clear_page_guard() adjusted the
> counts themselves; that commit dropped both adjustments but kept the
> subtraction implicit in expand().
>
> Count the guard pages under the merged block's migratetype when the
> buddy is cleared. account_freepages() skips an isolated block as it does
> for every other free page, and moving the block off the isolated list
> counts it then.
>
> Booting a 16GB VM with debug_pagealloc=on debug_guardpage_minorder=1,
> check the difference in free pages reported between /proc/vmstat
> and /proc/buddyinfo.
>
> At three points (idle, after a read and file-creation load, after
> a second load), check the difference between nr_free_pages and the
> buddyinfo numbers in the normal zone, as a number of pages:
>
>                 idle   after load   after second load
>     unpatched   -130        79205               99121
>     patched      -16           45                   0
>
> The small remaining difference seems to be due to the numbers
> not being read at exactly the same time, and is also seen
> without guard pages.
>
> Fixes: e0932b6c1f94 ("mm: page_alloc: consolidate free page accounting")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  mm/page_alloc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
Good catch.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
