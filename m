Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6011D3D7D8D;
	Mon, 19 Oct 2026 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399259; cv=none; b=bIrrpRbulTd+MvdpP4xHD1WjYD132lCUgcDvoTwpF8YL03RoH98wmW/p0QSFVZSjc352bYOM3IHzPTFTAfZSGGdkmT54M6fegWW9faftitpTRAqhvJWI4E06dIXE9iGY86KQ9lUQVLXAOT7VJ9q8EJWOBqx8x57WvLcHp0YLSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399259; c=relaxed/simple;
	bh=824lg1lsHXkFily9TJs5O0Zj5zsAHGaSwSm3LAt3l2E=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+3I5pRxjCd/+eo4soo2pzSKW5wrGhCBiIX/GIpIqKiYxH1dxl79sF7m84Gj4rJ/JHZCDxUyK7i2kWtrU0MsW5wYfrmxZNzVzBMFLzSu+5lP8DEYb/mjp7tj+p3eLzngyVnrudIJmNhtWZ7u7iES5P9+T6WfaO18SyRje5U1D8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tmAyxtoV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fmlXOGvu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tmAyxtoV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fmlXOGvu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tmAyxtoV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fmlXOGvu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tmAyxtoV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fmlXOGvu"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6227221CF7;
	Mon, 19 Oct 2026 08:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792399256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Swl9d07393pNaVM5gCSrIwypUUIonmrZgxtDNAS5pBM=;
	b=tmAyxtoVfmuiSWggmVPEQY7mejrZAUkDL73pAxEN5XEGKGOV0qby6Rr5Ki7hsZpb2ZDj4v
	pMtbdfngoVDmDBkptldputaTd9lY9gbwxyHC12EYjsWxoPawHfziGojOs5iauxYRvpgYrq
	Szy1VDdW1bm3EkK9v5OiQP0RF0xCOkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792399256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Swl9d07393pNaVM5gCSrIwypUUIonmrZgxtDNAS5pBM=;
	b=fmlXOGvuVT7S9h6mdWSTnGBD6zshMcLnjRFgAqcnhUVKqywNu04HP7wwmzm3rKA0bkx+GC
	zISi7aJYgNQDp9Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792399256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Swl9d07393pNaVM5gCSrIwypUUIonmrZgxtDNAS5pBM=;
	b=tmAyxtoVfmuiSWggmVPEQY7mejrZAUkDL73pAxEN5XEGKGOV0qby6Rr5Ki7hsZpb2ZDj4v
	pMtbdfngoVDmDBkptldputaTd9lY9gbwxyHC12EYjsWxoPawHfziGojOs5iauxYRvpgYrq
	Szy1VDdW1bm3EkK9v5OiQP0RF0xCOkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792399256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Swl9d07393pNaVM5gCSrIwypUUIonmrZgxtDNAS5pBM=;
	b=fmlXOGvuVT7S9h6mdWSTnGBD6zshMcLnjRFgAqcnhUVKqywNu04HP7wwmzm3rKA0bkx+GC
	zISi7aJYgNQDp9Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1EE3136CC;
	Mon, 19 Oct 2026 08:40:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ikJVLpfX1WrrbgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 19 Oct 2026 08:40:55 +0000
Date: Mon, 19 Oct 2026 10:40:55 +0200
Message-ID: <87h5iiaxrc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Walter Weber <walter.weber@rwth-aachen.de>
Cc: <linux-sound@vger.kernel.org>,
	"Geoffrey D . Bennett" <g@b4.vu>,
	<stable@vger.kernel.org>,
	Jaroslav Kysela
	<perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vasiliy Kovalev
	<kovalev@altlinux.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: usb-audio: Fix Scarlett 8i6 Gen 1 router source numbering
In-Reply-To: <20261018112012.41807-1-walter.weber@rwth-aachen.de>
References: <20261018112012.41807-1-walter.weber@rwth-aachen.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Sun, 18 Oct 2026 13:20:09 +0200,
Walter Weber wrote:
> 
> The router source numbering in s8i6_info is identical to the 6i6 entry
> and was never verified on hardware (it is marked "untested..."). On a
> Scarlett 8i6 1st Gen everything after the analog inputs is off by two:
> 
>   - "SPDIF 1/2" select values 16/17, which carry no signal;
>   - "Mix A/B" select values 18/19, which are the actual S/PDIF inputs;
>   - "Mix C-F" select the actual Mix A-D, and Mix E/F cannot be
>     selected at all;
>   - the matrix inputs cannot be fed from S/PDIF.
> 
> The real numbering was measured on the device by routing known signals
> (PCM test tones, mixes with distinct gains, an S/PDIF out-to-in
> loopback) and checking which source value arrives in the capture
> stream:
> 
>   PCM 1-12      0-11
>   Analog 1-4   12-15
>   (no signal)  16-17
>   S/PDIF 1-2   18-19
>   Mix A-F      20-25
> 
> Correct the offsets and enum lengths accordingly, and update the
> (currently unused) matrix_mux_init table to match. Values 16/17
> remain as placeholders (shown as "Analog 5/6") since the enum maps
> items to source values linearly.
> 
> The 6i6 entry uses the same layout and is also marked untested. It is
> left unchanged since I have no 6i6 to verify it.
> 
> Tested on a Scarlett 8i6 1st Gen (bcdDevice 2.60) with v7.2.11.
> 
> Fixes: 76b188c4b370 ("ALSA: usb-audio: Scarlett mixer interface for 6i6, 18i6, 18i8 and 18i20")
> Cc: stable@vger.kernel.org
> Signed-off-by: Walter Weber <walter.weber@rwth-aachen.de>

Applied now.  Thanks.


Takashi
