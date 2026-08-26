Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459FE30C179;
	Wed, 26 Aug 2026 22:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787781761; cv=fail; b=cfJCuS/xrbWOv7ApvUtPHQud+FdqohLKtnJ1TaxmJFPx2UO5EKuWmqLwa42d7R808I6aqqr9CsPUpgCzWppLtlLVtDbLgDTxIqCqhGwHWoCRarUiookY/CJDuD6kmapQ7nlsrfujEzIxHREjgEeiGBS89VpFabbK2NnFqGbLBhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787781761; c=relaxed/simple;
	bh=BnF0AEomnI9ASTUR/AFJNm92NUMpTHEGSkDW5l7VO2o=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:References:
	 In-Reply-To:MIME-Version; b=axWyNSPHQ9fqk5e5bVnsOnYJjAG1613srckcT2464mxXDJZ7M4XiITfixs059mS0gdFLL79L0baP+9jS/OfXWPE3If5XjkJpeZpbVAlKCnalwWDRe2EyaDpxHPhbZA/K1Yq3/JxQv17JnowrlU//OAiUxMryfhtJixBod2QqiO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P1LGlMEy; arc=fail smtp.client-ip=40.107.200.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P1LGlMEy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3eENLuAw9vZ3YaW62DX0UBiaxpzNMaHAbZMG2yRoTUAz8BcLnwX6DoamRDssBBySBJVnx/rfYXlMDJUdN60uAPcSsN8Mu1ikSw5gSVAib55ry828rR164kEpFl42kp8ZFRD21g0qbIIErSKrhcGQl5vfgsoNxZWvS3z7Vyg6w0HctTrNr+diZgRXqWOBfTwWPB7nZVOn8oCWw0k5bQoKdKb7gZmvU6JsZNOvaWGSkgh2Qf/q9mjPoAkLuNQPjyQ1p+ElxpzYpVQP1p3K/NgSW0SVDxGmqTRamcdXOkC4n1pBQmNfC0xRg+IfgmLa7Zlpc60USDiFafvcM17T9F9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwAvnB1W2isvSDRP8aE6X1X2isY9R7l0nl7t6WxuF94=;
 b=eVQu7DrOJk8fSuyO83Ae76wNtzl/lTk2wUYDPjqwmUCIoUT6u/b/YmnbsXBdk4blmNt+IAWUj9oyarvKy/n4mf834xGMjY4j7z32A/VCcCrM9PFQe3zxbXvDVI/XWmQUQbYDh3Erj2tnYO+EAKAlx5dCVnzH2fkxMKIKusxNVGce1m8fuCAvlkco9NnoqO6GiGs4RiUhwwiVsh2HxrimPtaGwEm2epjAPEou6a7Y+8tKT3HxLleQZPiJI0rB1e2uMmMIPvkGliQVu8PKPoePUQ0K+yBwgTL/EDOHR3zFyFcU9HjymISQlNidWOMdI3NdIY8voZjnjxYaHnREqHdU2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwAvnB1W2isvSDRP8aE6X1X2isY9R7l0nl7t6WxuF94=;
 b=P1LGlMEyPYnkp5LTr9S6yFrSTIPAIRaMAfECXhCPVgAvnFS8ZDBg5uNiGFiM5wXCOOj0FtQasQAeVV0ROTDXpNRaS+IEAuwUHIHdc6bG/eeWi0bLURzkvsieQsMkGeCzLapO9qhSUqoHG+zl9yW69Ilb7/1jIYPxt3KF83HEDhRb8TiSK5JUMPedWWqS3aJRFq64cun8W8zM7LxRExq5lOGnZ1SjrdJTwPQjgQtAto9Rn2NcfcwnZldGNBY+wJ8dkBgCGzCCt0qXbmZyeUK8doG+OCgL8bjwTYTTJh49bp3DIZu/S/kAvvXlVNdr8nwOzzk2SviAIq5QdQamEMlPpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SN7PR12MB7881.namprd12.prod.outlook.com (2603:10b6:806:34a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 22:02:35 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 22:02:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 18:02:31 -0400
Message-Id: <DKZ7QMMZPL21.20QCG4B32HCYJ@nvidia.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH] mm/slab: reject unsupported kmalloc sizes
Cc: "Harry Yoo" <harry@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Hao Li" <hao.li@linux.dev>, "Christoph
 Lameter" <cl@gentwo.org>, "David Rientjes" <rientjes@google.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Alan Stern"
 <stern@rowland.harvard.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
 <syzbot+805630f1453e490427fa@syzkaller.appspotmail.com>,
 <stable@vger.kernel.org>
