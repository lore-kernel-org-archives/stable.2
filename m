Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792665212;
	b=ZzyIaMhgxpggj9SKnhxNqw4kxjk780w//tkxOghDtbApPUJXPTzmd+wScu4mSRGT3IX2
	 Y9REjRHcNvzwqrnePg2pC1KRfIUnoIcdS5V1RXu0cIUfIdDhVpIvWET03o32U4S/WkUhv
	 eIzy/ewDeeBztGJLHT6HtMjKuISA8UwAKxbNTBqdrmHPrFvw7DxxFaPkgVuQyyGOOcsq4
	 Ba40Y0Ns5jkevvZSza3WN9F7+6mv2E3u+8wajcLMFoZsOL/Pw95m5fnvAdfncCLcJZ5yu
	 p5gOUIf7Zyd8AazNSqNLbqrhzrHdIOjYs8XOgKi4/F3ZnM8+phB4ekxHb2eJxR8bGiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792665212;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=Eii+E+ApoLK8hjZenVft4/iQ0kGf8G5pvZ2XzvoP4Pw=;
	b=gLK+B6ovLHcsQB7OjibIuzeJcEj61E8DMpKTiKa+8aL0nFhxcqHsjqPx56BLMAf0cqzy
	 DNi2ElObJEGHwLEVmeNP3h+JeLvekIGJcnIXjBkzIu13Rwi/uozfdFXw+YUpIL9mFs4ct
	 E7Pv9PiFMczPjHJHAE7otcRnATHROwHKvnqb34TAx0KJLghGMHHlzUzbuZVYVB+3izuPR
	 Zf2ylHev83EZLMrZLUk6ALuVTwUEjyhcLgXcXt7C7yy0EQOMnO8botowCtpaBOqNZ6p3S
	 +r7bm3gk31jz/61WUQxzZdrsTo9yYLQAkLsNel3Ji2qeSWiuoRF3IMkOhMtmfwEJBYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=BkauXHR3;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Rc9anYoH;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=BkauXHR3;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Rc9anYoH;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82AF606A31A;
	Thu, 22 Oct 2026 10:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C82AF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=BkauXHR3;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Rc9anYoH;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=BkauXHR3;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Rc9anYoH
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0CD21FB8B;
	Thu, 22 Oct 2026 10:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792665209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eii+E+ApoLK8hjZenVft4/iQ0kGf8G5pvZ2XzvoP4Pw=;
	b=BkauXHR3lOo/DRvdqxxFEPVxQuaV3n7dEZo6poQdCSo9Uk13+murFXrQqY+bAKkCZRxTNm
	2Kl20H7jF9ADl4trqhxuY8rVay1k0rO1HZZXhgJLNFgBDlLci7LM0k4lq5KuEiA043sqm9
	TYvblv19wmS7kJplD4t/yWOnbyZyyEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792665209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eii+E+ApoLK8hjZenVft4/iQ0kGf8G5pvZ2XzvoP4Pw=;
	b=Rc9anYoHbYNkihkabz06nMxuavPuvEPh7Csi7wKE0nOwkoDVaS8G7pmgNQ527RaQLcLCvH
	wqK1QAQ1kqNdkCCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BkauXHR3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Rc9anYoH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792665209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eii+E+ApoLK8hjZenVft4/iQ0kGf8G5pvZ2XzvoP4Pw=;
	b=BkauXHR3lOo/DRvdqxxFEPVxQuaV3n7dEZo6poQdCSo9Uk13+murFXrQqY+bAKkCZRxTNm
	2Kl20H7jF9ADl4trqhxuY8rVay1k0rO1HZZXhgJLNFgBDlLci7LM0k4lq5KuEiA043sqm9
	TYvblv19wmS7kJplD4t/yWOnbyZyyEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792665209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eii+E+ApoLK8hjZenVft4/iQ0kGf8G5pvZ2XzvoP4Pw=;
	b=Rc9anYoHbYNkihkabz06nMxuavPuvEPh7Csi7wKE0nOwkoDVaS8G7pmgNQ527RaQLcLCvH
	wqK1QAQ1kqNdkCCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99A76134E6;
	Thu, 22 Oct 2026 10:33:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0yBgHXnm2Wo3LwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Oct 2026 10:33:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2D027A1417; Thu, 22 Oct 2026 12:33:29 +0200 (CEST)
