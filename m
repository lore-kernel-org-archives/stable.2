Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663892;
	b=qXUocYMaSCxyEYvZNF3trolXuhDuVbAw9woNvBHMbGVMoIVrcc3AJJwJnbT4LZA3BjU6
	 FSV4kcp//MOmWDE3ainUVrQuWbaT8DQsk3Q2w5F7p0TbhSXPyvp+FMYv2D85nJz0TxoSR
	 /Rqw1JHgU89+0zDmGNBnlvPSctz8o5LUcqfW60SBJIHf4ovN3MlUmXqNWMU7ASMolUXn3
	 tP+BvR16BMNpGwzlmRwU5znteHc8dGhG9MqeO9QyAeKaPZqw8M7ceL/j8tRDI0MQjXRki
	 ceyN7PTE4nC1ZImbDMWXxk1Cb9/SdUk7EnUOc8gGkpxHKdNtGys0JVZu5eYdRVr266g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663892;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=9uIn4padYD3xjTA9K5j43pMgEFbyWMwuQcDwN6P6dHg=;
	b=qdJmI6m0emSSZiWCHGWNThvEVdJVJTUABfchVEJlDi4pNiJlHWYyydf7NwEqppF8mp5k
	 4+X978TW/dI8UEw8/NgZvNzGjD+9EeVbIdToO5Oj0hjX0hE+k2Jt8aQmKE691txCus8CA
	 2bKdL+LU+DVl6gAyhpHYbl7+q48DXLsyF/t8Mj+/q1v8BKvIz8z9iVkwAoc0hTEo9dCOW
	 W9TxJKdANhXwJblnmFcyWWx6pvTSCvEAK/LKc6VM81/RrIAU4WgK/AmH0YLVNHepP+xTQ
	 ub+K4eYRxqh7W2osQRLlazuIj6o4/tVPxjAs79Y9WJpT07Wm+TS/pK/gUVgc4zX3lXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YIW6ZwWP;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=THo3mDq0;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YIW6ZwWP;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=THo3mDq0;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE24606A31B;
	Thu, 22 Oct 2026 10:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACE24606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YIW6ZwWP;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=THo3mDq0;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YIW6ZwWP;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=THo3mDq0
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 57E031FCE2;
	Thu, 22 Oct 2026 10:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792663889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9uIn4padYD3xjTA9K5j43pMgEFbyWMwuQcDwN6P6dHg=;
	b=YIW6ZwWPVRkQ7MlOcTvAMKkgDQl/lptL/7E0V8kLTUWQqJkLdwbg+tJxPibGKA2tK1KKqE
	4tYPc2Kr8oDdmgO+iVo5CvgKLW8PZCuI/TwmErUPWA6sEny2bvROXwtC5mdQ5LmFlJ8DwM
	ebQffV4XECVhZlUZO1ZPLHhuAk5d1XE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792663889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9uIn4padYD3xjTA9K5j43pMgEFbyWMwuQcDwN6P6dHg=;
	b=THo3mDq0cU8eeecT4SvTdZK9npDLIQIuYbH5yA68IW2pBVOOkn0Isvr2IDWuxb6tF3OK/4
	hTKcn6jxhlEcZICQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792663889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9uIn4padYD3xjTA9K5j43pMgEFbyWMwuQcDwN6P6dHg=;
	b=YIW6ZwWPVRkQ7MlOcTvAMKkgDQl/lptL/7E0V8kLTUWQqJkLdwbg+tJxPibGKA2tK1KKqE
	4tYPc2Kr8oDdmgO+iVo5CvgKLW8PZCuI/TwmErUPWA6sEny2bvROXwtC5mdQ5LmFlJ8DwM
	ebQffV4XECVhZlUZO1ZPLHhuAk5d1XE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792663889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9uIn4padYD3xjTA9K5j43pMgEFbyWMwuQcDwN6P6dHg=;
	b=THo3mDq0cU8eeecT4SvTdZK9npDLIQIuYbH5yA68IW2pBVOOkn0Isvr2IDWuxb6tF3OK/4
	hTKcn6jxhlEcZICQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07396134E6;
	Thu, 22 Oct 2026 10:11:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Nje1NFDh2WrXFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Oct 2026 10:11:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 833BFA1417; Thu, 22 Oct 2026 12:11:24 +0200 (CEST)
Date: Thu, 22 Oct 2026 12:11:24 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 05/15] fserror: fully order the last pending error
 decrement
Message-ID: <mv2ru5d6qiqad2hemlzbrd4kfrt6pnfqmozn45xtk3cbj77hwb@ymmm3kzopfwb>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
 <20261011-work-super-fixes-core-v1-5-c727176c5b53@kernel.org>
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
In-Reply-To: <20261011-work-super-fixes-core-v1-5-c727176c5b53@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -12.80