To: "David Laight" <david.laight.linux@gmail.com>, "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260817-limit_kmalloc_size-v1-1-5bef487701cc@nvidia.com>
 <82f138f5-11d4-4839-94a3-c226fd982715@kernel.org>
 <20260826143644.5b3de07a@pumpkin>
In-Reply-To: <20260826143644.5b3de07a@pumpkin>
X-ClientProxiedBy: CY5PR15CA0142.namprd15.prod.outlook.com
 (2603:10b6:930:67::8) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SN7PR12MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: 87213d27-b360-4ede-fa00-08df03bdbc10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|4143699003|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rCirTUjrsDLiRUHqnms1Uz4XylXv5JXlaOZcqbmz6E1nx4VbW6S10iiSppFiLkR+dI1PQSmk1+A8z5osXQ3Zc/Hi2nrBKiqPHM233jbInL6sWnzVu5sbf5Ok2U6p91tIFaJ7ogAsJWgP8qA//NanqO4mxkFdNrGezCZ1ptCzmivGgbiTAyZ+aL7+8YWEvAn2YqdRViDi1t1xOu+P2fiEkii8zn1sRN9pX92L/RQO3dU3+2bG3JItDWahJJjVB7KnM5KmMvlBxcVVilJcSRCuRxr1bg77f0gTZJRMLtBiR+6Xm81QBSGd47eiB268TxOQQLLuz6jxdh+PmHG1C6yBm2mkONtEJBpD7klO14RQwFmvq+NxW9lI+xfIIlBzKB1Yrh0PeuJdC9znXZa/LjrAS6fwF+BT5fj4ygYECuS3DsSCIEp7kzbw+7fmLtWXAQJCp89ZBCieHSQE4YRgTWgnPh1Q/l2AsJ+CCG1SZPtvrYWhLsoSNmtX5f2fcHPsk+2M9x7bB0cmvLoRKU/VMC3RDnAjAHH/3meLpUjctOydD5cJ7cf9AW1He6NVZAME62G58J3SF2vchYWoJiwFnBSj4ZyPg5RsApvEwmiOzEqPU+64TvL+kVQP+i77tZ57FlLgX465aF37xVwGd9V7KBorcoCYhBNWQ24XjtHKboQiqpE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2VxUzNPY2Q1Z0p3Uk9pdm5ERC9OK0s2RDA1NzQ1Zm9HN0VVbnExL2RDcDhS?=
 =?utf-8?B?TjhwUnphdERXRDZqSG55eUZsdUZDU3psdnAwWDJ1bDhnUDVUb2tnTUhaeWhE?=
 =?utf-8?B?cjhWNTczdnpNdm9uMnphTGVEZ0szelkvY3hhcXNjNFNZc0ZuNkJvSTIwS2hq?=
 =?utf-8?B?enVUbnFxTFJzdlorWllxU1gxNXRXMmJaNmJlYzJTWG9PWmh1aUJBOXRnczNV?=
 =?utf-8?B?WTBITnFqcVFWSFBNYm1hRHg5RjZsVC9vZ3hTcnBqeWVQTnhUZTBZNjVFQnJn?=
 =?utf-8?B?MEJ6S2pTbmJkdk5JSktCYlZERTRyazVBMTgxWDhBcWpjNWpmU1lCVGhrdjFL?=
 =?utf-8?B?anIwN2o0L3lrRWgvaU9odk5EK2w2Vk9lWjY3WFZ0U3c0SEtNZkNkT0hZNXk2?=
 =?utf-8?B?dVFLeTNESHhzc1JvNWlST0ZPMW9Ba092RUkyL3RVVGxNKzNrK2hOMzVxbFZu?=
 =?utf-8?B?d2MyNjArNk56QTJYRFlKbm9MeUhVVENlTlg5N3E5VDFkZjNLZG5tb1Y0SHFJ?=
 =?utf-8?B?YTdQdzJMVUlQeE5DemhZVnFHdVlsbjA3ajFoSm1NSDVibEEyWnV3Wjhlalc2?=
 =?utf-8?B?ZlZwQmIrK25SemVNS2JQalRLNW4xVHpMSk5FZVJsVk5zZUdMTmRvSERHRHBk?=
 =?utf-8?B?Z1pWL0hxaDdFUXVVZUZwSmJZblVLU2dGVjZweDg5QUxQM282THNKL2RpSkJV?=
 =?utf-8?B?UlUvQ3QzN0JaS1pSTzBnZ0pyc3d0aFUwS3lub2FGeDQwQ0J1Vlc1Q2FFVFJ6?=
 =?utf-8?B?YWg5VFJ0QjZNTk93ZmtwdlIxOVNUTFl4OHhrYVdWc1NjaTc2WlozYVhDUTJw?=
 =?utf-8?B?VVNMVHZkN3JmbmtzbCtSM1ppbFBrSmRMczJGZU1Kb09PbkdPRHh6RTFxOXA1?=
 =?utf-8?B?YXRoWDBGRENCNGpoU3ErVVpoRk5wOHVPK1NWNVVBZWZxb0h3M2hBcDBSQlM1?=
 =?utf-8?B?dmJFWEdrc1dpT0RTTUZPVnJ6c1dXaHFsQit5M09UMlB3Ymk0dW9nWU1hc29P?=
 =?utf-8?B?N0FyYWFJNGlTUkVZazNsU2p6SDQ5NFNuUkNtVXpJaUNNTzJDMGluWHYzUlVu?=
 =?utf-8?B?Um5YU29CdFlDenN1bWd4TXdHeElQRld2eFpqWFMyOTh5RW8wcE82elJzMGw5?=
 =?utf-8?B?bHVldGxZcER3Mzc3RmVXU0hkTTVMQndhK3o5VEdVaEN6S3VRcGNsUFlaRlpX?=
 =?utf-8?B?NXAzV0FyeDFvMGpIcG9Rd2VyUlV1QkJCdVZ0enZ1SEpZSzhRVVBoZEhYWExh?=
 =?utf-8?B?SGtRbyszRFZvV1Q1bEZkTjl4bXJLZHZsY1RINitpd3VhQVYvUHBxdm1MR1p4?=
 =?utf-8?B?TFc0YWhjUlBpVGZmemtPOXpCalRTOTNsYXpRMGJhYVpUbk9ValRtSXFxcnVl?=
 =?utf-8?B?Y2t3LytxcGdYcW9vSnh1VDUvbEVuUWV5Z2NSZGZNeXdoRDNXSDB4Sk9iQWVs?=
 =?utf-8?B?LzdDSHlVVnNhTlFFcWMvcmFwbTN2V0dmZVV2dGZJWnhSc0lWRGE0UXYydnhF?=
 =?utf-8?B?bXVBem9IWTYySnY2Y083bU1OelB4b1ZmNjJPbDRVdmhyZzc4VUdmaHJJUUFD?=
 =?utf-8?B?ZVNvRU5Zdk50TzBPNWk1V2ZWVFl6RHQzY3pQWENXL0FSMEl1elpVOVFmSTJn?=
 =?utf-8?B?MHRQajFxM3FiUFdiWitJRFdTTmJrT3JJUGdaZWk0bXM3UjI1V3N0MGI0bHkw?=
 =?utf-8?B?YmtIeGE3RkVlLzFKQ3ZmaDZ3SDBSN3dvbFBwRnRhdjBhY29yNm1CeDVFUW1w?=
 =?utf-8?B?OEcvZjIxa1RFZjZOK28yRDVCVVVwY1YrQlVmYXhMaHhrYUMzbFhvbGNwWm91?=
 =?utf-8?B?MXdwdDNtcDZZYXFZalkvMXpKRkpCWjNiVGpxMFFuZWhDT0RCMnJiVk4wM0pQ?=
 =?utf-8?B?WGpnZ1ZKd2R2M2hSSjRjUnVZaVpCME5SckNZN1lqWG9OVFhMOXRxb2tSczkx?=
 =?utf-8?B?UXZIRFNDTUpxUmNTaHlVZ3lmclVpaS9oT09DalFteTlzVFlZVmt0aDZZcEor?=
 =?utf-8?B?YmZnNXdQVkVzU0lWSEh4MWNQdmlSUkxvNHlSRExlVnU4SW93dXNrOUVTVnBv?=
 =?utf-8?B?cUJyZWVNci9aSlRVYXhIL04rTmROaTlqdHN4RGUvUnprelNPYTJvUml6b2pO?=
 =?utf-8?B?a1plVjdSVVB5VFFsaVQzc1pFNzdxSmNsSVlGUW0yZ3YyaUhUZzBORUJQc2xU?=
 =?utf-8?B?VnB4N3FqUWRDMnlnYVM1WCsrRCtmZWNobzg0aGdJdFM4MitYZG94UnVsMXA1?=
 =?utf-8?B?U1o1SUtyMy8wNDRIZG9kTi9RNjFKSDFjeElsaGFrMWpZcFc1d01YSDVodlVR?=
 =?utf-8?Q?fn9+c7vBESz+fyXDFe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87213d27-b360-4ede-fa00-08df03bdbc10
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 22:02:35.0184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnOtxdnyRwQFvjvsIDyQ1ZDKXVplK9Zy57yNePVo50Aj/TRTd6mESL+87kQNCIm7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7881

