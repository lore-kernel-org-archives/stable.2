Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA8D36F8F5
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407068; cv=none; b=uq+SIVmRBWjsORAhdNY+Ib/9PdlSL5ME3ZYpueQ8FmNEMRoI+2KCD42cP1crOiZoK8RfNlTU+XO8DXKQf2tGO98VrVkYxRRwfl6Cn6CTLNhZJEgvLTFPu8Hm5H5Auk08UTIWrHsD10F+BWKcUSK9XhFZ4RUYzPImpH/sY2L1nkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407068; c=relaxed/simple;
	bh=6MjKi65qbbsw3CNf3rM1GiQOeSxiUd3JyvZ70YjB+54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDoolsQXDgbC7DbqV8dgKW0raZVVcwGRYDfwBZu9AbAt7OwjMqZFWvYZRcDK/uXOb7GQsuQc/DeM27jaBVaQthFCe0H0T3+TImjT2H1DQUIDIiNyGjND8HYVwZ6QxicsrDdu1Fl4RU2945VbZ3sxPzD1CGZby6VssJuTKtOOwRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wito95Uv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y0ZhYQLn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hSgTZFm5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r1Wl74VD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wito95Uv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y0ZhYQLn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hSgTZFm5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r1Wl74VD"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ED1517D6BC;
	Thu, 30 Jul 2026 10:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785407061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=opDwt57Ie+JYRyS1iHITtuftmOaehopxDSxLn4jODiE=;
	b=wito95UvNBa11Pg9cTA3thpu/CxbljlRBP3qXYlydMkoyd/0djq04vcAO9gteCFh3vypOf
	fvJS0W6N3muSTZ8qLplZiLzhf7d/W5v3MrKmVNmngw/v3FxWQHmCzXd9/y1xQM3aBTD1uf
	kicnBbQ842QHeZcqtX/0v4c3Z2CgH0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785407061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=opDwt57Ie+JYRyS1iHITtuftmOaehopxDSxLn4jODiE=;
	b=y0ZhYQLncwugpPVN2y+tSjnZe4zU/9/+3GY92v8rRjiHWgbWc+FGVjmTdA10IE2FC2m6Bs
	IZ0+/iTkQ9QI/+DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hSgTZFm5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=r1Wl74VD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785407056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=opDwt57Ie+JYRyS1iHITtuftmOaehopxDSxLn4jODiE=;
	b=hSgTZFm5YM9E0qLrwhwPrYC7FwTv8xtuizTgznD/qQGd5nElfEdWBVHNKhNJB67LPmCgk7
	PabsV61WSu5kCzAR5pr+MYf9Lg/ECLCnViZ5Dw0c8JXD1fL1E+TjlRomDXePyF7RDsk9Va
	Ddj9PEDxnaRHoDhXeawcZFEBJg5hPIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785407056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=opDwt57Ie+JYRyS1iHITtuftmOaehopxDSxLn4jODiE=;
	b=r1Wl74VDZWRqx0VbOeAys4+VlsHFmY0124+DLqTbDvul+j8wNWb1gNj7Prsq8QHSH5el80
	f+iG/q3dWDIH/YDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3E87779CC;
	Thu, 30 Jul 2026 10:24:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hlGbN1Ama2ojLAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Jul 2026 10:24:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8C489A0AAA; Thu, 30 Jul 2026 12:24:16 +0200 (CEST)
Date: Thu, 30 Jul 2026 12:24:16 +0200
From: Jan Kara <jack@suse.cz>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fanotify: fix use-after-free of file range info
Message-ID: <lkaqsnjtsfqbnlm456mxpq4k3hchwpmd4rnwydj2xektrnem7f@gwz5xjiduxfg>
References: <20260730085801.2068723-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730085801.2068723-1-nicoyip.dev@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: ED1517D6BC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Thu 30-07-26 16:58:01, Chengfeng Ye wrote:
> fsnotify_pre_content() builds its file_range on the triggering task's
> stack. fanotify_alloc_perm_event() saves a pointer to range.pos in the
> heap-allocated permission event so copy_range_info_to_user() can report
> the offset later.
> 
> The event reader can set the event state to FAN_EVENT_REPORTED and then
> sleep while preparing the file descriptor. If a signal interrupts the
> triggering task at that point, fanotify_get_response() changes the state
> to FAN_EVENT_CANCELED and returns. This unwinds the file_range stack
> frame while the reader still owns the event. The reader then dereferences
> pevent->ppos and copies the stale stack value to userspace.
> 
> KASAN reported:
> 
>   BUG: KASAN: use-after-free in fanotify_read+0x293e/0x2970
>   Read of size 8 at addr ffff88811434fc50 by task fanotify_inotif/95
>   Call Trace:
>    fanotify_read+0x293e/0x2970
>    vfs_read+0x177/0xa20
>    ksys_read+0xf7/0x1c0
>    do_syscall_64+0xf9/0x540
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Copy the range position into the permission event and make ppos refer to
> that event-owned value. The event remains alive until the reader finishes,
> so the reported offset no longer depends on the triggering task's stack.
> 
> Fixes: 870499bc1d4d ("fanotify: report file range info with pre-content events")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

Thanks for report! That's indeed a nasty bug. FWIW I always disliked how we
passed pointer to pos around instead of pos itself only to be able to
indicate it is not defined. Since loff_t is actually signed, Amir, do you
remember why we didn't just define (loff_t)-1 as "range not provided"
message instead of passing around ppos?

I think getting rid of passing ppos around and storing it to the permission
event would be preferrable over the hybrid approach in this patch.

								Honza

> ---
>  fs/notify/fanotify/fanotify.c | 3 ++-
>  fs/notify/fanotify/fanotify.h | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index a3555bebad63..c97d1be70310 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -601,7 +601,8 @@ static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
>  	pevent->state = FAN_EVENT_INIT;
>  	pevent->path = *path;
>  	/* NULL ppos means no range info */
> -	pevent->ppos = range ? &range->pos : NULL;
> +	pevent->pos = range ? range->pos : 0;
> +	pevent->ppos = range ? &pevent->pos : NULL;
>  	pevent->count = range ? range->count : 0;
>  	path_get(path);
>  
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index a0619e7694d5..c964df6c0514 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -438,7 +438,8 @@ FANOTIFY_ME(struct fanotify_event *event)
>  struct fanotify_perm_event {
>  	struct fanotify_event fae;
>  	struct path path;
> -	const loff_t *ppos;		/* optional file range info */
> +	loff_t pos;
> +	const loff_t *ppos;		/* &pos if range info is available */
>  	size_t count;
>  	u32 response;			/* userspace answer to the event */
>  	unsigned short state;		/* state of the event */
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
