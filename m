Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793116088;
	b=KcGWhRGSEdo62fa4w/ko79HX6tBAhO6KwAA0yRXgHp6XsLaFBDQlm8/2gBbB8Qesohg2
	 bkp+HHmVOfjMiIPD0+pEcSUS13oyEKb1B+eG3noELSaS24wXDFpUw07LM+sksAivyT/wJ
	 JzJyJZkQM9cffk69S/+No5ENrOs/OdbuAKEn6AcR/xyuouPT4OkiE3Ih8HgOgjcCHa19g
	 liHX+OxQHiy4AHjKZNPShGF4VrsETtFoIJuONeWNOpfNrh6Hvkecn16ZEsf+TSFMV4q+f
	 V9eZAL7JMsF8tlIn16jfvGaJi3+UYY3PmXN4AI/27+7ZUUYf+brL4ZlyzxCUhHAwmWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116088;
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
	bh=hb93qjo6wpu47506SADV8RRsHr8SM/hDtM5e7MvptGQ=;
	b=zqJLuHhUOiw+jYFFJ+wl0elExITgr+3B/AOwjI+POG6qwK2sVfdR1YjKeoc8Y4xxpfKv
	 n6TQDn33h/uiypS2RdZIg4zC5AvLbVH3D66fFStcH1/mviCekcwbf6C0WxzXerW9hZwOD
	 g+0FzQm5q1/g6TPl3fxcoprwXLHbUnhwGBVER3HN2n1LwV2inAeo25+/HLROro/xQnEuF
	 B+vBbOfjj62P5safOQPz420j1H0zpcfmEA43e4O6iY6j5G/Jcyjy/XVaCTRTEo9DIRWQC
	 NBHwvKC/JqY7ycuwwVY4D0c8tswUu8p9dgZVjg+nGy9JTbFmtf+/i0sGY8hp8YJc61g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NRDO7eU1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.3
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010003.outbound.protection.outlook.com [52.101.193.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4ED606A325;
	Tue, 27 Oct 2026 15:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A4ED606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NRDO7eU1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkRfsbCOTG/BMdNXHfMqel6HXcYxjgl2KPBBhPRu3sgnif10q0294uUOPcYc/mMXL3pZQmpDx4kmS2tzU0/1HYHK8A3GbuCGZtpSTjBtWILHqMXKeFvISws7LS6Cqkezq0IADZ6jDj6U3Na+/B4ihD/waJyjs3cN8QHq+Pb4jueCXRqSObqVy4ER5GVQBFeGLNLzbSlQg1er6liEusLfSQJDc1dtncXJ8e5iB52XHx54YFWOsSVAgX52khsn0m/lDJG9Ad3mzajvU3wGJEOjoliEX1PF71Z8OPF54g66nBgMmV7iC2qNwEJoMdKi/F0PTCWkcfM4q62MGRHvc2BBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hb93qjo6wpu47506SADV8RRsHr8SM/hDtM5e7MvptGQ=;
 b=bdVw2H3yjr2jkIJl4JWmaklkWQqgPd9iJwLJB4hT/QxWX+Q1qac0XAHKhBUG1vpAUie3xedy1KIpSJlbonm7yN9sth5TZB25OnK1QFvm+Zlo6xXSdUwZ34qOewJypj8MqhszPUCD03a9pqW/klCoTCI+aRgeJE4jjBKsfR6NaQBiLscQPKjXPevUGjucdH8enF/hyArp5++LQss/R5x6ODcqayQlqlPCYd3F+X+hPto0ncN9jYUPJ+j3M1L4yKaKci4b9NOtW6ovRqJlX6opoZ7Hzz9PNe3x2WrSjAU5DES+GE5PtK6NhWikV4puXfOhxvMtw3hWzt01jvOcdbkf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hb93qjo6wpu47506SADV8RRsHr8SM/hDtM5e7MvptGQ=;
 b=NRDO7eU1pLDKnn9T2SpQ+NkkmkBHBL/0cQWHhsLy0orhs1QMnG2DNjCDvIgBLMyZrIX8l8vQOoUKOF8wGInGr0TpG9/PCicJttqV/oRHmV0BRbFN6YzkBW7O5AmRT3/Y7lqY36HvpPO9gfWM6sAbju+6+SxQ/HJ5zfSClDMMoxs7bdViaX6z5cGwM9AvlfWBepP+kYJtWRE9T84nJQPyxyDnZjtk7BE1OSNLvWXQgOJvnAAOWzsPGM20bopFaHqKAkGlR1YVu5nROnrkNPgWx4Sbx73zaLdDfPnwuFNULHpPup58bIJkG/zXsZMjlVQWghPhTE3UaXGW74O+8YHyhg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 27 Oct
 2026 15:48:03 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:48:03 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/9] mm/page_alloc: don't undo a racing
 start_isolate_page_range()
