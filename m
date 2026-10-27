Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069735;
	b=GjzU4XBENGdjiULf0kfxFf5J9UysQLRk9Pz0gMHPcMKDB+dNPso9P5t2L/WzVO4GUWii
	 n6WPumeKDvv+wB/Yf2zro+7eDP7GfD9sWy1qEFOZx0V+yRFqLFK028e8cqf6MtD3Dd2p4
	 iUjDJKLHc1PO7kxVJfhCBTsLFXlyo7OWstLQk67bDMvSK4fzFN0RhEHx8Q0cVGVW97xwC
	 a/FbAUSKQTwP9QYlR0gL0ABwB3n77BzN5+QLRLBtv5gWaMBJNApah318Xo/oscfucN0KL
	 /HX+AhuFc8cg6+1glkXnSSpz/rDgAlSKIqPk/+1biqwBdjOeo0CPJEEf2qtSmpy6Xgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069735;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=V9PFsHDtvXgwv6NYqyvGmgu7gAiiaLp/I8Vm0DnTkkk=;
	b=kWh29yr8nSGAsqnyb6kNG+/mMbj2NkX3LrgF0kYGxTk/zc9CMhG5TTbW6qw3n9/Ut7Bj
	 8rbh/B/0opzhtpmgMKnLMRHB8Ib69aOPe8E/Yog0u2FmDT6s7+GV3VWy5BWWr9yPE68em
	 hwz2ds9OvCVp2rUOdJLNs51XV/Yq42eRsdxpCwoIUHk9dxw8+pGjIU5l010pPoU+yJLZq
	 TsRjca9gLVPHZnMDFpertkmvIsnai8RMbLSgpmCjc8tTrWo+zGbSvd3zGseQmFmqMvE+W
	 HHFkSFo1QBu8vKPUQWyBS7T9eY9KZRxXkeC25qtVKGOdJ0hoeilob9GiwaORrJicTNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aBMxL8KF;
	arc=none smtp.remote-ip=91.218.175.74
