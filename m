Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794857516;
	b=NDetcpEXiaO3eH9fuduO/J7ECOPf/qKjbhiYvWbDbFV3AHw8aUVC1f1uIPhg+afj3NRD
	 BxuuY+LA3wAYaSAnyYvAdMivRG+S7kWRV14ojSkdGFLXfrAJbKpvtr1NB9gy+f6b/TUSq
	 0hOjtLGMG1QPeimb2Cg5IeP9QIrNIPESMLJ5r26USZTgCjTc15ywHePhgrddhX/uOp0PI
	 bXvxHUhbMJEt41lyx3DVcePQOMgUX/Z2w6fDg0BzGh9Y/g9OYMCvB8OjQ5ogkuLudGy0H
	 0oQ5SmhGaOEWPkWdfsvnjwSNZlkFgWAPl4ZPB4x1Kl8Ccz8O3THYTzjJXf3wmVDdAnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794857516;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:X-Mailer:Message-ID:In-Reply-To:References:Content-Type:
	 X-MS-Reactions:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=qYPCpAb1FY9VNJpL+EWXBVDPnkM6qO6jgIc6uryhp44=;
	b=H8Tsh71dcAkBqkDhxCTw0xufM+JQTI6W+fc7F95grmNr4JAfIn47gHgBKpogHEXTRjKy
	 pPOq6aiVaD/v0EFdJ03Cj7x5HqLC50fob7Y9rlrBqW1zPQtFeSCTkiI6dBjBU4JmcuwBa
	 2P8tVaXoiE0yz9c01p5kFZnziVH8vouHR0/b36tL85DHphOT32Bj8Amilm2q9lU/Xc3Ck
	 Kwa0Jvt+AAKnY7SnQ2xqA1E7AcV99LLtGP9+Yfr/4GPN54+80/WPVjOVBuJgV1nqszZbv
	 ntRRgRmYN5ECtLtV1rWMOgEbELT2+DVzO9QzKcUIudU86WiRRkFFRYiEWJWwbRFP1hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="SHm0kT/3";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.44
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013044.outbound.protection.outlook.com [40.107.201.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D04606A322;
	Mon, 16 Nov 2026 19:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76D04606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SHm0kT/3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGgpqNF1qmOigKiHniXPrat1d14QgWdoUhQABgDZ1xhGlkHKnK6q21hWa4Is642R4APdH2SKRO336qZy/dP07sQvrMYP3aTQ47eN6nUyk48Wis8K6za/B+gpG2CZDfMuDCAH7UuUjUc5xVAbVVdzmqlxSQFo9PVX+k+f71LY8jkWOijghXl/V8pFpxT1h8TZE1eeGaBk8EYoXJet4+nKYvEEZ5anZS7mR3GIUs3QEJN692KAWwS5aid/11WQDJFore8GTAiCn0Gjb5AiLUd7gCIRHfrKndwEzQK5WttMPhUfKiwnxNp4E/RT9a5gDBVb0DkT11URAhqMbKOY4YORPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYPCpAb1FY9VNJpL+EWXBVDPnkM6qO6jgIc6uryhp44=;
 b=C03CVx8TxzRKhtoBjVXiMpL2gDSwvR/w0xo7LZmi1Ugw5j6zykJb3hrBO/qxmERHFFAtyi/3ZX/1NeLxkTOXcoKQNNq+D7Giv1qGR4P/D7uMJD3G8x+4vxGD/NcN52bhO6ObW6/6pPWlEIJTzG/Kj8FvEAKO1AiezfL0sMw1eNeI2lN3P840FNreuV5Ll2YdFq0D9O2Lix4vvYt1FhEhCA09ZcoVlBzu1bnxvfqVXAd1UxcdP8EI2aYV+TWTgwe5GSbXVPnZ3I1P4+9rx8lFaCswemV/agW/kxqV+2v2jbp3QLqVq2ZAunraz6y8PP7RTVw40lJX/wBDx4VnwASQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYPCpAb1FY9VNJpL+EWXBVDPnkM6qO6jgIc6uryhp44=;
 b=SHm0kT/3maonlcGqV5ITWbYkD4WUpKcqU39krG6nPNmrOB7QH3UBzqnXelGIu1+PWAjY0aivG5Zml4F2ib4BTGkp8Iz5gsxYyYzTFmRtGDhL2PKuQlNku1oeBt+d3d/M0shRO9LtvFbaEm4PoEpx4juSQmBqkdeVHdPL73mgsro/6ZpIs3px+4gLldVL3VljQBkXU4iK31kMys8zD8jzhsvzCJc40tT+20UDGfw2eo2KbF+8eGGc3LQQdqkPRBxpasxQBkN+j3vw1I1h8pokzXGUscdR62eX/gLDK/BqKNbIJiyEF70SgcFcrDl5e2dsHPXk8ix40OxsBUbbW6/hZg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 19:31:48 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 19:31:47 +0000
From: Zi Yan <ziy@nvidia.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com,
 byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com,
 joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org,
 matthew.brost@intel.com, mhocko@suse.com, pfalcato@suse.de, rppt@kernel.org,
 surenb@google.com, vbabka@kernel.org, ying.huang@linux.alibaba.com,
 kas@kernel.org, hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 kernel-team@meta.com, baolin.wang@linux.alibaba.com,
 Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mm: don't PTE-batch a swap-in of a folio with a
 hardware-poisoned page
Date: Mon, 16 Nov 2026 14:31:44 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <7D33217C-8F16-45CA-B88F-9A619C4DD73C@nvidia.com>
In-Reply-To: <20261116063624.1382944-3-usama.arif@linux.dev>
References: <20261116063624.1382944-1-usama.arif@linux.dev>
 <20261116063624.1382944-3-usama.arif@linux.dev>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: CH0PR03CA0373.namprd03.prod.outlook.com
 (2603:10b6:610:119::7) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1977d4-4a1e-4b09-3517-08df44184144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|7416014|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006|10067099003|261026121527099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	nCRwJqXzfSfI9Wt5N4Id+g2cPqAcMbZ7QYGtOvnu60QuiRkR1RI0mNgkJ27rNfz/O/TVM79oHdRQ7d0JtEYDJ1Wiy5t26fZVXyQ6w/xQSGfXfVXpZa7U4eNr8roX0FcpgWNYhp+mSQUxxvX+8SmL93PHJbwdTlSck5GH6D/dm6gtl306KxHcH5qdY8zqH3DzYyicyJzWNrbTGINj9GgjIbOfHP5vjIjvYrP2cxh3XaUrVzHrznOsCi/D8PhVCWz4CbBP3Rf6Amwa3ZS+TGFeu7nsmdngnrTEcDuBK3Dp7jcxkWob5KaS2At0lKQwJ1q9+3Gz90H0krXW8Zaw/n4LFgMT8H6qi6qmA3O4UJULqJAqV28EtzlT16WmN84Z+MyqoWhXb1s0KwKQwvWCph8YjsNTR+x29NIfCymu9UnOoaq2+FLj5P6njJJJ87PT+uXw8vRri5DREs3QOH5HwMPiMfzBeAdhVBVPGk0b6GMKzu+siHiBfH+Tyd/kqF5tMtIxge+pSKnHNVTL5OM2mg7gXWKC+ps1VAMkee/jjC7nTtpZMUCm4beg2bkIIHEw3cXmjT4TpVxm8zgarwXmoCwxqi2Hl6zZgcPT8QduKJu80CJ1z/MZilSJVgXGEqaLhfiAm5eqhnBOmEk+55Ujd1NvYgpujqHqlZ28nRC5u8J9Sis=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(7416014)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(10067099003)(261026121527099003)(261021121427099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YgdjFNU0zB9qf+7R5pAkxgh5VXwgI1tF/7xUJtiTyDJe6n8n/5Mq619pOxc8?=
 =?us-ascii?Q?+7l3inTTJW10l5yhP4nMfL1rV+0JSK/osNWlRV2zGoMFZRDjF+8mq9fzZnX6?=
 =?us-ascii?Q?lXkeWtWPcvuUfKSprIjftF4+eGdEUsj4ZoJ3iBqPAS9vg8n1uVdXnM/Cy57H?=
 =?us-ascii?Q?ORPWkUrOpnRV3uTBHJ9tI0zoWCYTkuuntDp4+yep4w5f4jPMMk9NY1hW8C2G?=
 =?us-ascii?Q?8CLbZLt+bzA6e7/aWvrQ6R38KJAaZ8zJFeCRfrR6ib4etqWADt9NHSpxCyP8?=
 =?us-ascii?Q?GIJ3RM6c1DHx7NTfqDdj3P+HdBpfEVVkOmvT2TOKp4dRn7PxNqivj9CxWpIg?=
 =?us-ascii?Q?Ksmqhd9fYBkkonCcU42p3DpOYJnxb2jkANNbJWhaIaSmfU8isr2zg2I0WKKg?=
 =?us-ascii?Q?Ab4bi0PSSJhuWrTxhgEAPwaH5hVeeYVufaOpeEW8S8BfLhGvMUDdNv94d9+W?=
 =?us-ascii?Q?LA/ZaETRPvfTGmY27YnO49MzHZH7zEUJWTDQqehVG3Dp2Y7HKhd5usJecjLG?=
 =?us-ascii?Q?oh96RWlWaOi6GPSa1Py6ER0rx2GJW+kmAsNfDKJdT5fIbgzrEqLV9hJQxGhJ?=
 =?us-ascii?Q?/pZaVyz3vsDCG4Brj6CGW27h8gp4ZEPO+UgpcZixKqaTyKwB5m3KfazqFoBd?=
 =?us-ascii?Q?lIV66RNgSRcc5+l41XWKNkdhRyW7fHIka3bm1ca19CMzMXHOx2ost+b+BK6j?=
 =?us-ascii?Q?er6iCCG7g3XfFp5tjLiA8xH3Hp5OGDw70r0kgao9qDXTrYlr50loL/ZjwoZX?=
 =?us-ascii?Q?n/OheiJv4eO7l54Jr4W8gQAUYDXNyTN+QY90vvcdj/T9iQEuje1G0tMuYqCi?=
 =?us-ascii?Q?aMNu/VnmgHNQ7hAOz3oT1ako3GnDI+Faldkb68Z+DXqT69ZmzP7zGSstvoDj?=
 =?us-ascii?Q?cr9T7Q6JnxNL5BJ8tj9hlLPvIzcapTFx7xo5i5cr/1H0B/frrePm4YMFBQSh?=
 =?us-ascii?Q?ihcwVFwep7QmDjqEOagsiMUnsT3t1TS5lSzg8GVy+qPdztf51SKBlGkhF2PU?=
 =?us-ascii?Q?mUYZKZcEiB+LpJlpRpdWJoJXiwXZKmqX4u9tY40SBueYfLps+IaLNZ5oWmjf?=
 =?us-ascii?Q?ZVAdAhPos8TK7lEb7G/GxYerL7n8+olRUm7gKMBHoNiibWabJM8gmGmBFzo3?=
 =?us-ascii?Q?IwPwaTtNxUWQNDI6MJtrcWFP4PCXokVCAN6JWM7WzVA9WiROe9TdF04BPOSr?=
 =?us-ascii?Q?/ZNPXR+09jDQsnk5o2txukhxRbbtK5UL8B0epC7EuEu92lwDq1mkj3FvznZ5?=
 =?us-ascii?Q?yKyUiR84kQz+wX7WV6X7dX+1CCpeSRfeQtTsQRNVKQ4XH64Jj5Dv2JHk8cZB?=
 =?us-ascii?Q?TMFrdGjmlQvOd4nIn3jk4Wuqs7nUxeGY/0H9x+TwDJu2SwyYcZvwIOts0VlA?=
 =?us-ascii?Q?8fAuXY5jqfxh7e/+hM02CfWm2JS2T12upV/zLDsUoOykaAJxEJN/X4GMDY1s?=
 =?us-ascii?Q?MOBYtmKQdDXUUrWpsJudWYUh0L5guCnq56USOjKG1nSS+AOh8nU2FMvt9Usu?=
 =?us-ascii?Q?wmYCt3biRHPKc0dW4GYcNgX4Z8LZUlxfW2/vWrCDmDKZw4iI+oUqo1k/FID0?=
 =?us-ascii?Q?TzP6H/GQP/RfiC+DdB/Jj7/Qd27W4l82sYZoZiorozUO6CMv6z6yXxZllC1l?=
 =?us-ascii?Q?pvOwVQcrL2K35LpHq8rlE9tXJmANqV3M1DyWGhuSkkdg2g7IqQoczWvwqGcV?=
 =?us-ascii?Q?q9FVlFZYy6QzAdTCqKnQ0DahbevO/3OvDUwq4/8ewwdkkyze?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1977d4-4a1e-4b09-3517-08df44184144
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:31:47.5892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nabj33zV+YS9WAFlAhidgsEaHMSpdd70tQZ2yQLpIZfUCiJv/HtzBT3fGK1Y5xD3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941

On 16 Nov 2026, at 1:34, Usama Arif wrote:

> do_swap_page() checks PageHWPoison() on the faulting page, but the
> large-folio batching path then maps the rest of the folio without
> looking at its other pages. A poisoned page that is not the one being
> faulted gets mapped anyway, and the fault that would have reported it
> never happens.
>
> Skip batching for such an anon folio and let each page take its own
> fault, where the existing check catches it. do_set_pmd() already backs
> off the same way.
>
> Leave a freshly read folio alone: it is not anon yet and can only be
> mapped as a whole, and falling back would free it with the poisoned
> page still in it, which the retried fault can then get back from the
> page allocator.
>
> Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  mm/memory.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
Like David suggested, it probably can be placed before folio_pte_range().
With that change, feel free to add

Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks.


Best Regards,
Yan, Zi
