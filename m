Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B937C3F8EDB
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785150806; cv=none; b=B58e8kXUrPeYvCJOWhYlwQHPpVzm5aGtrJNAhVfG53e0Iw7AFD7ZhmZmmt87b8SAgDDKbkUf0IfQfFMcQknkJ03qcGLM9HexVeznaE4uaaQHqndjoZFwtGc/P8EHkRh9Qng5g/PJmDx8goqY+jelv5hZ18OURJW7aW4A3PB+5Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785150806; c=relaxed/simple;
	bh=4viYh8myA6ITujs9QzMZTEso5RC4FGcB67zcjDDwhAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmB4groNN5yG6u/SCaEEEAq0onWqMLMhcgZEPmEiAXnFNJWXAqGhwAXZtcIoiMD3AXx5jWg08yMQT8/Dnc27NNvXBk/bIFHODQnKbv/Q4I/9nC6YHrVHDdTg3JKJL+xWlFs2UKXyuvKEJ5EwmUIWwECnAomYb+hbUVDsYJ3AJFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nPK4r+5o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fdl22dk+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2muCLxOB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R00dPWmR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nPK4r+5o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fdl22dk+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2muCLxOB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R00dPWmR"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 452607DAED;
	Mon, 27 Jul 2026 11:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785150797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lPCBgkNGCALXfGpN88n4wCcsCgDMJuqH3Bklhb+BsGw=;
	b=nPK4r+5oplLQUphpg5bwwa8rKvzD63VZ0NMHpEd/NkVrsjg0pfUIvBdD+eIvEG4b/lfDxr
	JdAf7/Csp/DBkFuqTP+AgF+loMJJdDiRxU8bCgTKEUzJJKuJQyX57YYZZRYaRfde4kYof5
	AiKIDVAE1b7IYPA8en5dltTjLTMpR/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785150797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lPCBgkNGCALXfGpN88n4wCcsCgDMJuqH3Bklhb+BsGw=;
	b=fdl22dk+Ff00wiEe/5OjsoZmLDqCX2Hbvkmiorv60Za6b+OHfJ2ngkuJfOpjjJkDA3aSPH
	GCavNRHpDo/7vwAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2muCLxOB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=R00dPWmR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785150793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lPCBgkNGCALXfGpN88n4wCcsCgDMJuqH3Bklhb+BsGw=;
	b=2muCLxOBt0B3OgeqFmv0Egdydkus3klEWcFu3bowacDrV6g8ouAPlgzPvYq8OY1psxiRi1
	rDv98U4BsKMFZbGhaSY+u9wx/RXSq5JiQIYeQJg9km2yr9pbk7qIdcSVZVW/S9kN5XU/JZ
	JJlUn0NsMdL4NTGrLAQawPnK8Ig9NME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785150793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lPCBgkNGCALXfGpN88n4wCcsCgDMJuqH3Bklhb+BsGw=;
	b=R00dPWmR0LEYiwy1KO3nEZCtLrRXTmKVGrhSdhNRtNEpnmkTTe/R76dnvaD6vlII7icKrl
	LbTmpMtyVhglEJBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C5E3779C1;
	Mon, 27 Jul 2026 11:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MTy9Dkk9Z2oDBAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 Jul 2026 11:13:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D66A4A0BA1; Mon, 27 Jul 2026 13:13:08 +0200 (CEST)
Date: Mon, 27 Jul 2026 13:13:08 +0200
From: Jan Kara <jack@suse.cz>
To: YANXIN LI <fadouse@pm.me>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	security@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ufs: use u64 for directory size in ufs_last_byte
Message-ID: <nweqpdbynd5dv6xq3yiqbo7s6cohpah2sibax4uy2qw7cq4u2i@ronvk3vrv4sb>
References: <20260718190300.867109-1-fadouse@pm.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718190300.867109-1-fadouse@pm.me>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 452607DAED
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Sat 18-07-26 19:03:07, YANXIN LI wrote:
> ufs1_read_inode() and ufs2_read_inode() copy the untrusted 64-bit
> on-disk size into inode->i_size.  ufs_last_byte() then truncates that
> value to an unsigned int before calculating the valid extent of a
> directory folio.
> 
> A directory size of exactly 4 GiB is truncated to zero.  In
> ufs_find_entry(), subtracting the requested record length from that zero
> forms an endpoint almost 4 GiB beyond the mapped folio.  A crafted UFS2
> image produces:
> 
>   BUG: KASAN: use-after-free in ufs_find_entry+0x583/0x6e0 [ufs]
>   Read of size 1
>   ...
>   ufs_find_entry
>   ufs_inode_by_name
>   ufs_lookup
>   __lookup_slow
>   path_lookupat
> 
> The KASAN classification reflects that the adjacent physical page was
> free; the source-level operation is an out-of-folio read.  A controlled
> UFS1 test with CONFIG_UFS_FS_WRITE enabled also made ufs_find_entry()
> return a directory entry from an adjacent anonymous page.  unlink() then
> passed that pointer to ufs_delete_entry(), which cleared the adjacent
> page's 3
> 2-bit d_ino.  This write result reproduced three out of three
> times.
> 
> UFS normally requires a privileged mount path.  A relevant boundary is
> a privileged automounter or image-processing service handling an
> attacker-supplied filesystem.  The write primitive additionally requires
> UFS1 to be mounted read-write with CONFIG_UFS_FS_WRITE enabled; the read
> is reachable with read-only UFS2.
> 
> Keep the intermediate size arithmetic at 64 bits so non-final pages are
> bounded at PAGE_SIZE.  With this change, the same controlled tests reach
> the real on-disk directory entry and produce no adjacent-page write or
> KASAN report.  A reproducer and full validation logs are available on
> request.
> 
> The vulnerable helper is present in v7.2-rc3, v7.1, v6.18.38, v6.12.95,
> v6.6.111, and upstream master at 1229e2e57a5c.  Runtime reproduction and
> fix validation were performed in an x86-64 QEMU guest running v7.2-rc3
> with generic KASAN.
> 
> Fixes: b71034e5e67d ("[PATCH] ufs: directory and page cache:
>  from blocks to pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: YANXIN LI <fadouse@pm.me>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ufs/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
> index e62fe5667..69e6d5535 100644
> --- a/fs/ufs/dir.c
> +++ b/fs/ufs/dir.c
> @@ -213,7 +213,7 @@ static void *ufs_get_folio(struct inode *dir, unsigned long n,
>  static unsigned
>  ufs_last_byte(struct inode *inode, unsigned long page_nr)
>  {
> -	unsigned last_byte = inode->i_size;
> +	u64 last_byte = inode->i_size;
>  
>  	last_byte -= page_nr << PAGE_SHIFT;
>  	if (last_byte > PAGE_SIZE)
> 
> base-commit: 1229e2e57a5c2980ccd457b9b53ea0eed5a22ab3
> -- 
> 2.54.0
> 




-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