Date: Thu, 22 Oct 2026 12:33:29 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 09/15] fs: don't keep a device frozen when its freeze is
 already gone
Message-ID: <yl2umpbk6fnz2soh7fi5xellmovarx6ouxrvf4ki5xxledmihx@gjldiqbxpufn>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
 <20261011-work-super-fixes-core-v1-9-c727176c5b53@kernel.org>
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
In-Reply-To: <20261011-work-super-fixes-core-v1-9-c727176c5b53@kernel.org>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: C0CD21FB8B

On Sun 11-10-26 17:56:09, Christian Brauner wrote:
> Device-mapper and the filesystem shutdown ioctls freeze the filesystems
> on a device through bdev_freeze() and fs_bdev_freeze() freezes each
> superblock with FREEZE_HOLDER_USERSPACE | FREEZE_MAY_NEST. That's the
> same holder FIFREEZE uses. So FITHAW can drop that freeze while the
> device is still suspended. qemu-guest-agent's guest-fsfreeze-thaw does
> just that as it issues FITHAW on every mount until it fails. An
> emergency thaw does the same. do_thaw_all_callback() only thaws the
> device freezes of sb->s_bdev and then drops the remaining userspace
> freeze of the superblock which may belong to any other device of the
> filesystem, an external log or journal device or another btrfs member.
> 
> The device's bdev_thaw() then calls fs_bdev_thaw() which gets -EINVAL
> from thaw_super() since there's nothing left to thaw. bdev_thaw() takes
> that to mean that the device is still frozen and keeps
> bd_fsfreeze_count elevated and device-mapper ignores the error. So the
> device stays frozen for good and every later mount of it fails:
> 
>   dm-0: Can't mount, blockdev is frozen
> 
> fe967191e585 ("fs: don't return -EINVAL for successful nested thaw")
> fixed the same outcome for a freeze that nested with FIFREEZE. A freeze
> that lost its hold behind the device's back still ends up there.
> 
> Treat -EINVAL from thaw_super() in fs_bdev_thaw() as the freeze being
> gone already. There's nothing left to thaw for the device then. Before
> fs_bdev_thaw() existed thaw_bdev() kept the count on the same error.
> 
> Fixes: 49ef8832fb1a ("bdev: implement freeze and thaw holder operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

I'd just note that interpretting EINVAL from ->thaw_super is a bit of
an adventure but so far only gfs2 implements that and that looks safe.
Using some less abused error code to mean "already thawed" would be
probably more robust in the long run...

								Honza

> ---
>  fs/super.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 82290d094c03..ac4c4d067509 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1494,10 +1494,29 @@ static int fs_super_freeze(struct super_block *sb)
>  
>  static int fs_super_thaw(struct super_block *sb)
>  {
> -	if (sb->s_op->thaw_super)
> -		return sb->s_op->thaw_super(sb,
> +	int error;
> +
> +	if (sb->s_op->thaw_super) {
> +		error = sb->s_op->thaw_super(sb,
>  				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
> -	return thaw_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
> +		/* -EINVAL means the freeze is gone already. */
> +		if (error == -EINVAL)
> +			return 0;
> +		return error;
> +	}
> +
> +	/* The caller holds an active reference. */
> +	if (WARN_ON_ONCE(!super_lock_excl(sb)))
> +		return 0;
> +
> +	/* FITHAW or an emergency thaw may have dropped the freeze already. */
> +	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE ||
> +	    !sb->s_writers.freeze_ucount) {
> +		super_unlock_excl(sb);
> +		return 0;
> +	}
> +	return thaw_super_locked(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE,
> +				 NULL);
>  }
>  
>  static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
> @@ -1610,7 +1629,8 @@ static int fs_bdev_freeze(struct block_device *bdev)
>   * frozen more than once (by the kernel or via another device).
>   *
>   * Return: 0, or the first error on a single-fs device; a shared device swallows
> - *         per-superblock errors, as fs_bdev_freeze() does.
> + *         per-superblock errors, as fs_bdev_freeze() does. A superblock that
> + *         lost the freeze already, e.g., to FITHAW, counts as thawed.
>   */
>  static int fs_bdev_thaw(struct block_device *bdev)
>  {
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
