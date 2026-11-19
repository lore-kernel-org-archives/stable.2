Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795107858;
	b=zyWpG8F5mQY1UCuZOn/fyvzLHNe5cjrliJp8vp3s1S054ElCLu08S4kW9PsWgfQFtHaI
	 mK6Fpw0+d8QG69+SsqxzhEhRrCeALzu6XVEp3YpqxgRTf4OLAINS6BKrYFDCdBipkzLMZ
	 8Z/W1Xmr6JalyVdrUqDsvAzC+DvSSL1TZq9RXBqiSihX3G1rozTOQgtIrvq7n41bjJwOC
	 1GC79+YbmSFsTULTcraOwc5F1nSl2owqYv3xZ/jM5PVSUNn3oULvjJdMbLX+d2RypgIsC
	 gILA7vSsg4MUhuA3f9cuyXV0hy0wlK5+CFtKloSGuyboZYFvSQp/rOZgPjQ9TVU92fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107858;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:X-Mailer:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-MS-Reactions:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=VDeAFAcJCA1EX1H0ZzF/45lpRqhjW15oKF3EGMs1RMQ=;
	b=wfievrFb52LndbHRepX1eKvxV/TlPAySfxvGHWzTmoId1sai1Z3VKzSx2sPVJcangIRM
	 rGhqeSM+jWy5TFuMAiQnrJZHIB5qTKJ/opZBi6jMtPF9RcW/brPfuhSeIjc+XsAH4Txzh
	 Ve14NO1u35OO4BykFbalgnyVxDsJEhIRQol3tc5yb5R0ALUZNPB8uhXg/uISnYQbkiTu3
	 4sC9kB6IOyQcS8+Dj0MLPTXOrN7+81sWAAetpKiUSnsFfbRN4WUvmsDeA9OOI7UA8hBuq
	 qV3r7oVgYMfGAeW7rVX+dX5aMRS5ehnJM0n0TlRzgFAn/Hi3otZkzGWobUfToRJj0VA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=B4dg8CJN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.25
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53E6606A32F;
	Thu, 19 Nov 2026 17:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B53E6606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=B4dg8CJN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqJVqP6Wog/rIsuPUkQ6V2fQaFrBcOslbUXS+U5fgbaUjA8ktCfuNScovlF0HA3tNhmfTapNawuYjFLq4LigBUKjOfM1ExGmdGPEiaunWbOWSFroEQ41URlH40PNZXZhY3xXL7ZCBLN8tx/ksLRpXX1fH4XRsv6lRx/RCFrRQouhJSmxSVIhCnpJlbSgsqD52LZXKnSyxPL/1AH6u6RhRXnbRiQFe0sVj/Igl1Xok4oy2ysswbly7eebJbGdQOeoTWlSv+PRxdjCZBzCaG8seiBOxn6w7I7rqCuqP9MbhvqkuHM7DjAebeAce/YInz8D/AcVxRzM706Mj0PloGrv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDeAFAcJCA1EX1H0ZzF/45lpRqhjW15oKF3EGMs1RMQ=;
 b=OWxfTzCWacE7xXABN578PbmZ1An5RldLCVYsPtd3QXy+qeVvk9HP73u8xQiGOJcqYoz38dNFAIy883puMydNxjkQi+4MSAfbSY6U7fYq1zzBMT+fS789mSCWsrIqCtVEf9BTaROOiSa8kw2EsoJ+pKgnDDX8+BFHkC0rfR0a/vAP/wJ2MVb5YazaZ+hGyDkiflQhnKrk8D970OXOBMbEGr3qWb3ERD6Uv2OhHXRa+BjYXFAX1yZbUQgvlhy1xTUgLurzGF9xAQ4y2stKiVw4u0RF4dS3Wt0FJrTgoZUF+KU4x6mKGFZmk4ePzfhsSxGCDhspo87fzipsA+paWyAyJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDeAFAcJCA1EX1H0ZzF/45lpRqhjW15oKF3EGMs1RMQ=;
 b=B4dg8CJNmhjWcfLeELCrpEyWKE2E+WnZQnfdcMjdFbnk8boaRjoM/3LZi63SgbX4Wisi1nFtS96LT1RXm5l2AysdserAP6HaXroBf4tU8ZG4YvD75/tLe7tL2xkQss6F0pFcJYP7sLzYxUzMzNwOYHRvYddvew/2LLiqRxLpUErLd0gyetHAIXIX33GJKKhc6yrquna7wdKp7hPL1GYnoU7pgJVZ2ZOSAU+n+ZNY48pivXHZGrF3UrIN3sdkBzVFalTt/uP4j97VadnMZOWQocH528HZNH7vzaSJ7Rd70V9Lg4og7zI6daxfPFpJJdiC5JJ3k4msdMizqon2g/1EEw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 17:04:12 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0615.009; Thu, 19 Nov 2026
 17:04:12 +0000
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
Subject: Re: [PATCH 1/4] mm: flush stale TLB entries before installing a
 CoW'ed folio
