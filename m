Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598075;
	b=fkbfEbjCSjRFDN0hfasTL18Sn/37JKMuwKTXK4NoWYxl20MvgD0S0HPs4+4BNtxkAbfm
	 d0sKlRmHAXxXxD6mTtDEBMTXNPD3UKvu5p5SgrjfwdWXs+BOQ7647MSB5hfawqCUQxtrR
	 dGdSX2BCNYBZC8RwA1oztx+c9Hn/UsjNYYecVNKzdHO6p7Km2/9+KtexzwbQXI4JBi+5H
	 JVSASXDDu7vjnYqP1h7B2yRQGEBkBYMN2ZuSWM7Dm9Ldmqt3+dCidyTFD476KkJ4UJneI
	 CyUxn+69NXRwZl/vU+99cSUe7xsWaWAWkl7hYDKi3+755W8rha05mzPwFp94kL/XqeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598075;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=9ruMhBL6geZHtZpeVeqePM4fPGxZEpg6PQ9GdOn9Qfc=;
	b=29GZ//2uovaiXzhMkhO8P5kfdw1SgLcL4y5hhkKhxd+r2NVkkv8aLBbTwv2qAn9DDOWy
	 0p3m3ogImCEglZw95scCcG6C50Rn3KgSIlj7y2LFsfSG/tdK+FM393jUIXWcFlOUTLi6z
	 zlOWXoUZn7FcYMBJMoqC8tyWeTE1z/D4S/czQqk7iBxZgkIo0PKBK6LiLDBg3784rGFLz
	 4x+29QtLfB3txKQ5doPUjVi73tyqXJ/jXJ6cUUyn3F1uJXdsZzoENc56hRGZx+tcMIx3T
	 Eu0dnaE8/clY+VapdWaxXl+nzFUlmbKtvJD+EedcrBcskvTkNSttA1RS9Tc+A9q59cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=x3G2Yh+W;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BX6TdYFy;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=x3G2Yh+W;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BX6TdYFy;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9AB606A68F;
	Wed, 25 Nov 2026 09:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E9AB606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=x3G2Yh+W;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BX6TdYFy;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=x3G2Yh+W;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BX6TdYFy
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5FCE1F456;
	Wed, 25 Nov 2026 09:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795598072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ruMhBL6geZHtZpeVeqePM4fPGxZEpg6PQ9GdOn9Qfc=;
	b=x3G2Yh+WF8bse2bC62OJJaDoSphgPQQV5gJgM8+KNL0txwsG45ahWusw4L/hZo1OD6j/q6
	C5rl1V7XJjK04M/WpBwOPdFENLOHK+NgMG1ew84cFE8Xk/sC4w/lkGxIrBEFwmb/qrxyqm
	JiYEkZjBOnsS7ck8uGt9bcBw4sel3IY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795598072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ruMhBL6geZHtZpeVeqePM4fPGxZEpg6PQ9GdOn9Qfc=;
	b=BX6TdYFy9nKZNMhG8YeDvFJ4MGChj9K8CkJWw0Y32c4LF6QEM5Gl11K3mKe2Okz1D6UPdw
	g/ZdUtFMJKyLoeBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795598072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ruMhBL6geZHtZpeVeqePM4fPGxZEpg6PQ9GdOn9Qfc=;
	b=x3G2Yh+WF8bse2bC62OJJaDoSphgPQQV5gJgM8+KNL0txwsG45ahWusw4L/hZo1OD6j/q6
	C5rl1V7XJjK04M/WpBwOPdFENLOHK+NgMG1ew84cFE8Xk/sC4w/lkGxIrBEFwmb/qrxyqm
	JiYEkZjBOnsS7ck8uGt9bcBw4sel3IY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795598072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ruMhBL6geZHtZpeVeqePM4fPGxZEpg6PQ9GdOn9Qfc=;
	b=BX6TdYFy9nKZNMhG8YeDvFJ4MGChj9K8CkJWw0Y32c4LF6QEM5Gl11K3mKe2Okz1D6UPdw
	g/ZdUtFMJKyLoeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B3141339F;
	Wed, 25 Nov 2026 09:14:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v3WvFfimBmsDGgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Nov 2026 09:14:32 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 0981627BD4; Wed, 25 Nov 2026 10:14:28 +0100 (CET)
