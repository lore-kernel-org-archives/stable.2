Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004B5423EB7;
	Mon, 12 Oct 2026 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837469; cv=fail; b=iuT3cjLQFHCKxzRaBUtIKLToSxpNJBCSFW1XNTwD/S2tX4KSRFNi8CVv6VM1n6Jfjut8T978+dZ+pFfeU8gM1O3yO8wC4WxNMMhafy3GOhkJAOnwo/SGAHuiVeh9TMaqenGkQFq7R/uF1nGoyLtsvyo6gXPWM2LTsMXTlXkeq0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837469; c=relaxed/simple;
	bh=UEhCoh5ZUR1SRAbpcGIedOzjEq+MwHKNBfZg4yNjPAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nHJGH8NX/oI7k1h1rhKkjLpET4oFu2IFvWldzyZP7Z26RdQL9WcvniGrcrUwFpnp2SSMuU8y4xsq1w91BhyL8mOuI7TGp+fTlU064c7Rccby3sNRRemuYNq59pzzA1gQyA0wXApeqac+aeyIhp0uv8XtchyOyzUjYrrrM5XiNtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JSavad2i; arc=fail smtp.client-ip=52.101.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JSavad2i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlR2QLnfEsMq8hXtZGkRjE/KygAyJNaJyLMxh0uEklONIdRpT4SMj6wIG5L7OZH6h9CP55MMbQ8Qrk3AVaL0FymghwlKMQU88LhrANJ/5fppFbtKRpLt00nzwVhEsAZbTx+33ooyDjDHQYeiWgGQhXJI2tmvu7DAbbmv871Ro6JDpSKLDJ16IX3UoU8a3LqBQPVUvsKc+IicyhKh8JAgKPR+pwMw6VKm2VZz3dZqFGme7HgqrLSyYB9lZpgyvtWiA3PDpVdubCYmuB5uSbEHCHXHjgtvVrSKxMdU2h4W4EDXkew/OqOx76s2vt2TLGbsDP6BptDlr6NwxQZIpdc8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNEl6AGkNNzFNCqeV5FE/xOl3ZVzOveD8wL+aGT/yQg=;
 b=pyEQA0YcMNUdWU4xw/S3VkwpNPq8SBAydUioR1O2sBtg8aMOw+oiGCTzzVmzuJmKXjcNBH8y+ldIqITfMBB+v+N88g//VRqWUGQQJSpUhuVVr+H+SqVuXD+rvOdGp98qjOPpXvxZ0uzhSIZCWhf6dVWNafp4kbjsPpPnGmTgxa+hPSbh1kFcwhAwHAdTc735t1SwmQijgHeVIdMV3Q/EzU26UH/B1WDZ/9coqvghNOQKbjeBSGURpAVI126I+yGtEwQAcP1XTRTCyJ6WHDsJBo+ahvISkrSJlMw6Pw/56mKMgSjc/CIqIPVmqlLUWFJruunj9mqWio0R7X0K0zpSTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNEl6AGkNNzFNCqeV5FE/xOl3ZVzOveD8wL+aGT/yQg=;
 b=JSavad2icHVT5ufBTBccBs+ymj/RhIqroqzIptHhvq0fqQ0+0/LCAsDvHya1Xn/roOnc1OKQRdZ3QzzjdqR1QH8sYr2LQVK7iMyCaO0W3h46apsr07ajSwX04tPGXxlAkt3zqlvFumeCrlPpabdR8pevYDlECIgZc4VZABZuXDkoxrOxdDpTxsnFKgqJ0qgVlMkmI4foYfcAkQ8DdDfHruIc9dduvC5v1njWwJXIxYTU2XFELQBGO6TqDhUAi1JP5KSOTECRQ2tZV277ymSQalkUvghQOj3Oqh5wog92lW3TRzD0PqcxDqVXbn7Z+55Nd9iLFxTVblHpIU03eImcOA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 12 Oct
 2026 20:37:39 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0472.016; Mon, 12 Oct 2026
 20:37:39 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Rik van Riel <riel@surriel.com>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
 Lance Yang <lance.yang@linux.dev>, Kyle Zeng <kylebot@openai.com>,
 stable@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: don't discard lazyfree THPs at PMD level
