Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663268;
	b=o/PWVT8ydaaqK+Ta6+WFlwvS0/CfF1aAUwrU3cZK0V1O8wDqh2MUoQWuwZjupySjC+dd
	 52yBKB26SyCnQw635Vl0tnHN/DpF1izoFFYsMumPPpsonpSdLMD42EqWJcgS8pKM1mlNJ
	 TYgvhH4FP+yBr6eJBWC/aqR9sGwzySgrR+wcpge5tSCQ98ocJvlJS/a0dNaaKjfrmhB6z
	 1V4VqgD+uoHhiSKLMTvevR9JYx65P4YiPjuIwshC286Z0IDHNpAt5oHW3kE1OlCVsHwB9
	 uryzIav76zi5Nupk70D0Hp9vjdU5hUs3shBWkO2wEOo9vbhkRAASt4LkW+2sd+6yncQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663268;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=xx5PWRnpBcaTq5EzVgkIhwjrcm3XGwseKhP5fVjXrZs=;
	b=GwKG2J868wNI+mmX+9T92T5mEUNTzPNwQFGdXj37IQEpNCdwN4cK3Zoecj4Huat9MijH
	 EpXq19jooG2XuvZrBNmyzasVn0u3Ii6JWju8RKLI+QPPGil0rG1b3493QX7dI2AVr5EhT
	 hUxh3dZt8+ONLq+vvbYyO4aVi5kOey9WAcln7pgMTvhQNQ7EZBOeRLZHcZVAKK66yZ3UE
	 XsIZL3zPNa3FpX9C33Sih1Ejo4m2HpaC7N+WjGOy+zXzPskHy9WcpkQPVEImluxp9z3Sf
	 isSZxjUvO4HUZz+KoJ9k86LZOD/AOmFbw/3i+H1qvYOv7PbWsXYfLH5DjL08rFE5HAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=XsHZEXtt;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4qt+iPl0;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=fRbJsRKd;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=yXzcqOCW;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0EF606A319;
	Thu, 22 Oct 2026 10:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB0EF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=XsHZEXtt;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4qt+iPl0;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=fRbJsRKd;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=yXzcqOCW
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD4261FCE2;
	Thu, 22 Oct 2026 10:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792663266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xx5PWRnpBcaTq5EzVgkIhwjrcm3XGwseKhP5fVjXrZs=;
	b=XsHZEXtt16YszjQLzPJdOiTObZxqiue3i9dZruJj5NbRkxUIVU2VcHMlGFQ2hEXYDTjClW
	WY4KwRkiLLcCvcsLVcDCt+/1VPIcwaDA7EXmXcLlRYeSXCDvgubeswx1cWuxeL4M80t466
	Sxj1JTQe8m0d7rtXtwZBrAMTp2Eefi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792663266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xx5PWRnpBcaTq5EzVgkIhwjrcm3XGwseKhP5fVjXrZs=;
	b=4qt+iPl0QgDN6y01/MLvSWfV+YktFHa5v8xtRi8RyAwW5+jedesfJGTSPd9Sq2SR++a6yF
	4IJGROd4YxoBbqDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fRbJsRKd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yXzcqOCW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792663264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xx5PWRnpBcaTq5EzVgkIhwjrcm3XGwseKhP5fVjXrZs=;
	b=fRbJsRKdg3/W9Y0S219wKFCsmQc/z1LupriN4SRD19Nv+SjN+NPSd+Cr6Adq9+KqhSkrqH
	aHDIc8GPScaihJrhxGTDZMaelM4329az0rup+PSrFwcWQ2wAEIH0Q1HpowCFhDapAb5NiD
	oSeXE6+LXGbykMi88rWSpmoEv8gnO6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792663264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xx5PWRnpBcaTq5EzVgkIhwjrcm3XGwseKhP5fVjXrZs=;
	b=yXzcqOCWlMcStErxspXDl0EyhhiboKWsqC3Xh8if8itof1TTfIZz1Z3UdT4y+GAWPpp31k
	lB31A1yMX8rexLBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A26C6134E6;
	Thu, 22 Oct 2026 10:01:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3WS6HuDe2WovDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Oct 2026 10:01:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2A5F5A1417; Thu, 22 Oct 2026 12:00:56 +0200 (CEST)
Date: Thu, 22 Oct 2026 12:00:56 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 03/15] quota: really wait for the thaw in quotactl_block()
Message-ID: <qvzylugu5zrrkjfznfnunimu6yyv3unaxppf7uxiobgx6pumta@n5h6ofkevlwt>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
 <20261011-work-super-fixes-core-v1-3-c727176c5b53@kernel.org>
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
In-Reply-To: <20261011-work-super-fixes-core-v1-3-c727176c5b53@kernel.org>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
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
X-Rspamd-Queue-Id: CD4261FCE2

