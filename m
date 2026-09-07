Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6E94582D4;
	Mon,  7 Sep 2026 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778727; cv=none; b=rxtvMQfpllovFwPoRMerosADeKQ/rJT0RXGuua3GHnYM0/YgaIBrl2EV0vUVdK8wx5Nz3bQ4/M1od5EZ0JnNWIoow+M1JxLItH/1GErTs0KI+4Pv3uV2Rq8YwgUavt1isCqoJZoceGhmNLXCfsiPatNMJ/DatPuPuPsTtsXv5So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778727; c=relaxed/simple;
	bh=EkrhXH5scV73aYB6YZZt0Vtwwvc+ZFt63YMtJ31oaek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukqxk3uvH8CiFK/mFft4aSvk5I+1grAIiD3p8uGnMsRjw4tw10zu8XWctd77G/1rVX16jJPW82d0M+kFe0Wsp6fKdoVVOGP7VfHvlSMbYu0nnt8/Vl2ebbqXhCza7VkGSc+cyf1UuWYFdF9YelHxzBjUL8YnFVJxRR9gO8qzzpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JFZvSV2z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=huc143XI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kLmpv+zX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x7QNqunY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JFZvSV2z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="huc143XI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kLmpv+zX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x7QNqunY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D41B71F787;
	Mon,  7 Sep 2026 10:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788778720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+viKHz58Rn8k1rjKXE9mnduA/LwbkUEJxfHpRBN8A1s=;
	b=JFZvSV2zAXUxkxB32ycpKVuSiNiSjCPnZCITHPZt2ZVW/AHKafyl/6sspCHgcyKwf2DR8u
	FVsKsnZ+I9KenY0dw3li+dzmB+bH5dvUcNDKC7Pj1gdmIAq1FiHRZTrWxzXBYgOTri4nDA
	xzeE0ij5B9WE4s8FBMRrDfURcznbRKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788778720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+viKHz58Rn8k1rjKXE9mnduA/LwbkUEJxfHpRBN8A1s=;
	b=huc143XISAhg0SlPG7UcaZRp5fMk8wmFqzg/4PBaJ38ov3T4PPMlesK6Clhl9eIqMPe6ZL
	0lYl61o3f0CBmIBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kLmpv+zX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=x7QNqunY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788778715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+viKHz58Rn8k1rjKXE9mnduA/LwbkUEJxfHpRBN8A1s=;
	b=kLmpv+zXEB5cYWY3IxmkZkZRLw3jy3Wkc4ZU9KyGYw/pORF09Aev+3tQxxl1ZgoclDPnMb
	b7vbtqN2W5uxibFD+ccqkx6kavF1mdi+KtOVRhsoqceS19TCtxlHGcR9/BAkJOnK5CqQYF
	zHCQzZ+4ZDCqBbusqTsMmLZsR/+4WhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788778715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+viKHz58Rn8k1rjKXE9mnduA/LwbkUEJxfHpRBN8A1s=;
	b=x7QNqunYWPxUP2LXLxPsi6lUthYAL5RFQbzyItLvezE1kE/c7d/uY9iccXU0Q3QvioF7Ys
	gGqE7we9Zq9yj+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B50881368D;
	Mon,  7 Sep 2026 10:58:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uPMuLNuYnmqGVAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Sep 2026 10:58:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3EAA4A0B8F; Mon, 07 Sep 2026 12:58:27 +0200 (CEST)
Date: Mon, 7 Sep 2026 12:58:27 +0200
From: Jan Kara <jack@suse.cz>
To: Baolin Liu <liubaolin12138@163.com>
Cc: jack@suse.cz, michael.bommarito@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] isofs: fix Rock Ridge CE extent validation on
 multisession media
Message-ID: <rkarpx2frv53ygu4hye6vpxi6kztw2uiygysx2x4cwrx3jjrtc@guubqalgvowf>
References: <20260907082602.3777551-1-liubaolin12138@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907082602.3777551-1-liubaolin12138@163.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D41B71F787
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,kylinos.cn];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Mon 07-09-26 16:26:02, Baolin Liu wrote:
> From: Baolin Liu <liubaolin@kylinos.cn>
> 
> Commit a36d990f5913 ("isofs: validate Rock Ridge CE continuation extent
> against volume size") compares the CE extent directly with s_nzones.  The
> extent is an absolute block number, while s_nzones is the number of blocks
> relative to the selected ISO session.  The comparison is therefore wrong
> when a multisession disc starts at a non-zero block.
> 
> isofs_get_last_session() selects the last session on multisession
> media, and its volume descriptors describe a volume beginning at that
> session's LBA.
> For example, a session beginning at LBA 45447 with 64 blocks can contain a
> valid CE at absolute LBA 45467.  The existing check rejects that CE, so the
> ER continuation record is not read, Rock Ridge is disabled, and the mount
> falls back to Joliet names.
> 
> Save the selected session start in filesystem-block units and validate the
> CE extent against the half-open interval [session_start, session_end).
> Scale the session length to the same block units and retain a separate
> block-device limit.  The lower bound is intentional: accepting arbitrary
> blocks before the selected session could make a CE read data from a
> previous session or another filesystem on the device.
> 
> Only apply the bounds check when cont_extent is non-zero.  A zero extent is
> the in-memory sentinel indicating that no CE continuation was found, rather
> than a request to read block zero.
> 
> For a single-session image, session_start is zero and the effective volume
> boundary remains unchanged.
> 
> Build-tested with:
> 
>     make CONFIG_RUST= CONFIG_RUST_DRIVERS= fs/isofs/
> 
> Fixes: a36d990f5913 ("isofs: validate Rock Ridge CE continuation extent against volume size")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>

Thanks for the fix! I've taken the patch to my tree. I've slighly cleaned
up the types (use sector_t instead of u64). I've also remove the check
against sb_bdev_nr_blocks() - if anything, we should have check s_nzones
fits within the block device earlier, not in Rockridge parsing code.

								Honza

> @@ -101,11 +107,14 @@ static int rock_continue(struct rock_state *rs)
>  		goto out;
>  	}
>  
> -	if ((unsigned)rs->cont_extent >= ISOFS_SB(rs->inode->i_sb)->s_nzones) {
> +	if (rs->cont_extent &&
> +	    (extent < sbi->s_session_start ||
> +	     extent >= session_end ||
> +	     extent >= sb_bdev_nr_blocks(sb))) {
>  		printk(KERN_NOTICE "rock: corrupted directory entry. "
>  			"extent=%u out of volume (nzones=%lu)\n",
>  			(unsigned)rs->cont_extent,
> -			ISOFS_SB(rs->inode->i_sb)->s_nzones);
> +			sbi->s_nzones);
>  		ret = -EIO;
>  		goto out;
>  	}
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
