Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4E6282F17;
	Wed, 26 Aug 2026 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787781181; cv=fail; b=EjtRslzoyBTl4sWxzP+95xe9Bw3/hrUV901y17HBq3HJAkDN8AyhvZQKQxGPNQjlYrKYl9sUi5heEEaMUSbJOtAYfjLAlXrMRStgtULcGA3/I9NCFaYQ+QZ6BgLfrm4fkoB9cHROnTCoEecGJgybR8DemkWizOCNUDDzumgS5uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787781181; c=relaxed/simple;
	bh=XXM4WdDOXwr0ze1bR9U/uH5F4u6AlTLN13q8EL8lQHo=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=VUxhofbMPhM+0+JfiYrm3kw4XubzfDEVfmgSsSHKUmEQAD15hDhx5r3rkA1orMr1OMzhShM56i0O2vsPD7barHoAMSVGPtpCR2KsR2ncM/LT61fzkCCxrwlKnWBFd4cq+SBqRkfeuXWXlw9ZZ1z3896dU5ppE8JO2NavKKPyD9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K9R8BdaV; arc=fail smtp.client-ip=52.101.53.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K9R8BdaV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZn3K3yDUX6icViZfrQZtGsjBBQgfedp66FIe4xyQpDZ8sMacUhCCvfFq6fcgcwqyHTOmOHuCYEbAwqdK27eZoAxQuf2kuioGHTVGsarDUw8QVGY4IAf+pD3lfxd39UwWgitE+nFjrwLgRSE9nITWeE9Zy7OOV6IzHuGdUZaaV8V3THs+STo+qGkJDpVA71SuADz36Rw83pkHLLZQ9C6fRxZD8S8nlAF/fl/uwuYh2BWKmcnUKyLSl08qaTrrh19YyOPx9kT/VUAhLOMnJb84kKNMtQZ0z0KyfrzhLxryNRxXnj3LMBKMGM16/6YblWhzL1w9+1tI1yVsrH2KHcRxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dL9TGz9RNXdnSlrzLw++iAOljeErhQDaXkFmcoUCkI=;
 b=NwHYrO70FkvV4D0NsOzwhjGHJmF+tBNnagYEs6Eo4wnbafSykSwNvFH4nBkPHWCfsplsxcjxiuUdaw/zMv6tjJrqeG5WHqt8qfuhNr889TRp+6Kl2z2scyEw62ODkFRQ9CVW1LuUFpFzzvB0GfjLxZhU5f/IXIzKfYjLzMBOft6VUXceSOLP10Bj/xfznDq0BqLexqnuOvupr84uozV8dOjeTqYpsK7VrZa7REvVWSDyYeWis+475KsYB5VY1z8eEtAUCmdQ6A0xX+iPFuK8rSwq7B/PBkNiZLz15xxU5ucLjBiDQPdhmzX0POauy6lghzCKXyXImYAH8NUE0NEIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dL9TGz9RNXdnSlrzLw++iAOljeErhQDaXkFmcoUCkI=;
 b=K9R8BdaVE3EIpxzjgJ3iE/T2EdLqPfNnOCGgglFsNUC+IyPQpEV3+kAJLUDuPlbkVOsmlYRbVYoXo2jlEJP9VjFokiC9kfx50MASlu2GfBwg1dcI4MdolBDLgo0jX2Uautn/ezt5znqCTs2jTcciwLBF3hwGIxWf2ESwIGsv98sM24ZphPHfMVXUFWJ1p1ZDant9Y/ZR8DvARmgfYyYVE5czLIIBLlBMYxWbjoXG5fymPxkrmjhleXK/yMKdVOhqtfMaXesKkp0Eb8dorQV/YqcigA5K+dvTCjLCzGw3ACfsjQlRmIEhCvQPA1WcUnr+r+QtBY5fORf3rKAGNalp3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 21:52:55 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 21:52:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 17:52:54 -0400
Message-Id: <DKZ7J9HNUDR6.BP9KG5Q7HYMJ@nvidia.com>
Subject: Re: [PATCH] mm/slab: reject unsupported kmalloc sizes
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Hao Li"
 <hao.li@linux.dev>, "Christoph Lameter" <cl@gentwo.org>, "David Rientjes"
 <rientjes@google.com>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Alan
 Stern" <stern@rowland.harvard.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
 <syzbot+805630f1453e490427fa@syzkaller.appspotmail.com>,
 <stable@vger.kernel.org>
