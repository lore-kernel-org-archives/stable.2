Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BF93EFFA6
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 06:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959571; cv=none; b=l8H2bcGs1gy+FtKxWRz0pjN2S3tnO80SioWkPhROxmBSIMMF60VFAiDl30gsN1KfRUUENn4PjbKFZ+7mdrlc21I6KfBbYnkgs00k5VMUlQwn5Z9mqieTGxO0erKzNPsttim4oS9p2feI+CR+yzoZQP11jtD1ihXbsllqOD2Kbwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959571; c=relaxed/simple;
	bh=2TV1f3bnq5f4ScvT6q6LW4A6jRa5qaEODzuqdxj1bLU=;
	h=Cc:Subject:Date:Mime-Version:Message-Id:From:In-Reply-To:To:
	 Content-Type:References; b=JRlOb8GlvlQE8pP8YBb2EgfOb6Aa4I5Gyt9ksJ0qIeWEjEoRA1+NpyKfYDSxg/uScPAeJEclENzfQGhlYf9SAxNDtkvIGIIw7w+D/oii9JfyeYxlhmy2CRofCxTv8s+s4H5LFj8v1oFLwJszg+YqloaxMqbG9j5Rb2y1FCOlH3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iTcsN+by; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iTcsN+by"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1791959549; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=1JmrvG8Wxu6YtXiksiU23e1HswNsSn5IxgMS7VCL0AQ=;
 b=iTcsN+byvXNYl6hTEYFqWX8+lbU4twF9xpYtGiOH6InWYmZLRqwfNMRVz2t9bQimc7k9wT
 TjkrOpTjyMYV0WQRL/7JsX086c7rmWh8yDTyg1tRrw0GVt6pd9X069YGiieE/+AVvmY96/
 4YNt0N5ny7Cc8RSMUwpZOnIruFiZmL+/w6ugOS785/hv32r11tWTr5tmln3UEk0x9vY/el
 cBbhbF99VxUyecqIeirKDMSNlEH8Cm/L/vWN6pOg3KjscQLrt0n9yj3NWAl0GpC7H1jDrc
 +QeZlz//gprlBGa91xMSxHvpPReT7tsIW/XlcFZSW18OJhIHtFWsnCQr/jTOtA==
Cc: <catalin.marinas@arm.com>, <will@kernel.org>, <ryan.roberts@arm.com>, 
	<dev.jain@arm.com>, <baolin.wang@linux.alibaba.com>, 
	<mark.rutland@arm.com>, <akpm@linux-foundation.org>, <david@kernel.org>, 
	<ljs@kernel.org>, <liam@infradead.org>, <vbabka@kernel.org>, 
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, 
	<linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] arm64/mm: restrict transparent contpte mappings to valid PTEs
Date: Wed, 14 Oct 2026 14:31:59 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26acf21fb+be267d+vger.kernel.org+zhaogongyi@bytedance.com>
Content-Transfer-Encoding: 7bit
Message-Id: <516828fb-558d-4a20-9532-51f50d6ba042@bytedance.com>
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
User-Agent: Mozilla Thunderbird
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
In-Reply-To: <20261013153953.77575-1-lance.yang@linux.dev>
To: "Lance Yang" <lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
References: <20261013093600.54995-1-zhaogongyi@bytedance.com> <20261013153953.77575-1-lance.yang@linux.dev>

On 10/13/26 11:39 PM, Lance Yang wrote:
>>
>> +	/*
>> +	 * Keep the producer-side invariant documented in pgtable.h true even
>> +	 * if a direct caller passes an invalid descriptor with PTE_CONT set.
>> +	 */
>> +	if (!pte_valid(pte))
>> +		return __set_ptes(mm, addr, ptep, pte_mknoncont(pte), nr);
> 
> set_ptes() is the only in-tree caller, and it already clears PTE_CONT
> before we get here ... no? Why not fold !pte_valid(pte) into the
> !mm_is_user(mm) check below and return __set_ptes() directly?
> 
> 	if (!mm_is_user(mm) || !pte_valid(pte))
> 		return __set_ptes(mm, addr, ptep, pte, nr);
> 
> If a direct caller does pass a !pte_valid PTE with PTE_CONT set, I'd
> rather add a VM_WARN_ON() to catch that. Silently clearing the bit would
> hide a caller bug :)
> 

Hi Lance,

Thanks for taking a look.

Yes, you are right. The public set_ptes() wrapper already strips PTE_CONT
before calling contpte_set_ptes(), so the pte_mknoncont() in the invalid
path is unnecessary for the current in-tree path.

The issue I was trying to avoid is not that the incoming pte already has
PTE_CONT set, but that contpte_set_ptes() rebuilds the pte from pfn/prot
and then adds PTE_CONT again based on alignment. For an invalid descriptor,
that transparent contiguous encoding should be skipped entirely.

So your suggested shape makes sense to me. I will change this to return
through __set_ptes() directly for invalid descriptors, and add a warning
for any unexpected direct caller that passes an invalid PTE with PTE_CONT
set, e.g.:

	if (!mm_is_user(mm) || !pte_valid(pte)) {
		VM_WARN_ON_ONCE(!pte_valid(pte) && pte_cont(pte));
		return __set_ptes(mm, addr, ptep, pte, nr);
	}

That keeps the fix focused on not creating new invalid contpte entries,
while still catching a bad direct caller instead of silently sanitizing it.

Thanks,
Zhao
