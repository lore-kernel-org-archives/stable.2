Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA813F6C2C
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782483561; cv=none; b=U89kdUNYrUo8lv4hMkO4keTeMzulK7RDFPLRFPn+YX+Hm8J5nT9GpdjV4STj7xPlb0nAp8mVHBp792SadnM8Z0FyKa+NFFOvr287lMpkn+NEKkSFT+8EoQ2cldvtWNILyZGAiFUZFd5ZkuQJPgphKDXlfVUNzSLDsv2qjJG/lxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782483561; c=relaxed/simple;
	bh=B3/FR7sbtfD9VYDuTjqm4dtS7bs4T0ydCkZRUZ16Sqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJyfrQAUpv5+kkU70Amr21wObGJ4+EYMs4cyDnOIOw4sysksxdV6lelM7y2CQOp3mMO7/u31mkLIUiUUQp+ry89JGj1XVKQd6ijJDx037bUElSFGUCYbgyi00jYws1Day9vzqfa9e1sRCdCooiTorIXS7Dxzt5b+7bblTse07X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LcApiVHn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8plrHN/0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LcApiVHn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8plrHN/0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LcApiVHn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8plrHN/0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LcApiVHn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8plrHN/0"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 79A0D758FC;
	Fri, 26 Jun 2026 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782483558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gbMQKiXqfVe8vOZqxCfOqjk0hfDyKNE4OsiYCQtUcUU=;
	b=LcApiVHn+gVKrWoqaEhQVbIz0Zfyo9dpkPuQ2Ozgyd1CvHJZQZLhznn3W40lcJJoYhKPXX
	XnHWM4Qwp5gLQLgo/Hi0uuS1ajli0CTyL3T2nBab5PzLOt9od2TNrqR7SjtURvkWXfbBuw
	RR7H1bO7aGjqzCtHLiubmx/BIuzvmZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782483558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gbMQKiXqfVe8vOZqxCfOqjk0hfDyKNE4OsiYCQtUcUU=;
	b=8plrHN/0jw3WpXlvF0EUMNASD/VGjmuOTWNRc3Kr8LRxujHnTLSnos7h0ZzEbzHLDC5zRy
	x/Nl5gth52RcGPCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LcApiVHn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="8plrHN/0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782483558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gbMQKiXqfVe8vOZqxCfOqjk0hfDyKNE4OsiYCQtUcUU=;
	b=LcApiVHn+gVKrWoqaEhQVbIz0Zfyo9dpkPuQ2Ozgyd1CvHJZQZLhznn3W40lcJJoYhKPXX
	XnHWM4Qwp5gLQLgo/Hi0uuS1ajli0CTyL3T2nBab5PzLOt9od2TNrqR7SjtURvkWXfbBuw
	RR7H1bO7aGjqzCtHLiubmx/BIuzvmZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782483558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gbMQKiXqfVe8vOZqxCfOqjk0hfDyKNE4OsiYCQtUcUU=;
	b=8plrHN/0jw3WpXlvF0EUMNASD/VGjmuOTWNRc3Kr8LRxujHnTLSnos7h0ZzEbzHLDC5zRy
	x/Nl5gth52RcGPCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BDD4779A8;
	Fri, 26 Jun 2026 14:19:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YBxNGmaKPmr3XgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 26 Jun 2026 14:19:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0FFBCA10A3; Fri, 26 Jun 2026 16:19:18 +0200 (CEST)
Date: Fri, 26 Jun 2026 16:19:18 +0200
From: Jan Kara <jack@suse.cz>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: do file ownership checks with the proper mount idmap
Message-ID: <s6mr3j7gew2cgerzrvqzenjctctrtnhvlynmcccxb24uszcauz@5iapd6wnbfxg>
References: <20260625153853.913949-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625153853.913949-1-pfalcato@suse.de>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.de:email,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 79A0D758FC
X-Spam-Score: -4.01