To: "Harry Yoo" <harry@kernel.org>, "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20260817-limit_kmalloc_size-v1-1-5bef487701cc@nvidia.com>
 <82f138f5-11d4-4839-94a3-c226fd982715@kernel.org>
 <ao9dPUpHxP5uOOcw@MacBook-Air.tail10959e.ts.net>
In-Reply-To: <ao9dPUpHxP5uOOcw@MacBook-Air.tail10959e.ts.net>
X-ClientProxiedBy: MN0PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:208:52c::16) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1c2555-c5cf-41f1-dcda-08df03bc628c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5EqWLt4tLfvopH9+qJ9R7GLRBEm78NfDyGThcH0E5ZhiJA/mD2tvTJTrIBrVIl5w1R+QUBlCYhpa5StnC5POtzbp2QwS6NzzRc33jrc/Qg+/uP0fJW9zd3gRMpkjdW2KyKEQfaPTGtaxl1ONhxv3eglr/YPZom7zwLJ3OqoYoO4Eu2GPZEZD9PGQt6/hrn+H2Kg1jqttG6Ek82PfS2GBioEm68lY2CUnjq7hP+5+actzExXzQaBn4SxHNGZvrvB6kEPazzPHj/wZOP5o57QzNVemdfvvUW7Y3giibvsbjNzJi/T6ZdpahvTKtSLVTCp5OzqtOboU/UB+plgZyGFYfyHlIaF/L1vD0QkFOxa8C8F4sDJUbCpW/6Pw6Ikoa9f3phGUgpQqC3RN8UScfWhuTm+V5tfNQRIxkWN/TgsnEivdzU+sxM8zLNvcxannSe3x+c4/e8ClM32GQIXGUWRDInG0uALABunZtUbEQ6Qy03SjDqRXqglEl8Kacksvs1j6z2zoM5WIOA0IYyrm3NbjlwDZ5fJ595UpjIyJD0o4sgNuCjDt4llGgFtRQprXzipD31kDtVxLRwCeDYyjFL7FZQT4lyJtOb09oSjhTc+Wcyp0XI8lZXMY1BaDBC6WhF6tQaAVD8wW/43CmrWGn0+Fe6KnkG/zXG4gE+tV+k1UbeA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHMxM0UzQnNYRW9EVE5mSmdTd0FVY2YrWVdTZFBhbWFPQUYrUWtMS1dEOFg0?=
 =?utf-8?B?MnNGa0toOGJQRzBHZ2VZZGt5UFFMUUphUGc5eXlCNlJORGdseUphK1pwL3ha?=
 =?utf-8?B?dXh1MTZnZWpxUFoyTDkwRWZmUUpScmRsdVV4am03TXhIM3VXM1ZEck9tQlla?=
 =?utf-8?B?bzlRcUhZbXduSUwyZzlEaEJraFlWdklRelhnRmN4OUI5VjlBQXZzOFljTkZL?=
 =?utf-8?B?Nkh3emhRSWx3MXRFUG40M2Z3cm1uaVBYTGd1QWtYVTZtakxxdUwwOUhPZEF6?=
 =?utf-8?B?TWQwd0VJR1B5Z25TSFZmR3R4VHBZY3lWRjR2YlltZXFYTWFXRmFyVFQ0YXpj?=
 =?utf-8?B?czZDOE16QVlzUUNqdlNXQkpEUlQ4VXRlUk8vcExpL3dwVjU4b0pkSE9Gb3kx?=
 =?utf-8?B?ZUJKZmVValdlRHY1ZHNTS0IvaitwdkVHc0g1c3BOK2RzNEdBN3J4eEdKUld3?=
 =?utf-8?B?bVQ0WXVDZWJUNUZOeVBveWJLTDFnbVVEdlR2Uy9qK2dsdWNpTzRraUxTaDA2?=
 =?utf-8?B?ZTVLSlNGOUllYk1PSXI4NHR3enFWaitFaVdUV2lIOEhteFl6VmI5bVVpNFpI?=
 =?utf-8?B?MFJ5UUw2Q2Vaa3c5TnJIaktsMWN2VVdhVFZNV1RpKzZycHV3cmFBckNlNmRa?=
 =?utf-8?B?b3dKM1p1VmlWTDhWdE5IaHorcFlOUU1Cd0VwZTdxaCsrdHBWbjVIK041UHdL?=
 =?utf-8?B?MVRVanJKdjVuTnVlaHQ5cTBWZlV2TWpIbVZJUkYxdWV2VmtXaGUwdTdGSE1l?=
 =?utf-8?B?MVYxVTRaV1p2TjYxZmg0b0dzM2pNdldIb1o4WTJWTFBQZmhsMTVNWkZhWnZ6?=
 =?utf-8?B?WDlqdVBrWThXb1c3UmI0NFNsVmwyM09JVkNVOHBhNnR2dDR6T1g1d2FHbDhX?=
 =?utf-8?B?eDhXdll5bEhaQkZ6R3E4clJERWlkSkhUVHpvQUdUeklWYzQxZy9PS1lucnRW?=
 =?utf-8?B?OVVhb3Q3M3hZWEFpcWROb2tDQlIrek9QT1lPaHh0OEo3NjlNa3ZFb2pzakU0?=
 =?utf-8?B?dUdvUy9RcytPWHNTRjF1a2VvSVFOenlRMGlrNGpadk9kVURGS3dNSDFjUStW?=
 =?utf-8?B?dDdwSnhrNThjbE1jMWRONm5KcDJQZlhqdVZSUDFlRGhpb3c4YURuUng2OWZG?=
 =?utf-8?B?VWxjYWtNMWdlblJWR1V0bXZ5enJXdDlqcVNOZ0VxeC9TWWdUYjRwUHp2d000?=
 =?utf-8?B?ZFRtMUE1ODJ6cjIzRXdFZzA2M1ZFYUI0R1dtNFZuSzNkWTVmQzduZlVsalJl?=
 =?utf-8?B?b2N3Ym1lM08vMTh2citRTng4aGovaHljVFRnY3BHWklHRE0vM0F1VC93b2NL?=
 =?utf-8?B?cDArRlA3M1dMWWVSb1VuMlhIZVFtSWlaYndKaUhrdjQzamFuYzU0MVEzYWlG?=
 =?utf-8?B?Z3gyOHgwZlNCaGNCbXM0aXdnTytFeW5MS0hXVndvcWJpVDNEelB2N2RsaVNh?=
 =?utf-8?B?WDBQVlhkUWp6MzBvNmRsZUg2WVZzNjErc0lySnVDZ01qQjErTWZzVFFpZUR5?=
 =?utf-8?B?aElxaE9xeE1VK3Q5dDUzYTVJTTNsYnM1Q2Z5ZmlVREdUaGZUWlB5aVBkODdv?=
 =?utf-8?B?azMzOGttUjRZOVFnK2l2dDhUNVhBWVluY1haMmxPQ2dRRVRZcithZG5tVjV5?=
 =?utf-8?B?amtydngxQnpXbS9zbnBVdGhZeWhMNmJMVFphWGJueWcxQzNQUi93WkN0Q1ht?=
 =?utf-8?B?VUloQVg2Q3ZSUzVpKzIzTjBxYTcwaVV5Z2pvZUpjLzhNOVp4bmNZZ2ptM3E4?=
 =?utf-8?B?NFNJS3puMzFxd2tLUHl1MXVRMFN1R3ZkRmJxUDJBd3RhZ1I1T2RMYmJEL1g3?=
 =?utf-8?B?QTdmZ0srOTJyN1I3eW0rb3RVUG9CL1dIV3pvelJFRDNuUzZVNUlLVys5S1pJ?=
 =?utf-8?B?SWN2N3hkSy9qZm55RXYzaDlGU012Z0RjUjNXc2ZBQmxXY0NqdjRVc2t5akF1?=
 =?utf-8?B?ZDNGYTJWV1F6ZStPcHpiN3Y4NWtCSHRYUnFoNFY1c1JjUG03Z1l4SFMybWFj?=
 =?utf-8?B?dWQ2ZmFFS0Y2ME1sMGYxMzl0YUQrbUNMNjFpRXAyaTJZbk1QZlArSVZTdXl6?=
 =?utf-8?B?Z2p4ZnJBSUc0M0VtS1Q1QmFkaFRicDJkdURTelJwV2NPM2Y4S29DS1V5ckdq?=
 =?utf-8?B?ZEZUNmRtQ09KRC85ZFlFLzRBQmdJWHJNWG83c09QblMrWlhDZ01PSHhnMFpO?=
 =?utf-8?B?ckYvaGMxcXNXdHhETFpLSTdyTDJMV2lCaVRCc0Q4bGttOXpvL3NUdGxaVlNo?=
 =?utf-8?B?eGF6ZHQ4K3VTZW9KSjZOb3ZIOGZQeW00b2NiZlhReFgzSExQSE1zcHNSOENr?=
 =?utf-8?Q?hI+LKtgj2R37t+D0nt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1c2555-c5cf-41f1-dcda-08df03bc628c
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 21:52:55.4424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 626j+LZxo+RESBI9g/e+5uq3rG9wOuJi3e5Lr76xMIjGL0LZMfzjXAtJ+vCmNpkO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911

