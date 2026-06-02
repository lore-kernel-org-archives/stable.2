Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C214C3C9EE6
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391484; cv=none; b=bcU1aQZm1qBEsjhYMcYOb1EC5ziIoX8hdT+av8+m/nEsAOeSquRxo25kSOdDVPdGW0+vSC7lBjWVaPGH6eVu0LZ5hjTc8zL0fV0G4nZHXscMY4mgrFVKzeLy0/lAJQNS9AlMAR1KZGwljHLN/YL4QjEYG2OR/jhcsLp2aj2ji7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391484; c=relaxed/simple;
	bh=kmYFTKG2SUmlBpuou8py97T6+0Zpvl4KZ/RWdzmEoQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnRRpDuO8kpDcJbYKMSIrdjDveNXxlWk+/uxMzCEnWzxgVpMrl5LGQpAs0S5kXdpXZhsOb/QprqRe5JXAST95Sb8NeniITwqiMJiWCgU+HSWxvKVQjVUlUEw3Ua1CAyYdH1BcHUkZOBKpCIYHqyn0++MPLISsEth0g1l1yOqpGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v2tljnKH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V9fvRhjx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v2tljnKH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V9fvRhjx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v2tljnKH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V9fvRhjx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v2tljnKH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V9fvRhjx"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDCE767142;
	Tue,  2 Jun 2026 09:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780391479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=56S6nHTn6QLJXTKoYw39upu1bRnKRafvZtBNAP4v898=;
	b=v2tljnKHaq6gUr0smMyvmzxgdYG5qci7SJKfPGApxkxVyc4K/hb5h2Jh6pnRTuKumrtNNn
	tXnk/mEDCntbmNUhyq3tZUXQo6CGiUoNGGTpgqlG6GTSbax2Ipl3Q+zF/PveM5LonjdQHO
	kU2leV/aFaPx0sSKexCnGsCz/+AGJxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780391479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=56S6nHTn6QLJXTKoYw39upu1bRnKRafvZtBNAP4v898=;
	b=V9fvRhjx34y6RXwCpaQ3DZxIA7UlXXXh7wOHYDPFPh6U5SdShBRKyXhjXvrwjuLcbcj5ct
	Zthva0hqIDNO8eBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=v2tljnKH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=V9fvRhjx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780391479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=56S6nHTn6QLJXTKoYw39upu1bRnKRafvZtBNAP4v898=;
	b=v2tljnKHaq6gUr0smMyvmzxgdYG5qci7SJKfPGApxkxVyc4K/hb5h2Jh6pnRTuKumrtNNn
	tXnk/mEDCntbmNUhyq3tZUXQo6CGiUoNGGTpgqlG6GTSbax2Ipl3Q+zF/PveM5LonjdQHO
	kU2leV/aFaPx0sSKexCnGsCz/+AGJxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780391479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=56S6nHTn6QLJXTKoYw39upu1bRnKRafvZtBNAP4v898=;
	b=V9fvRhjx34y6RXwCpaQ3DZxIA7UlXXXh7wOHYDPFPh6U5SdShBRKyXhjXvrwjuLcbcj5ct
	Zthva0hqIDNO8eBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3EBD779A7;
	Tue,  2 Jun 2026 09:11:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gdvnKzeeHmqGOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Jun 2026 09:11:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4B26CA0EC1; Tue, 02 Jun 2026 11:11:11 +0200 (CEST)
Date: Tue, 2 Jun 2026 11:11:11 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org, Denis Arefev <arefev@swemel.ru>
Subject: Re: [PATCH] make new mount API honour SB_NOUSER (was Re: [PATCH]
 block: Avoid mounting the bdev pseudo-filesystem in userspace)
Message-ID: <eevyuiiqt5b4n7kws2lc24jk2njdllanojl76t5cftx6he6hba@y46tiknbebj4>
References: <20260521072857.5078-1-arefev@swemel.ru>
 <20260602011907.GM2636677@ZenIV>
 <20260602013526.GO2636677@ZenIV>
 <20260602020444.GP2636677@ZenIV>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602020444.GP2636677@ZenIV>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BDCE767142
X-Spam-Score: -4.01

On Tue 02-06-26 03:04:44, Al Viro wrote:
> one should *not* be allowed to mount one of those, new API or not.
> 
> Reported-by: Denis Arefev <arefev@swemel.ru>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Won't it make sense to actually check fc->sb_flags before we call
vfs_create_mount()? Otherwise it looks good to me.

								Honza

> ---
> [[ I still want to see the rest of the reproducer - report smells like a missing
> d_can_lookup() somewhere, on top of fsmount(2) bug]]
> diff --git a/fs/namespace.c b/fs/namespace.c
> index fe919abd2f01..17777c837683 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4499,6 +4499,10 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
>  	new_mnt = vfs_create_mount(fc);
>  	if (IS_ERR(new_mnt))
>  		return PTR_ERR(new_mnt);
> +	if (new_mnt->mnt_sb->s_flags & SB_NOUSER) {
> +		mntput(new_mnt);
> +		return -EINVAL;
> +	}
>  	new_mnt->mnt_flags = mnt_flags;
>  
>  	new_path.dentry = dget(fc->root);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
