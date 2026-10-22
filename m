Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664629;
	b=1yphxZhrvUbdOgVili/ronsaLKdj7nkQmuSJCsxTL9dGBtuR3AW/UyF0qunrk1Xeuye9
	 DdSMVXd0CBUAfi4zLmMRbcovVj3AeYiM5jFUL2lxCz+XzLJ8Yj8rpA22Xrdfic7JKLmlE
	 uAAxGWIWHgzLhr0n8ooH5MFoyLx+NDqd0w2OdI4cnQu35O+XtEbUSaTHaKuYm1TFL8Afh
	 E59LV+HHo5GEpmhc4MRbqcnU+9+ng5GZk+MnTP7gRjFyJt0vgWfX870AynQglxROZEvbw
	 Zvr99JjKclA2Pn2hKbtdap2Cb8rUmOPjsxKy39AzTzi3OrG11OwgBBG5HAw0wRi8PhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664629;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=sZa9rUJ7koaFPHl3nudoqH3SGn6sft39s0BZomRZuiM=;
	b=M9zBICk/5SGnbe/CgPhlQ3GPdzR+Lq+6GKvEpq0FXgjlS3BNXVfNFg+sPyAGRCxuXBie
	 ezEENzPMlNA45EHqQDyFBerC5yvDDduUPwrriIbHron70yru7bRB1CSorR3pqKGBDLSdC
	 /DeodUphL9qXl3tupepcuFl5sVKhAsFDMKfVs5ukRkbhAbZKA3ABxgGj6SaE/xgjc5b3h
	 mNGfaKpuMFSg/iqihX0fRlkkBwU9/HaWoMB0hiDC2ELukF/yr1835TjV9c8RzO0lG7B+O
	 wYnAtmsEqzbtmnybJ6sP9X5p3XDUEk+1RCNPYVqghRIUAO8MyqTNwCq4D99yLCGao0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cidyetCy;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MUruPdiB;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cidyetCy;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MUruPdiB;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6D4606A31A;
	Thu, 22 Oct 2026 10:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A6D4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cidyetCy;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MUruPdiB;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cidyetCy;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MUruPdiB
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 328BE2214C;
	Thu, 22 Oct 2026 10:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792664627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZa9rUJ7koaFPHl3nudoqH3SGn6sft39s0BZomRZuiM=;
	b=cidyetCy3nVsfNsiTjcPHSZeOADygORArbcZZQYtLXx7GsTHG7/Cmyw/yJApkoqRz+Jqvp
	1Tg8lEGL1YhP/Dr876ldH9SSbj7BC+8PeeM20BoVog2w+UhclIo3ec0bDJkYNEIs4HEXgf
	o91YmEZuArWRvlmfIa8p8QKl3etrBzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792664627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZa9rUJ7koaFPHl3nudoqH3SGn6sft39s0BZomRZuiM=;
	b=MUruPdiBO5BltqF/uIjq/rIKuLNyDdDcZKlPGfkqjvnxDMl1guBdp6alTR9QgNrQIlQtux
	O+hSvpbUQxxo40Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792664627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZa9rUJ7koaFPHl3nudoqH3SGn6sft39s0BZomRZuiM=;
	b=cidyetCy3nVsfNsiTjcPHSZeOADygORArbcZZQYtLXx7GsTHG7/Cmyw/yJApkoqRz+Jqvp
	1Tg8lEGL1YhP/Dr876ldH9SSbj7BC+8PeeM20BoVog2w+UhclIo3ec0bDJkYNEIs4HEXgf
	o91YmEZuArWRvlmfIa8p8QKl3etrBzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792664627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZa9rUJ7koaFPHl3nudoqH3SGn6sft39s0BZomRZuiM=;
	b=MUruPdiBO5BltqF/uIjq/rIKuLNyDdDcZKlPGfkqjvnxDMl1guBdp6alTR9QgNrQIlQtux
	O+hSvpbUQxxo40Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AD5C134E6;
	Thu, 22 Oct 2026 10:23:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eWfsNTLk2Wo6JQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Oct 2026 10:23:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8AC15A1417; Thu, 22 Oct 2026 12:23:42 +0200 (CEST)
Date: Thu, 22 Oct 2026 12:23:42 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 07/15] fs: don't fail fs_bdev_freeze() once a superblock
 is frozen
