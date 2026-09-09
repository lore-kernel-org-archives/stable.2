Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9DE53D0B3;
	Wed,  9 Sep 2026 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952406; cv=none; b=BC2y73qUBeOo+uhQKT233Whotg8A3yFjNVZBv6ckq3OMTJBkD9ye7vJuvSFiTt1Zq8EJpbSnzbZrblUMRlw2prVccei46lr2OgbmvD9MsUYoiteGZD6aKUAV1BwcWB9E6PyItQbVL1+yhwK73ENcguIZ1J+6TRsJ+AYQtQ573QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952406; c=relaxed/simple;
	bh=Z1ZvfQTCP9miJZUJrg2PhIgqafneuXFxguvQNrM6Ouk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9xT1lf4jaYz7XxY+upztNbJlC7w84+fYGT0W/pLo4/7AN/X8rofsqXPvNFJy8p/VltTl/6NrtqpS5Q4YzgvVyicJz0RKqwBXSdTV+s6u1rYFO9DP6wN9n7ypK1600YKbynMfRtgz/qTz/uBRiN7tLdrEfcndd44gyxRKb+5Vcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kTzbP3mg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t205eAep; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aDR46n9V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7EltjWLF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kTzbP3mg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t205eAep";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aDR46n9V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7EltjWLF"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C1925223A2;
	Wed,  9 Sep 2026 11:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788952392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fIzu71Kacz/rjBQc2Rxx6ElSm2DVRC+o904X8TAJwRA=;
	b=kTzbP3mg4YSr+PuY8NwUS8DMeBCaobqcsHplbhgNV+ziDTpAKSQv8pxPCb+8mowhs6eqqu
	YYHKShTKYGEBM8mMALYLxayiNo7GaNgCkM28zgdy7h7SJamOWV6gAFpqFa/WXwfNo2xK/D
	1qp+8RcfD+OWfHbNWky1hVOGosF9nXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788952392;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fIzu71Kacz/rjBQc2Rxx6ElSm2DVRC+o904X8TAJwRA=;
	b=t205eAepGhpjwttuPrUE/wcjUM83Zcq/8dtqAA6Vwm6PPvOonF/RxmX/R/tNGuIKpmIxpr
	TjbJO4AVBZvFS5CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788952387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fIzu71Kacz/rjBQc2Rxx6ElSm2DVRC+o904X8TAJwRA=;
	b=aDR46n9V26MJxlJLA7szhUPyb0VkjhT1Ktj+8UN2YUtuz2VIPvJiWAs7FOZ3EGG0MwMp+u
	FI67lrA8FaPRtIhdkEhrafdPR5oHwA6xSpD2JI7LrvTW4WCcNs4AssHh1tj5xuQyvJuxYb
	yB0oWsrUPnyfZmI62TQxA12Hcib0Xsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788952387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fIzu71Kacz/rjBQc2Rxx6ElSm2DVRC+o904X8TAJwRA=;
	b=7EltjWLFGqsO58yv3jieM39o4c2LrIU/gMfLVRPPKs380u0yjrsVJRrHQVfaq9lcfGPfb1
	SyzlKccfMCD+bkCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BA871347F;
	Wed,  9 Sep 2026 11:12:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6kifCTA/oWpMXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Sep 2026 11:12:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C9C95A13AC; Wed, 09 Sep 2026 13:11:18 +0200 (CEST)
Date: Wed, 9 Sep 2026 13:11:18 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, jack@suse.cz, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, ntfs3@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, stable@vger.kernel.org, 
	syzbot+2a13ad6914e6fcec716c@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/ntfs3: use d_instantiate_new() in ntfs_create_inode()
 and murder syzbot's "WARNING in do_new_mount" saga
Message-ID: <wb2nqwn5fbrlp37u252gqptbtigphwjd3dceecebidbgmm6o2s@u74tm6ckvro7>
References: <20260909-work-ntfs3-d_instantiate_new-v1-1-2db697162ce8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-work-ntfs3-d_instantiate_new-v1-1-2db697162ce8@kernel.org>
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[2a13ad6914e6fcec716c];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,suse.com:email,suse.cz:email]

