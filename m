Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CBB1F1537;
	Sat, 25 Jul 2026 03:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784949381; cv=fail; b=lj4PzLPI0K9gNGgcXvA8qnVXiRG/hOTJx7bh9Ydt3hggupp5gGVTfo0u7mWVMqqXtHJ2+1axB3dK8X/0wNl+EO8g3YkSqChBDcnIj4f0P3ZMdtH9qxf7qnKNL4BAk9I6UxX/LxUoAhWVy3ebfk5odGVP6bwX827w+hanus9DD54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784949381; c=relaxed/simple;
	bh=s0OtPE/6winK3uonLznN10sT9z5147+zJ7CgNp/6qj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DaIh4Rc7e0I694Jzh4kaWmt5VKpbS6UWHUBITDQXkPLn5FpZsJ8GefCmENPO/Oh9DMI2rG2XiH76KoHZWo53QxHgjhz6lUkRhqt+0bAirZ2jCLZhvdKsfQADL6BaT2KcGVLmWUQcjgmqyjtnC1mIIkXQIZaOr1erjQtGQc939wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZSBf34OL; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZSBf34OL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkDbHsKKYTWHvTf2RGK4Kxbbo6dKSZuUs0pPs17bekBBf+Du+QMW2pVPVjacfQ9twUHMAml5H/h4bOevacQp1OyW24AE9fNcYMkyrIwuNO59qQLz0qe/9dDaQOmQdOlwMHqizrUxejv4di8Q0xyJ3oaKbGl3Aw1iPb0vHZhR3+yxnranfHygqfSaaFG00Vocoy4eiZWH+nXJ1/TSTVG++FRGq2FtxC98HZdY2nM82uQnGShGsg4Bld/ImLvekNnxIasuLL7tnflQnHGaZIt8X11K9IcJ8tkl0fmMp5X+3AevG7eQIqizCzk0n2HlTQU6OSQOG/vN/naLpUpwOfc03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gx5H1shF/buhZZYpk2FmwlBceq5suqo91Tz20j7+O58=;
 b=msrl1smD+YU7y4U2hCHN6XvGva9PpdnlrqNzJ4mDBFd99Gsqk9tRCrDioqvncsgheohW3Gpx0aunIkzuvMoysSBksFmCAwoGd3yNTvCdFpsqqol3bTiG42BNDw+Siqi5pQ8TkYpxq9khsu4W5/b/bdHrPQCX1Dg17nPM5Hie4sCX07EXTF1AHUM2Xb7M6zonUCzHmLP4SlL3312RBaJdHHgnH0gqAnzka6AswnO3ab0md5dKlsuoBcQb+OBT907/0CtpA/Br3inY0S18Uzeu2wiXgagsawRRQK6FFkX3Hmu3Ar4j7x1IYxczYqcEarLV/p+yr2JUAXxxSYWm1gCGaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gx5H1shF/buhZZYpk2FmwlBceq5suqo91Tz20j7+O58=;
 b=ZSBf34OLXWKhsW1IhGmxIpGil4o5c8LTzyP2HM0p8GOLNOiZZOKbceMhgShgGI2aiOvSeXU5aYEQb5P2TUdFYi0HVjDL9lHOhcbyddUbv1Jrdl254NHuolO8wpucJu9hyb4Sno13VyL/SxbiSqQq/j+fPPOzf/wricBY1q+69MSnqLMsMrG0rVZ5+5LDtkwFB8N8WI7kyTwXXKx+CY8sEI4o1haNCjelCNTGIry97gCmcOE19TTpHqbzw3q5DiLniUoN1LJrNEhXe1jaFneITbH2BJeZk9X8p8RWFBKyOcg44P2FHTrOghRhatsSU7e/ePhzGXC6//zyVPskLYjVCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS5PPF7671D5CC0.namprd12.prod.outlook.com (2603:10b6:f:fc00::653) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Sat, 25 Jul
 2026 03:16:02 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 03:16:02 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Kairui Song <ryncsn@gmail.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Matthew Wilcox <willy@infradead.org>,
 <syzbot+c5b060ce82921a2fd500@syzkaller.appspotmail.com>,
 <stable@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <kernel-team@cloudflare.com>,
 Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH] mm/huge_memory: Initialise workingset state before folio
 split
