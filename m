Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A36C42C500
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790842320; cv=none; b=mFHiOIXUnJ9nMxiTTP7+GS84GwecV5EE/47tGu/H3OUhu1bmfEF2Fq7veiQOAuQeYroJJZYHYAY1xP2iPcs9zryLgRxcrb8FeFNkMXKc+RHBMVRty2kQfIsaE8TFIWhLi+Ar2SeDb8xg4i9Pzsb88RgNnfC9pUcxPtc2kVnHKQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790842320; c=relaxed/simple;
	bh=rR9lDXurt2uwdSssWIyJRChYiHMIHeLvlylC9nmS+Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEsqlNAYZ8BhTip3cROp6FFvmw5vOY3WBejrOHjiNe7DrXFfFY+XxGbHXwYyreOgpTGyNA8m/hvMRXLMUw9r5HfHghmykXHH9vlACaSKn7ZIe7V/yNNLXqwYFVLMCWoSbLamU+Qh6LeMbq1GGCK2uHHAqUktZksECWCOnTvpNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uc6DfGZT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H/2NkGyA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SOrkK6cR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MyEt24Om; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uc6DfGZT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H/2NkGyA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SOrkK6cR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MyEt24Om"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E66721EBF;
	Thu,  1 Oct 2026 08:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790842296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HvMI2lZZBSxVV+2zdfxxLDs33Kp+LCZMwY4h4IUd9co=;
	b=uc6DfGZTarOhRPxv+k5N9rt79wwCHp4Iiv6x8pgxig1jZA30VtvPt/1NopC4aREzjvQbE8
	XbbsSLAOimDb+u8TFRnLaIihQhaFlK/HxLaDePVJPj14bIlaXDeeL2zVlge3y3gk7TurI6
	/6pH4PhyDIIaSrbSP1f27C3oaiDiOHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790842296;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HvMI2lZZBSxVV+2zdfxxLDs33Kp+LCZMwY4h4IUd9co=;
	b=H/2NkGyAPLaGAOrc1GzI9q+gDZXhx/et9FILtqpuvMc0sE/seC5N5/djaBtK34Uy9v2k6i
	uETDNXLiS4GDqFAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SOrkK6cR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MyEt24Om
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790842292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HvMI2lZZBSxVV+2zdfxxLDs33Kp+LCZMwY4h4IUd9co=;
	b=SOrkK6cR2Yr/qeqhBQfHd6hdbg+a3TxxWaHLY9qRYlDfK7JWfWBV04B7qe6mVwX81wpxF1
	tCbNvOPqeYSvS8pMbH9YRT90+PfKHoPcMhBNxG4eXPV42fh9JNCJPfQOAFaZ9VyePm8quZ
	N+jd3EC5BUIwzMtkiEC8+XOIk7vDOFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790842292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HvMI2lZZBSxVV+2zdfxxLDs33Kp+LCZMwY4h4IUd9co=;
	b=MyEt24OmUnE3HQj6uSDFye77cMEE982a2eJ0oaJ7ncH+QdeCfhJHPdhhEMKT4QRJIjJNFK
	viXetoNGrLJnSxAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E228B134B3;
	Thu,  1 Oct 2026 08:11:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zhNOLrMVvmp7UAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Oct 2026 08:11:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 67D84A13F7; Thu, 01 Oct 2026 10:11:16 +0200 (CEST)
Date: Thu, 1 Oct 2026 10:11:16 +0200
From: Jan Kara <jack@suse.cz>
To: Hui Peng <benquike@gmail.com>
Cc: Jan Kara <jack@suse.cz>, 
	Matthias Goergens <matthias.goergens@gmail.com>, Anders Larsen <al@alarsen.net>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] isofs: bound empty directory blocks in
 isofs_read_level3_size()
Message-ID: <gwglszf5mvb2n4mor235v5752rsohm3b2zs6msiolir7hqqiq2@73uzvzj2rmim>
References: <20260930042148.169831-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930042148.169831-1-benquike@gmail.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1E66721EBF
X-Rspamd-Action: no action
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
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,alarsen.net,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 

