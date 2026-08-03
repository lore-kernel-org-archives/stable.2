Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047D376A0A
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751833; cv=none; b=EfRozcr1XbR8sLCkz4jKEUlIuIl7JJ/2196GTKsjlLzm+RuSFeJDuqwlhnSn8ltp7sKGgmXyOG+yZkKL5/EFa3zarDQNkZ/pRvbekzXtqlGwRIXnBeRfi0FUJjz4wet00Kzib8ZtBdqaEu6mTZesvp0AIldsDmRguqmYGoync9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751833; c=relaxed/simple;
	bh=6H/FC0av6p39mNjIw5d+m54NfFgH0VpsV7GQqp7fLGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rM4MX+m1pM4Sl1ocqf61+2RuJHAqf1t7I0M66pj4uvTVbyMVUtb3oBNerh6MkhkEo3r/0WQ8rn/GEUxgvQ8czRXVOPV0skOa+r3iVT5M3+j02dG+1uy3uArtwGejQe+NiOLUW06DbccsnZTUzguqKphpJN1993p86h9FE8vahPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s5g6BQvV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hmlAv1mD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CYkyq0tv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xk/l9XTT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s5g6BQvV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hmlAv1mD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CYkyq0tv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xk/l9XTT"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 752233FBC;
	Mon,  3 Aug 2026 10:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785751825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CJy+2EF3Dhy7TWltT4LTBFxglCjp/1DLAObwpS2vbxU=;
	b=s5g6BQvVZG8RDe3yt65d4JQZ6C59PLnSSIM4/BfX1l9oDaQSjQfVrkSLW9IuUXD94MapKm
	RqiPnVwVBlbD5KIrKOlYOJPoyxLY/FlxTbcGZb4urZAbA11NvHJWOc2C0x/JLkxSGIXK1B
	vphLoBmy6bHec4B9KxeZL4fD1oLBnpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785751825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CJy+2EF3Dhy7TWltT4LTBFxglCjp/1DLAObwpS2vbxU=;
	b=hmlAv1mDsn8WmBWPwYuO58lUDV78JYGXHRXOfxhwZSxSLH14PmjKPWstZ2Ilknw14S1SQe
	rhjJ1oeXyT1/xbDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CYkyq0tv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Xk/l9XTT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785751821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CJy+2EF3Dhy7TWltT4LTBFxglCjp/1DLAObwpS2vbxU=;
	b=CYkyq0tviSrq1b1LRYdKuIGhYsB62sbi17BNyQue5Q72VmkFvqP6vhuDM0XRgcsodzv96E
	MztRq+aB/0gSC+GuRvNClM5objHgnXOaEMvu2ep+jowdIxGyY3F856O9/zH+PS9H5+Kd1q
	hYuN8QWSmKjw7Q+Emlu8HWvPWz4+CLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785751821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CJy+2EF3Dhy7TWltT4LTBFxglCjp/1DLAObwpS2vbxU=;
	b=Xk/l9XTTVJIz9+jKrHUbAz0VK0Bs8BxzPzxmzHBQtfhadH0+OQZFvo20v4Za5O81KkRjIl
	pWyU9IA9IrZE/SDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 658AF779A1;
	Mon,  3 Aug 2026 10:10:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9ofBGA1pcGqIQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Aug 2026 10:10:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 116E0A13A4; Mon, 03 Aug 2026 12:10:17 +0200 (CEST)
Date: Mon, 3 Aug 2026 12:10:17 +0200
From: Jan Kara <jack@suse.cz>
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ufs: validate cylinder group metadata before caching
 it
Message-ID: <3zr3q6j73h6ttv3rib34rjeb3luxv3y3c7rovyqik5cp4dflf6@eif226wccquv>
References: <20260801071306.59484-1-ali@iusegentoo.com>
 <20260801071306.59484-3-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801071306.59484-3-ali@iusegentoo.com>
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
	URIBL_BLOCKED(0.00)[iusegentoo.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iusegentoo.com:email,suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
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
X-Rspamd-Queue-Id: 752233FBC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Sat 01-08-26 10:12:58, Ali Ahmet Memis wrote:
> ufs_read_cylinder() copies the cylinder group index and the rotor
> positions straight from the on-disk group and caches them without any
> check:
> 
> 	ucpi->c_cgx    = fs32_to_cpu(sb, ucg->cg_cgx);
> 	ucpi->c_rotor  = fs32_to_cpu(sb, ucg->cg_rotor);
> 	ucpi->c_frotor = fs32_to_cpu(sb, ucg->cg_frotor);
> 	ucpi->c_irotor = fs32_to_cpu(sb, ucg->cg_irotor);
> 
> They are then used as indices during allocation and free:
> 
>   - c_cgx indexes the cylinder summary array as
>     UFS_SB(sb)->fs_cs(ucpi->c_cgx), so a value past s_ncg writes a 32
>     bit count outside the s_csp allocation.
> 
>   - c_frotor becomes a bitmap scan start, start = c_frotor >> 3, and
>     then length = ((s_fpg + 7) >> 3) - start. A start beyond the block
>     bitmap wraps the unsigned length to a huge value, so ubh_scanc()
>     walks far past the cylinder group buffers. c_irotor drives the
>     inode bitmap the same way.
> 
> A crafted image can set any of these freely, turning an ordinary
> allocation into an out of bounds access.
> 
> Reject a cylinder group whose recorded index does not match the group
> being read, or whose rotors fall outside the group, before the metadata
> is cached. Valid filesystems keep cg_cgx equal to the group number and
> the rotors within the group, so only malformed images are rejected.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ufs/cylinder.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/ufs/cylinder.c b/fs/ufs/cylinder.c
> index a2813270c..b930ee1cf 100644
> --- a/fs/ufs/cylinder.c
> +++ b/fs/ufs/cylinder.c
> @@ -68,6 +68,16 @@ static bool ufs_read_cylinder(struct super_block *sb,
>  	ucpi->c_clustersumoff = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_clustersumoff);
>  	ucpi->c_clusteroff = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_clusteroff);
>  	ucpi->c_nclusterblks = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_nclusterblks);
> +
> +	/* these on-disk values become array and bitmap indices */
> +	if (ucpi->c_cgx != cgno ||
> +	    ucpi->c_rotor >= uspi->s_fpg ||
> +	    ucpi->c_frotor >= uspi->s_fpg ||
> +	    ucpi->c_irotor >= uspi->s_ipg) {
> +		ufs_error(sb, __func__,
> +			  "inconsistent metadata in cylinder group %u\n", cgno);
> +		goto failed;
> +	}
>  	UFSD("EXIT\n");
>  	return true;
>  	
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