Date: Tue, 27 Oct 2026 11:48:02 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <04A50328-AA1B-4DDA-A929-3D77B09E3B78@nvidia.com>
In-Reply-To: <20261027-pgalloc-ai-hotfixes-v1-1-9c7d1aca801e@kernel.org>
References: <20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org>
 <20261027-pgalloc-ai-hotfixes-v1-1-9c7d1aca801e@kernel.org>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: BLAPR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:208:32f::24) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d3c8de-ca8e-4c8a-b701-08df3441afd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|4143699003|261022105027099003|261026121527099003|261009223027099003|56012099006|11063799006|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	RIzu4Qy1j0SwzIUB8kE1oAInUxai+4dk5i52Gjutw0MHkxAqGdA0tLArUz175uL0fH6T5Vd7+j5A8y2p1cxsk9dLdXzc8WU7LDse+vHUvp/h4Viw6e+NNsn513EqvoazF5F3nYmmGEXjA1W0XHu4pseZ59dSLIw9MumAl73F8PX8u5/JnkSMDJi8nK1R5oB9iZ4/psV2MITjvQzDGF4ZDw4R7YcFFWaJIfjDkYwfjvpyZLPiVgFw43cyx34QOONmNcqFMgS6Qk4t75/oXF/85WlZ3PLp2t5eBx2w/sj04rvR8yFBbiMPaKIqyWKwZuQWHz4TMaMrwdXhJSzWp6IXO7xNM/H//t2VDGgrhUXitugIz3LSoiJiCJprIPcp+rCzh/1Y0gesW27Sqa3E2PdJ7BRMgy8zHMpSNbNu1+Si2AAzM7LbR1yjwq4MLuWAVY7vqJud571dptf6ZvQkGpiGbKCtls8S/aHsrHR0gt/xXZt54TC/6mI9LMuGPC2TY/WjWgwI/b+KtE43i1eKHH7kejSQ7C3FZ8opkQsK35bwbYi0NgGgBjBBaTe52C2R/SjK3D96YR8lyFXTcvbIyM2K9TE/81ZF8fr+EystzWYYcdwVOghusg3Yz6jQm7zl4IhTjMif+TINedQDPiIyH1GV/xo2XqvW1psuy2E/Mj0sWIs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(4143699003)(261022105027099003)(261026121527099003)(261009223027099003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mXa479eOwmUuGzkvRXWoMqq7zzIMWgpcGY2jaO0T42AL0lXNXqrGS2ltCUDg?=
 =?us-ascii?Q?Auy4n+8g5mBagwjAehoNyFKlq9PgqPpujYiIl9EopFcduZR2cLCby2NE/mtd?=
 =?us-ascii?Q?IEIuu0DIb8yLeXuRSLBVaAW/jjXTWWP0F12r0lvj/acjOS5CAkhh+mhhINuI?=
 =?us-ascii?Q?CeV5nQpQCdWu8wdYuAyrJzJ4yEbhQOi/HvgETuKidSyeWGWPY7fk2IYKWLy1?=
 =?us-ascii?Q?ZFpQF7eT10RwEsznb0Q1QjTmUf6S0vB2IzyY1HWnvqIm9Q6sRe/usNJ9HuBI?=
 =?us-ascii?Q?5SCA01pm6M17waaSbEEMhPaVAwpMPefH8mESfn6G9K98BHvYczjBIbqlVmkx?=
 =?us-ascii?Q?e8wi+mEVGZ/YT8+7zgKS8kWrywGRv7Esz14xhNw/x6/jgcLYBHwlU0DxOtIw?=
 =?us-ascii?Q?6NWFiahKFWcal5c2I8Wa5MHOE6b1y4PpmZVKg7wLQXz3/g2Fnpfr6+VOKdau?=
 =?us-ascii?Q?U4dXwrbsSzWuCdSS65JKakqkz7sID+ZTMTrxiDI3hrHzNx0bSl4lY1auA3lW?=
 =?us-ascii?Q?1c+Oo4qHTFntib60tFW08ttkiXAwLd9PRgvKJriCiEP2uk8bC4NGRVycPAI4?=
 =?us-ascii?Q?1nleR0gDtxuhgHLYLo37tkTDVaMvqHZBHDL5Piom9Zcu+381vU+bWmOywkFk?=
 =?us-ascii?Q?fxFlGfSvLOSs1wBPaBUNVwRSJ1ddiJoq33bD24h0IuJUedLg/2ZY1H40b1pX?=
 =?us-ascii?Q?xnihLCj/T9RmU24UbMGgJMhRZLUUlEOFEJS/eyNw28gUpITP5cCiMyqxV9k+?=
 =?us-ascii?Q?YjIMMH6VHosFCfgjxkVmrui5VKLBKgnklmKY3bXd9unBNfR4/FlrbLB+aYBM?=
 =?us-ascii?Q?dhuGWufv3KbgksCSdIPmR9gIHvVORuBdDgZUuwks2otwJJTQPpfB1vF21rvZ?=
 =?us-ascii?Q?nXxe7Q2pL1bo1RfjnHJkj32aXGjo0LUF9DpLOACAq9HgiIq+8dy5z3h//Gsu?=
 =?us-ascii?Q?Xdc1IXwhQxb45OlvfIHf/OWPcQ/WCUrYYQdc9wTLf3a5DwmnvUVgs5PekeSD?=
 =?us-ascii?Q?Iyzh5Mb+RmOp/TzERQr3vVbYzxDbUaXMo7iSXObwTyePbJD7tEH/VahrqL1D?=
 =?us-ascii?Q?fwpnQjRxi4pY3S4erHQn9Q9iAgu+fmI2nCka9pIjbPEksQWGBLqdYCWrnp3u?=
 =?us-ascii?Q?TTUcIzdm+mg1n7FROrrpQA8O98Pc/FyoMlmejSkc2m60ERVM3GDBjnO7k7rc?=
 =?us-ascii?Q?WYYAnzt5AYGIKG2nVVoR4Masv+j/sTcw/IzBK4/vAUyZvEUmCSpjs6DWN5xb?=
 =?us-ascii?Q?yVhynCCBvSnR2XTSamw7udZbcuDwVIAIhgM5dlUncu+wbUbcJptwFxp24Jpu?=
 =?us-ascii?Q?TrKmmt/XBj3tYGegakiAJUbf1nOz0wOS7lcQIUdXfxeJM7OlDn0SCPiMjZks?=
 =?us-ascii?Q?kXxVsXuvo2Y0ler0lCV3Ho0ANQBYRD09LQzb3sng/ORCdnSFTulfyRplCedG?=
 =?us-ascii?Q?xhFiXwN5vahGCng5RyLKgcnlaBat5OuBhPDq3pCo7T7S+pEnUYJYL2iukf5n?=
 =?us-ascii?Q?SxKL3f6CIsHnsWSaquRObF+g17pNUkfMvSZF8yXXo8TpRzoNabbS2ezRG9vB?=
 =?us-ascii?Q?M7zAgZ354bB2RvpGLB28CRSPFMEkZq159hHvvTtOHSc8BO/3iEF+gooyLKG8?=
 =?us-ascii?Q?Qkk1/j7hy7BFjRpN9SHdkqE21IgSnE7Ar0VBsq555FRMiAJ7HQF9GnYI2tus?=
 =?us-ascii?Q?rDEVfqGYCOtLC1RgX8mwlxdBqiLqz0XKmwohTwIo4ymtsX3zf73DaJp7GsER?=
 =?us-ascii?Q?Ar2oH3Ig+Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d3c8de-ca8e-4c8a-b701-08df3441afd8
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:48:03.8682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSDXHXIGJSP/S0tKsJ/E1RNt5Qwqcamt86JNgpSLxhoP2E/FihIvjJPvI3m+wsbf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406