Date: Mon, 12 Oct 2026 16:37:34 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <9CC1C4F0-1C73-4AA4-8D1C-28DB024E2221@nvidia.com>
In-Reply-To: <asz2domYFnTe2owf@gremlin>
References: <20261009-lazyfree-stable-fix-v1-1-70997958ef8d@nvidia.com>
 <asy445BYRhcsGDE9@gremlin> <8B17F897-40BE-4834-8078-949DA951B46F@nvidia.com>
 <asz2domYFnTe2owf@gremlin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: PH8PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::10) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|PH7PR12MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: cf119431-7d9f-4af5-0740-08df28a0a820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|5023799004|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	CoYg9uNv5BsijXPkcPqWW7PdMhJ1zp6RsVqaQY+abCDY6iEjlH3sdrjcCkXTya2OufrmPgT+5mVkana2rdGxaXOvAEgmJd6TnXN6hZ5t50p2A/NIhOuJvp69m70cBMeQCCnUH0kf4BoopS7CG30S5NDMM4nRX/+SG7ajdHUgikpcFrN6pNod7bj1KsRmbt3/HfsvfOVvvkeyRA/3RVsWRu7Xmt8OcwAhzShHA6wN+T6tT1k8uUr2JgizTN0KQCWIy41I8TOb0wjUwijkHicLugbEWzE+xKIItwXKUZbDSc3nf0WgVEpZr3dSd6lvzQA8GinEczYsNIddOc+mkCAXz+0iwEx/OqJvCbaFZHfWYF2rKfYx8gD5xvwamdPmy5+QQ8zBQraItTtNrhrRqXfc+/PmLWkbGuXeRRBzhlDyrm0kDiPsU/vlHBg8+rl7Fn84k0aQM5TvRc1OnmJUFnVPguijXh3f5MX1f6EUYDNwNvXHpfTbGMyN+1K/5oqIe931db2MQ3cVQrgMmnfx+CV+w1rliKSW8eCr0qiVFsm6VL1iwoUU0ybxhgv8MJu5Jof/JS8me99bwt737c4SE+eUz+Nv6G3fhlt7aZIAXD+f+giBEMpXcHdUV1dfA5+uPnfSLod9nIQdhOROaNBcyOckLkZm4PzmZHPtnpZ9K8tq8n8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(5023799004)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3RWdVl0ZDVjcjU3ZTRVNnBaMWxmY3Q1dGNUbTdVR0JJOWFXQWNPbmMzUFFk?=
 =?utf-8?B?YVJtQ2FkcG9QdGw5cmlvVllhdVlIdDdQTGRtejNDTXYvUUdLSENPNW5GMUlm?=
 =?utf-8?B?QmFKbXdpc2pjWGdLbmJXSlhWTDk4NkVhSE5keVkrbEtuRDZENE1xR2JaSVgz?=
 =?utf-8?B?UmUyNjZoNGdCRm9BS0xXbjk1cnErSUtUN29nWi8zMC9ZY2pFZWZ1YXN5Qmt4?=
 =?utf-8?B?K1VwVHh5Y3MrcTRBZEkwcFJrU0czQ2lnRHVaNzlQZCtmczNSN3RQQ3NPbDZa?=
 =?utf-8?B?SDI1ZjY2cGhPNG41NEw4aDBOKzlNdGUrMjM4b0QzWWkxTXdmWFgxYWszSHB0?=
 =?utf-8?B?ZmZlTDhSYis2RVpVSUpFWWwyWlp2RElRR0Iwc0kxcGJqdms3V1RIN2RQazVj?=
 =?utf-8?B?RUw3bURxeUlTdWE0WUFsSkZJODZ3UExTS1dXaEZERXVEUmRQZ1ROQ3p5Q05V?=
 =?utf-8?B?ZGtPWW52NFhyOThjUkNnVWRMTmMvYWlQTU9YeEhldUszVk50MHBRT0cxUTgz?=
 =?utf-8?B?cTZ4Mk4yUU5BTkxxQ0ZMUVlRNVV6d0NqMTZHYTNuNlMvQ2R1TERuTVNMNlZp?=
 =?utf-8?B?VUYyckV3bVpMYVVybmttbWpqV1BTemFEVUhNOW1hNjEyRHYrWng0Nk9RYi9Y?=
 =?utf-8?B?OEhEeTQ2dVFBTi9MZU8rRUNHd2xWYVRPS1QwTGpOY3JNMVRHNE9VWCtWQkl1?=
 =?utf-8?B?QUJpbU9wcnpqOWcxay9uMWRLTHVCamZVWDFlVWhNUVZwVWxydkhGakdGYVlp?=
 =?utf-8?B?ZVdkRkF3MkVFdkxja2I4bXpvTlh1TEdJYUFxRkRmc1Erd29hdm9HbFJKaHh0?=
 =?utf-8?B?Y3AvdDk3ZC9NWllibTZqTmg0RlVMQ2FkR2tsMDZrVHNaZ0E2VUVZdGx2UXpI?=
 =?utf-8?B?alNHZlh0bDdHQURJMFVKWGFmNktmbmtkNzk1UlBJejN4WjlxTkxPdmt4ckZP?=
 =?utf-8?B?WFhTcy9TR25MOU0xditQbGtZTy82UTFsbndNNFFycFVPQXlNVU9kMTY3eGV6?=
 =?utf-8?B?Um9qY1VHdHdjdWN4b3dONDhYQ0Y0dlkzZFFTQUtDeFJHdjZWVnlTYUFlOUEx?=
 =?utf-8?B?eldseUxheGs2OTdWNThxWmpvNDFjMlQ2Q0RUT1VyU01GWnFCMUpFaERidy9N?=
 =?utf-8?B?NmpvNUpZZHo4V2tiQUhQMVdQOHZmOW9IRVpQRUl5QTB1ZVZDLy9IWGE5RmlK?=
 =?utf-8?B?cHF0Nm9qTXRIYmp4VnBqek5nbnpoendjVnNZVWR2dTd5RzhWVzYxRWxUSjlq?=
 =?utf-8?B?MGZKRENMS1ZNN0ZZOUxtYW1kTDV0aVF3Smd2Q0FsZ3pwUkY1QlMreDNqMDZM?=
 =?utf-8?B?YlNnMnBIYTN3QUJSSjUvYUQ2c1JQcCtBZklrcUpsemcvYkR4SUpoT2MySW4z?=
 =?utf-8?B?RlNFaTMxaDdTVEtWMWtBcG52QjNoSDFlQ3YrL0NzNW5qNlZuSTRqbi9wek5O?=
 =?utf-8?B?eEozN0YvN05TZzcwRHpRQjZtU2JueDhSNi9KMCtidWZmamRzd2FDLzVzTHFn?=
 =?utf-8?B?QUtIN1AyREtwN3dFOUp1Sk5FK2dISVhuSFd5ZmprS01lbVhMZFc3SFhUNnVF?=
 =?utf-8?B?ek4wNjFxdERaWkZFVnNMSlFXL0xNZXRMd0NYWUY2SEZWd1Z4Z2E3ZnBiRUFq?=
 =?utf-8?B?TGh6dzJ6N2N0R0RreFVTdjFBUS9RL2hFckxMZENXRFVNV09HSTFMZzYxUmdj?=
 =?utf-8?B?d1k3T2oya05MRnRsSjFXeVFpZGc2dXlwalBmVjZvQ1ZNTnNRNlY0UFV3Z1Nk?=
 =?utf-8?B?Qm5hczFqaVk5WXhteCtxM2FSa3VPVFVJT0lsbGZ4c2hXRVdHUzdHQnI1Wmh5?=
 =?utf-8?B?YXpEaUkvNkZJOHZiK1JZa0xwcCt4dVhpQkZmUXU1Y1NVemhHUnZGd0dNK1Fn?=
 =?utf-8?B?WG1VVVdrVUNiSzlaMElIMndLQXprdjFBOEh1UWlpWUdUdER6Smtzc2lEVmdE?=
 =?utf-8?B?SzRWUm9CS2k2T3Z0c212eWlwZHl5RThtM3I5ZDJOK3FaMDFMNDJoYzM4TEl0?=
 =?utf-8?B?OEk5VkszVmdZbGdYWmhQaCt1ZEM1VW9rZUU1Q0R1eW1kc3p1b2NOZ0FaditJ?=
 =?utf-8?B?OWtpWTlNdXBYbGdLRlRCbXh3ZXA2czN2VGlwandseTZVRjMvVmQvWGZKZE1C?=
 =?utf-8?B?SEVPV1A1V3RXQkdISEQ1YXBReTE3YnFHUUZCNkxLUjk3Vkk0RFh6Y1ByRldV?=
 =?utf-8?B?WGVNejFBMXl3OWV0WDF2d0wxQlBJbW5aVEJGL0hrRlpOcG8xSThDYjdINmhs?=
 =?utf-8?B?K2tLYVByUlczV3hZZnNZUWVNRzMyWjdvR0NpQzlZT3NGa2tZbkx4dU5Samhn?=
 =?utf-8?Q?9dvhXCMR4Vk461uXf1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf119431-7d9f-4af5-0740-08df28a0a820
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 20:37:39.2222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyiWLDCccecziGMOrJmsOcc7HMdEEsujM6d/ObUBhDsbgH20+kZDaagYtZzSAxJC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7937

