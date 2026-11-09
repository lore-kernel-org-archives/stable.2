Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234376;
	b=CrSza2jdpVE3x0mz0fXwv6JJ3U7EIIX/il8EXUa5GlDbueIMRP8CEiKPbDL8zzPBq1Pt
	 t4pucIxB1hOKt41LBlWLwEdItKqM3PInB9wS14CFN4Sr74EhvFnsdGWfosB3i6uM58Q0Y
	 iWXhZ7UEatoi9WCo6LtzbB7nLeaGT2IlU5nBWKKc1B5EwThKYpVHywKAAJbtlYOs9f68J
	 j41LaTN3BUURmCGTTZ1c74jiHSICJISwxacEz+EdOYnLjn0iDD0rbqEtoMD0lXegBRwWd
	 p3Gm97LxZn53gCe6ZsiJEPm/ngW3b5gQn9BYnKm6uCOmyokejdMbLrhLL7xMhbXUJTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234376;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=B9llKXUjtBg6NYHrvZa2RZ0JKeiVE2awkqQc7/d86Ts=;
	b=KeGUNAj1x/xYut8DAjKrAU5n1w2K8e5x/tKknu5i4kfArXpnTjuTLnzB3oO3QLinMNel
	 sdiOKqsrwcaeBnWxeVGBkfhwvhRd63Uuv9etpGnFAu5tmBjNZZnW+X5cflfap+s6+G9uB
	 pPmpzxLC3M+V+jwlPo7hMPRnOLLqKFugqwYVJV2JbpcciV28CRRwETRDlFsZBcFwyO/VY
	 6ROhLkqJSWVwSR03f/9RdCgJazBCgHpPJVUCeDumySNj5+cD+S+GzIemtjxLFyU7u2Y5b
	 8WmT63iTLzfKQzs9x5MaEllBKGWgb8tJ91NrUeEJ3T13KZwMomZpBI2pPpyxs/dSeLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DMOktpQ7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3231E606A321;
	Mon,  9 Nov 2026 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DMOktpQ7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7199F1F0089F;
	Mon,  9 Nov 2026 14:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794234375;
	bh=B9llKXUjtBg6NYHrvZa2RZ0JKeiVE2awkqQc7/d86Ts=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DMOktpQ73zOGC8v05iI/+U/1YfqHpq9vNS608Oycv4UNs8X1mYegSrCtypjvxWnF6
	 L4DV3s1GLDSfcLfCzBFgTmIIEfFwCXb5WYu+pWDZsjFgBHslsKmwVy831p+zDvPFnU
	 zGRlYzuxhnJnMZ2V0bJYk3maeqoanOEScQayztjdOZsLdbkhgHFf1RXkus0Vpczaft
	 mGnaoV5SYoXQUWqb4GQ+UkRlNz0iMVjc9vlSolytFBzEM6yxdlx12vvU+ctoUAKATB
	 +9Wc5UDGNQzrPuPHc2NvGxxYeTpI0F7H5ZizL2UrMXvVw4NIfnZ7n/opOWFU9rjEu4
	 8qPoSrS3USUTA==
Message-ID: <788856b1-754b-44cb-a5ca-676400d29a76@kernel.org>
Date: Mon, 9 Nov 2026 15:26:10 +0100
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
Subject: Re: [PATCH v2 1/2] mm: free unused page table allocated by
 do_set_pmd()
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
 Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261106153414.2938216-1-usama.arif@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261106153414.2938216-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 16:34, Usama Arif wrote:
> On Fri, 06 Nov 2026 13:36:12 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:
> 
>> do_set_pmd() can allocate vmf->prealloc_pte on architectures that need a
>> deposited page table, such as PowerPC with the hash MMU. If the PMD is
>> no longer empty when it takes the PMD lock, it returns VM_FAULT_FALLBACK
>> without consuming that table.
>>
>> Since collapse_pte_mapped_thp() uses mmap_read_lock(), a concurrent
>> userfaultfd operation can install a PTE table before taking the folio
>> lock. If that races with set_huge_pmd(), the unused preallocated table
>> is lost when its local vm_fault goes out of scope.
>>
>> Track whether do_set_pmd() allocated the table and free it after dropping
>> the PMD lock if it was not consumed. Preserve any preallocated table
>> supplied by the caller for PTE fallback. Successful PMD installation
>> consumes the table and clears the pointer.
>>
>> Returning without a preallocated table matches the existing behavior on
>> architectures that do not need a deposited table. All callers
>> already handle that case.
>>
>> Fixes: 1043173eb5eb ("mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  mm/memory.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
> 
> Acked-by: Usama Arif <usama.arif@linux.dev>
> 
> Reminded me of lazy pagetable deposit series :)

Not just you. haha :)

-- 
Cheers,

David
