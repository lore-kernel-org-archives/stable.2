Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656064;
	b=o4Yk0iSM5unvDKFzWbOb8SDldAy9JTe2RWB9WzCunnzOQov9yY6uvdk5WxSejfy4L/ps
	 5PECgjXET9J7KIjncZraJr9OWccCUAz0IHpZS/5WLQqw0vafyT4sFaRE/exlwao7E/ZxC
	 H5VhMkLk7yTd/LMxTat9Tvay3veziuaSBDxmSGordBqnfbDJmtU48JRbbMiGej3COYv0U
	 G61/51QPMTZv/0KuNHax5VfqwzfMMiYREEhh+iOCIMj8GpPdODTm9QhYjpUwjm1Sxe+d7
	 3Hwdq5N87hF/RJib8YMQWvKBzM3TviXtDgFZSx9dk/H5kkVQkHDNArAwoINW65OhcZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656064;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=Vb/3sWSxBw2qUSZvUAjgb9nGGAKW4T81LyCpd1I4tBE=;
	b=Jo9VrDmIVjiwuA0rSzZWaInhCbtncwrJ0+UwBioPkyu1YGk0tt1+BFme+xXJzyIrQX2a
	 Oxt209iuCiFIjnwT3LeY7r19Sc+qmEHMVONCDBGaMyKSMNr7xf0sRjuFSFpi7jaiTKKgH
	 QrWr4Wlmah64jWH1Xxj/wR0KOvN/u7fjLnCsKPKiD3w4bCo9P//T3dKcjhBHCDw+O9wUS
	 0i8jPdd+RwPWMwm5v6VgBEfkw0bP/ivnrmmxWQ10bY2VOtBB/v6Drqn/fmW64s4tpUeZ7
	 R+Tcbrf/48e0FRZioZqc0uNtWpEGdUqPCBmrl63UNbvYj7wJlGSSpHWWbKlP8rmHCAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=QQ1C106d;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="nqA/1t0z";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=WrzGD3HK;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2Dc2ShIS;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1172606D816;
	Mon,  2 Nov 2026 21:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1172606D816
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=QQ1C106d;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nqA/1t0z;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=WrzGD3HK;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2Dc2ShIS
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D867721FA3;
	Mon,  2 Nov 2026 21:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793656062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vb/3sWSxBw2qUSZvUAjgb9nGGAKW4T81LyCpd1I4tBE=;
	b=QQ1C106dgOT2yNLerNBoP/vWq8DRtW5gqsjUF7uh6dxg8oCAViLu8HNMvkyzJ6G6m9y9Re
	S7PjtyJppG69pSnhw3xwjVPv4sgm2sPsuVQE4EWWAaUKDLt013qvTjYXaQJOh802BqD4MW
	cj05Olry7FPgEc0s5b/jhfK7ICVevC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793656062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vb/3sWSxBw2qUSZvUAjgb9nGGAKW4T81LyCpd1I4tBE=;
	b=nqA/1t0zyndHEg8jx6xfPAdQi7/Ze3AqHMb1HdEi51LsKLxZM0iHPZL4vs85UAY6igI7E4
	ZRP5KP6mIQx1W5BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793656061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vb/3sWSxBw2qUSZvUAjgb9nGGAKW4T81LyCpd1I4tBE=;
	b=WrzGD3HKhykm+/exn5/6XQcxuvNvFAPfcExoRCxKdGBoLOTXopNbnQ/uMRqQQ7gJNAbI6z
	rQEwLwqUwYiRKokVYeOKZ01Aa5b7yG0NDrfTNrOuGgPyGHRU/uxJmMJpiCoOqhkOldEgv+
	6x0fy+8hrPrEwRdx/od+88aFR/+mCVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793656061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vb/3sWSxBw2qUSZvUAjgb9nGGAKW4T81LyCpd1I4tBE=;
	b=2Dc2ShISzrJ75w9xxR+2eH+YAYcA4JDqjvK8wrQo7vF78qEw+uJhZFltoS2KdXR42ywpHO
	rgmlkspX5+rD75CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B04C4134B3;
	Mon,  2 Nov 2026 21:47:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IZwpI/0E6WrgAQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Nov 2026 21:47:41 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 578DDB17B; Mon, 02 Nov 2026 22:47:37 +0100 (CET)
Date: Mon, 2 Nov 2026 22:47:37 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Benjamin LaHaise <bcrl@kvack.org>, 
	Jeff Moyer <jmoyer@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org, 
	Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org
Subject: Re: [PATCH] aio: don't let exit_aio() return before complete() is
 done
Message-ID: <b74oow6bhwdreed4fl55vjyllg6haqew3wetvfpep3saeu4rra@cr6un3h2yohg>
References: <20261030-work-aio-exit_aio-v1-1-83942022a4c4@kernel.org>
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
In-Reply-To: <20261030-work-aio-exit_aio-v1-1-83942022a4c4@kernel.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -12.80

On Fri 30-10-26 17:15:21, Christian Brauner wrote:
> exit_aio() kills all contexts in one go and waits for them with a
> single on-stack struct ctx_rq_wait. The count starts at table->nr, each
> killed context drops one count in free_ioctx_reqs() and exit_aio()
> subtracts the empty slots afterwards. Whoever drops the last count
> either calls complete() or, if it is exit_aio(), skips the wait.
> 
> With a full table skipped is zero and atomic_sub_and_test(0, ...) only
> tells us whether the count already hit zero. free_ioctx_reqs() runs from
> the percpu_ref RCU callback, so if exit_aio() is off the CPU long enough
> the last callback can have done its atomic_dec_and_test() but not yet
> called complete():
> 
>     free_ioctx_reqs()                    exit_aio()
>     atomic_dec_and_test() // 1 -> 0
>                                          atomic_sub_and_test(0) // true
>                                          kfree(table)
>                                          return
>     complete(&wait.comp)
> 
> complete() then locks and writes a completion on a stack frame that is
> gone. So hold an extra count for exit_aio() itself. Then the last count
> is always dropped by exit_aio() after it waited, or by a callback while
> exit_aio() waits for it. An unprivileged user gets there with four
> io_setup() calls and an exit without io_destroy().
> 
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Fixes: dc48e56d7616 ("aio: fix serial draining in exit_aio()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/aio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index bf002a9d2ad7..8cf02878a3cc 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -961,7 +961,7 @@ void exit_aio(struct mm_struct *mm)
>  	if (!table)
>  		return;
>  
> -	atomic_set(&wait.count, table->nr);
> +	atomic_set(&wait.count, table->nr + 1);
>  	init_completion(&wait.comp);
>  
>  	skipped = 0;
> @@ -985,7 +985,7 @@ void exit_aio(struct mm_struct *mm)
>  		kill_ioctx(mm, ctx, &wait);
>  	}
>  
> -	if (!atomic_sub_and_test(skipped, &wait.count)) {
> +	if (!atomic_sub_and_test(skipped + 1, &wait.count)) {
>  		/* Wait until all IO for the context are done. */
>  		wait_for_completion(&wait.comp);
>  	}
> 
> ---
> base-commit: b44341e39d856e4cc6ad8ed94ebffd440f39846c
> change-id: 20261030-work-aio-exit_aio-bf74801d34b4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
