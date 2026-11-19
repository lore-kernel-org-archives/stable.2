Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080972;
	b=jcAeACIlXJYLHjUqzgc/ot/Tg17Ug2MtAbMMchLcdLsE1hPIM64nsUNiKVyGH54sp0xz
	 cYcj1o1NeFsiR/Nx7PFq4XpsVJXwZBfdGK1svCHrbzNYJMZbBeD53aTnYOz/8DNd6xQIX
	 So73lbmmU5nw+SmTkoQYlN/7iNkDCZk42WugnT8te7hP4eiy5YPS0l553R7xjqAU7ELqw
	 9YpM0Eg/Jp0mERDQAb/K+tMr10gj63AVW9CQb8UafZwGLgAFA3FZqCW8MzhpNTKccf5v/
	 jGNQo+kV62zLcOyMdhZWwTgqsg+t+9VqeqDewPcBzTxhxYHCTekfOBfFZZp1QRkJ/MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080972;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=igdFWy6CMNTS7sv5o5j1ZIrF2rr0ZWKOfYYSmUoY0q4=;
	b=LfVcHr4B6O3RS2AqTJLCsatWHeh8cFNoCkAyGSBGvuPm5B/5T6Iu8+2R1zX6EoA3oMIR
	 f+rLVd076SUgc8gMSn+2ukVJ22bHrrjE2b/mnD/K+GUWAAskJzGujpX3zSjnccpMpwliI
	 ZXTmXRhzVFMT19LUdYb/OIMc9+UnbmRCmG/SVGXkjYNDqDvLMKvqcpaAM9KpDbGPECYLt
	 fO8b4bvmQKuNaQGImG+kbn8l3ROcqOv7kuXnoa1sAyGN2IugzqHZntbeF3J2gE0LQoma1
	 s6JJ410hSQ26OQphLBNTU9quYIriXQ02W55tbaM2LRB8lUVFHDkLq8T0nUPWhAkgyXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Kjagh+CI;
	arc=none smtp.remote-ip=95.215.58.183
Received: from mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD19606A334
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 09:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADD19606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Kjagh+CI
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FyyB2+EMJUxYLUau/jQ5mXJ3d+z/p5uRxFEljvc09D0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795080969; v=1; x=1795685769;
 b=Kjagh+CIAdQ/9Ozz+5xSZ+gQdakx8nHUEPACuc82FbvgqVLjd0XadE+gvS4egwVwjQOxjzYL
 IuMu4bC/HXZUHYSjK5+E1Zt4VkEE3f8K3seAIEzEswIx1bjPNYfA9ikeIC/i3xgm7RPtECvzOrl
 zHjbt5ZuiwvRzbirJ+OZ0JNU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2da72c0dcd2ffa2e;
	Thu, 19 Nov 2026 09:36:08 +0000
X-Mizu-Trace-ID: 2da72c0dcd2ffa2e
X-Migadu-Flow: FLOW_OUT
Message-ID: <0e42e0c4-c1f9-4778-a979-404fbb68130a@linux.dev>
Date: Thu, 19 Nov 2026 17:35:58 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH] mm: mglru: reset the mm iteration cursor in
 try_to_inc_max_seq_nowalk()
To: Baoquan He <baoquan.he@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Harry Yoo <harry@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>,
 stable@vger.kernel.org
References: <20261117113700.453044-1-hui.zhu@linux.dev>
 <av6lVy5fW47XPxre@fedora>
Content-Language: en-US
From: Hui Zhu <hui.zhu@linux.dev>
In-Reply-To: <av6lVy5fW47XPxre@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