On Thu 25-06-26 16:38:53, Pedro Falcato wrote:
> Ever since idmapped mounts were introduced, inode ownership checks
> (for side-channel protection) in mincore() and madvise(MADV_PAGEOUT) were
> done against the nop_mnt_idmap, which completely ignores the file's mount's
> idmap. This results in odd edgecases like:
> 
> 1) mount/bind-mount with an idmap userA:userB:1
> 2) userB runs an owner_or_capable() check on file that is owned by userA
> on-disk/in-memory, but owned by userB after idmap translation
> 3) owner_or_capable() mysteriously fails as the correct idmap wasn't supplied
> 
> In the case of mincore/madvise MADV_PAGEOUT, this is usually benign, because
> file_permission(file, MAY_WRITE) will probably succeed, as it uses the proper
> idmap internally, but it does not need to be the case on e.g a 0444 file
> where even the owner itself doesn't have permissions to write to it.
> 
> Since this is clearly not trivial to get right, introduce a
> file_owner_or_capable() that can carry the correct semantics, and switch
> the various users in mm to it.
> 
> The issue was found by manual code inspection & an off-list discussion with
> Jan Kara.
> 
> Fixes: 9caccd41541a ("fs: introduce MOUNT_ATTR_IDMAP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

This looks good to me. I'm a bit curious why Christian initially (in 2021)
used init_user_ns here instead of the file namespace... Anyway feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

I'll also note that there are quite some places in fs/ that could be
simplified with this helper but I'd leave them for later.

								Honza

> ---
> 
> I noticed there are a couple of call sites in fs/ that could perhaps be
> cleaned up with the added helper, but I'm skipping that for now for brevity's
> sake.
> 
>  include/linux/fs.h | 5 +++++
>  mm/filemap.c       | 2 +-
>  mm/madvise.c       | 3 +--
>  mm/mincore.c       | 3 +--
>  4 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d10897b3a1e3..50ce731a2b78 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2444,6 +2444,11 @@ static inline struct mnt_idmap *file_mnt_idmap(const struct file *file)
>  	return mnt_idmap(file->f_path.mnt);
>  }
>  
> +static inline bool file_owner_or_capable(const struct file *file)
> +{
> +	return inode_owner_or_capable(file_mnt_idmap(file), file_inode(file));
> +}
> +
>  /**
>   * is_idmapped_mnt - check whether a mount is mapped
>   * @mnt: the mount to check
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 5af62e6abca5..58eb9d240643 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4704,7 +4704,7 @@ static inline bool can_do_cachestat(struct file *f)
>  {
>  	if (f->f_mode & FMODE_WRITE)
>  		return true;
> -	if (inode_owner_or_capable(file_mnt_idmap(f), file_inode(f)))
> +	if (file_owner_or_capable(f))
>  		return true;
>  	return file_permission(f, MAY_WRITE) == 0;
>  }
> diff --git a/mm/madvise.c b/mm/madvise.c
> index cd9bb077072c..77552b03d318 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -336,8 +336,7 @@ static inline bool can_do_file_pageout(struct vm_area_struct *vma)
>  	 * otherwise we'd be including shared non-exclusive mappings, which
>  	 * opens a side channel.
>  	 */
> -	return inode_owner_or_capable(&nop_mnt_idmap,
> -				      file_inode(vma->vm_file)) ||
> +	return file_owner_or_capable(vma->vm_file) ||
>  	       file_permission(vma->vm_file, MAY_WRITE) == 0;
>  }
>  
> diff --git a/mm/mincore.c b/mm/mincore.c
> index 296f2e3922b5..c8757c5085bf 100644
> --- a/mm/mincore.c
> +++ b/mm/mincore.c
> @@ -227,8 +227,7 @@ static inline bool can_do_mincore(struct vm_area_struct *vma)
>  	 * for writing; otherwise we'd be including shared non-exclusive
>  	 * mappings, which opens a side channel.
>  	 */
> -	return inode_owner_or_capable(&nop_mnt_idmap,
> -				      file_inode(vma->vm_file)) ||
> +	return file_owner_or_capable(vma->vm_file) ||
>  	       file_permission(vma->vm_file, MAY_WRITE) == 0;
>  }
>  
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
