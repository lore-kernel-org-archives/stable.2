Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661CC3F1040;
	Thu, 15 Oct 2026 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092474; cv=none; b=YkWg2ppH2OBEnQkzpfYVNZ9/8ZGOFD0PUlCW/Oce6Ffsgue3W2S3P9SQ5IlsQ9Ie8GyhcFqYr+K48BrCQGSarUUFBPBM2pcVLZ99TlCgh/N/u1oW6NCCezZRioiVJeNJGfM8t43UWRSd8hhyWLEd6ZfkeFWwRHtXUeuCjzx9Q58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092474; c=relaxed/simple;
	bh=fEt9kplQoHHfBOmTkh0HVcUg07x1c3SExSsbV/kPLXc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AmxfLiEHgBEKtINgGFCsJx7RudE66u3SJ0SSPp0Lgd9CBcj+K6sXRDzY7KsMEhHr4GQUJUAKCuPh/woCrsHq3LfebuYqr7x17x8/Z7/JN9M+7m3Gc/dPwwaAdgdWe982I+RwhwKR7gej5MYtktUFFyk0piRMB13he0Y+xOPtEQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfWMtmm2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfWMtmm2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38471F000C4;
	Thu, 15 Oct 2026 19:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792092473;
	bh=aTUQn3LMk0w+yeTdUpwCQsIY+GVhDkIh+sgZRNspeMg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=BfWMtmm20yej46/YB4w/DGRwaPN+XM7OPRbg/ih4WLX+Z6SmQltw9AhB4OqcPLlZN
	 liXQTmMzMK3HxH6cKn/tFWlknlXMgiPBzmnrb2ezp3exxyTiRd75vEY2YHnxfklsIN
	 fmfrPR7vTBWgQ9ppLGILa+ve3rn+wyEktN+GeAMEfq88BzKlhXiCN8+tfcmIAAMEe7
	 6fiq0GjALPpZ/5+sgSczSsDnxxLtysNGK/DJoI9uK4IH+V/NWeJVWFOn4DcMzghNKV
	 6a6rLV8miiOyX1WfwNP6IDt9AgmXfCaMYiUjo6sOvczpv1T5JrGpON8Wxeg2LMZ87a
	 xmkaOEKa4ME0A==
Date: Thu, 15 Oct 2026 21:26:47 +0200 (CEST)
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
cc: "David S. Miller" <davem@davemloft.net>, 
    "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
    "Mike Rapoport (IBM)" <rppt@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] sparc64: flush only the aliased page, not its
 whole folio
In-Reply-To: <61ab29d3-929f-49de-bb64-5a49318ede00@gaisler.com>
Message-ID: <c74a2d45-2267-b380-c7fe-b6a2d3f8251b@kernel.org>
References: <20260928132102.1707-1-kaloz@kernel.org> <20260928132102.1707-2-kaloz@kernel.org> <61ab29d3-929f-49de-bb64-5a49318ede00@gaisler.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2075810683-1792092412=:25347"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2075810683-1792092412=:25347
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi Andreas,

On Thu, 15 Oct 2026, Andreas Larsson wrote:

> On 2026-09-28 15:21, Imre Kaloz wrote:
>> Since the conversion to folios, move_pte() and tlb_batch_add() flush the
>> D-cache of every page in the folio a single PTE maps.  Both run once per
>> PTE, so moving or unmapping a range backed by a large folio flushes each
>> of its pages once for every PTE of that folio, and each page flush is a
>> cross-call to all other online CPUs.
>
> It would be good if the description of what the patch does uses present
> tense, but past tense for what was wrong before the patch, or was
> otherwise reworded to make it clear.

Will do.

> The cross-call overhead is not true for all sparc64 machines and only
> for SMP configurations.

Right, it's only on SMP and only on sun4u CPUs whose D-cache can alias;
on sun4v flush_dcache_folio_all() returns right away. I'll say so.

>> Only the page the PTE maps can hold lines at the old colour, so flush
>> just that page, as before the conversion.  flush_dcache_folio_all() has
>> no other users and becomes flush_dcache_page_all() again.
>
> This could perhaps be a bit misleading, as multiple PTEs in the range
> handled by the caller can hold the old colour, could it not? Rather it
> is the traversing of the whole range one by one in the caller that does
> the trick. What do you aim to add to the previous description with this
> paragraph?

You're right. What I wanted to say is that flushing the page each PTE
maps is enough because the caller walks the range one PTE at a time, so
every page gets its own flush. I'll reword it that way.

>> On SMP QEMU guests, apt rebuilding its caches through mremap() triggers
>> RCU stalls and soft lockups in move_pte().
>
> Past tense or rewording here as well as this patch fixes this.

Will do.

<snip>

>> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
>> index 0837ebbc5dce..6712eac4baf1 100644
>> --- a/arch/sparc/include/asm/pgtable_64.h
>> +++ b/arch/sparc/include/asm/pgtable_64.h
>> @@ -946,6 +946,9 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>>  	set_pte_at((mm), (addr), (ptep), __pte(0UL))
>>
>>  #ifdef DCACHE_ALIASING_POSSIBLE
>> +/* Without pte_batch_hint(), move_ptes() calls this once per PTE, so
>> + * only the page this PTE maps can have lines at the old colour.
>> + */
>
> I'm not ecstatic about implementing a function that in the general API
> can be called for multiple ptes, even though this never happens on
> sparc64 as things stands right now. The code paths that saves us, from
> commit 0b5be138ce00 ("mm/mremap: avoid expensive folio lookup on mremap
> folio pte batch"), was "only" added as a performance regression fix.
>
> Perhaps the best logical solution would be if move_pte() got an added nr
> argument just as get_and_clear_ptes() has.
>
> Barring that, the comment should not describe why the change is ok, but
> rather descrive the code as it stands after this patch, that it depends
> on only being called for single pte's, and that this is accomplished by
> using the default pte_batch_hint().
>
> I would prefer the nr argument though, but that would go outside
> arch/sparc. Comments from mm people on this would be great.
>

I'll rewrite the comment that way.

I like the nr idea. Since sparc64 is the only user of move_pte(), it
would be a small change: move_ptes() would pass nr_ptes, the generic
version would ignore it, and sparc64 would flush every aliased page in
the batch. I’d still keep it as a separate patch on top of this one,
though, so the fix can go to stable as a plain sparc64 backport.

Matthew, Mike, Andrew, would you be fine with move_pte() taking nr?


Thanks,
Imre
--8323329-2075810683-1792092412=:25347--