On 12 Oct 2026, at 11:22, Lorenzo Stoakes (ARM) wrote:

> On Mon, Oct 12, 2026 at 10:33:34AM -0400, Zi Yan wrote:
>>> Looking at the code:
>>>
>>> <anon_vma lock>
>>> [reclaim]
>>> < PMD lock >
>>> -> try_to_unmap_one()
>>>     -> unmap_huge_pmd_locked()
>>>       -> __discard_anon_folio_pmd_locked()
>>>         [ clears PMD entry ]
>>
>> The PMD becomes pmd_none().
>
> Yup.
>
>>
>>> 	...
>>
>> There are two readers making decisions based on =E2=80=9Cpmd_none()=E2=
=80=9D locklessly:
>>
>> 1. munmap case is via zap_pmd_range() in mm/memory.c: it skips pmd_none(=
),
>> so the above folio is not zapped;
>
> Yup I get at that below.
>
> It also doesn't serialise on the PMD lock as a result.
>
> That's really key isn't it?
>
> 		if (pmd_is_huge(*pmd)) { 				<- returns false
> 			if (next - addr !=3D HPAGE_PMD_SIZE)
> 				__split_huge_pmd(vma, pmd, addr, false);
> 			else if (zap_huge_pmd(tlb, vma, pmd, addr)) {	<- doesn't lock the PMD
> 				addr =3D next;
> 				continue;
> 			}
>
> So it skips it and nothing happens to the PMD nor is there any serialisat=
ion
> between unmap_huge_pmd_locked() and this code.

Right.

>
> try_to_unmap_one() will be called under the PMD lock because of this In
> page_vma_mapped_walk(), I believe:
>
> bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> {
> 	...
> 		if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> 		    (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
> 		    pmd_is_device_private_entry(pmde))) {
> 			pvmw->ptl =3D pmd_lock(mm, pvmw->pmd);
> 			...
> 			if (likely(pmd_trans_huge(pmde))) {
> 				...
> 				return true;
> 			}
> 			...
> 		}
> 	...
> }