On Wed 30-09-26 04:21:48, Hui Peng wrote:
> isofs_read_level3_size() walks the sections of a level-3 (multi-extent)
> directory record and, on encountering a zero length byte (de_len == 0),
> moves on to the next block without bound. A crafted image with a long run
> of empty blocks between two sections of a multi-extent file can force the
> walk to read every block to the end of the device.
> 
> Count empty blocks (de_len == 0 at offset == 0) towards the existing
> 100-section limit. Track empty_blocks in a separate variable from section
> count 'i' rather than incrementing 'i' directly, because 'if (i == 1)'
> records the start of the second section (ei->i_next_section_block/offset);
> incrementing 'i' on empty blocks before the second section is read would
> cause 'i' to jump past 1, leaving the next-section pointer uninitialized
> (0) and reading past the first extent into unrelated disk data.
> 
> Tested in QEMU against Linux 7.3.0-rc3 with KASAN enabled using a crafted
> ISO image containing 150 consecutive empty blocks between two extents:
> on the unfixed kernel the loop reads all 150 blocks; whereas with this fix
> applied, the loop aborts with "isofs_read_level3_size: More than 100 file
> sections/empty blocks ?!?".
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Suggested-by: Jan Kara <jack@suse.cz>
> Co-developed-by: Matthias Goergens <matthias.goergens@gmail.com>
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sorry Hui, I already have a patch from Matthias for this in my tree.

								Honza

> ---
> Changes in v2:
> - Document in code comment why empty_blocks is tracked separately from
>   section count 'i' rather than incrementing 'i' directly (preserving
>   the 'if (i == 1)' check for the second section pointer), answering Jan
>   Kara's reviewer feedback.
> 
> Changes in v1:
> - Combined section and empty-block bounds check into i + empty_blocks > 100.
> 
>  fs/isofs/inode.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index 184350d2e6ad..d7b324029a1b 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -1173,6 +1173,7 @@ static int isofs_read_level3_size(struct inode *inode)
>  	struct buffer_head *bh = NULL;
>  	unsigned long block, offset, block_saved, offset_saved;
>  	int i = 0;
> +	int empty_blocks = 0;
>  	int more_entries = 0;
>  	struct iso_directory_record *tmpde = NULL;
>  	struct iso_inode_info *ei = ISOFS_I(inode);
> @@ -1200,6 +1201,17 @@ static int isofs_read_level3_size(struct inode *inode)
>  		de_len = *(unsigned char *) de;
> 
>  		if (de_len == 0) {
> +			/*
> +			 * A zero length byte at the start of a block (offset == 0)
> +			 * means the whole block is empty. Count that towards the
> +			 * same 100 limit as file sections, or a chain of empty
> +			 * blocks could be walked without bound.
> +			 * Track empty_blocks separately from section count 'i'
> +			 * so that 'if (i == 1)' correctly identifies the start of
> +			 * the second section even if an empty block precedes it.
> +			 */
> +			if (offset == 0 && ++empty_blocks + i > 100)
> +				goto out_toomany;
>  			brelse(bh);
>  			bh = NULL;
>  			++block;
> @@ -1241,7 +1253,7 @@ static int isofs_read_level3_size(struct inode *inode)
>  		more_entries = de->flags[-high_sierra] & 0x80;
> 
>  		i++;
> -		if (i > 100)
> +		if (i + empty_blocks > 100)
>  			goto out_toomany;
>  	} while (more_entries);
>  out:
> @@ -1258,7 +1270,7 @@ static int isofs_read_level3_size(struct inode *inode)
>  	return -EIO;
> 
>  out_toomany:
> -	printk(KERN_INFO "%s: More than 100 file sections ?!?, aborting...\n"
> +	printk(KERN_INFO "%s: More than 100 file sections/empty blocks ?!?, aborting...\n"
>  		"isofs_read_level3_size: inode=%llu\n",
>  		__func__, inode->i_ino);
>  	goto out;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
