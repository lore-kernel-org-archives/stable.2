Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103255;
	b=eePt7sB+RLwubcu9oQdijjbYy9HYaF0q3gW3kUNLyZFSTZDzx/r+DMdLqs2ml54eWOq5
	 kIH8VBLtZavNCPWt2WS1M7PLTC7KAE8cva6qiP7Y0B0K7+FRMednJYdNxbwojEcquN+fJ
	 E+DxCBrV4GPTPX6dE12wfAFhMpG9zK9yfT7xw0Ppy8TZQvB1A25UyovtLl9dTAmpD959X
	 4zrAyBJfxeLqLTkcBLO2ztYqXhGmqBse0PIbwbJOoHEppha7MULpOabrY47FDeWpPOMfd
	 8X4ZlWcvOfgm2hzpL8nyhgM5T4plLn+Ds+nXc+Zxchd7iWQLd/JC7i8iwEO3Fswkdxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103255;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=gF1krvmgAYG4bQY214OZvxSbHn7+z6Z9nJ4VSaWfHGQ=;
	b=40xp3qrrclSRFBoTSAaKkxUhfRF9j2Piegdt6l/6PiZr4U/M/NUWpPxcEsDWvNtv1099
	 BqL66mFN356S3ngZSYXLAk02r4fk+yBvU7pa+4RNFeNcUZwbpoVWx4EU/UBzvAQmZKak5
	 KLQ2YnSLbbeDaWpNcFZN+ex+QiSlNyVBBEW+5YPRAmNGSKrqRyvllMASIdTFL6cSeC7vz
	 E0bLZz78Xa2iAF5jU3rjfJuhB1D+G/+GO3ZYS+ggm+enJsPruoagkyn75C75GF8UEGBaB
	 E/UwgvT8V0rFSp3PSUswn2f6ziT40iPrNEUTFnTGQcSq+UxHyMVcv1J0v+9AwMngLJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=keTsDOcF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09CB606A32F;
	Tue, 27 Oct 2026 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=keTsDOcF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF051F01305;
	Tue, 27 Oct 2026 12:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793103254;
	bh=gF1krvmgAYG4bQY214OZvxSbHn7+z6Z9nJ4VSaWfHGQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=keTsDOcF7G7F+ooN9t4bItBivb0LMFM8cLAFy+Ya9JMiBTH73pCh08pe882fgPUuY
	 bIxs6JPsqRlmKh/mG47eI08xRiD5UHR2wK3y7HixHOl9J/ZP8f/F1ySYueJBWmhMfz
	 EN3MOmS1H06NlQTwNwrsHilgYwOLLKmsodXiWiJ8vYWSqPguYxIQW3Jk+fpBVhjmDJ
	 dBmApVWS/kZR6/H3g8KRviIq92S3hV6iFko0pqof0Dz6kpc3poeq3ADfqIAvIAGVfO
	 snJlPg/ysx9MOhtK0KEscjdVIkziNr2mo0XFZpTeCMFSlZivCinD5MLBV+tOJjfujs
	 +X/Kk2tqJS8FA==
Message-ID: <85fb6a33-5c41-4e25-8bdc-ac01c60b4ecd@kernel.org>
Date: Tue, 27 Oct 2026 13:14:02 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/ksm: fix userfaultfd protection during merge and
 unmerge
To: Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, xu.xin@linux.dev, chengming.zhou@linux.dev,
 ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, jglisse@redhat.com, aarcange@redhat.com,
 peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 bobbypowers@gmail.com, bgeffon@google.com, dplotnikov@virtuozzo.com,
 dgilbert@redhat.com, hughd@google.com, hannes@cmpxchg.org,
 cracauer@cons.org, mcfadden8@llnl.gov, gokhale2@llnl.gov, mgorman@suse.de,
 mike.kravetz@oracle.com, rppt@linux.vnet.ibm.com, xemul@openvz.org,
 riel@redhat.com, shli@fb.com, jthoughton@google.com, corbet@lwn.net,
 pbonzini@redhat.com, seanjc@google.com, sj@kernel.org, ziy@nvidia.com,
 stable@vger.kernel.org, samarth.colleges@gmail.com, med08elkadiri@gmail.com
References: <20261026130054.91461-1-lance.yang@linux.dev>
 <auCTv9O6F1JPyOAu@thinkstation>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <auCTv9O6F1JPyOAu@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/26 13:11, Kiryl Shutsemau wrote:
> On Mon, Oct 26, 2026 at 09:00:54PM +0800, Lance Yang wrote:
>> KSM loses userfaultfd protection when replace_page() builds a new PTE
>> from vma->vm_page_prot. Dropping its uffd bit lets a subsequent write go
>> through ordinary COW instead of userfaultfd write protection handling. For
>> RWP, a merged page also becomes readable without faulting.
>>
>> Keeping the uffd bit and restoring PAGE_NONE fixes merging, but we also
>> have to handle unmerging. An existing KSM page can be protected with RWP
>> before MADV_UNMERGEABLE, so unmerging already needs fixing independently
>> of preserving RWP during merging.
>>
>> Unsharing replaces a shared page with a private one and should leave
>> userfaultfd protection in place, as do_wp_page() already does for write
>> protection. Currently, an unshare fault reaches do_uffd_rwp() before it
>> can proceed to do_wp_page().
>>
>> - With synchronous RWP, handle_userfault() returns VM_FAULT_SIGBUS.
>>   break_ksm() then reports success with a KSM page still merged.
>>
>> - With asynchronous RWP, protection is cleared before unsharing.
>>
>> Preserve the uffd bit when merging, and restore PAGE_NONE for RWP. Let
>> FAULT_FLAG_UNSHARE skip RWP fault handling and keep PAGE_NONE on each
>> private copy as well. Unsharing can then complete with RWP still armed
>> for a subsequent access.
>>
>> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
>> Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
>> Link: https://lore.kernel.org/all/20261019010934.697895-1-samarth.colleges@gmail.com/
>> Link: https://lore.kernel.org/all/20261020055518.36087-1-lance.yang@linux.dev/
>> Cc: stable@vger.kernel.org
>> Co-developed-by: Samarth Narang <samarth.colleges@gmail.com>
>> Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> 
> Thanks for fixing this:
> 
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> 
>> @@ -1463,9 +1464,14 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
>>  		dec_mm_counter(mm, MM_ANONPAGES);
>>  	}
>>  
>> -	/* Preserve soft-dirty when replacing the page. */
>> +	/* Preserve soft-dirty and uffd protection when replacing the page. */
> 
> Small nit: the period at the end of a single-line comment looks odd to
> me. Am I the only one?

I think you are. :)

I would complain if something looks like a sentence but doesn't end with a period.

It would be different it it's not actually a full sentence.

/* preserve soft-dirty */

-- 
Cheers,

David
