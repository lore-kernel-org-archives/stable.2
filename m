Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448669;
	b=x3gkb8KDIWUaD23q3YTpZEBYx/gLavZCDaDDXgHqivpiTBesYlHVtW/wiDhwBFnFgsPl
	 dDoNV38k8LdjQXsu/awcwugPSPpJu3+ShkosRYT52K2Ikddepc8bdnBgUFbnOwVTrcVld
	 pqqGvr3gE+w9ii8pFQcJs8O069r49oz8Rf1LVrdndasRJXVSvpzqzGmhRObduWWt/vtZE
	 8ur1JIny4rVhK1eqvG/prEOZg2QTV7a/vwz9s8gOJBLSO80Grai2HpYgBx8yYSurjxGVn
	 O/o9oq8EIYV6nD/ifJ620v8f9bYNIsMpz2nWTKXskIku11X32XhSAFbZYIzPSz2v9VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448669;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=gM036Lz3o4zVMa1LHZqyXfXI7ctHVwdatuzaP+xuoQk=;
	b=riAHU1du2EbZUimr4xbPF+YZ1vMCVI4bQ/W2pgYxjz0KSWFpaJNMrYSUMXOXshqayK0s
	 PhL3cLtl082TXm+s12JJupVyQAaXwg8uV+R60tUJLm62g6S58cyV9zQbQPGwf4rkAfz1c
	 OblHAg35IZ20PB8nbKIj1xDOoshoysYvQgkXmBqgswoCk2evda0j1X7nxyEpELgeGSRaz
	 FPS2AIxcwe6z2jOsCf0M2ipSy6y06QsR7b+sTumyK+6G5V0kFn7RK6qKjU5W8Bc+pUHfV
	 EEBmZ0LegevvOR6kagXY76HtBNX3EZ0lA1d1oi39OxmSEMWqogKMEkzQs7j+MlyztmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=faUooxKv;
	arc=none smtp.remote-ip=91.218.175.180
Received: from mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB66606A885
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DB66606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=faUooxKv
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yKaM/QiUACyjX+qdRyFbfdqOOL/98E7TZUDAFfd2x+A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794448665; v=1; x=1795053465;
 b=faUooxKv0kNDG903OFqeLVR1EGlcLCvX6gWu51FNniszxFnwsJRj5rGAm7y/bHE8ac1WigCr
 iDvPEllng7LoA7eG/DEUYyRb5kIo+/sIiNMhc3QOjJiyRL6/RdQLVeBFDwTiki0Zty3V4VAEiuZ
 hFjJVN1i5g23LdUhIj29ewqc=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 41d9010a3529e826;
	Thu, 12 Nov 2026 01:57:45 +0000
X-Mizu-Trace-ID: 41d9010a3529e826
X-Migadu-Flow: FLOW_OUT
Message-ID: <5e2733ee-7a25-430f-bdda-f89fc5856e5d@linux.dev>
Date: Thu, 12 Nov 2026 09:57:35 +0800
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
Subject: Re: [PATCH v3] mm/mglru: fix a no-op lru_gen_clear_refs() call in
 lru_lazyfree()
To: "Liam R. Howlett" <liam@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Yu Zhao <yuzhao@google.com>, Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>,
 stable@vger.kernel.org
References: <20261109021611.22247-1-hui.zhu@linux.dev>
 <4xqyzrl4lbxwbky22lc5k5mcvusudg75z6hspjokfoghp3dny3@rjuukqzxiuyv>
Content-Language: en-US
From: Hui Zhu <hui.zhu@linux.dev>
In-Reply-To: <4xqyzrl4lbxwbky22lc5k5mcvusudg75z6hspjokfoghp3dny3@rjuukqzxiuyv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

2026/11/12 01:21, Liam R. Howlett:

