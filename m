Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A14033F383;
	Thu,  6 Aug 2026 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034742; cv=none; b=H/HBL2AT317tt+YlsleQ30O8jfhzAsNvU+6gHlA9TsIjzJd2j7u0mSRLatqJXel/PqSuIVm4BITsW3B7wDkV/okWuy+4YcTnMhVTTWAYw9zqZZsCpz9drWD60sgC1rS2NJmS6wXnlvYhV0Wr9EK0W/qV+4t/Lcu0RWnM9LTw334=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034742; c=relaxed/simple;
	bh=wcH9/Cw3vGVBCHbi3z6CbaQXHFcSW7QVMk0gQotEFlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQKF5wb18Qt0vcBQAuZTpJtntZCv+ZQB7LQjtviSRu25oEH9lC4xcCXb5AZRbQWJ3EcqLaf8sTk714scNohrkWIWW/H22s7F3c7mmPbqHEOYICEfDpDsU3Fhx6gmw2koE6igsHxEVhSKTVjlgMsZr2NnXxHX5B/bIK4/BbVAldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXiUMrsM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXiUMrsM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80651F00A3A;
	Thu,  6 Aug 2026 16:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786034738;
	bh=VrdYoYmL+T5FlaJX6gRMCUi3wWSvcdyxUT0pa5jmJHw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KXiUMrsM5jdndCIntJReZr0x2HnPjsWH60xKSgXTjnftr76RGmt+1g7fcXDDLukjK
	 bPCbcxzZ0jtr2cnnns6XD/kH1hWiM3agXfL6gkzrLYK7edFKbHKn8OrWZGgLwUdj8R
	 l+OA/n2RUUhf2TbUWue/FxpqOejOL0q9srpQXixktHk1yXx8SMYZCa/CFmzOx7qovu
	 RnabFQ8CofvqZ+0Ru1X+sA+iTaadt5Vo50/XAkzI3Z8GoEtid05wqQs7dM8WKwWZKQ
	 7HqDX1M+9u8v97tat8XcM3cdX4VC40nizoaJoahol3Uuj+LsJy5GSfx0uDXz66GMrh
	 qpb25E6/i+gaQ==
Message-ID: <857ed4fb-7f99-410f-be1a-59ada04d06a8@kernel.org>
Date: Thu, 6 Aug 2026 18:45:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: let special huge VMAs bypass the THP
 policy check
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260805055544.1568534-1-clg@redhat.com>
 <anL-NZkNMSSxN0YN@lucifer> <0bd6d355-e6d9-4f5a-b101-9a041c2a2436@kernel.org>
 <2a7686ee-56ab-439a-90fd-ad3c10e4c336@redhat.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <2a7686ee-56ab-439a-90fd-ad3c10e4c336@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>>
>> +static bool file_vma_honors_thp_toggles(struct vm_area_struct *vma,> +       
>> enum tva_type type)
>> +{
>> +    const bool forced_collapse = type == TVA_FORCED_COLLAPSE;
>> +
>> +    if (forced_collapse)
>> +        return false;
>> +    /* Huge PFN mappings allocate no folios so the policy doesn't apply. */
> 
> So, may be rename the routine to file_vma_thp_policy_applies() ?

Also a possibility. I'll let Lorenzo handle this.

> 
>> +    return !(vma_test(vma, VMA_PFNMAP_BIT) && vma->vm_ops->huge_fault);
>> +}
>> +
>> +static bool vma_thp_toggles_enabled(struct vm_area_struct *vma,
> 
> This routine could use the same 'file_vma_' prefix.

It's true even for non-file vmas.

> 
>> +        vm_flags_t vm_flags)
>> +{
>> +    /* THP=always? */
>> +    if (hugepage_global_always())
>> +        return true;
>> +    /* THP=madvise and actually advised? */
>> +    return hugepage_global_enabled() && vm_flags & VM_HUGEPAGE;
> 
> I would add extra parentheses around 'vm_flags & VM_HUGEPAGE'

It's even required and the compiler might complain :)

> 
>> +}
>> +
>> +static bool file_vma_forces_order_0(struct vm_area_struct *vma,
>> +        vm_flags_t vm_flags, enum tva_type type)
>> +{
>> +    const bool in_pf = type == TVA_PAGEFAULT;
>> +    const bool smaps = type == TVA_SMAPS;
>> +
>> +    /*
>> +     * Enforce THP collapse requirements as necessary. Anonymous vmas
>> +     * were already handled in thp_vma_allowable_orders().
>> +     */
>> +
>> +    if (file_vma_honors_thp_toggles(vma, type) &&
>> +        !vma_thp_toggles_enabled(vma, vm_flags))
>> +        return true;
>> +
>> +    /*
>> +     * Trust that ->huge_fault() handlers know what they are doing
>> +     * in fault path.
>> +     */
>> +    if (((in_pf || smaps)) && vma->vm_ops->huge_fault)
> 
> and there remove the extra parentheses.

Agreed, that was already there in existing code.

Anyhow, it was mostly for inspiration for Lorenzo. I should start spelling out
more clearly in the future that this is just a quick prototype, because recently
people assumed that some quick stuff I post inline would be complete or even
tested :)

-- 
Cheers,

David
