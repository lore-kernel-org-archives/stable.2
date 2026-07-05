Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A34A433E89;
	Sun,  5 Jul 2026 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783238938; cv=none; b=Ob4oqKrPiXmaL+bO5PTvpDFwQkXIjOAAQkzGv7MHoDvJjfYqvfQ0lEQMuc+r4Cqi/nOj4FV9bfjakOfVBy1sR5yYkWjARiBY5+BFXld52K0ozSyzmcgFx6hvw8WOmR20iPerYC+/9hqmDSO8mlI1zxnIMS21KzSOIXMR7mijcvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783238938; c=relaxed/simple;
	bh=cIrRmXjneRyxZCYVtjOisOC7Q6AqKSJ27U6Pgn9w7QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MiKitv8sqLbLZ+GFa1L11vvkqBETmI7uBFNq9I8yZG3WHzFLzpG12iKBJITcGRNBeirYolfgaRhlhbaaa0DaYMNpap+utRDWdx5xpnpm2LCjDQoAKNqoW8AC1gzunSak5PTl73qbWBO0g+u4l0EsXYrjDeM0nzJ9LJaG/WSka1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FqQCx48U; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FqQCx48U"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA63B1D70;
	Sun,  5 Jul 2026 01:08:50 -0700 (PDT)
Received: from [10.57.73.18] (unknown [10.57.73.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC3F53F905;
	Sun,  5 Jul 2026 01:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783238935; bh=cIrRmXjneRyxZCYVtjOisOC7Q6AqKSJ27U6Pgn9w7QE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FqQCx48UJNUfeHogU9/y9HwEqlbbhAQ6HAGisLpAoZ06/5JM87N/K8zIXSOkQS9Lo
	 tzFVemZDjh6FMqDs/3oBIzs/gxTzjo2BY91OzyLW22GOwYSGCjWr8ywmF0OCMoI9D1
	 02im7RrlbLfHvqkoRtrjjP2YXspf26q5PHLafXU8=
Message-ID: <8fdbe0d6-87fd-441c-b6d2-baac380f6fb3@arm.com>
Date: Sun, 5 Jul 2026 13:38:41 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] arm64: make huge_ptep_get handled unaligned
 addresses
To: Andrew Morton <akpm@linux-foundation.org>
Cc: muchun.song@linux.dev, osalvador@suse.de, ljs@kernel.org,
 david@kernel.org, liam@infradead.org, riel@surriel.com, vbabka@kernel.org,
 harry@kernel.org, jannh@google.com, lance.yang@linux.dev, kas@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, apopple@nvidia.com,
 rcampbell@nvidia.com, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, ak@linux.intel.com,
 nao.horiguchi@gmail.com, mel@csn.ul.ie, j-nomura@ce.jp.nec.com,
 pfalcato@suse.de, tglx@kernel.org, dave.hansen@intel.com,
 jpoimboe@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, stable@vger.kernel.org
References: <20260703114202.365553-1-dev.jain@arm.com>
 <20260703114202.365553-2-dev.jain@arm.com>
 <20260705003559.8b124d2b94b685cc2e4e77ae@linux-foundation.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260705003559.8b124d2b94b685cc2e4e77ae@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/07/26 1:05 pm, Andrew Morton wrote:
> On Fri,  3 Jul 2026 11:41:54 +0000 Dev Jain <dev.jain@arm.com> wrote:
> 
>> huge_ptep_get() can be handed a virtual address pointing to the middle of
>> a contpmd/contpte mapped hugetlb folio (examples of callers are
>> pagemap_hugetlb_range, page_mapped_in_vma).
>>
>> The arm64 helper rewalks the pgtables in find_num_contig to answer whether
>> the huge pte we have maps a contpmd or a contpte hugetlb folio, and
>> returns CONT_PMDS or CONT_PTES, so that it can collect a/d bits over the
>> contiguous ptes. We can falsely return CONT_PTES instead of CONT_PMDS
>> if the addr is not aligned.
>>
>> Fix this by aligning the pmdp pointer down to a contpmd base before
>> checking equality with the passed huge pte pointer, to correctly answer
>> whether the huge pte is the base of a contpmd block.
>>
>> Fixes: 29cb80519689 ("arm64: hugetlb: Cleanup huge_pte size discovery mechanisms")
>> Cc: stable@vger.kernel.org
> 
> Please describe the userspace-visible effects of bugs when fixing them.
> Particularly when cc:stable is proposed.  Thanks.

Forgot for this one. It should be, on systems where CONT_PTES != CONT_PMDS
(meaning page size is 16K) we could collect excess a/d bit state, meaning
extra work for the kernel.


> 