> On 26/11/09 10:16AM, Hui Zhu wrote:
>> From: Hui Zhu <zhuhui@kylinos.cn>
>>
>> lru_lazyfree() calls lru_gen_clear_refs() after lruvec_del_folio(), but
>> lru_gen_del_folio() has already cleared LRU_GEN_MASK, so folio_lru_gen()
>> returns -1 and lru_gen_clear_refs() exits at its "gen < 0" check without
>> clearing the refs or PG_workingset.
>>
>> A MADV_FREE folio therefore keeps the state it had before madvise(2),
>> even though madvise_free_pte_range() has already cleared the accessed and
>> dirty bits of its PTEs.  lru_gen_folio_seq() places it one generation
>> younger, and PG_workingset puts it in the last tier, so sort_folio()
>> promotes and protects it instead of evicting it and charges it to
>> lrugen->protected[], which read_ctrl_pos() uses to balance anon against
>> file reclaim.  __folio_inc_gen() clears the refs but not PG_workingset,
>> so this repeats every time the folio reaches the oldest generation.  If
>> the folio is redirtied first, ttu_anon_lazyfree_folio() keeps it and
>> lru_gen_eviction() packs the stale state into the shadow entry, so a
>> later refault is promoted to the youngest generation.
>>
>> Call lru_gen_clear_refs() while the folio is still on the generation
>> list, as deactivate_file_folio() and folio_deactivate() already do.  Its
>> return value only says whether the folio is in the oldest generation,
>> which lru_lazyfree() does not need because it re-adds the folio below.
>> Keep folio_clear_referenced() unconditional: the classic LRU needs it,
>> and it also covers the folios that lru_gen_clear_refs() skips.
>>
>> Fixes: cc8ec7be78ff ("mm/mglru: optimize deactivation")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Barry Song <baohua@kernel.org>
>> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
>> Reviewed-by: Barry Song <baohua@kernel.org>
> One nit..
>
> Reviewed-by: Liam R. Howlett (Google) <liam@infradead.org>
>
>> ---
>> Changelog:
>> v3:
>> Add Cc: stable@vger.kernel.org and pick up Barry's Reviewed-by.
>> No code change compared to v2.
>> Per the thread discussion, the __lru_gen_clear_refs() refactor will be
>> sent as a separate cleanup after this fix lands.
>> v2:
>> Call lru_gen_clear_refs() before lruvec_del_folio() instead of
>> open-coding the flag clears; drop the lru_gen_enabled() branch and
>> the comment (Barry Song).
>>
>>   mm/folio.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/folio.c b/mm/folio.c
>> index 35e242b48870b..ea3adb6a89d75 100644
>> --- a/mm/folio.c
>> +++ b/mm/folio.c
>> @@ -597,12 +597,10 @@ static void lru_lazyfree(struct lruvec *lruvec, struct folio *folio)
>>   	    folio_test_swapcache(folio) || folio_test_unevictable(folio))
>>   		return;
>>   
>> +	lru_gen_clear_refs(folio);
> Since you're not checking the return here, you could use
> folio_set_lru_refs(folio, 0);
> folio_clear_workingset(folio);

Thanks for the review.

That is exactly the shape we agreed on for the follow-up cleanup in
this thread, Barry's __lru_gen_clear_refs() draft. I would still keep
v3 as it is, for two reasons.

folio_set_lru_refs() is only defined under CONFIG_LRU_GEN, so the
open-coded version needs a new stub in mm_inline.h. That turns this
one-spot fix into the header change we planned for the cleanup patch.

The two calls are also unconditional, so on the classic LRU every
lazyfree folio would lose PG_workingset too, which upstream never did
before cc8ec7be78ff. Barry and Kairui just agreed to take this patch
as a clean backport for stable, so that CLRU behaviour change should
go into the cleanup patch with its own justification.

lru_gen_clear_refs() is self-gated on gen >= 0, so the call is a
no-op for folios that are not on a generation list, and the return
value it computes shares the cacheline lruvec_del_folio() touches
right after. I will send the cleanup, with the open-coded clearing
and the stub in one place, once this lands.

Best,
Hui

>
>>   	lruvec_del_folio(lruvec, folio);
>>   	folio_clear_active(folio);
>> -	if (lru_gen_enabled())
>> -		lru_gen_clear_refs(folio);
>> -	else
>> -		folio_clear_referenced(folio);
>> +	folio_clear_referenced(folio);
>>   	/*
>>   	 * Lazyfree folios are clean anonymous folios.  They have
>>   	 * the swapbacked flag cleared, to distinguish them from normal
>> -- 
>> 2.43.0
>>
