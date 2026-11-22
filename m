Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795335390;
	b=DUeAD3g0BaOapPygMa5bjA53IogprIWBVINpIuaJ5GZolbBzGrBO77hZsxA2WjOXv7G7
	 crydOFbFNZo0dXqdexZpFajDygSXwYPdlTY7Udcy3Czbkgjtz/ZU6GBLTOCsmcbLv8pyd
	 oUMD5Pz7zxltVcTkSDQrLQ3cYkC04OvZEHLd17wPtx1nFQzYifS899GKjoDuXtCD2JbRN
	 tJypGafD/j5Eq4WFhUobSLRvIItJ0+6qEKQGSojH2zmq0uPIedeZJRe6GmvR3RY4nZBwx
	 j1n5yNBBAaBqEwk/OHp4GFdPfQ/unimTPEXbWMeMQ8xr8+DZULlv70hNsAMGzKL+OYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795335390;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=RBjH7vezKmM7BkdzWaucT95AXfsE3Kk7iHGwB1TIx1I=;
	b=gBjSWcby1Az4YBgdHQK36CcjwbtHmdAD51U9AOqqtjXVGqCSWpcA4HXj0VCzoTzP+izN
	 7UVzaHhtZXIflBsAHslgv614aoxWy601hazJEBHnxBqEcAjkZQ6P2S2H3xDdTmu7e05uO
	 fkASGZ+gbDo3fTZBSJKAGzWi8K/v5xDUVdaZ234A14fZR3a69ENGwSVeAfFphqRLxcKKY
	 YEy1SaMeK1YG6Rsp1+PI6L4FfEhOwWAzHRx1V2Opjz7NszveAoaXXjjwinXY5vW0+76Si
	 V+IuLxDTOWmwvwYE4anJFsr9jtmd5HforaGQy+f4lBo3SCBcBXagjQAjckpkG6fU2ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=so7LnrNp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cE5WuAsd;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=so7LnrNp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cE5WuAsd;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CB4606A330;
	Sun, 22 Nov 2026 08:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75CB4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=so7LnrNp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cE5WuAsd;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=so7LnrNp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cE5WuAsd
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B3051F8CC;
	Sun, 22 Nov 2026 08:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795335387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RBjH7vezKmM7BkdzWaucT95AXfsE3Kk7iHGwB1TIx1I=;
	b=so7LnrNpeu0r7jNX4OIsPsY+T7XvU4vvpVbdPSIgi6LqZZgttFI6MY1hqAZNY9LJDwYtJY
	wKDKzU2OrkEiI4C15cEB2pBaGWMlzeb6oTO6jr7dS84S2tT8NNfV23GCD2Y5oe/3cBE7O/
	9w0DIqJMPXhrLHwqCfpeqr9tXJnES44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795335387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RBjH7vezKmM7BkdzWaucT95AXfsE3Kk7iHGwB1TIx1I=;
	b=cE5WuAsdkrQLctKQUQffYH0E9h9nQV8FgpKIoE+xOQapHAD1fT1Go/R1asdDqrGt4UvZ1+
	c12nmoQP6hWh3HDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795335387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RBjH7vezKmM7BkdzWaucT95AXfsE3Kk7iHGwB1TIx1I=;
	b=so7LnrNpeu0r7jNX4OIsPsY+T7XvU4vvpVbdPSIgi6LqZZgttFI6MY1hqAZNY9LJDwYtJY
	wKDKzU2OrkEiI4C15cEB2pBaGWMlzeb6oTO6jr7dS84S2tT8NNfV23GCD2Y5oe/3cBE7O/
	9w0DIqJMPXhrLHwqCfpeqr9tXJnES44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795335387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RBjH7vezKmM7BkdzWaucT95AXfsE3Kk7iHGwB1TIx1I=;
	b=cE5WuAsdkrQLctKQUQffYH0E9h9nQV8FgpKIoE+xOQapHAD1fT1Go/R1asdDqrGt4UvZ1+
	c12nmoQP6hWh3HDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECFA91342D;
	Sun, 22 Nov 2026 08:16:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VLJDL9qkAmsGZwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 22 Nov 2026 08:16:26 +0000
Date: Sun, 22 Nov 2026 09:16:26 +0100
Message-ID: <87a4n1702t.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH v3] ALSA: line6: Kill URBs before releasing the PCM buffer
In-Reply-To: <20261121104000.5431-1-25031212351@stu.xidian.edu.cn>
References: <20261121104000.5431-1-25031212351@stu.xidian.edu.cn>
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
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -12.30
X-Spam-Level: 
X-Spam-Flag: NO

