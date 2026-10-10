Received: from mta0.migadu.com (out-34.mta0.migadu.com [91.218.175.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747731DB95E
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 02:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599306; cv=none; b=ojx9p1MqrwnY7Dnr1qZndRQGoslSh101VMXb6UQ5+rEfcWUjLoavTcSVYMCm4qZgfQXRXyKuzq2S+dtvT+TQjTOQdUxndMs1G7rh7R8XR5CYjBPayO/+F23XU4CTSWQU5Bbp3b+nUODWLqG1dl1Moc/dpZx8OssGvodsCVY7nmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599306; c=relaxed/simple;
	bh=urJSlmWLmOnQ+/BmKriYgMubc8WR+Lejmxapcnw2+94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JK4k70SPJ4Cz7jciGSoE0X+EVOjEMbUm1TjwZy3AKY6j9HzQptLQdiZWxqZio17mIghgjXCX3pvViWSGCpTz1t0AMlhFvWB/Bdtlg+eV/WhUAW7hSph9ov8oOwU/Jddynd/clzfJ1OIbk2nAHxC+0tYa7tqdhdzmhxdJJSSUaBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sL10LDRK; arc=none smtp.client-ip=91.218.175.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sL10LDRK"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=urJSlmWLmOnQ+/BmKriYgMubc8WR+Lejmxapcnw2+94=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791599299; v=1; x=1792204099;
 b=sL10LDRKcHejZyQIyETDMoBzjubpk1/6dYH5dPLw5KgpbvatKglQIRv6K4R3xnzuo0SZ57Ov
 O2LKuM9SPJFAHS5b0l7Q62x5TwddqJDG2i128vL0Y/66XPqfRQIdTbZqoEoDVgprF16lqrFWLch
 S+MpROm9Em3sZ9458WNUrAhg=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9ec6e0e12739ee80;
	Sat, 10 Oct 2026 02:28:19 +0000
X-Mizu-Trace-ID: 9ec6e0e12739ee80
X-Migadu-Flow: FLOW_OUT
Message-ID: <0d2f9386-fe3f-4714-8204-9d6c710ac09d@linux.dev>
Date: Sat, 10 Oct 2026 10:28:11 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: don't discard lazyfree THPs at PMD level
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
Cc: stable@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Harry Yoo <harry@kernel.org>, Kyle Zeng <kylebot@openai.com>,
 Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Lorenzo Stoakes <ljs@kernel.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20261009-lazyfree-stable-fix-v1-1-70997958ef8d@nvidia.com>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20261009-lazyfree-stable-fix-v1-1-70997958ef8d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/10 10:08, Zi Yan wrote:
> __discard_anon_folio_pmd_locked() clears a lazyfree THP PMD before it knows
> whether the folio can be discarded, and restores it if the folio was
> redirtied or has extra references. A concurrent munmap() or
> MREMAP_DONTUNMAP skips the temporary none PMD and unlinks the VMA from its
> anon_vma, so the folio stays mapped after the anon_vma is freed and a later
> rmap walk uses the freed anon_vma.
> 
> Using an invalidated PMD instead of a cleared one requires additional arch
> code fixes. Instead, disable the PMD level discard of lazyfree THPs, as
> before commit 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP during
> shrink_folio_list()").
> 
> Fixes: 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP during shrink_folio_list()")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Closes: https://lore.kernel.org/r/20261009165214.40212-2-kylebot@openai.com
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

LGTM!

Reviewed-by: Lance Yang <lance.yang@linux.dev>
