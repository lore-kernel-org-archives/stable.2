Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4036424D42
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577870; cv=none; b=MOv8pTZKPF0j4I20tJ48GpWgI7xUn0YD01C90uq8TG3COarcANJZTdAwLlNiwBRfZoJpqN/+tyN/3YAFl1K+ozdfwge8eSiGIDBspTapILKJ9irnxkwmpGFkcSPbSV9JFNJ+RzrrG7mahXH+QcJnL3E+aZ53UgVrFmYQKSilIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577870; c=relaxed/simple;
	bh=KaQnsdE6H06P8oE6V/KnERQMPaPGiIIg/0UB0AGAcu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CtGHX2TWDazZUOxQarYXMMgO0XcLDygTsglndE96jirH87PCQpnPd5ysze5KZlS/8ylCXw05skD2yQJ19PQYI6PU/Mj2zl8103W4tKjyqwlVEkuTfFYquJvMd77STH0NYfVyBUNGB/UwGLsTUze88FBpWtO+zEE5PcNlHdeVzck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TydSa9rv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DzsQZsRV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IBHyS1aL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2Z1h2mK5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TydSa9rv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DzsQZsRV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IBHyS1aL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2Z1h2mK5"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D93711F795;
	Mon, 24 Aug 2026 13:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787577849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tmlYurk9glRoMkGr8JuVJLc/yGmp5DspqaHQBCgIxwQ=;
	b=TydSa9rvu6aqmntB8lnGh3MnS5EsFR+yWgomVf9JC9c9HUnFE8MUQHPnzJXwhL25wV0oMB
	T5Qe2na7+7hoj8D7agncgAEnfoY/KIbXnfufuTZ1XC+9r/jaTc+KMPRIVgQXiMiDcKdcNg
	jr9hZlHV7xbuFCQZY4GUQ3ZMFH6kbUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787577849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tmlYurk9glRoMkGr8JuVJLc/yGmp5DspqaHQBCgIxwQ=;
	b=DzsQZsRVHKbwO/OTKQcrE45O5TVIwBAgSL3viA1ikoGJAqqOCqVf9T1lh16ywEQN+X/IAH
	pXDE55D5EaWZquDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787577844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tmlYurk9glRoMkGr8JuVJLc/yGmp5DspqaHQBCgIxwQ=;
	b=IBHyS1aLQjJV2JGROGIPJ5LiO0kb00F5ewsCGR0cT4p/4KPn+VKOG+amoccyIWsNy369e1
	gXRj/l9ye/QugYWHuqOFU7O95gYTgovHNYS0RLPVG18ZOo4SYuycjqAj4bPL67k0So549x
	4R5m44k4Wx2jhlOG9kQBqOcqoimvIsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787577844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tmlYurk9glRoMkGr8JuVJLc/yGmp5DspqaHQBCgIxwQ=;
	b=2Z1h2mK5+xGg2emN/zQJr5icH2Rxhwgn2vS02D+543Y5Ayg4czLRukFOpD15PD7SaI2cvf
	4xDTW7EYOVhp4IDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A56313331;
	Mon, 24 Aug 2026 13:24:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p8aSBvRFjGrXVgAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 24 Aug 2026 13:24:04 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Laxman Acharya <acharyalaxman8848@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, Laxman Acharya Padhya
 <acharyalaxman8848@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] io_uring/query: cap user size passed to
 copy_struct_to_user
In-Reply-To: <20260821103317.91437-1-acharyalaxman8848@gmail.com>
Organization: SUSE
References: <20260821103317.91437-1-acharyalaxman8848@gmail.com>
Date: Mon, 24 Aug 2026 09:24:01 -0400
Message-ID: <87wltfslce.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.dk];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Laxman Acharya <acharyalaxman8848@gmail.com> writes:

> From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
>
> io_handle_query_entry() clamps hdr.size for the inbound copy_from_user()
> but keeps the original user value as usize. copy_struct_to_user() uses
> that usize and, when it is larger than the kernel result, clear_user()s
> the trailing bytes.
>
> As hdr.size is a __u32, a query can request nearly 4 GiB of zeroing,
> including on the error path where res_size stays 0. The interface is
> reachable without a ring via IORING_REGISTER_QUERY.
>
> Reject sizes larger than PAGE_SIZE, as recommended for copy_struct_*
> interfaces.
>
> Fixes: c265ae75f900 ("io_uring: introduce io_uring querying")
> Cc: stable@vger.kernel.org # 6.18+
> Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>

Looks good. feel free to add:

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>

> ---
>  io_uring/query.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/io_uring/query.c b/io_uring/query.c
> index 88a325736992..f2b5e19e5af6 100644
> --- a/io_uring/query.c
> +++ b/io_uring/query.c
> @@ -76,6 +76,9 @@ static int io_handle_query_entry(union io_query_data *data, void __user *uhdr,
>  
>  	if (copy_from_user(&hdr, uhdr, sizeof(hdr)))
>  		return -EFAULT;
> +	/* copy_struct_to_user() zeros up to usize bytes */
> +	if (hdr.size > PAGE_SIZE)
> +		return -E2BIG;
>  	usize = hdr.size;
>  	hdr.size = min(hdr.size, IO_MAX_QUERY_SIZE);
>  	udata = u64_to_user_ptr(hdr.query_data);
> -- 
> 2.51.2

-- 
Gabriel Krisman Bertazi
