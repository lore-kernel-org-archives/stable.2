Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB42D3FE347
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728152; cv=none; b=QXjS25MBCzlOnFE40NpApbSY7hk2g5gYnABC/fYc0HkagSqSBG76ivNI99z8lLON8Mznz2Qe6nMDF5ElwaR83+GV1vcIa/FoN8TEHILy8E4bms4YH1eNdUqxM/ix5LdEdJbD9K0CpHfdKA4HcGkL7klUAx2ChAvwYDmeTPB+fDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728152; c=relaxed/simple;
	bh=lQmgQs5IwiG1DL5ek9CXp3Y5TZZWbH9+aAHkY115yL4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JuJQutC51jXPVA1mvHcHBZN1FsfBHV8hY83AhDVRN2WDqWNkJH0m+/mM/Mp7HLlXSdEB4cWfDrmo6Rg7MOZuilhdZHVPsrIkTt34jJO7N4zcUKi34A9idknI/5wF3PjMptY7uHxKSATLtN4Cek15Einv5RUuqC/OIIf459+432I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LJmwljJb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/KKhNtV/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sNSU7e0D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BpMJ1ntC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LJmwljJb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/KKhNtV/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sNSU7e0D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BpMJ1ntC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBBE475D7B;
	Mon, 29 Jun 2026 10:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782728149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xk5jXTH0rPYDTmpQI6nSdSsvy17M4jYVpe4SU8tiahY=;
	b=LJmwljJb3pyfb2MfeuBUan7sxJD2En7Mz4/KtzTDbIH3bduYi/r0yAeSYx1jCR5k6z+UUt
	E7zEW3M+48hsm/5+6u6+aKXEFamnNlLiVWEkvr7Pi+8gCn1uB1xDbe9UopoDiKAW3Sjfiu
	QxS4F4IYpQWDRx3Kjfa/FRqwNYCFJlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782728149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xk5jXTH0rPYDTmpQI6nSdSsvy17M4jYVpe4SU8tiahY=;
	b=/KKhNtV/huD1pKcmJ5t6qHg1PVuyFppNCPiFR9DhPpBPpl9+510AZkjTrps3b1xNkqYRbt
	lbFQ/UFlQdZZ1IBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sNSU7e0D;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BpMJ1ntC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782728148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xk5jXTH0rPYDTmpQI6nSdSsvy17M4jYVpe4SU8tiahY=;
	b=sNSU7e0DPYIsqhI0nnX0d0QInczDzTkoBrBgNuEqtMppTLaji8mobjbHKA7pLkEYJmmrXp
	ppFCygeGvvYh60MIVSdVQDYssnu8wdJtnMV2mKk121nUPorWMw+7QKWRNFVTBbE9nRTwmv
	DWY95PzTzr++QCkAHUV6u+/7ZDLWFpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782728148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xk5jXTH0rPYDTmpQI6nSdSsvy17M4jYVpe4SU8tiahY=;
	b=BpMJ1ntCeLVlOKolhbN8HaUmsGiwB83lBGT4W1uFWU6t2F++hQ0/aA8zwOTtg11WzACXj+
	QdFIpnfLyKoR1RAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90F06779A8;
	Mon, 29 Jun 2026 10:15:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CcDDIdRFQmo9DAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 29 Jun 2026 10:15:48 +0000
Date: Mon, 29 Jun 2026 12:15:48 +0200
Message-ID: <87a4sdr6sr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	kees@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] fix: sound/usb: snd_media_device_create: incorrect media_device_delete on borrowed reference
In-Reply-To: <20260627040907.60784-1-vulab@iscas.ac.cn>
References: <20260627040907.60784-1-vulab@iscas.ac.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CBBE475D7B
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Sat, 27 Jun 2026 06:09:07 +0200,
WenTao Liang wrote:
> 
> In snd_media_device_create(), when chip->media_dev is already set, mdev
> borrows the reference without incrementing the refcount. On error paths
> through create_fail, media_device_delete() is called which releases the
> borrowed reference, corrupting the reference count. Additionally,
> chip->media_dev is set to NULL, losing the original reference.
> 
> Introduce an 'allocated' flag to distinguish between borrowed and
> self-allocated references, and only call media_device_delete() when the
> reference was actually acquired by this function invocation.

Does this really happen?  The code in question is after the check by
media_devnode_is_registered(), and if chip->media_dev has been already
set, it means that it should have been already registered, hence this
code path won't hit.


thanks,

Takashi


> 
> Cc: stable@vger.kernel.org
> Fixes: 66354f18fe5f ("media: sound/usb: Use Media Controller API to share media resources")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
>  sound/usb/media.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/usb/media.c b/sound/usb/media.c
> index b7497d18ee3f..290bd24bf301 100644
> --- a/sound/usb/media.c
> +++ b/sound/usb/media.c
> @@ -255,6 +255,7 @@ int snd_media_device_create(struct snd_usb_audio *chip,
>  	struct media_device *mdev;
>  	struct usb_device *usbdev = interface_to_usbdev(iface);
>  	int ret = 0;
> +	bool allocated = false;
>  
>  	/* usb-audio driver is probed for each usb interface, and
>  	 * there are multiple interfaces per device. Avoid calling
> @@ -272,6 +273,7 @@ int snd_media_device_create(struct snd_usb_audio *chip,
>  
>  	/* save media device - avoid lookups */
>  	chip->media_dev = mdev;
> +	allocated = true;
>  
>  snd_mixer_init:
>  	/* Create media entities for mixer and control dev */
> @@ -292,9 +294,11 @@ int snd_media_device_create(struct snd_usb_audio *chip,
>  create_fail:
>  		if (ret) {
>  			snd_media_mixer_delete(chip);
> -			media_device_delete(mdev, KBUILD_MODNAME, THIS_MODULE);
> -			/* clear saved media_dev */
> -			chip->media_dev = NULL;
> +			if (allocated) {
> +				media_device_delete(mdev, KBUILD_MODNAME, THIS_MODULE);
> +				/* clear saved media_dev */
> +				chip->media_dev = NULL;
> +			}
>  			dev_err(&usbdev->dev,
>  				"Couldn't register media device. Error: %d\n",
>  				ret);
> -- 
> 2.39.5 (Apple Git-154)
> 
