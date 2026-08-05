Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BED3DA5C7
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915275; cv=none; b=YpoJtnyywknrDslNYX+dT/V3cp+hoJTMOLpj0EtP8wIIpqth0+/DMEuzZe3Lsnb1m87/JuiHU+3xZTLSresO14igip0vMn+WCjLMlxR3YlpkMzln5PeNnJgINkh7CzElifyFGPNWbTuWce0YnIbC2cjB3ELVBYaIuZ08hTaKWwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915275; c=relaxed/simple;
	bh=aFj+bnt5qPaYVxhGeQp3OytBhII8T1fLQoOD4PgmEJs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKQzQSkwJGBG5D9qGPnVeG0api/GblXEogKrV4X0MSFPZ7L26kOkthh4Nc18nv3HqTKxezlq2J8ToRQieGNXaRom/JiwSIr/ER/V0XOhZ9mOj56GiZ/jfixFJc6w7444wAZ6k4dkXueC9XItpeN00ECG1EQDQJGBGsZGATIv3pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eUHJ/eyI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vdZIMcbh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RhVyM5Ep; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p7yfdF1+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eUHJ/eyI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vdZIMcbh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RhVyM5Ep";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p7yfdF1+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 31DB13E43;
	Wed,  5 Aug 2026 07:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785915263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zRUMdLBqp4XxaG80OnrjKjQTl+I8xT3lEnw6BPpT8xI=;
	b=eUHJ/eyIivJ+kcO5c2RCSmCH6qAyLXnSb7b3M0mJ0hF8qzcO2oGBJaE2X+WEzBtcPl5U0E
	k+JRrAvu4dMh4n+GkWlJsFcDbVOqEkSgdTW1eM9G6PONIZq348PdOo+1urz8nD150gt5cl
	3bV+akMxSbHzxHTjjybBh008Y15/M8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785915263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zRUMdLBqp4XxaG80OnrjKjQTl+I8xT3lEnw6BPpT8xI=;
	b=vdZIMcbhCvEVkGyyadxtAVzZFnFPpX36yAmvD7D13b+XcpSrMMcOG8v9YSe0tRprXUbI50
	+qmcqOdRCyyB2HBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785915259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zRUMdLBqp4XxaG80OnrjKjQTl+I8xT3lEnw6BPpT8xI=;
	b=RhVyM5EpgfNAG8Q6CNn0A2XdoZ0Bhz7JaJGyAufk054GUXDo2OeqX8osozkrp604bdp/my
	FX4qvTz6nFH5hnI5SvS+Svju8it638mK5iZfLpn+NZWgOBLmLXFgjXiiQ/mEyUoLI1VVZN
	H4bPva4IMBfKHOspBoz4Wogu8S2CZzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785915259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zRUMdLBqp4XxaG80OnrjKjQTl+I8xT3lEnw6BPpT8xI=;
	b=p7yfdF1+RgQ1lrO193b91ddu/WkH+xK9BZ3aHPfrj9fywZUJ4Lxp8acuAPSfEcmCadjE3W
	Hy7wjY+SBhtiDDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 010AC779C2;
	Wed,  5 Aug 2026 07:34:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NXlVOnrncmp+QgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 05 Aug 2026 07:34:18 +0000
Date: Wed, 05 Aug 2026 09:34:18 +0200
Message-ID: <87ldalggw5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baul Lee <baul.lee@xbow.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: bcd2000: clear the URB pointers on disconnect
In-Reply-To: <20260805013428.38204-1-baul.lee@xbow.com>
References: <20260805013428.38204-1-baul.lee@xbow.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.29
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.29 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.969];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo,xbow.com:email]

On Wed, 05 Aug 2026 03:34:28 +0200,
Baul Lee wrote:
> 
> bcd2000_free_usb_related_resources() frees both URBs and leaves the
> pointers behind:
> 
> 	usb_kill_urb(bcd2k->midi_out_urb);
> 	usb_kill_urb(bcd2k->midi_in_urb);
> 
> 	usb_free_urb(bcd2k->midi_out_urb);
> 	usb_free_urb(bcd2k->midi_in_urb);
> 
> The rawmidi device outlives that call.  A substream that is still open
> when the device is unplugged reaches bcd2000_midi_send() from the
> trigger path on close.  That function writes to the freed URB and then
> hands it to the USB core:
> 
> 	bcd2k->midi_out_urb->transfer_buffer_length = BUFSIZE;
> 	...
> 	ret = usb_submit_urb(bcd2k->midi_out_urb, GFP_ATOMIC);
> 
> usb_kill_urb() does not stop a later submission either, so a submit that
> races the disconnect can requeue the URB after it has been reaped.
> midi_in_urb is exposed the same way: bcd2000_input_complete() resubmits
> it from the completion handler.
> 
> KASAN on 7.2.0-rc5 (arm64):
> 
>   BUG: KASAN: slab-use-after-free in bcd2000_midi_send [snd_bcd2000]
>   Write of size 4 at addr ffff00001827d388 by task bpoc/168
>    __asan_store4
>    bcd2000_midi_send [snd_bcd2000]
>    bcd2000_midi_output_trigger [snd_bcd2000]
>    snd_rawmidi_kernel_write1
>    close_substream.part.0
>   Freed by task 168:
>    usb_free_urb
>    bcd2000_disconnect [snd_bcd2000]
> 
>   BUG: KASAN: slab-use-after-free in usb_submit_urb
>   Read of size 8 at addr ffff00001827d3b8 by task bpoc/168
> 
> Clear both pointers after freeing and test them on the paths that can
> still run.  Poison the URBs before freeing them: usb_poison_urb() waits
> for a running completion handler and rejects any later submission, so
> after it returns the input path is quiesced and only the rawmidi trigger
> path can still reach bcd2000_midi_send().  No unpoison is needed; the
> URBs are freed on the next line.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: b47a22290d58 ("ALSA: MIDI driver for Behringer BCD2000 USB device")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>

Applied to for-next branch.  Thanks.


Takashi
