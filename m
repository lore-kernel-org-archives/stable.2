Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16043BB68F;
	Mon, 12 Oct 2026 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791797910; cv=none; b=lIYyS/dPx/NUyfdYrrTkm5lLrmEH7277deaF/cpIduAgG2blx/zcRax4PvR3iKHnAKGkXpDkND7oFWL9unJ+73PON8DtfcpU0BKvM6U0w/s6m7K1MGubX+d/h2HdTu5EiAppq89ET9FpAUEM8LLiFgBvHFR9KrLuFkwRPEEZgvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791797910; c=relaxed/simple;
	bh=tfbFnAU+bkfMyVOGrALjDaWvKjqRTuArOAIj34eUUO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPN39D4Fd494Kd5eyZgWI7Fj9c8Ke6zUTLg+n1AhSUN6yxVsjozw6gmDCqazegXE5Z9fQUE5or0oW89bYwu5Hch7o0OJjo2TxwhwULD4sezMR0sVm+01NA6GkIhXgTQMCNG0VAdQvvnRJRjXT8X7Te859gFl0H4JXkBRS6nFXrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YoJuOtRL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qc3PUMzI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jBvpIfag; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RzBeEw0C; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YoJuOtRL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qc3PUMzI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jBvpIfag";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RzBeEw0C"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C4B021DFB;
	Mon, 12 Oct 2026 09:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791797906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kg1XO9faP6m/0SQ0V7ZFc78dVzs5U9T2ADjMTseWY8Q=;
	b=YoJuOtRLPgh7f9CbXokLXvzdhWKhzjqBlnoKGbBdQ2JFfo5v6bHzZqfF3ssrwLSFxpmeMf
	S4DW2FMmIXpecJOfF0nR97pcWGAd6H16WoccOxqdLe8VAPvA2lKlgndgjVwufvrceMYQNh
	mTA6YGXv/eYFMMMGiZjIGJxfP15l6wY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791797906;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kg1XO9faP6m/0SQ0V7ZFc78dVzs5U9T2ADjMTseWY8Q=;
	b=qc3PUMzIZdRUvmkFX5yMIvkOt1BCm4OSqtnP7bOa5Nr0IXlAsxHow1k47xh8ElUhwuTbTt
	Xscz2vfer4lh8iBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jBvpIfag;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RzBeEw0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791797904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kg1XO9faP6m/0SQ0V7ZFc78dVzs5U9T2ADjMTseWY8Q=;
	b=jBvpIfagC8+JRjzlAttwUE8YIgln3zHFXhf9IsjhBcll+k3u9GNlXPolhkO4u1PP85Z5hY
	TUl/8mBKyLyqYYV0FRrNb3cTukjTSpV1VR26p5pas6xj4mMfAWVjODWkQze95jrCxNsmIJ
	zdIUBH79iDepCo6E/PKuyMnXDZ++Ed4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791797904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kg1XO9faP6m/0SQ0V7ZFc78dVzs5U9T2ADjMTseWY8Q=;
	b=RzBeEw0C8Lhoivs5CAGhjdOHh77P0kP84OlOsbNGbTTmYBf7bIgGzxSqDGms1qUgRsSFov
	rUsfpc/ZMyD+pqCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73A5313314;
	Mon, 12 Oct 2026 09:38:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GTppFJCqzGqZcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 Oct 2026 09:38:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 05E1EA1403; Mon, 12 Oct 2026 11:38:20 +0200 (CEST)
Date: Mon, 12 Oct 2026 11:38:19 +0200
From: Jan Kara <jack@suse.cz>
To: Nikolaos Karaolidis <nick@karaolidis.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs: don't lose inodes that another LRU walker is
 isolating
