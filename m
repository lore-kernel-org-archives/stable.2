Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664193;
	b=zhiyJyEwb43fuA7ND+JXJXDlO8IP+DMjmnQN505YCFf1EtsJ7nWKyBs+PiOK76MYn01D
	 4NQ5M2IBLdskeTSm00dI3SRuV9XR+J9+JM4jdpivFF0s6DDd8foV3VX8VcCza/kkV6UKE
	 TkvR3x9o9ULF/Gh/Y/WmuWOQ93neKLJtZsld0UZv2mXtZGPOAT0Xm7Ub5rwONIpbpyQ9H
	 DU1akCfoPqlXh0MFuHWUjBLORZNyfC6/+5He9iXLxP+bOKoECrvNN4IQ2qHeFHmDt8RsC
	 HAD3EKGpsctgt/6UycQnf52lj3Rpv8jfzoINk0bb0z2w5Z7yW9N4wKSOhox5uRtrVjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664193;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=DSqtth9Qpbenh9XOfaBd+IxI7HLc0qZps+kjeRep0FM=;
	b=hTZu477+7Ool1eLmPzluovIhLQxYiogJ4753eNNfHpfY8uCYkHOkZBKcg9hbXco59Sbb
	 Uk4wRytmubIHIAvTi2MuopMC2ECnn85j0N+eJuYQGqLeQtG1HfNazyEQT0gCfvyBiKWR/
	 Ui52WoaOmtrx/Z+cCc+cSdArC0b19CIxpcGw/SZGtyOt86fZwq/ydOt9HDVj6WR+wG9Kw
	 aWT9o8Q9kObvuirxYY1XuCJuCiGLZ6VycQnyrS4vzn6YXetijRQJQIdIVflziLx4KNVbH
	 73OZeZKqZ3KniITyjsClZtbqBOJ1dq7OcUPO8D5CmRipBKj6d1TQFwhnisFfgVM1E7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=yywi59M5;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3KzQR2VS;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=xc7S9+dI;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="0ZtVT/29";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22446606A319;
	Thu, 22 Oct 2026 10:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22446606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=yywi59M5;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3KzQR2VS;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=xc7S9+dI;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0ZtVT/29
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0290A21E93;
	Thu, 22 Oct 2026 10:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792664191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSqtth9Qpbenh9XOfaBd+IxI7HLc0qZps+kjeRep0FM=;
	b=yywi59M5VteevZTydF2r2FFg41u4cYkjZRJ4cm24s52cVokTH68J8xf7gnE8XuORDIEoe8
	oetfGJHeiCkqFzSaUB3rX8vKuhcqApwylYXsbm7TSLcoFVZ0lDhIj8fc+h1LVPsQn1QC+E
	a+OW9pzS4c/tjJ2rUY/4uzMyo2B6DYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792664191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSqtth9Qpbenh9XOfaBd+IxI7HLc0qZps+kjeRep0FM=;
	b=3KzQR2VSEDYf6jeoVRESLjB6V4LdFeBmhzDqhUUYy9ZjwhG6y4viG2LKHTroMz/ece3uqT
	CBgZ4autqDe51+CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xc7S9+dI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="0ZtVT/29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792664190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSqtth9Qpbenh9XOfaBd+IxI7HLc0qZps+kjeRep0FM=;
	b=xc7S9+dIBZz0p2jz0JdP/QczrYlJFRJ3besi4I6wCDbHgcR2S+apk5vvv0EeQxdSJ/s3pm
	wuxVp3oEVrngccDRszugz0GvFA26J7lfBzbMYsei4nyfls9zmgRen9wrn6q5gnZhD2o+3T
	BHJ/YAFkdlhNoupjjSAg87IEVty4LS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792664190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSqtth9Qpbenh9XOfaBd+IxI7HLc0qZps+kjeRep0FM=;
	b=0ZtVT/29aGZ7kgiaJfMW5hzAaaqEPDcFoI29H6HCEAB/mIKDg+D8TTZkO7FQQIRmdaCUpK
	mKgy2m1TzP/TECBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8EC0134E6;
	Thu, 22 Oct 2026 10:16:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kLXBJ33i2WpwHQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Oct 2026 10:16:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5545CA1417; Thu, 22 Oct 2026 12:16:29 +0200 (CEST)
Date: Thu, 22 Oct 2026 12:16:29 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 06/15] fserror: don't accept error reports before the
 superblock is born
Message-ID: <3mwfltl3u7sht7ubkui6nybkhzjhsjle6rzmbfuzgahee7q5la@zjkree24ksq2>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
 <20261011-work-super-fixes-core-v1-6-c727176c5b53@kernel.org>
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
In-Reply-To: <20261011-work-super-fixes-core-v1-6-c727176c5b53@kernel.org>
X-Rspamd-Queue-Id: 0290A21E93
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -13.01

