Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FB54BC022;
	Thu,  3 Sep 2026 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447332; cv=none; b=tkzOF87gjYwchdIrpuOnMtKr8G2yyLvDlMqTlo0UhfIPdgaUUv6zsKLJF6qM8jTKNbBLzwMUFKw7V+RlFA844fU0WWTVYRUYyqv0rb54sEPeBXOIRK89wx/dyt4cvo8oUEiS8MrN8v4+Ya5pOtSoZ10futJck3+Nt1GVqRCR47I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447332; c=relaxed/simple;
	bh=dMAVsBKsZQ7Ik69y/mvFH6kBKvXIlz1hQPHV8YuEXVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KHANwkosFPeY4BJc4SpC2Tdxk11nOGpbtwKzCG25T68yM9R6lEZXO/52qnhbSG79wo5Ny0pvLE7grevp2h8aQ5JkgVQDRiCJ3gj3eP4LlNhN6Wh/C7KeR3Vyj1pDXq+4N9iZtqvnlIWxXQbCCsaVb7FbwJTixwbv3xCvKgpdxeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s5fDDOH/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FtsB/wZA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ALDL6KUu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LjHNPKsr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s5fDDOH/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FtsB/wZA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ALDL6KUu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LjHNPKsr"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BC5B1FB75;
	Thu,  3 Sep 2026 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788447319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ouYq8jEG/YnOzue8Ui4hUUZcZuiA7sjGHnKRkO31T/k=;
	b=s5fDDOH/CRuRHIc4OZuZqrbAcHSMlNS2p88e04exkBQ5yaibKC5sFI+R6Vk0JRl7U+lMxa
	iwtVbfvmGqfPOuruwwEW5EaNrtzjDgDYQzEFtt8WlCjyeES0hnZtcQ6bThJJm6FToJu16l
	a28+zBkQuoRP67q8Yg8xyhgF2WfXcds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788447319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ouYq8jEG/YnOzue8Ui4hUUZcZuiA7sjGHnKRkO31T/k=;
	b=FtsB/wZAMY5oob7JwCjJv+FhiUwecqszK+uoyIiY44MwgI8vNGlzqht9EyR2uwbVBVAtyM
	F2L45CF6EyB4GJDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ALDL6KUu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LjHNPKsr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788447315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ouYq8jEG/YnOzue8Ui4hUUZcZuiA7sjGHnKRkO31T/k=;
	b=ALDL6KUub4ChAr93EzfllCpbBa/bmdO4/Siqkuqm30KFTS17ktwjsPuZtFNlzxK/oM8fHT
	NdtmxhIk3AZud+syZbdfjYSnl/jwmmtR95kdRnvycraFQoA2UBMeFlAtTKtw15BxgUCHqY
	5yAvvtZuzeK/fV5W6DhCVBOEXBdz2iA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788447315;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ouYq8jEG/YnOzue8Ui4hUUZcZuiA7sjGHnKRkO31T/k=;
	b=LjHNPKsrVSoliqlCO/vsZc+BjLalIUt38bgAOCFL0FlSlWbrNVRC4jkV5i++QMLQGEhy5j
	K5QDQGZEZp+ZO3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62C58136D9;
	Thu,  3 Sep 2026 14:55:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p/C2K1GKmWqkLwAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 03 Sep 2026 14:55:13 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Aohan Mei <ljp1205831794@gmail.com>, io-uring@vger.kernel.org
Cc: axboe@kernel.dk, Aohan Mei <henrymei@tencent.com>, TencentOS Corvus AI
 <corvus@tencent.com>, stable@vger.kernel.org
Subject: Re: [PATCH] io_uring/net: commit all consumed buffers on bundle
 recv retry
In-Reply-To: <20260902022552.1890610-1-ljp1205831794@gmail.com>
Organization: SUSE
References: <20260902022552.1890610-1-ljp1205831794@gmail.com>
Date: Thu, 03 Sep 2026 11:55:06 -0300
Message-ID: <87o6ee5qr9.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3BC5B1FB75
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51

Aohan Mei <ljp1205831794@gmail.com> writes:

