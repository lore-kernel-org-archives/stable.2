Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011005.outbound.protection.outlook.com [52.101.62.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B823A4F5E0;
	Fri, 10 Jul 2026 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696273; cv=fail; b=AwTPQ7YUMR0bDBGE3q6Y6jIn5MHcfLOgFatM3JOUOEGgvbFmhvObvRvS7pmbyWWf15J1BJYRrqKHl8q6Pgr01OgPKl/sIqrp2/9tOdytkETxioZ4GZ43Vb5qVijso97ZiBx/E818iKP3sa2x1AqUO49hjiF6Zde/l94SlpRS5YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696273; c=relaxed/simple;
	bh=YpKHIZ56rl+gw4rI/z/qgVC9hKPaaa3C+M2LHn6yAIY=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=KidsG/rMFcpXSrAExEJU9ZfFavROkFzTWLs9VLgylT5smY4sV4y6POOaDrYbgaO0Pw8VGA5s5VznTWsXL0p0YFYaGtpJJxH8gnwxH5XzSPOkn6A90cGjgp16+NUDRHjcvcy1THY2kEXP8n0c/EiKUa25qKLEmbmfxsQQGG0EURY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L3sPoie/; arc=fail smtp.client-ip=52.101.62.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L3sPoie/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKSrvv3ZYhTc/XnE2NEEL3NyRDEd8rw/IXcSfgT9yO+B1UuSUDy4E+MU8CVjzhsCYgtUn+zLV/8FLtkPIa/UlLksjrqOhzo3EoBUB+GVdDN87zB5aQFoUIi65lmuj0C3MKwMWTlp0jkphK/guwh9TiNCbOVvtbnwjWG+wExlr752BDjhhmrrtxsGQeAxO4gjZetVyIa8ey0HaWTHVlhYiz0PAYCpA9vtv18uovm5tbR1xigHihaMXJ6SCVH4GnFe3YWu1eObRA8vheF6ILfrAa49CtQP6rEuu8yPiCX1eiGFi0sSePOx+VO487e0OQLlJlpbl1Kcbc18Tex1n8gp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpKHIZ56rl+gw4rI/z/qgVC9hKPaaa3C+M2LHn6yAIY=;
 b=OMk0EjE2llxPf0vlJezbzK1JGf2zc0+j/6ZJkrE6JyU0lNSCjtcspXkcokxKpYpx4APf5bYIx8ryA+8sEYAFG6lRVUefgJrKNHvQ7n7DF1L49p0Je3SI2IEXsnr1tQnOf7O1WnzNTuP83LoAb/kxVIv8WJIGbhGEEgu08Egx4y1bYRSpG9z58ZvjI0EmJPBs8qBUw/zL8yn1vYz0PATvfEIH1qFzgSbAC1pHMvCQtYKylkfh+5Y91SAHyOWg3smyLZkFt7GZoY+2QftPF1/0DSx9ezpu3/WbRuoNqfJhCv85/anYqWicCFkrKNFEFkoetHHRsjK+l8GCVNh3VR2bYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpKHIZ56rl+gw4rI/z/qgVC9hKPaaa3C+M2LHn6yAIY=;
 b=L3sPoie/rZg4C0/uBb8/AjX3/M0hNWTsx7GeyqrdXmemoQlUK+Hy67k7Kz2uAdy8JKponqLvJ3i1U412eHIvQMkdxJXk6Z0wXIlretMYbvD3+MFMxvsufClzyaIxWArWsKvyFP+tO0pe91YGIGbWZdhyHbtZVzjPPslkiK4Q8pnds+z9bnx5d5iAg1an5mRrX/M3538MFKGM6IiUmtAIi05MFJVWMEiwMr2N7ekWofrnP+JNCWehtsXhLSUREyYTM0IhGIC4EEMKdBVr+YrpVlgioxZhKdCBSdCPPvYsjaUEIlMB+EjNDL0Q9/6OXxgo9/PPGUodJYKZUf8qfLLSVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 15:11:06 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 15:11:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 11:11:05 -0400
Message-Id: <DJUZK00N36Y6.NQP9QK7QB8BA@nvidia.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Brendan Jackman" <jackmanb@google.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Mike Rapoport" <rppt@kernel.org>, "Yu Zhao"
 <yuzhao@google.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH] mm/page_alloc: free allocated PFNs if the range does
 not match
