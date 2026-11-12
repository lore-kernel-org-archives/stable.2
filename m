Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464002;
	b=EuIi9W7A4M3AD9dx/MAirh+6+rSkqqG3UG63MEmIpA95y44ldVIWdz7Q38Bnao0HSagZ
	 UgzWaLgOmnsH88X9S/Ult7Lde0fPOWlH5Z5KIydSmDUutOJ+eLjLJ8PctRTAd7AyRjJIl
	 oCGZtvJR0UKX2jyi1+cwSJ2XTjaBmP5/bx6zV65KW1z+WW4j5m0P5pRGTZ+4rRTvM6cw9
	 dMzzaeOleik8+Muggdo5E7Hl205wzKDbDs8Q+ECaIAGp/E0vTaMCXoeobzic1wQc/i8hV
	 71vdpvuEmoa41Rk1uy8Jcgi+DwVv+qjE9hSfLcawZXTzWYB+Q+ZBjAwWPj9wmbVP2HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464002;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=IuShiHyRyDZxBf6e8YOm6MFfw5BWDF9yKQbfeeu8nmE=;
	b=uEzxGs1oWWECpMLxRhvrKDX4/lcbToYtDDS8C9XxjC9NTSB3UV91lDkACHxf0FnnqmIR
	 cuU56X9dpW/EFbTPAA6vCkAxPGb4uj+WOpaCj6PvG3BNnzTeX3+lOoKDGKlUqH8eWzrbJ
	 Ce4NAdn7gBhKsuJI5hZrtcPpTNj7b76aeHAtGzOYI1K1n8EINF4o1arRk1cUD8XiCRYY5
	 kqUwT17nCRXVR3cG/6QBzDoUKwE6+DeXn9d1wzgLHPO0sFrEzHC4xiUQ5QH/fdzPEGmW1
	 v3pS4ZD9hETdtTLOWe89CKRbOlZCjpclOOlIyOfkKMzxLmbieogmTRS55UKYIpoXX/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JzuWZzGI;
	arc=none smtp.remote-ip=91.218.175.36
Received: from mta0.migadu.com (out-36.mta0.migadu.com [91.218.175.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C17606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 06:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02C17606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JzuWZzGI
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vN3Xm+gcrUO1WDmKGVle2xItUFZzcDTDyabC98afJ8s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794463999; v=1; x=1795068799;
 b=JzuWZzGIGjhlExhBiHKdumURCs82ANwESjEmR6fuXdFUxD/HMo8GyG7nln5rPeCUPYdOjCjv
 6Hjcrvi/Kgw8oe2NW5YrQQTszhMNkOjS9GbMAk3/lwMCB89FKKfazRWP5ycxS49rnQHdC42EF91
 A0qw+/EpE/kVNIorHcAQlF4g=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a59a91c215b2ecd2;
	Thu, 12 Nov 2026 06:13:19 +0000
X-Mizu-Trace-ID: a59a91c215b2ecd2
X-Migadu-Flow: FLOW_OUT
Message-ID: <1116fd15-a927-4f6e-a0ab-084bc36a90aa@linux.dev>
Date: Thu, 12 Nov 2026 14:13:10 +0800
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
Subject: Re: [PATCH v4 2/3] mm: gup: allow long-term pins of CMA-allocated
 HugeTLB folios
To: Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@kernel.org>
Cc: osalvador@suse.de, akpm@linux-foundation.org, azpijr@gmail.com,
 Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1794379433.git.zhengqi.arch@bytedance.com>
 <503c9f6d869e3206c6fd591de962c3d619b73825.1794379433.git.zhengqi.arch@bytedance.com>
 <80FED512-77D2-4D49-BAE5-745CE1F711CA@linux.dev>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <80FED512-77D2-4D49-BAE5-745CE1F711CA@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/11/26 3:42 PM, Muchun Song wrote:
> 
> 
>> On Nov 11, 2026, at 14:46, Qi Zheng <qi.zheng@linux.dev> wrote:
>>
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Long-term pinning treats explicitly CMA-allocated HugeTLB folios as
>> unpinnable, causing unnecessary migration or pinning failures.
>>
>> These folios already own their CMA bitmap ranges, and memory blocks
> 
> Commit message needs updating to bitmap as well.

Will do.

> 
>> overlapping CMA areas cannot be offlined. Allow HugeTLB folios with
>> HPG_cma to be pinned directly, including in ZONE_MOVABLE.
>>
>> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Muchun Song <muchun.song@linux.dev>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Acked-by: Muchun Song <muchun.song@linux.dev>
>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
>> ---
>> include/linux/mm.h | 29 +----------------------------
>> mm/gup.c           | 31 +++++++++++++++++++++++++++++++
>> 2 files changed, 32 insertions(+), 28 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index b0da9be413098..47d1d96bfc7fd 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2954,35 +2954,8 @@ static inline bool is_zero_folio(const struct folio *folio)
>> 	return is_zero_page(&folio->page);
>> }
>>
>> -/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
>> #ifdef CONFIG_MIGRATION
>> -static inline bool folio_is_longterm_pinnable(struct folio *folio)
> 
> I think David prefer to move this function first, then fix it in a separate patch,
> right?

Hi David, is this what you mean? If so, I will split it into two patches
for the v5.

Thanks,
Qi

