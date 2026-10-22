Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662766;
	b=1BzY3T7OT6dH2QLaPsyituXE/VOGsTgonVFyEKNxkR5xtfEKW7Q0fGbl/VcW27o/hMGd
	 Vj250+1mSuLgyqH7iQBZnoMPm34PlPvRReu095c3ClKIwYF4Ig+6nhqUDFgSN0pPFxKTU
	 ss7C1YjE6cNxnjXrqTxw+3dV6o2m2zCsUdDDGj0+vjrbavL5/O5Kn16kN91zB3815aNL1
	 oGdNdmhu2e2Ad+KEJsz3/Taw5lqIYxEpR7vksTHkMIPG6EHUMyeZqzpUK8DmnGKN7DTmz
	 buXXJ+QHrJeTJHnD7GvUMuyQb2kTgTaQhJg+mti/4rNUNf4E/KpjUVkd6ZhMQ0E2kqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662766;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=05Nb8YLu9YWXWXHPGusWiMczEkKLTdlNGiT1AxdnnfE=;
	b=hr5vNKS1GE8IfuGAdL+XBWzDG9fwHyEbk+DFApLdZWBV1moWalwL/cPd/INz1C60kpBC
	 vp7AUdqXaGUOUZLTuwjshC/LuAwJSBX4YmySRZlgqAReGvAwUZhtD7uHZmBN8P8dwC2Wi
	 Ne1DC9j989g8MBHKQAptEpx/YdNfHa+r8O7aozqCRT9kw/QhzL9JYK8ae8ro+6OJWQM/M
	 77s4mgR5BO/DmiL80t7uS94fTle+fNvaJwqLHhtlV/LiUvqMaUPrQq0vx1ep6KbObiUFp
	 wD48MMEzK+z4mAOil2G886VINekl8N3WlDKSqQo3iKCUy/a5Vv85PaE9865oPJHGw0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=A4bJ1+OO;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PygrsFCC;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=shhkZkAR;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dj5wIR94;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD596606A31D;
	Thu, 22 Oct 2026 09:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD596606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=A4bJ1+OO;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PygrsFCC;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=shhkZkAR;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dj5wIR94
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E68791FCB6;
	Thu, 22 Oct 2026 09:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792662764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=05Nb8YLu9YWXWXHPGusWiMczEkKLTdlNGiT1AxdnnfE=;
	b=A4bJ1+OO5lCRsErwaFst3LPuO1wSP8NZR/4rHQ6pwRa7vQpUCfrLbFx5UZvx0RlGH8v0q0
	RG9Xgv/x9Zr0y8Inwcswq7assU7Ri/p46hSoC3eo26h8dfVqz6IlwW2MV8rgH+FgC5esAh
	QHY93vQ02jOntTmg7wBbkWOeI2M3WDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792662764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=05Nb8YLu9YWXWXHPGusWiMczEkKLTdlNGiT1AxdnnfE=;
	b=PygrsFCCtDK3yQz3CwaMhfu6JIMSTcJfK78AknBaEwUOS+P1ps7n+dIU3zj3bKYRHJh8hl
	2Nf5B7NFbALhbVBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792662763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=05Nb8YLu9YWXWXHPGusWiMczEkKLTdlNGiT1AxdnnfE=;
	b=shhkZkARzbtekLHUkMPP7IV1edxr/0Opph4SCRAMFoQMAHACWhNdMMxtRMoVk+V/SaAd69
	Kj4rCN6zcI1aGKAWJ8NUlEy0mEymqB2frBKvbuvWtGEkKlfDlb2LNsqoFErwI9k3r6aQX+
	phwemMCDa+P45ycajsc7z5yFLbkvlPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792662763;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=05Nb8YLu9YWXWXHPGusWiMczEkKLTdlNGiT1AxdnnfE=;
	b=dj5wIR94e1c7gxgfAldDVzLS5+R54gKYhm7zHal5lylSzlhp4xOSuQR7HqIDxZ57zD45YH
	59dkJIHM/hdzmRAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB25E133F3;
	Thu, 22 Oct 2026 09:52:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Oy1lJevc2WpGBAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Oct 2026 09:52:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4538DA1417; Thu, 22 Oct 2026 11:52:43 +0200 (CEST)
