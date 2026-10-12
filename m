Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64811495AE8;
	Mon, 12 Oct 2026 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818290; cv=fail; b=Z5LxOfVJYjaE+VrHtGde06o6bJHNCA+O1+BppbsYUFasLwwH2+bTqZvf8ri4Aowl3jWBoFT4gT+MIxBsBMIkuOEBYx0WI2WnLD052Rw2PdzYxsNdRJWV9T0Vch3o+bHpPjxfUqf2NpJXBwn5kZVLaoslhIfhqzVDErO+2MjOe5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818290; c=relaxed/simple;
	bh=ibDalwfQLeTeyXDA8+mqh3tG9vSh/yyITVw2RO/FZVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rAtA0gtOpiDgEaa2QnwyuyW0AjLErBAQrTsqQf0D5VxwJ2aMVE1rkPGHXjlz5ld9dMWhXAQy9fDpAnYgwKty0XYCRKvDW+0J+Ctxz2dMliFuYFblOHfHw1pg00sQJCipaodbo5wdYLTGWuqzThcxn/LiNdxWEloTb2aEkJkTGgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rIcn8Q7Q; arc=fail smtp.client-ip=52.101.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rIcn8Q7Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDVULdtWbgSbTof65O3qcHErR+2Je+4+jUxQl3J8sjf/9k29TC9QGk7oa/JOw0ALZo3+TqHE0op5ENvwPo/LuO/HkTOZZIfeR9ESJJFcvJ+DJBFLWhpv93T57ZJp/+wqmjxSVqIGYvCLpRQ8KFYuGOSBQrsriTFAe3z6jgPp66/THyZGwxyIiZUmFRWlKANBaLg9oGnrNYMY5GGjlHWrHqzgQIbswaxaDsWT2m+kcjPWRpFlweDhMddjVJps1pqRORpH4yJG23nUUyWDRX7JiF/u2Gj0U+JhjwDA0j4IE6OotYOU1ipQZyGqWRwtxCfvj1h+GBNjTZX+AvW+Khk5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJ0oVSVX43KAQoD0odvHiSY5dJqkZ7dtIiSMksbG/gE=;
 b=eeGpIFoDcqQabO6QeAtytO6oxJJgbqzMT2LUNrCfL2qx3pEyORB+tMtY/6NxqIn0yI9wLcAPz/Ti3soRGYJX3GGVhs0P57FBTN57rbraByT/E8oQjlVFiiOudvtVUBfxkUrXdlRwFtfPN//mfZs0+iNkJGWBMooSKZpkrWL7SD/Fm3O1q1EDspAef+SSDmKnY+D3e4z1MzIns3QfzQJCz9ZyyVYN9i/lBdglODPJpNAWrMkjVfgi2Z8AsGrR0tZlNkbf0Crg1AG9wob7zuW/dHQe8tW/uOht0WMsPScCMHfGclQwF7WvTiDECDwudYndK6zkD/O7P+GMnAp0fWxElA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ0oVSVX43KAQoD0odvHiSY5dJqkZ7dtIiSMksbG/gE=;
 b=rIcn8Q7QqksdSWeVixEtidE/TlGvx3HWk9fPNYgAB8CBhq2OepWwsz36I4Qt6qQTbz9W2aQdJgIhfcT9TpsXuhECzMCAYC9SLtCpF4KmvStkfzE7+GbZPCuDPOjoYNLDdio08Pqkgz+tje7BBIqQNtI19M62851Yc4oS3OBIXAMZnHah+Gi9yCqwbKDigx19EvtR1ELOonPlW2ztFQZSxLCFq/mvcIuc3NNsNmU/WuDBMFrfnjAe8dbutKYVUn9tyeP76W+UyiV4jT4g4Vxg7HNKrfFbc4MP8R4o5ZZahWIatdQHnShA79QdMEFWhuheM28J3hCEF/dFxm3Ccai/nA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 15:18:02 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0472.016; Mon, 12 Oct 2026
 15:18:02 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org,
 liam@infradead.org, vbabka@kernel.org, jannh@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: keep the hardware dirty bit in MADV_COLD's
 THP path
