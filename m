Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882008;
	b=XHWaQl3Z5P0sdKI4RBwp28VVKQbtNXwi5/4oevFIsl/ioHtrn15XESnW9m6FeIehTpfg
	 g2Piaobu4z5XgJv8ldnDL6qXBv3E2CVjRIHotzJHa+do0VVaIftRH3phXEThcmGWIwCks
	 MBEOec6asSm6j1WRdPMQtepaEXZg39m053EiUFvu1fWup56SzNhNxkdgEmcd4ldgmmBP1
	 q35XLvcGBuc6do10exTpQJ1zcrl816pTDqn5nDTZECctj7ifcnhZDaXgh6cITF0cRkP8K
	 VCMQaocx7i3cZYrSDed/4ffqIcLhc0BHHxitWWrWgsGkoiOrZ6P9HuhyOmn0kgesW4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882008;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=399TihSEoNYgth+6wVnQYzG17uXV0lxIYTXFWph8MJw=;
	b=0Nc/sodpAptOHQ6H/LQRppt//nLIS7kkfgR5NGkyB5Y6+afdpQkDKfkI4JJyAYmI6UH4
	 /RE2MuNHeEFONdiwUKG1EYWcACRbO2IQl2LOrfnJ9jy1mqxQbM+LefiqNQBf8P3n+z3Qa
	 x7vpeZPh1FEUf15i007WIdHVGM5Kf5C9gWqx8j83sLG8zqpe6UHD9GYspPzXRUR/PM0i/
	 TTUqJ+sa+YEWwSATYGvqAzXNo5uDjxLQbxKTjrhy42fg31DR/GiaCcpKI3U0EHTaJAfYj
	 I7eROXOCve+N9rHUGvSKoIo0GMDr+giMsI67pUUwtL9PUul5aHbXeCnBxigajXSe6ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=w8z6FbOY;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iqs4PIZq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=w8z6FbOY;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iqs4PIZq;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13DA606A32E
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C13DA606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=w8z6FbOY;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iqs4PIZq;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=w8z6FbOY;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iqs4PIZq
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E405821FB0;
	Thu,  5 Nov 2026 12:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793881998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=399TihSEoNYgth+6wVnQYzG17uXV0lxIYTXFWph8MJw=;
	b=w8z6FbOYfxPCfpPyRo8fo9S5VcCI0qVhqe7YT1pPtFEMGd/3szBKK9zHo82Hn6L/F42ckJ
	gNNPNtgkV6sVnZuRl2rz4eVWBLAOLJNSoEigFrny7UedOyJgyWWwvJx41LMC4StVX+WeRd
	4PIxkUGlpjplbwMmoZTw66+rsgYv/Kk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793881998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=399TihSEoNYgth+6wVnQYzG17uXV0lxIYTXFWph8MJw=;
	b=iqs4PIZqE+DvP5T/3xiMqirTuMFp6TH5Tw6JOoxhYlLK7Zv4G3KnSDAWifAMVXG5pxJciH
	aHo5g6F361m4otBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793881998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=399TihSEoNYgth+6wVnQYzG17uXV0lxIYTXFWph8MJw=;
	b=w8z6FbOYfxPCfpPyRo8fo9S5VcCI0qVhqe7YT1pPtFEMGd/3szBKK9zHo82Hn6L/F42ckJ
	gNNPNtgkV6sVnZuRl2rz4eVWBLAOLJNSoEigFrny7UedOyJgyWWwvJx41LMC4StVX+WeRd
	4PIxkUGlpjplbwMmoZTw66+rsgYv/Kk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793881998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=399TihSEoNYgth+6wVnQYzG17uXV0lxIYTXFWph8MJw=;
	b=iqs4PIZqE+DvP5T/3xiMqirTuMFp6TH5Tw6JOoxhYlLK7Zv4G3KnSDAWifAMVXG5pxJciH
	aHo5g6F361m4otBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23355133F6;
	Thu,  5 Nov 2026 12:33:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9DzeOo137GoDLQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 05 Nov 2026 12:33:18 +0000
Date: Thu, 5 Nov 2026 12:33:16 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: willy@infradead.org, jack@suse.cz, akpm@linux-foundation.org, 
	kas@kernel.org, dave.hansen@linux.intel.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] filemap: prefault writes starting beyond EOF
Message-ID: <aux0ruR5HpMBMPI2@pedro-suse.tail5790ac.ts.net>
References: <20261104071002.49693-1-dennylin0707@gmail.com>
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
In-Reply-To: <20261104071002.49693-1-dennylin0707@gmail.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30

On Wed, Nov 04, 2026 at 07:10:02AM +0000, Hungyu Lin wrote:
> Since prefaulting moved to the slow write path, a buffered write can reach
> ->write_begin() and ->write_end() before discovering that its source buffer
> is unreadable. Several filesystems can extend i_size in these callbacks
> even when no data was copied. For example, a one-byte pwrite() at offset
> 4096 into an empty file can fail with EFAULT but leave a 4096-byte file.

I've been following this discussion rather passively on the other thread, so
I'll ask my stupid question: Why is this a problem? Yes, it's a bit of
weird behavior, but system calls are generally not expected to behave
super sanely in the case of bad input/weird errors.

> 
> Prefault the source before ->write_begin() when the write position is
> beyond EOF, and return EFAULT if no source bytes can be made readable.
> Overwrites and appends continue to skip this prefault. Keep the existing
> slow-path faulting for forward progress after a failed atomic copy.
> 
> This also leaves intentional zero-length ->write_end() calls used by
> generic_cont_expand_simple() unchanged. As with the previous prefaulting
> behavior, a concurrent userspace unmap can still race with the later copy.

Ok, so it's still racy? What do you do if you can't fault it in at all?
You still get a hole?

> 
> Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
> Reported-by: Kiryl Shutsemau <kas@kernel.org>
> Closes: https://lore.kernel.org/linux-mm/at9xXRhD2xZhszEj@thinkstation/
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Link: https://lore.kernel.org/all/at-XtWBQg3jv3H8Z@thinkstation/
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
> 
>  mm/filemap.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b74bc1e5015c6f318333427f223b9f42061a6213..30414d55412b84f11ebe98b8eea607ee8c04eef5 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4389,6 +4389,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>  			break;
>  		}
>  
> +		/*
> +		 * Some filesystems can extend i_size even when nothing was copied.
> +		 * Prefault writes beyond EOF to catch unreadable source buffers.
> +		 */
> +		if (unlikely(pos > i_size_read(mapping->host)) &&
> +		    fault_in_iov_iter_readable(i, bytes) == bytes) {

I say this doesn't matter, and if you pass insane inputs you get
insane outputs. Even more so considering this is racy, e.g races
against munmap(), mremap(), mprotect(), memory poisoning, and other things
like truncated memory mapped files sending out a SIGBUS (or uffd) :)

I don't think it makes to add random prefault loops in hopes this makes
for saner semantics.

-- 
Pedro
