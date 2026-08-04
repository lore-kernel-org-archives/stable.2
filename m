Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6027D18A92F
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836996; cv=none; b=K66Ldla0yljxGGp+M9eEwvoFwABLfBQXvFPHu4X0GuT6x1Un9rthke0jAwC8LAuHy4WOZb0szHydvcVz8WusedJxvBOZSyJ8eDKmPOJIilcFwuLBiREwVvAlyXMA5DW9ro5nFakQTtYm7WtWaeKoL1/lqpNVnk9oQYjh+X8FNjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836996; c=relaxed/simple;
	bh=0rQuZGGzfMjCG0FpIW84EoAmTPvDLT8hzCjzULUE6Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEQ1Z2QpgzCxNILO8cex13kgvJeV7jwd34z8W+E6PjO575dunagzJdKJDhK2b95Jlhooa3RKcWnwvU1h7DiMjjpkXSgJn8JrWBlCro+N0uGfTI4WGrf0hjtCujko9jB1Nfg4YEYlkXRpk9yvgyhF31usuby338zfkOjY26HbqYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hZ/LAolu; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hZ/LAolu"
Message-ID: <1745d0cd-c1a6-46c6-a054-ff4c08753dd1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785836988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8266ewtSQqX33fmCJb17/XpTd+S9uHhwz2iKFF7QQyc=;
	b=hZ/LAoluwG0aKwBytwdZ91mVyYvdi7/kqhI/26i1QWrQ7LY8p+j/Rk6+nq92Dh4t7hny+/
	Ui0LUpwffcRdHZfELdNgR7dlUnuj34vzHSpr2dxhB7DrwPTitcjr7MMxojG5yMbAsYw6OP
	TeEAs8mtygdFAmDhuNBcCdlFJLJ5eaM=
Date: Tue, 4 Aug 2026 17:49:04 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Fix incorrect flush address in direct page table reclaim
To: "David Hildenbrand (Arm)" <david@kernel.org>, luto@kernel.org,
 linux-mm@kvack.org
Cc: luto@amacapital.net, Liam Howlett <liam.howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
References: <20260804003708.49830-1-luto@kernel.org>
 <313133db-3b94-4a63-8bcd-21952ff77e41@kernel.org>
 <8cf8eaca-fc04-4a68-bbc8-50ecdbf96382@linux.dev>
 <3d3aa670-76bc-4df3-9c36-609c14354e9e@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <3d3aa670-76bc-4df3-9c36-609c14354e9e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/4/26 5:34 PM, David Hildenbrand (Arm) wrote:
> On 8/4/26 11:25, Qi Zheng wrote:
>>
>>
>> On 8/4/26 5:05 PM, David Hildenbrand (Arm) wrote:
>>> On 8/4/26 02:37, luto@kernel.org wrote:
>>>> From: Andy Lutomirski <luto@kernel.org>
>>>>
>>>> When zap_pte_range reclaims a page table, it does:
>>>>
>>>>       pte_free_tlb(tlb, pmd_pgtable(pmdval), addr);
>>>>
>>>> and this is unconditionally wrong: if this code executes, addr *always*
>>>> points one past the end of the range covered by the table.  The addr
>>>> parameter is used to flush the TLB (really the paging-structure-cache)
>>>> to drop references to the to-be-freed table, and any architecture that
>>>> cares about the parameter will flush the wrong address.  (But they'll
>>>> still free the correct page).
>>>>
>>>> I think it's worth contemplating why the kernel works at all.
>>>
>>> Note that this only triggers when someone does e.g., a MADV_DONTNEED over
>>> a large enough range (covering at least a full PTE table).
>>>
>>> So this isn't the ordinary munmap()/exit() page table reclaim code.
>>>
>>> I'm still surprised that it took so long to show up; likely we need more
>>> targeted tests for PT_RECLAIM that
>>
>> We backported the PT_RECLAIM to our internal tree a while ago (excluding
>> the rework patch being fixed here), and it has been running stably ever
>> since.
> 
> I'm wondering whether we should have a selftest that triggers this exact scenario:
> 
> (a) Populate page table(s)
> (b) MADV_DONTNEED to reclaim the page table(s)
> (c) Allocate plenty of pages for another purpose (draining PCP where the page
>      table likely ended up) and fill them with some data that looks like present page
>      table entries.
> (d) Re-access the reclaimed VA space, expecting re-population of anonymous
>      pages.
> 
> I can find someone to work on that.

That's great!

> 
> Any other ideas what we could check? We could certainly also check that the page table
> was actually reclaimed during MADV_DONTNEED.

Right, only the empty PTEs corresponding to fully PMD_SIZE - aligned PMD
will be reclaimed. We should probably include this kind of basic testing
in kselftests.

Thanks,
Qi

> 