Message-ID: <u3vsnr72tedlsbhcit4iyowesj5pkbifgh7xp6rzheg5tjj5g7@ce2eueg6nlg6>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
 <20261011-work-super-fixes-core-v1-7-c727176c5b53@kernel.org>
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
In-Reply-To: <20261011-work-super-fixes-core-v1-7-c727176c5b53@kernel.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Score: -12.80

On Sun 11-10-26 17:56:07, Christian Brauner wrote:
> fs_bdev_freeze() freezes the superblocks on the device and then returns
> the error of sync_blockdev(). But bdev_freeze() takes an error from
> ->freeze() to mean that nothing is frozen and drops bd_fsfreeze_count
> again. Its callers act accordingly. dm's lock_fs() doesn't set
> DMF_FROZEN and the shutdown ioctls just return. So nobody ever calls
> bdev_thaw() and the superblock stays frozen until someone thaws it by
> hand. Until then every writer blocks in sb_start_write().
> 
> freeze_super() only syncs sb->s_bdev and fails cleanly if that reports
> an error. So the sync in fs_bdev_freeze() is the first to see a
> writeback error on any other device of the filesystem, an external log
> or journal device or a realtime device. It also is the first sync for a
> read-only superblock since freeze_super() doesn't sync those at all.
> 
> I made fs_bdev_freeze() return that error in fbcb8f39e96d ("bdev:
> surface the error from sync_blockdev()") without thinking about what it
> means for the superblocks that are already frozen at that point. Don't
> report a failed sync once a superblock was frozen. The device is frozen
> and the regular bdev_thaw() undoes it. The error isn't lost either. It
> stays recorded in the errseq of the mapping so fsync() on the device
> still reports it. A device without any live superblock still reports
> the error of the sync, just like bdev_freeze() does for a device without
> holder ops.
> 
> Reproducer, xfs with an external log on dm-linear, a stale writeback
> error on the log device, then a dm suspend:
> 
>   mkfs.xfs -f -l logdev=/dev/vdb,size=64m /dev/vda     # vdb is 128M
>   dmsetup create log --table "0 $(blockdev --getsz /dev/vdb) linear /dev/vdb 0"
>   mount -o logdev=/dev/mapper/log /dev/vda /mnt
>   echo 1 > /sys/kernel/debug/fail_make_request/times
>   echo 100 > /sys/kernel/debug/fail_make_request/probability
>   echo 1 > /sys/block/dm-0/make-it-fail
>   xfs_io -c "pwrite 100m 4k" -c "sync_range -w 100m 4k" /dev/mapper/log
>   echo 0 > /sys/block/dm-0/make-it-fail
>   dmsetup suspend log          # fails with -EIO, the device stays active
>   touch /mnt/foo               # hangs until fsfreeze --unfreeze /mnt
> 
>   Buffer I/O error on dev dm-0, logical block 25600, lost async page write
>   device-mapper: suspend ioctl on log  failed: Input/output error
>   INFO: task touch:117 blocked for more than 30 seconds.
>    percpu_rwsem_wait+0x203/0x500
>    mnt_want_write+0x28f/0x2f0
>    lookup_open+0x135/0x1b20
> 
> The selftest in the next patch covers the read-only case.
> 
> Fixes: fbcb8f39e96d ("bdev: surface the error from sync_blockdev()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 2dc4ec2e8014..82290d094c03 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1555,7 +1555,8 @@ static void fs_bdev_sync(struct block_device *bdev)
>   *
>   * Return: 0, or the error from the one superblock on a single-fs device.  When
>   *         several superblocks share @bdev a per-superblock failure is swallowed
> - *         (see below), but a sync_blockdev() failure is always reported.
> + *         (see below).  A sync_blockdev() failure is only reported if no
> + *         live superblock uses @bdev.
>   */
>  static int fs_bdev_freeze(struct block_device *bdev)
>  {
> @@ -1586,8 +1587,17 @@ static int fs_bdev_freeze(struct block_device *bdev)
>  	 */
>  	if (error && count > 1)
>  		error = 0;
> -	if (!error)
> -		error = sync_blockdev(bdev);
> +	if (error)
> +		return error;
> +
> +	/*
> +	 * An error tells bdev_freeze() that nothing is frozen and nobody would
> +	 * ever thaw a superblock frozen above. So only report a failed sync if
> +	 * no superblock uses the device.
> +	 */
> +	error = sync_blockdev(bdev);
> +	if (count)
> +		error = 0;
>  	return error;
>  }
>  
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
