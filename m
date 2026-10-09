Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002C93911AF;
	Fri,  9 Oct 2026 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577646; cv=fail; b=PGeNzJvaNgH+64kS/5fjnY31f8+TI9HHEijT0WJbAPi0ObfXR9bXDaUBIq0US5+qr1EzxM83rSYtt7B35s42pdZbRSX8qMvfgaxWX664l1gYDU+i84kxD7RSS5TehXbUPRqto0PIRP0WIYIMLdzzm1UQRaUTNBvBKAuTGu55ZtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577646; c=relaxed/simple;
	bh=VkXZuR9dO6Nod4dNI21bDKllDzoWzNjPRyNlRH6cpCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=asqglma+BlKK9ddX9SLm54NJ2QtPQwUFUAQIWj3dJePSV7mN9W3ZDo29pT4tSRgJtm1EfXqtHZT6HU8lVe9xwIzL0Q7pqUTY+RPRrhItIKoutOzT/S2wg/cuUXIYb1U8wvSR5ulta5x69dNDGNVfeC9H5JA5H8t5aS1/6giIRVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PWSnP9E4; arc=fail smtp.client-ip=40.93.194.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PWSnP9E4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6ICBE1nwi3C+No0pbJg63VtWGCUIN04J4FiTR7w88wtkzRTb8Q4gXK7WVwLYp/bUsKFtmtBZkiFNbiL6BPBiw4vKY80dpXGTGAFr0xJQOvZcg8XmpQ+Rc3lPbWy0JtW/Qr2ssrGWQFv+uzYJnrzjgPkMRjOoJd3I8Kwt+cB5QxXYZJnBvDgDCjplx2+X6gczCjfacxGxUI7bnFu+7/Fgafnhr9SkCkihT8wL82dBiDRlPAgT/+9KKTGtFTZWsfiThsVJUntDqfY2Kzsns0/ir0X8C50Efdd6U5cQ+rZ8Zu14Cb/YTBa4qR7teSY96g8FUf23IILooIMTxTSIBuDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSLrLC/0mw1IND1VhNU6i+Wa/Dj8ejkoFT/gSARp3/g=;
 b=VPHM1dDF2lJljWhavV1y/HLUe0Rm5CDx+lGA4hOgHE+9F5TL6MLpkL6tOGDNB2DeMLWUdHisp9gadmoD46oiAdWbMAr72gxE2d/OoDtqONSe+hcGfWaN4OM0d2pEk8UdppBOajHUHNo/KGMRksOrADMHy5Gb9PZv4cmFZaPufNn2M77osUtArETljNPv8yQUqZ93aW05wsRVdcnHwPA31ltfP2elbrn53iJrSVfOR5DQ7dK/q/Vp6agh05/UCff0hbOv5Yxx8gWUEswFIsFxqQ9NokofRiPpt5rnEqV9b4zDa97WrV0eTkNAGnCMG/aYh8tV//UNl91fsDidZnbSuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSLrLC/0mw1IND1VhNU6i+Wa/Dj8ejkoFT/gSARp3/g=;
 b=PWSnP9E4NBwuhTlRp8o4EtjKwApd71EbJ7scMcKuva2hicCOjSZDshgtBe283lNdWPU9k9Yp0q+T03iaoK7FqS1oukklf6GMSvOo7ekkAukHv8ttlbu88YSw4mpOQwmDwz2C3YeU/03x8PpRtrhIAwwZH/izXX8iF4vrnItQT2E019I+pfmpoGe+AJwdTi2xPhltIQJQbq/1YsuLERfOSd2aYSQP596Sota+HH4IyAMk1TwqoOGP2duXvVi15D+XWpmSfzUtqXqTuw46npGrzyBCgq+FnCSs+gQr7YeHVVOO2X4VE+2+yPcDDY5/hGvgjR5e/B9sFKzsqrZOsX9lwA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 9 Oct
 2026 20:27:15 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 20:27:15 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kyle Zeng <kylebot@openai.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: avoid transient none PMDs during lazyfree
 reclaim
