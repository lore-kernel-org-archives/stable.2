Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524162;
	b=OtxoP2NMPd9aD1hnDXw3F2TZf50e769DhrOGFWu8qDNm4fvd/wvImQiawloOGrZ+oA/T
	 QNG1KNoSCt7EFrQxy7knjILVjBHv7A/Co4pPbamxCWTBMLRW3+h4mYp381pqlLdQ0sMqg
	 L17UTBy2z3NmqgUU7JiLo7XvDzg0Ss6rr5POr8/+k3KwIzXsJtruFZiABZYog5f09DgbD
	 FPLziobWKIZWokq1GYn68QbsWmviAY4aqj2LNvKRq7FvcGE5iiWPI8uYy3XyLoxSodRpC
	 TvSXJR/F0qGlxY2OteclYkN8CNOovjMu6xTFIC3k51IgoEC2hwHa8pN+TbNKjnijcQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524162;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=zTqJqtLVAhClH0Un/jCsQSvDa5fEGXg/BziUfu+XFT0=;
	b=VRRdLUYKI08Q1tT1sANL2EpMCJZkBJfUjN3oa0k1hurnlMSKO93gENg7EawuDB76k75U
	 i2ebnBkYNQtVbFNkEEA3qHFXOtmumUbZ73agJN8V6kl/lg0iwd9Hs5S6nlfsyXV/6HjA3
	 hyq+j2LRNWlKa7Oy9ztOkSuVQHNVbdE+mdW8y5lrdPuJL5+LzoSf7edY9ZvqGMUDx6I0X
	 3jO+57kwIR7rVNFEkfEi4Ywrqcldd9aCMZFXjieR05M5rbWOKIu/TAoLfDauXhWhbkMaN
	 mKMZ2uzzNKxu5OBIeuWo82iQZFbZOPkiw6Cobqa9/Z2ZP1Fy9bXZuORempwOxrA8Twg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=sp9xq77Y;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lCNfS4CM;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=sp9xq77Y;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lCNfS4CM;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A82606A32D;
	Tue, 24 Nov 2026 12:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82A82606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=sp9xq77Y;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lCNfS4CM;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=sp9xq77Y;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lCNfS4CM
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CA641F461;
	Tue, 24 Nov 2026 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795524159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zTqJqtLVAhClH0Un/jCsQSvDa5fEGXg/BziUfu+XFT0=;
	b=sp9xq77Y3UGi+wL44/r6/dl1iC7T/d1MmIfEnA/XjjNQjky3qmaYkvg4+UjHfbKMU2pK1+
	Y3pMvDkyeho9IlFQKeIFMfe7nJBnrF0O1Vgw6lCUcMCkNL8mpySRs3rjsn01E0N1ZJKNtL
	EtZwWvvrNUsa3i4vLB5h+zpoxOFn4Iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795524159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zTqJqtLVAhClH0Un/jCsQSvDa5fEGXg/BziUfu+XFT0=;
	b=lCNfS4CMRo0oF/zKFxD4us1DHCLI/Qs7BRlFIV3VUqKxL2o0Q+2IOvaApUWJLy3TD1Cdsf
	dwnMHQ606Uud1DAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sp9xq77Y;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lCNfS4CM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795524159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zTqJqtLVAhClH0Un/jCsQSvDa5fEGXg/BziUfu+XFT0=;
	b=sp9xq77Y3UGi+wL44/r6/dl1iC7T/d1MmIfEnA/XjjNQjky3qmaYkvg4+UjHfbKMU2pK1+
	Y3pMvDkyeho9IlFQKeIFMfe7nJBnrF0O1Vgw6lCUcMCkNL8mpySRs3rjsn01E0N1ZJKNtL
	EtZwWvvrNUsa3i4vLB5h+zpoxOFn4Iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795524159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zTqJqtLVAhClH0Un/jCsQSvDa5fEGXg/BziUfu+XFT0=;
	b=lCNfS4CMRo0oF/zKFxD4us1DHCLI/Qs7BRlFIV3VUqKxL2o0Q+2IOvaApUWJLy3TD1Cdsf
	dwnMHQ606Uud1DAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4285A1339F;
	Tue, 24 Nov 2026 12:42:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yC5VCD+GBWucEgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Nov 2026 12:42:39 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id CA50227875; Tue, 24 Nov 2026 13:42:34 +0100 (CET)
Date: Tue, 24 Nov 2026 13:42:34 +0100
From: Jan Kara <jack@suse.cz>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: fix cachestat NULL pgdat dereference on DAX mappings
Message-ID: <lh4cnpy2kw3tdtmhubwhhvim25kxpqxo6xttt7sihyx7x5hqdf@3tvivew2qh7m>
References: <20261123030014.3116755-1-bsdhenrymartin@gmail.com>
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
In-Reply-To: <20261123030014.3116755-1-bsdhenrymartin@gmail.com>
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
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,suse.cz,linux-foundation.org,gmail.com,cmpxchg.org,vger.kernel.org,kvack.org];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 6CA641F461

On Mon 23-11-26 11:00:14, Henry Martin wrote:
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
> DAX entries track present pages, not evicted folios.  Count them as
> cached and skip the workingset decode, mirroring the dax_mapping()
> split in the invalidation paths in mm/truncate.c.  PMD-order entries
> are counted as one page, as value entries carry no order information.
> 
> This issue was discovered by Tencent CodeBuddy Security.
> Cc: stable@vger.kernel.org
> Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>

I think that for DAX mappings, cachestat should just return all zeros
because none of the fields really make sense there. There's simply no page
cache for DAX mappings.

								Honza

> ---
>  mm/filemap.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index a1b2ca5b933c..caad0adde792 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4694,6 +4694,16 @@ static void filemap_cachestat(struct address_space *mapping,
>  			void *shadow = (void *)folio;
>  			bool workingset; /* not used */
>  
> +			/*
> +			 * DAX exceptional entries track present pages, not
> +			 * evicted folios.  They must not be decoded as
> +			 * workingset shadows.
> +			 */
> +			if (dax_mapping(mapping)) {
> +				cs->nr_cache += nr_pages;
> +				goto resched;
> +			}
> +
>  			cs->nr_evicted += nr_pages;
>  
>  #ifdef CONFIG_SWAP /* implies CONFIG_MMU */
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