On Sat, 21 Nov 2026 11:40:00 +0100,
YuanZhe Liu wrote:
> 
> line6_buffer_release() frees the stream buffer after
> line6_wait_clear_audio_urbs() gave up waiting for the URBs that are still
> active.  The buffer is still referenced by those URBs, and the completion
> callback of such an URB resubmits it from submit_audio_out_urb() with
> line6pcm->out.buffer already set to NULL, which ends up in a NULL pointer
> dereference in the memset() in submit_audio_out_urb().
> 
> While the URBs remain queued, the host controller can also write the
> received isochronous data into the freed buffer.  Such a write does not go
> through the KASAN checks, so it silently corrupts the freed slab object;
> the corruption was observed as a bogus KASAN quarantine entry that later
> led to a general protection fault in qlist_free_all().
> 
> The active_urbs bitmap cannot prove that the URBs are gone:
> line6_unlink_audio_urbs() is called outside the stream lock and only marks
> the URBs that are active at that moment, so an URB resubmitted by a
> completion callback right after the scan is never unlinked and keeps being
> resubmitted after the stream was stopped.
> 
> Set the unlink bit for every currently active URB under the stream lock,
> so that the completion callbacks cannot resubmit them, and then kill all
> URBs synchronously.  usb_kill_urb() waits for the giveback, hence the
> buffer is no longer referenced by any URB when it is freed.  Drop the
> unlink marks afterwards: line6_unlink_audio_urbs() can leave a stale mark
> on an URB that completed and was not resubmitted, and such a mark makes
> line6_stream_start() skip submitting the URBs.
> 
> Fixes: 63e20df1e5b2 ("ALSA: line6: Reorganize PCM stream handling")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

Thanks for the patch.

But, this kind of synchronization should be rather done in sync_stop
PCM ops that seems missing in the current LINE6 driver.
 
I guess line6_wait_clear_audio_urbs() could be replaced with
usb_kill_urb() as you've done, and move it to sync_stop callback.
Then it can be dropped from snd_line6_prepare() and
line6_pcm_acquire().  line6_pcm_disconnect() still might need it,
though.


Takashi

> v3:
> - Kill the URBs unconditionally instead of rechecking active_urbs outside
>   the stream lock, and clear the unlink marks after the kills.
> 
> v2:
> - Rebased on sound/for-next.  v1 was generated against v7.3.1 and no longer
>   applied, because line6_buffer_release() gained the prev_fbuf clearing
>   block in the meantime.  No code change.
> ---
>  sound/usb/line6/pcm.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
> index d17baf7761c6..4be3b41a98a2 100644
> --- a/sound/usb/line6/pcm.c
> +++ b/sound/usb/line6/pcm.c
> @@ -134,6 +134,36 @@ static void line6_wait_clear_audio_urbs(struct snd_line6_pcm *line6pcm,
>  			"timeout: still %d active urbs..\n", alive);
>  }
>  
> +/*
> + * Mark all currently active URBs for unlinking and kill them.
> + *
> + * The unlink bit is set under the stream lock, so the completion
> + * callbacks cannot resubmit these URBs any longer.  usb_kill_urb() then
> + * waits for the giveback of every URB, hence the stream buffer is no
> + * longer referenced by the host controller.  The unlink marks are
> + * cleared afterwards, so that a later stream start can submit the URBs
> + * again.  This function must be called from a sleepable context.
> + */
> +static void line6_kill_audio_urbs(struct snd_line6_pcm *line6pcm,
> +				  struct line6_pcm_stream *pcms)
> +{
> +	int i;
> +
> +	scoped_guard(spinlock_irqsave, &pcms->lock) {
> +		for (i = 0; i < line6pcm->line6->iso_buffers; i++)
> +			if (test_bit(i, &pcms->active_urbs))
> +				set_bit(i, &pcms->unlink_urbs);
> +	}
> +
> +	for (i = 0; i < line6pcm->line6->iso_buffers; i++)
> +		if (pcms->urbs[i])
> +			usb_kill_urb(pcms->urbs[i]);
> +
> +	scoped_guard(spinlock_irqsave, &pcms->lock) {
> +		pcms->unlink_urbs = 0;
> +	}
> +}
> +
>  static inline struct line6_pcm_stream *
>  get_stream(struct snd_line6_pcm *line6pcm, int direction)
>  {
> @@ -172,7 +202,7 @@ static void line6_buffer_release(struct snd_line6_pcm *line6pcm,
>  {
>  	clear_bit(type, &pstr->opened);
>  	if (!pstr->opened) {
> -		line6_wait_clear_audio_urbs(line6pcm, pstr);
> +		line6_kill_audio_urbs(line6pcm, pstr);
>  		if (pstr == &line6pcm->in) {
>  			/* prev_fbuf points into the capture buffer we are about
>  			 * to free; drop it while no capture URB is in flight.
> -- 
> 2.34.1
> 
