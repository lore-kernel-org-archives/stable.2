Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595283;
	b=u7uXQgofAAO53ORMIFm/r5Dua0kJZ/FPWajFKB4vARnfLd1Tf9hAhTt9Orzy1ny1fr8a
	 yyh9Zco/ALgFoMcX+AbMvJwV4NI5v5GvgDkDrl4e4Kki5slVNXrT6ofc7nPnAYCmLI2ty
	 aqayoOUvLPsfS76jVUDuar36wMBVmgiriougeHgVjPtjVYqEPPcECqqPBXvZcj1K2aqtN
	 JBtGQJ1WW+l0FrX55f5Rl1/2M8sVVzG1sWO43+lGpBvaCVCgbIZ0grTdB9KJoV7LoQBqW
	 5dxngq6RJFitiQYSiAOrv29RFEhXdWbmk5nh1qbCHsK0BwDi3yTlUTouma0w/MVZ2ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595283;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=4IL+wAUg2YMioNglotQqAajEtIi50oQ+jrWGTenLzTU=;
	b=D/DUFfTnsTu1+M+Kpcdb8unpjTAfRLbQdlG2MnOjlU9xQhysfXNWLDW7eybYEz3AU6Hm
	 hdZqq14kGVAgGa8qTWIhvB3W1dChgs1vIE3Wl+ZvI0yC9CSItC6W2p/DMpjLwGZgqt2U1
	 I/WbvJI3lmIqQIdjEpkt39tq6WS8J5YKTMn/9BjIOBNdkSJKbhxt5dOLPX1M57NrqZbD2
	 5YUMtvKa6hBCR0XsVLItX9Fn6b4mmBhD/AQotdkjy0+Mh5NwpRUJF5fpVHldaSXa4Deci
	 SfWfskFmgCDkiu2fY1TWz+eVlWPqh+slvOs5VjOLgiEzK+KPdULSpI4ONIz5MJhCfQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=kFdhW9k8;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=fjGwKxnF;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Afx3HhuS;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=41gz4xnp;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E21606A324
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0E21606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=kFdhW9k8;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=fjGwKxnF;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Afx3HhuS;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=41gz4xnp
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04DAA21F93;
	Wed, 21 Oct 2026 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792595274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4IL+wAUg2YMioNglotQqAajEtIi50oQ+jrWGTenLzTU=;
	b=kFdhW9k85lZxkLuQFkoMN1Di1Ys1mAf090DUb/Ji7ixNmKq/7S+1NpATauaLFaNpF2ZyKE
	tXYT4LFJFLCQW6Wl5eY6+3oDi5TVAEBQBS+HK0BUM8yMIN0itndeky0yVmXyMcz0xLZERu
	JjA5PGnQ6zMwRZ3Avq2mAccSo0Trsew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792595274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4IL+wAUg2YMioNglotQqAajEtIi50oQ+jrWGTenLzTU=;
	b=fjGwKxnF9K6US9y2Fxt0YOsr+du6LfzBFo8MYsB1tqkvVrOz6L1nti9tJZ0e46/PicKWhJ
	UkJp5qKsFSvUBUAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792595272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4IL+wAUg2YMioNglotQqAajEtIi50oQ+jrWGTenLzTU=;
	b=Afx3HhuSSFNpkakRqGh9I0RnIMjicwBbxKLXHp6MhGJOvuIdqA/BJL7AlsjoNTaBsB/05H
	z0sM9DHquMUjpDCt6FqUdatEvbRv/JdU/JxnuhdM7WMYaWmTW4LW2MuC06qcQYUS2xxWnX
	3ZCc8J8qQq6KJ/QMrwNHb9GahepSSYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792595272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4IL+wAUg2YMioNglotQqAajEtIi50oQ+jrWGTenLzTU=;
	b=41gz4xnpCASbZfXud9a6C7Kcx7fCf3dbp8s0+8/xXgef7skC4pF/NTncrOEb2ewFJVQE7M
	AI7f5EUdBu7Y/pAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFF70134A5;
	Wed, 21 Oct 2026 15:07:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ixtZKUbV2GrnfAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Oct 2026 15:07:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 59E92A13C6; Wed, 21 Oct 2026 17:07:46 +0200 (CEST)
Date: Wed, 21 Oct 2026 17:07:46 +0200
From: Jan Kara <jack@suse.cz>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz, 
	shr@devkernel.io, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/page-writeback: avoid 32-bit overflow in dirty
 threshold shares
Message-ID: <n6sci6hug3mywpnhcylk5b3fldm3xjekiexwugqgmxx35sotsc@wcdhaetb23jr>
References: <20261021060654.27855-1-dennylin0707@gmail.com>
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
In-Reply-To: <20261021060654.27855-1-dennylin0707@gmail.com>
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
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Score: -12.80

On Wed 21-10-26 06:06:54, Hungyu Lin wrote:
> The ratios used by __wb_calc_thresh() are scaled to parts per million,
> but the threshold and ratio operands are unsigned long. On 32-bit
> kernels, their multiplication can wrap before the result is assigned
> to u64.
> 
> For example, with a threshold of 25600 pages and the default maximum
> ratio of 1000000, wb_max_thresh becomes 4125 pages instead of 25600.
> The shared threshold and minimum share calculations can overflow in
> the same way, producing incorrect per-writeback dirty limits.
> 
> Use a u64 threshold for the three ratio multiplications and div_u64()
> to retain the existing division order and rounding.
> 
> Fixes: ae82291e9ca4 ("mm: use part per 1000000 for bdi ratios")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Looks ok. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes in v2:
> - Use a u64 threshold variable instead of repeated casts, as suggested by
>   Andrew Morton.
> 
>  mm/page-writeback.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index eeab25d6ce36..1d6aab8781a5 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -883,6 +883,7 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
>  {
>  	struct wb_domain *dom = dtc_dom(dtc);
>  	struct bdi_writeback *wb = dtc->wb;
> +	u64 threshold = thresh;
>  	u64 wb_thresh;
>  	u64 wb_max_thresh;
>  	unsigned long numerator, denominator;
> @@ -894,13 +895,14 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
>  	fprop_fraction_percpu(&dom->completions, dtc->wb_completions,
>  			      &numerator, &denominator);
>  
> -	wb_thresh = (thresh * (100 * BDI_RATIO_SCALE - bdi_min_ratio)) / (100 * BDI_RATIO_SCALE);
> +	wb_thresh = div_u64(threshold * (100 * BDI_RATIO_SCALE - bdi_min_ratio),
> +			    100 * BDI_RATIO_SCALE);
>  	wb_thresh *= numerator;
>  	wb_thresh = div64_ul(wb_thresh, denominator);
>  
>  	wb_min_max_ratio(wb, &wb_min_ratio, &wb_max_ratio);
>  
> -	wb_thresh += (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
> +	wb_thresh += div_u64(threshold * wb_min_ratio, 100 * BDI_RATIO_SCALE);
>  
>  	/*
>  	 * It's very possible that wb_thresh is close to 0 not because the
> @@ -916,7 +918,7 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
>  			wb_thresh = max(wb_thresh, (thresh - dtc->dirty) / 8);
>  	}
>  
> -	wb_max_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
> +	wb_max_thresh = div_u64(threshold * wb_max_ratio, 100 * BDI_RATIO_SCALE);
>  	if (wb_thresh > wb_max_thresh)
>  		wb_thresh = wb_max_thresh;
>  
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