On 27 Oct 2026, at 11:46, Vlastimil Babka (SUSE) wrote:

> From: Josef Bacik <josef@toxicpanda.com>
>
> start_isolate_page_range() fails with -EBUSY if one of the pageblocks is
> already isolated, i.e. if somebody else is working on it. It restores
> the pageblocks which it has isolated itself before it returns, as its
> kernel-doc says:
>
>   We then clean up by restoring the migration type on pageblocks we may
>   have modified and return -EBUSY to caller. This prevents two threads
>   from simultaneously working on overlapping ranges.
>
> alloc_contig_frozen_range() nevertheless calls undo_isolate_page_range()
> for the whole range in this case, which clears every isolated pageblock
> it finds. The only ones left at this point belong to the other user of
> the range:
>
>   CPU0 offline_pages()                CPU1 alloc_contig_frozen_range()
>   start_isolate_page_range(A)
>     pageblock X: isolated
>   migrate ...
>                                       start_isolate_page_range(B)
>                                         X is isolated: -EBUSY
>                                         (own pageblocks restored)
>                                       undo_isolate_page_range(B)
>                                         X: not isolated any more
>   test_pages_isolated(A): -EBUSY
>   (again and again)
>
> offline_pages() repeats the migration and test_pages_isolated() until the
> latter succeeds, which is now impossible and the task spins until it gets
> a signal, while the free pages of X are handed out by the allocator again.
>
> If X is released after the last test_pages_isolated(),
> __offline_isolated_pages() takes pages which are accounted as free off
> the free lists as MIGRATE_ISOLATE. Thus NR_FREE_PAGES stays too high, or
> hits BUG_ON(!PageBuddy(page)) if one of them has been allocated.
>
> For another alloc_contig_frozen_range() or cma_alloc() the result is a
> spurious -EBUSY.
>
> Return the error, like the function did until it was reworked.
>
> Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
> Cc: <stable@vger.kernel.org>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