2026/11/19 15:29, Baoquan He:
> On 11/17/26 at 07:37pm, Hui Zhu wrote:
>> From: Hui Zhu <zhuhui@kylinos.cn>
>>
>> iterate_mm_list_nowalk() and try_to_inc_max_seq_nowalk() both advance
>> mm_state->seq without walking the mm_list, but only the former drops the
>> cursor. When the latter races with an ongoing page table walk, head is
>> left pointing into the middle of the fifo.
>>
>> The next walker reads that as "this generation already started": it skips
>> reset_bloom_filter() and resumes after the cursor. Every mm before the
>> cursor is skipped, and none of them have bits in the filter being read, so
> Nit:
> Isn't it that mm after the cursor is skipped, none of them have bits in
> the filter being read? Because bits in the filter are set in the last
> generation iteration, mm after cursor didn't iterate, so no bites set
> for them?
You are right, thanks for catching it. test_bloom_filter() reads
filters[walk->seq % 2], and that buffer was filled by the aborted walk of
the previous generation, which only got as far as the cursor. So the mm
the resumed walk visits -- the ones after the cursor -- are exactly the
ones with no bits in it, and they lose their non-leaf walk. The mm before
the cursor are simply left out of this generation. I will fix the wording
in v2.
>> walk_pmd_range() descends into none of their PMDs and harvests no accessed
>> bits. try_to_shrink_lruvec() ignores the failed try_to_inc_max_seq() and
>> keeps evicting, so those hot folios become reclaim candidates and refault
>> in the parent memcg, until head wraps around a generation later.
>>
>> Factor the pattern into skip_mm_iteration(), which carries the rationale
>> that used to sit in a comment in try_to_inc_max_seq_nowalk(), so the two
>> callers cannot drift apart again. The wrap-around in iterate_mm_list() is
>> left open-coded on purpose: there head is already back at the fifo, and
>> tail has to survive for the force_scan test. Dropping the cursor is safe:
>> get_next_mm() holds an mmgrab() reference, and a concurrent walker bails
>> out at "walk->seq <= mm_state->seq" before touching head again. The
>> unwalked part of the fifo restarts from the head next generation, as
>> iterate_mm_list_nowalk() already does.
>>
>> Only reachable from memcg_reparent_objcgs() -> max_lru_gen_memcg(); not a
>> memory safety issue, since lru_gen_del_mm() repoints head and tail under
>> mm_list->lock.
>>
>> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
>> ---
>>   mm/vmscan.c | 23 +++++++++++++++--------
>>   1 file changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 6a1af9b92349..0dc4017b87e4 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -3235,6 +3235,7 @@ static bool iterate_mm_list(struct lru_gen_mm_walk *walk, struct mm_struct **ite
>>   	do {
>>   		mm_state->head = mm_state->head->next;
>>   		if (mm_state->head == &mm_list->fifo) {
>> +			/* head is back at the fifo; keep tail for force_scan below */
>>   			WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
>>   			last = true;
>>   			break;
>> @@ -3263,6 +3264,18 @@ static bool iterate_mm_list(struct lru_gen_mm_walk *walk, struct mm_struct **ite
>>   	return last;
>>   }
>>   
>> +/*
>> + * Advance mm_state->seq without walking the mm_list. The cursor must be
>> + * dropped as well: iterate_mm_list() resumes from head, and resets the Bloom
>> + * filter only when head == &mm_list->fifo.
>> + */
> This looks like a good catch, while the function name here is a little bit
> confusing. From the code block inside, we can't see it's doing iteration,
> just a pair of pointer resetting and a max_seq advancing. I would rather
> not wrap up them if no good name is concluded. Personal opinion.
How about inc_mm_state_seq(), after inc_max_seq(), leaving the "why"
to the comment:

     /*
      * The cursor must be dropped along with mm_state->seq:
      * iterate_mm_list() resumes from head, and resets the Bloom filter
      * only when head == &mm_list->fifo.
      */
     static void inc_mm_state_seq(struct lru_gen_mm_state *mm_state)

If that still does not read well to you, I will drop the helper in v2 and
keep the two lines open-coded.
>
> Other than the nits,
>
> Reviewed-by: Baoquan He <baoquan.he@linux.dev>

Thank you!

Best,
Hui

>
>> +static void skip_mm_iteration(struct lru_gen_mm_state *mm_state)
>> +{
>> +	mm_state->head = NULL;
>> +	mm_state->tail = NULL;
>> +	WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
>> +}
>> +
>>   static bool iterate_mm_list_nowalk(struct lruvec *lruvec, unsigned long seq)
>>   {
>>   	bool success = false;
>> @@ -3275,9 +3288,7 @@ static bool iterate_mm_list_nowalk(struct lruvec *lruvec, unsigned long seq)
>>   	VM_WARN_ON_ONCE(mm_state->seq + 1 < seq);
>>   
>>   	if (seq > mm_state->seq) {
>> -		mm_state->head = NULL;
>> -		mm_state->tail = NULL;
>> -		WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
>> +		skip_mm_iteration(mm_state);
>>   		success = true;
>>   	}
>>   
>> @@ -4686,15 +4697,11 @@ static void try_to_inc_max_seq_nowalk(struct mem_cgroup *memcg,
>>   	DEFINE_MAX_SEQ(lruvec);
>>   	bool success = false;
>>   
>> -	/*
>> -	 * We are not iterating the mm_list here, updating mm_state->seq is just
>> -	 * to make mm walkers work properly.
>> -	 */
>>   	if (mm_state) {
>>   		spin_lock(&mm_list->lock);
>>   		VM_WARN_ON_ONCE(mm_state->seq + 1 < max_seq);
>>   		if (max_seq > mm_state->seq) {
>> -			WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
>> +			skip_mm_iteration(mm_state);
>>   			success = true;
>>   		}
>>   		spin_unlock(&mm_list->lock);
>> -- 
>> 2.53.0
>>
