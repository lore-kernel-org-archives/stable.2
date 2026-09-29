Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804C3F5BFC;
	Tue, 29 Sep 2026 05:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790661496; cv=none; b=qJ65snOZMtk27U82xpz9MQKA/IFTHLD23zE8x66GBW4hiv9+Pe8WWCg/xoiXnldEw7Ktj/2leFMloYRPd+ynzHzZc1dIVij0WvwYcT4htbHmaxLX5v4oNdtOAPvN2WQrEkNegGM5cVTKxHnJDbSPfWdISf3FEjRR4g/UugLXlgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790661496; c=relaxed/simple;
	bh=dYWTGKEmLy9RCuDX9LBRoIFyt0G1rRI61VU8mKpqEG8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kn3ddbmr0UN6rICGuFBBKZa7KjWZsE4ZZ3IoTXRZgs0yeir5G9BrkWLdICinhtgKINxuwcLK2Xra1dMxf/ugTOJcPqrHHh5wh9bXQKSt+ArT5arE8bPUWpNdhRgOCQpNOwJsGrOknedybFcUeoUDPaT20a0P2BHGTp6gYXkCs5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WtG3rPAX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MFAcjth6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vEzcR55v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MNGEDZBL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WtG3rPAX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MFAcjth6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vEzcR55v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MNGEDZBL"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8215C1F79E;
	Tue, 29 Sep 2026 05:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790661488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HqOlcpvcIyNFLst/qfqz9TJtK91EoerlTMtFztTgEJE=;
	b=WtG3rPAXfa9oKArYYfe8zHGwgGKKYuim1N6GvQiEkilp7tqaPmR1e/xYyGbIgthydyX6Pb
	CXWNrwAAZ/f1Q3kgGGzSnGgIDnKaqrWdTqv68jP4/IO24Wf6ysblNMjYJxk454V5kEPEcZ
	HbNk7j927Ne55pMUhhGNTsrHFpr0DUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790661488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HqOlcpvcIyNFLst/qfqz9TJtK91EoerlTMtFztTgEJE=;
	b=MFAcjth6jNmE0BbSFRRLjoNYr3dJByXNh+YPeiRo4SrCL2taXqES2hQv2xXmrDT/RBLI2x
	3rbpyClZLk75qXCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vEzcR55v;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MNGEDZBL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790661484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HqOlcpvcIyNFLst/qfqz9TJtK91EoerlTMtFztTgEJE=;
	b=vEzcR55vVicyUIC8CrZyFeLKvMnTmP6RkT2VNRtFmPlEKtS2NJRPreTzWo2U/GIb1jkgvc
	tIRo/RNMAVr5DeksG/CKZJCYDriW/kFaL1tjRRJFLiV/qgdxr68PmOLVL1iMiOIaFftmFK
	ZGVvxgW0yEtcIh0xPaLecgFBSNy2MSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790661484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HqOlcpvcIyNFLst/qfqz9TJtK91EoerlTMtFztTgEJE=;
	b=MNGEDZBLTCB2hyjz1aB59js81oabbjwbD89TGYNNNYhifI5rtMW2aBh95FO2s5bI2VVSSY
	yegKggKA8MuFZjDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AFC0133F1;
	Tue, 29 Sep 2026 05:58:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JbwcOGtTu2odMQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 29 Sep 2026 05:58:04 +0000
Date: Tue, 29 Sep 2026 07:58:03 +0200
Message-ID: <87tsn838gk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sasha Levin <sashal@kernel.org>
Cc: Faaris Ansari <faarisansari@googlemail.com>,	stable@vger.kernel.org,
	regressions@lists.linux.dev,	linux-sound@vger.kernel.org,
	=?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>,	Takashi
 Iwai <tiwai@suse.com>,	Jaroslav Kysela <perex@perex.cz>,	Faaris Ansari
 <faaris.ansari@gmail.com>
Subject: Re: [REGRESSION] Audient EVO4 hardware volume control now requires quirk
In-Reply-To: <2026-09-28-2-daily-reply-0001-re-audient-evo4-channel-3-set-cur@kernel.org>
References: <CANBVYRCL=8QdLxGg4S6qrahrFtwJxhv-aSGpW7-1S=+iOe4ZGA@mail.gmail.com>
	<2026-09-27-daily-reply-0001-re-audient-evo4-mixer-put-errors@kernel.org>
	<CANBVYRAr_ShKGmrt2NoqsDsDEbTXa5DWJbq2oP6wKLWJQpLRWw@mail.gmail.com>
	<2026-09-28-daily-reply-0001-re-audient-evo4-upstream-decision@kernel.org>
	<ee6e9e8f-e174-4872-baee-114d848e8137@gmail.com>
	<2026-09-28-2-daily-reply-0001-re-audient-evo4-channel-3-set-cur@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -2.01
X-Rspamd-Queue-Id: 8215C1F79E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[googlemail.com,vger.kernel.org,lists.linux.dev,gmail.com,suse.com,perex.cz];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Spam-Flag: NO

On Tue, 29 Sep 2026 00:39:05 +0200,
Sasha Levin wrote:
> 
> > [   80.940668] usb 3-1: cannot set ctl value: req = 0x1, wValue = 0x203,
> > wIndex = 0xa00, type = 4, data = 0x0/0x81
> [...]
> > numid=4,iface=MIXER,name='EVO4  Playback Volume'
> >    ; type=INTEGER,access=rw---R--,values=4,min=0,max=254,step=0
> >    : values=182,182,0,0
> 
> Thanks, that narrows it down.
> 
> Every failure is SET_CUR of the Volume control on feature unit 10, channel 3
> (wValue 0x0203, wIndex 0x0a00). That unit is 'EVO4  Playback Volume' and
> advertises read/write volume on all four channels. mixer_ctl_feature_put()
> writes channels 1 and 2, then returns the channel 3 error, so the hardware
> volume changes while userspace is told the write failed and adds software
> attenuation on top. Faaris sees the same on 7.3-rc5, so this is a mainline
> regression from 87a6f2fa6e6c ("ALSA: usb-audio: Propagate write errors in
> generic mixer put callbacks").

Right.  So a simple fix would be to just to set the IGNORE_CTL_ERROR
quirk flag like below.  One of iD14 models has already this flag, so
it might be safer to set to all Audient devices.


thanks,

Takashi

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2690,6 +2690,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	DEVICE_FLG(0x2708, 0x0002, /* Audient iD14 */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
+	DEVICE_FLG(0x2708, 0x0006, /* Audient EV04 */
+		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x2772, 0x0502, /* Musical Fidelity M6s DAC */
 		   0), /* for avoiding QUIRK_FLAG_DSD_RAW with vendor match */
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
