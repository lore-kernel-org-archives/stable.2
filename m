Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B3D5111B7;
	Tue,  8 Sep 2026 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862870; cv=none; b=gUun+3qVXIr4wIKsUrloXo8IByH+ltYNkr7KGO8foRN+CReTvz44ejL0urB/G+rtZK+SxwV+1UYKraVUYn/kTz+4PRjBrWaJ3N+KM241OP663e5HqWrToE4eVNt1eeF8sPkvPpEdw8c8KIQvhRsMsPMmHELZPbvmXiZ7QEp2Hqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862870; c=relaxed/simple;
	bh=2QqxPt8UXxT+BbmCv6HBeCdHjjUTvykPh4VG1ctOQSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+L0HbIjPZo6g8FDtpRhTPkh/bsD29vTTEIRISTzAoY7crp/rYPMagUhEYSASAajlgnL7McAZkJpTcMkgmWujlk5Mk0pHCCw+5diPptGRKDBWWEClwEjc9DNbXXS3aUDyjf2Du/zTmrGfXvVOPdxItfaD9+AXV65nklw2RjGsFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xsPvOlsK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VeOpz+42; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G5OVleZY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kSFw2lc6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xsPvOlsK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VeOpz+42";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G5OVleZY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kSFw2lc6"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A210021A0A;
	Tue,  8 Sep 2026 10:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788862862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aDp/ISnPqmAmyyV6yTqkmNNaW1ciXzOxEdetGx7hFj8=;
	b=xsPvOlsKk1cbm6s7SDFqJbfm9KCbJAQ2597WmKET1V3N9C2bcUe1nGAlYR8gerp09dk48b
	rcuSzK4H/eCLRqf/p6EP8fQ7oYEpNJYUfXUH9WL1SLsxQkIUkhhVq/UIU0B7L9wUajrnKl
	mSn6//Zw5qdz2LppYGZsD54ijThXIOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788862862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aDp/ISnPqmAmyyV6yTqkmNNaW1ciXzOxEdetGx7hFj8=;
	b=VeOpz+42bOc88/wnNFm0rhwczSWj7rGT76tckqneED6GybbrrSdxxpz1+nk16hN4Pa4taB
	ecZF+Be0zpMO7ECg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=G5OVleZY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kSFw2lc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788862858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aDp/ISnPqmAmyyV6yTqkmNNaW1ciXzOxEdetGx7hFj8=;
	b=G5OVleZYqvSktUQMX0dRsr/QNT8SrwR/wusccQOEHsDnZgZ71qyZ8NFWQausYcCpGVifiv
	IvbTYGVvUjcrx6Md9r0uVtZZJ97yBspygYd+pwdCMy0/K1B1QynjMvHkgOOJ2ln6R0GhQj
	zYq4JyWeNiK95zP1ohdQwaDpxWOn3vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788862858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aDp/ISnPqmAmyyV6yTqkmNNaW1ciXzOxEdetGx7hFj8=;
	b=kSFw2lc6gKIpNah1vIPmOovss7QMg31pBccVvfV3JJrY3BwYn2m8JMAjGfs/6LRckdDDJ8
	icyn1iNdvv0ylzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81B321364A;
	Tue,  8 Sep 2026 10:20:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d7SnH4rhn2rJDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 08 Sep 2026 10:20:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1A64FA12E2; Tue, 08 Sep 2026 12:20:58 +0200 (CEST)
Date: Tue, 8 Sep 2026 12:20:58 +0200
From: Jan Kara <jack@suse.cz>
To: Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Benjamin Peterson <benjamin@locrian.net>, 
	Jan Kara <jack@suse.cz>, Arjan van de Ven <arjan@linux.intel.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Jake Edge <jake@lwn.net>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] exec: do_close_on_exec() before taking exec_update_lock
Message-ID: <tzmyqzv64imx2t4k72dfqxobapw7pyqrht7iwvxuibrlqg67ux@jiu4arsjwmfx>
References: <20260907-cloexec-before-exec-update-lock-v1-1-8018c201a7df@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-cloexec-before-exec-update-lock-v1-1-8018c201a7df@google.com>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: A210021A0A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO

On Mon 07-09-26 23:26:32, Jann Horn wrote:
> do_close_on_exec() currently happens while holding the exec_update_lock,
> which is used in a lot of places that access process state to
> synchronize access checks.
> I recently added another such use of exec_update_lock, causing a
> regression.
> 
> do_close_on_exec() can block waiting for a reply from a filesystem.
> That means a hung filesystem can block codepaths that use
> exec_update_lock; and it also means that a FUSE filesystem which
> attempts to inspect the calling process can deadlock.
> 
> To avoid such problems, move do_close_on_exec() before the
> exec_update_lock is taken, but after the FD table has been copied if
> necessary.
> 
> I have looked through all the calls between the old and new position of
> the do_close_on_exec() call; there seems to be no file descriptor table
> access in between.
> 
> Reported-by: Benjamin Peterson <benjamin@locrian.net>
> Closes: https://lore.kernel.org/r/f5e8166a-88be-46c5-8939-1e5227ffe4c2@app.fastmail.com
> Fixes: 6650527444da ("proc: protect ptrace_may_access() with exec_update_lock (part 1)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/exec.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 745f6eb5279e..b51e5d7e4536 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1164,6 +1164,20 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		goto out;
>  
> +	/*
> +	 * We have to apply CLOEXEC before we change whether the process is
> +	 * dumpable (in setup_new_exec) to avoid a race with a process in userspace
> +	 * trying to access the should-be-closed file descriptors of a process
> +	 * undergoing exec(2).
> +	 *
> +	 * This can block on filesystem ->flush() handlers, including waiting
> +	 * for FUSE daemons, so do it before exec_mmap takes the
> +	 * exec_update_lock.
> +	 * This must happen after the point of no return, and after unsharing
> +	 * the FD table.
> +	 */
> +	do_close_on_exec(me->files);
> +
>  	/*
>  	 * Must be called _before_ exec_mmap() as bprm->mm is
>  	 * not visible until then. Doing it here also ensures
> @@ -1214,14 +1228,6 @@ int begin_new_exec(struct linux_binprm * bprm)
>  
>  	clear_syscall_work_syscall_user_dispatch(me);
>  
> -	/*
> -	 * We have to apply CLOEXEC before we change whether the process is
> -	 * dumpable (in setup_new_exec) to avoid a race with a process in userspace
> -	 * trying to access the should-be-closed file descriptors of a process
> -	 * undergoing exec(2).
> -	 */
> -	do_close_on_exec(me->files);
> -
>  	if (bprm->secureexec) {
>  		/* Make sure parent cannot signal privileged process. */
>  		me->pdeath_signal = 0;
> 
> ---
> base-commit: 73ae59e975966d24e32926247ddb45a537ebe184
> change-id: 20260907-cloexec-before-exec-update-lock-972ad108510c
> 
> Best regards,
> --  
> Jann Horn <jannh@google.com>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
