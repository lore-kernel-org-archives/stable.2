Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903151;
	b=HnL/X7l3X0roC/BB59Br98ZSggyw27qz3iNkMfMqX+M4PieaRkm/tChoXQhErTj7qb9n
	 pgQCEV5KQGTCzUTw9CoxjLfwAxNZqVie+h09g3tRsQvpSL/1QuKgltmVuhl/P6yEwZzRx
	 Gr49on2UhBCFt78CDPlyg7ydak/+ED49i8Om1SqfZCUqbI+8Qc1RCTBmAjTEP1f+P+OPA
	 nvqo6+q+bEpecTLb+uCL9vQxi+Px0fF78IRjbPtwtVqMlEa0ycRNqlfknbvQ56ucy9kxf
	 WOpqiOX7MMYtbZ7B7aQkrGoRxsjxil+9P6fHBFjKyUGSBhtfHH44PF2d8z9+p0rneTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903151;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=43uhnSsbz3kHU9pdgxC9KmtDl/67WB1TNCWfONes/yw=;
	b=gh8HLbEch9yLJb5AYyYs2mwNnvvr5zkQGfBUwMZC7NQekE5xIu5BpnIuJDtc8ZsPVB3y
	 qPSVwjpKGLwsZ7FZplOq6IUm8HebMERv0Zoq6mSj9QlP4A8yuj/kcGqCzEn7u56siv9FN
	 5qrvAbM1ASpfHCOL4Bn8N56cqfd5mKv2SqYli8gVVqdkksXPzGcxxljEjAS1eMPvbw64Y
	 Hia37rh4DOzwOg+Vpu3hmhgy4UAzMMz53M286PqY+/9W+Wz53vQfaffokFYIifW0ANgiW
	 qDKaUGp0/yVVblJAuOdDo/GkGdZPRYcmn+bi/L5UO5sHR+LMUlZ0Jmg5vJRziDHHxGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=gpLik4Np;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IRCfsY0D;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qpZ4fh0Q;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="/Zr3qgE1";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80146606A32D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80146606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=gpLik4Np;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IRCfsY0D;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qpZ4fh0Q;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/Zr3qgE1
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 680B41F806;
	Thu,  5 Nov 2026 18:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793903142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43uhnSsbz3kHU9pdgxC9KmtDl/67WB1TNCWfONes/yw=;
	b=gpLik4NpZai2UCjBWJ/B95wrHx4MFifwTzLWTRBPuU4JR4/ciZjfkZNijMo/jVikJg/ygF
	hXxQy95vm+/D72Fq30mAwhIbXoERwC3lkAK+lm6im+qEmXKSAMyCFceZGJneyxAC1IgVze
	Jzdww+rCxUQNhEyS3mcIi9GyDQooxhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793903142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43uhnSsbz3kHU9pdgxC9KmtDl/67WB1TNCWfONes/yw=;
	b=IRCfsY0DDHNNDPM4eXi8rOYTYZ4Xoyq6uw0m4wt/msxYws1pV66lh10BLLtzBT9ELWY4ZG
	CAAL25a7JaiBzFDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793903140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43uhnSsbz3kHU9pdgxC9KmtDl/67WB1TNCWfONes/yw=;
	b=qpZ4fh0QxEdi0FT26Cr+9xiUgjtuL0capIrgzL6ruIrFpfI80vQ6Zmkpoh/99Vql2oxws5
	cD93of+Fqf+ld9B00RpMC/cOTXFB/rLYJlmvqYUYgtvJ7BMtW5S1qcVmbueCji3IDM2wff
	LRazJdXXvLpumw9+JCsWwDGVSym4yKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793903140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43uhnSsbz3kHU9pdgxC9KmtDl/67WB1TNCWfONes/yw=;
	b=/Zr3qgE1TUmuiHY93oePEYHUzm7HO4+DFmlFo2o14oM23SU60+Tpdx+yUWXDjuHfGG8YcQ
	Jd41VfGUr+OCttBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C052133F6;
	Thu,  5 Nov 2026 18:25:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3Xl0BiTK7GqAHQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Nov 2026 18:25:40 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id B89CDB819; Thu, 05 Nov 2026 19:25:39 +0100 (CET)
Date: Thu, 5 Nov 2026 19:25:39 +0100
From: Jan Kara <jack@suse.cz>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz, 
	shr@devkernel.io, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page-writeback: avoid overflow when reporting BDI
 byte limits
Message-ID: <ijzndqxlfmivwaujc7nhtsa4p3hyd43g3aqud3vovajnd7jh7f@wcarf4xjxm5b>
References: <20261103193627.71959-1-dennylin0707@gmail.com>
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
In-Reply-To: <20261103193627.71959-1-dennylin0707@gmail.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -12.80

On Tue 03-11-26 19:36:26, Hungyu Lin wrote:
> bdi_get_bytes() multiplies unsigned long operands before assigning the
> result to u64. On 32-bit kernels, the intermediate product wraps and
> min_bytes and max_bytes report incorrect limits. For example, with
> vm.dirty_bytes set to 104857600 and max_ratio set to 100, max_bytes
> reports 268 instead of 104857600.
> 
> Convert the page count to bytes in u64 and use mul_u64_u32_div() to avoid
> overflow in the subsequent multiplication. This also handles large dirty
> limits on systems with larger pages. Combining the two divisions keeps
> the existing rounding behavior.
> 
> Fixes: 00df7d51263b ("mm: add bdi_get_max_bytes() function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 499a35473e4f..ddebec79d8d9 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -665,7 +665,8 @@ static u64 bdi_get_bytes(unsigned int ratio)
>  	u64 bytes;
>  
>  	global_dirty_limits(&background_thresh, &dirty_thresh);
> -	bytes = (dirty_thresh * PAGE_SIZE * ratio) / BDI_RATIO_SCALE / 100;
> +	bytes = mul_u64_u32_div((u64)dirty_thresh << PAGE_SHIFT, ratio,
> +				100 * BDI_RATIO_SCALE);
>  
>  	return bytes;
>  }
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
