Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF75415F08;
	Mon, 28 Sep 2026 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790593631; cv=none; b=C5EEKbN1Qaf/04BlsP4meKEBZpWo/z6Qa5/jD9YrJAaZV8oXYEIt7WB2FC2b27dQVQSEaXetUm6DA12y85rK3Ob/M9G/ViiZqVlsXb3tEhj4/VJAuPpw40F4MbQk/Fq6D3u2j51Vd5F5sCjKngrGmiz0sZTV4IG2oalzRrrBck8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790593631; c=relaxed/simple;
	bh=JuFta5vYDKkfyWSB7vYFGBGTLaKRCKTKF6A01c56UNM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGfU1YCJFpMfUNxX0xELjIb3CyMON6KUg4c/ht+oRkvoLFU9ObVNf4j1FN7dUi7jD5NHqJHH3V6M0Zkw/5oVNEcKZ9nAh9cO9DUdaDtVhM9HC5zScPhPUAVf+MSlKgk3snx1Y8KZ4TbF8I6slYgVlCqseDQ1qk6OUsL2ul1vdwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=plAWPkrL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=av87D/iR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qV+phgV6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SMlY4QI+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="plAWPkrL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="av87D/iR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qV+phgV6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SMlY4QI+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7CF2D1F812;
	Mon, 28 Sep 2026 11:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790593624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9XybMtF/N4JRglGOx/jG/Xggqki2sIqdTfZWMVmqzXE=;
	b=plAWPkrLz8aLCjXrVAmv1ExeAO6FfbtmGBZ2SeBdM56vh6tV78d8YrzKSBlPSjfJsWOK9g
	MUT4SHj9rJeAQWf5yhbMaSU/CSYAeoHULduRDWpl6igy39dgSLnuQ+sSQOAGj65i5AZ8Q0
	QYtlQzr9y/hYLGfw2N2XNUkTqvnh25Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790593624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9XybMtF/N4JRglGOx/jG/Xggqki2sIqdTfZWMVmqzXE=;
	b=av87D/iRaMe9qQExAttu/T6ud3rmCwBi6Hb5qgghSuMbdGRSpZL5+J2iIJAlt/lptVfbbz
	yTAwbFna7pRc9TCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790593620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9XybMtF/N4JRglGOx/jG/Xggqki2sIqdTfZWMVmqzXE=;
	b=qV+phgV6cxj/XOoeiigha3TjbiSxZg7LO+UYv5Q0huHpMdjjEw3ZdoDUMqxhYVnAuq1fRg
	mDa7YKKEDdCT/N/+xLPhbEoYTDcM9ZtU1lWKINbuAAQOEhbJhZvD41NfbJZ80Ii3+aIeBO
	izhF1lI4a6mhoZL0itTbyMXfrNwgNmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790593620;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9XybMtF/N4JRglGOx/jG/Xggqki2sIqdTfZWMVmqzXE=;
	b=SMlY4QI+BdXyYzr1A/WzPCNmErgLU3daJolaJc5N2xqQaSGlQ0Jy+4MLSpsTZHoCbywTHG
	EMH8rM+y30+boGDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28FF5133F1;
	Mon, 28 Sep 2026 11:07:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HtepAFRKumqGJwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 28 Sep 2026 11:07:00 +0000
Date: Mon, 28 Sep 2026 13:06:59 +0200
Message-ID: <87eced7hyk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: baojun.xu@ti.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/tas2781: Fix ACPI device double put in tas2781_read_acpi()
In-Reply-To: <20260917164520.2163024-1-vulab@iscas.ac.cn>
References: <20260917164520.2163024-1-vulab@iscas.ac.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Thu, 17 Sep 2026 18:45:20 +0200,
Wentao Liang wrote:
> 
> The reference returned by acpi_dev_get_first_match_dev() is already
> released right after the physical node is looked up. The adev variable
> is not reassigned afterwards, so the acpi_dev_put() on the err path is a
> second, spurious put of the same device, which unbalances the reference
> count, or frees the device while physdev may still be in use.
> 
> Drop the redundant acpi_dev_put() from the error path.
> 
> Fixes: bb5f86ea50ff ("ALSA: hda/tas2781: Add tas2781 hda SPI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

This should have been already addressed in the commit 8bec01c80e79.
Could you verify whether there is still an issue in the latest
upstream?


thanks,

Takashi

> ---
>  sound/hda/codecs/side-codecs/tas2781_hda_spi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
> index 0e4f3553f273..63f8b15c2d8c 100644
> --- a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
> +++ b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
> @@ -386,7 +386,6 @@ static int tas2781_read_acpi(struct tas2781_hda *tas_hda,
>  err:
>  	dev_err(p->dev, "read acpi error, ret: %d\n", ret);
>  	put_device(physdev);
> -	acpi_dev_put(adev);
>  
>  	return ret;
>  }
> -- 
> 2.34.1
> 