Date: Mon, 12 Oct 2026 11:17:57 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <D964ECBC-59B6-4A4B-83D5-935EA2D06D30@nvidia.com>
In-Reply-To: <asy4c7zkkmSRln1H@gremlin>
References: <20261011132227.413217-1-samarth.colleges@gmail.com>
 <42087cd7-473e-40a7-ae63-3c841c615c8f@kernel.org> <asyy7Nwik5yMTNbo@gremlin>
 <asy4c7zkkmSRln1H@gremlin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: SJ0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::15) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5d4950-0156-4e5a-b614-08df287401bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|5023799004|4143699003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	T20sQ4NLFTYFQAEbEe5JVEykWA8pP+fteS+3SEqMLBDlMGLnt4T7B8FvLaCUxPfng7kR7HOfm4FON6FDGerYHpCnkXq3sGqUz3YXtc5/q3QHIupbR3dEuXXSQCwpt7G7fqg8rl9IXYwwPK0QqcvxAB6DM4HR6oIfNGtpdp4oUmHqsc+JMZUzdi1pGcH4rHlHX26iY27KIcgDSa955bpwF7lMUgM861NqCA4W1xO/FTATun1mpnF3gRDI7CNWhlVMVMR50zzBylzs8RtYPUphZHg5XNJ+Cc5xcY5hApRr15G0WOdD5yjK5l2czIA4KLwH+cEkPlTw3bEiXGJ2M1mgrfMPSksrGJEJ/QgsYxA0VcgnR0GefLzqgZDGxOZKeJJnUizYb2adCTp5IMvVuCDwPY2fen9qwvrwVVJUibGjjfjKgLht46yVq6ck9QslxQOSSuR5xyZ7JjyfaXxe74gqpPXjDgdIICJYdJfXmlxinD8T2DC2JS6qkNXLW//JA9lUUBIFH1W00Dxfa3/B9umVW3v/mMaUfpMKivmrIq9oYlhbuUMNkoxlTosiMQsd45pfgHUBbbWCqawLDqCWiwQqU7rhqqiguDLUIVLVCBYrwo52oNWJKwCmC/8BYdyj+NwAhEekJuJUa6fYOTNf85fnybQastbK4MTgGmgifg03Hg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(5023799004)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGVKaktlWGNac2gwNGJCWDFlL3BXUkFlN1FVOTVQNGI5bktnSWRFTUpseWNZ?=
 =?utf-8?B?enBLQkVaTkNNcTNpazFhbjBJeENORzhzdkV0aXRHUEZCUGp5eFMzMXZwdWpz?=
 =?utf-8?B?VFozcGw4Z1hUVllkclhaSjY0bS9FVmJEUEhuMDY2NWRlZVYvNmttYjE0MHVG?=
 =?utf-8?B?dGI0RkFRdy9HVG4wN0l5d3ppNjlsZTJWR2RVRTVEcWxwM21pTVNoRDE4dlFC?=
 =?utf-8?B?VnFTdFVLSXI2bHQ3ODBUbE9pQXYwTmgwNFhlZWdXSlFDYXVFQmw3cTRoUnN6?=
 =?utf-8?B?U29tWDU0TXA3ajJGNzd6c3RjTjVBeU5WZmhHZnVPR1ZyMldCbm0wbzZRdGZt?=
 =?utf-8?B?a25HSVhhaTc2ZUJaQXlkc1BHTEc5MDBiSVJzRjZtZlEyM0ZNcXI5TEpQYjRR?=
 =?utf-8?B?UEZ1c0Z5Skh6R0Z2STU3ckN3UVF5ZGRVOWFUaUdKQllFaGF2U05UczFra2lV?=
 =?utf-8?B?Mk92VEV2WmRxQS92SE9kdnhSSjlLKytxQjFoTG1YRUZJV3NWK1RSSU5UdkxE?=
 =?utf-8?B?amthdXZKYzlEUFdSc05zdzNvUzFKSzFMakhRU24rRTh4S29hWnlXOE9JMmNO?=
 =?utf-8?B?Q1BFaG9jcldNMk40TnEyZllFV2lNZGNhWUdkTFV2MFI5Z3dZbDIrOWJ3aUIv?=
 =?utf-8?B?d1QwS3YzNVUrZGpaMnAxSjZVVmZ1S0Q2eXZXRlMxQmMvWVJaQmFYTytXMTc4?=
 =?utf-8?B?ejh6bk1XY05od3RaSnpkTmsvUnVlbnRHQ0Y3ODhCbm4xV2FSN3lycWdEWXRs?=
 =?utf-8?B?TzRIN1lsUFBhbzFIcHZtbzNyaDRqcmtaaWdpcy9ZTzdCZWtjcm5Rbnl3SElE?=
 =?utf-8?B?dEVmOUlRVzdrSk1nRDBJVDV5Y3B5VW9zVTVBL1lOaUgzeHRudlg0aDZ1UWhP?=
 =?utf-8?B?a0wxSW5YZExkZmtMRE9mMlkybWtzeDVnQmM1b21RNS9nQzhpVk0wTkdWMmlX?=
 =?utf-8?B?SmVWd3AzVWVjYkZISlBpSXEvR0xVckxIQ0t1TnlHMnpBK1k2N3J3S1RocFRq?=
 =?utf-8?B?NitXZWl3amczYmVGVnlKQnkvUnMzS084UTgzSTBsTU5xMHpydU9RelZpQ0dI?=
 =?utf-8?B?Q04vMHV6bTBSRk9KcEMrV1hpWGt0QmcydmJtem9RQ0tVUXRPNGNHMUZqR3h2?=
 =?utf-8?B?N29KTCtTb2hwQmRGalJ6RE1weXdjR0JWWGNDOEFrandoeHlRZDNSRjIyanQz?=
 =?utf-8?B?NlJaYXJJcHhaZWVxS29vSUs1dnR6TnNNcmRQcE94a3N0ZGtGc0p5Zlo1S1gv?=
 =?utf-8?B?Y09oTnp1djRyeDlWaTRGbUoxZE9NNTd0OEYvdXdNUk41NDJMQm81SXBML2hT?=
 =?utf-8?B?ejdJQ1BoRVlQeU9MbWZCL2xKS055Y0dEdkN3T3RyQzhtSWlSNjY3MEZVVDV6?=
 =?utf-8?B?WXlCK3Q5QzZEMkp3UUROOXM1OHp5Y3VDdmQ0Ti9oc2pNcnNQNUJ5eDc5NmNr?=
 =?utf-8?B?Qm9CWG54V016L3RRM3RBTjBnZWwwM2lwcHVKMSs3M0YzYlkyLy82Nnp4YWo4?=
 =?utf-8?B?VTlRSnhLTFJwb3ZxeXAzVjVuYWlYSVNmK2I1SHVvU0tTMUVsVnpCTGhFZE9j?=
 =?utf-8?B?RkxoZXRGL1QxYlQzdG1DVFo5NzJYTUJYUWZYUzdOY0xpVXRlYWY2YzVidXRv?=
 =?utf-8?B?MHYxY2hXKzNPMDFDOUN5SzZVR2dETHdyQzNScVJtMTlMRlA5YXBoNWpsQzBT?=
 =?utf-8?B?WC9qRVRwemtEZEFwRGtSVEdMRys3clcwVC9tSytvYmh2MUk0YTdrWkp4enlz?=
 =?utf-8?B?UXNmL0ZLRk5XS0locjhpYlE2NkI1UFJJbG5BMWFuNmdibGdTS2ZKT1RxVDVl?=
 =?utf-8?B?KzJnMXVzd2ZZVEpzVnRMdWcwT3o0aUZueE5XNzFBTzg3dFNNdzRCZ1ROcHRB?=
 =?utf-8?B?ajNzZzJRVU1rZFk5ZjlsU25SNEZiYmNxMTlSQ1Npa05FMWVUMGNURFh6RHJB?=
 =?utf-8?B?cTA3RVdZenJlOGlqMEt6OXZzazYxQ2FYbzRBWHpaNUFJY2FaWG1HWXBBRjBh?=
 =?utf-8?B?aGphcnhTZnoyTnhTK1FoNjJyajZUUHU3VFQwRHJiK04vTk5qOWtlRDZmcjdR?=
 =?utf-8?B?alFtUVZLSU5OL0JpakYxUTM0UHp5QkpzY3JvUDRZTFhlSllQYUFrK08rOWRQ?=
 =?utf-8?B?Y1FPbngza2NkRVZLazZ3OHRmc3ducXpmekc2SUtMdHVxNk8wdk55bVppS2xD?=
 =?utf-8?B?R1M5aUdPZTBsclB1Vjh4bW1Bd0lVWGg3Qk1vK3JoRFEzZlJoejdFRjNLQ09U?=
 =?utf-8?B?OGhIbzkrbWNKMXBlQTA1dVZPRFVsakw1STV3WU9wWGlRemFTd2JzN3FKOSs5?=
 =?utf-8?Q?gaJ/zOfbtLkZL0N1TS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5d4950-0156-4e5a-b614-08df287401bc
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 15:18:02.1215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZeGEKS6bkci4+mLm53LEPEs9yG8/ZY+Js4OHHiNqR1u82oli21AFh2mh3gDBDMoc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479

