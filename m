Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFA84137A5
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923671; cv=none; b=ubrcb76dcKxBjWLmjvdKq7ASwhHKERfL8i9Yi0TceQV3op/Ad6ql7glDanBbNmg4CWf5GdLrZhegBMdLncUrb7IU9/DS9oXRXWYjffNLpyXV1kQT3l9IuypUH+iNu0W7wZPmBsduVpNuccZMaalttjYaJM2cvWKRmHNBgkpreyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923671; c=relaxed/simple;
	bh=JQ3oZVjLP87sHYjb40c9x7VGq7no8bJJrBM64eKvE7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOgd29uUiEOXIic8NPy8ExJadfrNt7OB/U4ApQLtUWbdPnPK0Ge/56lEYKMFmbpqzFTqAimyj08VJTNK4q6IyB0LZKbT6RAT1QrOKMhh9Qhj9iJ6SGuWE1G+FIMctBYpHBfSViMJn5zDm174ttLKFK0vkLStPOM0efIkdYapz9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L6ICGwBK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ML4uu4Lj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LoBlLnBk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=70OBZuG+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L6ICGwBK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ML4uu4Lj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LoBlLnBk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="70OBZuG+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2BFA87FC19;
	Wed,  5 Aug 2026 09:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785923663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eeajFeVjPjUQuZaaEAEPZnfTLpVdRSKGZG/gV3HhPAM=;
	b=L6ICGwBKfLu/3qQyzjGtJni6yfmjmvutjWtuuMohgnHIdkNQat/Qlz9bmzfLheIeFuJl/x
	Lq6a3jdFe49c8BPQmO3qg5PBAmqmVtduE5ZzMCXiaFZ83ATKSLEnQoEidoMNA4T0T4wMJ3
	hFanS7w2rll2ZsQQwhGV8BxOYmfWBBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785923663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eeajFeVjPjUQuZaaEAEPZnfTLpVdRSKGZG/gV3HhPAM=;
	b=ML4uu4LjsgQZ4+LXXy4FonLcZ0xYgZHBjLXYThsfwRdt5xAQg9lxy5YfQGlKA4+vKjInww
	L+hk81ICW8RUYYCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785923659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eeajFeVjPjUQuZaaEAEPZnfTLpVdRSKGZG/gV3HhPAM=;
	b=LoBlLnBkxJP0NsRwJrh5aBq7Y5DJ/k3c9GYIMBt3RyVO/NDQmDFqQzJ/D/yp9MiSF0p9Wt
	4QI84DuL6rM/hWfuVkunjKHT14Cj8+h+SBO+vArkZlskXGwYfNgKLtxWzhsGqmx6wfKGZt
	sjNrV9iI4y6eMAF92MNov2sB00phOew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785923659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eeajFeVjPjUQuZaaEAEPZnfTLpVdRSKGZG/gV3HhPAM=;
	b=70OBZuG+RZGRPxnQL6V4s24IINoHbVVa7QQZ8p4wPyMseQROTCsxqu5KAtkOs2ubAYaucl
	77vqgzJ382nJ6bDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17F6A779B6;
	Wed,  5 Aug 2026 09:54:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /t7TBUsIc2qQTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Aug 2026 09:54:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B5ECBA13A7; Wed, 05 Aug 2026 11:54:14 +0200 (CEST)
Date: Wed, 5 Aug 2026 11:54:14 +0200
From: Jan Kara <jack@suse.cz>
To: Youngjae Kwon <yjkwon0026@snu.ac.kr>
Cc: jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3] fsnotify: Fix stale object mask after concurrent mark
 updates
Message-ID: <gc2bqp2c3a6emhshpewjalti2j26a5zsrmd6s4gopzvmofklqw@xjnfn4tbaktb>
References: <20260801055704.2663156-1-yjkwon0026@snu.ac.kr>
 <20260802015801.2426818-1-yjkwon0026@snu.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802015801.2426818-1-yjkwon0026@snu.ac.kr>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Sun 02-08-26 10:58:00, Youngjae Kwon wrote:
> When a mark gets a new event bit, fanotify and inotify may avoid
> recalculating the object mask if the cached aggregate already contains that
> bit. This is racy with a recalculation triggered by a concurrent update to
> another mark on the same connector.
> 
> The concurrent scan can read the mark before the new bit is added, while
> the updater reads the old aggregate before that scan publishes its result.
> The updater then skips recalculation and the scan publishes a mask without
> the bit, leaving the object mask stale after both updates complete.
> 
> This can be reproduced with two fanotify groups watching the same inode:
> one thread removes FAN_MODIFY from one existing mark while another thread
> adds FAN_MODIFY to the other mark. After both fanotify_mark() calls return,
> writes can fail to produce FAN_MODIFY for the group whose mark now contains
> the bit. This was reproduced on an unmodified v6.12.95 kernel. The
> equivalent inotify interleaving loses IN_MODIFY events.
> 
> For normal fanotify additions, recalculate whenever the raw mark mask
> changes. The normal mask is not cleared asynchronously, so an unchanged
> addition cannot introduce missing interest. Always recalculate ignore-mask
> updates because FS_MODIFY handling may clear the ignore mask without taking
> mark->lock, making snapshot comparisons unreliable.
> 
> Always recalculate after updating an existing inotify watch. Its replace
> path temporarily sets mark->mask to zero, so a concurrent scan can observe
> zero even when the old and final masks are equal. Assigning the replacement
> mask directly would avoid the transient zero, but existing-watch updates
> are infrequent, so unconditional recalculation is simpler.
> 
> Link: https://lore.kernel.org/all/CACwKKmCZdiZDoFuYm6LZhQ=XvHPk0fNKH=X3LmoXMqakYqJaNw@mail.gmail.com/
> Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
> Fixes: 912ee3946c5e ("fanotify: do not call fanotify_update_object_mask in fanotify_add_mark")
> Cc: stable@vger.kernel.org # needs adjustments for <= 7.0
> Suggested-by: Jan Kara <jack@suse.cz>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>

Thanks the patch looks good to me, I've added it to my tree. Amir, are you
happy with the changes like this?

								Honza

> ---
> Changes in v3:
> - Preserve the normal fanotify duplicate-add fast path by recalculating
>   only when the raw normal mask actually changes.
> - Recalculate fanotify ignore-mask updates unconditionally because the
>   ignore mask may be cleared concurrently without mark->lock.
> - Keep v2's unconditional recalculation for existing inotify watch updates.
> 
> I will send backports for stable kernels through 7.0.y after this lands.
> 
>  fs/notify/fanotify/fanotify_user.c | 12 +++++++-----
>  fs/notify/inotify/inotify_user.c   | 15 +--------------
>  2 files changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 9ee373ff5..9c27db2b7 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1321,16 +1321,18 @@ static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
>  static bool fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
>  				      __u32 mask, unsigned int fan_flags)
>  {
> +	__u32 old_mask;
>  	bool recalc;
>  
>  	spin_lock(&fsn_mark->lock);
> -	if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS))
> +	if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS)) {
> +		old_mask = fsn_mark->mask;
>  		fsn_mark->mask |= mask;
> -	else
> +		recalc = old_mask != fsn_mark->mask;
> +	} else {
>  		fsn_mark->ignore_mask |= mask;
> -
> -	recalc = fsnotify_calc_mask(fsn_mark) &
> -		~fsnotify_conn_mask(fsn_mark->connector);
> +		recalc = true;
> +	}
>  
>  	recalc |= fanotify_mark_update_flags(fsn_mark, fan_flags);
>  	spin_unlock(&fsn_mark->lock);
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index ed37491c1..5f19c24ec 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -539,7 +539,6 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
>  {
>  	struct fsnotify_mark *fsn_mark;
>  	struct inotify_inode_mark *i_mark;
> -	__u32 old_mask, new_mask;
>  	int replace = !(arg & IN_MASK_ADD);
>  	int create = (arg & IN_MASK_CREATE);
>  	int ret;
> @@ -555,27 +554,15 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
>  	i_mark = container_of(fsn_mark, struct inotify_inode_mark, fsn_mark);
>  
>  	spin_lock(&fsn_mark->lock);
> -	old_mask = fsn_mark->mask;
>  	if (replace) {
>  		fsn_mark->mask = 0;
>  		fsn_mark->flags &= ~INOTIFY_MARK_FLAGS;
>  	}
>  	fsn_mark->mask |= inotify_arg_to_mask(inode, arg);
>  	fsn_mark->flags |= inotify_arg_to_flags(arg);
> -	new_mask = fsn_mark->mask;
>  	spin_unlock(&fsn_mark->lock);
>  
> -	if (old_mask != new_mask) {
> -		/* more bits in old than in new? */
> -		int dropped = (old_mask & ~new_mask);
> -		/* more bits in this fsn_mark than the inode's mask? */
> -		int do_inode = (new_mask & ~READ_ONCE(inode->i_fsnotify_mask));
> -
> -		/* update the inode with this new fsn_mark */
> -		if (dropped || do_inode)
> -			fsnotify_recalc_mask(fsn_mark->connector);
> -
> -	}
> +	fsnotify_recalc_mask(fsn_mark->connector);
>  
>  	/* return the wd */
>  	ret = i_mark->wd;
> -- 
> 2.50.1
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
