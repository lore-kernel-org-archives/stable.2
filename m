Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F6F346A04
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994806; cv=none; b=iWnN1nOhDFGicvnUi0XbXS9yi0mpi3wSsg6+MUDiGD3eNzuHldVdFw5Km45h3aSVHGmDsRZysCC/guyWL0BR3zUJL7YoKAUVk+G6tU7mF5Tvtx+APf8dJuA27NTIddkwT+yRI2sJ6kCya/F0zRlKvfAg0cwFIoRlOvZHl6vYX8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994806; c=relaxed/simple;
	bh=LRvwKo+qnU53CopQyDWdwxmCysOcs2U49k8qwQikoYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+PFPTjuR223iLFEzUA6gorjNxsnpxsg3hm/IVez78y6uBVb7yrTvRkh76YE6yz46nKXXx0q+R2IsifTJgfM8eKbJg9LpHHySIadVmO69e7vp1954aTCD2UYjLXmYstMkMO4LMDKRi5VPCRNMUYBtXCSsf6iLEVZr7VUbTgJdMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iifc0pdL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EvEGavgP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y9Kd2cpH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8s7K2iF7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iifc0pdL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EvEGavgP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y9Kd2cpH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8s7K2iF7"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 409446A7D5;
	Tue,  9 Jun 2026 08:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780994803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SkwgUno5OVjg29hLYJfsk0E2z8CzY6794Poai6l+Syg=;
	b=iifc0pdLEJFFz7v/nTbIvZHa0aSmahb6nKmAc4JRUnbwNn9QaHqbdA0XFQj2oRrUVJ6Ywq
	fXfttPOuSZO3+B6b2S/x/80dZYPGFCgWGcu4ok9kxKlxXZ+qKVJrXg3erC/3vxjJuz0QjR
	smJS8VKQzCN/tGzKIds6ThXcFGQHOso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780994803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SkwgUno5OVjg29hLYJfsk0E2z8CzY6794Poai6l+Syg=;
	b=EvEGavgPfqnRsj+bigCqM6Nre3O4jhxk2gVNy46rYQtMxClruQlhTfICwsRCfChXJxTSwn
	kRA5R5H+A20BpcBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=y9Kd2cpH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8s7K2iF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780994799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SkwgUno5OVjg29hLYJfsk0E2z8CzY6794Poai6l+Syg=;
	b=y9Kd2cpHerZ3l4p8U1BCmKTQtSyWENzbZAsreFaiCeAdtHXYhk/30v/l/qZDBQZUfyxbe9
	RV6WLmQoKYEtlBwsBd7ZZvnXt1t3Kc6KiR5dMaoZIqNtE/u1kZKz75l9Z4nfleNzC7Pb2l
	5Vzho73fdJ+7mSEiFfbl7DdNvWgUwIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780994799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SkwgUno5OVjg29hLYJfsk0E2z8CzY6794Poai6l+Syg=;
	b=8s7K2iF76Cm36PZHMJRIknZM58rOeOSYodxzyzZvuCd2izMaAMudwtzN4KAWHqUhNELa6M
	TjDt8cHOL3HYDgDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34C98779A7;
	Tue,  9 Jun 2026 08:46:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r93dDO/SJ2qNdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 09 Jun 2026 08:46:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BB4F5A0A90; Tue, 09 Jun 2026 10:46:38 +0200 (CEST)
Date: Tue, 9 Jun 2026 10:46:38 +0200
From: Jan Kara <jack@suse.cz>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, 
	Kees Cook <kees@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Chia-Lin Kao <acelan.kao@canonical.com>, Benjamin LaHaise <bcrl@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	linux-aio@kvack.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] libfs: set SB_I_NOEXEC and SB_I_NODEV by default
 in init_pseudo()
Message-ID: <c2upjkd7boexrdqi4t2i7tcm36mdjo3nz6p4js4heyhb7xjp5e@pkhjld3pafvu>
References: <20260604025315.245910-1-jhubbard@nvidia.com>
 <20260604025315.245910-2-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604025315.245910-2-jhubbard@nvidia.com>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[nvidia.com:email,infradead.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:email,suse.cz:dkim];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[24];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,gmail.com,canonical.com,kvack.org,linux-foundation.org,redhat.com,linaro.org,amd.com,kernel.dk,vger.kernel.org,lists.freedesktop.org,lists.linaro.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,infradead.org:email,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 409446A7D5
X-Spam-Score: -2.51

On Wed 03-06-26 19:53:14, John Hubbard wrote:
> Since commit 1e7ab6f67824 ("anon_inode: rework assertions"),
> path_noexec() warns when an anonymous-inode file is mmap'd from a
> superblock that has not set SB_I_NOEXEC. dma-buf backs its files this
> way and never set the flag, so mmap of any exported buffer trips the
> warning on a CONFIG_DEBUG_VFS=y kernel:
> 
>   WARNING: CPU: 11 PID: 121813 at fs/exec.c:118 path_noexec+0x47/0x50
>    do_mmap+0x2b5/0x680
>    vm_mmap_pgoff+0x129/0x210
>    ksys_mmap_pgoff+0x177/0x240
>    __x64_sys_mmap+0x33/0x70
> 
> init_pseudo() sets up internal SB_NOUSER mounts that are never
> path-reachable. Set both flags here so every pseudo filesystem gets
> them by default instead of each caller setting them.
> 
> SB_I_NODEV is inert for unreachable mounts. SB_I_NOEXEC has one
> visible effect: an executable mapping of a pseudo-fs fd, such as a
> dma-buf, now fails with -EPERM, which is the invariant the assertion
> enforces. No in-tree caller maps these executable.
> 
> Reproduce on CONFIG_DEBUG_VFS=y:
> 
>   make -C tools/testing/selftests/dmabuf-heaps
>   sudo ./tools/testing/selftests/dmabuf-heaps/dmabuf-heap -t system
> 
> Fixes: 1e7ab6f67824 ("anon_inode: rework assertions")
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/libfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 1bbea5e7bae3..e8226b9e1bc8 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -736,6 +736,7 @@ struct pseudo_fs_context *init_pseudo(struct fs_context *fc,
>  		fc->fs_private = ctx;
>  		fc->ops = &pseudo_fs_context_ops;
>  		fc->sb_flags |= SB_NOUSER;
> +		fc->s_iflags |= SB_I_NOEXEC | SB_I_NODEV;
>  		fc->global = true;
>  	}
>  	return ctx;
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
