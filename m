Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B48A3E4C7A
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915243; cv=none; b=mQc4QNGtNt3Qc30ef72d6Vv0G22fl3boVtYtKDj0aKn2k74Bq6qMpXtCop34OPK1qwjqueo80zsszXqL8GTPle3V5N2WC+ShUeOxnXF0gNlK0Y8TannGnpnBzY3mdKJViaJ67F9Ap38asW1iUiOsw/6bhldQ2Y1Rct8WTxe0h6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915243; c=relaxed/simple;
	bh=+gJTN6mi8M37nZVklJrSI8HoEMpYYyCXD6qAEQScjfA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sa7Lqhwlso3h19yoxuJDl4kPqXNXEK+hjTyDANLzfITbRQSfz1xuvKiuuWM3O2ARITKYt7QJW/Ec9Uu5vDQaQPRmcQqa77MPAG6u2CM7U77lTc1OftsZKzI2FWePIfOPhjNyh2O43V2hqKS4qkZpVqfbHQN43DS+xBKyzgjtjHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o+kZgXDJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HtOFglVj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BXZMYuJ5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gzkewCDk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o+kZgXDJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HtOFglVj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BXZMYuJ5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gzkewCDk"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 17E707FB86;
	Wed,  5 Aug 2026 07:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785915236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b4xVtkXgLYGk+LHt8B0/Yu5mUHGsKTFANxlSlQBbwfw=;
	b=o+kZgXDJbbbpN6Xs0J5Qyt8g+pK0R+IVmYO2yQjURsq4vdsUcQB74MhaOZROtNhSiYQ9Gq
	1QCwUgSFlQK1gV/OqrPi34IOkw7GQMDcUPy/CN3lxawtOSSY4eBDQfwJeSBT/yY+qMuKcY
	igCSJkuDaFJOHYuR4ICHBj53xZBNxjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785915236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b4xVtkXgLYGk+LHt8B0/Yu5mUHGsKTFANxlSlQBbwfw=;
	b=HtOFglVjUX0sz9wuO3nRNN2PXq20elMFhuT9lcb1koglQNbDAOxL3fYR0VG6KcIC1DdaKy
	KfccW1aPuhsEpkCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785915232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b4xVtkXgLYGk+LHt8B0/Yu5mUHGsKTFANxlSlQBbwfw=;
	b=BXZMYuJ5xbdADpsWSayQ8nZhZ8RzOUspvENhutx3jmtYGJrpuLwkbsmtqghe2BP6fB46N3
	sxXXq8zafbZjRgJmZTcXf31ySa7+7st7gAuMPPgNGPWCzUoulYfufngAkn5rg1zTFIh5HZ
	n0Fvt6UmBaceFIAHbqxLZF2xO2DSOms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785915232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b4xVtkXgLYGk+LHt8B0/Yu5mUHGsKTFANxlSlQBbwfw=;
	b=gzkewCDkCT2L/5Fn+WIwODVK9pQi1VGLFzGEk5vWbqIjCM6Bj5Jxq6zpw0Yqgzshf3HJqw
	3t8dEhA+OpOSM6Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4507779B6;
	Wed,  5 Aug 2026 07:33:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Liy4Kl/ncmpbQgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 05 Aug 2026 07:33:51 +0000
Date: Wed, 05 Aug 2026 09:33:51 +0200
Message-ID: <87mrv1ggww.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baul Lee <baul.lee@xbow.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: 6fire: bound the MIDI event length from the device
In-Reply-To: <20260805013423.38175-1-baul.lee@xbow.com>
References: <20260805013423.38175-1-baul.lee@xbow.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[xbow.com:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On Wed, 05 Aug 2026 03:34:23 +0200,
Baul Lee wrote:
> 
> usb6fire_comm_receiver_handler() forwards a MIDI event using a length
> byte the device supplies, with no bound and no check that the transfer
> delivered that many bytes:
> 
> 	if (!urb->status) {
> 		if (rt->receiver_buffer[0] == 0x10) /* midi in event */
> 			if (midi_rt)
> 				midi_rt->in_received(midi_rt,
> 						rt->receiver_buffer + 2,
> 						rt->receiver_buffer[1]);
> 	}
> 
> receiver_buffer is a 64-byte kzalloc() buffer (COMM_RECEIVER_BUFSIZE), so
> only 62 bytes follow the two-byte header.  receiver_buffer[1] is a u8 the
> device chooses, so a device that answers with 0x10 and a length of 0xFF
> makes snd_rawmidi_receive() read 255 bytes starting two bytes into a
> 64-byte object.  The bytes past the buffer are handed to userspace
> through the rawmidi read path.
> 
> urb->actual_length is not consulted either, so a short transfer leaves
> both the type byte and the length byte at their previous values and the
> handler acts on stale data.
> 
> The receiver URB is submitted from usb6fire_comm_init() at probe, so the
> read happens on plug with no user action; forwarding to userspace also
> needs a MIDI input substream open, since usb6fire_midi_in_received()
> only calls snd_rawmidi_receive() when rt->in is set.
> 
> KASAN on 7.2.0-rc5 (arm64), single packet from an emulated device:
> 
>   BUG: KASAN: slab-out-of-bounds in snd_rawmidi_receive
>   Read of size 255 at addr ffff000009f64682 by task bash/183
>    __asan_memcpy
>    snd_rawmidi_receive
>    usb6fire_midi_in_received [snd_usb_6fire]
>    usb6fire_comm_receiver_handler [snd_usb_6fire]
>   Allocated by task 11:
>    usb6fire_comm_init [snd_usb_6fire]
>    usb6fire_chip_probe [snd_usb_6fire]
>   The buggy address is located 2 bytes inside of
>    allocated 64-byte region [ffff000009f64680, ffff000009f646c0)
> 
> Reject the event when the length exceeds the bytes that follow the
> header, and require the transfer to have delivered the header plus that
> many bytes.  The receiver URB is submitted with a 64-byte
> transfer_buffer_length, so a genuine device cannot deliver an event
> longer than those 62 bytes and nothing valid is dropped.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: c6d43ba816d1 ("ALSA: usb/6fire - Driver for TerraTec DMX 6Fire USB")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>

Applied to for-next branch now.  Thanks.


Takashi