X-Mailer: aerc 0.21.0
References: <20260629-free-pfn-on-alloc-contig-range-error-path-v1-1-496ff9ca22db@nvidia.com> <4549ad0e-abb1-4156-95c6-5e3c1319dffe@kernel.org> <d44ae8a5-ec70-456b-92a0-ce7ccabf6917@kernel.org> <DJMH7EKQ3SBB.2REYPX4LVFFTF@nvidia.com> <9210ef86-3131-464b-93e7-336420d894d9@kernel.org>
In-Reply-To: <9210ef86-3131-464b-93e7-336420d894d9@kernel.org>
X-ClientProxiedBy: MN2PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:208:239::32) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SN7PR12MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 2494136a-4171-4942-6470-08dede9576d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|22082099003|18002099003|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	hnh+niSkn7suCuzgK7gFyDLdOmo78NWkkncbwu1It47/6zPqxL5o1+0Mp/5NVWlIPrGc5GRuMWPq6e8vf7FWGpL9xpC89eOx4SNkBvYYRIIV4ftye3FOEfnWmTon/XL1d1cUK1ggWhhC1f2OJ10jK4LRycnyr4ckzDq+mWywtNM0b7d9ZL3tJAlnjbsN2gcJGwlBcqLMSRd/QO13pn3YORdEVihLxWu8Yq38M9CmT4fZHEBrE58v3N0eJL42hdN7m/EQmVrwcjJhaZROe5hBiN8g3+szAo98tOV6wIgRullWlTEqHI/DY9pIEp4XKgVp97Eg6zv6ifn4mc6/UBAIHow40vugStMFeCuDQc84ev7IO9nQbZSC6UKH8pfXSxg19z8dIFMmNBCm34mQTvNva0GC6CyjXEIceMAWME1sLmU1Rqt2rm2C07M0uTZp2cS6AkA9XLXEufQByMwXyoSCeRqQGmsE6GjlGMHgqXJuwirfYUiJG+ULHazWtSS/N0W8hcx6f5WzeLBo0Rku0PgvOD1toi2pCegaXCZaYk0ezmHX+fJn2vauEjQhsulBF1T/e2gaIGHaWYahw8sCMRVCr7FF1Xi/w1lmFzUMUyg3AtJ8aJvgLoqg7tghxn+aaLkwkmQczw94ETkqr0rF0hzs/Pr4MqOM4QVEs9L+HMjrFfbZB+ZeSrv/0riOrjREmQ+A75zy9FSP1g9QE/zjmqFLVQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUNnYWlEUmZQMUQ5ZlJqdkE4V3JJUDhqc0twT29sWm1Qc1FDbGM5bG9OZjNW?=
 =?utf-8?B?ZkpyUWdIOTFsa3lFQmRZMmI0UXVCMWF5cm56SC9MVHFpUTRKaTl4VHczSEdv?=
 =?utf-8?B?Y1MyTkhjKzYydFA1RHVDZXVMNzZJdzNZQngzc2xvVWJwczRlbWxTT0ltajYy?=
 =?utf-8?B?WXdzS3lmV0RzNmJLMTYybmdDb3gzT1h0MkFFbm5sWVoxMkMwSXlwb28zc25N?=
 =?utf-8?B?R1daNFl4VDZVR2Y2RisvYTdVRWZkKzBuRjJLaXRta0lXWTlUMkVVN0VIVC8r?=
 =?utf-8?B?VVJ4YXVNbjJYVm52YVNTaE5nMUVMZ05TOHJycTlMY3JCSTR5WkNmUlE5K2Z6?=
 =?utf-8?B?SXpZTE5JVHhKUkYyMHVkRWpqVXhZTVJNZjNxeGF0OFNaRFZSZHpEZmU3SzRz?=
 =?utf-8?B?eVJiMEVNd2dWdHpQNHBOZi9DZ1o2MjZGSENMZ1VZNkVWTmhYMkFZeERSdmMx?=
 =?utf-8?B?aDFrbG11ZE5TYW9oRGZwL1hKSGUxeXg1N2ZxdTFtMHdhNHZaU3llZ0VzMVJY?=
 =?utf-8?B?U1hWMStkb2pLSnJPNDJQL1ZROHdrZzFEZkdCUzk4cUJWVFRmTmZIVjEwTy9i?=
 =?utf-8?B?eUd2NEFVZjdBelkxclpVRW16RForQTNGTVQrZ2FKbXVlNGRoOHFIbWJKSlky?=
 =?utf-8?B?YUJnbDBickI0Mm5QalBETFNWTXhLa2JWRmNFbG02ZXNkNVRLNWRyek1lQUY5?=
 =?utf-8?B?QnJ1OE5qamZVQmtHRC9aR3FPTHk1VUZhUGxhQjFUUjZrTFZWeHlxS0wra0x4?=
 =?utf-8?B?ME1nZWt1c1FjeXJDOHp5UXlUV2U3K0RBZmwvdytVTlBqajNpSFVkVmlxdE4y?=
 =?utf-8?B?RzQwSHRGK1hVYjRnUDEwVjEyN3BCSTNaUmlBU3FPbTNIdkJuRkRWbFdUNDBi?=
 =?utf-8?B?akFiQk1mYXQwd1A0aXdpbDJDbXNDZHV2UjBGTDFWU2MxSmtRMkdCMDd5YnZY?=
 =?utf-8?B?VmdHK3hiVTN1dGE1ckhkMWhZNHo1Vi8xaXowZHgzbmZvTlZoVVBhQWROVm44?=
 =?utf-8?B?MDRDeUEwSGRXTHFTK0ZDZEpiSWFMTUtSYnVrRXVjUFljYWNXekNIZXRiaGFq?=
 =?utf-8?B?Z2hTTldQWkRRVTlkcXdFYlRLbUt6MXdad0k4cG1Hb1ppN2V3Zmp6RFJjcEY0?=
 =?utf-8?B?anNHRjAyenBEWXE1YXI2NEp6VDZNL1MvRVAvUmJZSTljdDVNQ1ZCQVltWWJk?=
 =?utf-8?B?K1BYUGcxL0hTQ2RBN2srdzJsTDdiQXo1bllpZHRKZ3h3LzFQVkZnUFRsSERq?=
 =?utf-8?B?WkFYc1M1NEJLSHU1bk5qcjFReW9rWmF1WW1sSFpSVmFydFRZOFBzdHk1WGNl?=
 =?utf-8?B?VkRHb3hoaDlLTC9HanQ4T3cyWmpGS2I2TzYrOEEvem85YWJrKzhSRG1lZERp?=
 =?utf-8?B?QURBNHQxOHhtZWY4TUdCbExIL21GYndNNDNPRHlyazRmN3hoY0FXMDNqd05B?=
 =?utf-8?B?d3J3WWxWQ0k0Z2FKSE9kZWJ5SHhmY21sL2pnald0M2tlVVh6ZEplcnM3ODRu?=
 =?utf-8?B?ZnQraDhXQnlRRDdtRkl5U1kvVUVFYzVDdWpaL2pmSmVzREhsbUtML2xJS2k1?=
 =?utf-8?B?MEtxRENCWGt2VHg2RnE0YzR6VHNJeENSRExTbm04bHJmbUxGV0UzQW43VVRY?=
 =?utf-8?B?dWhDUEE5VTd1WGlYS1dFZ2w2OUVyMUVvQkk4SlFIL094bEFnTmEwYmwrQzFP?=
 =?utf-8?B?MFNFMHRpczNoMjJqSnZhc0dEK0NNY3RTWlhWMXpjK3NwUjJDN1M0QUR3Nkpr?=
 =?utf-8?B?SWREN2JRUEREcHJWNG1QakxYbnNhT3VaVm5XNlpxRWg4NXA2akMwUzVEbWsx?=
 =?utf-8?B?bTJlT0hiVDVzYkRZeFBxamFEckxyNDFtY3lCUjl4VlZIVDZPZDhaRHJXKzdB?=
 =?utf-8?B?QXRscUNYamZuS1VpOFFBcWhOTDZPd3pjUnhKV0FCTVJ3dEtSeUd1b21QSE9q?=
 =?utf-8?B?WGFSaTJCLzNCZjJQR3BnOEhVVkIvYmxaWlFmckxpVlF5NllpTlA2MVNvTnpO?=
 =?utf-8?B?dGJvWWxaeUFlNldpVUM4dzZsK2ZvOHZPTmwxamJUeG1lV00yVWFheFlPdHN1?=
 =?utf-8?B?dHFsWHFTN3VlUFpEU2wrdndjc20yQ1NhOUpEczJ4NS90bk54QktOZDBCUkNt?=
 =?utf-8?B?aVk5cEF0KzNaU0EwT1BXOHhJU2treFdub013SnNqYmNZaEorOTBGd25rMTRn?=
 =?utf-8?B?NklmcUFWKzNpbGdyT3VzRU1zakhHRjJHaGk2QXRZRTZ1WCtpblJjYW04Tk56?=
 =?utf-8?B?YVVLZHZoR0lEN1RmSEZKdktXUXVrRy9iQURhWEVRcDcyMm5jMlBtdFhIYmpP?=
 =?utf-8?Q?Qd4Gb5HsmNPfHwwzUS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2494136a-4171-4942-6470-08dede9576d5
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 15:11:06.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQybVHQbIm+mEOxRDulT3SyHwxM+oyaZdU2Oke/eZysKOzVFXXSb9l2rL617eQlR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250