Date: Fri, 24 Jul 2026 23:16:01 -0400
X-Mailer: MailMate (3.0r7024)
Message-ID: <A9196318-4D79-469A-800C-09B83E2222E4@nvidia.com>
In-Reply-To: <CAFF6190-1325-49BE-825D-FDD9DA91CF03@nvidia.com>
References: <20260724195244.3715130-1-matt@readmodwrite.com>
 <6449A238-AA0D-4EB0-8B78-2A669532AEE8@nvidia.com>
 <CAFF6190-1325-49BE-825D-FDD9DA91CF03@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: MN0P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::9) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS5PPF7671D5CC0:EE_
X-MS-Office365-Filtering-Correlation-Id: 21140a69-aeb9-4f8e-b9e8-08dee9fb0e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|4143699003|56012099006|5023799004|11063799006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aM5Grl8pvv4OmH0OYVHfVl0XPNd0dVxdxSDvPKFozVqJnFlo1q+8dL1Ez7DkDIK5WGCg2Rq6atJ3d9Gywj0CioJDPCni8x2QO6jESAOH7jRmlIxrCXGz/X2B2Gw7IY/zcLbLHb/IzjowVuXcndK0O/+eBw/B5z5Uz4z3IiRXbmvt81Gh+485BgvFDFdp+JaWMj9Fw+egVtWabBizCygBdFSTqJLXWIRcCrOWKr/AZ4T8/rM8GHyUSvXE5nktYND+2MFg9kCefbq9Rsp9jJllM3fryX5XyI+FXbKbxwbYzG5u9tw8RbyFECrRrM08NDiwgTGDFXHtJbkfjqCGu9rW7YfmRQKpzPTN4HZ2jlKOiqpON53OGEpbw8POXXClmPsWxu68b5HqdGspNT8G0GNDpS2kwzrvzLVfBzusZcuypzOnhWlsMNbikac05F06EBBo4/I6N5bc5NeiKxyUeZoaeArFTF5X2gy4IKgD1UkUxWzoW8ZIrIQeF0xuDnZnFZIwrfz3x2Kwd4BKz3tfsEfvyrXodAREFmClYrMMEJVU6GPH4h8TfkU4a2kQp/nK66lFR6LQlpaYgbb1Xt7fQunYQqW0tHdKrPiG/vVIzEzFsHfyxDTIOi/1QPauU9/XwerFhJB7/i09oyf8yWrs6C0GvOryLnzOaY0Loo848mgzHrQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(4143699003)(56012099006)(5023799004)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2M4czdlZFRZSlQrSHJzQ2ZzMDNlVEpQTUlpWVpsK3J1N0NKMmtIMzNmOTJZ?=
 =?utf-8?B?ZVJ6eVFqUWU5cVJXN01ZTUNzaWZsVXNBYXhMLzFsaXNZNEhDbmxYcnRSR2Zv?=
 =?utf-8?B?UUxkUHptQUlZdjlHbGdvV3VTUWZsdXN3WDRNanFLQU16bG9UQWJLdGoxeHpq?=
 =?utf-8?B?cEdmMGRycXFNcU9ES0pNUnZJbDgyT3JiaTZiTGxKVWZlb2U0LzI1NHZPOGE1?=
 =?utf-8?B?dlpkdnRlUTJKYTB0eHhIekxzYXFFTkdjbEU3WTFmbGc1a216T05sYlhOOGpY?=
 =?utf-8?B?VEJESVR0V2Z1UFJ1YTJPdUN4c3ZWNWdVTWVPaE53dXkvNUxaQTRpWWZlL0Yw?=
 =?utf-8?B?bjN4blZ6cWQ4R2hXMHFuaEJjMlV0M3A2SXZ2OW5BaE9mZWNhUEk3d29SYXZq?=
 =?utf-8?B?QjNyczhOaVJJcFR2b2ZIRFlBazBudGlVTkdkdEZFbXpRbmMvK2RLMFYrTThx?=
 =?utf-8?B?MTVsMHVhaFZjOVFuTUlmYVNzMXVvc2ozM25ZbjVoTitkVjZJdm9naFlFOXcr?=
 =?utf-8?B?eXhZcFBIcUVKRGxRdVFwSDJvZDk2Y3BBRlA3OGpvWjNVZnpCaGZPVzQ4R2xR?=
 =?utf-8?B?UDVXQVdOaERBek1UcXFnTjdCSEo0TEJNTGU1OG5OdUdIbU93eVE4R2IzRHpQ?=
 =?utf-8?B?V1RYdkg0TGpDOEtBNXg5TUVNWHNrUXRpSzZoVmpJVERCTFRkVzFQVHlNMitJ?=
 =?utf-8?B?WllCbVRIcDgvMTExR1dhNkpFVTNJc0k0aGhnb2ZEOGpOWGdNcFRQVlh0RGJX?=
 =?utf-8?B?NlRrdmIxYWM4VmgrVnJZa1BCS0orS3Rjb3BoME8wTkU2WE9OdEtSako2TmVy?=
 =?utf-8?B?T01IcTdyYTZNV080dFJDTEd5cmVDNjRMTm1qOTFwTFh0VmZiVzU4THVmUytW?=
 =?utf-8?B?NThYMlA1TzhnZmJ4MDlqY05pY1hoMTZHNzNNSlk1WWRSanlkQmlPQ2FvQmNF?=
 =?utf-8?B?UW9kN0dvbU95Ny9odmlxRUdBSENPbXlIb3ZtVEJvUjdhMVVxWGZnclhJcHNx?=
 =?utf-8?B?K0hmWFpjTFZSbzZBODdKU2MydG96RVQ5dHVNWTNHcEV2OWg3RGhRM3JaSThM?=
 =?utf-8?B?blZvaUh6enhMZkdxenNkb0RHSTNXczlCWjVPTXlRTjBCWSszT0pTZ3NvaGdz?=
 =?utf-8?B?Zk43SWtuODhSZ1Z2U0NMcFlxdlZkdWNxVGpVM3BFbk8xcGREcThXYkg5dGdX?=
 =?utf-8?B?MkhabHJaWlRZeWpnZnRnS2Q3YkJ2SWxhZVVtbzRlWlVMVWZnQWxsajc4T0ta?=
 =?utf-8?B?LzBpOGlCWFNkRkhtYUVFOHlLZ3F0ZWRibitIdk54MjAvaUV5TGNQV0NoVzhp?=
 =?utf-8?B?OVlQT2ZVa0ZyV0Y5NHB1MzNaaGg3UUUySURWWFhwK0t4eHNDTzBZNVNKM3lx?=
 =?utf-8?B?WWs4K2NjUy9BTEdUcGg2R09ZRlI1Z25FWTFNbDBleURVSlgzSjBKb2tMdkRE?=
 =?utf-8?B?blhFdTdibDFnNGVpM29YRFY3VGJXK1RvTFFTWFQ0R1Y2U08yVXEvZC9mTWV1?=
 =?utf-8?B?VmR3TEFMT29lckljOEwyS2UrbUNLUEVZeWJpdlRwdTJoSTZ0UVdGdnlNQWVy?=
 =?utf-8?B?STAxMGJoWVhyWk9CRVorL1ladnF3N0dwK1Z0UFI2SmtVQW5zK3ZlQ1RwRXhO?=
 =?utf-8?B?OUZLMVE3bUFPazRuNk9hS2E1d3dIOTlWamdyWC93azI4ak52WlVxdnlZSUZH?=
 =?utf-8?B?WEd1WlBXcmQ4NndYbFlWRVJJRWZYRjkwa2w4SUZJS3RGdDBlTldIb0ZVMHh0?=
 =?utf-8?B?aFkvRGhoNEs5dXA1Z0tNMXZNTllwcTVZYTZkb1F3SzdvdWk0dzBKcnBJYXdE?=
 =?utf-8?B?YlJZUCs2alZvTXE2aEhkNkg5cnZiSkVWcHRvcDAvVE4zb3c2akJnK1ppMkx3?=
 =?utf-8?B?NVJENG1hL0tFU2V2dzR1SldnTGw1VDB4SzNUa09tRmJzQm1iVWh2enUxVkpT?=
 =?utf-8?B?ZWFLcHY5dzZOcmRTR1RCYThPTHhwZEhRaTViMCsvU0JDekJrU0Y1d2tDN1hL?=
 =?utf-8?B?YnZnRzlkVkh2Uk5tRXJoM05VWkYwa2xlckN6d0hxYUtQUEdhK2VJZlROTEZM?=
 =?utf-8?B?QTJMZjZmWlRUNUo0cGxlS3dHQ1p0RFp6V09GNGtkaFFZYzJkZnlVUU40Qzdv?=
 =?utf-8?B?QXRQVEdzZUVtYlhHWktwOEN4d0dzN1JnbVBPempsT0lJNG9kK0pzNXlDRTk2?=
 =?utf-8?B?NTZTUDBVYTRmYjRoa3R2TmQ5bElCWWxGM244VjcyeS9HRzA0ZVduNUdKZE9T?=
 =?utf-8?B?d0pWLzl0Rm1JRlVka3U4ZWhUcFp4bWx1VStOWFBQN2xoT0dPekhlMmFhSktk?=
 =?utf-8?Q?6jCP7bqQls5ZHsL2GM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21140a69-aeb9-4f8e-b9e8-08dee9fb0e7f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 03:16:02.3608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xr0rST72wJcydLnv7lowUwJpLAPRG/079DcHQk7tZd5jN0/Qbi6P1wP6NtGdng4o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7671D5CC0

