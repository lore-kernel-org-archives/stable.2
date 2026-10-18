Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EFC3EF663;
	Sun, 18 Oct 2026 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341782; cv=none; b=ZmbcjlFI9exIAOvg3U+Dc3kX3XZcBnhp0COSvePpEkh5/nUQTJqkVWo4Q+YbnLzcgYYmrPtNMnsbxTNQgjzSLsW8FhQ6c+05o7Dn1RTeI+KkFEh3LAWvo1UTpMnoN4pbaBz2h8JkIcOZj1khHCpYy6YZZmkmj2/YUSz5d/HcJaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341782; c=relaxed/simple;
	bh=IHrvpG2wVPzApJlQiEzQQkeSpUN0h3yuPVCXYWde/rs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIn2qyYTvAw+wQoegtsepI03+aeqAWWtVChSr0Iryifr0Ny+GEcXI7hOaCtbNVjWOOe2YZnXTk8stJAlAwFTjwID6sHddq88LzXIWlcrJGQt2H4NLuWgv1IqTgmtURrLe/vHPg3M/sxDYCgD2hiw6u4H1mcYe5tTf0urYK+YvaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=os4D7A73; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ik/JJU9D; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=os4D7A73; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ik/JJU9D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="os4D7A73";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ik/JJU9D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="os4D7A73";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ik/JJU9D"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 13FF621C3C;
	Sun, 18 Oct 2026 16:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792341769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+R51h5F8SUVAknQAJcEABYH8iVTxPikAQ8Yb5pzDi5s=;
	b=os4D7A73SvBJNwDLO5tTW+87iU/EEuoecnL2nCIXpJ9jLn9IyVrtlqyyvZZ3EJOEReXLZ8
	DsIXbOd9a1j2nWx7Qus1Dii0/fzM4FfGgLgTLA+YTHrBCJqFOb9gSsiCnZFP7+mA7a7v9a
	/JgkV9ZlLbvP6ZhPemQ1X7c5iPFbVng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792341769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+R51h5F8SUVAknQAJcEABYH8iVTxPikAQ8Yb5pzDi5s=;
	b=ik/JJU9DDo76v1xarhAKQWdFCVaX8STlucEPWrmB4yAj7Lh1HuhOHrrd2cDuRhdHpVXm2z
	kfuu2xbnn4uRgxDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=os4D7A73;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="ik/JJU9D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792341769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+R51h5F8SUVAknQAJcEABYH8iVTxPikAQ8Yb5pzDi5s=;
	b=os4D7A73SvBJNwDLO5tTW+87iU/EEuoecnL2nCIXpJ9jLn9IyVrtlqyyvZZ3EJOEReXLZ8
	DsIXbOd9a1j2nWx7Qus1Dii0/fzM4FfGgLgTLA+YTHrBCJqFOb9gSsiCnZFP7+mA7a7v9a
	/JgkV9ZlLbvP6ZhPemQ1X7c5iPFbVng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792341769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+R51h5F8SUVAknQAJcEABYH8iVTxPikAQ8Yb5pzDi5s=;
	b=ik/JJU9DDo76v1xarhAKQWdFCVaX8STlucEPWrmB4yAj7Lh1HuhOHrrd2cDuRhdHpVXm2z
	kfuu2xbnn4uRgxDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F401132D3;
	Sun, 18 Oct 2026 16:42:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zL6LGAj31GrKLgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 18 Oct 2026 16:42:48 +0000
Date: Sun, 18 Oct 2026 18:42:47 +0200
Message-ID: <87tsmjarjs.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Will Bush" <will@willbush.dev>
Cc: "Takashi Iwai" <tiwai@suse.com>,	"Jaroslav Kysela" <perex@perex.cz>,
	linux-sound@vger.kernel.org,	regressions@lists.linux.dev,
	stable@vger.kernel.org,	"Jan Lentfer" <jan.lentfer@web.de>,	Sebastian
 =?ISO-8859-1?Q?Dalfu=DF?= <sd@sedf.de>
Subject: Re: [REGRESSION] usb-audio: Behringer UMC204HD broken in 7.2.10
In-Reply-To: <45162613-2802-401c-84c9-742f9c8c68e6@app.fastmail.com>
References: <45162613-2802-401c-84c9-742f9c8c68e6@app.fastmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[web.de];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,vger.kernel.org,lists.linux.dev,web.de,sedf.de];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Rspamd-Queue-Id: 13FF621C3C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Sun, 18 Oct 2026 18:34:27 +0200,
Will Bush wrote:
> 
> Hi Takashi,
> 
> Thanks for all your work on usb-audio. I was updating my system (NixOS), which
> took me from 7.2.9 to 7.2.10, and my Behringer UMC204HD device stopped working.
> 
> It gets into a loop:
> 
>   [  225.148019] blazar kernel: usb 3-4: new high-speed USB device number 19 using xhci_hcd
>   [  225.340016] blazar kernel: usb 3-4: New USB device found, idVendor=1397, idProduct=0508, bcdDevice= 1.35
>   [  225.366005] blazar kernel: usb 3-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>   [  225.366187] blazar kernel: usb 3-4: Product: UMC204HD 192k
>   [  225.366304] blazar kernel: usb 3-4: Manufacturer: BEHRINGER
>   [  230.493021] blazar kernel: usb 3-4: failed to read device descriptor: -110
>   [  230.493313] blazar kernel: snd-usb-audio 3-4:1.0: probe with driver snd-usb-audio failed with error -110
>   [  235.612029] blazar kernel: usb 3-4: failed to read device descriptor: -110
>   [  235.612302] blazar kernel: snd-usb-audio 3-4:1.3: probe with driver snd-usb-audio failed with error -110
>   [  240.732035] blazar kernel: usb 3-4: failed to read device descriptor: -110
>   [  240.732461] blazar kernel: snd-usb-audio 3-4:1.4: probe with driver snd-usb-audio failed with error -110
>   [  240.732538] blazar kernel: usb 3-4: USB disconnect, device number 19
>   [  241.019061] blazar kernel: usb 3-4: new high-speed USB device number 20 using xhci_hcd
> 
> Issue seems to be from commit: b5c4823cf3e4 ("ALSA: usb-audio: Apply boot quirk for Behringer models generically")
> 
> I was able to patch 7.2.10 to get it working again:
> 
> -	if (USB_ID_VENDOR(id) == 0x1397)
> +	if (id == USB_ID(0x1397, 0x1234))
> 
> Not sure if applying the quirk to every Behringer device is too broad or what
> the fix should be. Ping me if you want me to test a patch.
> 
> #regzbot introduced: b5c4823cf3e4

Interesting, it's just a descriptor read and this fails on your device
by some reason.  Could you try to ignore the error like below, and
verify whether it continues to work?


thanks,

Takashi

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -865,7 +865,7 @@ static int snd_usb_cm1a_boot_quirk(struct usb_device *dev)
 	err = usb_get_descriptor(dev, USB_DT_DEVICE, 0, desc, sizeof(*desc));
 	if (err < 0) {
 		dev_err(&dev->dev, "failed to read device descriptor: %d\n", err);
-		return err;
+		// return err;
 	}
 
 	return 0;
