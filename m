Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271790;
	b=MvD0i7Zy2c94r6uMksEFoClz5e+reMeAOnGz0uJuyPQu7EWMpAqnXPOVy2Ib7UcFMui8
	 0J/6CogwAOPOIPWFJUTA5ha0l6lCLsUlwJemvmob1hNZV6qjS2jjPH1Pz+j3z9d9H4ucP
	 UQ+Ukv19za2Q17b7RH6mhb0FPYutXzTNnRN4C9ssNrGIhrVrzHp1YGIESmc/5MT7SqTCq
	 H1naNUwfI1eIr6cIS/oLQvDroU7FhboIDcPwqRweXqQPhBSLE8W3hvqwrN8wmzPFR+FH0
	 PwAOAta/KEonjKa844PHUvNCCVYKhxTnDtK34YqAc6g7LD0GecAg5u/2vKrgeTjmLOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271790;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=MN2H/Sd0YoWD7yOsUu+/3nrXR4+HLFAIs61hYMcDiRg=;
	b=OJ3GqVpZbsOE1J0Neu1voLsZyGKQimhLwfDPGhMZG4Y51r+r41JyWNNhL1GyzPdehS9q
	 kHI2vCpbQBba9sitBRWaB+n4sUjR5E+Jrs05o8gSo15/2ScNdQai5XaSNjzsngsrREO2B
	 UxZKJiNl//LidcRerLQFPctw0ukicdkKsvAZ6ncC3S8I3FMhHq1OAZtG+PlS4i7Ko4oA1
	 q+PIV+ZUHD2/nvpTSL5Ra4IyZz0SJU4YYdbSCXKg/OvMsXr1lX6YTn+8IarrM4RLdA2Sk
	 aozpPkYxKBkCREShYSHihpKLcNPRRQDBZXQE67wEi2uj899QxanJ4zxp8W3aUhbDyLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kraS3KWc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F2C606A31A;
	Thu, 29 Oct 2026 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kraS3KWc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E871A1F01825;
	Thu, 29 Oct 2026 11:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793271789;
	bh=MN2H/Sd0YoWD7yOsUu+/3nrXR4+HLFAIs61hYMcDiRg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kraS3KWcR1HapYe2L8S04iaBUBqNCB8CgKH3Z4hF8TMnrmxZGGmnZ2QpTqjbmPO7b
	 mVvrwquiFMJDE9p3UwAnEs+1js4PqXm/tZQtza0S3ZtIpsLWkdtViZEFp6ZJ8SEQST
	 v+nIgqZXH8hsCK1nprjCVjMvlhvvsz91WUv0cl4n2JQlB+wnm6BaRxa/js3GiGpLr3
	 jizIWEtIUQzmXO+462nKgWuYKe2pZMOfnpo9WCtr1L4+fxPj7YKX4aqbouQaA2aRux
	 vUEyglwL6d5E0toW8MCroM61RUoU3Lux0qi7OwzKJW51rs80KLz2s0rbV7ZIljKCo+
	 K3ZqDZO9lh7XA==
Message-ID: <cba61fbf-17a1-4e27-88db-9ba066cbceb9@kernel.org>
Date: Thu, 29 Oct 2026 12:02:48 +0100
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
Subject: Re: [PATCH 33/46] mm/madvise: fix data loss from MADV_FREE on a KSM
 page
To: xu.xin@linux.dev
Cc: akpm@linux-foundation.org, aneesh.kumar@kernel.org, apopple@nvidia.com,
 axelrasmussen@google.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 baoquan.he@linux.dev, chengming.zhou@linux.dev, chrisl@kernel.org,
 dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, harry@kernel.org,
 hughd@google.com, jack@suse.cz, jannh@google.com, jgg@ziepe.ca,
 jhubbard@nvidia.com, josef@toxicpanda.com, joshua.hahnjy@gmail.com,
 kas@kernel.org, kasong@tencent.com, kees@kernel.org,
 kexec@lists.infradead.org, lance.yang@linux.dev, liam@infradead.org,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ljs@kernel.org, matthew.brost@intel.com,
 mhocko@kernel.org, mhocko@suse.com, minchan@kernel.org,
 muchun.song@linux.dev, nico.pache@linux.dev, nphamcs@gmail.com,
 npiggin@gmail.com, osalvador@suse.de, pasha.tatashin@soleen.com,
 peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de,
 pratyush@kernel.org, qi.zheng@linux.dev, rakie.kim@sk.com, riel@surriel.com,
 rppt@kernel.org, ryan.roberts@arm.com, shakeel.butt@linux.dev,
 shikemeng@huaweicloud.com, stable@vger.kernel.org, surenb@google.com,
 usama.arif@linux.dev, vbabka@kernel.org, weixugc@google.com,
 will@kernel.org, willy@infradead.org, ying.huang@linux.alibaba.com,
 youngjun.park@lge.com, yuanchu@google.com, ziy@nvidia.com
References: <20261027-fixes_core-v1-33-6f74bec9a5bb@kernel.org>
 <20261029045307.131675-1-xu.xin@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261029045307.131675-1-xu.xin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/26 05:53, xu.xin@linux.dev wrote:
>> MADV_FREE can clear the dirty flag of a singly mapped KSM folio. The
>> folio remains in the stable tree and can gain new mappings without being
>> dirtied again. Once marked lazyfree, reclaim can discard data that those
>> mappings still need.
>>
>> KSM always marks a folio dirty when converting it to a KSM folio in
>> try_to_merge_one_page(). Marking a folio lazyfree clears PG_swapbacked
>> but leaves PG_dirty unchanged. Preserving PG_dirty makes reclaim restore
>> PG_swapbacked instead of discarding the folio. This also protects folios
>> that were already lazyfree when KSM converted them.
>>
>> Skip KSM folios before clearing their dirty flag, checking under the
>> folio lock to serialize with KSM conversion.
>>
>> Fixes: 854e9ed09ded ("mm: support madvise(MADV_FREE)")
>> Cc: stable@vger.kernel.org
>> Reported-by: Josef Bacik <josef@toxicpanda.com>
>> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  mm/madvise.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index 75b409e97dbf2..a16e3cb256b7b 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -756,6 +756,15 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>>  		if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
>>  			if (!folio_trylock(folio))
>>  				continue;
>> +			/*
>> +			 * KSM folios can gain new mappings at any time, so we must
>> +			 * not clear their dirty flag.
>> +			 */
>> +			if (folio_test_ksm(folio)) {
>> +				folio_unlock(folio);
>> +				continue;
>> +			}
>> +
>>  			/*
>>  			 * If we have a large folio at this point, we know it is
>>  			 * fully mapped so if its mapcount is the same as its
>>
>> -- 
>> 2.43.0
> 
> The fix looks correct to me: checking folio_test_ksm() under the
> folio lock properly serializes with KSM conversion, and skipping
> the folio avoids clearing PG_dirty on a KSM folio.

Yes. And doing it under the lock is something the original AI fix missed.

Thanks!

-- 
Cheers,

David
