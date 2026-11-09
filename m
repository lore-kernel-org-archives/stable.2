Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221757;
	b=g2cCTdEa8HKECLoimrvtwIjjnuKfSze5rF+SVi2GoliJiodzdUbsUEC27OG9jz/HQddY
	 kLlgoden6Ce8Dvt34hDe9KAzA84t1yBfFCyLWbmjXNtQ+aIT853wHnOyoDsvPLCapwdIA
	 EeX4/0iXhw9G4RxBBInv1esKOaOloHCu/1Ry8o+A4BSkahJ8V6TlOiWg54b3ZAfuRHFOx
	 Jz4uUyUs5XACVueg+dHLjim6z3VIM7qrVtQcDkUQNKYP0XU5aSVhhqMGfY5lWSiKEl+G/
	 KuIUDeVdgCr1Jo82Hu++oQD8L5JfTdrLxMb6gOI6yjWyD2n/GLUB27+uFTpab+TikCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221757;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=WjVWX6E21tFl2sD8Mx7SLeOlrK6FQokIkj+LlsMQstQ=;
	b=WDNINnSKBXb7agBrQNFeJVWJfkjBfqm3/y6gyvjMqPnnxtzR7CyEs3ngMiopLWP3ToV5
	 WescARMn6ELDvr5hyKLkYNYTsASWo6vJcN8Mp1Udeb/daT22oPdwHOy2m7JHnQsfz6HDF
	 woomVGB5Q26DnRyO+DCEG4tlUQLVyxw6LCUySLStK4zxT4HJqzuuWuqn0PzC/5xDDn5Pt
	 uInorhZW+74FdqKmFjOvzAN83/kEHCtEZd+XbIlCcQVIF3aDRGPe3yzgVlhrhxCaaxSNA
	 PqXYg+uUfep7N4BJwwaIvHy+fIuxfOWac+gdXuw2J6WXpNXfkgWgN8550UiN5x7divg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=CscclKHE;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qufVQwoT;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=n7NL+oR7;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qZ3i4Ij6;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB4B606A333
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 10:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAB4B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=CscclKHE;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qufVQwoT;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=n7NL+oR7;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qZ3i4Ij6
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D8DA2202C;
	Mon,  9 Nov 2026 10:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794221748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WjVWX6E21tFl2sD8Mx7SLeOlrK6FQokIkj+LlsMQstQ=;
	b=CscclKHEIlu/Q61Xk5Hh4VchYO+eezj+MGVMuYCp8E2Xs8ENpkkNja9WQp0ucIIyQeV2j6
	y1OUzfzv9zSFSYqILcH40oukwIWrfPsWf/R325cZ/26GCAPCOdIWciItDUKgPjS9jNEH5P
	scALSnazHU/dRIuYjQkKonIHiB/++24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794221748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WjVWX6E21tFl2sD8Mx7SLeOlrK6FQokIkj+LlsMQstQ=;
	b=qufVQwoT1LMSP11eAa4ve7TRhyy8JX5taO1QNjgQEqXhR7vyx1RyLzuyOvwWCS/AvFH7+o
	TmrSXifcntz7kUBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=n7NL+oR7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qZ3i4Ij6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794221747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WjVWX6E21tFl2sD8Mx7SLeOlrK6FQokIkj+LlsMQstQ=;
	b=n7NL+oR7Reaim+RWNUMTZHX2Q/WVbcqcqJ9pPXizXf0ljWHkiTQIpIQU0hx2DR4wlkL0c2
	E9RdrhClQELefsBi9xLJ3fp4aLVAg62zrgC8QSHXvFYbHtqgJeTCJh4NDxz0rCQOj+fy9f
	fiLlhmj1UXgEtQFAwHEOfmHojYtvswE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794221747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WjVWX6E21tFl2sD8Mx7SLeOlrK6FQokIkj+LlsMQstQ=;
	b=qZ3i4Ij6wVdOuvLQnvtDp3MHdOPaZc5kDK/WlKCa0WV3s07OnP1hl2zmKhc0L7VHGK3VR8
	2bIKy5Lnbba3UjAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D703013319;
	Mon,  9 Nov 2026 10:55:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aeYKKrKm8WqQBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Nov 2026 10:55:46 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 5CE2221EB8; Mon, 09 Nov 2026 11:55:38 +0100 (CET)
Date: Mon, 9 Nov 2026 11:55:38 +0100
From: Jan Kara <jack@suse.cz>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: willy@infradead.org, jack@suse.cz, akpm@linux-foundation.org, 
	kas@kernel.org, dave.hansen@linux.intel.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] filemap: prefault writes starting beyond EOF
Message-ID: <vmzll2iszhdaycphuyjjp6vwki7gf4npbfb2eltzt3rc7pbdsk@bcnlvrzc6c2g>
References: <20261104071002.49693-1-dennylin0707@gmail.com>
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
In-Reply-To: <20261104071002.49693-1-dennylin0707@gmail.com>
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
	FREEMAIL_TO(0.00)[gmail.com];
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
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 0D8DA2202C

On Wed 04-11-26 07:10:02, Hungyu Lin wrote:
> Since prefaulting moved to the slow write path, a buffered write can reach
> ->write_begin() and ->write_end() before discovering that its source buffer
> is unreadable. Several filesystems can extend i_size in these callbacks
> even when no data was copied. For example, a one-byte pwrite() at offset
> 4096 into an empty file can fail with EFAULT but leave a 4096-byte file.
> 
> Prefault the source before ->write_begin() when the write position is
> beyond EOF, and return EFAULT if no source bytes can be made readable.
> Overwrites and appends continue to skip this prefault. Keep the existing
> slow-path faulting for forward progress after a failed atomic copy.
> 
> This also leaves intentional zero-length ->write_end() calls used by
> generic_cont_expand_simple() unchanged. As with the previous prefaulting
> behavior, a concurrent userspace unmap can still race with the later copy.
> 
> Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
> Reported-by: Kiryl Shutsemau <kas@kernel.org>
> Closes: https://lore.kernel.org/linux-mm/at9xXRhD2xZhszEj@thinkstation/
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Link: https://lore.kernel.org/all/at-XtWBQg3jv3H8Z@thinkstation/
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
>  mm/filemap.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b74bc1e5015c6f318333427f223b9f42061a6213..30414d55412b84f11ebe98b8eea607ee8c04eef5 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4389,6 +4389,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>  			break;
>  		}
>  
> +		/*
> +		 * Some filesystems can extend i_size even when nothing was copied.
> +		 * Prefault writes beyond EOF to catch unreadable source buffers.
> +		 */
> +		if (unlikely(pos > i_size_read(mapping->host)) &&
> +		    fault_in_iov_iter_readable(i, bytes) == bytes) {
> +			status = -EFAULT;
> +			break;
> +		}
> +
>  		status = a_ops->write_begin(iocb, mapping, pos, bytes,
>  						&folio, &fsdata);
>  		if (unlikely(status < 0))
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
