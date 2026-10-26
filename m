Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032404;
	b=ppWZbENt2D3JUhLFLuyvPp3gyR1DwbqdT8zmJ5k8zzHhQWOWzzQ2lVV29Vf1FUBZEoii
	 +rq8mpPkW2DoVlcMyxiylJMXfuQlrje1Gm4aB+eXvRhVBVpXreQ1N93A0LMVzFvnalvHE
	 yuegmErxCcjFI9HHkHPGa7SAuu4o+OHkUIteCE2vjx99Mi/mzWXkfwOCW5uPlKyurIfxE
	 GM+pxsf8llGsr2xrtD+TbjEDMF+3pnZzQjjAO1mHswPc88tsb1R0APO9sT8duA7V238+e
	 HyIQNwXhhEOtCIguSsIgedQv+1EYYsrMmzSHgARggrQhqPuPCSwPJ7YegMIEGo2uEEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032404;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=yYf5UWvZ+GcrVAg69TILlqXVI2fvHpzHYVVjWtuH7Kg=;
	b=EY+eH0pFgUGtCq8/M6jxVRWhs6msUulCIqm0IaBK/sB5cfuHJ8DlffzFMGuH4Jri7l00
	 NTUYzve4U9bRAtf9k0JwCkuYIicKkkqhuicSaF27IDVbnuAEPmGn67XSU22UWjcUj6/br
	 O5wzOFUOOI9Hu7d3Plbh2+t24UMFemkmXtTHqP9iRxaNB6eBsoTy/CWQADOGoxVITSXpF
	 gwibcOMu4HlTDIChsKeIwDVdz6ANNccqXfo6CXD6vwfNco1acyoKjgOBNc8DjpE55ZrLr
	 AAQC1xeEPTuQRMbxQWcN2r3Y3+Ms3LrMwcKGi13H+LBFOYdKZRv3zWbqJCXbmrDLs9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=itFUQNJd;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Iypac72U;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XjgU0Ptl;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1jTlf6CB;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF05606A330;
	Mon, 26 Oct 2026 16:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BF05606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=itFUQNJd;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Iypac72U;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XjgU0Ptl;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1jTlf6CB
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 21B971F7A3;
	Mon, 26 Oct 2026 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793032401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yYf5UWvZ+GcrVAg69TILlqXVI2fvHpzHYVVjWtuH7Kg=;
	b=itFUQNJdXyvJGmDFuqzVC3Wgj8yybg5QcWEeRsYwqj5nzEXUjS0/Z+NNNtgSDtBjNmnxoI
	e2qbFQAs0KMd+9HVQkE5ENS6X8SXg1GCK8HMQS5p9RdFK3Lo/bS0gB8e2U24vkHCFWoojK
	zYaW+hgP8Xq2+PIBSr/E0PRajXKd9PI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793032401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yYf5UWvZ+GcrVAg69TILlqXVI2fvHpzHYVVjWtuH7Kg=;
	b=Iypac72Uy6VsBosAChLXP6YfP+EG3v3d1dAfTsAR8NtC5SrCYyxOeGgc8WJQbw3SVCdBDD
	JcWEtBoXEHD6ITAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XjgU0Ptl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1jTlf6CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793032400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yYf5UWvZ+GcrVAg69TILlqXVI2fvHpzHYVVjWtuH7Kg=;
	b=XjgU0PtlvsnMlLIoCHG6nZSOdfgN1SThx2J1hD1bnNOovjaTsto6DwtgEGlLBEywyE/4XN
	70XIBEB9gTonX3a0JwooBax/2+hzNUps4N/WvQcVQcZZYa2UwDo1CnNMwMPGlWd+GpexSo
	yyAl2t6uP/Ts8uajjsWE+CnSFdJFm28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793032400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yYf5UWvZ+GcrVAg69TILlqXVI2fvHpzHYVVjWtuH7Kg=;
	b=1jTlf6CBBJwwHOB4ROaNRLi1p9O3txN9e7ypjNbFNqaUMGFHWU6au3TkpCmUCQf6oiIDVl
	JwyYcfz/n45ZfuCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63A6413319;
	Mon, 26 Oct 2026 16:33:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0FTXCM6A32ppOwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 26 Oct 2026 16:33:18 +0000
Date: Mon, 26 Oct 2026 16:33:08 +0000
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
Message-ID: <at9_1mf2kLqMX8-W@pedro-suse.tail5790ac.ts.net>
References: <20261026152013.10511-1-lance.yang@linux.dev>
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
In-Reply-To: <20261026152013.10511-1-lance.yang@linux.dev>
X-Rspamd-Queue-Id: 21B971F7A3
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
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,infradead.org,linux.dev,arm.com,suse.cz,kvack.org,vger.kernel.org,lst.de,gmail.com,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[16bf7cd0ebeb1de93aa5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email]
X-Spam-Score: -12.01

