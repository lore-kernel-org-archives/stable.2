Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792665501;
	b=cOfx/0wan1U4sqAEhmGUlhJhohIuC/3nonkzivHkQjquooWN5PFXnSfA+hRa3jy/snvI
	 brJHY9BJT7/iXQZleN4bZa+6CNCDNaWjiWvSixaK2Ilw26s/1R15PGUo2dfSkyue5s6MH
	 VWCxW4bTfnFZlt84ji53mQalLigvHwepsQB8wbUzmE4iBpj6se6HiSHx5JI6F5WtW3nRD
	 IGomSVRw1S9FD5pDxovHZ/ePgEkfB2OXKwda+Q1drxADKXpYCvoXrh2z/ZGQha7Zr0owC
	 UKAHXudzmdg9keXm5b9AQc2EWtaaMf2fjDEmSHBbdg9Ceh4PS9kCE5aZZbLlDzfUpvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792665501;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=41JCmBNS/gSKFEfwkqTpoi94vQPWz5Cux+SoBsWvcng=;
	b=07FM7Rgd8t6SjdYcVD0Xp6TqFGCRhLgroNhCyNJUskHoVd4g4iopV4OfJjjeVqO9iRK7
	 sq1ZxZiPREzo8BpygqIk+6DUTI++kUBZjErs4ReObnaz/ncgL1rXmsCjzyF3YGc3BLMBo
	 Qd07QksMm2gG3x2EqWyADzbFlaYcIY+ullf9u43YB+7Agb6u6qQXNYTi4OAhMJCHwWZTx
	 cikiu8xuxNlDgE9Cnatel7ffkUXlXOX8N3MM75XoOMYa/sUri7HTbBiKITDPxPx43DeJe
	 yWbrUyxrYvUSGxin97wdcD8HHzpXALvi6iFXPwvWvD0XLUu8pF7QpylBIGGt2J3poMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qpRo+Ndf;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vzsXiGCn;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qpRo+Ndf;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vzsXiGCn;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267D0606A319;
	Thu, 22 Oct 2026 10:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 267D0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qpRo+Ndf;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vzsXiGCn;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qpRo+Ndf;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vzsXiGCn
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3AADB21E60;
	Thu, 22 Oct 2026 10:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792665499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41JCmBNS/gSKFEfwkqTpoi94vQPWz5Cux+SoBsWvcng=;
	b=qpRo+NdfJguJX/4UdEB5jnRpJ0vqvO+TmrdFLmqZXaoZCFDKXQu31qxzuTkXKsCI0EbAJu
	yVbkTalFaQ109OfxY9d6AvJosssHkPZSPAeEBi9PO4Q37x4FWaHJBwQcntaav+IF5ZSk29
	mgEcsxaMLPV5KWsGTsIMhShnrZYfFRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792665499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41JCmBNS/gSKFEfwkqTpoi94vQPWz5Cux+SoBsWvcng=;
	b=vzsXiGCnkscRboT2utBQ0qsWW9aSXO8jPVesTsrULdHyG/lQJuBIWswIDCRAr4h8FcPSTK
	Pwtm02tr5khyQ9Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qpRo+Ndf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vzsXiGCn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792665499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41JCmBNS/gSKFEfwkqTpoi94vQPWz5Cux+SoBsWvcng=;
	b=qpRo+NdfJguJX/4UdEB5jnRpJ0vqvO+TmrdFLmqZXaoZCFDKXQu31qxzuTkXKsCI0EbAJu
	yVbkTalFaQ109OfxY9d6AvJosssHkPZSPAeEBi9PO4Q37x4FWaHJBwQcntaav+IF5ZSk29
	mgEcsxaMLPV5KWsGTsIMhShnrZYfFRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792665499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41JCmBNS/gSKFEfwkqTpoi94vQPWz5Cux+SoBsWvcng=;
	b=vzsXiGCnkscRboT2utBQ0qsWW9aSXO8jPVesTsrULdHyG/lQJuBIWswIDCRAr4h8FcPSTK
	Pwtm02tr5khyQ9Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DC13134E6;
	Thu, 22 Oct 2026 10:38:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R6FDNprn2WpjNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Oct 2026 10:38:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8C84BA1417; Thu, 22 Oct 2026 12:38:18 +0200 (CEST)
Date: Thu, 22 Oct 2026 12:38:18 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 11/15] super: keep the read-only state if a
 reconfiguration doesn't change it
Message-ID: <h4njmihez4imvzmmpl6zqyxys6hedwzhukidmpp4ba52oxei4c@g25ohxttylap>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
 <20261011-work-super-fixes-core-v1-11-c727176c5b53@kernel.org>
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
In-Reply-To: <20261011-work-super-fixes-core-v1-11-c727176c5b53@kernel.org>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 3AADB21E60

On Sun 11-10-26 17:56:11, Christian Brauner wrote:
> fspick() creates a reconfiguration context with an empty flag mask. Only
> setting "ro" or "rw" adds SB_RDONLY to it. reconfigure_super() honours
> the mask and leaves SB_RDONLY alone otherwise. But a lot of filesystems
> decide in their ->reconfigure() whether to go read-write by comparing
> fc->sb_flags & SB_RDONLY with the current state of the superblock and
> ignore the mask: affs, befs, btrfs, efivarfs, ext4, fat, gfs2, hfs,
> hfsplus, hpfs, isofs, jffs2, jfs, minix, nilfs2, ntfs, ntfs3, ocfs2,
> overlayfs, ubifs, udf, ufs and xfs. mount(2) always puts SB_RDONLY into
> the mask so that never mattered for it.
> 
> So reconfiguring a read-only superblock through fspick() without "rw",
> e.g., to change an unrelated option or with no option at all, makes
> these filesystems go through their read-only to read-write transition.
> For ext4 and btrfs that ends with a read-write superblock that writes to
> the device and can be written to through any read-write bind mount:
> 
>   EXT4-fs (vda): re-mounted 68db7463-95cb-47f9-ab87-d1fd35252958 r/w.
> 
> Fill in the current read-only state when the mask doesn't cover it.
> reconfigure_super() is called with s_umount held so that can't race with
> another reconfiguration. Doing it when the context is created would.
> 
> Fixes: cf3cba4a429b ("vfs: syscall: Add fspick() to select a superblock for reconfiguration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Yeah, this is a bit of a workaround for slightly broken conversions to the
new mount API but given how widespread this is I think it is a sensible
choice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/super.c b/fs/super.c
> index ac4c4d067509..edd5648d1720 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1077,6 +1077,14 @@ int reconfigure_super(struct fs_context *fc)
>  	if (sb->s_writers.frozen != SB_UNFROZEN)
>  		return -EBUSY;
>  
> +	/*
> +	 * Filesystems take fc->sb_flags & SB_RDONLY as the read-only state the
> +	 * superblock ends up in. If that isn't being changed, e.g., fspick()
> +	 * without "ro" or "rw", it's the current one.
> +	 */
> +	if (!(fc->sb_flags_mask & SB_RDONLY))
> +		fc->sb_flags = (fc->sb_flags & ~SB_RDONLY) | (sb->s_flags & SB_RDONLY);
> +
>  	retval = security_sb_remount(sb, fc->security);
>  	if (retval)
>  		return retval;
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
