Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097045;
	b=K5KbOepZe99KuDDHqas6oMuCUK3Z9eJlyMp1SHrsa6zj8YlPe9Xj99bQZwBV0TFvHH1o
	 oKg53zLnc7TnT7lOzyEbwhsoHsX8gDfOf/h3c/lqn4DF57lIVxfX9OZ5rvvDVyt3pD5nv
	 OgykMeG9m8d9Aex4Cj/XwpCi9n7jPZyIQC+NEvpZht2Ta6KWz0IAGVEHoTWeAK7+SBNNf
	 pwLurLPiNU/3zRQansNrKe3MfoW1ERJJZ4TBKyGOz9M88MVGQSJLCJc6EfQgROqY2wvn2
	 gk4O1iZoVwWZcIOGT8LVRNQXp0PPlXJvD4fJ8n93L6zNAPak4iar64wE/kIBu3RQCDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097045;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=CfsimHztCruO2Wg5kbGqSZxP4HQYNhZ0++xp8V5kraE=;
	b=aaw77gag8aAx8gOOmkM5WNKSW03p50ReKPEzGIQQuSp9rGXWSxoHGcPInHu+aS84KuRD
	 BlWQekDWv/fqK5kMQDiuVlOswxMua3SiE0ReOpZD6aZOx7uPuODavJ6tTfpwjl4V7O5s3
	 ASUspe1wNzzcfoJw1iE0Z0Aa/EbQc3DbnoOh47RVZoKIUxkV2MJIyJFr5YDd85l/39pIu
	 B7c/Gk3F2AQA2bHuYAgbAigOljZNCXbMZ3394A/sJ2aXM/N0WAd9IqWWzjCB12I6phhUW
	 tm7hogK1ooWGow4BNs5WZ8ijm4dz6ChjaBUCVFRV3Y2ig9RVBNlZbp5WkRL82Q4aM8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wERo8I2l;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8HWqkJop;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wERo8I2l;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8HWqkJop;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CCC606A31F;
	Tue, 27 Oct 2026 10:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62CCC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wERo8I2l;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8HWqkJop;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wERo8I2l;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8HWqkJop
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 371831F7E9;
	Tue, 27 Oct 2026 10:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793097042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfsimHztCruO2Wg5kbGqSZxP4HQYNhZ0++xp8V5kraE=;
	b=wERo8I2l80Tbc7zJzgDVpUtP8F4hNH5xHai1+6lKUZPKwS4vDftwCXE/JroFhBufP60rJ0
	B/oCs7boHDjA0SGhsKWWb1V9o5NDenKsZHKq1syJC63/jbUrF6n4/ZPg19Hl/dxyjMZeqJ
	xNmRFjrv1LVl1hvgYjA99EMcOdJD7+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793097042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfsimHztCruO2Wg5kbGqSZxP4HQYNhZ0++xp8V5kraE=;
	b=8HWqkJopKnjpTl2rDCb/W7qDTjgk+JL8glEff3Y7OL45XtiNrvHKtDVQBZvE1sSYQ2NkeN
	PF5hAv8OYKoavEDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wERo8I2l;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8HWqkJop
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793097042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfsimHztCruO2Wg5kbGqSZxP4HQYNhZ0++xp8V5kraE=;
	b=wERo8I2l80Tbc7zJzgDVpUtP8F4hNH5xHai1+6lKUZPKwS4vDftwCXE/JroFhBufP60rJ0
	B/oCs7boHDjA0SGhsKWWb1V9o5NDenKsZHKq1syJC63/jbUrF6n4/ZPg19Hl/dxyjMZeqJ
	xNmRFjrv1LVl1hvgYjA99EMcOdJD7+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793097042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfsimHztCruO2Wg5kbGqSZxP4HQYNhZ0++xp8V5kraE=;
	b=8HWqkJopKnjpTl2rDCb/W7qDTjgk+JL8glEff3Y7OL45XtiNrvHKtDVQBZvE1sSYQ2NkeN
	PF5hAv8OYKoavEDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 507801321C;
	Tue, 27 Oct 2026 10:30:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /jBeBlB94GqiEQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 27 Oct 2026 10:30:40 +0000
Date: Tue, 27 Oct 2026 10:30:34 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, liam@infradead.org, nico.pache@linux.dev, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, usama.arif@linux.dev, kas@kernel.org, 
	jack@suse.cz, djwong@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, hch@lst.de, ngocthang2710.1999@gmail.com, 
	syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v4] khugepaged: fix readahead lock inversion in
 collapse_file()
Message-ID: <auB9CHQh0acOxXpZ@pedro-suse.tail5790ac.ts.net>
References: <at9_1mf2kLqMX8-W@pedro-suse.tail5790ac.ts.net>
 <20261027025507.59451-1-lance.yang@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027025507.59451-1-lance.yang@linux.dev>
X-Rspamd-Queue-Id: 371831F7E9
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,infradead.org,linux.dev,arm.com,suse.cz,kvack.org,vger.kernel.org,lst.de,gmail.com,syzkaller.appspotmail.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[16bf7cd0ebeb1de93aa5];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,linux.dev:email,syzkaller.appspot.com:url,appspotmail.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.01