> From: Aohan Mei <henrymei@tencent.com>
>
> For a bundle receive (IORING_RECVSEND_BUNDLE) using a provided
> buffer ring, the initial issue peeks N buffers and defers the
> commit via REQ_F_BUFFERS_COMMIT. If MSG_WAITALL (or a short read
> on a streaming socket) yields a partial result,
> io_net_kbuf_recyle() commits only the buffers covering that first
> partial round and clears REQ_F_BUFFERS_COMMIT. On subsequent poll
> armed retries, sel.buf_list is reset to NULL while
> REQ_F_BUFFER_RING prevents re-selection, so neither the retry
> rounds nor the final io_recv_finish() -> io_put_kbufs() ever
> commit the remaining buffers that have already been written to.
>
> This leaves bl->head accounting for only the first partial round
> rather than all consumed buffers. Buffers that already hold
> received data stay visible in the ring and are handed out again
> to later requests, corrupting or dropping application data.
>
> Defer the commit entirely: do not commit in io_net_kbuf_recyle(),
> keeping REQ_F_BUFFERS_COMMIT set for the final completion; recover
> the buffer list on retry so the final commit has it available; and
> derive the number of committed buffers from the total received
> bytes rather than the final round, so a short last read cannot
> under-count.
>
> Fixes: 41b70df5b38b ("io_uring/net: commit partial buffers on retry")
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Cc: stable@vger.kernel.org
> Assisted-by: CodeBuddy:Kimi-K3
> Signed-off-by: Aohan Mei <henrymei@tencent.com>
> ---
>  io_uring/kbuf.c | 4 ++--
>  io_uring/kbuf.h | 2 ++
>  io_uring/net.c  | 7 ++++---
>  3 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
> index 7c309173dd19..c4bae8f00173 100644
> --- a/io_uring/kbuf.c
> +++ b/io_uring/kbuf.c
> @@ -76,8 +76,8 @@ bool io_kbuf_commit(struct io_kiocb *req,
>  	return true;
>  }
>  
> -static inline struct io_buffer_list *io_buffer_get_list(struct io_ring_ctx *ctx,
> -							unsigned int bgid)
> +struct io_buffer_list *io_buffer_get_list(struct io_ring_ctx *ctx,
> +					  unsigned int bgid)
>  {
>  	lockdep_assert_held(&ctx->uring_lock);
>  
> diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
> index 401773e1ef80..7079f2dec9e0 100644
> --- a/io_uring/kbuf.h
> +++ b/io_uring/kbuf.h
> @@ -71,6 +71,8 @@ struct io_br_sel io_buffer_select(struct io_kiocb *req, size_t *len,
>  				  unsigned buf_group, unsigned int issue_flags);
>  int io_buffers_select(struct io_kiocb *req, struct buf_sel_arg *arg,
>  		      struct io_br_sel *sel, unsigned int issue_flags);
> +struct io_buffer_list *io_buffer_get_list(struct io_ring_ctx *ctx,
> +					  unsigned int bgid);
>  int io_buffers_peek(struct io_kiocb *req, struct buf_sel_arg *arg,
>  		    struct io_br_sel *sel);
>  void io_destroy_buffers(struct io_ring_ctx *ctx);
> diff --git a/io_uring/net.c b/io_uring/net.c
> index fbe719d86c46..bff4514c0100 100644
> --- a/io_uring/net.c
> +++ b/io_uring/net.c
> @@ -483,8 +483,6 @@ static int io_net_kbuf_recyle(struct io_kiocb *req, struct io_buffer_list *bl,
>  			      struct io_async_msghdr *kmsg, int len)
>  {
>  	req->flags |= REQ_F_BL_NO_RECYCLE;
> -	if (req->flags & REQ_F_BUFFERS_COMMIT)
> -		io_kbuf_commit(req, bl, len, io_bundle_nbufs(kmsg, len));
>  	return IOU_RETRY;
>  }

Hi Aohan,

This looks fishy.  This function no longer commits and recycling is now
basically a nop. but io_send also relies on it.  Doesn't it break the
commit for io_send on a short write?


>  
> @@ -877,7 +875,8 @@ static inline bool io_recv_finish(struct io_kiocb *req,
>  	if (sr->flags & IORING_RECVSEND_BUNDLE) {
>  		size_t this_ret = sel->val - sr->done_io;
>  
> -		cflags |= io_put_kbufs(req, this_ret, sel->buf_list, io_bundle_nbufs(kmsg, this_ret));
> +		cflags |= io_put_kbufs(req, this_ret, sel->buf_list,
> +				       io_bundle_nbufs(kmsg, sel->val));
>  		if (sr->flags & IORING_RECV_RETRY)
>  			cflags = req->cqe.flags | (cflags & CQE_F_MASK);
>  		if (sr->mshot_len && sel->val >= sr->mshot_len)
> @@ -1221,6 +1220,8 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
>  			goto out_free;
>  		}
>  		sr->buf = NULL;
> +	} else if (req->flags & REQ_F_BUFFER_RING) {
> +		sel.buf_list = io_buffer_get_list(req->ctx, sr->buf_group);

I'm not sure, but during a retry, you can drop the ctx lock.  are you
guaranteed to get the same buffer you had before?

-- 
Gabriel Krisman Bertazi