Yes.

My wording was not precise.

zap_pmd_range() doesn=E2=80=99t take the PTL since it sees pmd_none(), whil=
e
try_to_unmap_one() takes the PTL.

>
>>
>> 2. MREMAP_DONTUNMAP case is via move_page_tables() in mm/mremap.c calls
>> get_old_pmd(): get_old_pmd() returns NULL for pmd_none(),
>> so move_page_tables() skips the above folio.
>
> move_page_tables() is called for _all_ mremap() operations. So the same i=
ssue
> would occur across mremap().
>
> That bit isn't special to MREMAP_DONTUNMAP.

Right.


>
>>
>>> 	[ reinstates PMD entry later ]
>>
>>
>> 1. for munmap, unmap_region() calls free_pgtables(). In free_pmd_range()=
,
>> the restored PMD is treated as pmd_bad() and cleared. And the folio=E2=
=80=99s
>> rmap is not removed.
>
> Yup I got to that point below :)
>
>>
>> 2. for meremap, dontunmap_complete() unlinks anon_vma but the source VMA
>> still maps the folio.
>
> Well, only if the set_pmd_at() managed to reinstall it AND the PUD page t=
able
> that mapped it still exists.
>
> That set pmd could also UAF on the PMD page table in theory couldn't it?

No, in __discard_anon_folio_pmd_locked(), the caller holds anon_vma read lo=
ck;
when mremap() or munmap() calls free_pgtables() to get rid of page tables,
they first call unlink_anon_vmas() and get blocked by the aforementioned re=
ad
lock. set_pmd_at() is called while free_pgtables() is blocked, so no UAF he=
re.

>
> It's all really horrible.

And kills my brain.

