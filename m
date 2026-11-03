Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717266;
	b=G70SRpHQS0yNAA335hlps7tt8owKGtuhVabgi/IAeIzGXg08ZhRNKd52VPQRkqybnLlr
	 npc3djLOmV6LXPzG3e2jCKW0IA98kiBKSFcIZEZP1kOOC03U8coaCfaNr/AwoJiDkMkWe
	 YSxptu7u1Q8PshlmaOg/PwYqTE2rbVNzTxyiV+bjj/UkkTE4PwnumatVmsspgsE2UMR78
	 KJuv9qbsWu+1wqVZwxrnPdOhY3nEfijk/2F9/LwbzXxk/RBRkduEo0s/8leyu2LN9fJet
	 MldcOkAAFPjQMKGJ/tDFz8TaDVcsR3zEH+iBppOoE3TBsuHh3KF/tzEtsOnetIfgthg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717266;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=YXoxe9Qu1Hj58tp1tyj5bOciDNUA04IKDc8QcBHrpJQ=;
	b=YOwP0s0fQmJNQ0xnvy1snfDAPfApqmaGtqDrkgyXNKbahHy2vb6IojeWS14YLS6ksh9R
	 t+zKkKQAPsEcDNHW6GZpexLQMssH63JVa+lSpEECziNLKhtVqUIa8y3BYRw+h4FIDlU6L
	 RwhvUhuU9gUt0H9L7tMAItIhCXF7g0k/nY2esSqF1WJzOYk0s7J3oY+LtjH2kIhE5+9ll
	 /NEFW1JDTR/2c0a4m0lPFdyey6To4vTeWyBuhr+Hr8k+HvwM3NxyN86+ZnlXb2mOEfZky
	 /qADnCvZcfOLmKu3AH6fjyCFyJL2/UV+jG5+Z7MG4xcAxjzI1k380Yl998Mu7t0zovQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="l146/vAv";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Nd+qNEc8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="l146/vAv";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Nd+qNEc8;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A409606EEB5;
	Tue,  3 Nov 2026 14:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A409606EEB5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=l146/vAv;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Nd+qNEc8;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=l146/vAv;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Nd+qNEc8
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B4A181F7B3;
	Tue,  3 Nov 2026 14:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793717263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YXoxe9Qu1Hj58tp1tyj5bOciDNUA04IKDc8QcBHrpJQ=;
	b=l146/vAvG+RenZpah+7v/7sa3kSzL+7HKVNYrHTh/f2yqQULm9RruhbL4FtF4aGkPTy2oq
	Z305kB6Kyv57jY4kgMGMuOA/94iAi/Hsrcd01Urh9KmLZeJVBFFxxy4zsfeiiEFiDvv/Is
	x/0xEf6DIzyJHWsCShgmZAVflluNJLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793717263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YXoxe9Qu1Hj58tp1tyj5bOciDNUA04IKDc8QcBHrpJQ=;
	b=Nd+qNEc89D7jSbkRX8UkGLWtgWMYHHz++qtEIzAOt5GNq+XvQuTFRKz8z/RKUbWAFU8JH4
	bgCxv6S8HqUB0sBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793717263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YXoxe9Qu1Hj58tp1tyj5bOciDNUA04IKDc8QcBHrpJQ=;
	b=l146/vAvG+RenZpah+7v/7sa3kSzL+7HKVNYrHTh/f2yqQULm9RruhbL4FtF4aGkPTy2oq
	Z305kB6Kyv57jY4kgMGMuOA/94iAi/Hsrcd01Urh9KmLZeJVBFFxxy4zsfeiiEFiDvv/Is
	x/0xEf6DIzyJHWsCShgmZAVflluNJLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793717263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YXoxe9Qu1Hj58tp1tyj5bOciDNUA04IKDc8QcBHrpJQ=;
	b=Nd+qNEc89D7jSbkRX8UkGLWtgWMYHHz++qtEIzAOt5GNq+XvQuTFRKz8z/RKUbWAFU8JH4
	bgCxv6S8HqUB0sBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69B371350A;
	Tue,  3 Nov 2026 14:47:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MW8OEQ/06WroEgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 03 Nov 2026 14:47:43 +0000