Message-ID: <zec4khbtx7uap5swffdwxfesiz7as3ey5ulzyruwbztqfpymzs@n5t4xbsoz6c6>
References: <20261009142431.713875-1-nick@karaolidis.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009142431.713875-1-nick@karaolidis.com>
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,karaolidis.com:email,suse.cz:email,suse.cz:dkim];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,huawei.com,gmail.com,vger.kernel.org,kvack.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,karaolidis.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Rspamd-Queue-Id: 9C4B021DFB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Fri 09-10-26 14:24:31, Nikolaos Karaolidis wrote:
> When inode_lru_isolate() finds an unused inode that still has page
> cache, it sets I_LRU_ISOLATING, drops i_lock and the list_lru lock,
> invalidates the page cache, clears the flag again and returns
> LRU_RETRY so that the restarted walk can free the inode.
> 
> Another walker of the same list can reach the inode in that window.
> It sees a non-zero i_state and takes the inode off the LRU, as it
> would an inode that is in use. Page cache deletion requeues the inode
> once the mapping is shrinkable, so this is harmless if it happens
> before the last deletion. If it happens after, nothing puts the inode
> back: it stays in memory, unused, clean and without page cache, out
> of reach of the shrinker and of drop_caches, until it is looked up
> again or the filesystem is unmounted.
> 
> Before commit 2a0629834cd8 ("vfs: Don't evict inode under the inode
> lru traversing context") the pin was an i_count reference, and the
> final iput() put the inode back on the LRU.
> 
> Skip inodes that are being isolated and leave them to the walker that
> pinned them, which restarts its walk once it has unpinned them.
> 
> The window is reached by any unused inode with page cache on
> CONFIG_HIGHMEM kernels, and otherwise by inodes whose page cache is a
> single shadow entry at index 0. On an i386 HIGHMEM guest, eight
> concurrent "echo 2 > /proc/sys/vm/drop_caches" over 2000 freshly read
> one-page ext4 files leave roughly 400 of the inodes off the LRU per
> round; on x86_64, with the files' pages first evicted through
> memory.reclaim, 3 to 4 per round. With this patch, none in either case.
> 
> Fixes: 2a0629834cd8 ("vfs: Don't evict inode under the inode lru traversing context")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Nikolaos Karaolidis <nick@karaolidis.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Found while working on reclaim of inodes pinned by page cache in
> ZONE_MOVABLE.
> 
> Tested on master af32da41b032 (v7.3-rc6-232) in QEMU/KVM with a small
> stress program: mount an ext4 image, read 2000 one-page files, run 8
> concurrent "echo 2 > /proc/sys/vm/drop_caches", drop caches again
> single-threaded (2, then 1, then 2), and count the filesystem's inodes
> still in memory via how many the umount frees:
> 
>   i386 HIGHMEM:      ~390 of 2000 lost per round without the patch
>                      (3 runs x 20 rounds), 0 with it
>   x86_64, pages evicted through memory.reclaim first (single shadow
>   entry left):       ~4 per round without, 0 with
>   x86_64 with KASAN, PROVE_LOCKING, DEBUG_VM, DEBUG_LIST:
>                      6109 lost in 50 rounds without, 0 with, no splats
> 
> The reproducer is a single C file run as init; I can post it if useful.
> 
> I went with skipping the inode rather than requeueing it on unpin
> (which would be closer to what the final iput() did before
> 2a0629834cd8) because it avoids the remove/re-add and leaves the inode
> where the pinning walker finds it again. Happy to switch if preferred.
> 
> Jan, this applies cleanly before or after "fs: Basic infrastructure for
> offloading inode reclaim" (v2 3/5); happy to rebase onto that series if
> you'd rather take it there.
> 
> For stable: 6.18 and older need inode->i_state instead of
> inode_state_read(). I have only tested master.
> 
> An LLM was used to check the analysis against the code, write the
> reproducer and draft the changelog; I have reviewed all of it.
> 
>  fs/inode.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index a9d37be390a1..74dfc379b377 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -942,6 +942,12 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>  	if (!spin_trylock(&inode->i_lock))
>  		return LRU_SKIP;
> 
> +	/* Another walker is dropping its page cache, leave it to that one */
> +	if (inode_state_read(inode) & I_LRU_ISOLATING) {
> +		spin_unlock(&inode->i_lock);
> +		return LRU_SKIP;
> +	}
> +
>  	/*
>  	 * Inodes can get referenced, redirtied, or repopulated while
>  	 * they're already on the LRU, and this can make them
> 
> base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
> --
> 2.55.0
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
