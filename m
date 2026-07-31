Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0333F1AC4
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785500860; cv=none; b=u0Un70XbdT5Ggjd6PcDMOdujeyte4zRac2w/0czjgde/p3iPD1n7/26X3VfVdaRaFKeoS3QWRr3QAgavncPPmnZbCmo1a4TInXtDJaZKrf3NvEQSMQ/f2bkvfnzeIFmRcW7rdjp+ZV2b4D0fM7UY2yijBbxKGcAVvjSpG3CSNso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785500860; c=relaxed/simple;
	bh=pOXK61Xg0LJX4PGsNaRRZoqjM+ptyrjJuzlThvXZoTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8Yr9ywZfPjXwv4Rm3AdMLOiW5zjK1fEz96eGwnkibiokMbozAbrB/cUfy9tNcWp0Z1tEbf1+smM7USoy1l57xXYjkdjvibeiMDycJmKZE519ydFhMdY/Fovjz/yXf2mfcsrjpJTlCzicACVFHsYLJ//IjRLup1EVxiwcxsx22k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2vyzOOTB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PlXJ69cV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FS22OlYI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vKGikB6t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2vyzOOTB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PlXJ69cV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FS22OlYI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vKGikB6t"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3DAEB4096;
	Fri, 31 Jul 2026 12:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785500852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TeSSD6iVeW9hQPqJ+MYjmsMx/vPG1MgRBQKXQQVnpdk=;
	b=2vyzOOTBpXf8cKZhLNvqbcFmlqdL2ZNESxu1t1eC6Qx6mdbM7TJW4VOSV9seV5lNQrvezz
	OllHZM47irBK+4ImNB9Ab63uiKDUYS0zsMksYviSrjhaJZOQmYea4+cEsbdvc/+xOYxvHQ
	Yfmv1vnI61bEhh//yX/Caq1QbsJeD84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785500852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TeSSD6iVeW9hQPqJ+MYjmsMx/vPG1MgRBQKXQQVnpdk=;
	b=PlXJ69cVQ/wX8TJ/Q2uiEUmiQ4C3oZCeU19vrmRX3T2kvfxUt5q93P3/ZLowJaFWc+dEcr
	/B73g8pjiE6WyCCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785500848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TeSSD6iVeW9hQPqJ+MYjmsMx/vPG1MgRBQKXQQVnpdk=;
	b=FS22OlYIIxIL3yKvGGUPdgd8Q4VJcyWLxOO7fW/+CywX9BPEKqPoyv+d9pxU0QZ7726cF2
	cfAuR+HYl+P5MR0A0RsXLabx8S7BMbKcvsa6j59TOxevMGFtBJG+8F5ZespdXe27f3j42F
	pMQAaClv2yQCJmD7eC2XrPtxeeCkHXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785500848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TeSSD6iVeW9hQPqJ+MYjmsMx/vPG1MgRBQKXQQVnpdk=;
	b=vKGikB6tCGx+NqcdOIaeMC17WRduzXx+pnl+kiC/JtktGqXiBIIA34gYB22vHcZECu3ErV
	ylZrJ84XF68SlyCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 352B3779B0;
	Fri, 31 Jul 2026 12:27:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XZ/6DLCUbGqfBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 31 Jul 2026 12:27:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D6498A13A4; Fri, 31 Jul 2026 14:27:27 +0200 (CEST)
Date: Fri, 31 Jul 2026 14:27:27 +0200
From: Jan Kara <jack@suse.cz>
To: Youngjae Kwon <yjkwon0026@snu.ac.kr>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fsnotify: Fix stale object mask after concurrent mark
 updates
Message-ID: <yxm3q5glchsjgr3pudmcy2vtn3umneardtcnvbuxyfn4oaiuqq@77aualjjutwn>
References: <CACwKKmCZdiZDoFuYm6LZhQ=XvHPk0fNKH=X3LmoXMqakYqJaNw@mail.gmail.com>
 <20260730152241.444632-1-yjkwon0026@snu.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730152241.444632-1-yjkwon0026@snu.ac.kr>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Fri 31-07-26 00:22:41, Youngjae Kwon wrote:
> When a mark gets a new event bit, fanotify and inotify avoid recalculating
> the object mask if the cached aggregate already contains that bit. This is
> racy with a recalculation triggered by a concurrent update to another mark
> on the same connector.
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
> Always request recalculation when an existing mark's calculated mask
> actually changes. For fanotify, compare fsnotify_calc_mask() before and
> after normal-mask, ignore-mask, and flag updates. Keep the cached aggregate
> check for unchanged updates, and keep the flag helper's inode-reference
> handling.
> 
> Link: https://lore.kernel.org/all/CACwKKmCZdiZDoFuYm6LZhQ=XvHPk0fNKH=X3LmoXMqakYqJaNw@mail.gmail.com/
> Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
> Fixes: 912ee3946c5e ("fanotify: do not call fanotify_update_object_mask in fanotify_add_mark")
> Cc: stable@vger.kernel.org # needs adjustments for <= 7.0
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>

Looks mostly good, just one question below:

>  	spin_lock(&fsn_mark->lock);
> +	old_mask = fsnotify_calc_mask(fsn_mark);
>  	if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS))
>  		fsn_mark->mask |= mask;
>  	else
>  		fsn_mark->ignore_mask |= mask;
>  
> -	recalc = fsnotify_calc_mask(fsn_mark) &
> -		~fsnotify_conn_mask(fsn_mark->connector);
> -
> -	recalc |= fanotify_mark_update_flags(fsn_mark, fan_flags);
> +	recalc = fanotify_mark_update_flags(fsn_mark, fan_flags);
> +	new_mask = fsnotify_calc_mask(fsn_mark);
> +	recalc |= old_mask != new_mask;
> +	recalc |= new_mask & ~fsnotify_conn_mask(fsn_mark->connector);

How could this last line ever change anything? If old_mask == new_mask,
then it would look like a bug that some bit from the new_mask (and thus
old_mask) isn't already included in the aggregate connector mask?

I can fix this up on commit but I want to understand why you've kept the
line here just in case I'm missing something...

								Honza

>  	spin_unlock(&fsn_mark->lock);
>  
>  	return recalc;
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index ed37491c1..c44f2daa1 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -565,17 +565,8 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
>  	new_mask = fsn_mark->mask;
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
> +	if (old_mask != new_mask)
> +		fsnotify_recalc_mask(fsn_mark->connector);
>  
>  	/* return the wd */
>  	ret = i_mark->wd;
> -- 
> 2.50.1
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