Date: Fri, 09 Oct 2026 16:27:10 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <55765FF3-18D7-424C-984D-81C316F323E1@nvidia.com>
In-Reply-To: <8db35dc0-eb06-42e4-90f9-534522e810e1@kernel.org>
References: <20261009165214.40212-2-kylebot@openai.com>
 <DM0II2QHWWS1.2RXEJXC8S0101@nvidia.com>
 <8db35dc0-eb06-42e4-90f9-534522e810e1@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: PH8PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:510:2da::15) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: f719c99a-0920-4a26-79fc-08df2643b4c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|22082099003|11063799006|10067099003|4143699003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	7WiF1xVU3k+jRD0jGIjDS/mcVmC2fjW6xPOWb9Lfz0izwSAcJMJ+ohp3SK8oQT78M8T/5iTROukW3bKrcnS2TG6g8PgtJwLJWejwujLccPRe0qLxEWRJIyOZlEavHPQ4aAd7Jwt/qFPSK6BReBwBTZz+ZmLXlTs/7/I68boS2fN1ttZHQm5jAnbr2xDXYR0mo9m6cxabIRTArEtD17Rg3JjsZcDJjiW+vA0FpvdPOtKVn+JS27DdXbO+TOh+e7SkdEHmvsOkCn7374jxBazIypLaAxVa5ZPUyOACyNzU9xUaf3EWqwweRkwJ8TfQGJSWgYcdPsL/L10F71aREMJK6i7/69bXhobo34VpaJv6Vkr0AhIs9SmurXvzytK1sw/yqEaCfX6L51Sl2sgfiJ/EWAV54MeEIOLGJ3c0WGXU6+WvOE3BTT34yfU7dNF9Jtm7fTdBagImUCfyvTVSHOHuMcJ3GONoTLMpdTRk3fFnd8FvAJoOXNj0kQTRbwmoRQrYHlPqD7MPBPPGizfiPFMb+o4Hfw9gPBQ+PbIQBHekMl50bqfYlGlrO6FPvrua7IKJIDxXr0653JXziiv8WnNrp2xwiTSUyJyBzR5JUwc9DrfiRH0c3B5Ex3Bx98VBH21lYzTZ7kQPsQ3gRZVd6Vi7C9OZx0XlptOhcv09XZxn2Y4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(22082099003)(11063799006)(10067099003)(4143699003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b0AWZvdHaeROxpRC3EdrQR7knTTOxLjFMDDtbX7BBmZJLGwV9BHsdYhtY0zf?=
 =?us-ascii?Q?pSEuTyE6tJsH9bjjh7H6bgfan1dgDyyIrtQ5Dbq9/xnyiXNaE6p01/meizKQ?=
 =?us-ascii?Q?qczN41zkbGdiQaQ+IG0cbPc+3aGlfw4Jg9slIyd0/NkSJg4MU/wNyjTVxl/I?=
 =?us-ascii?Q?wMErm8x6eeerHUaKgPxVlpgLTdCEl29Qx5m96Pw7xpYd4kE8Bgwa3mTiCgf6?=
 =?us-ascii?Q?DNluC84XJk071RDz4Sg4716D5xQIrr1Y3RMHxWSwiuU06GcWsNHL7Ou3gAGA?=
 =?us-ascii?Q?HfDfQUMz+IsXgxrf4GzOWgMVZ/XoUU7hjm7gIci39hwX2ySNw8LlmwezgfAM?=
 =?us-ascii?Q?Wr0eduDi2g1jNTrlwiPSLr1B5uy0pK5gA2FKlfJ8x/cGhF3fvlbrLdy5PASy?=
 =?us-ascii?Q?93kQcUyxuVm+1kre/VC9+P46rSGSZg6ifnLoedM/U9WGOJCO1h8U1Qr6HgyY?=
 =?us-ascii?Q?Ubc9xzW9CC8Kucbc0llfFP2wST9QHPJ6FAW0NlY2qT7UfFuMTByLuC7jAxYL?=
 =?us-ascii?Q?Wiougwa3QfuiCuJ3SPQ8pAbfCkfR+bhqDnGCCBTFxZqvyzfzGfqCXWqjPvPf?=
 =?us-ascii?Q?KAp/zn68ORYgCL2bGqNd1jCvMSq/+N6wdfZhj6zurg2IqUcbVMjdsYhVZ0GE?=
 =?us-ascii?Q?X53k3Y+USAVqbvrMlRw5Xt3v5+njDTlb9x6OBjlQATKdl2b8Svgn8eTNq9rc?=
 =?us-ascii?Q?fqaibbtdaJ7Vei0Ts72t6wlMWZ0Tb5AFuGwAEJg+S1EeOdbaMsJRApb0jOnQ?=
 =?us-ascii?Q?gMxD59amIKLXVHoYomj7ThsF1EfFDbReZxpVRSBI5uWRnNqGqn0O7LMx1dmm?=
 =?us-ascii?Q?JyhzZvoK2zo4q9ioyxrtxb3p4dI5DYCWZPWtXwo0InHLsqg5Q07fCCStYT8D?=
 =?us-ascii?Q?IDrF3ujOe55MATVmr5QbZDHJsrjbOeLikU+7OzUKheuodXuE/4ZcUuiKhBy4?=
 =?us-ascii?Q?TB7ATJH9lOtR/Y+oQV+8peaCCz+gWGJFfkd31cUNisRRQfilqH7/553c4Wi5?=
 =?us-ascii?Q?CY0/lbizaDo8Ju5VR9ziKOV2aKe/dVNVqiwaEYRya1Oe3qboUGxdiELhinBI?=
 =?us-ascii?Q?S88QM3/+Nzy/mgpLxAn4AsTVcUzbfLfcmp0Pvlm/HorX+oGi3D+CPUiXIDnl?=
 =?us-ascii?Q?75egeCrXKrwj/BVcCmEMDoMgDqOuIrwS9Ebg/wxSWS0gtQ88g9+4apqdthW7?=
 =?us-ascii?Q?t0lw554DuXD/ChLGUTbgpwxgDUIcSHbzZCRmfb/U0QbOHiIxNXDyPp96m0A+?=
 =?us-ascii?Q?pOeOphI3YH6RM6uM2HQ1jXqmQMkg8FWT6Ebts14uDaWkH2hMINH0iZjAXvQ5?=
 =?us-ascii?Q?AAWrWsVgMg/uQeJ/iNiUYr8DroJtZvaJRNXr6mz0q6HEY7imidjlTuqxLzyH?=
 =?us-ascii?Q?vj/088Gtb9beLPGVnkGB5kKJAorrl+oyR6y2fVD2wtMHQc5Q+4JXv2zHh8o9?=
 =?us-ascii?Q?yC/zXPIi1UjPstfQiEk2FNIvF6jm3KOKq5cCYnfWyEuBvxdU9GADHGUYmq/e?=
 =?us-ascii?Q?hA3GsvXAkVkIhPWLWkfYkKUwJ+1/qsbLrhm3WjupALpldSWoFdVoo4ERW6ZK?=
 =?us-ascii?Q?A/CoogLcQEP+i48l3NfSoU+4HGdDS9S6pV5bsakVvs/+DEWelSoStnfoxJKE?=
 =?us-ascii?Q?B5rxmyWMkRAXCczEMN6t0GiGDJm/zTUnVSDK/Oi2USXVQdMuCkvTwqs3y30E?=
 =?us-ascii?Q?jGWp5y9LblwJYuakwRXVPGgnmdKBgqfcvojC5Ca/9NjPIjLN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f719c99a-0920-4a26-79fc-08df2643b4c8
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 20:27:15.0039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjdEzMoCaVZuYhJ8F569PS43OTMMwoJxkW7u4B6NOiBhecvy6f0Yld8Zlmd1uvGb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134

On 9 Oct 2026, at 16:23, David Hildenbrand (Arm) wrote:

> On 10/9/26 20:17, Zi Yan wrote:
>> On Fri Oct 9, 2026 at 12:52 PM EDT, Kyle Zeng wrote:
>>> __discard_anon_folio_pmd_locked() clears and flushes a huge PMD befor=
e
>>> checking whether the folio can be discarded. If the folio was redirti=
ed
>>> or has unexpected references, it restores the original PMD. Reclaim h=
olds
>>> the PMD lock and the anon_vma read lock, but not the owning mmap_lock=
=2E
>>>
>>> Both zap_pmd_range() and mremap's get_old_pmd() can skip a none PMD
>>> without taking its lock. A concurrent munmap() or whole-VMA
>>> MREMAP_DONTUNMAP can therefore miss the PMD and later unlink the sour=
ce
>>> VMA from its anon_vma, leaving a restored mapping behind. The anon_vm=
a
>>> write lock taken by unlink_anon_vmas() waits for reclaim to finish, b=
ut
>>> does not repeat the skipped page-table walk. Once the remaining VMA
>>> links are removed, the folio's positive mapcount no longer guarantees=
 a
>>> live anon_vma. Racing lazyfree reclaim against MREMAP_DONTUNMAP as an=

>>> unprivileged user reproduces a KASAN use-after-free in
>>> folio_lock_anon_vma_read().
>>>
>>> Use pmdp_invalidate() to keep a recognizable, non-none huge PMD while=

>>> the discard can still fail. Concurrent unmap and move operations then=

>>> have to synchronize on the PMD lock instead of skipping the mapping.
>>> Clear the invalidated PMD only after the dirty and reference checks h=
ave
>>> succeeded, before removing the rmap and withdrawing the deposited pag=
e
>>> table. The full invalidation retains the TLB flush required for the
>>> dirty and GUP-fast checks.
>>>
>>> Fixes: 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP during shri=
nk_folio_list()")
>>> Cc: stable@vger.kernel.org
>>> Assisted-by: Codex:gpt-6-astra
>>> Signed-off-by: Kyle Zeng <kylebot@openai.com>
>>> ---
>>>  mm/huge_memory.c | 11 +++++++++--
>>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 1e5d68acf62a..20262195385a 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3569,11 +3569,17 @@ static bool __discard_anon_folio_pmd_locked(s=
truct vm_area_struct *vma,
>>>  		return false;
>>>  	}
>>>
>>> -	orig_pmd =3D pmdp_huge_clear_flush(vma, addr, pmdp);
>>> +	/*
>>> +	 * The discard may fail, so keep the PMD non-none until we're
>>> +	 * committed to discarding it. Otherwise, concurrent munmap() or
>>> +	 * mremap() can skip the PMD without taking the PTL and later unlin=
k
>>> +	 * the VMA from its anon_vma despite a restored mapping.
>>> +	 */
>>> +	orig_pmd =3D pmdp_invalidate(vma, addr, pmdp);
>>
>> There are some gaps we need to close before getting this fix in:
>>
>> 1. GUP-fast cannot follow the invalidated PMD: riscv and LoongArch nee=
d
>> pmd_access_permitted() that requires _PAGE_PRESENT; s390's
>> pmdp_invalidate() needs a change.
>
> Ugh. We really need pmdp_invalidate() to have reasonable semantics. Thi=
s whole
> PMD locking is a mess :(
>
>>
>> 2. sparc64's thp_pte_count can be imbalanced with this change (based o=
n
>> Lance's offlist feedback).
>
> Ack.
>
>>
>> In addition, powerpc has a page table check issue similr to riscv, whe=
re riscv
>> fixed it with commit 9f4a88b8d01a6. This is not related to this issue
>> but discovered along with the investigation.
>
> Zi, do you have the capacity to take over this patch?

Yes, I can take over it. My plan is to send a series including
patches for 1 and this patch as is. powerpc fix can be a separate one.

Best Regards,
Yan, Zi
