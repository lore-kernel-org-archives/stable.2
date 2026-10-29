Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793257469;
	b=0z5OlxaQiwN0bAvZw3JsRQBDrryFyu3ULfcUYCeA+rhS+POD4YMIGvuaL/BuX+XUFXUW
	 GUMciZlBjnFTG7XI5WHikyYBsq+80tQggjg6/biGnbiU9eDLSdUv2Va1Fdj43yLzOwSOt
	 EVemDSqepk3fncmC4tgloFZAQaCo3PXVsDg12Wmnxcb6DQfvVF9KeDuHgjTrSYtex/54/
	 EYtAX7WVYM45sWC+PinuF66X05CuN2kNGH0GKj3C3GTmu6jG+96X21AyzXLph7XzYsCqn
	 jw6/DME3vHHtKDmelluM8wMOup2CxEZ7maV9U+YJjYaWDn9YNs03LitQvHs+bI0OCFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257469;
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
	bh=B2IyQ4vSKlxarRe3pQF73VFmc7A99AzPV7bW9+sTKKY=;
	b=SCeh1n+lDN1jRrWEkCp71KMKmkAeqOiXhwJKDGXTfZ5dcbZTpLsaqSQb7btNxdGNruYA
	 XBU8zb1DoxobAHD7TftXHUnsNawp/Y/dOEkd9eP+eR3lRBJb54ntyBE8umIAPqQCihXwj
	 BFDn11glePVsJE/ihV8JVpZMYMdJ4jqeeclyCSTfQjo7qw96xajbCI2UQ2b0hKLNoRvYL
	 YOH3ZOLsRZ16d1OZqFVRk2hRN7NfL8vCdRjk/qdmf1v1v06n/FmUCE3YZ586mQ+Zg0Lea
	 sMBaXAV870ccqZbSCvuZ1CuYqzXhv1n8XHu7FJ2JB46wFJ7kOT22P+Sxjgagr1tePBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iLncvtzN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.12
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011012.outbound.protection.outlook.com [52.101.57.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1530E606A31D;
	Thu, 29 Oct 2026 07:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1530E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iLncvtzN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQMzCgfMT8FqZwta/1Oqqtb9RWpb4mS4m7Yx4HYWW9pCtN/r7nLF8Xt7km8Uy66tgFIdj/3IpopOAdUalofVVxwvhUbcBFfR0+0c4t1puKk/06CGjaxoVZzKebxEzMrxi57/5dYnh0Bqo82efq1gS4kaMz0ns9KFhwv3YNW4f+vPWqerH68JfH0/IU/7l0vCUVYejEhjAoLZVaiXDrqnrrpfcY6SDYPKp2mRmkjyrqI/bbholRU1dZNY/JFJb9/RW4nzns2bPrDKWcy4BCFLmkLE6uMwBa8d7SWePl8365r9elIzuk5VG1xFOzhrM0XLXNJkCrMTkPtZsZ1hiwwAiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2IyQ4vSKlxarRe3pQF73VFmc7A99AzPV7bW9+sTKKY=;
 b=fUKjObzW+r7CbPt3P6fwAYbEZ+J0//dkR8XYBlxJi9kJPQZugpfHKJWb4XvVwhWvxoruWfweWMwszzUwWIZjpK+bw0ZUFsDVY/dx7vIOX0v6bmDlXuLnVpdSIEL+LS/Ran9pM9TjfsY8HgfiC1bjV3vsd/5cZHvTclPmpqc0I4vNM1IrWcf7s/yyC5AlNtDqUr7QGsCbhBy/0StFyp/RdV08KLRX6l9bYJZUysXvrAiyWfrRFdMH/QzleZ2u3RFivwLZutb8nt2TGik82GTaku6LywYDG52z77xWx2BC99BuXb8UZrck5So/yE3b0mHsjrklDCE49wXpebMr2AlO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2IyQ4vSKlxarRe3pQF73VFmc7A99AzPV7bW9+sTKKY=;
 b=iLncvtzNHQ2HhkajhjSpT/Dljza94IPv+2oU3Qam+dVtENs9QmEYclU4pJoGO1bFL/y3f8IW0o5T2yY3yAZBHuImmWWXkqhGVnMlHy/XAQpFiBglWHgcNMUuVRGMJpz9dScE2JRAHywoKiXZ3KthRPIMVXo0m2l36BuiNTC/VvZ5f7sIC+rRR8T1/XIeMX0fD3bSpe/KJZezUko1jtkF7px5wls2GEhvZMkP38PwNzYpp4mknjCboshxpb14f8dQ49o3rGprkzkz1LKAoYiTnn0cDtIm80FSi948VfZNAr6QCre3snR1jhZYNB9QKBtsYQ+pYAM4io2mdZilicqWJw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 by MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 07:04:25 +0000
Received: from CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128]) by CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 07:04:24 +0000
Date: Thu, 29 Oct 2026 18:04:19 +1100
From: Balbir Singh <balbirs@nvidia.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Salvatore Dipietro <dipiets@amazon.it>,
	Christoph Hellwig <hch@lst.de>, Dave Chinner <dgc@kernel.org>,
	Matt Fleming <matt@readmodwrite.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: page_alloc: remove ALLOC_NON_BLOCK from
 ALLOC_RESERVES
