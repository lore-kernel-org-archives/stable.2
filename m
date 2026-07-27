Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7695C3CB8F4
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179630; cv=none; b=dCGdYxEQyAPaBaXAef6ztP5HN7leX9otXwyowmQ65DzZYUiXA+9Q4mbVI5lslGxBz5P6At8zqdiH3DoHnE/sG04ek1FYnSsFrDjvRqaQNlSqfXv+UlK6MpGI7bYBnH1CP8la8aXSC5xZKZKjAvmmtOD/NT99Kz443gmoDzyY9/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179630; c=relaxed/simple;
	bh=jDd/fGsZGnV1Z7fNXNC8cwwpBxA8nTxDZqV4n61ktXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGUszvvkwJm58ALvhWXA4KUgA7ullWcBJ3db1nAj/P8y8+omQW3m13v/wng9JQ39xd1qYN91NNJ10eUrsLcSCUEZqQwnkm/42aPjDqu3USp7wh3Sb2DzWYi+xhYAp3YeQBXW/GWjdjDCbLeVcHE+TGy7RoUKB6XBLUzYb8WWk/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZObtBz5F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hPgfXF1y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ePUSytKQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G74DuVlJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZObtBz5F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hPgfXF1y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ePUSytKQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G74DuVlJ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6EDBC7BD2F;
	Mon, 27 Jul 2026 19:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785179622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DMGILCNhgCjwY+F5txoKiVf3mVd9BR/z5BR9Y9ftxpk=;
	b=ZObtBz5FLJGwMXwx6cYcw2Q7NrwfHUqZogpGygoMdnuIxf989zzOntAwu79HQhzJb+0kCc
	eZwcySsPVC0p2+WtVRb6H9IFoy4y5VabKB7Qgh/N+8jTMA44Hik3C4FXr0WZzCLRIDtXTY
	3/fFVGaKP4HBUI2+dqyMopbXHxaXXfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785179622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DMGILCNhgCjwY+F5txoKiVf3mVd9BR/z5BR9Y9ftxpk=;
	b=hPgfXF1ythb9Ygtj94mNBg6il7uAQ0y629jrnek2NLLEhsmsvmGGtRsybFC7QvoFeRceGK
	6Ny89Yff+aZDsDDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785179618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DMGILCNhgCjwY+F5txoKiVf3mVd9BR/z5BR9Y9ftxpk=;
	b=ePUSytKQz+f05vOcMooEN/xijAua/gofq953LfdGRU0x2C0Movn9ULuuwOj+Eh7oVF8h+k
	pdv/XI6c8NVjV/ISmrk90Wg9QDMggl7UeLesGs2Ks4S5imWmEH+w3osY04BPcWFhHstdLA
	PDAEVFBwyVxM5T7usuP0K0UFchfkJQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785179618;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DMGILCNhgCjwY+F5txoKiVf3mVd9BR/z5BR9Y9ftxpk=;
	b=G74DuVlJYYaE3QqZW2NXmlDeleno9N2icQ9MsUryYJGxPVuabrx+k3xW6hAIJaDgtsNeGo
	wj8KouzmP/G/CTAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 521F7779B9;
	Mon, 27 Jul 2026 19:13:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZXUEFOKtZ2peUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 Jul 2026 19:13:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E3F7AA0BA1; Mon, 27 Jul 2026 21:13:29 +0200 (CEST)
Date: Mon, 27 Jul 2026 21:13:29 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Mateusz Guzik <mguzik@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] super: fix emergency thaw deadlock on frozen block
 devices
