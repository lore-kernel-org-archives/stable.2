Received: from mta1.migadu.com (out-203.mta1.migadu.com [95.215.58.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA86A221F26
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 01:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791594784; cv=none; b=SP+SzzKvBeRC1oiLlKCiShjCaDFE5NTHfvZdAXcQujxtMl1ZJIGTubmxrx6qJeS+W0++bSxmnSyevMo2wRECpcD2VVaSBhGN7oQ0HBTPoDTJHSiSL7jYwFq7BUumj3K1edAHsQIUh5FwYaX7VY1xXIokk3ipwjBa2IM4gdiQEyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791594784; c=relaxed/simple;
	bh=vgSSjwqoJ3UL9SpCaxLIlO+CXMUgBIurc/MPR7NqdSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XvYOylWINM12RxSR5yXgON51X0HwFrWTpXUcYiWrbOqXRBLcFXiCcFyopFNURSovF8isgZzOcYbdZQgV2tFCa0lvkALjV9KQGGCs1TqLBDN6nG6RlA6BB2rDtwCZ+RrwX4LRXC9dnbFUDM7cktUuLK4XW52vBPsdM8llQ6GuEug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hg2oA4vQ; arc=none smtp.client-ip=95.215.58.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hg2oA4vQ"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vgSSjwqoJ3UL9SpCaxLIlO+CXMUgBIurc/MPR7NqdSQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791594779; v=1; x=1792199579;
 b=hg2oA4vQ4SiQPWoa8gt3sTBnuZs5ox+3Syuyla4g6zq7cwfE7gZ7i2ogDBFoZ6CPz1E3rvwb
 fi/y0+u+GpiJhDbLHzmTZXahtcfAEj0395D9giLkuVTrZdDXiyNl3IBzP6abI/zZ1ABYftNIBhX
 mQQ22QPZE/KkYgeLlBN55gJw=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9e75b8b92041ffeb;
	Sat, 10 Oct 2026 01:12:59 +0000
X-Mizu-Trace-ID: 9e75b8b92041ffeb
X-Migadu-Flow: FLOW_OUT
Message-ID: <0ec81c65-fbf5-405f-948b-0fb1b2e083e8@linux.dev>
Date: Sat, 10 Oct 2026 09:12:48 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: avoid transient none PMDs during lazyfree
 reclaim
To: "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>
Cc: Kyle Zeng <kylebot@openai.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 stable@vger.kernel.org
References: <20261009165214.40212-2-kylebot@openai.com>
 <DM0II2QHWWS1.2RXEJXC8S0101@nvidia.com>
 <8db35dc0-eb06-42e4-90f9-534522e810e1@kernel.org>
 <55765FF3-18D7-424C-984D-81C316F323E1@nvidia.com>
 <d68cb3de-e471-4ce8-8c6d-c7260d79ec1e@kernel.org>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <d68cb3de-e471-4ce8-8c6d-c7260d79ec1e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/10 04:44, David Hildenbrand (Arm) wrote:
> On 10/9/26 22:27, Zi Yan wrote:
>> On 9 Oct 2026, at 16:23, David Hildenbrand (Arm) wrote:
>>
>>> On 10/9/26 20:17, Zi Yan wrote:
>>>>
>>>> There are some gaps we need to close before getting this fix in:
>>>>
>>>> 1. GUP-fast cannot follow the invalidated PMD: riscv and LoongArch need
>>>> pmd_access_permitted() that requires _PAGE_PRESENT; s390's
>>>> pmdp_invalidate() needs a change.
>>>
>>> Ugh. We really need pmdp_invalidate() to have reasonable semantics. This whole
>>> PMD locking is a mess :(
>>>
>>>>
>>>> 2. sparc64's thp_pte_count can be imbalanced with this change (based on
>>>> Lance's offlist feedback).
>>>
>>> Ack.
>>>
>>>>
>>>> In addition, powerpc has a page table check issue similr to riscv, where riscv
>>>> fixed it with commit 9f4a88b8d01a6. This is not related to this issue
>>>> but discovered along with the investigation.
>>>
>>> Zi, do you have the capacity to take over this patch?
>>
>> Yes, I can take over it. My plan is to send a series including
>> patches for 1 and this patch as is. powerpc fix can be a separate one.
>>
>> Best Regards,
>> Yan, Zi
> 
> If we need a quick stable fix we could temporarily disable the whole thing until
> it is fixed, just a thought.

+1 we could do that for now. A quick fix with minimal churn (correctness 
comes first).
