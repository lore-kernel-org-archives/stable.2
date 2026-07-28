Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5371A6828
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251138; cv=none; b=ZJ0JgfkNgzV7I/r5Q42aZtEUrVmrQSAmD06neKOoSpRRl7N8ZPBJM1INud8MQkdGHFcEFiRnYnfGPdRTZ69YRoaLI9YRHdc/7F/QThDWsPfEWJ70bgdkC/Z4XgQAsV+S46HU5bxl6SC3EK+JRNpR812qjNq5mHXpAOuudyMaIC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251138; c=relaxed/simple;
	bh=ojwAFxJs6Wn0yZCJInlHDI7T2dLWCvbDXXaNJ57HJ18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+Uluj9GEr6++X4K5KxmA2pMk6zKonKAYFEk1IAQicqGmM1ciOhK1cVbZEsEabNe8/ipry49GFkOO8MI0ZWHEIkhNGN0ljiSD6nOFjUo4jBkIkfTzl9dkG1hPtsEx9t0Bktt38qL/79VOUWMONDdvfDUY0VSla0YR+SNW474Y9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=brLL81fF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lSa2vC/O; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XgB2y6ke; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4SG3xVFp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="brLL81fF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lSa2vC/O";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XgB2y6ke";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4SG3xVFp"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4A493ED1;
	Tue, 28 Jul 2026 15:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785251126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DiMXoinYrfvkN7ssjGkHAthfL1dUNuPu+43kKlOoSCA=;
	b=brLL81fFnU2L85DINZsEtJ7VnigaaBn+jGrEKk2mBL3hIFxQ61gffo6Sq8eHxv2kxtpeJe
	7HaZLzRZHS1yVqzyrL5bb5o2ZBn31KPOzq3R2tsZzuA4EsTNqqMeDPwtGMoeTHuQKfxg0K
	VqXpgzPJ1XZlG+x0PUNTv2EV/xHxPns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785251126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DiMXoinYrfvkN7ssjGkHAthfL1dUNuPu+43kKlOoSCA=;
	b=lSa2vC/O/WjeRNqusk/LC0MYIplbg5qC3MAhxbMhOnMV16oumMWe18CaBkM9HAzUk3ZCu8
	LMRok14s8/1EaMDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XgB2y6ke;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4SG3xVFp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785251117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DiMXoinYrfvkN7ssjGkHAthfL1dUNuPu+43kKlOoSCA=;
	b=XgB2y6keZQf4qgkvRC+/VcrfZswfJg1L5OFDbY1F7k53D8CLDNXWr/R1y+9Y803yr5goYX
	wUXJBL8cbWqeEb/HxJJAokfC71shO3ALLF6z4AUyV4jeJN98J/3qLUdQiUuER2UB7XGkme
	+m5VqdVz5l5S1sqvNExW6FpFj5Rbm40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785251117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DiMXoinYrfvkN7ssjGkHAthfL1dUNuPu+43kKlOoSCA=;
	b=4SG3xVFpmTNiIYcz4LlN3UgoAslWWmp1uCt8sLW8vZopssdnPGsr6NLabTbacCW8lsTfkU
	uz4BJVVglSsq4IBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7763779B3;
	Tue, 28 Jul 2026 15:05:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tv6tMCjFaGpFOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 28 Jul 2026 15:05:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 73F09A10B6; Tue, 28 Jul 2026 17:05:04 +0200 (CEST)
Date: Tue, 28 Jul 2026 17:05:04 +0200
From: Jan Kara <jack@suse.cz>
To: Baul Lee <baul.lee@xbow.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jack@suse.com, federico.kirschbaum@xbow.com, stable@vger.kernel.org
Subject: Re: [PATCH] udf: fix OOB read for a crafted unallocSpaceEntry
Message-ID: <izuuku5bbo3vezh4iebahgvbh7l3wjbojjk2y3h7sbhj667pmo@vi7kfnshjm2k>
References: <20260726062509.43738-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726062509.43738-1-baul.lee@xbow.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,xbow.com:email,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[suse.cz:query timed out];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: D4A493ED1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Sun 26-07-26 15:25:09, Baul Lee wrote:
> udf_read_inode() sanity-checks the on-disk allocation-descriptor length
> before it is used:
> 
> 	if (iinfo->i_lenEAttr > bs || iinfo->i_lenAlloc > bs)
> 		goto out;
> 	/* Now do exact checks */
> 	if (udf_file_entry_alloc_offset(inode) + iinfo->i_lenAlloc > bs)
> 		goto out;
> 
> but the TAG_IDENT_USE branch sets i_lenAlloc from the on-disk
> lengthAllocDescs and returns before ever reaching them.  A USE inode
> therefore keeps a completely unvalidated le32 there, while i_data is
> allocated at only bs - sizeof(struct unallocSpaceEntry) bytes.
> 
> udf_current_aext() computes, in its in-ICB branch,
> 
> 	alen = udf_file_entry_alloc_offset(inode) + iinfo->i_lenAlloc;
> 
> with no clamp and passes alen to udf_get_fileshortad() as maxoffset.
> That helper only checks (*offset + sizeof(struct short_ad)) > maxoffset,
> so an inflated i_lenAlloc lets the walk step past the end of i_data and
> dereference sa->extLength in adjacent slab memory.
> 
> A Type-1 partition whose unallocSpaceTable extent is non-zero loads the
> USE table inode at mount and sets UDF_PART_FLAG_UNALLOC_TABLE.  An
> unprivileged statfs(2) then reaches udf_count_free_table() ->
> udf_next_aext() -> udf_current_aext(), and KASAN reports a
> slab-out-of-bounds read just past the 472-byte i_data allocation.
> 
> Apply the same exact check on the USE path, before i_data is allocated
> and walked.  ret is still -EIO there, so the offending inode fails to
> load.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: 23b133bdc452 ("udf: Check length of extended attributes and allocation descriptors")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>

Thanks for the patch but commit b8228f59dc58 ("udf: bound lengthAllocDescs
from unallocated space entry") in my tree should already handle this.

								Honza

> ---
>  fs/udf/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index c97914aa8d8b..8a0c9ea31a11 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -1475,6 +1475,8 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
>  		iinfo->i_lenAlloc = le32_to_cpu(
>  				((struct unallocSpaceEntry *)bh->b_data)->
>  				 lengthAllocDescs);
> +		if (udf_file_entry_alloc_offset(inode) + iinfo->i_lenAlloc > bs)
> +			goto out;
>  		ret = udf_alloc_i_data(inode, bs -
>  					sizeof(struct unallocSpaceEntry));
>  		if (ret)
> -- 
> 2.50.1 (Apple Git-155)
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
