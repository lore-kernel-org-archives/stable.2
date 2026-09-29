Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184E4524B10;
	Tue, 29 Sep 2026 12:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685499; cv=none; b=oxKDeAOGpq270UYFXNbfZ+hXYxUH4NNaq48zboezmyl4lPxZbBvyjZ2MDelLP9TtsSe05W4AGI5RQdXJFXaAjnwqORrhwB0QCYmOqCFPYW2LdiJL/cunV9UcefBJZR5cFmVFcTfnizb6VoWMAsnt0tN67O0jJeE9eLkyEmXrm2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685499; c=relaxed/simple;
	bh=N016Wq6/SHHakCleZ/df5SJAUlM23T1+j7xKfCp8iy4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDF7tQLwGKhsTmpT5Vwrzb3HiaQBcpCcMvOQo/WWrU9KUKvGWanNsrx9cutWy054TEI3i2MwbLYzZ+3+iWB0t9Kb4J+eARBkhRjmlo1qhkY8dYEVyD3tYBqlbfbCCwrLHbxcACJvhv/ukhrmTnfYn9bGDi1lYcTcxBL7zNUlb64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pDoem6q9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0XsSDUW8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hGviz5nc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3TgjsFiT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pDoem6q9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0XsSDUW8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hGviz5nc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3TgjsFiT"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0308C21CDF;
	Tue, 29 Sep 2026 12:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790685492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1NtVvbChCopOWyJ5GIO/8EB4CDdX0lL6k0zyomFenEo=;
	b=pDoem6q9ZKeiksVakxhGCFXGn60DTaCexAWuhuuNBuuj5N6o+ifmedcc0KdbQpLUCDpD1w
	65QMjt3EMjPfnDd9SzHfuf/4xMXFkCdLM20aya/csbym4qOJF7wwEJ7FGrCqtG6B8+x5B9
	zXU3otAgqyFz4cF75A9p3cq0440Fy+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790685492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1NtVvbChCopOWyJ5GIO/8EB4CDdX0lL6k0zyomFenEo=;
	b=0XsSDUW8TPHkLFOSRUIu9/VKqgZ2b8VE7NJdYyCeI3z0V1MwbVVc07jClEmKbIHmW2y5ls
	/X1s1+3mxpRZtsBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hGviz5nc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3TgjsFiT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790685488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1NtVvbChCopOWyJ5GIO/8EB4CDdX0lL6k0zyomFenEo=;
	b=hGviz5ncmydF8PhwlhfI3ko3hM1w1g1JEmsu9pXr3Q0isTV9fFC9+2wzcGZz6KfwqV7pmf
	H5iaQn8QOdLhEp66mwsyCzTm0C2zBaNkf7+rg2S6JZ4zGm14Vc5H6TaBxnUs9mxNa0gk9j
	okGHQzB8Z29L4OTpycVt5152a3Kubyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790685488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1NtVvbChCopOWyJ5GIO/8EB4CDdX0lL6k0zyomFenEo=;
	b=3TgjsFiTJgsMXVSuEgh4jJM7EEyrlq547cpq4fJfKvvRxZtqGqMumICSDMds51xnTIoD80
	lMG4IcByb9DJe6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91B0A133F1;
	Tue, 29 Sep 2026 12:38:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ifGeGC+xu2oaYwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 29 Sep 2026 12:38:07 +0000
Date: Tue, 29 Sep 2026 14:38:03 +0200
Message-ID: <87mrt01bdg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Faaris Ansari <faarisansari@googlemail.com>
Cc: Sasha Levin <sashal@kernel.org>,	stable@vger.kernel.org,
	regressions@lists.linux.dev,	linux-sound@vger.kernel.org,
	=?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>,	Takashi
 Iwai <tiwai@suse.com>,	Jaroslav Kysela <perex@perex.cz>,	Faaris Ansari
 <faaris.ansari@gmail.com>
Subject: Re: [REGRESSION] Audient EVO4 hardware volume control now requires quirk
In-Reply-To: <87tsn838gk.wl-tiwai@suse.de>
References: <CANBVYRCL=8QdLxGg4S6qrahrFtwJxhv-aSGpW7-1S=+iOe4ZGA@mail.gmail.com>
	<2026-09-27-daily-reply-0001-re-audient-evo4-mixer-put-errors@kernel.org>
	<CANBVYRAr_ShKGmrt2NoqsDsDEbTXa5DWJbq2oP6wKLWJQpLRWw@mail.gmail.com>
	<2026-09-28-daily-reply-0001-re-audient-evo4-upstream-decision@kernel.org>
	<ee6e9e8f-e174-4872-baee-114d848e8137@gmail.com>
	<2026-09-28-2-daily-reply-0001-re-audient-evo4-channel-3-set-cur@kernel.org>
	<87tsn838gk.wl-tiwai@suse.de>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,gmail.com,suse.com,perex.cz];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Spam-Score: -2.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0308C21CDF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Tue, 29 Sep 2026 07:58:03 +0200,
Takashi Iwai wrote:
> 
> On Tue, 29 Sep 2026 00:39:05 +0200,
> Sasha Levin wrote:
> > 
> > > [   80.940668] usb 3-1: cannot set ctl value: req = 0x1, wValue = 0x203,
> > > wIndex = 0xa00, type = 4, data = 0x0/0x81
> > [...]
> > > numid=4,iface=MIXER,name='EVO4  Playback Volume'
> > >    ; type=INTEGER,access=rw---R--,values=4,min=0,max=254,step=0
> > >    : values=182,182,0,0
> > 
> > Thanks, that narrows it down.
> > 
> > Every failure is SET_CUR of the Volume control on feature unit 10, channel 3
> > (wValue 0x0203, wIndex 0x0a00). That unit is 'EVO4  Playback Volume' and
> > advertises read/write volume on all four channels. mixer_ctl_feature_put()
> > writes channels 1 and 2, then returns the channel 3 error, so the hardware
> > volume changes while userspace is told the write failed and adds software
> > attenuation on top. Faaris sees the same on 7.3-rc5, so this is a mainline
> > regression from 87a6f2fa6e6c ("ALSA: usb-audio: Propagate write errors in
> > generic mixer put callbacks").
> 
> Right.  So a simple fix would be to just to set the IGNORE_CTL_ERROR
> quirk flag like below.  One of iD14 models has already this flag, so
> it might be safer to set to all Audient devices.

... and below is such a version to cover all Audient devices:

Faaris, please let us know if this (or previous) one actually works
for you.  Once after confirmation, I'll submit the proper patch for
upstream.


thanks,

Takashi

-- 8< --
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2688,8 +2688,6 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_FORCE_IFACE_RESET | QUIRK_FLAG_IFACE_DELAY),
 	DEVICE_FLG(0x262a, 0x9302, /* ddHiFi TC44C */
 		   QUIRK_FLAG_DSD_RAW),
-	DEVICE_FLG(0x2708, 0x0002, /* Audient iD14 */
-		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x2772, 0x0502, /* Musical Fidelity M6s DAC */
 		   0), /* for avoiding QUIRK_FLAG_DSD_RAW with vendor match */
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
@@ -2788,6 +2786,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x2622, /* IAG Limited devices */
 		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x2708, /* Audient devices */
+		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	VENDOR_FLG(0x2772, /* Musical Fidelity devices */
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x278b, /* Rotel? */