On 24 Jul 2026, at 16:26, Zi Yan wrote:

> Use Lorenzo=E2=80=99s current email.
>
> On 24 Jul 2026, at 16:18, Zi Yan wrote:
>
>> On 24 Jul 2026, at 15:52, Matt Fleming wrote:
>>
>>> From: Matt Fleming <mfleming@cloudflare.com>
>>>
>>> xas_try_split() adds __GFP_ACCOUNT for page-cache xa_nodes, but
>>> __folio_split() leaves the xa_state's xa_lru unset. That lets a live,
>>
>> But mapping_set_update() is not required for xas_split_alloc() and xas_s=
plit(),
>> or at least nothing triggered for uniform split path. Why?
>>
>> xas_split_alloc() uses
>> gfp =3D current_gfp_context(mapping_gfp_mask(mapping) & GFP_RECLAIM_MASK=
),
>> whereas xas_try_split() starts with GFP_NOWAIT and follows xas_nomem()
>> by adding __GFP_ACCOUNT if XA_FLAGS_ACCOUNT is set.
>>
>> Should xas_split_alloc() also take a gfp input and the caller gets
>> gfp the same way as xas_split_alloc()?

xas_try_split() is called under the xarray lock with irq disabled, so it
cannot accept arbitrary gfp. And xas_split_alloc() is the only one does
not do

