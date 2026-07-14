Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC433DA7C8
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014942; cv=none; b=FVNgFmVgDGYndFYfGn3rZP+c7U9w41ro6WMv1NNvaZ+R3oHPEAkTKXEAFCc8hwieArYf0h2i4B/J5f7NuSDqB/aDYxmeP/BD45Wlcriqewy1PNYLiGOUb2TI1Mnuuie7Km5muxGKW93JQbmaRa3iflOGwfmiwCl4RBGdGx5DSDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014942; c=relaxed/simple;
	bh=1UVCl5SzEx8F5RS38zfiQUEwERndu9AN2P0HJOWQERE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0XBmi/gZ346tBjS1Bh7tkDNJowDDsy98wXMppD6xWHX54d84TS/3jDoo+ZLe5BJJV8rD7pG2RratUdB+m1i/upDoi868f9JCz9u2Z9lagnpKmHgcsFYHQev7IIp5fT8tbBzXk/7buV3U/KBhWzum2t/SJiKOljAnlgNhoF4tEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SktocTuN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZtMRnGOv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SktocTuN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZtMRnGOv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SktocTuN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZtMRnGOv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SktocTuN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZtMRnGOv"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CDEF877D43;
	Tue, 14 Jul 2026 07:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784014937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnTbA7GhlPQM6AhqTPDoE4nGiTmzPf2D9WJB8lE7ePg=;
	b=SktocTuN9M6l6MFa29iT9xyXn0fMCI9RYcUoolxwTaKbLYLbCv/jVCzPlJrhahoLwJtyGx
	Ja+FIuh8jE4pE7w3WjdP5YrC9wRXYlxyyyxfkQxta9qn0bmrJxzqniO2TE0aD5iqIyL7gF
	1Mz49SHRpXlurzaegsIB4QrrRPc4kVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784014937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnTbA7GhlPQM6AhqTPDoE4nGiTmzPf2D9WJB8lE7ePg=;
	b=ZtMRnGOv7ndcQQYTp+U9dE8F65vk49Qq4zA883sSaP43f2w3gW+eSHS16pqLgfifZ0+s+E
	4VkA/aSDmNv9mZCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784014937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnTbA7GhlPQM6AhqTPDoE4nGiTmzPf2D9WJB8lE7ePg=;
	b=SktocTuN9M6l6MFa29iT9xyXn0fMCI9RYcUoolxwTaKbLYLbCv/jVCzPlJrhahoLwJtyGx
	Ja+FIuh8jE4pE7w3WjdP5YrC9wRXYlxyyyxfkQxta9qn0bmrJxzqniO2TE0aD5iqIyL7gF
	1Mz49SHRpXlurzaegsIB4QrrRPc4kVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784014937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnTbA7GhlPQM6AhqTPDoE4nGiTmzPf2D9WJB8lE7ePg=;
	b=ZtMRnGOv7ndcQQYTp+U9dE8F65vk49Qq4zA883sSaP43f2w3gW+eSHS16pqLgfifZ0+s+E
	4VkA/aSDmNv9mZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D5B3779AE;
	Tue, 14 Jul 2026 07:42:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NFVAJVnoVWpgfwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 14 Jul 2026 07:42:17 +0000
Date: Tue, 14 Jul 2026 09:42:17 +0200
Message-ID: <87se5myq3q.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Takashi Iwai <tiwai@suse.de>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_midi: cancel pending IN work before freeing the midi object
In-Reply-To: <20260709150717.399083-1-fanwu01@zju.edu.cn>
References: <20260709150717.399083-1-fanwu01@zju.edu.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.989];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,zju.edu.cn:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Thu, 09 Jul 2026 17:07:17 +0200,
Fan Wu wrote:
> 
> The f_midi driver embeds a work item (midi->work) whose handler,
> f_midi_in_work(), dereferences the enclosing struct f_midi through
> container_of().  This work is armed from two sites: f_midi_complete(),
> on a normal IN-endpoint completion, and f_midi_in_trigger(), on an ALSA
> rawmidi output-stream start.
> 
> Neither f_midi_disable() nor f_midi_unbind() cancels midi->work.
> f_midi_disable() only disables the endpoints and drains the in_req_fifo;
> it does not synchronize the work item, and the sound card is released
> asynchronously to the final free of the midi object.
> 
> The midi object is reference-counted (midi->free_ref) and is freed in
> f_midi_free() only once both the usb_function reference and the rawmidi
> private_data reference have been dropped.  In f_midi_unbind(),
> f_midi_disable() runs before the sound card is released, so while the
> USB endpoints are already disabled the rawmidi device is still usable by
> an open substream.  A concurrent userspace write on such a substream can
> reach f_midi_in_trigger() and queue midi->work again after
> f_midi_disable() has returned.  A work item armed this way may still be
> pending when the last reference drops and f_midi_free() proceeds to
> kfree(midi), letting f_midi_in_work() dereference the struct after it
> has been freed, a use-after-free.
> 
> For this reason cancelling midi->work in f_midi_disable() would not be
> sufficient: the ALSA trigger path can rearm the work after disable()
> returns.  Cancelling at the refcount-zero free site is the boundary
> after which neither arming source can survive, because by then both
> references that keep the midi object alive have been dropped: the USB
> endpoints are already disabled and the rawmidi device has been released.
> 
> Fix this by calling cancel_work_sync(&midi->work) in the refcount-zero
> block of f_midi_free(), before the embedded work_struct is freed along
> with the rest of the structure.  opts->lock is a sleeping mutex, so
> calling cancel_work_sync() under it is permitted, and the handler takes
> midi->transmit_lock rather than opts->lock, so no self-deadlock can
> occur while it waits for a running instance of the work to finish.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 8653d71ce3763 ("usb/gadget: f_midi: Replace tasklet with work")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>  drivers/usb/gadget/function/f_midi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> index 4d9e4bd70..fba8cf787 100644
> --- a/drivers/usb/gadget/function/f_midi.c
> +++ b/drivers/usb/gadget/function/f_midi.c
> @@ -1309,6 +1309,7 @@ static void f_midi_free(struct usb_function *f)
>  	opts = container_of(f->fi, struct f_midi_opts, func_inst);
>  	mutex_lock(&opts->lock);
>  	if (!--midi->free_ref) {
> +		cancel_work_sync(&midi->work);
>  		kfree(midi->id);
>  		kfifo_free(&midi->in_req_fifo);
>  		kfree(midi);

I guess disable_work_sync() would be even safer in this case.


thanks,

Takashi
