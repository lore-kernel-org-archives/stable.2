Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D6B3A901D;
	Tue, 29 Sep 2026 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705500; cv=none; b=kSnzJU8x8CQ1BmUKsmnl0ycyUYmrGUb+xLQwgBnRbCmgkYueaD+5IqLmYGXEo61V0Iy0LDYyLJo8X8Xwf0yJNhliE7yE/JzP5ow9E1ym+bFdZe98KYIYUhvJTd4MfOY+8pNJXy+eOifsZtt6btYA80D4RfP5rBzKwua/BCeBJSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705500; c=relaxed/simple;
	bh=ZC/1BAGTEGyUZTJ5wnEnOfra8VAiWtX8d1bOgYEgIQc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFBz1JOP0sGJ/kn/lg/fE64Zkurldx2mZt6Qcrkppzn+j+JtpSbW3ohEiB6HljjN5+XVS5mgZea8rPPivo/NWTvIUb6nshe2+VnoaHMo9IQ1Qb7qrCKlQU4r00yZcLZY5K4Z3fwpImEsd/mcWcLnxdY5B5uhwhk0uQEmWyJjVYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=08edolbw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H3eI1mdw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W6FmG3ev; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qDH59VVG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="08edolbw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H3eI1mdw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W6FmG3ev";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qDH59VVG"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CFF41F449;
	Tue, 29 Sep 2026 18:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790705481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NgcLbakM2L9wTwco9aUXFMr5hk4/sbbU9mjRuZYCqy0=;
	b=08edolbw8g7+vJPSbYvQQNz2pKRxDjRl7gmMN4O4qjlMYiG849ohRaKyyZXdGC0IH6DreK
	5WkLp7HcHYcsdPnQsNpAnPT3SuaYjLvtjU3Xg52dCw3DqjDdsui/KEQbiJ8Wqz9Z1VvZkQ
	BIMxVylgswpkk2egSIgJk4mO/9xDKZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790705481;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NgcLbakM2L9wTwco9aUXFMr5hk4/sbbU9mjRuZYCqy0=;
	b=H3eI1mdwMFwiKtdIFXU/IXmBXwy9Dl/AqllhiPZjycPv2IPX31sZzF/ltWR/MtOsR29q9a
	dxhMoDCYSymetuAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790705477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NgcLbakM2L9wTwco9aUXFMr5hk4/sbbU9mjRuZYCqy0=;
	b=W6FmG3evGc2agAAPPzkZSLth6uDFUBYm+FiMzWxgUjX3oDZlrO+Yolq4NyD2cJfq7RbBgN
	3kuhNOhLm+SJTxGiwSZG1fZOdH6V53u7tQsMLl6ejQhlg+NdcGu9QN+4ewos8UsFK04o31
	lMWhGXQzGZ5Z88rt4rAO5eyIDdN8Awg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790705477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NgcLbakM2L9wTwco9aUXFMr5hk4/sbbU9mjRuZYCqy0=;
	b=qDH59VVGH0KasGFaV/Jjs1DwcBFPkd47By4LHgmMtlFH8YIksuvEwjDuVJaTFJfryrkHlE
	aj2ogJ6DHhwMFrAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96166136D1;
	Tue, 29 Sep 2026 18:11:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0ZQPG0T/u2oxUQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 29 Sep 2026 18:11:16 +0000
Date: Tue, 29 Sep 2026 20:11:16 +0200
Message-ID: <87a4p0ylkr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	linux-sound@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/tegra: Re-enable SDO workaround for Tegra194
In-Reply-To: <CALHNRZ8RLs6mXkYiZ4qRimmf4WzpWpnJ9racWTPH__Op2Nk8kg@mail.gmail.com>
References: <20260926-tegra194-hda-sdo-v1-1-f7a636a07a58@gmail.com>
	<aruc3qx7izFQYOhC@orome>
	<CALHNRZ8RLs6mXkYiZ4qRimmf4WzpWpnJ9racWTPH__Op2Nk8kg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO

On Tue, 29 Sep 2026 19:22:25 +0200,
Aaron Kling wrote:
> 
> On Tue, Sep 29, 2026 at 6:12 AM Thierry Reding
> <thierry.reding@kernel.org> wrote:
> >
> > On Sat, Sep 26, 2026 at 02:24:19AM -0500, Aaron Kling via B4 Relay wrote:
> > > From: Aaron Kling <webgeek1234@gmail.com>
> > >
> > > This workaround was originally added for Tegra194, but no longer gets
> > > applied for it. Commit 615d43540043 ("ALSA: hda/tegra: fix tegra-hda on
> > > tegra30 soc") changed the guard to tegra30-hda, which worked because all
> > > affected archs had the fallback compatible. However, commit 7f0ea5acfc19
> > > ("arm64: tegra: Use correct compatible string for Tegra194 HDA") removed
> > > the fallback compatible for Tegra194, causing this to break.
> > >
> > > Fixes: 7f0ea5acfc19 ("arm64: tegra: Use correct compatible string for Tegra194 HDA")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: LLM
> > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > ---
> > > ALSA: hda/tegra: Re-enable SDO workaround for Tegra194
> > > ---
> > >  sound/hda/controllers/tegra.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > Maybe we should move this out of of_device_is_compatible() conditionals
> > and into hda_tegra_soc instead. That would make the checks for this a
> > lot more consistent and robust.
> 
> I received a notification from Takashi Iwai that this has already been
> picked up, but it was only sent to me and not the list. Not sure why.
> But looking at -next, it's already there. Not sure if you would want
> to have that pulled back for updates or do followups later.

Ah, I overlooked that your mail had 'Reply-To', and my mailer followed
it as default.

And yes, the patch was already queued for 7.4.  But if anyone has a
better alternative, feel free to submit as an incremental fix.


thanks,

Takashi
