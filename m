Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793547164;
	b=3hxQzX6XJHvAV5vDMCwk9kiRBjPquOnFQCzM6Nuw/OBvmXLvIF16JKMu53AHN6VXdH7c
	 vLa9sbocDudsu0Y0Cpg6C/z8tI2kabvD2C1gfK6DmV7CGNcCOH2+jphzUXfWtjk7dT7pK
	 1GeKSCvhGCJwMjKaR3zzpAR4AZlb3W2ZIqtTbigeYyQpDlWSjK+ijL8Uv7/O0mlkFBHu6
	 9JOycjLx5Gx/cTwta8NKLCGr/qu36ooMRcLVSi/vsPP4ZL5qrmlJWAVglZgBPHLeb/9lP
	 hnVmDLl2q5ygTEyb9MjdEDjR5gGlr775EoB/8InloXXnBJ01SoQFp1z241CdWbtFaag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793547164;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=Hvpx/ahIxVQP35occbNZa581qq41bBI9D98Rab5woag=;
	b=yiPpe6IjiYzRS0U+JA/GE0X17j/SmNKb4z3w0uWq2nKzOMCIURPEAdG20xCO34XmYPuO
	 hx1vgtBAzRb7vxjSoU+KesF9JFTu400IXDzjb+AL3o/15IlC+7exshkQQg0TnJYN8Xnp1
	 4gxTV4Lmwtp/WwxJnA35w0RDc8MXpaZN3Ca7xKlhygFdA/4/B7Q+pjc0X2nYABd8QM37y
	 ON2MEk3pbeFDnW25ooqmbndb2Bw8Se2CZs3eCXsA8DXtfmppMOZ7zmt4bW4ItVArCEATV
	 7poEX9MDNSmY0p4Rqubp0opYDtVaFaaxXonyyOhvkqM7G3sRtqZPeO07I6mD2qkN7Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xRwQuUE4;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="mCC/XQHI";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xRwQuUE4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="mCC/XQHI";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBC8606A324;
	Sun,  1 Nov 2026 15:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DBC8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xRwQuUE4;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mCC/XQHI;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xRwQuUE4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mCC/XQHI
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F14F51F7BD;
	Sun,  1 Nov 2026 15:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793547156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hvpx/ahIxVQP35occbNZa581qq41bBI9D98Rab5woag=;
	b=xRwQuUE4pd3UTBUUfBWu1jKyyGXisxvq3YD4ebJnFiUuHlLHmalKFxHrwGuf4vtNjfLVkT
	P+nQQrKXTzKRk67LEbeMhXeXAwCsR/68UJ7JKGyDcU2x64cDuDsCpNR0z/xqmIa3TPiWZ6
	O35iJ7ZVZp9CS2k/W+Z2QX9DdgKhums=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793547156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hvpx/ahIxVQP35occbNZa581qq41bBI9D98Rab5woag=;
	b=mCC/XQHImKF+H2eiZFg9yJzu38lQZxZQxMLuM+9KkH7Tl9HwnWOjjcJ197LoLDaYowBmFQ
	g4G28QkXYtlrrcCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xRwQuUE4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="mCC/XQHI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793547156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hvpx/ahIxVQP35occbNZa581qq41bBI9D98Rab5woag=;
	b=xRwQuUE4pd3UTBUUfBWu1jKyyGXisxvq3YD4ebJnFiUuHlLHmalKFxHrwGuf4vtNjfLVkT
	P+nQQrKXTzKRk67LEbeMhXeXAwCsR/68UJ7JKGyDcU2x64cDuDsCpNR0z/xqmIa3TPiWZ6
	O35iJ7ZVZp9CS2k/W+Z2QX9DdgKhums=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793547156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hvpx/ahIxVQP35occbNZa581qq41bBI9D98Rab5woag=;
	b=mCC/XQHImKF+H2eiZFg9yJzu38lQZxZQxMLuM+9KkH7Tl9HwnWOjjcJ197LoLDaYowBmFQ
	g4G28QkXYtlrrcCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B650134B3;
	Sun,  1 Nov 2026 15:32:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1MkkFJNb52qQLgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 01 Nov 2026 15:32:35 +0000
Date: Sun, 01 Nov 2026 16:32:35 +0100
Message-ID: <87ld7cpnxo.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.de>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] ALSA: bcd2000: Fix use-after-free of MIDI URBs on file close
In-Reply-To: <20261031190936.5696-1-25031212351@stu.xidian.edu.cn>
References: <874ie1rbge.wl-tiwai@suse.de>
	<20261031190936.5696-1-25031212351@stu.xidian.edu.cn>
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
X-Rspamd-Queue-Id: F14F51F7BD
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -12.51

On Sat, 31 Oct 2026 20:09:36 +0100,
YuanZhe Liu wrote:
> 
> bcd2000_disconnect() calls snd_card_disconnect(), which only prevents
> new opens, and then frees the MIDI URBs.  A rawmidi file that was
> already open can still be closed afterwards, and its close callback,
> bcd2000_midi_output_close(), calls usb_kill_urb() on midi_out_urb.
> 
> The URB pointers are cleared on disconnect and their accesses are
> serialized with midi_lock, but bcd2000_midi_output_close() reads
> midi_out_urb without that lock.  The check can therefore pass just
> before the pointer is cleared, and usb_kill_urb() then runs on the URB
> that has already been freed:
> 
>   BUG: KASAN: slab-use-after-free in usb_kill_urb+0x74/0x80
>   Read of size 8 at addr ffff8880078e7d40
>    usb_kill_urb
>    bcd2000_midi_output_close
>    close_substream
>    rawmidi_release_priv
>    snd_rawmidi_release
> 
>   Allocated by: usb_alloc_urb <- bcd2000_init_midi <- bcd2000_probe
>   Freed by:     usb_free_urb <- bcd2000_midi_free
>                 <- bcd2000_disconnect
> 
> Take the lock in bcd2000_midi_output_close() and reference the URB with
> usb_get_urb() before releasing it.  The URB then stays valid until
> usb_put_urb() after usb_kill_urb() has returned, even if a disconnect
> frees it in the meantime.  usb_kill_urb() itself cannot run under
> midi_lock, as the completion handler takes the same lock.
> 
> Fixes: b47a22290d58 ("ALSA: MIDI driver for Behringer BCD2000 USB device")
> Cc: stable@vger.kernel.org
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

Applied now.  Thanks.


Takashi