Message-ID: <auLv88bDy-oZKIC4@parvat>
References: <20261028171719.2043421-1-hannes@cmpxchg.org>
 <20261028171719.2043421-3-hannes@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028171719.2043421-3-hannes@cmpxchg.org>
X-ClientProxiedBy: MEWP282CA0078.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1e1::6) To CH3PR12MB9730.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH3PR12MB9730:EE_|MW4PR12MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e357f15-cf69-4e42-fda7-08df358add7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|11063799006|4143699003|56012099006|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8pomeT5go6XFDJCcU3UxzkJ0BJ+VWT3BRVe6QVStuieAj8E9ErUoS2dJ4KIWKBbQijDZlcI+0LTw+ObeMfvhWeUcQ8RRCvEzmf7DF3vVkt6ThLX3oE6Rqm1YjiBq2+R2/gVmHtQfTsm0Mnu080bJ87bY/CM+c6MSNUElUCK57jxPnpc8oTjiPafRYoEeeP+JRrKf5wsthMuNUnGYRtA1aOhMgosiLWiGhRxrHMlC5HQY0h83SaEQuB/MZq3kV9IXI8phnIVsXzDlTndtjrcWjVo7oKqAm3PNAzUTPOPSvF23WU0Gr4i5PlXITAI3uMdFPJPDhxgMK4U1khuXuuSDXVygk/zqI5OJ/q3A5mriHc1xcorKbi8Q7dtZmP3ZRaCJVfe3BByibDByYHzQx5ul0QjlsIE+TqKIRTzvU90wdz+FH8sMIDKYCnP5GSU4+sa//a2UxfLIanT8r0TmQVPTaFL3qlU3TsMOuIlv/eSrWj41hNnW3oDMvixFWrgao/3Tr4YwdT+gHao8NqDCtR0dFwDHhLaVtD1Eg4Fo/Glhs2Zs8hvXKpyT5o6mjESOPNxQ8jTE7zKmYovkGlr9kqA8WhQt75XD8fHIaDeSiVOZHydAG5FXS3Rg1Pigcms2UZZsxhA4ioFliYu1lye7w9gNFrfDcQMp//jFVlcf4szIUpQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(11063799006)(4143699003)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AKBXixoZOQRfKumPOkCfunaMxMFfa8mnUP3duF1W0U5IMPcFblj4b7KGxTP2?=
 =?us-ascii?Q?zk8vj3saO7rzBcbNJnLbyjqANpH3zZJqBzVq8DJDcYERPpxklWhp3bp9Hq/C?=
 =?us-ascii?Q?FsHG39iSDx3kzzC+Z7Au1k4cbWIlN4KgrxKTX/yJmOiJ3nWAdjlNe2XzHq2s?=
 =?us-ascii?Q?pfRMw8PmtDOLyTfmA6C48/X9jZ+cywUDe+UnmYEjauhWewpikyTWeySEoqz4?=
 =?us-ascii?Q?e4/zjOnwTBTEBZvFKJsW2epch/VZNI+vEjPqayqHUE7Qg0U4/HQ4evG0fKEQ?=
 =?us-ascii?Q?8w73edbqz1wS+7ufk50O+EDdFWTkBKaFYhDNBYb+GiSsvbe09GpFTLKqvO6e?=
 =?us-ascii?Q?yKUZpUJT0i0NxyrAqo1fgxh8gwAtvt7f4kGsNWOqPPk4ZrCwBOD37GPRa3kk?=
 =?us-ascii?Q?cMMiZy2hzE6m9v1BYBgT2tuJcxr7v2fVw2rBT/nyPZ564KQEHBfvlCBIGW5W?=
 =?us-ascii?Q?blXyNTe9b7F5kJwd2rie75eXc1eNVx9ime8KwefWb28LkXSARCrWj6KIWxCS?=
 =?us-ascii?Q?SSq+n09VhHlDOAFaZ3SqiA7w059LkH4p1/jol6TdSjHWCx+xYO22p4IoowzB?=
 =?us-ascii?Q?i6v3Km2IM1T7ImCHjqq9SZpDgYGaVnn6HoNX2+NHJX4vIsrm0unPxOpC42R3?=
 =?us-ascii?Q?2SphYtrTADYaXQ/KeJ9rIbbLW3qtvT1IZcp0HT0NXP9NNiJG3mDAdH/yaGb/?=
 =?us-ascii?Q?z5ZWmXWu9+Dwj7FvtKXWr1G4rlJYQSDFtXHPS642NZZhtzwrwdCMxwRsvtRf?=
 =?us-ascii?Q?sNOpcrP3jAAczvzZqvsZDSICQz5cXyURswxRI3IQq2JFIvEZk78tO8/k7I9m?=
 =?us-ascii?Q?OHcb0C9Hd/lyZutR1zSYGuAnil8RtOK3Jh4rPIgNzjzOm16Zwg4NtbHpekUe?=
 =?us-ascii?Q?Y2CfjiCsUuOp+zTqwa4tZzFS9ID+C5zXP53k2SXstrfO8h1hmoRgrL61WrjC?=
 =?us-ascii?Q?7H9TW0XZmbpKUIEG1gBTWuVfuQaD0JmLiK4ngI6gCgM43UFAZhX+JdGUm2XK?=
 =?us-ascii?Q?Ix8jAkMAf75llwGUMLFVuQw6cPtDQ8MqGgZ9q+zCbr/rEld5U2RHhwoAcruD?=
 =?us-ascii?Q?2VsTX4l6JUdt/gRQufJJEwmZBp/u3OjHW9lG9OnTj0LDtOdlHvxq3FPsJ4U3?=
 =?us-ascii?Q?OD0jZA2gklslj2N1D0BZ/Rb3w6IkIekyFRfTo908GpOCbeA0i0U1/1qq+r4t?=
 =?us-ascii?Q?+r62nquowwIYuYlKXpblvEebGh89/Kz9M572Ko8MrwUiF98mdheNe05c1fSW?=
 =?us-ascii?Q?BQWnoO2gWljuHVUX4DZ9ojdgBXrh8pGUeZffrUl1OhnRy7ceW63cyZpJKXKI?=
 =?us-ascii?Q?5gvo632MsgoTjZA3IzlfYqnymE1kFrSym1Vs8+x4Ajg6CVFB4chABqcTP3TC?=
 =?us-ascii?Q?nyHASoE0Y53TUDXeDKU25XtI1rzTg3y/nBHeo+n/6aoUibO5+k/uq/8ylK+i?=
 =?us-ascii?Q?XjxIskUrOMyTzDt4P+jMtt2ww+ZY3J6jHvnFo9qpqkNgE5i9SJoNVQKpuYat?=
 =?us-ascii?Q?LlsXK+FyvwMLQx18NnSwMPnfaSc3sDPvi1TwEDwzEtrFvyXIt+IJ9q7vkiry?=
 =?us-ascii?Q?GdjFPPpVRinjQh68OSS6v6S2rqQj3dhDa4KvQv9Gny7n1Am/d2RSrc0Fc+us?=
 =?us-ascii?Q?VFLISXiVkyPiP68PlUcU1JD6A2oy6m6WD4QzzbzUdaFMZVV527f7q+4623DO?=
 =?us-ascii?Q?nWBeDQKfkHASEdwzVLImsO7IA/cC0eGjVy6yUvDOqaIz/aTDigBjHjRteElT?=
 =?us-ascii?Q?ldawenNZHA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e357f15-cf69-4e42-fda7-08df358add7e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 07:04:24.8517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dvftoidpd09FCLvm9olsy/Xop3WKzxIMiCP3ZSkwBvJrT/r1wd/IZdY69qcpLvO5vha+wHJHxmFgIno/B76tew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309