Date: Wed, 25 Nov 2026 10:14:28 +0100
From: Jan Kara <jack@suse.cz>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: report all-zero cachestat for DAX mappings
Message-ID: <mixn4cl5mnx5e2o3e5tlklaa5ynlu6qadorrlpifywqstbep2w@o6tylgke5umz>
References: <20261125030432.274396-1-bsdhenrymartin@gmail.com>
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
In-Reply-To: <20261125030432.274396-1-bsdhenrymartin@gmail.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,suse.cz,linux-foundation.org,gmail.com,cmpxchg.org,vger.kernel.org,kvack.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Score: -12.80

On Wed 25-11-26 11:04:32, Henry Martin wrote:
> filemap_cachestat() treats every xarray value entry as a workingset
> shadow.  On DAX mappings, value entries are DAX exceptional entries:
> same value bit, different bit layout (flags in the low bits, pfn
> above).  Decoded as a shadow, a DAX entry yields a bogus node id;
> NODE_DATA() for it can be NULL, and lru_gen_test_recent() then
> dereferences it:
> 
>   Oops: general protection fault
>   RIP: 0010:lru_gen_test_recent+0xde/0x300
>   Call Trace:
>    workingset_test_recent
>    filemap_cachestat
>    __x64_sys_cachestat
> 
> Any writable file on a DAX mount triggers this once an mmap write
> fault has populated entries.
> 
> DAX mappings have no page cache, so none of the cachestat fields
> make sense for them.  Skip the xarray walk for them and report all
> zeros, and document the behaviour in the syscall's kernel-doc.
> 
> This issue was discovered by Tencent CodeBuddy Security.
> Cc: stable@vger.kernel.org
> Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes in v2:
> - Return all zeros for DAX mappings instead of counting DAX entries as
>   cached, per Jan Kara's suggestion (Nhat Pham agreed).  This also drops
>   the dirty-accounting gap and the inaccurate PMD-order claim from v1.
> - Document the DAX behaviour in the syscall's kernel-doc.
> 
> Link: https://lore.kernel.org/linux-mm/lh4cnpy2kw3tdtmhubwhhvim25kxpqxo6xttt7sihyx7x5hqdf@3tvivew2qh7m/ [Jan Kara]
> Link: https://lore.kernel.org/linux-mm/CAKEwX=Py7W0vOwxKdWMCZu3d=BbF2OkgDt6Tu_AHhEJZ06w0ew@mail.gmail.com/ [Nhat Pham]
> Link: https://sashiko.dev/#/patchset/20261123030014.3116755-1-bsdhenrymartin@gmail.com?part=1
> 
>  mm/filemap.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index a1b2ca5b933cb..4f6fd1f4caedb 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4779,7 +4779,8 @@ static inline bool can_do_cachestat(struct file *f)
>   * The `flags` argument is unused for now, but is included for future
>   * extensibility. User should pass 0 (i.e no flag specified).
>   *
> - * Currently, hugetlbfs is not supported.
> + * Currently, hugetlbfs is not supported.  DAX mappings have no page
> + * cache, so cachestat() always reports all zeros for them.
>   *
>   * Because the status of a page can change after cachestat() checks it
>   * but before it returns to the application, the returned values may
> @@ -4824,7 +4825,10 @@ SYSCALL_DEFINE4(cachestat, unsigned int, fd,
>  		csr.len == 0 ? ULONG_MAX : (csr.off + csr.len - 1) >> PAGE_SHIFT;
>  	memset(&cs, 0, sizeof(struct cachestat));
>  	mapping = fd_file(f)->f_mapping;
> -	filemap_cachestat(mapping, first_index, last_index, &cs);
> +
> +	/* DAX mappings have no page cache; report all zeros. */
> +	if (!dax_mapping(mapping))
> +		filemap_cachestat(mapping, first_index, last_index, &cs);
>  
>  	if (copy_to_user(cstat, &cs, sizeof(struct cachestat)))
>  		return -EFAULT;
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
