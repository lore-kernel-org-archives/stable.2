Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794951390;
	b=KuksoeARU7RB1A/oD1Gkje+xsyg1E8E1K4ZGlm+AGNk2NVO4HFCXaGqEFMBNI0z6dnT8
	 mdmay8WgBvumroJ1+E51tsSmOpbNQeychjjCvZhz9HUGhB7kxSvI6+bgKXC88RZk+du/y
	 6SqA11SQgQqGaPM6ZZG71+hClsF0oXyEZp3Muu5L3hr7ATUK1XXgWVd0RklGU6EI6hZHM
	 bIdhGOyjLamWOb8wJ+VVbQ1ma53pjGwcVM2Ybb8eSpWL4N1w/HVJg9QIIozeco/pUjIox
	 PfWwPxQhwb2uaOxmAP3Ix+uQVGrzGUTTNr6RRj90k077CuSOcZJTOpVnr3Uv5eJN4ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794951390;
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
	bh=WPBID6TOGMMSLO5EHtGxdv3Hy8bn3TbHbNYeq6Iz01I=;
	b=csmPYG6T9xXG8O4rrBJcvOqEikLcGDNIhxpbQQRiAFhHEzu6NHUDgmboRmiHc6bxQqrL
	 rMzT+zlYFMR71RoxY1vTUOgzqvtQq2f/qr+vqHGtxWtT38Dyt7myeWV0/3wriu+usPQvI
	 +p4KREL1WFJsWSq6L5dlb5bROvZ2YQP8M++9vIIAZbXE5+AnY7cLU0lBem3HMIQ1NKqBe
	 f0ODGlNWbYSfTtwlSBSSvXMj+Svq7xWefQHXj0RnaXnkb5bxWQyQm8KwCNw5M2DTE0n7C
	 7f8ehxtf3+ygbziiiDF4P74VmySFqDWtw4jGLNE0yTLCgU0DzMuq3iKD+WOPxBx4R5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iMBVKKRk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.6
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010006.outbound.protection.outlook.com [40.93.198.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0203606A31C;
	Tue, 17 Nov 2026 21:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0203606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iMBVKKRk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bk+L9ADJnExlTHUMCaqIsVoG7D0Qn4JD01K0/eP5c/JkjOMNimhhtLbei5FyCBAgiuwTgOc2HJOn+zRHIxwumxS90y4CzICYxh05va8Me8+OOb8lztcfOXf3td/07MsrG6+k+J23jYD7pAKOu60fNe60c7nLYsjsjuLQYSZTVHE4xQhBtwHl3xXIF9YK5b2rKItKe6ZFOSr1PLToAynR+/bN5i0KBdytJ3QPqCmTi++ogYLFRXgm1ft3MZtDEdxisZ7jaA+vmRh2MbbaiJwl/L1zzDair47NKoB+JXFVabhDKaAO0Nn4rbyu0e21zdM3cbgJc2ideKOInYLhLDgk2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPBID6TOGMMSLO5EHtGxdv3Hy8bn3TbHbNYeq6Iz01I=;
 b=gBBiyFjl5zxcWnhl0gLakkgApM1vRTYchIRuRaDT3r2uEKjAwtCrfxOg54yPR0p0BTrKWhCqR3QzLUPYoUne6BtsmJF8kKEad7qvSOYUSAlNyfiZxjAOEWHw9dygbZ9ROofsbZtCa3ojE2KYmzI8C9tz0oGpFbrF9FpHC6DyyIxje4NP+sUC1unJjhwQePsHDgbxWxUpa26C222D6DLLpH/ids1g6PCQNav1gU/UE7HGm2PdKZdIme3ZwWxnk+4PA/XY6pPAKGWXZz5AYNby1/ja5vr2VJ2gpJz5Uc8sMt0ESPSw7djc7ISlBSYqK2Ady4lD6hjotgzoEgujhIdWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPBID6TOGMMSLO5EHtGxdv3Hy8bn3TbHbNYeq6Iz01I=;
 b=iMBVKKRkPWlifSpojGvVgxp/QiTf1KD+Sh01b5AdOYNXmptPUQRubDffPXtSiyMtghmVSKMo1i2ABKaZCG/Rxs4WiIcHAn1RLMa1HaPEE5jAGZjItiQuo8H+B4dpdGem2xV/W4pVpjod/HU5jG1HX6EY/kLVI9CirkpqCzahDsidrtSxB4czQoRlImWXVDS2++2RMn5tEYDsUBIjuSfO5zZ5jyuvZRtP68/6/7ckBTVK2fPNh++L+++ZOx7gagHBZ/QHMMwh7zNl6ofDBquxdG5HJeqO6V709AGc39x7mST0z7ELbgMJ7ckywmo0C4p/J7xYtJIpZmgbxszoiZkHLg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by LVXPR12MB999195.namprd12.prod.outlook.com (2603:10b6:408:3dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 21:36:25 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0615.009; Tue, 17 Nov 2026
 21:36:25 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>,
 Roman Kisel <romank@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mm: update walk_to_pmd() to explicitly return an
 error
Date: Tue, 17 Nov 2026 16:36:22 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <22C199AB-EBF7-4C51-845E-1192CE29E7FF@nvidia.com>
In-Reply-To: <20261117-huge-pfnmap-fault-races-v2-1-276007e73bcb@kernel.org>
References: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org>
 <20261117-huge-pfnmap-fault-races-v2-1-276007e73bcb@kernel.org>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: BN9PR03CA0542.namprd03.prod.outlook.com
 (2603:10b6:408:138::7) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|LVXPR12MB999195:EE_
X-MS-Office365-Filtering-Correlation-Id: 09cee316-deea-4de7-a3b2-08df44f2d494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|18002099003|22082099003|11063799006|4143699003|56012099006|261028144727099003|261022105027099003|261021123027099003|261026140227099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	uqTPaFF/1P9q6SA1xFRe7W+fZJ7SREGEkahTXtA5ccmB8AX9fM2NtCr2b5Jd89gIShjZM6CKgCEs49MW9mtLu5/a0pR5wFd7BcbyR5yzNT3wMFsxfgYs0gYDNaeSrAHbF4qg9Bnd6lRvyo/5i66DiqQKKa/igU7rP+xxkTwtGfyj+fho2AVDqn57OhgXeS7KBH5ZZo+xjinenZ9+/SQcFxeg/9NcA7NFSFuZ57F7e9c1g4hoXoJ10ode43F5XfmwwZXL5lrFZ8F4FkSHC3ic4r5u14VQwGigmZ4ILHJ94ItB75pZ0KT2PY+rjiyaoLYCGLPeomALCTs3Uwil9lbib+yEj66HxzPtcNoTIHNUgOvKMmQBnehAhLOuJe/kqXxEgYb3BDKDBqDp1M31sCHWy2z2zQEZhkUhfAk21gfpbR6KBlDDvCK3E0B33X0+m9JzruCQt2Qn6LorD7ygbWOy5QbgFn9MPexKOuchaQ70zed0+GxOYuT/9/Wek+/u1pyH+ydMo+L48EwbIuPKRsL3y2uLj58cMGZaN4XoajKaQaPEP5sO7c1J31ybf81fE9TD1rqZVQcjX1umvbnNVl4372D5z6Xs7yo2iodb+uvC41NbAZVBJyAqX9ygXTYtGWBiUojO3V9ZUdgUw4E9WoXkKuFg0E5t9zOq6BZ4uRYzvsM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(261028144727099003)(261022105027099003)(261021123027099003)(261026140227099003)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ye5pgOsdtg6gx5jy8eWf50ZASbfWYDDBpruQdt9KU8qi52VwqEo4gIDav9CW?=
 =?us-ascii?Q?xnX0wL9I/tbh4JGcXCD7N4VoXdTKBk/7hCTwIgSkDnOZMVmCmsEaRMB9nGz/?=
 =?us-ascii?Q?434HD2zAVclOCt7KN8jf508a5l0Ffygv8B2d0+FPaho5JaqzYthVVxjCoyJu?=
 =?us-ascii?Q?ZttUlaPaLPrmA5cCW47WrzshD9bTb6xMJC87DQVo4MC+bd2nPexGUhd0Z38q?=
 =?us-ascii?Q?8q/+jsOHeNdAI2VwAcKmK4PboI+3t7gXdZOuqlx8HOlcCw4VDWIK2eeu7yo0?=
 =?us-ascii?Q?NHoEtDY6rSp79N/zsR7XcE2MzmQ1s+6/+gdNacPR5mjne8VO2qkhmg4Jlc3x?=
 =?us-ascii?Q?WeY0EnrZecfqY4q9SWrAKtK3ZAFldgOXnYK+4Ff+hZtNbvzJR+ZLAcIXQ0hD?=
 =?us-ascii?Q?OIrRCSgeis0i/a6omFcVlXhi2cVWFjEZJ2TpspRYMFtYWATLogLh8JsLWYaj?=
 =?us-ascii?Q?wDHBHwxZxYLid33BGy+jwoyRUEg2CK0q948bsTEMmhWCEb3ySupJzcSJCRrx?=
 =?us-ascii?Q?ipl3Q++Q25m0aIhyNZeIFB7A3Iw5YCajF/t86S3aTRNAvNQ+2bsW13jKWL/7?=
 =?us-ascii?Q?opIx6e6RoWKLxLhPM3CH9pxCUrgHIn9qMvr/DhS8UBRD6UUofO4OGF0ljkJj?=
 =?us-ascii?Q?6bqETwZpf09bDlvPLh6rre/b+I6CC0g9evjx5HEVN1Xrq1a9laCv6jwDELuA?=
 =?us-ascii?Q?+1oZGqfWGoHYo9bKMO+bMWGJhvhoBuFCX63sUqbhxulad1aCDLL5mYdxkz/n?=
 =?us-ascii?Q?iuekyP0FVr1IMNxJmFR0JntSKE7cE35IJm4w7WrXXrxbDE0daLYaQsrYUta2?=
 =?us-ascii?Q?Cp+0HZYKDArKXzobnpkSGbYzzCpjq9CMu2iYIsgjo1KJGE8hANM8ycNaHDat?=
 =?us-ascii?Q?J8mWrmfMFRw5ThlBBDso9l1M+ifhvV3jyN0sLsbFbzRMXUER7kHw+K0bl+Iq?=
 =?us-ascii?Q?R5MuVeuKE9V+ApVISbuC1WVcCqjHZVQUyC4a8EamQkAZJWxMpXWgPE1L2+Ce?=
 =?us-ascii?Q?Iw+L5F0qjXPrke7JlFhOhY0eCmqsMSyUFr/huth3Ny1kr3dtiiiIwq6klEqx?=
 =?us-ascii?Q?xNrY/DWt3iN2WTv/xaZ3U9S5dna8YhTeOQLRpivMZLRO/GGcjAwf/HpW7rTa?=
 =?us-ascii?Q?brEx3HpaMkd7eu35EnzONgP8WOMA5hiQz9HIL0Mze8mqWCk8+5eMnOGFD27V?=
 =?us-ascii?Q?glBe9QPzy8Jb8yyYbuMd6VWtABC6CD6daGuOTZKLTbAic95WulkJNV0eLSit?=
 =?us-ascii?Q?EzSaWkV7f1J/q2b46pCyJvxQEjGUUJpwjytS/RkUeggbL2egIcTKOrtL223f?=
 =?us-ascii?Q?JTFUkZBR1Z4NeiUo0bAqFLWSktViNNCH8nsxqz7taKuaH9qjwp5HlpfqG/YI?=
 =?us-ascii?Q?6REwegv4C14WAbTNHCltz80kuEIao3oDahNg8kfjePXlLkyvhV9uP9SkFmd+?=
 =?us-ascii?Q?vi1aXHjYZWUa1cd+qRzHZ3JUZBA+VUnp/ico1JhcKYk4Ts6LJ/Yzjscen+ip?=
 =?us-ascii?Q?pXNrDPbb7Ob4Pf1w+ZolDxPMxmotTBtnL67rlqxkdd8MurrEFHzQAKsyfFOj?=
 =?us-ascii?Q?YjcrIeubRFoO4C4ehvg4GglmHzd1i30+2zTFKIyDjl91ACLH5oMracHTaFk2?=
 =?us-ascii?Q?QOi4296T5h83XBWuuvXODHrT/XV77QzqdQ39WjbtGInGVczmdbWxfJYBS0Yo?=
 =?us-ascii?Q?NLisRFKagKeegxDUCpiurQRpA4ysogwRgVzDZUnGfhDqDTfSR/PiUYo2of8r?=
 =?us-ascii?Q?+xx/5/5J4w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cee316-deea-4de7-a3b2-08df44f2d494
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:36:25.0894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAu6amjwpKiE/4e/Wo5D8u4IqQhl3wRVPy3AYu4dW1FHOY3tg4jvgLMCt3lqdjy1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999195

On 17 Nov 2026, at 13:31, Lorenzo Stoakes (ARM) wrote:

> Rather than callers inferring an error from a NULL pmd return, explicitly
> return error codes.
>
> This allows different error codes to be returned for different failure
> conditions.
>
> No functional change intended.
>
> This is a prerequisite for the fix to insert_pfn() which follows, as that
> needs to be able to tell a failure to allocate a page table apart from a
> race with a huge fault, so mark it for stable alongside that fix.
>
> Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/memory.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
