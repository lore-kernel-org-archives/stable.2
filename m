Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656067;
	b=wjwFt/IHeGBamgwg/yfV5fteZNELp9LWyQOlVtf0jbJMVO/6q/DuYL+ZonpeHhyTTQfp
	 4LiBKn6k7iSztlFEIYTijxMZHZcPqNiXwYpOIU3nxBYWTb9dGCbqUun0osYdJ9W6SUKF2
	 GzCFCyeg5x9+UP8LqO1Oijxg+TpJqQMpoPK99Lum0mThzGfqhXBaPuoQ2vaOo8gieeb/Z
	 oYoj5o6MZlj9VULxTmHdY6Fkr8Mszg7+BILZuSDYJBDo59ML2+2QM+albU6wNzMsKDsVg
	 PoCMH9+Yrus/nXCBJsBpSHt5cRCHV7H6NJQxxxhqQMGDkEzPKvERj78kvyYspwMqf7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656067;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=Hm+ytWjWmjwRRRqkaZgxMRCNpo3ZO0Yg6C7lgInlKnY=;
	b=fRFHM8TclHjxH4d7yOHc55XDbOFrIcVzquq+tWhmmutbitoIpEVWrHYtZmduryP06COO
	 q0e+h+pwUmmv3kiTVzO4H2Gsjuj3eGrn/Opgn1wZ+CGQ59fG1ICkM5VfI3tK4G3/jqoRt
	 4ikuroZvI5x4dPzYc5I8nPmTAEdHsG35zts3M2VuW5Le7vsMA22kOFKgAbvoqmpdr2Sqw
	 jFUFFTa5I4EvDG66OiBohFsEg9tQxqhSsGDk7u5Wvlsuq220+Q7wgX8oEmEd/dOANBxJe
	 0mvU1H1RRWtA5cAHEOq8SjXUslSydLyRTKpO6c1RR/oODFGVvbm9TD5P6akDqBsz3zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=fUzE4Bey;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KVNiJYe5;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=fUzE4Bey;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KVNiJYe5;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835CA606D82D;
	Mon,  2 Nov 2026 21:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 835CA606D82D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=fUzE4Bey;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KVNiJYe5;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=fUzE4Bey;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KVNiJYe5
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 66BC021FAA;
	Mon,  2 Nov 2026 21:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793656064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hm+ytWjWmjwRRRqkaZgxMRCNpo3ZO0Yg6C7lgInlKnY=;
	b=fUzE4Beyy/9uaHzBHgm0a/0E9WDXX2YUGoq3mmbuxpzbD76cPpX00HGegTJTQvIUeu3aSX
	9QaCFiOtAFIK+PsS3+jgF4iHKXlM3uWZtzXjDVna3uRaFKqtH1Tm2I8CDtW2ZPP8mRHMOw
	wnRnssT1EZOqce3XIy2EwC4Riq8usXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793656064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hm+ytWjWmjwRRRqkaZgxMRCNpo3ZO0Yg6C7lgInlKnY=;
	b=KVNiJYe5dBXqQS0Zoj5dO/MULZaRCLCLai/0Rde7pMHM3IPbvZnP6m6jmT1uffD6SNnlxa
	omPZYJIG1NVqnFCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fUzE4Bey;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KVNiJYe5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793656064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hm+ytWjWmjwRRRqkaZgxMRCNpo3ZO0Yg6C7lgInlKnY=;
	b=fUzE4Beyy/9uaHzBHgm0a/0E9WDXX2YUGoq3mmbuxpzbD76cPpX00HGegTJTQvIUeu3aSX
	9QaCFiOtAFIK+PsS3+jgF4iHKXlM3uWZtzXjDVna3uRaFKqtH1Tm2I8CDtW2ZPP8mRHMOw
	wnRnssT1EZOqce3XIy2EwC4Riq8usXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793656064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hm+ytWjWmjwRRRqkaZgxMRCNpo3ZO0Yg6C7lgInlKnY=;
	b=KVNiJYe5dBXqQS0Zoj5dO/MULZaRCLCLai/0Rde7pMHM3IPbvZnP6m6jmT1uffD6SNnlxa
	omPZYJIG1NVqnFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DDF1134B3;
	Mon,  2 Nov 2026 21:47:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vkdUCQAF6WplAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Nov 2026 21:47:44 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id E6688B17D; Mon, 02 Nov 2026 22:47:39 +0100 (CET)
Date: Mon, 2 Nov 2026 22:47:39 +0100
From: Jan Kara <jack@suse.cz>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Krystian Kaniewski <krystianmkaniewski@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/filemap: stop fault-around when the walk steps back
Message-ID: <kppowwph3bjl6qnbzmoq5zdjplt5eebiuweuvrm7wa7dqfhgt7@sj7kyq2ja3nh>
References: <20261031-jf-mm-filemap-map-pages-lower-bound-v2-1-21029744e589@linux.dev>
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
In-Reply-To: <20261031-jf-mm-filemap-map-pages-lower-bound-v2-1-21029744e589@linux.dev>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linux.dev:email,msgid.link:url];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,suse.cz,linux-foundation.org,kernel.org,vger.kernel.org,kvack.org,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,linux.dev:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,msgid.link:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 66BC021FAA

On Sat 31-10-26 04:33:59, Jose Fernandez (Anthropic) wrote:
> filemap_map_pages() can dereference a PTE pointer outside the page table
> it locked. KASAN has reported this as a use-after-free read [1]. The
> same path can also write out of bounds. When the stray entry reads as
> none, the fault-around loop maps a page there with set_pte_range().
> 
> Its fault-around loop walks the page cache and moves vmf->pte by the
> change in index. A lower index moves it back. xas_find() can step back
> to a lower index when a multi-index entry is split during the walk.
> 
> [1] fixes xas_find(), but the loop still relies on the walk never
> stepping back. Stop the fault-around when the walk steps back. ->fault()
> maps the faulting page if the loop did not.
> 
> Link: https://lore.kernel.org/20260904121301.200049-1-krystianmkaniewski@gmail.com [1]
> Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes in v2:
> - Add Fixes: and Cc: stable tags, and say in the message that the loop
>   can also write out of bounds (David Hildenbrand).
>   https://patch.msgid.link/0a1ad7d2-ff0e-4248-8f03-2a64a9134aae@kernel.org
> - Link to v1: https://patch.msgid.link/20261028-jf-mm-filemap-map-pages-lower-bound-v1-1-0bf126e876d4@linux.dev
> ---
>  mm/filemap.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b74bc1e5015c..1df776907140 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3968,6 +3968,13 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  		unsigned long end;
>  		vm_fault_t map_ret;
>  
> +		/* A lower index could move vmf->pte out of its page table. */
> +		if (unlikely(xas.xa_index < last_pgoff)) {
> +			folio_unlock(folio);
> +			folio_put(folio);
> +			break;
> +		}
> +
>  		addr += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
>  		vmf->pte += xas.xa_index - last_pgoff;
>  		last_pgoff = xas.xa_index;
> 
> ---
> base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
> change-id: 20261028-jf-mm-filemap-map-pages-lower-bound-a623ed8a81c9
> 
> Best regards,
> --  
> Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
