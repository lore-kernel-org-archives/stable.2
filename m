Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DC7126C02;
	Fri, 25 Sep 2026 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790319691; cv=none; b=Q/QlNGODmKiMf4vlcftpw+YA1cQJe9Cfvq4IWD4OCPuokryMrUGFO41yqGnsFbyAPe/MuWEmyOp0lb3WpTJ3tYDrnEPSsOF8vSRS+nOHAPldHZt4J8QztJgSrhfme7ec98mWuYnzPOxF33nLaLzLaqNiw0QcP0kD3OlXg2SPZXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790319691; c=relaxed/simple;
	bh=ybrqyG5jd+0ZNmw6bxWvXnpAFn0qEQAc0SpEc+wlL/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Md7KJNkrgpt6BVtwS+UQqzzaMYChUwCHpiynWc4hHFIcPtNcwrSWBq/C7b8Xhtq2PPEUyRMqkrqlq+AOQffB7TMR2207L+av3VxRrWBDKHeVjn5uN7miJqUvUR2fSn7sOuSJeeQP/bpAQ41qWOYk0tswahC78sOJyF/DaVH3FzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsFUjKBg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsFUjKBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD041F000FF;
	Fri, 25 Sep 2026 07:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790319689;
	bh=12GQTQF+CbA5YWBSY494mtmthnVLIa76obNaRDLDI/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZsFUjKBgrpHW8BPAYX+7NWH4Sgkrz1IewWel2Oqzog+gTBQMFg6F22pt+peCYKq3s
	 0erWR043KfeVfU7c9hbkT5gFacZ2S2SVvoQRngbPCHTQliIyjgMrzNi4YpWpgKEHAW
	 yc6BU1+ypEBxx3O9T0wnjWani0UonVjC9NA8sauVwF1q0j9wdcKY4Q5log9VP3jvPf
	 F+DUFg4l1MOFJwRIOvefvcRyHtzzRgAXJe+34GgThhIulZ4Mz5sFTjAiSxqKyS2Twf
	 vVZewlqy6kOIGqFtCPEeQ36qkpjc9DDEIjbR9E3JdGeHjCxr1BOsxbGFnkAgU9dfah
	 6cfKfYb3HfnnQ==
Message-ID: <90fc724a-08c4-4324-9420-89fab05d53d1@kernel.org>
Date: Fri, 25 Sep 2026 09:01:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] userfaultfd: clear the inherited uffd bit in
 move_swap_pte()
To: Kiryl Shutsemau <kirill@shutemov.name>,
 Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com,
 surenb@google.com, aarcange@redhat.com, ljs@kernel.org, liam@infradead.org,
 vbabka@kernel.org, mhocko@suse.com, shuah@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260919004630.1159895-1-donggeunyoo.kernel@gmail.com>
 <20260919004630.1159895-2-donggeunyoo.kernel@gmail.com>
 <arO0a3CU_idyVsqQ@thinkstation>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <arO0a3CU_idyVsqQ@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/26 13:18, Kiryl Shutsemau wrote:
> On Sat, Sep 19, 2026 at 09:46:29AM +0900, Donggeun Yoo wrote:
>> UFFDIO_MOVE on a swapped-out page installs the source PTE at the
>> destination unchanged, so a uffd bit set on the source lands in a
>> destination VMA that was never registered for write protection.  It is
>> then permanent: the bit is dropped only by change_protection() under
>> MM_CP_UFFD_{WP,RWP}_RESOLVE, which uffd_wp_range(), mrwprotect_range()
>> and userfaultfd_clear_vma() issue only for a VMA registered in that
>> mode.  pagemap reports the page as uffd-tracked, and MADV_COLLAPSE
>> refuses the range while the bit is set, because collapse_scan_pmd() is
>> strict about uffd on swap entries.
>>
>> move_present_ptes() and move_zeropage_pte() build the destination PTE
>> from dst_vma->vm_page_prot and arm RWP only when dst_vma asks for it, so
>> the destination's own registration decides the result.  move_swap_pte()
>> copies the source PTE instead and only ever sets the bit, never clears
>> it, so one UFFDIO_MOVE behaves differently depending on whether the page
>> happened to be resident.
>>
>> Clear the uffd bit on the moved swap entry unless the destination is
>> RWP-registered, as copy_nonpresent_pte() does where it installs a PTE
>> into a destination that may not be armed.  A WP-registered destination
>> stops inheriting the bit as well, which is already what it gets when the
>> moved page is resident.
>>
>> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
>> ---
>>  mm/userfaultfd.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>> index 74f04c323c50..6495666c596b 100644
>> --- a/mm/userfaultfd.c
>> +++ b/mm/userfaultfd.c
>> @@ -1452,6 +1452,8 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
>>  	/* Re-arm RWP on the moved swap entry if dst_vma is RWP-registered. */
>>  	if (userfaultfd_rwp(dst_vma))
>>  		orig_src_pte = pte_swp_mkuffd(orig_src_pte);
>> +	else
>> +		orig_src_pte = pte_swp_clear_uffd(orig_src_pte);
> 
> Putting it in the 'else' is wrong. Clear uffd on the source
> unconditionally and re-arm based on the target VMA:
> 
> 	orig_src_pte = pte_swp_clear_uffd(orig_src_pte);
> 	/* Re-arm RWP on the moved swap entry if dst_vma is RWP-registered. */
> 	if (userfaultfd_rwp(dst_vma))
> 		orig_src_pte = pte_swp_mkuffd(orig_src_pte);

I'm confused why the original code proposed would be "wrong"?

I prefer your way of writing it as well, but I don't understand why it would be
"wrong"?

Maybe I need more coffee :)

-- 
Cheers,

David