On 12 Oct 2026, at 6:38, Lorenzo Stoakes (ARM) wrote:

> +cc Zi
>
> On Mon, Oct 12, 2026 at 11:33:48AM +0100, Lorenzo Stoakes (ARM) wrote:
>> -cc slopper.
>>
>> On Mon, Oct 12, 2026 at 12:09:07PM +0200, David Hildenbrand (Arm) wrote:
>>> On 10/11/26 15:22, samarth.colleges@gmail.com wrote:
>>
>>>> diff --git a/mm/madvise.c b/mm/madvise.c
>>>> --- a/mm/madvise.c
>>>> +++ b/mm/madvise.c
>>>> @@ -426,8 +426,14 @@
>>>>  		}
>>>>
>>>>  		if (!pageout && pmd_young(orig_pmd)) {
>>>> -			pmdp_invalidate(vma, addr, pmd);
>>>> -			orig_pmd =3D pmd_mkold(orig_pmd);
>>>> +			/*
>>>> +			 * Rebuild from the entry pmdp_invalidate() exchanged
>>>> +			 * out, not from orig_pmd: hardware may have set the
>>>> +			 * dirty bit since orig_pmd was read, and a MADV_FREE'd
>>>> +			 * (lazyfree) THP whose dirty bit is lost is discarded
>>>> +			 * by reclaim, silently dropping the store.
>>>> +			 */
>>>> +			orig_pmd =3D pmd_mkold(pmdp_invalidate(vma, addr, pmd));
>>>
>>> Okay, you are saying we can lose the dirty bit that could get set concu=
rrently.
>>> And if we did an MADV_FREE before, we might not detect that the content=
 was changed.
>>
>> Yeah, lazyfree -> write means you don't actually free it.
>>
>> As per the manpage:
>>
>> 	For each of the pages that has been marked to be freed but has not yet
>> 	been freed, the free operation will be canceled if the caller writes
>> 	into the page.
>>
>> This is anon memory only:
>>
>> 	The MADV_FREE operation can be applied only to private anonymous
>> 	pages (see mmap(2)).
>>
>>>
>>>
>>> I suspect this found through the help of an LLM and not an actual use c=
ase in
>>> practice?
>>
>> Seems very likely.
>>
>>>
>>> Using MADV_COLD following MADV_FREE sounds odd at thirst. In particular=
, when
>>> having MADV_COLD race with actual access.
>>
>> It's odd to MADV_FREE (lazyfree) then MADV_COLD (deactivate) yes,
>> especially with racing accesses.
>>
>> I wonder if there are other cases where you could get weird races like
>> this...
>>
>> In any case it seems a really hard thing to hit in reality. But I think =
we
>> probably need to fix this because of the stated contract of MADV_FREE.
>>
>> I think probably we shouldn't have added that contract...
>>
>>>
>>> On the PTE path we use clear_young_dirty_ptes(CYDP_CLEAR_YOUNG) which a=
chieves
>>> the same through ptep_test_and_clear_young().
>>>
>>>
>>> ... where we also just do a
>>>
>>> pte =3D ptep_get(ptep);
>>> set_pte_at(vma->vm_mm, address, ptep, pte_mkold(pte));
>>>
>>> in the generic variant and rely on the per-arch variant to do the right=
 thing.
>>>
>>> Which makes me wonder whether we should actually have per-architecture =
PMD
>>> helpers for that purpose?
>>
>> Is it achieving the same thing? There's an invalidation here also.
>>
>> pmdp_establish() is used to install a pmd_mkinvalid() entry and there's =
a
>> flush_pmd_tlb_range().
>>
>> --
>> Cheers, Lorenzo
>
> OK, isn't this all moot with Zi's patch? [0]
>
> [0]: https://lore.kernel.org/linux-mm/20261009-lazyfree-stable-fix-v1-1-7=
0997958ef8d@nvidia.com

No. Without lazyfree PMD level THP discard, the affect PMD will be split
into PTEs without dirty bit and the dirty folio is still discarded.

We will need Samarth=E2=80=99s fix for backport, then we can think carefull=
y
about David=E2=80=99s per-arch solution for mainline.

Best Regards,
Yan, Zi
