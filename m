Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794569176;
	b=zTY9rInRRxzbcU4sYKenKVvn5IMrdnweHTm+JnvQHAkekolivP8PVtF4UZTJx+9vxdMM
	 TooEpZvpUg0yxpNbXRqk7H1sfPIwzngx1ohSsfi8mmvqh/PXp5KbuxMsLFNTHjwePBtJn
	 mgWUNSnYY3wJM6+GIciico8kD0fsmm6LdRJdR5OBaAZozLIgPqOuECV6y4YTmrODEVHtL
	 ax4AM185dMYupUnl/cKR1PMzk2XoIZd0iISwXuzyAfTZ3K1cwbUQtQmfkjIewYmn490CV
	 PgGva7NS0Uv9dVE2bsX19ICb2LIOlCMJfgwL9g2h9jk5n12kUdf64LNCfchWQNW+LDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794569176;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=4x8nFWCpdcxb4NpnUFWgKTMy110gq5tD1D2+ep/FdgM=;
	b=GjJfTEKIuHzMyHGdxW122DmGMjD8iTugC3yOUTZAPhBuPbSMROTCPHczcDqF0ibljVte
	 0QlGFrbgP2PscqDhkRbX10OVG5mKwS0uiHkb0aVUumPgvCADBIXsxgnTuaaYSHuNcKQf+
	 77JchoUinHAeh+WDGyp1HAUtBtqTGnEsBSf6b6SYKTQA74miGarNgu6PDyThYVNVnwmDy
	 6GGpZ4VsKPZO2nbauuHTfyZIHSDC9E/mSbcTF86Un2i6craKAlIuBTljvAPj5ZOfKHt8/
	 KBjCs1rkYI811XCLwgz4bXISdiRRy4a91N3h+PHY+y8XuSzYlTPJUHff1sCXC3sjTiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="iDajg/Er";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CBoZeyLQ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="iDajg/Er";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CBoZeyLQ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5712C606A321;
	Fri, 13 Nov 2026 11:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5712C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=iDajg/Er;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CBoZeyLQ;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=iDajg/Er;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CBoZeyLQ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 714071F76B;
	Fri, 13 Nov 2026 11:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794569174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4x8nFWCpdcxb4NpnUFWgKTMy110gq5tD1D2+ep/FdgM=;
	b=iDajg/Ermjj/jmrnAiLhe05hC+gvgRafrJTvokoMfsoiabU0wr3lRLf5i9oEtU/Vk/fMk5
	BLrck70s9oishGkIlDzWJmNUZdh8a6ZwblF3Y6+ij6bzMkhDQho/uUxdBJvQDeseNREfBC
	cXzlOFfrE8Mnftxr/VNMkjdRs570He8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794569174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4x8nFWCpdcxb4NpnUFWgKTMy110gq5tD1D2+ep/FdgM=;
	b=CBoZeyLQqbD8/JtPqJ6i1lqu0QaDC5GCc9Vcdoj/CMihrXuTV9s/gURR4YVY4yz2FHZmlp
	oDL14eW6LMWcqhBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794569174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4x8nFWCpdcxb4NpnUFWgKTMy110gq5tD1D2+ep/FdgM=;
	b=iDajg/Ermjj/jmrnAiLhe05hC+gvgRafrJTvokoMfsoiabU0wr3lRLf5i9oEtU/Vk/fMk5
	BLrck70s9oishGkIlDzWJmNUZdh8a6ZwblF3Y6+ij6bzMkhDQho/uUxdBJvQDeseNREfBC
	cXzlOFfrE8Mnftxr/VNMkjdRs570He8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794569174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4x8nFWCpdcxb4NpnUFWgKTMy110gq5tD1D2+ep/FdgM=;
	b=CBoZeyLQqbD8/JtPqJ6i1lqu0QaDC5GCc9Vcdoj/CMihrXuTV9s/gURR4YVY4yz2FHZmlp
	oDL14eW6LMWcqhBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 416461344A;
	Fri, 13 Nov 2026 11:26:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0GgxB9bz9mpqPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Nov 2026 11:26:14 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id BD11C22CA0; Fri, 13 Nov 2026 12:26:13 +0100 (CET)
Date: Fri, 13 Nov 2026 12:26:13 +0100
From: Jan Kara <jack@suse.cz>
To: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Xiang Mei <xmei5@asu.edu>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] isofs: limit empty zisofs blocks to their uncompressed
 size
Message-ID: <it7eawzslh3dw6podnkacs47lwghp5iidovj3kbwjago6wnsra@vgr56wuuifw4>
References: <20261112143541.269-1-mdmitrichenko@astralinux.ru>
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
In-Reply-To: <20261112143541.269-1-mdmitrichenko@astralinux.ru>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,sashiko.dev:url,astralinux.ru:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,sashiko.dev:url]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Thu 12-11-26 17:35:40, Mikhail Dmitrichenko wrote:
> When a zisofs block is smaller than a page, the empty-block path in
> zisofs_uncompress_block() zeroes the rest of the page and returns that
> length. zisofs_fill_pages() then advances past the page without reading
> the remaining blocks, returning zeros instead of their contents.
> 
> For example, with 64 KiB pages and 32 KiB zisofs blocks, an empty first
> block should zero only the first half of the page. Instead, it zeroes
> the entire page and returns 64 KiB, so the second block is never read.
> 
> Commit 68d4d3e78150 ("isofs: fix out-of-bounds page array access on empty
> zisofs block") accounted for poffset but left this older problem in
> place. It was pointed out by Sashiko while reviewing a 5.10 backport.
> 
> Limit the zeroed range and returned length to one uncompressed block
> and the available output space. Only mark a folio uptodate when the
> range reaches its end. zisofs_fill_pages() already zeroes the tail and
> marks the partially filled folio uptodate at EOF.
> 
> Fixes: 59bc055211b8 ("zisofs: Implement reading of compressed files when PAGE_CACHE_SIZE > compress block size")
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/patchset/20261105083209.922-1-mdmitrichenko%40astralinux.ru
> Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>

Thanks. I've added this to my tree.

								Honza

> ---
>  fs/isofs/compress.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
> index 2d23abaeb874..c471007a76ed 100644
> --- a/fs/isofs/compress.c
> +++ b/fs/isofs/compress.c
> @@ -64,16 +64,24 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  	}
>  	/* Empty block? */
>  	if (block_size == 0) {
> -		for ( i = 0 ; i < pcount ; i++ ) {
> +		unsigned int bytes = min_t(loff_t, 1U << zisofs_block_shift,
> +					  (((loff_t)pcount) << PAGE_SHIFT) - poffset);
> +		unsigned int remaining = bytes;
> +
> +		for (i = 0; i < pcount; i++) {
>  			unsigned int off = i ? 0 : poffset;
> +			unsigned int len = min_t(unsigned int, remaining,
> +						 PAGE_SIZE - off);
>  			struct folio *folio = folios[i];
>  
> +			remaining -= len;
>  			if (!folio)
>  				continue;
> -			folio_zero_range(folio, off, folio_size(folio) - off);
> -			folio_mark_uptodate(folio);
> +			folio_zero_range(folio, off, len);
> +			if (off + len == folio_size(folio))
> +				folio_mark_uptodate(folio);
>  		}
> -		return (((loff_t)pcount) << PAGE_SHIFT) - poffset;
> +		return bytes;
>  	}
>  
>  	/* Because zlib is not thread-safe, do all the I/O at the top. */
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
