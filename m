Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662947;
	b=iuBUHotYezSvsOywoz5gsDQjxlfwynOZPOfori5KUM4biMOQ0VlhuEfu++odGDb2g+47
	 4jy1zE8tNmfQDfCnnrnQmtsAI/G18QcdZtw/nZSng+LOn4ITsElabeXOjoMPo094yo23Z
	 PejT0V6Tq8TOCwDXRxvF3l3nw4xD/9kO1RzxSMKSN7RV6FVSyrU5vgbTyD3ouYMpbV61R
	 fOb9hTBYQR4xbmcTcbVZwjS1GdGq/w3b3ysOsnqunOfDb86SA2GvjafsAQX8nd1VCT4mT
	 j1F3v2HagYIr4J/YD6qEqjbCq5K7DSs35xBoKln8Kvmh/fBv5+JCtnKPE6yvRLiVLhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662947;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=8VmMT6SL3lJ/c87KR2eDUfeOG9XwswkHzu1/RmZsfbw=;
	b=bgQH1kzT3LbW3HBj63xATJA1UnnMKzUVcUeh2kDEmQzRxVVm4wYRk8haI0zPX9bnis0x
	 VQ481nGzjFEYvupgfPBAGBP8JnsiHDaZCXCCqIUzumQ8ohCDsCQWSdeL50Fd2qOUxf/S/
	 42kd+P6Nej22uUJBh4dr4wOuFOIfBiuz2ARUHQaNrkx6weyoZeipLRcKqm4QGTFFiS/cl
	 ZNUaaAklM0NZA12wDRLshEL8gH+F7QPVWZ23rXgEF4yIujd3auqhBxDc7GB/KdW/AtIjm
	 VF7CUJ4YVvRXxIn09Pl0MhoLxNxsb2DXHnd/TccOJE9GFtozdroDWhDhPyyFkr1KQmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=kdn4NQ9K;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="CB/cdJ/3";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=0MKzMBl1;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bTQCFzj4;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AF9606A319;
	Thu, 22 Oct 2026 09:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2AF9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=kdn4NQ9K;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CB/cdJ/3;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=0MKzMBl1;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bTQCFzj4
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF3472212F;
	Thu, 22 Oct 2026 09:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792662945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8VmMT6SL3lJ/c87KR2eDUfeOG9XwswkHzu1/RmZsfbw=;
	b=kdn4NQ9KpaN2zIvp5IbzFXPnTdAst5oxWQFJQvaiZvlwPoc5BP7yOEPKSEqBhCZ5HbkO3Q
	4cc+KCdYAiyTTLUZcev9n9oIAvRqlxsS7FMrL2qhl2jQYX32YU6oL7EZyZW1wy9RjmrJMm
	UdQzIe7pPGvbBHgZh0gV7tg1XvU+rsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792662945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8VmMT6SL3lJ/c87KR2eDUfeOG9XwswkHzu1/RmZsfbw=;
	b=CB/cdJ/3F90e9V1KBM/iB3jXpWdeZLBPotnWDu7U88AD3yxrhFrb6wwW89jy7K5VdFkw0G
	0z0ARWtFNTXyR9Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0MKzMBl1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bTQCFzj4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792662944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8VmMT6SL3lJ/c87KR2eDUfeOG9XwswkHzu1/RmZsfbw=;
	b=0MKzMBl1VINOziycO0wd4arrDofm8Fp6OEvtmrIr9dOHypVu3p71TOMehGSMkSJ0cXnCTV
	KfZoTmHEOWa1mh+kMkUtj9JpbYi86N75lew37UsprdGfRZ7V1LkCYxYJ0P39wdLRIlZRYa
	pRRCFo/SakFa6XQduKYdCzZ9y+C2K5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792662944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8VmMT6SL3lJ/c87KR2eDUfeOG9XwswkHzu1/RmZsfbw=;
	b=bTQCFzj4e7EnvITVqIllGzkZxJ8tmLEcYVC4wEcOvks9wsfmKpIh3CZQ3NTpBlFscPeuPM
	ZT5ZP+Ofn3lCzHCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B651E133F3;
	Thu, 22 Oct 2026 09:55:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iFi6I6Dd2Wp3BwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Oct 2026 09:55:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3F280A1417; Thu, 22 Oct 2026 11:55:36 +0200 (CEST)
Date: Thu, 22 Oct 2026 11:55:36 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 02/15] super: don't warn when resume thaws a userspace
 freeze
Message-ID: <zx5xykzg6s5tdzcegobouzicxdddgxakdw5lhmubgzqkqa5d2m@s56uiwg47smi>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
 <20261011-work-super-fixes-core-v1-2-c727176c5b53@kernel.org>
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
In-Reply-To: <20261011-work-super-fixes-core-v1-2-c727176c5b53@kernel.org>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: DF3472212F

On Sun 11-10-26 17:56:02, Christian Brauner wrote:
> filesystems_thaw() is called on every resume from suspend or hibernation
> no matter whether filesystem freezing was enabled. It walks all
> superblocks that have freeze methods and calls thaw_super() with
> FREEZE_EXCL | FREEZE_HOLDER_KERNEL and its owner token. It relies on
> may_unfreeze() to refuse every superblock it didn't freeze itself.
> 
> But may_unfreeze() checks the kernel freeze count before it checks
> whether the superblock is exclusively frozen at all. A superblock that
> userspace froze via FIFREEZE or that got frozen through its block device
> has freeze_kcount == 0. So every resume while such a filesystem is
> frozen triggers:
> 
>   WARNING: fs/super.c:2165 at thaw_super_locked+0x85f/0xbf0
>   ...
>    filesystems_thaw_callback+0x196/0x220
> 
> and with panic_on_warn the resume panics.
> 
> Check the owner first. If the superblock isn't exclusively frozen, or
> not by the caller, there's nothing for the caller to undo and that isn't
> a bug. An exclusive freeze always holds a kernel reference so keep
> warning if that's not the case.
> 
> Reproducer, needs CONFIG_PM_DEBUG:
> 
>   mount /dev/sda /mnt
>   fsfreeze --freeze /mnt
>   echo freezer > /sys/power/pm_test
>   echo freeze > /sys/power/state
>   # WARNING in thaw_super_locked() from filesystems_thaw_callback()
> 
> It fires on every run. Not a selftest because it suspends the machine
> and the only symptom is the warning in the kernel log.
> 
> Fixes: 1af3331764b9 ("super: add filesystem freezing helpers for suspend and hibernate")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Right, looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 15ecfbeb92ab..4e8f7f48540c 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -2165,14 +2165,15 @@ static inline bool may_unfreeze(struct super_block *sb, enum freeze_holder who,
>  			return false;
>  		if (WARN_ON_ONCE(!freeze_owner))
>  			return false;
> -		if (WARN_ON_ONCE(sb->s_writers.freeze_kcount == 0))
> -			return false;
>  		/* This isn't exclusively frozen. */
>  		if (!sb->s_writers.freeze_owner)
>  			return false;
>  		/* This isn't exclusively frozen by us. */
>  		if (sb->s_writers.freeze_owner != freeze_owner)
>  			return false;
> +		/* An exclusive freeze always holds a kernel reference. */
> +		if (WARN_ON_ONCE(sb->s_writers.freeze_kcount == 0))
> +			return false;
>  		/*
>  		 * This is still frozen multiple times so we're just
>  		 * going to drop our reference count and undo our
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
