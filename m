Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E294014B2
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408013; cv=none; b=omRhVT6kcIDnBp+Ck9uogtBb1QWvQ8gYukQ4ud/5wtvbDdVnkbNbpM8NQ2CXKqadkVxi536D652mUTGUw/qo3j13/wISWn8oAFc0Xw4/kTrMPGRZk1nCc7SBIjG5gxqxJjMkjEjGEzhtgBEkdjOEluokzqPX5NVqI/zColJCMPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408013; c=relaxed/simple;
	bh=/MBlEYvFIICFGTGKTnmazwdW0s2gZZ7HA1j7QnDqoWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeRuRG4DTEo07zF+voifIc2dweWu8HacpXwBqGjpllAtfqLav7NqM1suSJrUUP57Uq0rKvqzJErdS4caoouY0pLcV2WKHWguPnaowoec5NrtBUQN8kKDzx1g/aYvTlhCYUg3ZFy01gNRtTxrYzQsxxkbmoVj6HlrRNTYknakZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cMmib7JZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FpRPKiSv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H86vLXBk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MnWhgLdf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cMmib7JZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FpRPKiSv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H86vLXBk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MnWhgLdf"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBAA77D34F;
	Thu, 30 Jul 2026 10:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785408006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gIpmj/7H1TjHvt3+EIRlO5wljTtBHj40+mJX7NWnxt0=;
	b=cMmib7JZa55H+NMFXGCQKjHUt1M9MaTYuWy3Kw0fov9YjinoYehoF7Krp+Xhmnjdt7XIUw
	g2R8QMX55fgQwJmzevRWbjL1Jn7SsQp3EGSYT6povEVYYLn8vlzNTq9REIAqJ+ZDub+/Xx
	z6GvIaZxNr++rxHJApuK9fKPIQvasjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785408006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gIpmj/7H1TjHvt3+EIRlO5wljTtBHj40+mJX7NWnxt0=;
	b=FpRPKiSvd6FL3NbRBy+WZiNY8xJ3DDzTaO4wWwXlXoiirZ6qpkKILtpG0CTEUorYK8f0BA
	kg+O9nDBzupJWnDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785408001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gIpmj/7H1TjHvt3+EIRlO5wljTtBHj40+mJX7NWnxt0=;
	b=H86vLXBkBqFi0nTvLkuDrT9V3ZJXNBr2anFnv+Zzk+1jOam3woFPborFPbDu1LfbfC/Tbj
	hfqjucY7kzqFrw9KfjayNCtJdvvd/BvVSla0l+SwICE11RX/GuY8rI3wkgEEcfmHzyX/QE
	DrzaGe7ZXkOFk/Vyc1dbCX1QQ9hUZJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785408001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gIpmj/7H1TjHvt3+EIRlO5wljTtBHj40+mJX7NWnxt0=;
	b=MnWhgLdfLI/xMJSSvP0cW/Q3N399IYBJU7rmRaxs2sZjZ8vlJH19vEH/vGn0a0X0YqNLG9
	GVD27RtzXgxjoHBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E27EB779CC;
	Thu, 30 Jul 2026 10:40:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oZdHNwEqa2o9PAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Jul 2026 10:40:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 92590A0AAA; Thu, 30 Jul 2026 12:39:57 +0200 (CEST)
Date: Thu, 30 Jul 2026 12:39:57 +0200
From: Jan Kara <jack@suse.cz>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, stable@vger.kernel.org
Subject: Re: [PATCH] udf: Fix data loss when converting inline inodes to out
 of line
Message-ID: <rso23jqsd7vbgyuppxqdqjldhzczd75tzsn3ubh6pdouilvk2z@zlollakdlgqp>
References: <20260729144547.4028292-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729144547.4028292-2-jack@suse.cz>
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
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 29-07-26 16:45:48, Jan Kara wrote:
> When udf_expand_file_adinicb() converts file from inline format to out
> of line, we use filemap_fdatawrite() to writeout the data to the new
> blocks. However since 36580ed08776 ("udf: Do not allocate blocks on page
> writeback") the writeback actually doesn't allocate the new block and
> the folio dirty bit is just silently cleared. Thus unless the file is
> written to after the conversion (as it can easily happen in case of
> truncate up), the data is just lost. Fix the problem by explicitely
> allocating the block underlying the data before starting writeback.
> 
> Fixes: 36580ed08776 ("udf: Do not allocate blocks on page writeback")
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>

Sorry, this was an old version of the patch which missed prerequisite
moving of udf_map_block() declarations up in the file.

								Honza

> ---
>  fs/udf/inode.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> I plan to merge this fix through my tree.
> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index b8b9b7132115..b5e374f355b2 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -405,6 +405,10 @@ int udf_expand_file_adinicb(struct inode *inode)
>  {
>  	struct folio *folio;
>  	struct udf_inode_info *iinfo = UDF_I(inode);
> +	struct udf_map_rq map = {
> +		.lblk = 0,
> +		.iflags = UDF_MAP_CREATE,
> +	};
>  	int err;
>  
>  	WARN_ON_ONCE(!inode_is_locked(inode));
> @@ -434,20 +438,27 @@ int udf_expand_file_adinicb(struct inode *inode)
>  		iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
>  	else
>  		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
> +	up_write(&iinfo->i_data_sem);
> +
> +	/* Allocate the block underlying the data */
> +	err = udf_map_block(inode, &map);
> +	if (err < 0)
> +		goto restore;
> +
>  	folio_mark_dirty(folio);
>  	folio_unlock(folio);
> -	up_write(&iinfo->i_data_sem);
>  	err = filemap_fdatawrite(inode->i_mapping);
>  	if (err) {
>  		/* Restore everything back so that we don't lose data... */
>  		folio_lock(folio);
> +restore:
>  		down_write(&iinfo->i_data_sem);
>  		memcpy_from_folio(iinfo->i_data + iinfo->i_lenEAttr,
>  				folio, 0, inode->i_size);
> -		folio_unlock(folio);
>  		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
>  		iinfo->i_lenAlloc = inode->i_size;
>  		up_write(&iinfo->i_data_sem);
> +		folio_unlock(folio);
>  	}
>  	folio_put(folio);
>  	mark_inode_dirty(inode);
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