Received: from mta0.migadu.com (out-74.mta0.migadu.com [91.218.175.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A329C606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A329C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aBMxL8KF
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aboeRYMBw2lMDN35kj+b7/S1t+rS41JAG+rBlUvVfhg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793069731; v=1; x=1793674531;
 b=aBMxL8KFpPbDzPXO2Idhj+x/0LL9hPc0iCPINsROyW4JAgRJKEJbI4Dne6RDhrotLAq/vasN
 VUh8maR/W/RnXrExj8qcQhRACKY3emUYvEyaH5rDtvXBYOdnvXLwtrGkZqXgowqsxRD5oCbyu0l
 97/+ERTxKtiScXm006KKWZ8s=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8a802e798165f00b;
	Tue, 27 Oct 2026 02:55:13 +0000
X-Mizu-Trace-ID: 8a802e798165f00b
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: pfalcato@suse.de
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	usama.arif@linux.dev,
	kas@kernel.org,
	jack@suse.cz,
	djwong@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	ngocthang2710.1999@gmail.com,
	syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] khugepaged: fix readahead lock inversion in collapse_file()
Date: Tue, 27 Oct 2026 10:55:07 +0800
Message-ID: <20261027025507.59451-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <at9_1mf2kLqMX8-W@pedro-suse.tail5790ac.ts.net>
References: <at9_1mf2kLqMX8-W@pedro-suse.tail5790ac.ts.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Mon, Oct 26, 2026 at 04:33:08PM +0000, Pedro Falcato wrote:
>On Mon, Oct 26, 2026 at 11:20:13PM +0800, Lance Yang wrote:
>> collapse_file() can call page_cache_sync_readahead() while still holding
>> source folios locked. If truncate holds mapping->invalidate_lock
>> exclusively and waits for one of those folios, readahead waits for
>> invalidate_lock and neither side can make progress.
>> 
>> We need to release those folio locks before starting readahead. On a page
>> cache miss, roll back first, populate the collapse range, and retry once.
>> Doing readahead after rollback avoids an extra pass when all folios are
>> already present. If another miss occurs on retry, give up rather than keep
>> retrying while truncate or reclaim removes folios.
>> 
>> Keep page_cache_sync_readahead() and wait for read I/O with
>> filemap_lock_folio(), releasing each folio before moving to the next. The
>> existing uptodate check during collapse still handles read errors.
>> 
>> Shmem uses shmem_get_folio() for swapin and fallocated folios without
>> taking mapping->invalidate_lock, so it is unaffected.
>> 
>> Reported-by: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=16bf7cd0ebeb1de93aa5
>> Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>
>Thanks for the patch! This looks almost perfect!

Thanks Pedro!

>
>> ---
>> v3 -> v4:
>>  - Move readahead after rollback and retry collapse once (per Pedro).
>>  - Drop the preparation pass and its redundant uptodate check (per
>>    Baolin and Pedro). Thanks!
>>  - https://lore.kernel.org/all/20261016065920.4153-1-lance.yang@linux.dev/
>> 
>>  mm/khugepaged.c | 44 +++++++++++++++++++++++++++++++++-----------
>>  1 file changed, 33 insertions(+), 11 deletions(-)
>> 
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index da91762f6358..0d3bd9e23613 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -2239,6 +2239,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>>  	enum scan_result result = SCAN_SUCCEED;
>>  	int nr_none = 0;
>>  	bool is_shmem = shmem_file(file);
>> +	bool do_readahead = false;
>> +	bool readahead_done = false;
>>  
>>  	/*
>>  	 * MADV_COLLAPSE ignores shmem huge config, so do not check shmem
>> @@ -2256,6 +2258,10 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>>  
>>  	mapping_set_update(&xas, mapping);
>>  
>> +retry:
>> +	result = SCAN_SUCCEED;
>> +	do_readahead = false;
>> +	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
>>  	__folio_set_locked(new_folio);
>>  	if (is_shmem)
>>  		__folio_set_swapbacked(new_folio);
>> @@ -2320,17 +2326,9 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>>  			}
>>  		} else {	/* !is_shmem */
>>  			if (!folio || xa_is_value(folio)) {
>> -				xas_unlock_irq(&xas);
>> -				page_cache_sync_readahead(mapping, &file->f_ra,
>> -							  file, index,
>> -							  end - index);
>> -				/* drain lru cache to help folio_isolate_lru() */
>> -				lru_add_drain();
>> -				folio = filemap_lock_folio(mapping, index);
>> -				if (IS_ERR(folio)) {
>> -					result = SCAN_FAIL;
>> -					goto xa_unlocked;
>> -				}
>> +				do_readahead = !readahead_done;
>> +				result = SCAN_FAIL;
>> +				goto xa_locked;
>>  			} else if (folio_test_dirty(folio)) {
>>  				/*
>>  				 * This page is dirty because it hasn't
>> @@ -2657,6 +2655,30 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>>  	new_folio->mapping = NULL;
>>  
>>  	folio_unlock(new_folio);
>> +
>> +	/* Readahead may take invalidate_lock; source folios are unlocked. */
>> +	if (do_readahead) {
>> +		for (index = start; index < end;) {
>> +			folio = filemap_lock_folio(mapping, index);
>
>I'm not sure if there's a point in locking the folio. If we are retrying,
>then the logic above will lock it anyway and check uptodate. So I don't
>think there's much of a point doing it here. Right?
>
>So I think we could get away with a filemap_get_folio() here, and no
>filemap_lock_folio() after RA. Unless you're intent on waiting for RA
>right before failing, but I don't see a point in that.

Right, waiting for RA is what I intended here. Without that wait, the
retry can hit folio_trylock() while the read is still in flight and bail
out with SCAN_PAGE_LOCK, before it even gets to the uptodate check.

If the read completes successfully, we can continue with collapse.
That's why I kept the wait before retrying. Do you think waiting isn't
worth it here, and we'd be better off leaving collapse to a later
attempt?

>
>With that addressed:
>
>Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Really appreciated!

>> +			if (IS_ERR(folio)) {
>> +				page_cache_sync_readahead(mapping, &file->f_ra,
>> +							  file, index, end - index);
>> +				folio = filemap_lock_folio(mapping, index);
>> +				if (IS_ERR(folio)) {
>> +					result = SCAN_FAIL;
>> +					goto out_put;
>> +				}
>> +			}
>> +			index = folio_next_index(folio);
>> +			folio_unlock(folio);
>> +			folio_put(folio);
>> +		}
>> +		/* Drain the local LRU batch before retrying isolation. */
>> +		lru_add_drain();
>> +		readahead_done = true;
>> +		goto retry;
>> +	}
>> +out_put:
>>  	folio_put(new_folio);
>>  out:
>>  	VM_BUG_ON(!list_empty(&pagelist));
>> -- 
>> 2.49.0
>> 
>
>-- 
>Pedro
>