Date: Thu, 19 Nov 2026 12:04:07 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <FBB72DA3-74B8-468B-9857-4397C18D4F38@nvidia.com>
In-Reply-To: <98be89bc-1394-406b-8723-0032a7b57ad1@kernel.org>
References: <20261118-file_folio_flush-v1-0-e9e739ed14e0@kernel.org>
 <20261118-file_folio_flush-v1-1-e9e739ed14e0@kernel.org>
 <22DF2F1E-2692-48AC-AEE5-79B61947D86D@nvidia.com>
 <98be89bc-1394-406b-8723-0032a7b57ad1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MS-Reactions: disallow
X-ClientProxiedBy: CH0PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:610:32::32) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CY3PR12MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: bc520a1f-b662-4eb0-11be-08df465f2206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|261102123227099003|261026140227099003|261026121527099003|261028144727099003|11063799006|261022115727099003|261021121427099003|261021123027099003|261022105027099003|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AhF1pYP+JFrLYwtExjXDZDZMvySwwEBRJsUzxLQJA95JzZtyxoiW06Il7lm/s/T4iUxJ9e8OPclIb6QUdQfaKmXlf7yKS3YgtO0BbJqBe2/irFLufZf3aPFIgCClUQu3NEJhugDJwfBMkmTHOVAUvJ0DoECgWUDmKB1QkQ43cC43+Mfshe/R9LiVGtOhgnbtkOue0J0fvciTb7TuEas5zujtBAoR2j8vJDOaEsjhNDuT8hCU5okrYidMC0acwJs0W9C6OmN9PFZ+/Wt+1MfF1l0vh0GmnUli1iEKVvwoWbuqOS3UvMwkPPX77bOXBaENR2goBoZoPpldAMW1/bs7GoQoWxwUn7q0TZ2s+XcJ+xSZzpc2OJEasRGohoumZG8aduE4Y12rBNZ9ncyNzRNkEYztyl2SkOkpUPUfd8Fb5/tPe/GS4adlHBHlXOxPsJfKDNoD3eTkXmHr0LTG6Vv6A3gyktvE5VKysHC8yZMDZ6TKnf4aO76+YjoVKvv9jH7Hsn2f3kN3PYEb6kPXF2Ucol7XNq7lLnB+A1Ixe0JN2iK9aaQh1EfVujvNT4o5Dtj1ul05wp+YptXwG87uHAuME5j263dmo5ffeMqFOH7JtrT/5SuVObCjdz/t+3Jxp1OYDGbpaktNoBTcDO6iLHpUTKIuHddA6X2TJ4sF7rvZ7Qg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(261022115727099003)(261021121427099003)(261021123027099003)(261022105027099003)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1cyU2ovSS94ejZibDNNWWtCNU5UekZHSnlEZFR3dGNwNm9KS1BOUUFBWFFX?=
 =?utf-8?B?SGsrN2VYeTBlRnRCSE96bldFQnArMjZ4aVlVT0RLMUt4T3VjSmNFc0txZG0x?=
 =?utf-8?B?bkpjMFM3Sm4wS1NGNWdSWlVESUVSRGFra2svSng4dlJPd3IzRXlUR0dSMjlp?=
 =?utf-8?B?RGlaWUdxNmNIaldaQWQyeWlBdUxWRGNuK2tXK2llYnFqTGpKb0NPOGJ5MUUy?=
 =?utf-8?B?cWdxcld5WHVaL1E4aW1kczkrUDJSa3RnWmhYWFNCNWdCaEpJTXcwUlp5TXFE?=
 =?utf-8?B?cUVvcGh5b3MxMG1zL0lSSDVFS29EMFRZYlAwcmt6b0JZZzJFMGpHOGVISUVY?=
 =?utf-8?B?dWVDMGF6ajRVNURkaVM0RVpnckp6d3dENHZINTNYNTB2SU41a0Q4d0dMczRi?=
 =?utf-8?B?ckFUeU4vQ21PY2tPckJCMjBKT29xdS9kbXZCM0pxWEdVdHFQQzJrV1NqdkFa?=
 =?utf-8?B?azJvRk1GRVR5c2ZxQ1NiZjN3MHNMRmVDdDQydWRyeEhzc2xMMDZiOHgzUkMx?=
 =?utf-8?B?ZDRPbVVqTUJEYUIvelhvbHhEVjRQL3ppZDR0SWxHQ3QyN21JRW5QcHVTUUhO?=
 =?utf-8?B?NHVObUJLSksyRm5TcnBxSE5QNFJvKzl6bktZQ0xONnF5VE9uSlVEc2grVHdB?=
 =?utf-8?B?VHIyM2JzWmxudnE3TFM4ekZLQXMxUWRwZ3N1dlBXcndMdjhnUjh4clcvN255?=
 =?utf-8?B?ZGtnbnlzRGI1M0RUT1U5cHVFTlpGRnRObFVCOXF0UUxDbk5IUUZ0Rm9KcEJP?=
 =?utf-8?B?Z3F2UmQ0NUJrVGcyWG12Zkc0NExuTXBMZlBmenBrME5KaUVmN1lyb3dFNi9p?=
 =?utf-8?B?R1d1M25Qam5OU1JHRDFTMCsxU0hEWDNBMXI2a2l3UGE4VXlzT3Z2MENvMzlj?=
 =?utf-8?B?UUFoMUwxQW1vN1hIT2ZwQW52cUNkOFpqb3NwUHZnUnJZRkdXQXVoUzV4WXBU?=
 =?utf-8?B?ODU2U29qUDRPYWRpOTJWY3MyL2YzSHBscGhFazRnTGtkWHgvOGdvZXdqbTNp?=
 =?utf-8?B?Rmw5NDc1UDhyaXNmam1KV3pabVZDdWlodEJjcmMxdjhnNndZOXREclpVaXl5?=
 =?utf-8?B?Sms0V084Z0cwcnlYQk1iQm5IblRGaTFxVlBNaUQyYWZnMkxuN3o0MndsNGFu?=
 =?utf-8?B?bVlGdTNhMmNvWVJKVHM2UDU2OFFQdHBPSytoR1AwUFVGdDJ0Z0VKSG1md2ly?=
 =?utf-8?B?NkUvNGQ4ZktRamJ0anYveTNnTmxFL25MLzNnWXZZRFB2WlYrVTdydGZpbzN4?=
 =?utf-8?B?cHRBY0YyMU9SaU1TN2ZXSHlQUlAwcHNISW1peDZHaTkra0ludGxBN0tnZzNF?=
 =?utf-8?B?V2JVTlBoQVhpT1RCQ0tzUnBXaFZrQkJ3eWtrS1dMVExvUVY1ME53OGFJN2pI?=
 =?utf-8?B?TkMzRjFabWpmSFJaYjBoVEdYUTFyM21wSERwOUJSdFZlUTI2VlgrTitqT3Fs?=
 =?utf-8?B?dzdxR25hWFRiMHBXMGFpQk1UZmJlL2RxdDZOM0xaWE9jQjhjdnAxcUZTWi8w?=
 =?utf-8?B?SmJBTW5ucW9FQjBna0FJcUdsMzBMSTRRa3k2VzQweFJiMDluUXlPTkZSSmpM?=
 =?utf-8?B?c3k2TDN1UHVKRW03RnpOdnVOVlZ2bEdFNU5zZ09TQVExdDgzdkxTSzdPQWxo?=
 =?utf-8?B?MFE4TnpoSUFpMFhOUTZGVTlPc0hwUE1CS1RHNEl4STNpYkdFeWZNb09vY1RG?=
 =?utf-8?B?Q0RsZWpaRW9jT2cxblN6YWlaUlZacURrc29EalFKL2c0SDgrS0Z6WkFTZXI0?=
 =?utf-8?B?dmFlYTF6aFBDYVZIaGdiTHdORStTNlh0dUZ5dW85Z3B6Rk5ueUVYdnRoaG9z?=
 =?utf-8?B?Zkc0NE9qMXVld2xMVFd4M3EvZVJJNDRXaUI2SmpDRk9WK043eTdVN1FLM21X?=
 =?utf-8?B?VThnRkFpd1N3WHJSeGl6c2N4RTh5S0NCRXJjdlM3eGdab3lsdFJMSzBuT0tC?=
 =?utf-8?B?T0dpcnZtZTRWUURiUGJYVG1rRUxlSXZxTGwzcDJHL3RqSDNCZWRBZWlDZURr?=
 =?utf-8?B?Q1IxWmpWcDh2Q3NadStaalBtcHhHNjFFRUhRblR6Yzl6VlZmOGViZGZHQWM3?=
 =?utf-8?B?b1lBakFHaGNub05SZ1A5ZTFDdEdOaU1xdFovNmcyZUwzUFo3KzlQZHkvK0JJ?=
 =?utf-8?B?d3BNV05rSm5rNGpwQ3B6L1F2clJsR1lselBjMVFEK1h4SnRYRVJIMUljS2NV?=
 =?utf-8?B?WC9XUFdDczdINXV4Zk5CNjFJS3AzZHN5Qlgxcjh1SEJvUlhBa09mN0NqUnhO?=
 =?utf-8?B?YVhEbDZBNEFhN0phMlRnclp6QlBlSDBqd2ZDamxuRFFsRG1zaGtwSjhSU0No?=
 =?utf-8?Q?jEBi/YI9UKRoQDIdVV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc520a1f-b662-4eb0-11be-08df465f2206
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:04:11.9015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kf3eAjwqZUaBktI7VV0qhnzrk5CwR81+m+Hbb3XaPJJDvCedYbTsjFCEun2IMyZ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9630

