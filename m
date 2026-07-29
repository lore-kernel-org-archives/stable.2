Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB78175A72
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785306333; cv=none; b=G6GZyE/vDkC+iw576AnYmbDotAuOIyV1rdDQprShQXNIFN7VZ2cs7ptB4GRoC9z+bIZL+tj7v48tdCwbCTaiCkwTZ/qfjjlvHn9oDycVEe+BItwGBWSBole2IMJNToPika14YNqTK8KTr8vgCWGbPCGYyv4Tlb+1SVMDoPZj9oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785306333; c=relaxed/simple;
	bh=1f1TNTTbmBLXHfEHvq2Pk8c6l5/WMi4Pe83iZigW8zU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yc5u/K0rgTLK8AkCgnpwUz4Mfj5zpO2FMLJtqdIN9ZE7QE5MlkHCJIkeonRiLVrg9r7ERNeAGk7oBoNlCh2di4WfRxgByMpgQIQkB/8YQ8mLSqudmv0d9ATQA+qAPFldMRtP6RYvQ3uIKTQ4aG6x3SUh4X879H+WH4zfXYoRmeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=stmPyluO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q93YyFK8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Qq2tmL4/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AhfRPYeC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="stmPyluO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q93YyFK8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Qq2tmL4/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AhfRPYeC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B93963E33;
	Wed, 29 Jul 2026 06:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785306320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BcfjQ8efsmOv5bMk4RUgMaAjzifTKf2MCS9w/xFVkuQ=;
	b=stmPyluOgV0uNHaQU+rkw2faQcAmDj/03+3dsg9ptg+BKNQ1u4e8SPhD1lMnV7O/y8zSlw
	F/mTHemkOaO09eubfG8OtSHCZ0H5mGcAGEpIsxaEShoVietNQkWadOZ5xreR2cZxZdHj3C
	mmVzOtUeAqeiexoENIl33sWSN36OVmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785306320;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BcfjQ8efsmOv5bMk4RUgMaAjzifTKf2MCS9w/xFVkuQ=;
	b=q93YyFK8AYFNs0ymep+uDa1PANsFEJr1NnuT8kycuEG0/O/3Qi/2MDjcIljwdZLHDZM0Ai
	WOxXcImDk8XpbOAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Qq2tmL4/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AhfRPYeC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785306316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BcfjQ8efsmOv5bMk4RUgMaAjzifTKf2MCS9w/xFVkuQ=;
	b=Qq2tmL4/kyfS2ATwtTcJMjjlx+8+qnFSkfGOeUeF/gAl4luIiC7MKUTid2Y+nyMGl1Mgx3
	KUH1Gl1xmhMsgrXERqpj70N5P/iEzQUL/YE/oBm+wg2QyAmITLzk93EYPG7T+q4NS0lTLs
	GBEf2BChpW3cMPjp19btyBk5XTEpGAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785306316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BcfjQ8efsmOv5bMk4RUgMaAjzifTKf2MCS9w/xFVkuQ=;
	b=AhfRPYeCV8thkiNV7+uuqrgFwC1P1rn0CUdk3UpFMoczjWEe9UVdQqixKhgivB9lK62j0z
	4LA4/v0RON3GE0BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60644779A1;
	Wed, 29 Jul 2026 06:25:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J6Y/FsycaWpeVgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 29 Jul 2026 06:25:16 +0000
Date: Wed, 29 Jul 2026 08:25:15 +0200
Message-ID: <87se525n3o.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sonali Pradhan <sonalipradhan@google.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Daniel Mack <zonque@gmail.com>,
	Gordon Chen <chengordon326@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jussi Laako <jussi@sonarnerd.net>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Fix DMA buffer out-of-bounds write when fill_max is set
In-Reply-To: <20260728201716.2347726-1-sonalipradhan@google.com>
References: <20260728201716.2347726-1-sonalipradhan@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B93963E33
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,gmail.com,kernel.org,sonarnerd.net,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Tue, 28 Jul 2026 22:17:16 +0200,
Sonali Pradhan wrote:
> 
> When a USB audio endpoint requests full packet transfers via the fill_max
> descriptor flag, data_ep_set_params() promotes ep->curpacksize to
> ep->maxpacksize. However, maxsize is left at the original sample-rate
> derived value.
> 
> Since u->buffer_size is allocated as maxsize * packets, the resulting
> DMA buffer is far too small for the requested transfer length. When the
> USB host controller streams up to curpacksize bytes per packet, it writes
> past the end of the buffer via DMA, corrupting kernel heap memory.
> 
> Update maxsize to curpacksize when fill_max is set so that the allocated
> DMA buffer size matches the actual transfer request size.
> 
> Fixes: 8fdff6a319e7 ("ALSA: snd-usb: implement new endpoint streaming model")
> Cc: stable@vger.kernel.org
> Assisted-by: Jetski:Gemini-3.6-Flash
> Signed-off-by: Sonali Pradhan <sonalipradhan@google.com>
> ---
>  sound/usb/endpoint.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
> index 24cd7692bd01..d825c09a766a 100644
> --- a/sound/usb/endpoint.c
> +++ b/sound/usb/endpoint.c
> @@ -1172,6 +1172,7 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep)
>  		ep->curpacksize = ep->maxpacksize;
>  	else
>  		ep->curpacksize = maxsize;
> +	maxsize = ep->curpacksize;
>  

Unconditionally reassigning here makes harder to understand the
intention.  So I modified slightly to make the reassignment
conditional, only when ep->fill_max is set.

	if (ep->fill_max) {
		ep->curpacksize = ep->maxpacksize;
		maxsize = ep->curpacksize;
	} else {
		ep->curpacksize = maxsize;
	}

Applied the fix in the form above now.  Thanks.


Takashi
