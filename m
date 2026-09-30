Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1404D1781;
	Wed, 30 Sep 2026 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767769; cv=none; b=IwhAkr0adXjrdk6P1Pj6Zrv8uLdzlmpYIQCNdp64tmbxpZRyXQK7f4P/JpJrrVGCJG2OFEGTWKk/zeQ3WccA9x7LQ1W8Ory0f6W+UrF/nNEzmSEvzIY6REX+/A1hUORPSRnq7flEIBpd4Vl+sk6RU7GJO6BmxBR22GYzYbl8lCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767769; c=relaxed/simple;
	bh=Y+YqHRTyQd67P+coEMZYjNTxVdlkJ+wHPGQuPRvSz1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PD5FArJRhfso3RPLKc398/mJ0p7Qyz1mjG1HYUMcY/9ZtXBrErCim0fvVs2Z6Ej38hoysHqlg/gAHQoz4RRTD+ZxpJ8izNaFqQ9JaMEr/Umg2I+aYZYnSX3sZwTQZpwPygLtA6fyT/jrvlyBOZKsdYWQpU/Rzm+duiUTjghTeqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C1yQtHZq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iNpY1vID; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p3i3HRQT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G5ppi8Fg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C1yQtHZq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iNpY1vID";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p3i3HRQT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G5ppi8Fg"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B5A91F88D;
	Wed, 30 Sep 2026 11:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790767755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=czHfmONilSqBZ5eKgfPANF0ary+HpblwUS8HlTqFfi0=;
	b=C1yQtHZquN5QPzok5t64LFf9KwbY6XIQwXiEmal7JWvGMcgwGYIjKO1paeDxTYnTgHSgeI
	5p9kPiMy1Uy8D80gwoKX6Z5IJKO5F7Uf4bLY0lxWMtTvJTG+yTxGlBDC4UOvGa3JNdDRce
	iB2dUM0GL17iSTEbyxfYn5cAD3NlReo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790767755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=czHfmONilSqBZ5eKgfPANF0ary+HpblwUS8HlTqFfi0=;
	b=iNpY1vIDfVPm9i2IfUMs+QFipq+nv4ASUbZ6QEgdDHv6umXyDiXOOIXsroAujy7KNf4QWk
	ljGvzLOAoAEhBUAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790767751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=czHfmONilSqBZ5eKgfPANF0ary+HpblwUS8HlTqFfi0=;
	b=p3i3HRQTcwxFvYducP7oYeUievk3BvWGevzVzbJam/2I2CpExwPlEA7Px6PbkqBACW3YlB
	KrtelWcEkpTBPQG7UILyNYkiDXkYEyTwKMC+4YScAIkTvC2v70n46Z7vf24+3+iECGIVJw
	kGh76IqtkxwJTHIPuxm0V5usWVldj3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790767751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=czHfmONilSqBZ5eKgfPANF0ary+HpblwUS8HlTqFfi0=;
	b=G5ppi8Fg0IvFPrU0LHm5mYDpPzYVMcUA1fcH2Mq6RdykfD5qEkxeW4NcrxTsEheiHC3XQU
	dO0R7dQd7/FPqEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5571B13722;
	Wed, 30 Sep 2026 11:29:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n78LDIfyvGpfOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 30 Sep 2026 11:29:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CCC4EA13AD; Wed, 30 Sep 2026 13:29:10 +0200 (CEST)
Date: Wed, 30 Sep 2026 13:29:10 +0200
From: Jan Kara <jack@suse.cz>
To: Giorgi Kobakhia <gkobakhi@asu.edu>
Cc: Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, 
	Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Subject: Re: [PATCH] udf: fix return value for non-recorded-allocated extents
 in udf_map_block()
Message-ID: <hyp53lrzwckzp2sblhciocql4sidxvk2ujhc4zml2r72i2qkwv@ospm4msdwrto>
References: <20260928200445.18722-1-gkobakhi@asu.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928200445.18722-1-gkobakhi@asu.edu>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,epos.bh:url,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Mon 28-09-26 13:04:45, Giorgi Kobakhia wrote:
> In the if (!(map->iflags & UDF_MAP_CREATE)) check the ret is set to
> inode_bmap(inode, map->lblk, &epos, &eloc, &elen, &offset, &etype),
> which returns 1 on success, -errno on error and 0 on EOF. ret is set
> back to 0 only if the etype of the extent is EXT_RECORDED_ALLOCATED.
> In other cases the ret is still equal to 1, which is not a valid return
> value for udf_map_block() and is later accessed in page_get_link().
> 
>  Oops: general protection fault
>  KASAN: maybe wild-memory-access
>  RIP: 0010:page_get_link (fs/namei.c:6503)
>  Call Trace:
>   vfs_readlink (fs/namei.c:6419)
>   do_readlinkat (fs/stat.c:583)
>   __x64_sys_readlink (fs/stat.c:605 fs/stat.c:602 fs/stat.c:602)
> 
> Move the reset to 0 line outside the if, so udf_map_block() returns either
> 0 or -errno, even if the extent type is not EXT_RECORDED_ALLOCATED.
> 
> Fixes: c226964ec786 ("udf: refactor inode_bmap() to handle error")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Tested-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Giorgi Kobakhia <gkobakhi@asu.edu>

Thanks for the fix! I've just rewritten the changelog to explain this can
happen only for corrupted filesystems and added the fix to my tree.

								Honza

> ---
>  fs/udf/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index e45e546a739a..2f04c4f0e1b8 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -372,8 +372,8 @@ static int udf_map_block(struct inode *inode, struct udf_map_rq *map)
>  			map->pblk = udf_get_lb_pblock(inode->i_sb, &eloc,
>  							offset);
>  			map->oflags |= UDF_BLK_MAPPED;
> -			ret = 0;
>  		}
> +		ret = 0;
>  out_read:
>  		up_read(&iinfo->i_data_sem);
>  		brelse(epos.bh);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
