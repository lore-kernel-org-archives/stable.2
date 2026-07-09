Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC528C86C
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604251; cv=none; b=J8jcHzAieluKqqPH4bSeK2Q1MmlzdsfxZW84dJMUa76E+niHMfwwm9gpfWEkq85UKVMt/dq7s9fEG9jQxT0mbCVmG/Xul9CYoNeekZPjwySmz1bksEe4VCC29G+vZ/R3V6eAn2xrN1XG+50ir8ZW3FjNFx4S6GP7JCN3CT1lsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604251; c=relaxed/simple;
	bh=ncWhm7gJeQ93T7p82XT3/t2TFTc0Ic618PHop9W5wbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbKZMDM/lrO+KIifR80/Z2UTJb7QC0hYAq3Fj1EihX5r4lxNiw9P/1tDt4TiC2qur5DSkXKx95yBzGSA6fqGNHUeq/IsYXvV13LbsEiczAQ/aR3b2rGra5+8ie55KxftYJbEfNL0oM51PTbgjjJawGP8M0j8AmU+80t9hZqIWBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QQvobcGu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x4D/Fufd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QQvobcGu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x4D/Fufd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QQvobcGu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x4D/Fufd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QQvobcGu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x4D/Fufd"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F20875C06;
	Thu,  9 Jul 2026 13:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783604248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=auksEXEKhj1V7KzR+yrL3ymH3SJtGHXdgrlGLgP3TN0=;
	b=QQvobcGuljNc0jqIvZlDA+x/1N9P2XD4XulQc9NrS7RiACV2jr1J/40uwWKHSlyWNi/Boz
	1EIZhAjc88J4EHrXoh4rALgVYUD+87TlMNs+hb4u40z/wASgXn1hb+ZtuIuVCZHHaQ7oG/
	0/6y1qK1r2QQqTuTJyMf67ek7FtChnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783604248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=auksEXEKhj1V7KzR+yrL3ymH3SJtGHXdgrlGLgP3TN0=;
	b=x4D/FufdY1sBNtJ9KLDlwi2Ub6NZb5jPm8LezDSEdJxUoy7vhckwA67x/8VOVZS7l+BZL1
	KG0MgBTKA2YC2/AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QQvobcGu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="x4D/Fufd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783604248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=auksEXEKhj1V7KzR+yrL3ymH3SJtGHXdgrlGLgP3TN0=;
	b=QQvobcGuljNc0jqIvZlDA+x/1N9P2XD4XulQc9NrS7RiACV2jr1J/40uwWKHSlyWNi/Boz
	1EIZhAjc88J4EHrXoh4rALgVYUD+87TlMNs+hb4u40z/wASgXn1hb+ZtuIuVCZHHaQ7oG/
	0/6y1qK1r2QQqTuTJyMf67ek7FtChnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783604248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=auksEXEKhj1V7KzR+yrL3ymH3SJtGHXdgrlGLgP3TN0=;
	b=x4D/FufdY1sBNtJ9KLDlwi2Ub6NZb5jPm8LezDSEdJxUoy7vhckwA67x/8VOVZS7l+BZL1
	KG0MgBTKA2YC2/AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75724779AA;
	Thu,  9 Jul 2026 13:37:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jQCgHBikT2qNOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 09 Jul 2026 13:37:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 22B64A12D7; Thu, 09 Jul 2026 15:37:24 +0200 (CEST)
Date: Thu, 9 Jul 2026 15:37:24 +0200
From: Jan Kara <jack@suse.cz>
To: David Lee <david.lee@trailofbits.com>
Cc: Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, 
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>, stable@vger.kernel.org
Subject: Re: [PATCH] udf: reject VAT indexes equal to the entry count
Message-ID: <ic5yl6efm77r2tajqeizeljokkpkqe2vvh3eww54apuu7e2pof@yomiowfjhwjx>
References: <20260708101712.1706564-1-david.lee@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708101712.1706564-1-david.lee@trailofbits.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7F20875C06
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed 08-07-26 10:17:09, David Lee wrote:
> UDF 1.50 virtual partition mapping uses the VAT as an array of physical
> block mappings. s_num_entries stores the number of entries in that array,
> not the highest valid index. The valid VAT indexes are therefore below
> s_num_entries.
> 
> udf_get_pblock_virt15() currently rejects only indexes greater than
> s_num_entries. A crafted image can request index s_num_entries, pass the
> bounds check, and make the kernel read one entry past the allocated VAT table.
> 
> Change the check to reject block >= s_num_entries, so the count is handled as
> an exclusive upper bound.
> 
> A crafted UDF image reproduced this on origin/master commit
> 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53 with a KASAN slab-out-of-bounds
> report in udf_get_pblock_virt15().
> 
> Trail of Bits has a reproducer that triggers kernel panic demonstrating the bug, and can share it if needed.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Lee <david.lee@trailofbits.com>
> Assisted-by: Codex:gpt-5.5

Thanks! I've added the patch to my tree.

								Honza

> ---
> fs/udf/partition.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/udf/partition.c b/fs/udf/partition.c
> index 2b85c95..ad8dced 100644
> --- a/fs/udf/partition.c
> +++ b/fs/udf/partition.c
> @@ -55,7 +55,7 @@ uint32_t udf_get_pblock_virt15(struct super_block *sb, uint32_t block,
>  	map = &sbi->s_partmaps[partition];
>  	vdata = &map->s_type_specific.s_virtual;
>  
> -	if (block > vdata->s_num_entries) {
> +	if (block >= vdata->s_num_entries) {
>  		udf_debug("Trying to access block beyond end of VAT (%u max %u)\n",
>  			  block, vdata->s_num_entries);
>  		return 0xFFFFFFFF;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