On Sun 11-10-26 17:56:03, Christian Brauner wrote:
> quotactl_block() makes commands that modify quota wait for a frozen
> superblock to be thawed. Since 576215cffdef ("fs: Drop wait_unfrozen
> wait queue") it does that by taking and dropping s_writers via
> sb_start_write() and sb_end_write() and retrying until the superblock
> isn't frozen anymore.
> 
> But freeze_super() doesn't take s_writers for a read-only superblock. So
> sb_start_write() never waits and quotactl_block() spins until the
> superblock is thawed. The loop doesn't check for fatal signals and the
> permission checks only happen after quotactl_block() returned. So any
> user that can resolve the device node of a frozen read-only filesystem
> can make a task burn a cpu without being killable until someone thaws
> the filesystem.
> 
> Wait for the thaw with wait_var_event_killable() on s_writers.frozen
> instead. freeze_super() and thaw_super() already wake waiters on it for
> wait_for_partially_frozen(). That waiter only ever waits for the
> superblock to leave SB_FREEZE_WRITE and gets away without a barrier
> between the store to s_writers.frozen and wake_up_var() because
> percpu_down_write() executes a full barrier after the store that moves
> it out of SB_FREEZE_WRITE. That doesn't cover a waiter for SB_UNFROZEN.
> So add the barrier wake_up_var() requires to all of these wakeups.
> 
> The cond_resched() that 77449e453dfc ("quota: fix livelock between
> quotactl and freeze_super") added to the loop goes away with the
> spinning. As a side-effect waiting for a read-write superblock is
> killable now as well.
> 
> Fixes: 576215cffdef ("fs: Drop wait_unfrozen wait queue")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Good catch! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

							Honza

> ---
>  fs/quota/quota.c | 12 ++++++++----
>  fs/super.c       | 19 +++++++++++++------
>  2 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index 33bacd707580..d55ef08de833 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -894,11 +894,15 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
>  			up_write(&sb->s_umount);
>  		else
>  			up_read(&sb->s_umount);
> -		/* Wait for sb to unfreeze */
> -		sb_start_write(sb);
> -		sb_end_write(sb);
> +		/*
> +		 * Wait for sb to unfreeze. A read-only superblock is frozen
> +		 * without taking s_writers so sb_start_write() won't wait.
> +		 */
> +		error = wait_var_event_killable(&sb->s_writers.frozen,
> +				READ_ONCE(sb->s_writers.frozen) == SB_UNFROZEN);
>  		put_super(sb);
> -		cond_resched();
> +		if (error)
> +			return ERR_PTR(error);
>  		goto retry;
>  	}
>  	return sb;
> diff --git a/fs/super.c b/fs/super.c
> index 4e8f7f48540c..2dc4ec2e8014 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -2068,6 +2068,13 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
>  		percpu_up_write(sb->s_writers.rw_sem + level);
>  }
>  
> +static inline void sb_freeze_wake(struct super_block *sb)
> +{
> +	/* wake_up_var() needs a full barrier after storing s_writers.frozen. */
> +	smp_mb();
> +	wake_up_var(&sb->s_writers.frozen);
> +}
> +
>  static int wait_for_partially_frozen(struct super_block *sb)
>  {
>  	int ret = 0;
> @@ -2293,7 +2300,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who, const void *fre
>  		WARN_ON_ONCE(freeze_inc(sb, who) > 1);
>  		sb->s_writers.freeze_owner = freeze_owner;
>  		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
> -		wake_up_var(&sb->s_writers.frozen);
> +		sb_freeze_wake(sb);
>  		super_unlock_excl(sb);
>  		return 0;
>  	}
> @@ -2313,7 +2320,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who, const void *fre
>  	if (ret) {
>  		sb->s_writers.frozen = SB_UNFROZEN;
>  		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
> -		wake_up_var(&sb->s_writers.frozen);
> +		sb_freeze_wake(sb);
>  		deactivate_locked_super(sb);
>  		return ret;
>  	}
> @@ -2329,7 +2336,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who, const void *fre
>  				"VFS:Filesystem freeze failed\n");
>  			sb->s_writers.frozen = SB_UNFROZEN;
>  			sb_freeze_unlock(sb, SB_FREEZE_FS);
> -			wake_up_var(&sb->s_writers.frozen);
> +			sb_freeze_wake(sb);
>  			deactivate_locked_super(sb);
>  			return ret;
>  		}
> @@ -2341,7 +2348,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who, const void *fre
>  	WARN_ON_ONCE(freeze_inc(sb, who) > 1);
>  	sb->s_writers.freeze_owner = freeze_owner;
>  	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
> -	wake_up_var(&sb->s_writers.frozen);
> +	sb_freeze_wake(sb);
>  	lockdep_sb_freeze_release(sb);
>  	super_unlock_excl(sb);
>  	return 0;
> @@ -2378,7 +2385,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
>  	if (sb_rdonly(sb)) {
>  		sb->s_writers.frozen = SB_UNFROZEN;
>  		sb->s_writers.freeze_owner = NULL;
> -		wake_up_var(&sb->s_writers.frozen);
> +		sb_freeze_wake(sb);
>  		goto out_deactivate;
>  	}
>  
> @@ -2396,7 +2403,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
>  
>  	sb->s_writers.frozen = SB_UNFROZEN;
>  	sb->s_writers.freeze_owner = NULL;
> -	wake_up_var(&sb->s_writers.frozen);
> +	sb_freeze_wake(sb);
>  	sb_freeze_unlock(sb, SB_FREEZE_FS);
>  out_deactivate:
>  	deactivate_locked_super(sb);
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
