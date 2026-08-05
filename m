Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84233E49C8
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915353; cv=none; b=LPByx29JOwuiB9zohHR9nkZDNYVGnV/nCQZLkaucLn1ZNfGaLDpN3v/EVNYZ4lbTz4mWe3x6VSp00fj2FjNuzC8vO3OG7JzFtKNNG7uHdpgjb39DkQrd9vBlA/TjDxr52CpQetd/O//ln1NYOvFPUGPNwh0pC1u0uxEDub0DFLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915353; c=relaxed/simple;
	bh=H/d9i1J4rllvLzs26ent0HZYsBY3Ql124OoPVA3r9cE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IrNd5zgDShZlSYkAsN13lK+lvski4jMc2iVFItFpSPRtJl8P3ZxTN9i1xqSsdtLUpihH0e2yo8VvrhcaPKHA6gblDZDGoaXDv52WP0ekOOMkKS5YsaagDyK5ZZv1GuoYtwZiFK/iGLJ6hdFn3OrUoRrvtCp0ZKbK9ZTMTHtz+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tSJW16co; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n1K8N6qw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qqsH9qky; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IDLPPyQx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tSJW16co";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n1K8N6qw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qqsH9qky";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IDLPPyQx"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA77F7FB69;
	Wed,  5 Aug 2026 07:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785915345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt6BhsMAZujbe6tU67OukCcMBQ8kg3coFR6gNJlZ72A=;
	b=tSJW16colZA3mp1p1XOhlZ4D+0E4bANiYTr/JjwE5x47PzH8GmFKMGnKuW7KXppzsMQD8W
	dh6fk/vBQ3uPk25oODW9VztxgtM+hb39KnkJtrN+KBKq0LsvrHvCbHVyMMX6kA55qwTQxT
	lEZXkvf23gRSN51T8bKbcDVoUTUK1JM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785915345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt6BhsMAZujbe6tU67OukCcMBQ8kg3coFR6gNJlZ72A=;
	b=n1K8N6qwV4b+NZtkFTecXQZBGgG0xOy7obewTSfbcTn3PWPQfEnuv5YFGWVoezma5CkuLd
	CXLO0RLKPzBObNDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785915341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt6BhsMAZujbe6tU67OukCcMBQ8kg3coFR6gNJlZ72A=;
	b=qqsH9qkyQjqkVEQbq62+W+XxTw6tTCytQcoJR0Bpc48A5uvctTxTW6Vjmcl2e/SEv+Mw4/
	Spfb3kJYCu1hIbCwNOrSZZU2tz1IRRrTVd/2NqKByXYfKX2oIz+GJUjksOt1MVtcLGTrjw
	Vaccsnp6onqcOIg/FoIYG+VMexxSMQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785915341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt6BhsMAZujbe6tU67OukCcMBQ8kg3coFR6gNJlZ72A=;
	b=IDLPPyQxikzWyxTD6W+06lKdhjKrQOn/vbHo1z9H9tRxS8YtnyTZYQXBWk8ClA7adKgouk
	Ofcz3q/TjNiUjMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 745AE779C2;
	Wed,  5 Aug 2026 07:35:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Or0zG83ncmp5QwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 05 Aug 2026 07:35:41 +0000
Date: Wed, 05 Aug 2026 09:35:41 +0200
Message-ID: <87jyq5ggtu.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baul Lee <baul.lee@xbow.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: fix OOB write on Type II inbound URBs
In-Reply-To: <20260805013441.38245-1-baul.lee@xbow.com>
References: <20260805013441.38245-1-baul.lee@xbow.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
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
X-Spam-Flag: NO
X-Spam-Score: -3.29
X-Spam-Level: 

On Wed, 05 Aug 2026 03:34:41 +0200,
Baul Lee wrote:
> 
> data_ep_set_params() sizes each URB transfer buffer before it adds the
> Format Type II transfer delimiter:
> 
> 	u->packets = urb_packs;
> 	u->buffer_size = maxsize * u->packets;
> 
> 	if (fmt->fmt_type == UAC_FORMAT_TYPE_II)
> 		u->packets++; /* for transfer delimiter */
> 	u->urb = usb_alloc_urb(u->packets, GFP_KERNEL);
> 
> buffer_size is computed from the pre-increment packet count and never
> recomputed, so for a Type II endpoint the buffer is one packet short of
> the packet count the URB is built with.
> 
> prepare_inbound_urb() then lays out one iso frame per packet and never
> consults buffer_size:
> 
> 	offs = 0;
> 	for (i = 0; i < urb_ctx->packets; i++) {
> 		urb->iso_frame_desc[i].offset = offs;
> 		urb->iso_frame_desc[i].length = ep->curpacksize;
> 		offs += ep->curpacksize;
> 	}
> 
> 	urb->transfer_buffer_length = offs;
> 	urb->number_of_packets = urb_ctx->packets;
> 
> The last descriptor therefore points one packet past the end of the
> transfer buffer, where the host controller writes device data on every
> inbound transfer.  prepare_silent_urb() and prepare_playback_urb() bound
> their fill loops by ctx->buffer_size, so only capture is affected.
> 
> fmt_type comes from the device's audio streaming descriptors, so any
> device advertising a Type II capture format hits this once userspace sets
> hw_params on the stream.
> 
> KASAN on 7.2.0-rc5 (arm64) with a dummy_hcd/raw-gadget device, one report
> per inbound transfer:
> 
>   BUG: KASAN: slab-out-of-bounds in dummy_timer
>   Write of size 64 at addr ffff0000186171c0 by task cons02/166
>    __asan_memcpy
>    dummy_timer
>    hrtimer_run_softirq
>   Allocated by task 166:
>    usb_alloc_coherent
>    snd_usb_endpoint_set_params
>   The buggy address is located 0 bytes to the right of
>    allocated 64-byte region [ffff000018617180, ffff0000186171c0)
> 
> Compute buffer_size after the delimiter packet has been accounted for,
> and bound the fill loop by buffer_size, as prepare_silent_urb() already
> does on the outbound side.  This grows every Type II URB allocation by
> one maxsize packet.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: 8fdff6a319e7 ("ALSA: snd-usb: implement new endpoint streaming model")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>

Applied now.  Thanks.


Takashi
