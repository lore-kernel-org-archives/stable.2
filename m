Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106806;
	b=DAyAMTUghy4Pyfo8mYufValXZ1zn4pWo0C+72uYYNr69na4aJcmoway2CFGquAVdpl0p
	 C+x/q1TM4tctFDEAu9e066ZW3JIaQSp+yUYsTtU8zTeZ6/Uocrybig/dIjA8O1hilmIgc
	 mtBZL+X5glSEGo1bCx4ZZxmTxxyM4KPzJ0rCDxlm2i+oACRLwxA6vfVIZ+G69JzDqRvnB
	 B5kvgZLRxnOiHy5AzDKlJbQuHJnwnCm3DN82paIWJm2g01bDztIA8634Y2oyBsS2p3W/w
	 tK51d2qTHowfQgQO8EmSlcnZytZmkJtDw429SEzrzBrOKqGbuHTLKycAnyDEeDjG5Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106806;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=+k7jQIisBr/EB9/SFTt/Z05L9GkTQwwbMLBurwVBaeA=;
	b=yU1pc+qkIpWzARueHmzAmR3dN/nwcyiZ/82/5JJ5dPYu8zLJtfuMhBxW8sR020sR69Lf
	 ieAWEVWF7PMNTVQSwsLyfvvl7/w/zO7XLbUn8RPFO2vz/5YA+R0RhzEQtZfLY2N4E6Z1N
	 nxcJRoFBtogNWXVI7lKmVbomq52hpvenP1aYbE9aMflmRpS5GBJRPef0PTojKEx0BudjA
	 FUhqB0DjJot4osxRw0LpiFBL1AZFkoli0f9xo6R6iS0+NmJEScmwtp/yCqUEjzCDr+ahm
	 fpEEZg/WBX6p8KOX2/C571qBWMLuvDyeNtPmWStMNXWXD1tiiOadBYDp+78Mi6Epy9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i5XtRq9Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C3D606A334;
	Thu, 19 Nov 2026 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i5XtRq9Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1A21F000C4;
	Thu, 19 Nov 2026 16:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795106806;
	bh=+k7jQIisBr/EB9/SFTt/Z05L9GkTQwwbMLBurwVBaeA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=i5XtRq9QO/asg49e9AMgG7FHzZMOk+0LZWdqPC81ZGDMQVztBteHuZiCZrtHlHUjD
	 Gcj5/tBy4iSqlEsZRjcnggB3JjL9l4rcfZ/UWiggi9qrvVd9UQgmP1s5Q8e+zouIgB
	 KwwwWre1VcYs5Y9oHbrX1JPxdvnEe/Bhz2teJlaqcble0zYgDNCotCT+YZgGuSlE71
	 hIldK48bkgh/YlkHTGtRtMAA99dBVJfNxJyJvlo4564BHV7HRDMB8vypx8pkqHAqyZ
	 O/Hs9mhuRF21ifpdayx26eS9JN5EyHtGqjKTL/w+SgHw+q1ge/rP2guxlkJFvGRPQu
	 q3VCNckRb3fCg==
Message-ID: <a2b68112-1c04-4291-9c59-f9b258b97354@kernel.org>
Date: Thu, 19 Nov 2026 17:46:40 +0100
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
Subject: Re: [PATCH] mm/mprotect: don't skip uffd marker install when racing
 with PTE table reclaim
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Qi Zheng <qi.zheng@linux.dev>, Tal Zussman <tz2294@columbia.edu>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261107-uffd_shmem_marker-v1-1-91fa2d653cfe@kernel.org>
 <av8EisTx8vlYID0b@gremlin>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <av8EisTx8vlYID0b@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/26 15:24, Lorenzo Stoakes (ARM) wrote:
> On Sat, Nov 07, 2026 at 12:28:55AM +0100, David Hildenbrand (Arm) wrote:
>> change_pmd_range() populates PTE tables before installing uffd-wp
>> markers. An empty PTE table can be removed after change_pmd_prepare()
>> returns but before the pmd_none() check.
> 
> These *** wp markers man :)

Tell me about it ...

> 
>>
>> That check then skips the range, allowing UFFDIO_WRITEPROTECT to report
>> success without installing the required markers. Subsequent writes by
>> userspace to these areas will not trigger uffd events.
>>
>> PTE table reclaim during MADV_DONTNEED and page table retraction during
>> khugepaged can trigger this.
>>
>> Retry page-table allocation in that case. Simplify the code, getting
>> rid of change_pmd_prepare() by routing all code through the "again" label.
>>
>> It's a small race though, so likely this is not very urgent.
>>
>> Fixes: fe2567eb5521 ("mm/shmem: allow uffd wr-protect none pte for file-backed mem")
>> Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> LGTM, so:
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Thanks

-- 
Cheers,

David
