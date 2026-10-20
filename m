Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487220;
	b=UK0UNglEl8P21aIGgoGs+R/l82c2otw5gI7Opnq1I963ozurYkx6R7qhRr84E7TEgcua
	 Gwzq04BBnzC2SPbFpJbCmx+uXxNH/eE1aV/Xm7J5o3NhID1QIEBNimHha/NsBgaE+Ky4G
	 IEOq52e+VWCkN9wuWhF1Po/oj0jj1a1Ngk9zpqTUjPQU1b/Guq96TwwY/VDsk/Fm6CGTk
	 d/9O/VUKsRb0rYfrbZhBTR4RLqCF0WjecQzoKCZ70OXjc9h2kxIiNqVnV12xWAtXl1TgI
	 Klc3lEne6J+vmnLxWrURY2gh7YKfnMNgNwWrJfFPFtvIrxx2bfeR/Yrj06RkEAg8ICw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487220;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Spamd-Result;
	bh=xwINHTgCnT1vCZQIZe0JyVWtSi5Ffah6jz5uwd0618g=;
	b=UAZu2+PU/ZBsOnmWQnDGG4EKQQZgNkQNua/yqDDk3lOO3I6e+n9OoMfnK1zyDUjSsvWG
	 mDw+fkDeQn06F0v81ZPZU4RABX25oq99qCc7bkAh+UrWAbPm4D+GfGdxP3iZp+6xnqMKl
	 eoGDy6GgpQ32ikCWkTy23FE5CZ/EyVKQld8UhSXKo2eGF8AkScLwJiVSbd+WpFLSUti7H
	 48hQH5650BobYHPWBy38+5taDUIyVX3642FKFQoGOkl3ei+ECAu5rA9UCHV+lB5llcmQX
	 eOMyrazrJl2fAaMrVZ4B9JjMdkkeTfc5indpEiEJM7OX/pebRGLT2MSKZ/eSU5ZQAWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CBT7h19t;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6lpblSgq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CBT7h19t;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6lpblSgq;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EFB606A319;
	Tue, 20 Oct 2026 09:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50EFB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CBT7h19t;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6lpblSgq;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CBT7h19t;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6lpblSgq
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B2B991F451;
	Tue, 20 Oct 2026 09:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792487218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xwINHTgCnT1vCZQIZe0JyVWtSi5Ffah6jz5uwd0618g=;
	b=CBT7h19tzNPggCOvECubxz18UsTXHXvN2iYF9nGzhd1Rciwtx50MtWPXfYfdQMpA2BqiHV
	6ZsO1JFvHvQKht+0wqfzQ8xXgsv3/MNlHDi+wtl/rnKcrDXY6fLy+b1+7IqFkGf5RLM11n
	tNDl+IWt0EK3yY8PxEDCkOUvmpGVCXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792487218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xwINHTgCnT1vCZQIZe0JyVWtSi5Ffah6jz5uwd0618g=;
	b=6lpblSgqsRfzMEeHoHQfLNmEKP3tNMmwfJbvNwtTP6DQAi82Y99X45y6mtlyJ6HvhC/IQW
	ruxklm15vZQOjlBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792487218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xwINHTgCnT1vCZQIZe0JyVWtSi5Ffah6jz5uwd0618g=;
	b=CBT7h19tzNPggCOvECubxz18UsTXHXvN2iYF9nGzhd1Rciwtx50MtWPXfYfdQMpA2BqiHV
	6ZsO1JFvHvQKht+0wqfzQ8xXgsv3/MNlHDi+wtl/rnKcrDXY6fLy+b1+7IqFkGf5RLM11n
	tNDl+IWt0EK3yY8PxEDCkOUvmpGVCXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792487218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xwINHTgCnT1vCZQIZe0JyVWtSi5Ffah6jz5uwd0618g=;
	b=6lpblSgqsRfzMEeHoHQfLNmEKP3tNMmwfJbvNwtTP6DQAi82Y99X45y6mtlyJ6HvhC/IQW
	ruxklm15vZQOjlBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C14F136CC;
	Tue, 20 Oct 2026 09:06:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2iNZCTIv12qzZQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 20 Oct 2026 09:06:58 +0000
Date: Tue, 20 Oct 2026 11:06:57 +0200
Message-ID: <87a4o8ivv2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sonali Pradhan <sonalipradhan@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neill Kapron <nkapron@google.com>,
	Takashi Iwai <tiwai@suse.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Fan Wu <fanwu01@zju.edu.cn>,
	Victor Krawiec <victor.krawiec@arturia.com>,
	Felipe Balbi <balbi@ti.com>,
	"Felipe F. Tonello" <eu@felipetonello.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] usb: gadget: f_midi: fix UAF race during IN request handling
In-Reply-To: <20261019135701.2767078-1-sonalipradhan@google.com>
References: <20261019135701.2767078-1-sonalipradhan@google.com>
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
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,suse.de,wanadoo.fr,zju.edu.cn,arturia.com,ti.com,felipetonello.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Mon, 19 Oct 2026 15:57:01 +0200,
Sonali Pradhan wrote:
> 
> f_midi_disable() frees pre-allocated IN requests from in_req_fifo
> without holding midi->transmit_lock. Concurrent f_midi_transmit() or
> f_midi_complete() calls can then access these request buffers after they
> are freed, leading to a use-after-free.
> 
> Fix this by acquiring midi->transmit_lock in f_midi_disable() while
> releasing IN requests, and checking ep->enabled under midi->transmit_lock
> in f_midi_transmit() and f_midi_complete() before modifying requests.
> 
> Fixes: e1e3d7ec5da3 ("usb: gadget: f_midi: pre-allocate IN requests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sonali Pradhan <sonalipradhan@google.com>
> ---
> Resending and rebasing on latest linux-next as I haven't received
> feedback on my initial submission:
> https://lore.kernel.org/all/20260819102709.212646-1-sonalipradhan@google.com/
> 
>  drivers/usb/gadget/function/f_midi.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> index 63fb6ee70a3d..c26d04eb9209 100644
> --- a/drivers/usb/gadget/function/f_midi.c
> +++ b/drivers/usb/gadget/function/f_midi.c
> @@ -280,9 +280,18 @@ f_midi_complete(struct usb_ep *ep, struct usb_request *req)
>  			/* We received stuff. req is queued again, below */
>  			f_midi_handle_out_data(ep, req);
>  		} else if (ep == midi->in_ep) {
> +			unsigned long flags;
> +
>  			/* Our transmit completed. See if there's more to go.
>  			 * f_midi_transmit eats req, don't queue it again. */
> +			spin_lock_irqsave(&midi->transmit_lock, flags);
> +			if (!ep->enabled) {
> +				spin_unlock_irqrestore(&midi->transmit_lock, flags);
> +				return;
> +			}
>  			req->length = 0;
> +			spin_unlock_irqrestore(&midi->transmit_lock, flags);
> +

Does this transmit_lock help here?  As far as I see, the ep
enable/disable itself is done outside the lock.

> @@ -678,10 +690,11 @@ static void f_midi_transmit(struct f_midi *midi)
>  	unsigned long flags;
>  
>  	/* We only care about USB requests if IN endpoint is enabled */
> -	if (!ep || !ep->enabled)
> -		goto drop_out;
> -
>  	spin_lock_irqsave(&midi->transmit_lock, flags);
> +	if (!ep || !ep->enabled) {
> +		spin_unlock_irqrestore(&midi->transmit_lock, flags);
> +		goto drop_out;
> +	}

Ditto.


thanks,

Takashi
