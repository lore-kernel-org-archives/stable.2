Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F1B3644C6;
	Sun, 11 Oct 2026 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791708489; cv=none; b=KWP9QpY5300ANsZ1D41cwbNw8/jYWQVk71W5frRhiJgN8eY5x63mhRnNbpIPo8gIEH8+cewoNbPeg8jOSCMAGK9X6lVciuF33/ZUCRQZ5LeAljwjJ1b+lz6PM35/hY3Pdy/ucmsTtM0Hx9Ue5QVYVt1CQD3Xbz7TrDLSYDW7RtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791708489; c=relaxed/simple;
	bh=x2IsOvbtgXQiwEIuFiG1fuZtAaXxvLftWk+3ijwN8tc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVxzqlg3DNKZh3JF21qm4pLWEGxyngncZ9m+RZvj2xTRul4j8oiCoToY3AArC4zG1iviUqzL/zSPqEl0aXh8pKyfRCw0x/ZpE/W/1Kh/GNMvGKVb8d+HJ7JQxcEIapjNRQ+ssW5fUBMS8qfaHMi/CicB7gh/k2Zfq8+CmnHF3OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rQnXxq9t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B1auYzjz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wHPDw6Dr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ku5PR8Vd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rQnXxq9t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B1auYzjz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wHPDw6Dr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ku5PR8Vd"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4DFE11F750;
	Sun, 11 Oct 2026 08:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791708486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2bxbAabFpli0yHxHck/fqu9NfMRGLevdTk0BX0wmfCM=;
	b=rQnXxq9tD+LAsfwVK3GyZndziEIIWf/y6Wj7IjyFdJpjR6J3lvqHdPKXFT3UDqTcg2LbOW
	RnMtMJ8/FakM7rJcSWmtz//JIjlNPIth8pgqFqWZHqVuNSZ5mQYxwmVyoF0D4zudPe6NsA
	aWjepuMkeRWyYiyfcdTVAPYqCY/0K34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791708486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2bxbAabFpli0yHxHck/fqu9NfMRGLevdTk0BX0wmfCM=;
	b=B1auYzjzXUYQdY6HmJG97BbaRDTj6AMC2xnn7lA9wp0EbAOP3EPcNjrwcUwm65T1hwmN+k
	t0+SUo7rDkO3QjBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791708485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2bxbAabFpli0yHxHck/fqu9NfMRGLevdTk0BX0wmfCM=;
	b=wHPDw6DrNzH0hzAHt7/IDBilnkFBMl2I9ZhT6snuGYn26txNtTqSwpXI4rhal6cbyfkmQ2
	SM8GHvPIF8hZdQoRKFVSjVhrBd1Ob87G/fm/DCMW85EN62vyJUCAAToOW4xqobwEod9sfS
	NFF5eyw3CKeR5s1LU/H9qi1XVVeS5r8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791708485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2bxbAabFpli0yHxHck/fqu9NfMRGLevdTk0BX0wmfCM=;
	b=ku5PR8VdakE829yO8tJ6CMUtUtQMrVRDO4iZxFSukO/CsHIXQT77eNbi0hdJTTt3ZbHHxs
	cvAyaR1/xIOcslDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A837E13408;
	Sun, 11 Oct 2026 08:48:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VWW9HkRNy2rJEAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 11 Oct 2026 08:48:04 +0000
Date: Sun, 11 Oct 2026 10:48:04 +0200
Message-ID: <87mrskipx7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ma Ke <make_ruc2021@163.com>
Cc: david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: cs35l41: Fix ACPI device reference leak on probe failure
In-Reply-To: <20261011062801.3163066-1-make_ruc2021@163.com>
References: <20261011062801.3163066-1-make_ruc2021@163.com>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,sashiko.dev:url]

On Sun, 11 Oct 2026 08:28:01 +0200,
Ma Ke wrote:
> 
> cs35l41_hda_probe() takes an acpi_device through
> cs35l41_hda_read_acpi() and stores it in cs35l41->dacpi. It is
> released in the err: label, which is reached from every later failure.
> 
> One failure is not routed there:
> 
>         ret = cs35l41_hda_read_acpi(cs35l41, device_name, id);
>         if (ret)
>                 return dev_err_probe(cs35l41->dev, ret, ...);
> 
> cs35l41->dacpi is assigned inside cs35l41_hda_read_acpi(), before the
> point where it can fail:
> 
>         adev = acpi_dev_get_first_match_dev(hid, NULL, -1);
>         ...
>         cs35l41->dacpi = adev;
>         ...
>         ret = cs35l41_hda_parse_acpi(cs35l41, physdev, id);
>         if (ret)
>                 return ret;
> 
> so on that path the reference taken by acpi_dev_get_first_match_dev()
> is never dropped, and cs35l41->acpi_subsystem_id is leaked as well.
> This is reachable on any system whose ACPI description does not match
> what the driver expects.
> 
> Route the failure through a new err_acpi label that releases both.
> 
> cs35l41_hda_read_acpi() also drops the reference on its own !physdev
> path while leaving cs35l41->dacpi pointing at the released device.
> Clear the pointer there so the reference is not dropped a second time
> from either cleanup path.
> 
> Found by code review.
> 
> Fixes: 447106e92a0c ("ALSA: hda: cs35l41: Support mute notifications for CS35L41 HDA")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ma Ke <make_ruc2021@163.com>

While the error path you're correcting looks right, but could you
check the issue reported by Sashiko?
  https://sashiko.dev/#/patchset/20261011062801.3163066-1-make_ruc2021%40163.com
IIUC, the suggestion there looks correct, and we have already the
unreference call in the error path of cs35l41_hda_parse_acpi(),
indeed.

The refcount management there is really messy, admittedly...


thanks,

Takashi

> ---
>  sound/hda/codecs/side-codecs/cs35l41_hda.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
> index 62296be45c55..1088065f1fff 100644
> --- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
> +++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
> @@ -1929,6 +1929,7 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
>  	struct device *physdev __free(put_device) =
>  		get_device(acpi_get_first_physical_node(adev));
>  	if (!physdev) {
> +		cs35l41->dacpi = NULL;
>  		acpi_dev_put(adev);
>  		return -ENODEV;
>  	}
> @@ -1986,8 +1987,10 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
>  	dev_set_drvdata(dev, cs35l41);
>  
>  	ret = cs35l41_hda_read_acpi(cs35l41, device_name, id);
> -	if (ret)
> -		return dev_err_probe(cs35l41->dev, ret, "Platform not supported\n");
> +	if (ret) {
> +		dev_err_probe(cs35l41->dev, ret, "Platform not supported\n");
> +		goto err_acpi;
> +	}
>  
>  	if (IS_ERR(cs35l41->reset_gpio)) {
>  		ret = PTR_ERR(cs35l41->reset_gpio);
> @@ -2066,6 +2069,12 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
>  
>  	return 0;
>  
> +err_acpi:
> +	acpi_dev_put(cs35l41->dacpi);
> +	kfree(cs35l41->acpi_subsystem_id);
> +
> +	return ret;
> +
>  err_pm:
>  	pm_runtime_dont_use_autosuspend(cs35l41->dev);
>  	pm_runtime_disable(cs35l41->dev);
> -- 
> 2.43.0
> 