On Tue, Oct 27, 2026 at 10:55:07AM +0800, Lance Yang wrote:
> 
> On Mon, Oct 26, 2026 at 04:33:08PM +0000, Pedro Falcato wrote:
> >On Mon, Oct 26, 2026 at 11:20:13PM +0800, Lance Yang wrote:
> >> collapse_file() can call page_cache_sync_readahead() while still holding
> >> source folios locked. If truncate holds mapping->invalidate_lock
> >> exclusively and waits for one of those folios, readahead waits for
> >> invalidate_lock and neither side can make progress.
> >> 
> >> We need to release those folio locks before starting readahead. On a page
> >> cache miss, roll back first, populate the collapse range, and retry once.
> >> Doing readahead after rollback avoids an extra pass when all folios are
> >> already present. If another miss occurs on retry, give up rather than keep
> >> retrying while truncate or reclaim removes folios.
> >> 
> >> Keep page_cache_sync_readahead() and wait for read I/O with
> >> filemap_lock_folio(), releasing each folio before moving to the next. The
> >> existing uptodate check during collapse still handles read errors.
> >> 
> >> Shmem uses shmem_get_folio() for swapin and fallocated folios without
> >> taking mapping->invalidate_lock, so it is unaffected.
> >> 
> >> Reported-by: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=16bf7cd0ebeb1de93aa5
> >> Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> >
> >Thanks for the patch! This looks almost perfect!
> 
> Thanks Pedro!
> 
> >
> >> ---
> >> v3 -> v4:
> >>  - Move readahead after rollback and retry collapse once (per Pedro).
> >>  - Drop the preparation pass and its redundant uptodate check (per
> >>    Baolin and Pedro). Thanks!
> >>  - https://lore.kernel.org/all/20261016065920.4153-1-lance.yang@linux.dev/
> >> 
> >>  mm/khugepaged.c | 44 +++++++++++++++++++++++++++++++++-----------
> >>  1 file changed, 33 insertions(+), 11 deletions(-)
> >> 
> >> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >> index da91762f6358..0d3bd9e23613 100644
> >> --- a/mm/khugepaged.c
> >> +++ b/mm/khugepaged.c
> >> @@ -2239,6 +2239,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
> >>  	enum scan_result result = SCAN_SUCCEED;
> >>  	int nr_none = 0;
> >>  	bool is_shmem = shmem_file(file);
> >> +	bool do_readahead = false;
> >> +	bool readahead_done = false;
> >>  
> >>  	/*
> >>  	 * MADV_COLLAPSE ignores shmem huge config, so do not check shmem
> >> @@ -2256,6 +2258,10 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
> >>  
> >>  	mapping_set_update(&xas, mapping);
> >>  
> >> +retry:
> >> +	result = SCAN_SUCCEED;
> >> +	do_readahead = false;
> >> +	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
> >>  	__folio_set_locked(new_folio);
> >>  	if (is_shmem)
> >>  		__folio_set_swapbacked(new_folio);
> >> @@ -2320,17 +2326,9 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
> >>  			}
> >>  		} else {	/* !is_shmem */
> >>  			if (!folio || xa_is_value(folio)) {
> >> -				xas_unlock_irq(&xas);
> >> -				page_cache_sync_readahead(mapping, &file->f_ra,
> >> -							  file, index,
> >> -							  end - index);
> >> -				/* drain lru cache to help folio_isolate_lru() */
> >> -				lru_add_drain();
> >> -				folio = filemap_lock_folio(mapping, index);
> >> -				if (IS_ERR(folio)) {
> >> -					result = SCAN_FAIL;
> >> -					goto xa_unlocked;
> >> -				}
> >> +				do_readahead = !readahead_done;
> >> +				result = SCAN_FAIL;
> >> +				goto xa_locked;
> >>  			} else if (folio_test_dirty(folio)) {
> >>  				/*
> >>  				 * This page is dirty because it hasn't
> >> @@ -2657,6 +2655,30 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
> >>  	new_folio->mapping = NULL;
> >>  
> >>  	folio_unlock(new_folio);
> >> +
> >> +	/* Readahead may take invalidate_lock; source folios are unlocked. */
> >> +	if (do_readahead) {
> >> +		for (index = start; index < end;) {
> >> +			folio = filemap_lock_folio(mapping, index);
> >
> >I'm not sure if there's a point in locking the folio. If we are retrying,
> >then the logic above will lock it anyway and check uptodate. So I don't
> >think there's much of a point doing it here. Right?
> >
> >So I think we could get away with a filemap_get_folio() here, and no
> >filemap_lock_folio() after RA. Unless you're intent on waiting for RA
> >right before failing, but I don't see a point in that.
> 
> Right, waiting for RA is what I intended here. Without that wait, the
> retry can hit folio_trylock() while the read is still in flight and bail
> out with SCAN_PAGE_LOCK, before it even gets to the uptodate check.
> 
> If the read completes successfully, we can continue with collapse.
> That's why I kept the wait before retrying. Do you think waiting isn't
> worth it here, and we'd be better off leaving collapse to a later
> attempt?

Hmm, yes, thanks for the explanation. I had a fresh look at the code and your
patch preserves that bit of behavior. Isolating folios is simply trylocking,
and only does a hard folio_lock after RA. So, LGTM!

-- 
Pedro
