Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021502;
	b=IaC0a2Pi3cidCSfhnB9S7InqPojUzVYVx5lAoyBfWJZOSziOdgStFWEHoH57HjMQ7YUV
	 o8vqq3azE7tYnViuvcPQSqUiX8b8NbH39Rg+ZpoIzibtSJiADsXnTBRTsmCDqcXgAPHRC
	 vEMUpp9BOmtvQqmCqDQ9F+lPC3jfJUHMfjahWegjrFow9bgrFB3pendhpAb8rk1Ya2CDQ
	 L6gGfgMIBjeX3jtegmDZkcp273rA80J/pIH0IMMQiHBHy+zvtqRhysh/OjcW5mkC56B+5
	 HtUjzAiOhMYmvcRXJunkxHD1sahfXmJbbdqrrCMhTbpo2+2UBbdDF2BHL5iqWiBu3RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021502;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=LKf/jI/bjj0oPXrviRNSHjeXeMp3TxZx0LrRFINXjVw=;
	b=aFiEn5R4C9kFyohv+XDwFbpeCaVeyhLFLoDrr8ZjOdN8OYe65HHl7CqaXJHoiHeNsEZ5
	 6crBy0IPop179E5rAyOre6v6j4lsmAuQOucOJyQs29dxRSn0eRxRWklL6YQBn0Le1GMhK
	 9cjg3F9L0RyvB0fpMEw/i7MW8ba+U5eIja7TWpK0m92O6XkI1kCIqZDWQQvCcCcWiMKPP
	 jWcd1d9x3nEU0CkGPvjFr/Sl3ucW5/K9SMyWLPGgjOVDIXSlsVX7HaDsWkgyWVTXR7Jqt
	 uOG6oAc/yNMJQc0XFO0BXBJ4YlwJ0gf6Dni1wR3/9tBEHFPY2oKJmWQfKNMqYUCV1pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UX1M8Er+;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AstCp0Vn;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UX1M8Er+;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AstCp0Vn;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED8A606A31A;
	Mon, 26 Oct 2026 13:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ED8A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UX1M8Er+;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AstCp0Vn;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UX1M8Er+;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AstCp0Vn
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27FB721EBD;
	Mon, 26 Oct 2026 13:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793021500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LKf/jI/bjj0oPXrviRNSHjeXeMp3TxZx0LrRFINXjVw=;
	b=UX1M8Er+JZvgKRP+DnkHGie/LMyRJLqLTRWNMKOj+vLBPyOqyiDN7H22WQIJiAm1tmExF2
	CYQ/CL6epAdiKivnKyhe70jXQhl8NoosTUaZFT0RvqQzP0fX2uNnOSRmuun6FjyfoohMgI
	J5/ZxwjV5WS8j4OIIQL2O9Bc7I7UW7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793021500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LKf/jI/bjj0oPXrviRNSHjeXeMp3TxZx0LrRFINXjVw=;
	b=AstCp0Vn8QLm3QFjXiGbZoQjWqLwTJCuYYh/PwSlR9ZX5+HNTFcIgFeuvV0dzZzoKJOcsd
	5BHy+myC12caKbDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793021500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LKf/jI/bjj0oPXrviRNSHjeXeMp3TxZx0LrRFINXjVw=;
	b=UX1M8Er+JZvgKRP+DnkHGie/LMyRJLqLTRWNMKOj+vLBPyOqyiDN7H22WQIJiAm1tmExF2
	CYQ/CL6epAdiKivnKyhe70jXQhl8NoosTUaZFT0RvqQzP0fX2uNnOSRmuun6FjyfoohMgI
	J5/ZxwjV5WS8j4OIIQL2O9Bc7I7UW7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793021500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LKf/jI/bjj0oPXrviRNSHjeXeMp3TxZx0LrRFINXjVw=;
	b=AstCp0Vn8QLm3QFjXiGbZoQjWqLwTJCuYYh/PwSlR9ZX5+HNTFcIgFeuvV0dzZzoKJOcsd
	5BHy+myC12caKbDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F334913408;
	Mon, 26 Oct 2026 13:31:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ulRbMztW32qOeQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 13:31:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 80BEEA1419; Mon, 26 Oct 2026 14:31:31 +0100 (CET)
Date: Mon, 26 Oct 2026 14:31:31 +0100
From: Jan Kara <jack@suse.cz>
To: Jiale Yao <yaojiale02@163.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/5] filemap: drain in-flight DIO before buffered writes
Message-ID: <ddkjou5djippzkzf4euqg4wvsnjsc23fw4qldwi3hru5cxg4ul@eyts4mtzasxt>
References: <20261025124115.3178287-1-yaojiale02@163.com>
 <20261025124115.3178287-2-yaojiale02@163.com>
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
In-Reply-To: <20261025124115.3178287-2-yaojiale02@163.com>
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
	FREEMAIL_ENVRCPT(0.00)[163.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -12.80

On Sun 25-10-26 20:41:10, Jiale Yao wrote:
> An asynchronous direct write can remain in flight after its submitting
> thread releases the inode lock. A buffered write can then dirty page
> cache before the direct write completes its post-I/O invalidation. The
> invalidation finds dirty pages, reports a possible data corruption, and
> records -EIO in the mapping error sequence.

Well, when you do stupid things, you get stupid results. We were always
saying mixing buffered and direct IO in the same file isn't a good idea and
we try to not screw users too badly but give no promises. This falls into
that cathegory... So I don't think there's much to fix here. The only
sensible exception here are simple filesystems which have only simple
support for direct IO and fallback to buffered IO for the rest. But I think
we should handle these on a case-by-case basis and either drop the support
for direct IO altogether or convert them to iomap and properly handle the
waiting in their .write_iter methods (like e.g. ext2 does it).

								Honza

> Drain in-flight DIO before both regular buffered writes and direct I/O
> fallbacks in __generic_file_write_iter(). Preserve IOCB_NOWAIT semantics
> by returning -EAGAIN when waiting would be required, while retaining a
> positive partial direct write result.
> 
> Fixes: 8174202b34c3 ("write_iter variants of {__,}generic_file_aio_write()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  mm/filemap.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b74bc1e5015c..289b8ca44ada 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4502,10 +4502,19 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		 */
>  		if (ret < 0 || !iov_iter_count(from) || IS_DAX(inode))
>  			return ret;
> +		if ((iocb->ki_flags & IOCB_NOWAIT) &&
> +		    atomic_read(&inode->i_dio_count))
> +			return ret ?: -EAGAIN;
> +		inode_dio_wait(inode);
>  		return direct_write_fallback(iocb, from, ret,
>  				generic_perform_write(iocb, from));
>  	}
>  
> +	if ((iocb->ki_flags & IOCB_NOWAIT) &&
> +	    atomic_read(&inode->i_dio_count))
> +		return -EAGAIN;
> +	inode_dio_wait(inode);
> +
>  	return generic_perform_write(iocb, from);
>  }
>  EXPORT_SYMBOL(__generic_file_write_iter);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
