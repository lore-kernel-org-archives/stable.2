Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060A75477E
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 07:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785049529; cv=none; b=R0DUm8FnJOeRxUtqajGD9DXIvxFHjzJWI2Qcz4gbvwzRUcJ54lKndfZqgv88P8CDoP8/S6Sz385iJh2Io0xpk6t982/NtJ9BE6BdRbgEE3HR0GT65CLykcFVd0aTN3PumbpxSdmW/p1C+xL7kHbZ1hdkpD8LmsyIMe/HfJLyQ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785049529; c=relaxed/simple;
	bh=t84jAXZikXYC+PELPXPfvAFct7AWbHmSuGg8i9MrLd8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+00i4lL7cDJtNACHZZTj1B8udOIiDwhWkgZkxw4h0LVNHOo6YQmtwPz+WJgh+zcHOSgHoL3BnSGRCDNbnnRA0/KNqEsq7jAt/gCncqELrrRrdkrPgyaMXqxdGlIYJdA80qKJh1CNQLINYpN72MLmbQ+yN7EuIK4UdnW/7NM3Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PohT+jkR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MDbZUmTf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PohT+jkR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MDbZUmTf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PohT+jkR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MDbZUmTf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PohT+jkR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MDbZUmTf"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F44C48E0;
	Sun, 26 Jul 2026 07:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785049526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iAEwjP0CiCDIbmbuLpxP4oulQd6CrCr1nMD25ADCMvI=;
	b=PohT+jkRNJ86UiTDf8MLGjUIJCETq25oT2RxmfnQMqSj5fKfthTaj9viOx7pYVt2ktYITH
	QHOZjTlYzlo2sggrdm8k+QQQmbQok8a4pP7uA4AB4zDhmnatSCaEPP2UYQpM+WFM8p5/Xv
	WC9bo7BrxJAi02wE5Q+stLJLN+27bkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785049526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iAEwjP0CiCDIbmbuLpxP4oulQd6CrCr1nMD25ADCMvI=;
	b=MDbZUmTfPMt2oir6g26KgWqiLiqm01CsegqmdMnguFTltYDV0NCuFdVGs7JRfcR8FtyMZl
	aaeXxOZFn+1EEuBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785049526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iAEwjP0CiCDIbmbuLpxP4oulQd6CrCr1nMD25ADCMvI=;
	b=PohT+jkRNJ86UiTDf8MLGjUIJCETq25oT2RxmfnQMqSj5fKfthTaj9viOx7pYVt2ktYITH
	QHOZjTlYzlo2sggrdm8k+QQQmbQok8a4pP7uA4AB4zDhmnatSCaEPP2UYQpM+WFM8p5/Xv
	WC9bo7BrxJAi02wE5Q+stLJLN+27bkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785049526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iAEwjP0CiCDIbmbuLpxP4oulQd6CrCr1nMD25ADCMvI=;
	b=MDbZUmTfPMt2oir6g26KgWqiLiqm01CsegqmdMnguFTltYDV0NCuFdVGs7JRfcR8FtyMZl
	aaeXxOZFn+1EEuBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECC89779B9;
	Sun, 26 Jul 2026 07:05:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 52oJOLWxZWrsAQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 26 Jul 2026 07:05:25 +0000
Date: Sun, 26 Jul 2026 09:05:25 +0200
Message-ID: <87a4reb58q.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baul Lee <baul.lee@xbow.com>
Cc: linux-sound@vger.kernel.org,
	tiwai@suse.com,
	clemens@ladisch.de,
	perex@perex.cz,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: fix OOB write in snd_usbmidi_akai_output()
In-Reply-To: <20260726052040.41315-1-baul.lee@xbow.com>
References: <20260726052040.41315-1-baul.lee@xbow.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,xbow.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Sun, 26 Jul 2026 07:20:40 +0200,
Baul Lee wrote:
> 
> snd_usbmidi_akai_output() computes its fill-loop bound
> 
> 	buf_end = ep->max_transfer - MAX_AKAI_SYSEX_LEN - 1;
> 
> as a signed int, so a small device-advertised bulk-OUT max_transfer
> makes buf_end negative.  The loop guard then compares the u32
> urb->transfer_buffer_length against that negative int: the usual
> arithmetic conversion turns buf_end into a large unsigned value, so the
> guard stays true and each iteration keeps appending SysEx framing and
> payload bytes past the end of the URB transfer buffer, which is only
> max_transfer bytes long.
> 
> A USB device that advertises a tiny bulk-OUT endpoint can therefore
> trigger an attacker-length- and content-controlled heap out-of-bounds
> write when a process writes to the created /dev/snd/midiC*D* node.
> 
> Perform the comparison in signed arithmetic so that a negative buf_end
> stops the loop instead of wrapping to a huge unsigned bound.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: 4434ade8c933 ("ALSA: usb-audio: add support for Akai MPD16")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>
> ---
>  sound/usb/midi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> index d87e3f357cf7..cc7df77632a1 100644
> --- a/sound/usb/midi.c
> +++ b/sound/usb/midi.c
> @@ -799,7 +799,7 @@ static void snd_usbmidi_akai_output(struct snd_usb_midi_out_endpoint *ep,
>  	buf_end = ep->max_transfer - MAX_AKAI_SYSEX_LEN - 1;
>  
>  	/* only try adding more data when there's space for at least 1 SysEx */
> -	while (urb->transfer_buffer_length < buf_end) {
> +	while ((int)urb->transfer_buffer_length < buf_end) {
>  		count = snd_rawmidi_transmit_peek(substream,
>  						  tmp, MAX_AKAI_SYSEX_LEN);
>  		if (!count) {

The code change looks correct, but I believe the intention can be
understandable by a more explicit check like the below.
Could you verify it and submit v2 if it works?


thanks,

Takashi

-- 8< --
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -797,6 +797,8 @@ static void snd_usbmidi_akai_output(struct snd_usb_midi_out_endpoint *ep,
 
 	msg = urb->transfer_buffer + urb->transfer_buffer_length;
 	buf_end = ep->max_transfer - MAX_AKAI_SYSEX_LEN - 1;
+	if (buf_end <= 0)
+		return;
 
 	/* only try adding more data when there's space for at least 1 SysEx */
 	while (urb->transfer_buffer_length < buf_end) {

