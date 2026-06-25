Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D09263C8C;
	Thu, 25 Jun 2026 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376101; cv=none; b=mpUvtlRrl2yu2lc6KEv07L8MaHXrsZYMuujdx6bJot2rEYLeNlS7ddsiHKN0q5m3pRJXmAQjVJYBlz0fJd0hvz+c0xmOBKHXT2u8yoxnu/eVqCk7NaIYYapUZcZBcSKfTnTXsTluHU9btjQtI4GAcf9agf6Zty4qqVnmPN3CuXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376101; c=relaxed/simple;
	bh=0arGaawYfZJvGNMwZzYpIeBiIHt3Cff+d5T1fy2Fglc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADPXSBVuRRKEtlp1PnV21B6/yg0EbfK9UVtUHWOICmbd11oF7KmVOdR7LgZWUM2knunFi5wvo82Dw/RFWBjPnTGQjPzGeIfht4RwBBUWE+FjdKC0tNacFJjtudCmbRkbcnIn2nBFqQBIUuZyD3Qn5GVq65+A64evcM+5Nlmy5rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vv/BFSEI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vv/BFSEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1395E1F000E9;
	Thu, 25 Jun 2026 08:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782376100;
	bh=egKHugauFVcD2XmzNTTw3d2qyTB8B7rTgdVmFNmqNrg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Vv/BFSEIrXCF8hk5q6CGRIvgWvOV5dQsjW4VlCOMp/qdSdxk12UM4sQxtefRbTzOp
	 QdXuqVGkYsFyLEwaNMZag5GRtXKhEo8ddH4seU+ZQbFr4eI/RZwrVn0nrHd8cMr8Al
	 hQGiJp1NVjM/TA4fwEyDEMewqt8B9VGV1NsEvo9G/Zbb6vVJV5UN2EZlr7XWRJpOco
	 +VQoEcH1OlXNI1jpeU76sFyrYPyzIAS+aGyItEhL1vfE6sdJ36CvFo/azd+A8TfX4x
	 Bru//XwEltp7BC/88i5rhtt3Op8hWVaFunUX/pAWuHTU+hoxF9iYMfsoqOtj42gs8M
	 P+Prj8fBTAaLw==
Message-ID: <237cdb97-5abc-4c89-a0cf-1a961425f947@kernel.org>
Date: Thu, 25 Jun 2026 10:28:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, ljs@kernel.org
Cc: riel@surriel.com, liam@infradead.org, vbabka@kernel.org,
 harry@kernel.org, jannh@google.com, kas@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, stable@vger.kernel.org
References: <20260625042853.2752898-1-dev.jain@arm.com>
 <ca31c254-504f-4857-bec7-10b8c2de94ed@kernel.org>
 <614e89a8-5108-4ac1-bdf8-fecca48bd91b@arm.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <614e89a8-5108-4ac1-bdf8-fecca48bd91b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/26 10:03, Dev Jain wrote:
> 
> 
> On 25/06/26 1:26 pm, David Hildenbrand (Arm) wrote:
>> On 6/25/26 06:28, Dev Jain wrote:
>>> try_to_unmap_one() handles hugetlb folios when memory failure needs
>>> to replace a poisoned hugetlb mapping with a hwpoison entry. In that
>>> case page_vma_mapped_walk() returns the hugetlb entry in pvmw.pte, but
>>> the code reads it with ptep_get() before decoding the PFN.
>>>
>>> That is wrong on architectures where hugetlb entries are not encoded as
>>> regular PTEs. On s390, for example, a raw huge RSTE must be converted
>>> by huge_ptep_get() before helpers such as pte_pfn() can inspect it. A
>>> raw decode can select the wrong subpage, so try_to_unmap_one() can
>>> install a hwpoison entry for the wrong PFN.
>>>
>>> The userspace-visible result is that a later access to the poisoned
>>> hugetlb subpage can miss the expected SIGBUS. With DEBUG_VM, the wrong
>>> subpage can also trip the PageHWPoison check.
>>>
>>> Use huge_ptep_get() for hugetlb mappings before decoding the PFN.
>>>
>>> Before c7ab0d2fdc84, the bug existed in the form of a plain dereference:
>>> we would check the head page pfn of the hugetlb with pte_pfn(*pte), and
>>> bail out on mismatch. This would mean that the hwpoisoned entry will not
>>> get installed.
>>>
>>> I am not sure what is the procedure on such kinds of very old bugs - how
>>> back should I really go?
>>>
>>> Fixes: c7ab0d2fdc84 ("mm: convert try_to_unmap_one() to use page_vma_mapped_walk()")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>> Applies on mm-unstable (d17fe8a046a2).
>>> There are similar old bugs present, in try_to_migrate_one(), check_pte(),
>>> remove_migration_pte(), prot_none_hugetlb_entry().
>>
>> Yeah, we should handle all these cases properly. Can you send fixes?
>>
>> Using ptep_get() on something that's not a PTE entry is shaky on some architectures.
> 
> I can send the fixes blaming the commit till which backport is relatively simple. The bug will
> still remain before that, where we don't even do ptep_get(), just a plain dereference, if
> that is fine. Probably no one is running pre-2017 kernels.

The issue is that we would have to analyze in which cases exactly it would cause
problems, like when migrating prot-none hugetlb folios on s390x, where
pte_present() would not work as expected.

I don't think any of us has time (or motivation) for that detailed analysis to
make some odd hugetlb cases happy.

So I'd say, let's just fix it in a simple way and be done with it. Use
best-effort Fixes: but rather state in the patch description that this was found
by code inspection and that the actual effects are unclear (e.g., pte_present()
misbehaving on s390x), and using huge_ptep_get() is just the right thing to do.
-- 
Cheers,

David