On Wed 09-09-26 11:03:18, Christian Brauner wrote:
> ntfs_create_inode() creates a new inode via ntfs_new_inode(). It hashes
> it with insert_inode_locked() and so it's marked as I_NEW until
> unlock_new_inode().
> 
> ntfs 3 calls d_instantiate() in between though... Since the dentry was
> already hashed by the lookup before the create any path walk finds it
> without touching the parent's i_rwsem and so can lock the inode.
> 
> If the inode is a directory unlock_new_inode() calls
> lockdep_annotate_inode_mutex_key() and marks i_rwsem with the
> i_mutex_dir_key class.
> 
> That resets the count and the owner of a lock somebody else may already
> hold by now...
> 
> syzbot has been spamming us with the same godforsaken bug
> 
>   "WARNING in do_new_mount"
> 
> since 2023. I can't take it anymore so I went looking. Afaict, syzbot's
> executor chdirs into a freshly mounted ntfs3 image, creates a
> directory and then mounts some pseudofs on it. Everytime the mkdir()
> takes longer than syzbot waits mount() runs concurrently:
> 
>   mkdir("./sys")                        mount(NULL, "./sys", "sysfs")
>   ntfs_create_inode()
>     d_instantiate()
>                                         user_path_at() finds the dentry
>                                         do_lock_mount()
>                                           inode_lock(inode)
>                                           namespace_lock()
>     unlock_new_inode()
>       lockdep_annotate_inode_mutex_key()
>         init_rwsem(&inode->i_rwsem)
>                                         unlock_mount()
>                                           inode_unlock(inode)
> 
> The mount side then releases a lock that according to the rwsem nobody
> holds:
> 
>   DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && ...):
>   count = 0x0, magic = 0xffff888043a854e8, owner = 0x0,
>   curr 0xffff888000244880, list empty
>   WARNING: CPU: 0 PID: 5346 at kernel/locking/rwsem.c:1368 __up_write
>   Call Trace:
>    inode_unlock include/linux/fs.h:877 [inline]
>    unlock_mount fs/namespace.c:2892 [inline]
>    do_new_mount_fc fs/namespace.c:3828 [inline]
>    do_new_mount+0x777/0xa40 fs/namespace.c:3887
> 
> On PREEMPT_RT the same thing shows up as
> 
>   DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current)
>   WARNING: kernel/locking/rtmutex_common.h:193 at rt_mutex_slowunlock
> 
> The up_write() underflows the reset count. A following inode_lock() on
> that directory then never returns. A path walk into the new directory
> racing with the mkdir() corrupts the lock the same way via
> inode_lock_shared() in lookup_slow().
> 
> Switch to d_instantiate_new() and drop the trailing unlock_new_inode().
> All error paths bail out before that point with I_NEW still set and
> keep using discard_new_inode().
> 
> May we never see this fscking bug report again.
> 
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
> Cc: stable@vger.kernel.org # v5.15+
> Reported-by: syzbot+2a13ad6914e6fcec716c@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/6a9beced.a5e650b3.26d8a.000b.GAE@google.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ntfs3/inode.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 56b4f6469a28..4ac26c80bd34 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -1866,10 +1866,10 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
>  		goto out6;
>  
>  	/*
> -	 * Call 'd_instantiate' after inode->i_op is set
> +	 * Call 'd_instantiate_new' after inode->i_op is set
>  	 * but before finish_open.
>  	 */
> -	d_instantiate(dentry, inode);
> +	d_instantiate_new(dentry, inode);
>  
>  	/* Set original time. inode times (i_ctime) may be changed in ntfs_init_acl. */
>  	inode_set_atime_to_ts(inode, ni->i_crtime);
> @@ -1917,9 +1917,6 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
>  	if (!fnd)
>  		ni_unlock(dir_ni);
>  
> -	if (!err)
> -		unlock_new_inode(inode);
> -
>  	return err;
>  }
>  
> 
> ---
> base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
> change-id: 20260909-work-ntfs3-d_instantiate_new-814ad31dea82
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