On Wed Aug 26, 2026 at 5:47 PM EDT, Harry Yoo wrote:
> On Wed, Aug 26, 2026 at 11:28:12AM +0000, Vlastimil Babka (SUSE) wrote:
>> On 8/17/26 22:40, Zi Yan wrote:
>> > kmalloc is used to allocate physically contiguous memory for kernel
>> > allocations. For requests larger than KMALLOC_MAX_CACHE_SIZE, kmalloc =
uses
>> > the page allocator and can only support up to KMALLOC_MAX_SIZE. For re=
quest
>> > sizes bigger than KMALLOC_MAX_SIZE, the page allocator can emit a WARN
>> > because kmalloc allocates an order greater than MAX_PAGE_ORDER. System=
s
>> > with panic_on_warn=3D1 crash because of this WARN. Fix it by rejecting=
 any
>> > kmalloc size bigger than KMALLOC_MAX_SIZE.
>> >=20
>> > Fixes: aadb4bc4a1f9 ("SLUB: direct pass through of page size or higher=
 kmalloc requests")
>> > Reported-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
>> > Closes: https://lore.kernel.org/all/6a820ebc.9ebadd4d.20b15e.001b.GAE@=
google.com/
>> > Tested-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
>> > Signed-off-by: Zi Yan <ziy@nvidia.com>
>> > Cc: stable@vger.kernel.org
>> > ---
>> > It fixes a page allocator warning (order > MAX_PAGE_ORDER) when gadget=
fs
>> > requests excessively large memory from kmalloc. Instead of adding
>> > __GFP_NOWARN to suppress the warning, as was done for usbfs[1], change
>> > kmalloc to return NULL without a warning for this specific issue.
>> >=20
>> > [1] commit 4f2629ea67e72 ("USB: usbfs: Don't WARN about excessively la=
rge memory allocations")
>>=20
>> So I checked and for kvmalloc() we have in __kvmalloc_node_noprof()
>>=20
>>         /* Don't even allow crazy sizes */
>>         if (unlikely(size > INT_MAX)) {
>>                 WARN_ON_ONCE(!(flags & __GFP_NOWARN));
>>                 return NULL;
>>         }
>>=20
>> This comes from Linus in commit 7661809d493b4. I'd do the same thing her=
e
>> then.
>
> But the purpose of this patch is to avoid the warning in the page
> allocator. Should we fix this in the caller (gadgetfs) then?=20

It is fixed by: https://lore.kernel.org/all/20260820223719.A4A3C1F000E9@smt=
p.kernel.org/

Please disregard this patch, but we can keep the discussion going.


>
>> Thus there would be a useful warning for e.g. development mistakes
>> resulting in the size to be unexpectedly high.
>>=20
>> Callers passing size that comes from userspace or similar untrusted sour=
ce
>> can either pass __GFP_NOWARN or sanitize the size to what they expect to=
 be
>> sane (which is context dependent and I assume actually way lower than
>> kmalloc limits in practice). Note that passing even sizes within but clo=
se
>> to/at the limit, trusting blindly some external source, can succeed the
>> allocations but effectively DoS the system with heavy reclaim/compaction=
. So
>> caller sanitization should still be preferred IMHO. Some of the recent
>> arguments from Linus [1] would apply to this too, I think.
>>=20
>> [1]
>> https://lore.kernel.org/all/CAHk-=3DwiSmgwwLKCqJwGS-dVHnSLU8W+7q1UQq-G9=
=3DTBGGZbuhQ@mail.gmail.com/




--=20
Best Regards,
Yan, Zi