Date: Tue, 03 Nov 2026 15:47:39 +0100
Message-ID: <87zevqvuno.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sonali Pradhan <sonalipradhan@google.com>
Cc: nkapron@google.com,
	gregkh@linuxfoundation.org,
	tiwai@suse.de,
	balbi@kernel.org,
	jeffinphilip14@gmail.com,
	victor.krawiec@arturia.com,
	fanwu01@zju.edu.cn,
	christophe.jaillet@wanadoo.fr,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_midi: fix UAF race during IN request handling
In-Reply-To: <20261028074821.579450-1-sonalipradhan@google.com>
References: <20261028074821.579450-1-sonalipradhan@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,wanadoo.fr];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,suse.de,kernel.org,gmail.com,arturia.com,zju.edu.cn,wanadoo.fr,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -12.30

On Wed, 28 Oct 2026 08:48:21 +0100,
Sonali Pradhan wrote:
> 
> f_midi_disable() drains and frees pre-allocated IN requests from
> in_req_fifo without holding midi->transmit_lock. If f_midi_transmit()
> runs concurrently on the workqueue, f_midi_do_transmit() can peek a
> request from in_req_fifo and write into its buffer while
> f_midi_disable() frees it, leading to a use-after-free.
> 
> Additionally, when usb_ep_queue() fails in f_midi_do_transmit() (such
> as with -ESHUTDOWN when the endpoint is disabled concurrently), it
> resets req->length = 0 and returns active instead of the error code,
> causing the do-while loop in f_midi_transmit() to keep spinning under
> midi->transmit_lock until the substream is drained.
> 
> Fix this by acquiring midi->transmit_lock in f_midi_disable() while
> releasing IN requests from in_req_fifo, and returning the error code
> from f_midi_do_transmit() when usb_ep_queue() fails so f_midi_transmit()
> aborts immediately and drops active substreams.
> 
> Fixes: e1e3d7ec5da3 ("usb: gadget: f_midi: pre-allocate IN requests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sonali Pradhan <sonalipradhan@google.com>

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi


> ---
> Changes in v2:
> - Remove the transmit_lock and ep->enabled checks added in v1 from
>   f_midi_complete() and f_midi_transmit().
> - Return error code from f_midi_do_transmit() when usb_ep_queue() fails
>   so f_midi_transmit() aborts the loop immediately.
> - Link to v1: https://lore.kernel.org/all/20261019135701.2767078-1-sonalipradhan@google.com/
> 
>  drivers/usb/gadget/function/f_midi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> index 63fb6ee70a3d..48cda34399e8 100644
> --- a/drivers/usb/gadget/function/f_midi.c
> +++ b/drivers/usb/gadget/function/f_midi.c
> @@ -420,6 +420,7 @@ static void f_midi_disable(struct usb_function *f)
>  	struct f_midi *midi = func_to_midi(f);
>  	struct usb_composite_dev *cdev = f->config->cdev;
>  	struct usb_request *req = NULL;
> +	unsigned long flags;
>  
>  	DBG(cdev, "disable\n");
>  
> @@ -431,8 +432,10 @@ static void f_midi_disable(struct usb_function *f)
>  	usb_ep_disable(midi->out_ep);
>  
>  	/* release IN requests */
> +	spin_lock_irqsave(&midi->transmit_lock, flags);
>  	while (kfifo_get(&midi->in_req_fifo, &req))
>  		free_ep_req(midi->in_ep, req);
> +	spin_unlock_irqrestore(&midi->transmit_lock, flags);
>  
>  	f_midi_drop_out_substreams(midi);
>  }
> @@ -661,6 +664,7 @@ static int f_midi_do_transmit(struct f_midi *midi, struct usb_ep *ep)
>  		ERROR(midi, "%s failed to queue req: %d\n",
>  		      midi->in_ep->name, err);
>  		req->length = 0; /* Re-use request next time. */
> +		return err;
>  	} else {
>  		/* Upon success, put request at the back of the queue. */
>  		kfifo_skip(&midi->in_req_fifo);
> -- 
> 2.56.0.307.g5fe7bd680c-goog
