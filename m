Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BE43806B6
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751614; cv=none; b=kTK3tKa5NE6jY/WW8tgSlHMRQ2n/I8e599s63JGUHAnAUYDUSSH/ztOmgueB1jA/RiafdIrEpM5YtecjXC67KofiX6IgVHcQWSJ3SkEGfiXvUJAAqVsGkECHg9lsEx03ZIyi/Q2i81qIEDIJzmq2o5YoN9Pn2DrWKWEglgTHpPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751614; c=relaxed/simple;
	bh=8FRlLbA9WCFWOMINk88Sk2OsraUDY7vNxZBbAaLNNgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TznKbPF6l+I6kwySvNF/yv/kOyjYp5w1jyrIVVFUQwt2c462YkL2mqO3d+VMbarcB2ZVAjQHiLmkR/slnVbCCsuqftmZDiBTBdwdZ94siJtIRXNrYnU2k0BQMoFxdqR8HxbBG0mlg+4DWmzZtoAIr7lUpzQ9+8vX0OpRGSbIRBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yATYq7ws; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Iryosf8W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hgHtbNQV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PtD6SNPW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yATYq7ws";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Iryosf8W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hgHtbNQV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PtD6SNPW"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD4BC3F5E;
	Mon,  3 Aug 2026 10:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785751607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mIp0J0Cf6G2Gc0vNBn3JQce/ys9BKqGk0T5zMEqiAHE=;
	b=yATYq7wseVBADe2kh54ogtFvo/KsWzolRNX/JxNGoBz/3BCWFVumAWLk/pIryUstT5TJzI
	XgFbfPEzDFuJWuRGzxFBOiicGhhNAH9X+Afi9yIjbBF4qe6VFIgqafXk6YbXO00Bvg3cgY
	xKgjJ6XdxNuYo050jfu7wziBqymZpNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785751607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mIp0J0Cf6G2Gc0vNBn3JQce/ys9BKqGk0T5zMEqiAHE=;
	b=Iryosf8WtmdfRf1TwF/TqguMXwYw8RS/zwYE1X6XcGARNT2xHnAPLx1Qdn+vvACbf45p0j
	VFscpNRe6SMyC4AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hgHtbNQV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PtD6SNPW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785751602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mIp0J0Cf6G2Gc0vNBn3JQce/ys9BKqGk0T5zMEqiAHE=;
	b=hgHtbNQVgfGuZYmxwrnJ2x6UW2kjU5AT3A0Tw/qzvzgODPon7TXBn6gz+HEJ6UH1UHIpOo
	3sMJkjoUGtWwX98DwfX1v7yRC7gdUX/ght0PQh+mwZE/4m3e+FN+K4WDtnaQ50nvuAwqZn
	Yu6U1D8qTSKQ6jxRkkjLmYAAwZUxF9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785751602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mIp0J0Cf6G2Gc0vNBn3JQce/ys9BKqGk0T5zMEqiAHE=;
	b=PtD6SNPWA6cCwCHdtkqplIg/2nYvacGy+gq7XdzqwUOee4Zab+tGKn6r/Dms0zM0Yt5H3B
	q1KnMjApIH5i+bBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDA21779A1;
	Mon,  3 Aug 2026 10:06:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I8DiMTJocGqCQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Aug 2026 10:06:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7697AA13A4; Mon, 03 Aug 2026 12:06:38 +0200 (CEST)
Date: Mon, 3 Aug 2026 12:06:38 +0200
From: Jan Kara <jack@suse.cz>
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] ufs: create the root dentry after loading cylinder
 metadata
Message-ID: <q6zgjx7g3ciaxfbc6wnmgafuc6bsyz53opvljuogfblwxy45hb@nkpbchrwbngx>
References: <20260801071306.59484-1-ali@iusegentoo.com>
 <20260801071306.59484-2-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801071306.59484-2-ali@iusegentoo.com>
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
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,iusegentoo.com:email];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,iusegentoo.com:email,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: DD4BC3F5E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Sat 01-08-26 10:12:57, Ali Ahmet Memis wrote:
> ufs_fill_super() installed sb->s_root before it loaded the cylinder
> group structures for a writable mount:
> 
> 	sb->s_root = d_make_root(inode);
> 	...
> 	if (!sb_rdonly(sb))
> 		if (!ufs_read_cylinder_structures(sb))
> 			goto failed;
> 
> When ufs_read_cylinder_structures() failed, the error path freed the
> in-core superblock information and set sb->s_fs_info to NULL while
> sb->s_root stayed installed. get_tree_bdev() then reached
> deactivate_locked_super(), and because s_root was present,
> generic_shutdown_super() called sync_filesystem() and the put_super
> operation. Both dereference UFS_SB(sb), which is now NULL, so a mount
> that fails only while reading the cylinder groups oopses during
> teardown. A crafted image whose first cylinder group cannot be read
> reaches this path.
> 
> Load the cylinder group metadata first and create the root dentry last,
> so the superblock is published to the VFS only once it is fully set up.
> ufs_setup_cstotal() and ufs_read_cylinder_structures() take only the
> super_block and do not use the root inode, so the reordering is safe.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ufs/super.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ufs/super.c b/fs/ufs/super.c
> index c4831a8b9..7deecb395 100644
> --- a/fs/ufs/super.c
> +++ b/fs/ufs/super.c
> @@ -1199,6 +1199,15 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_maxbytes = ufs_max_bytes(sb);
>  	sb->s_max_links = UFS_LINK_MAX;
>  
> +	ufs_setup_cstotal(sb);
> +	/*
> +	 * Read cylinder group structures
> +	 */
> +	if (!sb_rdonly(sb))
> +		if (!ufs_read_cylinder_structures(sb))
> +			goto failed;
> +
> +	/* create the root dentry last, once UFS_SB(sb) is fully set up */
>  	inode = ufs_iget(sb, UFS_ROOTINO);
>  	if (IS_ERR(inode)) {
>  		ret = PTR_ERR(inode);
> @@ -1210,14 +1219,6 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
>  		goto failed;
>  	}
>  
> -	ufs_setup_cstotal(sb);
> -	/*
> -	 * Read cylinder group structures
> -	 */
> -	if (!sb_rdonly(sb))
> -		if (!ufs_read_cylinder_structures(sb))
> -			goto failed;
> -
>  	UFSD("EXIT\n");
>  	return 0;
>  
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