On Sun 11-10-26 17:56:05, Christian Brauner wrote:
> fserror_unmount() drops the bias on s_pending_errors and waits for the
> count to reach zero in wait_var_event() while the umount holds s_umount
> exclusively. The worker that finishes the last pending error wakes it up
> in fserror_pending_dec() through refcount_dec_and_test() and
> wake_up_var().
> 
> wake_up_var() requires a full barrier between the store that makes the
> condition true and its waitqueue_active() check. refcount_dec_and_test()
> isn't fully ordered though. It provides release ordering and acquire
> ordering on success which orders the load of the decrement but not its
> store against the later load of the waitqueue. So the worker can see an
> empty waitqueue while the umount, already queued, still reads a count of
> one. The umount then sleeps forever with s_umount held and sync(2) and
> everything else that wants that superblock hangs behind it.
> 
> LKMM allows this and so do the herd7 models for arm64 (LDADDL; DMB
> ISHLD; LDR) and POWER. x86 is safe because the locked xadd is a full
> barrier. With smp_mb() before wake_up_var() all three forbid it.
> 
> The litmus test (LKMM: Sometimes; with smp_mb() before the read of wq in
> P1: Never). P0 is fserror_unmount() dropping the bias and queueing in
> wait_var_event(), P1 is the last fserror_pending_dec():
> 
>   { cnt=2; wq=0; state=0; }
> 
>   P0(atomic_t *cnt, int *wq, int *state, spinlock_t *wql)
>   {
>           int r0, r1, r2;
> 
>           r0 = atomic_fetch_sub_release(1, cnt);
>           if (r0 == 2) {
>                   r1 = atomic_read(cnt);
>                   if (r1 == 1) {
>                           spin_lock(wql);
>                           WRITE_ONCE(*wq, 1);
>                           smp_store_mb(*state, 2);
>                           spin_unlock(wql);
>                           r2 = atomic_read(cnt);
>                   }
>           }
>   }
> 
>   P1(atomic_t *cnt, int *wq, int *woken, spinlock_t *wql)
>   {
>           int r3, r4;
> 
>           r3 = atomic_fetch_sub_release(1, cnt);
>           if (r3 == 1) {
>                   smp_rmb();
>                   r4 = READ_ONCE(*wq);
>                   if (r4 != 0) {
>                           spin_lock(wql);
>                           WRITE_ONCE(*woken, 1);
>                           spin_unlock(wql);
>                   }
>           }
>   }
> 
>   exists (0:r0=2 /\ 0:r1=1 /\ 0:r2=1 /\ 1:r3=1 /\ 1:r4=0)
> 
> Not reproducible on x86 hardware. The consequence can be shown there by
> emulating the reordering in fserror_worker(), debug only: sample
> waitqueue_active() before the decrement, sleep, then decrement and only
> wake if the sample saw a waiter:
> 
>           iput(event->inode);
>   +       if (debug_reorder_ms) {
>   +               struct super_block *dsb = event->sb;
>   +               bool waiter;
>   +
>   +               mempool_free(event, &fserror_events_pool);
>   +               waiter = waitqueue_active(__var_waitqueue(&dsb->s_pending_errors));
>   +               msleep(debug_reorder_ms);
>   +               if (refcount_dec_and_test(&dsb->s_pending_errors) && waiter)
>   +                       wake_up_var(&dsb->s_pending_errors);
>   +               return;
>   +       }
>           fserror_free_event(event);
> 
>   # boot with fserror.debug_reorder_ms=5000
>   mount -t ext4 /dev/vda /mnt
>   xfs_io -x -c "shutdown" /mnt      # EXT4_IOC_SHUTDOWN with NOLOGFLUSH
>   umount /mnt &                     # hangs forever
>   sync &                            # hangs behind s_umount
> 
>   INFO: task umount:108 blocked for more than 30 seconds.
>    fserror_unmount+0x20d/0x2c0
>    generic_shutdown_super+0xac/0x530
>    kill_block_super+0x3b/0xa0
>    ext4_kill_sb+0x6c/0xc0
>   INFO: task sync:111 <reader> blocked on an rw-semaphore likely owned by task umount:108 <writer>
> 
> Fixes: 21945e6cb516 ("fs: report filesystem and file I/O errors to fsnotify")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Geez this is subtle. In particular because it is different from
atomic_dec_and_test() which *does* provide full ordering. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fserror.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fserror.c b/fs/fserror.c
> index 1e4d11fd9562..d8a800580012 100644
> --- a/fs/fserror.c
> +++ b/fs/fserror.c
> @@ -35,8 +35,15 @@ void fserror_unmount(struct super_block *sb)
>  
>  static inline void fserror_pending_dec(struct super_block *sb)
>  {
> -	if (refcount_dec_and_test(&sb->s_pending_errors))
> +	if (refcount_dec_and_test(&sb->s_pending_errors)) {
> +		/*
> +		 * refcount_dec_and_test() isn't fully ordered but wake_up_var()
> +		 * needs a full barrier between the store and its waitqueue check.
> +		 * Pairs with the barrier in prepare_to_wait_event().
> +		 */
> +		smp_mb();
>  		wake_up_var(&sb->s_pending_errors);
> +	}
>  }
>  
>  static inline void fserror_free_event(struct fserror_event *event)
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
