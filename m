Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A48374170;
	Thu, 25 Jun 2026 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376822; cv=none; b=KXBREAk1bxSakTlLETlsd5pOzAH0/IGbILuVODE4ns/IKomNHdBF5ok4UNr7hnIp/AXW6JY0fRJ7ZBqT9Y8B2K6LKHb44UM+iPK1K/hUrdVnX8FyFry5FrGyAxNjtifXKmHtxTAimwsJEFi3mV2xd09mla+yFb9/cDGoNfoKgf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376822; c=relaxed/simple;
	bh=BWj4NQGKd4mjmlkdybirdAqawz1Y04I6GIWh4Gx5jiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGviUgQ1pr0M3ECsmsiGOhfJUd3eOj26PszP//9j/mLEEK61lmlIce80gfo55tYcP8tSMoi2xBMso7Z0iViO6RRiqwniA1ejKf8Br26LlXbjdmVAKcpmm9X5vnHk2g0SgT+UmnsqUYTEoBbhDDqNCL55JkrRfKlxToVXiqldr/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GGavGui+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GGavGui+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2DE52BCE;
	Thu, 25 Jun 2026 01:40:14 -0700 (PDT)
Received: from [10.164.19.14] (unknown [10.164.19.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C36F63F836;
	Thu, 25 Jun 2026 01:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782376819; bh=BWj4NQGKd4mjmlkdybirdAqawz1Y04I6GIWh4Gx5jiU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GGavGui+k0FYR7uIV3hPdH3uSry9W7h2Do9UqFdinnEraOlgikBT8u5AQd9lV8P1C
	 xyJzy7nC83ViHAtje4xZv8QlxTwwvzp/xA3ktS9ilzR1667loWyfqwZpBbSxmqk+c1
	 4WK1oEkh8K7hXxod9TzJ0MSZKS0+hycjFGvQpgJ4=
Message-ID: <d2cc9d50-3e17-4217-ac79-00978cd9e3c0@arm.com>
Date: Thu, 25 Jun 2026 14:10:13 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
To: "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org,
 ljs@kernel.org
Cc: riel@surriel.com, liam@infradead.org, vbabka@kernel.org,
 harry@kernel.org, jannh@google.com, kas@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, stable@vger.kernel.org
References: <20260625042853.2752898-1-dev.jain@arm.com>
 <ca31c254-504f-4857-bec7-10b8c2de94ed@kernel.org>
 <614e89a8-5108-4ac1-bdf8-fecca48bd91b@arm.com>
 <237cdb97-5abc-4c89-a0cf-1a961425f947@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <237cdb97-5abc-4c89-a0cf-1a961425f947@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 25/06/26 1:58 pm, David Hildenbrand (Arm) wrote:
> On 6/25/26 10:03, Dev Jain wrote:
>>
>>
>> On 25/06/26 1:26 pm, David Hildenbrand (Arm) wrote:
>>> On 6/25/26 06:28, Dev Jain wrote:
>>>> try_to_unmap_one() handles hugetlb folios when memory failure needs
>>>> to replace a poisoned hugetlb mapping with a hwpoison entry. In that
>>>> case page_vma_mapped_walk() returns the hugetlb entry in pvmw.pte, but
>>>> the code reads it with ptep_get() before decoding the PFN.
>>>>
>>>> That is wrong on architectures where hugetlb entries are not encoded as
>>>> regular PTEs. On s390, for example, a raw huge RSTE must be converted
>>>> by huge_ptep_get() before helpers such as pte_pfn() can inspect it. A
>>>> raw decode can select the wrong subpage, so try_to_unmap_one() can
>>>> install a hwpoison entry for the wrong PFN.
>>>>
>>>> The userspace-visible result is that a later access to the poisoned
>>>> hugetlb subpage can miss the expected SIGBUS. With DEBUG_VM, the wrong
>>>> subpage can also trip the PageHWPoison check.
>>>>
>>>> Use huge_ptep_get() for hugetlb mappings before decoding the PFN.
>>>>
>>>> Before c7ab0d2fdc84, the bug existed in the form of a plain dereference:
>>>> we would check the head page pfn of the hugetlb with pte_pfn(*pte), and
>>>> bail out on mismatch. This would mean that the hwpoisoned entry will not
>>>> get installed.
>>>>
>>>> I am not sure what is the procedure on such kinds of very old bugs - how
>>>> back should I really go?
>>>>
>>>> Fixes: c7ab0d2fdc84 ("mm: convert try_to_unmap_one() to use page_vma_mapped_walk()")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>> ---
>>>> Applies on mm-unstable (d17fe8a046a2).
>>>> There are similar old bugs present, in try_to_migrate_one(), check_pte(),
>>>> remove_migration_pte(), prot_none_hugetlb_entry().
>>>
>>> Yeah, we should handle all these cases properly. Can you send fixes?
>>>
>>> Using ptep_get() on something that's not a PTE entry is shaky on some architectures.
>>
>> I can send the fixes blaming the commit till which backport is relatively simple. The bug will
>> still remain before that, where we don't even do ptep_get(), just a plain dereference, if
>> that is fine. Probably no one is running pre-2017 kernels.
> 
> The issue is that we would have to analyze in which cases exactly it would cause
> problems, like when migrating prot-none hugetlb folios on s390x, where
> pte_present() would not work as expected.
> 
> I don't think any of us has time (or motivation) for that detailed analysis to
> make some odd hugetlb cases happy.
> 
> So I'd say, let's just fix it in a simple way and be done with it. Use
> best-effort Fixes: but rather state in the patch description that this was found
> by code inspection and that the actual effects are unclear (e.g., pte_present()
> misbehaving on s390x), and using huge_ptep_get() is just the right thing to do.

Sure thing, sounds good.