if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
	gfp |=3D __GFP_ACCOUNT;

the others, xas_nomem(), __xas_nomem(), and xas_alloc() all have it.
Commit 7b785645e8f13 ("mm: fix page cache convergence regression") added
the __GFP_ACCOUNT statement. I will send a patch to add it to
xas_split_alloc() with Fixes: 6b24ca4a1a8d4 ("mm: Use multi-index entries
in the page cache")

In sum, I think this patch does the right thing. And Sashiko pointed out
this issue before[1].

[1] https://sashiko.dev/#/patchset/20260716095424.471052-1-kirill@shutemov.=
name

>>
>>> memcg-charged xa_node exist without being linked into the mapping's
>>> shadow_nodes list_lru; when reclaim later walks the list_lru it trips
>>> VM_WARN_ON(!css_is_dying()).
>>>
>>> Use mapping_set_update() to install both the workingset update callback
>>> and the shadow_nodes list_lru on the xa_state.
>>>
>>> Reported-by: syzbot+c5b060ce82921a2fd500@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=3Dc5b060ce82921a2fd500
>>> Fixes: 58729c04cf10 ("mm/huge_memory: add buddy allocator like (non-uni=
form) folio_split()")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
>>> ---
>>>  mm/huge_memory.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index b5d1e9d4463d..12d0e0b14e83 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -4033,7 +4033,8 @@ static int __folio_split(struct folio *folio, uns=
igned int new_order,
>>>  		gfp_t gfp;
>>>
>>>  		mapping =3D folio->mapping;
>>> -		min_order =3D mapping_min_folio_order(folio->mapping);
>>> +		mapping_set_update(&xas, mapping);
>>> +		min_order =3D mapping_min_folio_order(mapping);
>>>  		if (new_order < min_order) {
>>>  			ret =3D -EINVAL;
>>>  			goto out;
>>> --=20
>>> 2.43.0

mapping_set_update() probably can be delayed right before the if block
containing xas_split_alloc(). Otherwise, LGTM. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>


Best Regards,
Yan, Zi
