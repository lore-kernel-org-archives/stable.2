Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1208A4AFE32;
	Fri,  2 Oct 2026 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951842; cv=none; b=rSszeDJ4bl26cg75nqTwZPMEpvecHRZrHQSpevpdzf/jY2QPj39HZTK0RVjbFbu1hIXWGwzOk5Ho7eOKHfVlQ+7LlWfcKyxzt8/QXLJOP7otqjwULiAzNYrLqG3Tgtty4+Hwv2N0oXSOXigm59pP80/eyzlWsl1Lgyy+D7f0+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951842; c=relaxed/simple;
	bh=6CH/8IzkIXtGuOK9RJX4Hj6IqM2VPNeN5HI/Cjk6La4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAEERMic4DI4Y8D5xZTkjkEOXbG0R0HU0e8v7sW6y34/kGQ2u7xo7956B3yV9PfRR3iadoyn8JV4VkNAMjJIx9hn8eDT9SZrpnBsEXnCaRTFhpYGvrHwLEoha0iJydT7HUymFJzUMLQrU3i36oUCvf6U9aNGmXIJNOrL/PgQroQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HZrjofbc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nyu9WZIn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bQ97VKaC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7hbTUEHY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HZrjofbc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nyu9WZIn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bQ97VKaC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7hbTUEHY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ED77621D37;
	Fri,  2 Oct 2026 14:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790951831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NMxZ4oqZmkoHvOOj7yXqHEZT7la4YVoeVCdqLi+FXEI=;
	b=HZrjofbcVTwnBPFQFcZgEJJTF5DPMSBg8m4+sPL9TLTjpote2Wrtbgt/oWsKrOw/x/Invx
	ZVaEptrtZsDNQ0LjPA/l7jdifcX+FneIXWxFJe2rzzco4nfE5rw2k+Bbb/xYpl3erUJJ1b
	qwRRa5I2epYQFvTn9mnEY4t744g2BAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790951831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NMxZ4oqZmkoHvOOj7yXqHEZT7la4YVoeVCdqLi+FXEI=;
	b=nyu9WZInMSdTJiw2XAZyhB9mDsfRQ1PeGOzFRBpBX3BnqSfdhFfRyxxM9Zi1EK7yyzbviB
	2+JaP8N+vGGaylAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790951826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NMxZ4oqZmkoHvOOj7yXqHEZT7la4YVoeVCdqLi+FXEI=;
	b=bQ97VKaCe8DJiQ08K9akeAyN8FMyMLjl7OGBYkkt+CycrZ0KaaI2ra8x4L59DYDLQRKtPP
	3/vhIxq+IlYYhQarAs7S9bdzupQQwGEi0yN8OX/MuzozTkNUMOw4FRacj2Md/qD0vemofO
	iAfIKVItK81pLVzOOUDHqZoGLPr9woU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790951826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NMxZ4oqZmkoHvOOj7yXqHEZT7la4YVoeVCdqLi+FXEI=;
	b=7hbTUEHYIEoZnFEBQqU1zhSVY5ikzeECC1jsAlxGyEUjW/iqZxknDs6QfJlIY87TpM4ubH
	7N2d7fclE2BeEsCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AB4D139A3;
	Fri,  2 Oct 2026 14:37:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I+XWGJLBv2reSAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 02 Oct 2026 14:37:06 +0000
Date: Fri, 02 Oct 2026 16:37:06 +0200
Message-ID: <87fqyoyxrh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sasha Levin <sashal@kernel.org>
Cc: Faaris Ansari <faaris.ansari@gmail.com>,	Takashi Iwai <tiwai@suse.de>,
	Faaris Ansari <faarisansari@googlemail.com>,	stable@vger.kernel.org,
	regressions@lists.linux.dev,	linux-sound@vger.kernel.org,
	=?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>,	Takashi
 Iwai <tiwai@suse.com>,	Jaroslav Kysela <perex@perex.cz>
Subject: Re: [REGRESSION] Audient EVO4 hardware volume control now requires quirk
In-Reply-To: <2026-10-01-1-daily-reply-0001-re-audient-evo4-fix-status@kernel.org>
References: <CANBVYRCL=8QdLxGg4S6qrahrFtwJxhv-aSGpW7-1S=+iOe4ZGA@mail.gmail.com>
	<2026-09-27-daily-reply-0001-re-audient-evo4-mixer-put-errors@kernel.org>
	<CANBVYRAr_ShKGmrt2NoqsDsDEbTXa5DWJbq2oP6wKLWJQpLRWw@mail.gmail.com>
	<2026-09-28-daily-reply-0001-re-audient-evo4-upstream-decision@kernel.org>
	<ee6e9e8f-e174-4872-baee-114d848e8137@gmail.com>
	<2026-09-28-2-daily-reply-0001-re-audient-evo4-channel-3-set-cur@kernel.org>
	<87tsn838gk.wl-tiwai@suse.de>
	<87mrt01bdg.wl-tiwai@suse.de>
	<87ecec19pa.wl-tiwai@suse.de>
	<0e1a1284-7069-4c46-9f35-57c10c129883@gmail.com>
	<87wls4yvv8.wl-tiwai@suse.de>
	<2026-10-01-1-daily-reply-0001-re-audient-evo4-fix-status@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,googlemail.com,vger.kernel.org,lists.linux.dev,suse.com,perex.cz];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 

On Fri, 02 Oct 2026 16:19:45 +0200,
Sasha Levin wrote:
> 
> > Thanks for clarification.  Then we need a fix like mine in anyway.
> > I'm going to submit the proper patch.
> 
> Thanks Takashi. a154f7b9f197 ("ALSA: usb-audio: Apply IGNORE_CTL_ERROR
> quirk to all Audient devices") is in your for-linus branch, but it
> isn't in Linus' tree yet.

Yes, and I sent a PR right now to Linus, so hopefully included in
7.3-rc6.

> 87a6f2fa6e6c ("ALSA: usb-audio: Propagate write errors in generic mixer
> put callbacks") is already in 7.2, 6.18 and 6.12, and it is in the
> current 6.6, 6.1, 5.15 and 5.10 -rc1 releases. I'll queue the quirk
> change for the stable trees as soon as it lands upstream.

Thanks!


Takashi
