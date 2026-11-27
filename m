Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790480;
	b=4/lAIdydhn2j2tTGqqmMWfFat/pkAFSg/3majpLrjSBL+wVwwQqsIESJ2bJdgEBVFYbF
	 mK/cXE1mErmKvjIU6I6UZAHH4dNTFb1CQqzuNyQR0Ewj1ikHvp/gCS/KcH3CSdS3A5u0s
	 lT/ZeD7eCDogW710D216NyIK+GkwO76yWJDKk9jrp6Cj68eSmuZc6/FuCUNV0FuulauGF
	 20KJ6reSks0YpHXvB77rzLGex2AVxbtqY//lMgHJnTM/bSzjlclo414Q8eY2JhUCl5yr8
	 2ZlK0+tH/FGbjHAgVvAa8mWhMDFhsq+huPmzgtkmPpm1jYEsw/kzP6pur/8XmJ/nyFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790480;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=5OiMqB0HFqHTXQ26F6nnKmMgWEH3gjayAZHzMcMj1aU=;
	b=w4DcHihZz2xRtqF6prcGXJsI/nTQR5igJDe82MRBqZfXtYIsf2AhWZpvFWsnm1xt4iAr
	 zLUgX49c2FmMATjP9CeNqFJbvvs05bKEzUtzYbz0SdphopGWwXedbsLQlE6gydfRr3xj8
	 s5dkotKMSqbAo4VqjtbVEgLMRtj5gPU+wK9+n2o+ioObe7k48U8S8GNUtkIAMdzoY2g4+
	 QoHxFjKGybTPMZm5I1RmlaWY+CgkPqN1IqZpQa3+cROC1ICla3l5B3I+De5SRz3EDT1gb
	 WLO9MvkneqlfWuw1+RAvp7kReq5XlElKw+FITCUW94pYxqXVjUSFDeaYvpNjTLFTabQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=V18JV07i;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=V3WqNeUg;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=V18JV07i;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=V3WqNeUg;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83915606A327;
	Fri, 27 Nov 2026 14:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83915606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=V18JV07i;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=V3WqNeUg;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=V18JV07i;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=V3WqNeUg
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ABDEB22936;
	Fri, 27 Nov 2026 14:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795790477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5OiMqB0HFqHTXQ26F6nnKmMgWEH3gjayAZHzMcMj1aU=;
	b=V18JV07iazluiBay10fP/4fd0aBvpx12c6oF3mwpxHXAz2019+WnkVqDSmKZaSvTDlMhPF
	+XNcC7x/9xS53FynRM9dvfhEdVgtRrrJQHH2ACw69rokKv+FHXTcm7PNCnE8tEKcZQmeJF
	hnt16LEz+mQWdpgZEpYRwU0z+1jzExc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795790477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5OiMqB0HFqHTXQ26F6nnKmMgWEH3gjayAZHzMcMj1aU=;
	b=V3WqNeUgkgQSxLbxSxJo8uXWKoVfkUXxcp5ohyGehBBEEMBEjZJ+8bwnYcECcgLBCveJmp
	KHVJE0UjiSqIGoCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795790477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5OiMqB0HFqHTXQ26F6nnKmMgWEH3gjayAZHzMcMj1aU=;
	b=V18JV07iazluiBay10fP/4fd0aBvpx12c6oF3mwpxHXAz2019+WnkVqDSmKZaSvTDlMhPF
	+XNcC7x/9xS53FynRM9dvfhEdVgtRrrJQHH2ACw69rokKv+FHXTcm7PNCnE8tEKcZQmeJF
	hnt16LEz+mQWdpgZEpYRwU0z+1jzExc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795790477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5OiMqB0HFqHTXQ26F6nnKmMgWEH3gjayAZHzMcMj1aU=;
	b=V3WqNeUgkgQSxLbxSxJo8uXWKoVfkUXxcp5ohyGehBBEEMBEjZJ+8bwnYcECcgLBCveJmp
	KHVJE0UjiSqIGoCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ECF013432;
	Fri, 27 Nov 2026 14:41:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w90gF42WCWvcXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Nov 2026 14:41:17 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 13DF251056; Fri, 27 Nov 2026 15:41:13 +0100 (CET)
Date: Fri, 27 Nov 2026 15:41:13 +0100
From: Jan Kara <jack@suse.cz>
To: Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Jinchao Wang <wangjinchao600@gmail.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/readahead: read folio order limits under the
 invalidate lock
Message-ID: <pmv77fehocb557wy6vtcu2fank4uf54k42n22owpyuxxzxfgkj@46pvovh3r7jg>
References: <20261127072340.73758-1-zhaogongyi@bytedance.com>
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
In-Reply-To: <20261127072340.73758-1-zhaogongyi@bytedance.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,suse.cz,linux-foundation.org,kernel.dk,gmail.com,kvack.org,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,bytedance.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80

On Fri 27-11-26 15:23:40, Zhao Gongyi wrote:
> Block device mmap readahead can race with set_blocksize(), which updates
> the block size and minimum folio order under the exclusive invalidate
> lock. page_cache_ra_order() reads the minimum before taking the shared
> lock and can allocate a folio smaller than the new block size. On the
> buffer-head path this can cause a NULL dereference in guard_bio_eod().
> 
> Take the existing shared invalidate lock before computing the folio order
> limits so they stay valid through allocation and I/O submission.
> 
> Fixes: 47dd67532303 ("block/bdev: lift block size restrictions to 64k")
> Cc: stable@vger.kernel.org # 7.3+
> Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>

Ups, this is hairy. The fix looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Earlier proposals:
>   https://lkml.iu.edu/hypermail/linux/kernel/2511.3/04090.html
>   https://lore.kernel.org/r/aUN9BFdxHQj8ThMS@ndev
> 
> The earlier syzbot retest hit a bug in the fallback path. Since
> b244c89a70b3, the caller holds invalidate_lock before the fallback reads
> min_nrpages. This patch covers the remaining mmap readahead path.
> 
> A/B testing on arm64/QEMU at the declared base commit gave 10/10
> baseline hits via madvise and 6/10 via MAP_POPULATE. Both paths had
> 0/10 hits with this patch. The 20 patched serial logs showed no kernel
> warnings or crashes.
> 
>  mm/readahead.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 6e5563290..80f3e141d 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -484,7 +484,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  	struct address_space *mapping = ractl->mapping;
>  	pgoff_t start = readahead_index(ractl);
>  	pgoff_t index = start;
> -	unsigned int min_order = mapping_min_folio_order(mapping);
> +	unsigned int min_order;
>  	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
>  	pgoff_t mark;
>  	unsigned int nofs;
> @@ -506,15 +506,17 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  		mark = ULONG_MAX;
>  	}
>  
> +	/* See comment in page_cache_ra_unbounded() */
> +	nofs = memalloc_nofs_save();
> +	filemap_invalidate_lock_shared(mapping);
> +
> +	/* Serialize with set_blocksize() updating the minimum folio order. */
> +	min_order = mapping_min_folio_order(mapping);
>  	new_order = min(mapping_max_folio_order(mapping), new_order);
>  	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
>  	new_order = max(new_order, min_order);
> -
>  	ra->order = new_order;
>  
> -	/* See comment in page_cache_ra_unbounded() */
> -	nofs = memalloc_nofs_save();
> -	filemap_invalidate_lock_shared(mapping);
>  	/*
>  	 * If the new_order is greater than min_order and index is
>  	 * already aligned to new_order, then this will be noop as index
> 
> base-commit: 29378f5cd79a27718ead9717fe7b094b651a8e1e
> -- 
> 2.39.5 (Apple Git-154)
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