On Wed, Oct 28, 2026 at 01:15:54PM -0400, Johannes Weiner wrote:
> 1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH
> non-blocking allocations accesses reserves") stopped handing out
> reserve access for ALLOC_NON_BLOCK on its own: the extra 25% below the
> min watermark is now only granted on top of ALLOC_MIN_RESERVE. But the
> flag was left in ALLOC_RESERVES, which produces something odd:
> 
> With the ALLOC_RESERVES match, __zone_watermark_unusable_free() doesn't
> subtract the free highatomic pages for them. So in the slowpath, they
> get to consume regular blocks below the min watermark by the number of
> free highatomic pages. The highatomic reserve is capped at 1% of the
> zone, which on any decently sized machine is a multiple of the min
> watermark: GFP_NOWAIT can drain regular memory to zero.
> 
> The user-visible result is brutal hiccups during bursts of GFP_NOWAIT
> allocations under memory pressure. This was found in review and
> reproduced with a synthetic burst, not observed in production, but the
> sequence of events is a realistic one: On a 32G box with an anonymous
> working set, swap, and a filled 290M highatomic reserve, a GFP_NOWAIT
> burst drove regular free memory in the 28G Normal zone (min=60M) to
> 28M, 0.8M and 0.6M in three runs. Swapout failed to allocate its swap
> table, reclaim scanned 13M pages to reclaim 200k, page faults stalled
> for tens to hundreds of milliseconds. The machine survives it, but not
> by design: direct reclaimers eventually fail and start unreserving
> highatomic blocks, until the allocation succeeds or the reserve is
> gone and the OOM killer runs. That reserve exists for high-order
> atomic allocations; here it is destroyed to bail out a GFP_NOWAIT
> consumer that was never entitled to the memory.
> 
> Remove ALLOC_NON_BLOCK from ALLOC_RESERVES. With that, the GFP_NOWAIT
> burst is stopped short at the min watermark. No direct reclaim, no
> stalls, no failed allocations, and the highatomic reserve stays intact
> for the requests it exists for.
> 
> __zone_watermark_ok() is unaffected, since everything it keys on
> ALLOC_NON_BLOCK is already nested under ALLOC_MIN_RESERVE. Update the
> flag comments accordingly: ALLOC_NON_BLOCK just means the caller can't
> block; the reserve math belongs with ALLOC_MIN_RESERVE.
> 
> GFP_ATOMIC order-0 requests have a milder version of the same problem.
> Through ALLOC_MIN_RESERVE they also count the free highatomic pages in
> their watermark check, but rmqueue_buddy() serves them regular pages
> first and only falls back to the reserve once those are gone. They can
> still push regular free memory to 37.5% of min minus the free
> highatomic pages before the reserve is touched. Unlike GFP_NOWAIT they
> are entitled to the reserve, so this needs the watermark check and the
> freelist order reworked together, and is left to a separate patch.
> 
> Fixes: 1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH non-blocking allocations accesses reserves")
> Cc: stable@vger.kernel.org
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/page_alloc.h | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_alloc.h b/mm/page_alloc.h
> index 9c3c2830acb0..7097ea1805f6 100644
> --- a/mm/page_alloc.h
> +++ b/mm/page_alloc.h
> @@ -32,12 +32,11 @@
>  #define ALLOC_OOM		ALLOC_NO_WATERMARKS
>  #endif
>  
> -#define ALLOC_NON_BLOCK		 0x10 /* Caller cannot block. Allow access
> -				       * to 25% of the min watermark or
> -				       * 62.5% if __GFP_HIGH is set.
> -				       */
> +#define ALLOC_NON_BLOCK		 0x10 /* Caller cannot block. */
>  #define ALLOC_MIN_RESERVE	 0x20 /* __GFP_HIGH set. Allow access to 50%
> -				       * of the min watermark.
> +				       * of the min watermark, or 62.5% if
> +				       * the caller cannot block either
> +				       * (ALLOC_NON_BLOCK).
>  				       */
>  #define ALLOC_CPUSET		 0x40 /* check for correct cpuset */
>  #define ALLOC_CMA		 0x80 /* allow allocations from CMA areas */
> @@ -58,7 +57,7 @@
>  #define ALLOC_NO_CODETAG       0x1000
>  
>  /* Flags that allow allocations below the min watermark. */
> -#define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
> +#define ALLOC_RESERVES (ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
>  
>  /* Flags that mean GFP_ATOMIC */
>  #define ALLOC_MASK_ATOMIC (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE)
>

Acked-by: Balbir Singh <balbirs@nvidia.com>


