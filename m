Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795126245;
	b=mjj0gtJ/+pCT/ehhqfueKH60RPxsIMZuN/+25BCyaZm/NiUplOPYprdMyKpDlSkyv+3L
	 X53KEFAO6dxZihnfBjzFhSUBl3GE7SZvhq5rb2T4vPeM2kcKJG/luAVV95DmZf3aMJQTx
	 VcFaPKH1xXojSkzgA40QV2bARVuixgRDysQvUY+IEFrfY1gK+3BIX3N7agtD+sKbVPnZp
	 VW991rZHvAs3aJKLcxm5OAYkRnODgwNmNMxBgAG70MR8NxyaiwkgTdkHBvjgw6Yh2zxxt
	 Cc1OgBDTHphcf2M6fciSHsZgz1kwHvyFsziYfjyafIE/dCOTOvuU1cilqgVDy1gW3JQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126245;
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
	bh=Q16wtGOavbPIAGC4+aWBnZ2UkK/yRQBQbfQX15aLa8c=;
	b=SnT3Bbei5vHzuMll4vSy+QEpeA+KnK3bkKxmMdDHOUzbIxJ9BVFd/bFK4ylm9jvKlCHo
	 +ini3U2Ed9yvrdU8ro7OpNSSzylW11xDALiR60PuIkCCWj6MmbeOZkgc2+At0wvzoSkX/
	 Icq95HejxXTIYHmlvsZ084h7y0FaF1MNKTVtySZVaPmkyQJ+oCoNEgfshBckpe15DbmoK
	 tUNRyfciIlQ1uPY6+oQ8gS7cx8A9a+bBJ3mXnFyw7Kt7B4TD4JMOebSUp9rKkXSXFyb+N
	 qx9HKYHq1rZaPM2zxLmKye/Jihgmm9zSfeT1lJdM325jPCUK9pe33fKNGclOQml1ZBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dtutlTMB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.47
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6DF606A337;
	Thu, 19 Nov 2026 22:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D6DF606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dtutlTMB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLnH52jX3nro6rFJAa0KjS5VZCjmt1Bf+bhj/q9Y5OY8tA4A5Uv27F4ivTfu72X8zzZMBPjD7vChu6Y+zmwU7+Lr5U3KgfiggPgD9fbCfztOwUssLNuxk4wUu4HhhAyunPbF+jidX+2U639+Hfg4X/KYqyLTUjlJgydYuXouunVa3/U85RA1QF7rEf9/1J5UwNDSfQmFaHFh06YtyRgf3F5tutnacSkMnXXotrxsrsNTOMmCqnrhXIo9twFTFZYflK1gcHbL4pJ6P+6icW9y/5/WddP/LH2zvS0oakYlEEERxM1DzbEklmtREuoGdNsIaxKTVuPduqUuy5b4D8vojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q16wtGOavbPIAGC4+aWBnZ2UkK/yRQBQbfQX15aLa8c=;
 b=cSJFbR/aZv2gbL7qiBesUFMV4Isk9GrcEsoO6W6LM787GiKYgNFb0fXemsq4Xpaq+NJunZFFvV6kNbFc4ynJ6LPTm8oA4Lqy0VGtCHrBVk5RIMh2Wu1tWI82IzYAnMcdQXhw5NjkRPewtc7X7nlh/kjve3ZhVoHHqIlUcLkoxp2f8RJglq7LfytW/VMmiEwZZquS5LG+NmmhgttlFCXivQzV671tHxSzxDsifpZCAO51VB3zxsNKL5eQXGePZmugI/8NmJenE856avNEeuHF2cksTGCZ6B7eYP32cD+r2FJdL38dKO+wycEUBDJMq2kwN61tYoID+Yz5a476xTThog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q16wtGOavbPIAGC4+aWBnZ2UkK/yRQBQbfQX15aLa8c=;
 b=dtutlTMB4ZJ8aD135i3v7Vwv4pnBDNNTlLIAi2ayYhd8HbmvTzFRQajASChiP2OeFh/FrQ2/YbsUy4wbH0bcziuPTrI4V4bBN3NWv8hxCoumTlup1+T++UmD1Vc3jz+Nn7BncPHGkDkvne3ps3Qrscd0wQe+9NfFuejXjpe/T8dJ58QLV6uHS9tZ1cDpnOCObnzutoFhxPZwRtWfrTJW/96d6JEuoxao9WM4NLX+NaxP5hc/jHCSYkIUTL+X9gtAwa9fvfRkpi2r0TKYJ5BasR4DIMNIlU5iNYFz8S2YaX3GFQ2zb660Sf9KUMpdPLy6lbWtwlriw+zKILy5YL+dpQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 22:10:35 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0615.009; Thu, 19 Nov 2026
 22:10:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 =?utf-8?q?Cenk_Y=C4=B1lmaz?= <cenk@deepfinresearch.com>,
 Zhang Peng <zippermonkey@icloud.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
 Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
 Mel Gorman <mgorman@suse.de>, Sasha Levin <sasha.levin@oracle.com>,
 Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/4] RFC: mm/rmap: don't defer TLB flushes when unmapping
 lazyfree folios