On Sun 11-10-26 17:56:06, Christian Brauner wrote:
> alloc_super() biases s_pending_errors for every superblock but
> generic_shutdown_super() only drops the bias and waits for pending error
> reports if sb->s_root is set. fserror_alloc_event() accepts reports
> whenever SB_ACTIVE is set. But xfs sets SB_ACTIVE around log recovery
> and f2fs around gc for checkpoint=disable, both while filling the
> superblock. If such a mount fails s_root stays NULL, nothing waits for
> the queued reports and destroy_super_work() frees the superblock while
> fserror_worker() is still pending. The worker holds no reference to the
> superblock. It reads s_flags and s_op, puts the inode it pinned and
> decrements s_pending_errors:
> 
>   BUG: KASAN: slab-use-after-free in fserror_worker (fs/fserror.c:54)
>   Read of size 8 at addr ff11000107366060 by task kworker/1:0/25
>   ...
>   Allocated by task 120:
>    __kmalloc_cache_noprof+0x27a/0x650
>    sget_fc (fs/super.c:326 [alloc_super()] fs/super.c:874)
>    get_tree_bdev_flags (fs/super.c:1479 fs/super.c:1866)
>    vfs_get_tree+0x8b/0x2f0
>   Freed by task 83:
>    kfree+0x1e8/0x5e0
>    process_one_work+0x953/0x1700
> 
> Nobody can listen for errors of a superblock that isn't born yet.
> fanotify marks need a path in the mounted filesystem and the xfs health
> monitor is attached through an ioctl on a mounted filesystem as well. So
> don't accept reports before SB_BORN is set. A born superblock always has
> s_root set when it's shut down so every accepted report is waited for.
> Errors during the mount are still logged as lost reports and xfs still
> records them in its health state.
> 
> Waiting for the reports of a failed mount in generic_shutdown_super()
> instead wouldn't be enough. That runs from ->kill_sb() after the error
> path of ->fill_super() and xfs and f2fs have already freed state there
> that putting a pinned inode needs.
> 
> Reproducer, xfs with a dirty log and a bad crc in the refcount btree
> root of AG 0. Log recovery reports the corruption while xfs has
> SB_ACTIVE set and then the mount fails. The work item normally runs
> right away, so a kprobe on queue_work_on() points it at a wrapper that
> sleeps until destroy_super_work() has freed the superblock:
> 
>   mkfs.xfs -f /dev/vda
>   mount /dev/vda /mnt && echo foo > /mnt/foo && sync
>   xfs_io -x -c "shutdown -f" /mnt      # flush the log, then shut down
>   umount /mnt                           # the log stays dirty
>   xfs_db -x -c "agf 0" -c "addr refcntroot" -c "write -c numrecs 7" /dev/vda
>   insmod r6_fshold.ko fserror_worker=0x$(awk '$3 == "fserror_worker" { print $1 }' /proc/kallsyms)
>   echo 1 > /sys/module/r6_fshold/parameters/armed
>   mount /dev/vda /mnt
> 
>   XFS (vda): Metadata CRC error detected at xfs_refcountbt_read_verify+0x1e/0x240, xfs_refcountbt block 0x30
>   XFS (vda): Failed to recover leftover CoW staging extents, err -117.
>   XFS (vda): Error -5 reserving per-AG metadata reserve pool.
>   BUG: KASAN: slab-use-after-free in fserror_worker+0x2da/0x310
> 
> Not a selftest since the work item has to be held back with a kprobe.
> 
> Fixes: 21945e6cb516 ("fs: report filesystem and file I/O errors to fsnotify")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks sensible to me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

but I've added Darrick to CC since he might have an opinion as well.

								Honza

> ---
>  fs/fserror.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/fserror.c b/fs/fserror.c
> index d8a800580012..90ce04d58514 100644
> --- a/fs/fserror.c
> +++ b/fs/fserror.c
> @@ -96,6 +96,13 @@ static inline struct fserror_event *fserror_alloc_event(struct super_block *sb,
>  		return NULL;
>  	if (!(sb->s_flags & SB_ACTIVE))
>  		goto out_pending;
> +	/*
> +	 * xfs and f2fs set SB_ACTIVE while filling the superblock. Nobody can
> +	 * listen before the superblock is born and if the mount fails nothing
> +	 * waits for the event.
> +	 */
> +	if (!(sb->s_flags & SB_BORN))
> +		goto out_pending;
>  
>  	event = mempool_alloc(&fserror_events_pool, gfp_flags);
>  	if (!event)
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