>
>>
>>>
>>> Concurrent munmap():
>>>
>>> <mmap write lock, downgraded to mmap read lock later>
>>> do_vmi_align_munmap()
>>>   -> vms_complete_munmap_vmas()
>>>     -> vms_clear_ptes()
>>>       -> unmap_region()
>>>         -> unmap_vmas() < zaps > <----- EDIT: the real issue, see below
>>> 	-> free_pgtables()
>>> 	   -> unlink_anon_vmas()
>>> 	     -> < anon_vma lock taken! >
>>> 	   ... clears down page tables (no rmap lock) ...
>>>
>>> Is the issue actually the zapping in unmap_vmas(), which doesn't seem t=
o be
>>> protected by rmap lock at all, meaning that _that_ can happen with
>>> concurrent munmap()?
>>
>> No. zap and rmap walkers are serialized by PTL. The reason is described =
above.
>>
>
> Well, no, that's not quite right AFAICT - as above the PMD PTL _is not ta=
ken_
> because the PMD entry is cleared.
>
> So the serialisation that would otherwise exist between the try_to_unmap_=
one()
> and zap_pmd_range() doesn't happen.
>
>>>
>>> So unmap_vmas() doesn't correctly populate the mmu_gather struct for th=
e
>>> range, meaning that the underlying page isn't freed and the refcount,
>>> mapcount etc. are all left as they were?
>>
>> Yes to the underlying page isn=E2=80=99t freed.
>
> The refcount and mapcount etc. would be correct? I think the refcount wou=
ld be
> such that it permanently leaks and the mapcount would be incorrect or onl=
y
> accidentally correct?

refcount and mapcount would be wrong in the munmap case. Both are correct
in MREMAP_DONTUNMAP case, since the folio is still mapped in the source VMA
but its anon_vma says it belongs to dst VMA. When dst VMA is unmapped,
the anon_vma is freed, but the folio is still mapped and its ->mapping
points to a freed anon_vma. A rmap code checking folio->mapping is a UAF.


>
>>
>>>
>>> MREMAP_DONTUNMAP seems a bit of a bizarre callout, but I suppose it is =
the
>>> other case in which (under certain, likely, circumstances
>>> e.g. non-partial/self-merging remap) an unlink_anon_vmas()'s call is do=
ne.
>>>
>>> With normal mremap() that'd happen via an unmap of the original VMA.
>>>
>>>> rmap walk uses the freed anon_vma.
>>>>
>>>> Using an invalidated PMD instead of a cleared one requires additional =
arch
>>>> code fixes. Instead, disable the PMD level discard of lazyfree THPs, a=
s
>>>> before commit 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP durin=
g
>>>> shrink_folio_list()").
>>>
>>> Again it feels like this commit message assumes a bunch of information =
that
>>> isn't presented here.
>>
>> 1. SPARC has thp_pte_count-- in its pmdp_invalidate(), but set_pmd_at()
>> does not add it back, since the code assumes pmdp_invalidate() is only
>> used in THP splitting code.
>>
>> 2. GUP-fast accepts an invalidate PMD on s390, risk, loongarch. They
>> need to fix it to prevent GUP-fast from succeeding for this new
>> pmdp_invalidate().
>
> Thanks that's useful to know! And ugh.
>
> They seem like they are existing bugs effectively in pmdp_invalidate()? O=
r stuff
> that we would want to fix anyway I guess?

SPARC=E2=80=99s thp_pte_count might cause other issues, since its code only=
 considers
huge pmd splitting. powerpc=E2=80=99s page table check might have an issue.

>
> In general the point of all the above discussion is to encourage a commit
> message that conveys this information clearly.
>
> When I read the patch first there was a lot of 'huh' and that's a sign th=
at the
> commit msg doesn't say enough.
>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 805db93fe0428..1131b76bbbc28 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -2275,17 +2275,6 @@ static bool try_to_unmap_one(struct folio *foli=
o, struct vm_area_struct *vma,
>>>>  		}
>>>>
>>>>  		if (!pvmw.pte) {
>>>> -			if (folio_test_lazyfree(folio)) {
>>>> -				if (unmap_huge_pmd_locked(vma, pvmw.address, pvmw.pmd, folio))
>>>
>>> This is the only caller of unmap_huge_pmd_locked(), making that and
>>> __discard_anon_folio_pmd_locked() dead code, shouldn't we remove all of=
 it?
>>>
>>> Otherwise we're leaving dead code around.
>>
>> 1) it keeps the backport small, 2) I am going to restore the function an=
d
>> this reduce the code churn.
>>
>> I can remove the dead code if you think that is better.
>
> No, if you plan to reinstate it (soon!) then that's fine, but please
> explain that you're intentionally doing that in the commit message please=
!

Sure. I will try to come up with a concise but comprehensive message to cov=
er
both the issue and why pmdp_invalidate() does not work itself.


Best Regards,
Yan, Zi