On Mon, Oct 26, 2026 at 11:20:13PM +0800, Lance Yang wrote:
> collapse_file() can call page_cache_sync_readahead() while still holding
> source folios locked. If truncate holds mapping->invalidate_lock
> exclusively and waits for one of those folios, readahead waits for
> invalidate_lock and neither side can make progress.
> 
> We need to release those folio locks before starting readahead. On a page
> cache miss, roll back first, populate the collapse range, and retry once.
> Doing readahead after rollback avoids an extra pass when all folios are
> already present. If another miss occurs on retry, give up rather than keep
> retrying while truncate or reclaim removes folios.
> 
> Keep page_cache_sync_readahead() and wait for read I/O with
> filemap_lock_folio(), releasing each folio before moving to the next. The
> existing uptodate check during collapse still handles read errors.
> 
> Shmem uses shmem_get_folio() for swapin and fallocated folios without
> taking mapping->invalidate_lock, so it is unaffected.
> 
> Reported-by: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=16bf7cd0ebeb1de93aa5
> Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lance Yang <lance.yang@linux.dev>

Thanks for the patch! This looks almost perfect!

> ---
> v3 -> v4:
>  - Move readahead after rollback and retry collapse once (per Pedro).
>  - Drop the preparation pass and its redundant uptodate check (per
>    Baolin and Pedro). Thanks!
>  - https://lore.kernel.org/all/20261016065920.4153-1-lance.yang@linux.dev/
> 
>  mm/khugepaged.c | 44 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index da91762f6358..0d3bd9e23613 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2239,6 +2239,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  	enum scan_result result = SCAN_SUCCEED;
>  	int nr_none = 0;
>  	bool is_shmem = shmem_file(file);
> +	bool do_readahead = false;
> +	bool readahead_done = false;
>  
>  	/*
>  	 * MADV_COLLAPSE ignores shmem huge config, so do not check shmem
> @@ -2256,6 +2258,10 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  
>  	mapping_set_update(&xas, mapping);
>  
> +retry:
> +	result = SCAN_SUCCEED;
> +	do_readahead = false;
> +	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
>  	__folio_set_locked(new_folio);
>  	if (is_shmem)
>  		__folio_set_swapbacked(new_folio);
> @@ -2320,17 +2326,9 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  			}
>  		} else {	/* !is_shmem */
>  			if (!folio || xa_is_value(folio)) {
> -				xas_unlock_irq(&xas);
> -				page_cache_sync_readahead(mapping, &file->f_ra,
> -							  file, index,
> -							  end - index);
> -				/* drain lru cache to help folio_isolate_lru() */
> -				lru_add_drain();
> -				folio = filemap_lock_folio(mapping, index);
> -				if (IS_ERR(folio)) {
> -					result = SCAN_FAIL;
> -					goto xa_unlocked;
> -				}
> +				do_readahead = !readahead_done;
> +				result = SCAN_FAIL;
> +				goto xa_locked;
>  			} else if (folio_test_dirty(folio)) {
>  				/*
>  				 * This page is dirty because it hasn't
> @@ -2657,6 +2655,30 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  	new_folio->mapping = NULL;
>  
>  	folio_unlock(new_folio);
> +
> +	/* Readahead may take invalidate_lock; source folios are unlocked. */
> +	if (do_readahead) {
> +		for (index = start; index < end;) {
> +			folio = filemap_lock_folio(mapping, index);

I'm not sure if there's a point in locking the folio. If we are retrying,
then the logic above will lock it anyway and check uptodate. So I don't
think there's much of a point doing it here. Right?

So I think we could get away with a filemap_get_folio() here, and no
filemap_lock_folio() after RA. Unless you're intent on waiting for RA
right before failing, but I don't see a point in that.

With that addressed:

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

> +			if (IS_ERR(folio)) {
> +				page_cache_sync_readahead(mapping, &file->f_ra,
> +							  file, index, end - index);
> +				folio = filemap_lock_folio(mapping, index);
> +				if (IS_ERR(folio)) {
> +					result = SCAN_FAIL;
> +					goto out_put;
> +				}
> +			}
> +			index = folio_next_index(folio);
> +			folio_unlock(folio);
> +			folio_put(folio);
> +		}
> +		/* Drain the local LRU batch before retrying isolation. */
> +		lru_add_drain();
> +		readahead_done = true;
> +		goto retry;
> +	}
> +out_put:
>  	folio_put(new_folio);
>  out:
>  	VM_BUG_ON(!list_empty(&pagelist));
> -- 
> 2.49.0
> 

-- 
Pedro