Date: Thu, 22 Oct 2026 11:52:43 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 01/15] super: don't put the remount context under s_umount
Message-ID: <4zo5y25hnl7bo6tamysu3ortqloicmdcl6gm26aoua77jcjxyt@ncbgimqm6d5i>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
 <20261011-work-super-fixes-core-v1-1-c727176c5b53@kernel.org>
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
In-Reply-To: <20261011-work-super-fixes-core-v1-1-c727176c5b53@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Sun 11-10-26 17:56:01, Christian Brauner wrote:
> do_emergency_remount_callback() is called from __iterate_supers() with
> s_umount held exclusively. It creates a reconfigure context for the
> superblock and fs_context_for_reconfigure() takes an active reference
> for it. put_fs_context() drops that reference via deactivate_super()
> while s_umount is still held.
> 
> The iterator itself only holds a passive reference. So if the
> filesystem is unmounted while reconfigure_super() runs, the umount drops
> the mount's active reference without ever taking s_umount because
> atomic_add_unless() in deactivate_super() sees the context's reference.
> Now the context holds the last active reference and we're fscked:
> put_fs_context() ends up in deactivate_super() which tries to take
> s_umount again and the kworker deadlocks on itself:
> 
>   WARNING: possible recursive locking detected
>   kworker/1:1/53 is trying to acquire lock:
>   (&type->s_umount_key#26){+.+.}-{4:4}, at: deactivate_super+0x6f/0x90
>   but task is already holding lock:
>   (&type->s_umount_key#26){+.+.}-{4:4}, at: super_lock+0x188/0x3a0
>   ...
>    down_write+0x90/0x1e0
>    deactivate_super+0x6f/0x90
>    put_fs_context+0xb1/0x7d0
>    __iterate_supers+0x33d/0x410
>    do_emergency_remount+0x20/0x40
> 
> "Emergency Remount complete" is never printed and the superblock's
> s_umount stays held forever. Everything that needs it hangs after that,
> including sync(2) and thus the clean reboot that usually follows a
> sysrq-u. The window is all of reconfigure_super(), i.e., syncing a
> read-write filesystem, so an umount racing with sysrq-u hits this
> easily.
> 
> Iterate without holding s_umount and take it in the callback instead.
> The context's active reference keeps the superblock alive while we hold
> s_umount and we only drop it after we released s_umount again. If it is
> the last reference deactivate_super() takes s_umount and shuts the
> filesystem down, just as the umount would have done.
> 
> Reproducer. sysrq-u remounts every block filesystem read-only, so use a
> throwaway VM. It needs CONFIG_SCSI_DEBUG and CONFIG_MAGIC_SYSRQ. The
> scsi_debug delay keeps reconfigure_super() busy writing back the dirty
> data long enough for the umount to land in the window:
> 
>   modprobe scsi_debug dev_size_mb=256
>   dev=/dev/sda        # the scsi_debug disk
>   mkfs.ext4 -q $dev
>   mount $dev /mnt
>   dd if=/dev/zero of=/mnt/dirty bs=1M count=32
>   echo 20 > /sys/bus/pseudo/drivers/scsi_debug/delay
>   echo u > /proc/sysrq-trigger
>   sleep 1
>   umount /mnt
>   # lockdep: possible recursive locking detected in
>   # do_emergency_remount(), "Emergency Remount complete" never shows up
>   # and sync hangs.
> 
> Without the fix this reproduces on the first run on v7.3-rc6. With the
> fix the remount completes and the kworker shuts the filesystem down.
> 
> Fixes: 8d0347f6c3a9 ("convert do_remount_sb() to fs_context")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 1d5ccf540a9b..15ecfbeb92ab 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1158,23 +1158,34 @@ int reconfigure_super(struct fs_context *fc)
>  
>  static void do_emergency_remount_callback(struct super_block *sb, void *unused)
>  {
> -	if (sb->s_bdev && !sb_rdonly(sb)) {
> -		struct fs_context *fc;
> +	struct fs_context *fc = NULL;
> +
> +	if (!super_lock_excl(sb))
> +		return;
>  
> +	/* Make sure no reference put under s_umount is the last one. */
> +	atomic_inc(&sb->s_active);
> +	if (sb->s_bdev && !sb_rdonly(sb)) {
>  		fc = fs_context_for_reconfigure(sb->s_root,
>  					SB_RDONLY | SB_FORCE, SB_RDONLY);
> -		if (!IS_ERR(fc)) {
> -			if (parse_monolithic_mount_data(fc, NULL) == 0)
> -				(void)reconfigure_super(fc);
> -			put_fs_context(fc);
> -		}
> +		if (!IS_ERR(fc) && parse_monolithic_mount_data(fc, NULL) == 0)
> +			(void)reconfigure_super(fc);
>  	}
> +	super_unlock_excl(sb);
> +
> +	/*
> +	 * Our active reference may be the last one by now, so only drop it
> +	 * after s_umount has been released.
> +	 */
> +	if (!IS_ERR_OR_NULL(fc))
> +		put_fs_context(fc);
> +	deactivate_super(sb);
>  }
>  
>  static void do_emergency_remount(struct work_struct *work)
>  {
>  	__iterate_supers(do_emergency_remount_callback, NULL,
> -			 SUPER_ITER_EXCL | SUPER_ITER_REVERSE);
> +			 SUPER_ITER_UNLOCKED | SUPER_ITER_REVERSE);
>  	kfree(work);
>  	printk("Emergency Remount complete\n");
>  }
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