On Wed Aug 26, 2026 at 9:36 AM EDT, David Laight wrote:
> On Wed, 26 Aug 2026 11:28:12 +0200
> "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:
>
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
rge memory allocations") =20
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
>> then. Thus there would be a useful warning for e.g. development mistakes
>> resulting in the size to be unexpectedly high.

You mean kmalloc should also have this check?

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
>> caller sanitization should still be preferred IMHO.
>
> Indeed, and sanitising the values early on saves all the size_add() and
> size_mult() operations (that are just saturating maths) but still let
> through the 'DoS the system' sizes.

Yes, I am all for santizing inputs.

> Mostly the actual maximum size is actually small. I suspect limits like
> 64k, 1M or 16M would be appropriate.

I agree that the limit you suggested is better. One thing to consider is
that Mike is converting all __get_free_pages() to kmalloc[1], so the
limit might end up to be 2^MAX_PAGE_ORDER, matching the page allocator
limit.

[1] https://lore.kernel.org/all/aip7Y3UHmXsdX8OH@kernel.org/

>
> David
>
>> Some of the recent
>> arguments from Linus [1] would apply to this too, I think.
>>=20
>> [1]
>> https://lore.kernel.org/all/CAHk-=3DwiSmgwwLKCqJwGS-dVHnSLU8W+7q1UQq-G9=
=3DTBGGZbuhQ@mail.gmail.com/
>>=20
>> > ---
>> >  mm/slub.c | 7 ++++++-
>> >  1 file changed, 6 insertions(+), 1 deletion(-)
>> >=20
>> > diff --git a/mm/slub.c b/mm/slub.c
>> > index 0337e60db5ace..a3071f4ef1945 100644
>> > --- a/mm/slub.c
>> > +++ b/mm/slub.c
>> > @@ -5263,7 +5263,12 @@ static void *___kmalloc_large_node(size_t size,=
 gfp_t flags, int node)
>> >  {
>> >  	struct page *page;
>> >  	void *ptr =3D NULL;
>> > -	unsigned int order =3D get_order(size);
>> > +	unsigned int order;
>> > +
>> > +	if (size > KMALLOC_MAX_SIZE)
>> > +		return NULL;
>> > +
>> > +	order =3D get_order(size);
>> > =20
>> >  	if (unlikely(flags & GFP_SLAB_BUG_MASK))
>> >  		flags =3D kmalloc_fix_flags(flags);
>> >=20
>> > ---
>> > base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
>> > change-id: 20260817-limit_kmalloc_size-3a4a2c73beac
>> >=20
>> > Best regards,
>> > -- =20
>> > Yan, Zi
>> >  =20
>>=20
>>=20




--=20
Best Regards,
Yan, Zi

