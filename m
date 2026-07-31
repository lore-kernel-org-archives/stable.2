Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B753EF0A0
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497747; cv=none; b=YSL7VOiBDvKE3MqKZAadhyhXJ0RY4FkK84ANNsGc2esKtTBJWCSr7tuseJ4Yd+ILMk9a9uR12DtA3UDIL3rFglgamSyZU8d7gsmZf0rHeLGEilMNSDXKjX3PSxyYCY1v42bdkS47D8bPOFm1HptYJOFANe6K6/YdkvZlQTG/5ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497747; c=relaxed/simple;
	bh=eS7PMH8rQeLscEniFu1WBe1VHM3qvs2ecqiwFkaX0U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2oMTgxvfwNKUoDVl1yf5EWEduBfWk69xdywO3MExhmFMLmHTEZMAHbhP1EDab5daUTrX0VDg74Jgnt/NcB08FB5G6odsi8mZlE4Wxp6CnKoIWt8v3y7NZEBP1qfJxlp+YwZtXtoV187fYYgyaWSLYqZOFLiUu+LrIWuFQuJrt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1yIQtzQh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W9OYDnOu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2b+imBQw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0gwssALx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1yIQtzQh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W9OYDnOu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2b+imBQw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0gwssALx"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A6EF67DF06;
	Fri, 31 Jul 2026 11:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785497739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DdoKKksVgNQFUZR7FTPENhfgtHOZxTqAYBL0F6JCNi8=;
	b=1yIQtzQh5hjbUejn+7ND5f35/RHM7s0wGxFfT0ZVk6dhAY7qU6eh+lD3Oox23HBC76rHFu
	Veu8/F7WULseFjCiJyDe+ptu6Xac51EIIo827FhRGzBg/0v5dmIPrhGtPyDGFciejHcu99
	gKQskqyoY/epyoukmzuvmJLVF5zuNMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785497739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DdoKKksVgNQFUZR7FTPENhfgtHOZxTqAYBL0F6JCNi8=;
	b=W9OYDnOuGvsiLTNrugHgTBh4OJkMJvvzVAGQLhxY2jZ/HZKzKBZD/2WX9yw+sHVG3j+iSg
	y3wysj8gcC3PIkAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785497735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DdoKKksVgNQFUZR7FTPENhfgtHOZxTqAYBL0F6JCNi8=;
	b=2b+imBQwv/fcQUhYSBBy8kHv77aVq5qckaKhvJ6QnqgN069c+uzGY5oUeZPVEYQbJ43Gw7
	wPcne7J8oEJWvLKBhzums3ZlsxiQpZ3wOYJf5Yu9pbdj1AKA+PtIajqlC9xRGyN2upuo00
	5htvUbV68HYV2j9oLCP7+eUbVyTZ7cg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785497735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DdoKKksVgNQFUZR7FTPENhfgtHOZxTqAYBL0F6JCNi8=;
	b=0gwssALx2NQ4VpQ3Fxr0nhKCKafyRQQAXRo5b43ycd/irt2H5Ml6lXPtZh2K1MjqYZ9TxZ
	bBgPPVneiHwC8+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E5DC779B0;
	Fri, 31 Jul 2026 11:35:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r4KjJoeIbGpgUgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 31 Jul 2026 11:35:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 38D7CA13A4; Fri, 31 Jul 2026 13:35:27 +0200 (CEST)
Date: Fri, 31 Jul 2026 13:35:27 +0200
From: Jan Kara <jack@suse.cz>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] fanotify: fix use-after-free of file range info
Message-ID: <433lrqir2g4xryun3bsakomhii6al2oamua2mhn3knjdbwiaf5@knswbgm4m2x2>
References: <20260730134316.2085087-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730134316.2085087-1-nicoyip.dev@gmail.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Thu 30-07-26 21:43:16, Chengfeng Ye wrote:
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
> Store the range position directly in the permission event and use
> FANOTIFY_NO_RANGE when range information is unavailable. The event remains
> alive until the reader finishes, so the reported offset no longer depends
> on the triggering task's stack.
> 
> Fixes: 870499bc1d4d ("fanotify: report file range info with pre-content events")
> Cc: stable@vger.kernel.org
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

Thanks! I've added the patch to my tree.

								Honza

> ---
> 
> Changes in v2:
> - Remove ppos from fanotify_perm_event and use FANOTIFY_NO_RANGE as the
>   sentinel for unavailable range information, as suggested by Jan Kara.
> - Read the event-owned position directly when reporting range information.
> 
> Link: https://lore.kernel.org/linux-fsdevel/20260730085801.2068723-1-nicoyip.dev@gmail.com/ [v1]
> 
>  fs/notify/fanotify/fanotify.c      | 3 +--
>  fs/notify/fanotify/fanotify.h      | 6 ++++--
>  fs/notify/fanotify/fanotify_user.c | 4 ++--
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index a3555bebad63..b05b6d3abb87 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -600,8 +600,7 @@ static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
>  	pevent->hdr.len = 0;
>  	pevent->state = FAN_EVENT_INIT;
>  	pevent->path = *path;
> -	/* NULL ppos means no range info */
> -	pevent->ppos = range ? &range->pos : NULL;
> +	pevent->pos = range ? range->pos : FANOTIFY_NO_RANGE;
>  	pevent->count = range ? range->count : 0;
>  	path_get(path);
>  
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index a0619e7694d5..3710543dbf82 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -428,6 +428,8 @@ FANOTIFY_ME(struct fanotify_event *event)
>  	return container_of(event, struct fanotify_mnt_event, fae);
>  }
>  
> +#define FANOTIFY_NO_RANGE	((loff_t)-1)
> +
>  /*
>   * Structure for permission fanotify events. It gets allocated and freed in
>   * fanotify_handle_event() since we wait there for user response. When the
> @@ -438,7 +440,7 @@ FANOTIFY_ME(struct fanotify_event *event)
>  struct fanotify_perm_event {
>  	struct fanotify_event fae;
>  	struct path path;
> -	const loff_t *ppos;		/* optional file range info */
> +	loff_t pos;			/* FANOTIFY_NO_RANGE if unavailable */
>  	size_t count;
>  	u32 response;			/* userspace answer to the event */
>  	unsigned short state;		/* state of the event */
> @@ -468,7 +470,7 @@ static inline bool fanotify_event_has_access_range(struct fanotify_event *event)
>  	if (!(event->mask & FANOTIFY_PRE_CONTENT_EVENTS))
>  		return false;
>  
> -	return FANOTIFY_PERM(event)->ppos;
> +	return FANOTIFY_PERM(event)->pos != FANOTIFY_NO_RANGE;
>  }
>  
>  static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index b604e3da58ad..bba92d691f0d 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -675,12 +675,12 @@ static size_t copy_range_info_to_user(struct fanotify_event *event,
>  	if (WARN_ON_ONCE(info_len > count))
>  		return -EFAULT;
>  
> -	if (WARN_ON_ONCE(!pevent->ppos))
> +	if (WARN_ON_ONCE(pevent->pos == FANOTIFY_NO_RANGE))
>  		return -EINVAL;
>  
>  	info.hdr.info_type = FAN_EVENT_INFO_TYPE_RANGE;
>  	info.hdr.len = info_len;
> -	info.offset = *(pevent->ppos);
> +	info.offset = pevent->pos;
>  	info.count = pevent->count;
>  
>  	if (copy_to_user(buf, &info, info_len))
> -- 
> 2.43.0
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
