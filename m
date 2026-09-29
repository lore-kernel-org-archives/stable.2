Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9023E49F5;
	Tue, 29 Sep 2026 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687661; cv=none; b=ldKS5THj/2U6T3MPm/MFC17bGGmfO8nOBuHz+7bG5vTyEbVLelF3pJseBb+MQ7wbDY3mk7I8Yqy7p7F9z1frHqBV6vU5vHhhC1W1JCl1Op7Wo+nFXziCPwITWZLJMksZviGBIXcWFEQ6Kp2fSRZArsvI7ieyuqGn+R1Sn/5bXU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687661; c=relaxed/simple;
	bh=V9p/JGAt2mLH6zFOQCX27yHoAKyKP7con7WGcPR45gQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mj8fyDp3G6VHHAaN63z9SlI1E9z6p9DWYYYIAYTxKWAMV/B00aPpUY6djaqyLanod08DBZB9iyV59Xv/aBAcbGHEHs9Bvgd1vKnCGpYBj48pQ6jLUsn/88MHIWULJojzpg8cQWQVEN2l42X1N3PFnhUbM0uK8i00vLcpwdfXubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MLt/gJfl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BJabApVH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QjQsDeJP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F5ZfzRj6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MLt/gJfl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BJabApVH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QjQsDeJP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F5ZfzRj6"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7E061F391;
	Tue, 29 Sep 2026 13:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790687653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=46bz9UIR9B1uzYpolE+hSSENMSPdn7y+CNsafSWJblw=;
	b=MLt/gJflb8QZwWkgTzG4+o+D7akZUQI3mTCCORfcercbphYPpm6Yo5azevPUfoZNvGvAbt
	Ec+uDnu/fj44nKSxVIgtMoHJ0UO9xSPb8HVB2xIn6K6RC8IpT6/D9zGiETiOGs7QofDNW7
	kSd+NHtrUF+sWKVCG0dzBduFroi0g+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790687653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=46bz9UIR9B1uzYpolE+hSSENMSPdn7y+CNsafSWJblw=;
	b=BJabApVHDxMqTMIzDtr+qmgpYt1L2KBWM8V1N42VM+jVfN3jvw9nvm6sNRnljEwSaDCa5K
	bNWQxNg4kQ/dMOCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QjQsDeJP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=F5ZfzRj6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790687649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=46bz9UIR9B1uzYpolE+hSSENMSPdn7y+CNsafSWJblw=;
	b=QjQsDeJPkmroaoxdSkWMgWuEf0pylvuuv0fystExEYeTlScVsA8ApWAh8lCtwE11ij7gOt
	t/u80veW+kH/VadyugiYaiuSrGy3YG9qR3KsUnRbHeDwgN9ubmi9e30ONYcpxUtnA1q2Iu
	+y9BN+3N0tMBhfAjbXH1yacTha99t20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790687649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=46bz9UIR9B1uzYpolE+hSSENMSPdn7y+CNsafSWJblw=;
	b=F5ZfzRj6c+ObzWhea1QYI6USff+3p3yT13rLxIStKPtbO0X3Nn85Fuh1akzUdVREMYczm+
	D/aKTJsTKh5h2uAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E6D1136D1;
	Tue, 29 Sep 2026 13:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FUSzEKG5u2qhDAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 29 Sep 2026 13:14:09 +0000
Date: Tue, 29 Sep 2026 15:14:09 +0200
Message-ID: <87ecec19pa.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Faaris Ansari <faarisansari@googlemail.com>
Cc: Sasha Levin <sashal@kernel.org>,	stable@vger.kernel.org,
	regressions@lists.linux.dev,	linux-sound@vger.kernel.org,
	=?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>,	Takashi
 Iwai <tiwai@suse.com>,	Jaroslav Kysela <perex@perex.cz>,	Faaris Ansari
 <faaris.ansari@gmail.com>
Subject: Re: [REGRESSION] Audient EVO4 hardware volume control now requires quirk
In-Reply-To: <87mrt01bdg.wl-tiwai@suse.de>
References: <CANBVYRCL=8QdLxGg4S6qrahrFtwJxhv-aSGpW7-1S=+iOe4ZGA@mail.gmail.com>
	<2026-09-27-daily-reply-0001-re-audient-evo4-mixer-put-errors@kernel.org>
	<CANBVYRAr_ShKGmrt2NoqsDsDEbTXa5DWJbq2oP6wKLWJQpLRWw@mail.gmail.com>
	<2026-09-28-daily-reply-0001-re-audient-evo4-upstream-decision@kernel.org>
	<ee6e9e8f-e174-4872-baee-114d848e8137@gmail.com>
	<2026-09-28-2-daily-reply-0001-re-audient-evo4-channel-3-set-cur@kernel.org>
	<87tsn838gk.wl-tiwai@suse.de>
	<87mrt01bdg.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[googlemail.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,gmail.com,suse.com,perex.cz];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Spam-Score: -2.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A7E061F391
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Tue, 29 Sep 2026 14:38:03 +0200,
Takashi Iwai wrote:
> 
> On Tue, 29 Sep 2026 07:58:03 +0200,
> Takashi Iwai wrote:
> > 
> > On Tue, 29 Sep 2026 00:39:05 +0200,
> > Sasha Levin wrote:
> > > 
> > > > [   80.940668] usb 3-1: cannot set ctl value: req = 0x1, wValue = 0x203,
> > > > wIndex = 0xa00, type = 4, data = 0x0/0x81
> > > [...]
> > > > numid=4,iface=MIXER,name='EVO4  Playback Volume'
> > > >    ; type=INTEGER,access=rw---R--,values=4,min=0,max=254,step=0
> > > >    : values=182,182,0,0
> > > 
> > > Thanks, that narrows it down.
> > > 
> > > Every failure is SET_CUR of the Volume control on feature unit 10, channel 3
> > > (wValue 0x0203, wIndex 0x0a00). That unit is 'EVO4  Playback Volume' and
> > > advertises read/write volume on all four channels. mixer_ctl_feature_put()
> > > writes channels 1 and 2, then returns the channel 3 error, so the hardware
> > > volume changes while userspace is told the write failed and adds software
> > > attenuation on top. Faaris sees the same on 7.3-rc5, so this is a mainline
> > > regression from 87a6f2fa6e6c ("ALSA: usb-audio: Propagate write errors in
> > > generic mixer put callbacks").
> > 
> > Right.  So a simple fix would be to just to set the IGNORE_CTL_ERROR
> > quirk flag like below.  One of iD14 models has already this flag, so
> > it might be safer to set to all Audient devices.
> 
> ... and below is such a version to cover all Audient devices:
> 
> Faaris, please let us know if this (or previous) one actually works
> for you.  Once after confirmation, I'll submit the proper patch for
> upstream.

... or if you have a chance to test Christian's patch set and verify
whether the problem is fixed there, we can avoid other changes:
  https://lore.kernel.org/20260919151840.24371-1-arc@gmx.li


Takashi