On 19 Nov 2026, at 11:49, David Hildenbrand (Arm) wrote:

> On 11/19/26 17:47, Zi Yan wrote:
>> On 18 Nov 2026, at 4:20, David Hildenbrand (Arm) wrote:
>>
>>> Zapping PTEs in zap_pte_range() defers the TLB flush until after dropping
>>> the PTL for clean page-cache folios.
>>>
>>> A concurrent write fault in a MAP_PRIVATE mapping can then CoW the
>>> page-cache folio and install a new anon folio without a prior TLB
>>> flush:
>>>
>>> 	CPU0				CPU1
>>> 	LOAD(ADDR)
>>> 	 -> #PF
>>> 	    installs R/O PTE -> A
>>> 					fuse_open()
>>> 					 -> invalidate_inode_pages2()
>>> 					    -> zap_pte_range()
>>> 					       clears R/O PTE
>>> 					       // delayed flush
>>> 	// Other CPUs (incl CPU0) still cache ADDR -> A
>>> 	STORE(ADDR)
>>> 	 -> #PF
>>> 	    do_cow_fault()
>>> 	    copies A to B, installs R/W PTE -> B
>>> 	    // no TLB flush: PTE was none
>>>
>>> CPUs with stale TLB entries will still read from the old folio while writes
>>> go to the new folio, until the TLB is flushed.
>>>
>>> We really must process pending TLB flushes if we are not faulting the
>>> same folio back in.
>>>
>>> Fix it by flushing the TLB before installing an anon (CoW'ed) folio in
>>> set_pte_range() if a TLB flush is pending. Zapping itself stays as fast
>>> as before.
>>>
>>> Other faults are not affected: unmap_mapping_*() users only remove
>>> folios from the page-cache after their own TLB flush, so until then, a
>>> refault maps the same folio again. The exception is a concurrent
>>> invalidation that removes the already-unmapped folio from the
>>> page-cache before the zapper flushed the TLB; that is an unlikely corner
>>> case that we'll not handle for now.
>>>
>>> Note that we don't care about MADV_DONTNEED followed by a new read
>>> fault, as MADV_DONTNEED only guarantees its semantics once the operation
>>> completed. CoW faults will flush the TLB either way.
>>>
>>> For example, imagine that MADV_DONTNEED zaps a page-cache folio and
>>> doesn't flush the TLB (but still holds a reference). If the page-cache
>>> replaces the folio, a new read fault might map the new folio without
>>> flushing the TLB. That's okay, as MADV_DONTNEED did not complete yet.
>>> Same applies to MADV_DONTNEED of CoW'ed folios when re-faulting the
>>> page-cache folio.
>>>
>>> Memory reclaim, which removes folios from the page-cache before performing
>>> its own batched TLB flush, will be handled separately.
>>>
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>
>> This is really old.
>>
>>> Reported-by: Cenk Yılmaz <cenk@deepfinresearch.com>
>>> Debugged-by: Cenk Yılmaz <cenk@deepfinresearch.com>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>>> ---
>>>  mm/memory.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index d2f48d78b0d7b..e1d9759e6fde1 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -5888,6 +5888,12 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
>>>  	/* copy-on-write page */
>>>  	if (write && !(vma->vm_flags & VM_SHARED)) {
>>>  		VM_BUG_ON_FOLIO(nr != 1, folio);
>>> +		/*
>>> +		 * Concurrent zapping might have dropped the PTL but not flushed
>>> +		 * the TLB yet. Flush before installing a new folio.
>>> +		 */
>>> +		if (mm_tlb_flush_pending(vma->vm_mm))
>>> +			flush_tlb_page(vma, addr);
>>
>> This looks like an adhoc fix, but it is minimal for backport.
>> Hopefully we can find a cleaner refactoring later.
>
> I'm afraid if we don't want to throw away performance there is no way around it.
>
> We have similar handling on the uffd-wp path ...

Performance or our sanity. :)

Anyway, this is for a later discussion.

Best Regards,
Yan, Zi
