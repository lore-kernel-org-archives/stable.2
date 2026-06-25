Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FEE2D97BA;
	Thu, 25 Jun 2026 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782374602; cv=none; b=eG/sojAhZ+fJ3jAGeAy9OSjmSEsV/+nOBm+j15Z3WFVP+56Ras41SJRFVrqQRIufAeM7c4e4OVxR7a2lVk/Lz/VsATQhHgpbnVrHlhJjUx6OXr3baDTRCvYVjiTSzRRwzm3mTcQ+c6xsfBLiDMbzTkteJ7bkHOS4A+DBpnOy6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782374602; c=relaxed/simple;
	bh=aAbiQ0kC3g2kpXXxbZWIR5lShtLiakkafy46q5goelw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cag5vQA+JHsv68kSdQzpIeTCvGZClGR1wm2DLjXsEshSUuZaxIDJw9k6nooZCAkrJfU47E0TEYUc4gZWQNUm/WRzWdRoc4AHrBt69SLbQbHgdllfGVaYI9rNp40TqTI4mhJT/PNqFSOK5XBY4ml5A6C7wdeI2q4/DzqrY1ITN8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=M4jQmsnu; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="M4jQmsnu"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5337515A1;
	Thu, 25 Jun 2026 01:03:15 -0700 (PDT)
Received: from [10.164.19.14] (unknown [10.164.19.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A8423F915;
	Thu, 25 Jun 2026 01:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782374599; bh=aAbiQ0kC3g2kpXXxbZWIR5lShtLiakkafy46q5goelw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M4jQmsnuPIRvYaZFh5IORzmFo567AEHUtqQ3dVOoZpvslmKRwfGE2vVVY7nZyEWkJ
	 BzDMxDgufZjCVSb5BsWx9fB2sEsY19ztI4drtxdP4wJgDH6YyciK2n8+0F7ylTUOs5
	 RUIfPbyR6Do+Xh4Sg/kga5ozK9Cla8cfO/myz+Zo=
Message-ID: <614e89a8-5108-4ac1-bdf8-fecca48bd91b@arm.com>
Date: Thu, 25 Jun 2026 13:33:13 +0530
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
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <ca31c254-504f-4857-bec7-10b8c2de94ed@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 25/06/26 1:26 pm, David Hildenbrand (Arm) wrote:
> On 6/25/26 06:28, Dev Jain wrote:
>> try_to_unmap_one() handles hugetlb folios when memory failure needs
>> to replace a poisoned hugetlb mapping with a hwpoison entry. In that
>> case page_vma_mapped_walk() returns the hugetlb entry in pvmw.pte, but
>> the code reads it with ptep_get() before decoding the PFN.
>>
>> That is wrong on architectures where hugetlb entries are not encoded as
>> regular PTEs. On s390, for example, a raw huge RSTE must be converted
>> by huge_ptep_get() before helpers such as pte_pfn() can inspect it. A
>> raw decode can select the wrong subpage, so try_to_unmap_one() can
>> install a hwpoison entry for the wrong PFN.
>>
>> The userspace-visible result is that a later access to the poisoned
>> hugetlb subpage can miss the expected SIGBUS. With DEBUG_VM, the wrong
>> subpage can also trip the PageHWPoison check.
>>
>> Use huge_ptep_get() for hugetlb mappings before decoding the PFN.
>>
>> Before c7ab0d2fdc84, the bug existed in the form of a plain dereference:
>> we would check the head page pfn of the hugetlb with pte_pfn(*pte), and
>> bail out on mismatch. This would mean that the hwpoisoned entry will not
>> get installed.
>>
>> I am not sure what is the procedure on such kinds of very old bugs - how
>> back should I really go?
>>
>> Fixes: c7ab0d2fdc84 ("mm: convert try_to_unmap_one() to use page_vma_mapped_walk()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>> Applies on mm-unstable (d17fe8a046a2).
>> There are similar old bugs present, in try_to_migrate_one(), check_pte(),
>> remove_migration_pte(), prot_none_hugetlb_entry().
> 
> Yeah, we should handle all these cases properly. Can you send fixes?
> 
> Using ptep_get() on something that's not a PTE entry is shaky on some architectures.

I can send the fixes blaming the commit till which backport is relatively simple. The bug will
still remain before that, where we don't even do ptep_get(), just a plain dereference, if
that is fine. Probably no one is running pre-2017 kernels.

> 