Message-ID: <3cjzaja7j3mw3ufzhlejsspfkylkxw2wladik2a3s3n7ztvoys@ck4dt5kckneb>
References: <20260723-work-super-emergency_thaw-v1-1-7c315c600245@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-work-super-emergency_thaw-v1-1-7c315c600245@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu 23-07-26 11:37:05, Christian Brauner wrote:
> do_thaw_all_callback() calls bdev_thaw() while holding sb->s_umount
> exclusively. If the block device was frozen via bdev_freeze() dropping
> the last block layer freeze reference calls fs_bdev_thaw() which
> reacquires s_umount:
> 
>   do_thaw_all_callback(sb)
>     super_lock_excl(sb)                     # holds sb->s_umount
>     bdev_thaw(sb->s_bdev)
>       mutex_lock(&bdev->bd_fsfreeze_mutex)
>       # bd_fsfreeze_count drops 1 -> 0
>       bd_holder_ops->thaw == fs_bdev_thaw
>         get_bdev_super(bdev)
>           bdev_super_lock(bdev, true)
>             super_lock(sb, true)
>               down_write(&sb->s_umount)     # same task: deadlock
> 
> The emergency thaw worker deadlocks against itself holding both
> s_umount and bd_fsfreeze_mutex. That fscks any subsequent unmount,
> freeze, or thaw of that filesystem and block device.
> 
>   [   81.878470] sysrq: Show Blocked State
>   [   81.880140] task:kworker/0:1     state:D stack:0     pid:11    tgid:11    ppid:2      task_flags:0x4208060 flags:0x00080000
>   [   81.884876] Workqueue: events do_thaw_all
>   [   81.886656] Call Trace:
>   [   81.887759]  <TASK>
>   [   81.888763]  __schedule+0x579/0x1420
>   [   81.890372]  schedule+0x3a/0x100
>   [   81.891794]  schedule_preempt_disabled+0x15/0x30
>   [   81.893848]  rwsem_down_write_slowpath+0x1ea/0x900
>   [   81.895191]  ? __pfx_do_thaw_all_callback+0x10/0x10
>   [   81.896528]  down_write+0xbd/0xc0
>   [   81.897505]  super_lock+0x91/0x180
>   [   81.898457]  ? __mutex_lock+0xa99/0x1140
>   [   81.900748]  ? __mutex_unlock_slowpath+0x1f/0x400
>   [   81.902069]  bdev_super_lock+0x5b/0x150
>   [   81.903132]  get_bdev_super+0x10/0x60
>   [   81.904042]  fs_bdev_thaw+0x23/0xf0
>   [   81.904755]  bdev_thaw+0x82/0x100
>   [   81.905484]  do_thaw_all_callback+0x2c/0x50
>   [   81.906298]  __iterate_supers+0x5d/0x130
>   [   81.907067]  do_thaw_all+0x20/0x40
>   [   81.907739]  process_one_work+0x206/0x5e0
>   [   81.908545]  worker_thread+0x1e2/0x3c0
>   [   81.909339]  ? __pfx_worker_thread+0x10/0x10
>   [   81.910171]  kthread+0xf4/0x130
>   [   81.910799]  ? __pfx_kthread+0x10/0x10
>   [   81.911528]  ret_from_fork+0x2e2/0x3b0
>   [   81.912259]  ? __pfx_kthread+0x10/0x10
>   [   81.913010]  ret_from_fork_asm+0x1a/0x30
>   [   81.913806]  </TASK>
> 
> bdev_super_lock() even documents the violated requirement with
> lockdep_assert_not_held(&sb->s_umount).
> 
> Acquiring bd_fsfreeze_mutex under s_umount also inverts the
> bd_fsfreeze_mutex vs. s_umount ordering established by
> bdev_{freeze,thaw}() and can thus ABBA against a concurrent block-layer
> freeze even when the recursive path isn't hit.
> 
> Fix this by not holding s_umount around the bdev_thaw() loop at all. Pin
> the superblock with an active reference instead as
> filesystems_freeze_callback() does. The active reference keeps the
> superblock from being shut down and so ->s_bdev stays valid without
> holding s_umount. The block-layer-held freeze is dropped by
> fs_bdev_thaw() with FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE exactly as
> a regular unfreeze would and thaw_super_locked() handles
> filesystem-level freezes as before.
> 
> The emergency thaw path has deadlocked like this in one form or
> another for a long long time but the current exclusively-held
> shape dates back to commit [1] where thaw_bdev() already ended in
> thaw_super() with s_umount held by do_thaw_all_callback().
> 
> Fixes: 08fdc8a0138a ("buffer.c: call thaw_super during emergency thaw") [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Good catch. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 70dcb07e7fa5..ffdcc6a2e0de 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1082,16 +1082,30 @@ void emergency_remount(void)
>  	}
>  }
>  
> +static inline bool get_active_super(struct super_block *sb)
> +{
> +	bool active = false;
> +
> +	if (super_lock_excl(sb)) {
> +		active = atomic_inc_not_zero(&sb->s_active);
> +		super_unlock_excl(sb);
> +	}
> +	return active;
> +}
> +
>  static void do_thaw_all_callback(struct super_block *sb, void *unused)
>  {
> -	if (!super_lock_excl(sb))
> +	if (!get_active_super(sb))
>  		return;
>  
> +	/* fs_bdev_thaw() acquires s_umount so it must not be held here */
>  	if (IS_ENABLED(CONFIG_BLOCK))
>  		while (sb->s_bdev && !bdev_thaw(sb->s_bdev))
>  			pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
>  
> -	thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE, NULL);
> +	if (super_lock_excl(sb))
> +		thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE, NULL);
> +	deactivate_super(sb);
>  }
>  
>  static void do_thaw_all(struct work_struct *work)
> @@ -1117,17 +1131,6 @@ void emergency_thaw_all(void)
>  	}
>  }
>  
> -static inline bool get_active_super(struct super_block *sb)
> -{
> -	bool active = false;
> -
> -	if (super_lock_excl(sb)) {
> -		active = atomic_inc_not_zero(&sb->s_active);
> -		super_unlock_excl(sb);
> -	}
> -	return active;
> -}
> -
>  static const char *filesystems_freeze_ptr = "filesystems_freeze";
>  
>  static void filesystems_freeze_callback(struct super_block *sb, void *freeze_all_ptr)
> 
> ---
> base-commit: c4fd59e777f64a23778ea199937ac1e32a5a1bc2
> change-id: 20260723-work-super-emergency_thaw-a3959dbd39d1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