Date: Thu, 19 Nov 2026 17:10:32 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <884244A6-9EBE-4579-A6D9-D510FEBD1D34@nvidia.com>
In-Reply-To: <20261118-file_folio_flush-v1-3-e9e739ed14e0@kernel.org>
References: <20261118-file_folio_flush-v1-0-e9e739ed14e0@kernel.org>
 <20261118-file_folio_flush-v1-3-e9e739ed14e0@kernel.org>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: IA1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::17) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: 037af25c-feb3-474c-017d-08df4689ef97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|18002099003|22082099003|6133799003|56012099006|4143699003|261102123227099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261028144727099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	G1FdHXWqlLyi4FYvG60g3rpTXWX4JJ4VHllz4XGGN2u9RAlRt9btNsuTSmun+4ZUHX9YcfGlDwCucHuG51Gj9fQvLSlkybcBhJvoI1AJA4lyAa3WzwdkxsbjMyxGw/pLEcGcfWtsGvFU8peinhslh+xd+EIY7q+56/5R/VJtPsZi/jdEbnOyG2OfBg/QQazDlWMnbhCeDVz8nLoQKOU9HfyjmzcuierXJ29uTVZrrGwJKoSie2mBjYzRbbNhC9IuhKm6UGaRyi5+TEegGA/e+jR6oS3dINgM6mA/yyXJ3dL/3f1qfNRqs89QhIPaLEalQ+3L+ogqq1fplGlva95otKQ/WBOL3AWi/R7gUSVP48UHsrqTfsKQGCGOVdOWZXoqjPBIDDIJJ+dgWKitVBYgEr9PHDV1qwSeRZRPJPuE+VddYaUPbswcJNETqzJ9wuQxTxFy+I71eK1ZO5hDA506rX1g2ArDxk3gFwuO4wqSGqm/CroqTEDayBMNihr9/U7fvm1MjpaISoG5zXBRR0/ho8pHxXYxn+rHcX6t5wP95EmzytkblIvqprHTqsDQbcKd7Q+Nn0zrwqqsd0vn8CTK4l4b3YByf2yvhjZwVQu66K6JGzMbACViQYfxLpSl3CqzO4S3p/j0/98XrauPFQHcBS9tVpkODAcWt/M6CDj7mVU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(4143699003)(261102123227099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261028144727099003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7+idSxc/61vft/GOQJ4C78NFrErV82La3JQoHRf+1zSatpM4ioBJBuW3Cxsi?=
 =?us-ascii?Q?eA6sSZ8ubNi1TmUaRT8ovre1G9ixqrmrv6mDwA4e0ZOHvBNbSqNQ7BIMOzyt?=
 =?us-ascii?Q?avOhrXSpBYnXCm0RNOfKzyxTOB6G06k4QvFDFdJSBnJnNiCTscp9dzCQfq1T?=
 =?us-ascii?Q?pQu+lujx6ksWYi6tFcbUdokSefQLzh9qV0j2xoK+zOU3QTHT8Bc6ha8cUxmj?=
 =?us-ascii?Q?4257BcY1hgfidKZKUYcsBQew4xvgtJMEyCeqBU+Y8fhid33QhSjY/J7z5x2g?=
 =?us-ascii?Q?5ADQBIA79DJgro9tLDE9H1nrWcynMAtCjYO8OgPWlIhs19AcLFEdFOjgjLsz?=
 =?us-ascii?Q?xsCamZf3V2vi3dSxVIPGjBBUGl4g+3zpCdGgwUvYfDPPrwaE8nouDT3iqe2q?=
 =?us-ascii?Q?bAlBwNgqdpEHJt3V8p+NArNz0bfjIk0Dp5kN8dQbkzHAtWiUPFC88XiGAC+U?=
 =?us-ascii?Q?wmAbe+KFJXw2ZedquFhwHlrfy0FCxDHEZZKzj1T1t0w+KYhSeUEeuBtUh+Co?=
 =?us-ascii?Q?3wfLijb/68lzCWpbQ1qkUgQ+xFwD1WTz52kBGHkmeHb77afa4iv7cKPUR0jk?=
 =?us-ascii?Q?+gNcIQ/6hHIarq69VKYe/NFLUYkDQpescLCK+s4C2o12LH0MmZtyKj8ql3cJ?=
 =?us-ascii?Q?kfm7pZ7IlLLxUHRU4aZOirA7iIG46ZW+rN9UCn71UOebCT15NtjyMFpzJS2V?=
 =?us-ascii?Q?ccJs6m2cVzvBuX9s1Pwc4SR4h+loqHq5tw1KwFPsJ7/pR61EfJTXawF+fWsZ?=
 =?us-ascii?Q?XQKnpXjRR8DomrVIuMHF8Waw3swkjNGOmuPacMgdTnv1ATzCnkH915HUy077?=
 =?us-ascii?Q?oNNNkXFJvy7vEjXU8TpuLPf+GDNd5Qvto9OnctlRfQbsLX7ET6yL/NMKTj5F?=
 =?us-ascii?Q?SfvDDy/ZItpY6MEjOVReJvjpTY1qZ/wVnGYDe+ogtQX0EjMyZoL+41tx3Hor?=
 =?us-ascii?Q?sMVsXiaQATGWDj37j6m68ZUaYUFgsq6G5JhGJSGfP8tExeuEYsXhXgrfHe08?=
 =?us-ascii?Q?xQhxhHwCSasb+nxFesYs4dT3siyG0QFr/uCjSbjQXrkdmmjb710nUXI9C0Wc?=
 =?us-ascii?Q?/9U1WS9xcaChoSX9EEjF+uXc0K2zuAEWsxKm/FfbdbejcRnflimrsjSXrnGO?=
 =?us-ascii?Q?2fG3wxRF7rCbrbBjAcLmF7fEROFQ7/q1Ueym+izGsEXS0Q67tlJttGW2HQSv?=
 =?us-ascii?Q?k3cdiypV/inkZIPGh56wWkzp87CUdjaksR+e5ayP7RiEfugoPPHLLEnFUObM?=
 =?us-ascii?Q?zPy5S4Q72AKXCL7VWNa2+zHLos/A4j7Rio56oIA0UXu1Q1fgELjiLH+5VFDd?=
 =?us-ascii?Q?NoWfc/tem/049Q6Eed99J8uFiWicEMWtgdrRP1u7GvO2mEP3evX6Y9UjyEaD?=
 =?us-ascii?Q?u3iVlB5wFdIYk/4wyI0LGZNkY3bo1SmAZGyqFWEHbyIWQRlSJSNbSMGEdTu8?=
 =?us-ascii?Q?y6R1DsGksTnrhabaYml0whG9Nm2OlQdLCzTfe0PSGSRAVCTAgPEPAQOLnTDH?=
 =?us-ascii?Q?Nm+4ao9Fj5zEt5oWlMyR7dwp+1QZ/ZF2WpJCgsjHMcIEiIZoswnzkqgNceLb?=
 =?us-ascii?Q?HNurI+UbimhLx7dNtXxH/B1BBVvkUzXuYGyyzhtW2EPXRzD7Eek0G81Zfsxi?=
 =?us-ascii?Q?ianyXWTLsvTZH4okegro4HdlzgSHMXPTsJ8IYJEwr3Oov9hDjjbuz6ZctbSx?=
 =?us-ascii?Q?+7XghciWa7pMA2/A1/XhVmIwTtivJXSqMCUDVkQAYlNnaIBZoRlGZz8s9o0K?=
 =?us-ascii?Q?/7PDT0yv4Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037af25c-feb3-474c-017d-08df4689ef97
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 22:10:35.5189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zr6TmxHwDukSJmwZycik7NLvbOEWYELPChdXadAZcnHyTCp3Q+29xkFRURrWwosH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509

On 18 Nov 2026, at 4:20, David Hildenbrand (Arm) wrote:

> When reclaim discards a lazyfree folio, it clears the PTE but delays the
> TLB flush. Until flushed, mapping a new folio into the now-none PTE
> can leave some CPUs still reading from the old folio while others
> already write to the new folio.
>
> This is hard to trigger in practice and would mostly look like a weird
> use-after-free bug in an allocator that uses MADV_FREE, but it can be
> reproduced reliably with three threads pinned to different CPUs:
>
> (1) Thread A populates the pages, MADV_FREE's them and then
>     MADV_PAGEOUT's them.
> (2) Thread B reads all pages to keep TLB entries cached and verifies the
>     content of pages published by thread C.
> (3) Thread C waits until mincore() indicates that a page is no longer
>     present, writes a new value to it, and publishes it to thread B.
>
> Thread B can then read the old value after the new folio was mapped and
> the content updated.
>
> One way to handle it would be adding conditional flushes to
> do_anonymous_page(), migrate_vma_insert_page(), UFFDIO_COPY and
> UFFDIO_MOVE ... essentially anywhere we install new anonymous folios,
> which would mean that these places flush quite frequently on concurrent
> reclaim.
>
> To perform targeted flushes, we'd have to keep some PTE markers behind,
> which is also rather nasty and not an easy fix.

Maybe that is the long term solution. We basically overloads p*d_none()
with multiple meanings.

>
> So let's not defer the TLB flush for lazyfree folios, which includes
> folios in VM_DROPPABLE mappings.
>
> To avoid flushing if the folio was redirtied or has additional
> references, perform all non-deferred TLB flushes only once we know that
> we won't restore the PTEs, right before removing the rmap.
>
> The downside is that we no longer batch TLB flushes when discarding
> lazyfree folios, which harms performance, but is the right thing to do
> for now.
>
> Fixes: 854e9ed09ded ("mm: support madvise(MADV_FREE)")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/rmap.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
Anyway,

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
