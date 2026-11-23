Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795419866;
	b=IwhOK0oEIwVestnMJV+7RdX70D6Ibygm+HjtK91689r74hVNCt5x1OIAS0dolp/wTFv1
	 bklHELQRKQsv95T4HqG/JNKXhF0w/RHfhj6gOSoZtgMOO+38gUsN6SsQVU3rFsa5akezW
	 Eb4KAGaEWNtp4qATfsUHoUYm48/88N9fXa+kOk52cMsC6KKTQ4USNe0VWlqkxfnjYi0bW
	 CCUwKz/FHYkkFjA9izK85mb9iWkuZTm1C1Aqrqj9QLeMBwFFRgXSHf+jjZQWouxH9NG4w
	 EYgidE4MQWZJmwAN5KgtwM5TGb/n9vPnVzVQiURjueygjRy78Srg1ZsQUTCNpSASjCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795419866;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=JJkQya4c8RJJzm9nBLBXauSmtfVWdU74c+91+UOjFS4=;
	b=mQEt4JyTrbfXgHXk9yAjPuVKT2/w/TOWQuzRHYrhC6LLGRln8zFOrySOdojpWusIvyr+
	 2dQgJ0duDFV/T0aXJjYoYPp/ot4CuYgZSaezTVX3o1a1qPofNVqTBIoaCCD16PdkgF2hX
	 9vi9x96uFzk+tuuSMYIzkraVWirYpL9ILhInkf1OMmIj0uSiBUq6RvFUMtTBYRDvB6rs2
	 qpaU7x8xQAreR9O8oKGNPOntTtR4UCOf884aD/aaJKkcAkZSVhRoVW4iz8yXVPbzvMF9w
	 OQ61bJX+YP/iGcIAA23JkRzNFYZiuR1zXeyHFRw7AHKPsWTxX0VNUNpUanVvNQxgg/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sgiDxWF5;
	arc=none smtp.remote-ip=115.124.30.130
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B822606A31A;
	Mon, 23 Nov 2026 07:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B822606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sgiDxWF5
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795419860; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JJkQya4c8RJJzm9nBLBXauSmtfVWdU74c+91+UOjFS4=;
	b=sgiDxWF5OA5YOgNMG93UL46ORr5yEZW7x2UAeAqBJmqgb7VMKlzdZToOVKFWaAl6K5ZB40FPt5mzGOgKr2T9rQYkl27gZ44ULm+yhN1K10svHoJYBTpGs9+ewKnmcDhLT/5vGQLORWOkJRKHlb+CXYbIxFEWOy3uum61isQp+Tg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0XFFWEwR_1795419856;
Received: from 30.74.144.153(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XFFWEwR_1795419856 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Nov 2026 15:44:18 +0800
Message-ID: <d6c70716-86a7-46f1-abac-57e3c909d214@linux.alibaba.com>
Date: Mon, 23 Nov 2026 15:44:15 +0800
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
Subject: Re: [PATCH] mm/madvise: fix MADV_FREE handling for PMD-mapped THPs
To: "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, Ying Huang <huang.ying.caritas@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>, Sashiko <sashiko-bot@kernel.org>
References: <20261119-madv_free_thp-v1-1-a312919e1ee5@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261119-madv_free_thp-v1-1-a312919e1ee5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/20/26 12:04 AM, David Hildenbrand (Arm) wrote:
> After MADV_FREE cleared the dirty flag of an anonymous folio, reclaim will
> later free the folio without writing it back if no mappings are dirty.
> 
> If our folio is still in the swap cache, the swap entries then point at
> swap slots that were never written, exposing stale content of the swap
> device. Bad.
> 
> madvise_free_pte_range() therefore frees the swap slots first, and skips
> the folio if that is impossible. madvise_free_huge_pmd() does not, and a
> PMD-mapped THP can be in the swap cache if try_to_unmap() failed during
> reclaim, for example due to a racing mlock().
> 
> Further, madvise_free_huge_pmd() checks whether the THP is mapped by
> other processes before taking the folio lock. Another process that still
> has swap entries for the THP can concurrently map it from the swap cache,
> and we might end up clearing the dirty flag of a shared folio.
> 
> Fix it by factoring out the folio handling of madvise_free_pte_range()
> into madvise_free_try_prepare_folio(), and using it for PMD-mapped THPs
> as well. Hopefully this prevents further bugs.
> 
> For PMD-mapped THPs, this change implies:
> 
> 1. We free the swap slots of a THP in the swap cache, and skip the THP if
>     that is impossible.
> 2. We check the mapcount under the folio lock.
> 3. We no longer lock and check THPs that are neither dirty nor in the
>     swap cache, just like for PTE-mapped folios.
> 
> For PTE-mapped folios, this means:
> 
> 4. We check the mapcount once before taking the folio lock, to not lock
>     folios that are mapped by other processes.
> 
> Only compile madvise_free_huge_pmd() with CONFIG_ADVISE_SYSCALLS to keep
> !CONFIG_ADVISE_SYSCALLS builds working.
> 
> Chris and Sashiko reported the missing swap cache handling for PMD-mapped
> THPs, the other issue was found by code inspection.
> 
> This has medium urgency.
> 
> Fixes: bd4c82c22c36 ("mm, THP, swap: delay splitting THP after swapped out")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/sashiko-outbox-202086@kernel.org/
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Make sense to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