On Fri Jul 10, 2026 at 10:45 AM EDT, David Hildenbrand (Arm) wrote:
> On 6/30/26 17:06, Zi Yan wrote:
>> On Tue Jun 30, 2026 at 9:39 AM EDT, David Hildenbrand (Arm) wrote:
>>> On 6/30/26 09:44, Vlastimil Babka (SUSE) wrote:
>>>>
>>>> So this?
>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>>
>>>>
>>>> Hm well, it's a path that warns, can only happen due to a development =
error?
>>>> Not sure we care about stable then. Anyway.
>>>>
>>>
>>> If someone would run into the WARN we would already be in Fixes: territ=
ory.
>>>
>>> it's a path that should never be executed. If it does, the real issue m=
ust be fixed.
>>>
>>> So (a) I don't think this is stable material (b) I am skeptical that th=
is is
>>> even a Fixes and (c) I am wondering whether we should touch this *at al=
l*.
>>>
>>> :)
>>=20
>> I looked at the code again and agree with you that the code is not
>> reachable and the fix should not be in the WARN path. Theoretically, if
>> order =3D ilog2(end - start) is smaller than MAX_PAGE_ORDER,
>> find_large_buddy() can return an outer_start smaller than start, leading
>> to this WARN path. But currently alloc_contig_frozen_range() with
>> __GFP_COMP is used by gigantic hugetlb, thus that is not possible.
>>=20
>> How about
>> 1. making sure order is bigger or equal to MAX_PAGE_ORDER,
>
> Makes sense. As you say, hugetlb doesn't need something smaller.
>
>> 2. adding a comment in the WARN path to prevent someone else trying to
>> fix WARN path if Sashiko reports this again
>
>
> Agreed.

Thanks for the confirmation. I will submit a new version following these
ideas.

--=20
Best Regards,
Yan, Zi

