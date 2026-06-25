Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1DB2309AA;
	Thu, 25 Jun 2026 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782363972; cv=none; b=isuDwhRJFTmkaxlzl+w65oiqdZoNjajazcKC16T2B++0XOiYbj+sQzZ2C6HTucYM/eNWUJyD7ea1fC87/tRl532oU+GRdwiumbF6hIJtVTVo8MKQonEGe/4KICXroKg5Z1dPpYRnZBpJKjhc+fpjuk+D9jeP0gvzs4hDXisw0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782363972; c=relaxed/simple;
	bh=Lay1HVOEFuLeVqkTA0aGqyvQ+T34DBOYVeHMQyWlWxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZ6Ppp/SGRuYhYGL381tdtiBihUo5s5exuMAGUl9+7IzihQbf16mqI/g3jiKT2Np8GE4jWbsxv01MzvbcHD93yuknFi1J5glUoUL3oQ/g/iECA0bgWW04xQl6Axg/tVWFobovLSU8152vLZRzPXSTwxvjFh0RVMjxqnclFEMULc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UiR8YwXC; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UiR8YwXC"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0E762BCE;
	Wed, 24 Jun 2026 22:06:04 -0700 (PDT)
Received: from [10.164.19.14] (unknown [10.164.19.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 994CC3F905;
	Wed, 24 Jun 2026 22:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782363969; bh=Lay1HVOEFuLeVqkTA0aGqyvQ+T34DBOYVeHMQyWlWxI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UiR8YwXC0OcWwu5H/2F2xG3WeZQPa7DTkaff1XDArWPQ5iDEW4vKBeqhsms5v91dY
	 nqB/Pji3MJWFNE6eJIjpqk1zLtQ/xjJKzh1aVx9RrmCi8V/V0xd7EUS57VvjCat5l4
	 CF/2pyXu3QWf/JrjUquDEykrcJRasB6AnnkTJwH4=
Message-ID: <c17ea0ca-1e6c-4504-87f5-219f13c846f5@arm.com>
Date: Thu, 25 Jun 2026 10:36:02 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@kernel.org, ljs@kernel.org, riel@surriel.com, liam@infradead.org,
 vbabka@kernel.org, harry@kernel.org, jannh@google.com, kas@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, stable@vger.kernel.org
References: <20260625042853.2752898-1-dev.jain@arm.com>
 <20260624214230.4aff522ec8fa4a8f1607c942@linux-foundation.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260624214230.4aff522ec8fa4a8f1607c942@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 25/06/26 10:12 am, Andrew Morton wrote:
> On Thu, 25 Jun 2026 04:28:51 +0000 Dev Jain <dev.jain@arm.com> wrote:
> 
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
> 
> I think 9 years is enough ;)
> 
>> There are similar old bugs present, in try_to_migrate_one(), check_pte(),
>> remove_migration_pte(), prot_none_hugetlb_entry().
> 
> Why now?  Was there some more recent (s390?) change which exposed this?

I was refactoring the hugetlb bits in try_to_unmap_one, so the bug got
caught in review by David (which reminds me to put a "Reported-by" tag
on this patch).

I guess if someone would run hugetlb-read-hwpoison.c on s390, this would
be caught. Turns out, this selftest is in a category of "destructive tests"
in run_vmtests.sh, so ./run_vmtests.sh or even ./run_vmtests.sh -a won't
run this. We are supposed to run this with ./run_vmtests.sh -d, and that
option was broken until one month ago, see 3432cbb291aa. So essentially
no one has been running that test.
> 

