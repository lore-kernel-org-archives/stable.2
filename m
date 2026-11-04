Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795098;
	b=HZ86naQscEOKoHoaIco6CNdKqAxDkGsk1+qTNEOFjCxpa5ERP+rO5hVELDbbAjV5OxIZ
	 aIqXX654cexeohhg2ZpCSc2m3+ORDZg9J/YBC6VBW3dUZK2ePV73wilYFplf2Uj/8nmeL
	 GHbcGLSXCeJZLX3j6lQ3D4o9OoN8rwCdv/XPOLKWeS1fHl73svOl0qaVRGIFMySVmAvPy
	 MD1x+WxebBvgHwe/tLXEjBjn2Ql5dd59Ojgo6r4okbgj+VVmf4xNFtstuvplxGfCHB+Dx
	 H6y9uymfVYiOT8mUk7Un87nyfmaERxNuytD8WX+uW7asP2rQesSbjxI95Kf3b7JBWxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795098;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=XNmrnQLKNQ/MDoLuIp/7vZYSf99RWekPLj/FzDmiyl0=;
	b=oia4qv9sWapOS5gYbii9uiaOeeEncCSXRrFKaI+1dvNViqKVPXQlZB8aPZrcAGtNGPkx
	 sEaQmGby6seT3FFtNNQTAzS07ZjXmdMscP3YDFzeQZP6quSd/J6EJbLJ2ktQUK2Pn/9Jx
	 Mclc/isEwGWMizF/E/+3FNbMmPjAU/z3v06tjNbaXjtN3/Z2+z0J8inGzxEQfynAPHF/O
	 kQJS8ROZmMsn49tH19JmNPqAcL6dHR5jzO9yHticWrYSkhCnAoUOXM9Y08glaE39RyMGd
	 EyKOQLA2sVW8zMIXdnxjPZ3DA3ocA1C0bB/fyRjNSU/14BMIuNZv7kyai5+oiIdh0vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=B8KWGY3x;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5vTouD4T;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=HgLQC5gs;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OdOXGJkj;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9CF606A335
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 12:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC9CF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=B8KWGY3x;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5vTouD4T;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=HgLQC5gs;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OdOXGJkj
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E31461F444;
	Wed,  4 Nov 2026 12:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793795089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XNmrnQLKNQ/MDoLuIp/7vZYSf99RWekPLj/FzDmiyl0=;
	b=B8KWGY3x9w/OD4QG98rL3PWMD5ZUPDfI+tKORnZUlzqldFWrWohOBAyvr7g5GDeZ7+7bOL
	SDYVLs4uZl1ZWBUsEFaxIBMiA7Wx92nKt6JVn3YecFAy4td//ibZiHOJcnWIA1r5bWsAf8
	Q+al1C6ZqVTI/Cc4fLDwQhU5kAT5svU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793795089;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XNmrnQLKNQ/MDoLuIp/7vZYSf99RWekPLj/FzDmiyl0=;
	b=5vTouD4TXJOt8d+3D4pnInf4aD806DzEFGA6puXemTawLaDBSkpVjn9gMWIIhQkIJG6Ulg
	ZmlbZei7xhzSCADQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793795088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XNmrnQLKNQ/MDoLuIp/7vZYSf99RWekPLj/FzDmiyl0=;
	b=HgLQC5gsVedS0j82/uhuLLWySwJi+GnYvnvJG/SJLuE5KsdY1Rhq6OCEVx7HE5P/5SdYrK
	otQ4F0UKhS3HRSq/hrPa9dR8ZygzAR+JT+T3AShehkOR6BVb8vdCIyQF5ba5gtj2bkYQVH
	AmxWEZa8ac+b/fUHHvocBIcHFbcogY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793795088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XNmrnQLKNQ/MDoLuIp/7vZYSf99RWekPLj/FzDmiyl0=;
	b=OdOXGJkjcHKO3Ti5fXUDD/4TMuk7xhhY+2lyzZqKzDLKtH6ovyiCm4umqBK3JrvMLcXfxR
	o19Oi/LHImCz86CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1C6D134F0;
	Wed,  4 Nov 2026 12:24:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vLJ3IhAk62rWawAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Nov 2026 12:24:48 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 37672B368; Wed, 04 Nov 2026 13:24:48 +0100 (CET)
Date: Wed, 4 Nov 2026 13:24:48 +0100
From: Jan Kara <jack@suse.cz>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: jack@suse.cz, sortie@maxsi.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] isofs: handle Rock Ridge long-form dates before 1900
Message-ID: <hgfr4dfhp6blqqkdjrmw4uihofgzjljfpks7bumzmizcdt6b2o@sbjhrm6mzx56>
References: <20261029004902.76944-1-dennylin0707@gmail.com>
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
In-Reply-To: <20261029004902.76944-1-dennylin0707@gmail.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -12.80

On Thu 29-10-26 00:49:02, Hungyu Lin wrote:
> iso_date() stores the year relative to 1900 and rejects negative values.
> Rock Ridge LONG_FORM timestamps encode calendar years from 1 to 9999,
> so valid years before 1900 are returned as seconds since the Unix epoch
> equal to zero instead of their recorded dates. For example, an 1899
> timestamp on an image produced by xorriso is reported as 1970 by stat,
> and cp -p preserves that incorrect time.
> 
> Use the calendar year for both timestamp formats and pass it directly
> to mktime64(). Keep the epoch fallback for year zero, while allowing
> valid long-form years before 1900. Short-form dates are unchanged.
> 
> Fixes: 5ea45f54c8d6 ("isofs: fix Y2038 and Y2156 issues in Rock Ridge TF entry")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Thanks for the fix. I've added it to my tree. I've dropped the CC stable
since this really isn't a serious issue...

								Honza

> ---
>  fs/isofs/util.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/isofs/util.c b/fs/isofs/util.c
> index 42f479da0b28..6f9a90e58a89 100644
> --- a/fs/isofs/util.c
> +++ b/fs/isofs/util.c
> @@ -25,7 +25,7 @@ struct timespec64 iso_date(u8 *p, int flags)
>  		year = (p[0] - '0') * 1000 +
>  		       (p[1] - '0') * 100 +
>  		       (p[2] - '0') * 10 +
> -		       (p[3] - '0') - 1900;
> +		       (p[3] - '0');
>  		month = ((p[4] - '0') * 10 + (p[5] - '0'));
>  		day = ((p[6] - '0') * 10 + (p[7] - '0'));
>  		hour = ((p[8] - '0') * 10 + (p[9] - '0'));
> @@ -34,7 +34,7 @@ struct timespec64 iso_date(u8 *p, int flags)
>  		ts.tv_nsec = ((p[14] - '0') * 10 + (p[15] - '0')) * 10000000;
>  		tz = p[16];
>  	} else {
> -		year = p[0];
> +		year = p[0] + 1900;
>  		month = p[1];
>  		day = p[2];
>  		hour = p[3];
> @@ -45,10 +45,10 @@ struct timespec64 iso_date(u8 *p, int flags)
>  		tz = flags & ISO_DATE_HIGH_SIERRA ? 0 : p[6];
>  	}
>  
> -	if (year < 0) {
> +	if (year < 1) {
>  		ts.tv_sec = 0;
>  	} else {
> -		ts.tv_sec = mktime64(year+1900, month, day, hour, minute, second);
> +		ts.tv_sec = mktime64(year, month, day, hour, minute, second);
>  
>  		/* sign extend */
>  		if (tz & 0x80)
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
