Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33DA4A7C8A;
	Mon, 19 Oct 2026 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405390; cv=none; b=Ol2yvTKvtrjhI91Wiz0F3TB6AtR7LJcTf5TmiTo4EWWj0t5VA/nnGiYljxkAwikr9hgStrXzhpOOEqk3ia8FuEnWy40aKGo6hkV/aeUm+4/abBrdBLwrruksRgh20hr2tnKHYsIVQLSfJ3T99SpWtdJZqvVUF69FemIndU4HY8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405390; c=relaxed/simple;
	bh=OdiH2xEEPBPv8eRNB0AVuyOVKMlpyVgFr6l47XD/diw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JoZ0LuQgY0BTf4t/K6LzjMYXDQj4vzi901ntHTwM55zIc74sBSrDaGfoqclPtKOeVCnu7smicicZz2RDIHm8QdNprRxqsOztogZ3LKEY+oTWDiuoafillXSkbmlwM2iXdgNfH5Ov1DQDBDZgy6mYbYLi136jCpYbnUtZHdXCdyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=juXQXzc4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EvM77jX2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=juXQXzc4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EvM77jX2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="juXQXzc4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EvM77jX2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="juXQXzc4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EvM77jX2"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D24C91F444;
	Mon, 19 Oct 2026 10:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792405385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXCUC77DUqL6MhRZrFelUG52qJt6rCs3f4AN3ZZrk5w=;
	b=juXQXzc4MBFPuoiognX1hfDQz+ZaQ2XSewXk/5znHeK74yboyiBth1H23SLA9ZU6ng+0JD
	qOpEreXRWYewYKwCU0wZxUzjLDaiTyT8XmqOYweSFZVr4/hVvi+lXBi+jKp1Oy8kRcKY3M
	jPFB7JH3f7UHl+lPg8wBqknNFkyCn98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792405385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXCUC77DUqL6MhRZrFelUG52qJt6rCs3f4AN3ZZrk5w=;
	b=EvM77jX2NCG2CHbQ40T+BBCA2kc0ltk7vljEapQIeK63OITnH39orinnROfcz/Gaob3S/p
	JlWodqQk3x2mjkAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792405385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXCUC77DUqL6MhRZrFelUG52qJt6rCs3f4AN3ZZrk5w=;
	b=juXQXzc4MBFPuoiognX1hfDQz+ZaQ2XSewXk/5znHeK74yboyiBth1H23SLA9ZU6ng+0JD
	qOpEreXRWYewYKwCU0wZxUzjLDaiTyT8XmqOYweSFZVr4/hVvi+lXBi+jKp1Oy8kRcKY3M
	jPFB7JH3f7UHl+lPg8wBqknNFkyCn98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792405385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXCUC77DUqL6MhRZrFelUG52qJt6rCs3f4AN3ZZrk5w=;
	b=EvM77jX2NCG2CHbQ40T+BBCA2kc0ltk7vljEapQIeK63OITnH39orinnROfcz/Gaob3S/p
	JlWodqQk3x2mjkAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6160F136CC;
	Mon, 19 Oct 2026 10:23:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8TkfAYnv1WpHWgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 19 Oct 2026 10:23:05 +0000
Date: Mon, 19 Oct 2026 12:23:04 +0200
Message-ID: <871p9mat13.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Will Bush" <will@willbush.dev>,	"Takashi Iwai" <tiwai@suse.com>,
	"Jaroslav Kysela" <perex@perex.cz>,	linux-sound@vger.kernel.org,
	regressions@lists.linux.dev,	stable@vger.kernel.org,	"Jan Lentfer"
 <jan.lentfer@web.de>,	Sebastian =?ISO-8859-1?Q?Dalfu=DF?= <sd@sedf.de>
Subject: Re: [REGRESSION] usb-audio: Behringer UMC204HD broken in 7.2.10
In-Reply-To: <87a4oaavrv.wl-tiwai@suse.de>
References: <45162613-2802-401c-84c9-742f9c8c68e6@app.fastmail.com>
	<87tsmjarjs.wl-tiwai@suse.de>
	<bb9cad8e-48fc-4cc7-a893-1542270f2018@app.fastmail.com>
	<87a4oaavrv.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -7.30
X-Spam-Level: 
X-Spamd-Result: default: False [-7.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[web.de];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_CC(0.00)[willbush.dev,suse.com,perex.cz,vger.kernel.org,lists.linux.dev,web.de,sedf.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url]

On Mon, 19 Oct 2026 11:23:48 +0200,
Takashi Iwai wrote:
> 
> On Mon, 19 Oct 2026 10:39:46 +0200,
> Will Bush wrote:
> > 
> > On Sun, Oct 18, 2026, at 11:42 AM, Takashi Iwai wrote:
> > > Interesting, it's just a descriptor read and this fails on your device
> > > by some reason.  Could you try to ignore the error like below, and
> > > verify whether it continues to work?
> > 
> > Thanks for the quick reply. I reverted my patch and applied yours. Device keeps
> > disconnecting and reconnecting (just more slowly). It never ends up working.
> > 
> >   ❯ journalctl -k -b -0 -o short-monotonic | grep -E 'usb 3-4|snd-usb-audio 3-4'
> >   [    2.264012] blazar kernel: usb 3-4: new high-speed USB device number 3 using xhci_hcd
> >   [    2.458009] blazar kernel: usb 3-4: New USB device found, idVendor=1397, idProduct=0508, bcdDevice= 1.35
> >   [    2.484013] blazar kernel: usb 3-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> >   [    2.484035] blazar kernel: usb 3-4: Product: UMC204HD 192k
> >   [    2.484050] blazar kernel: usb 3-4: Manufacturer: BEHRINGER
> >   [   12.976010] blazar kernel: usb 3-4: USB disconnect, device number 3
> >   [   18.012013] blazar kernel: usb 3-4: failed to read device descriptor: -110
> >   [   18.012623] blazar kernel: usb 3-4: parse_audio_format_rates_v2v3(): unable to retrieve number of sample rates (clock 41)
> >   [   18.012768] blazar kernel: usb 3-4: parse_audio_format_rates_v2v3(): unable to retrieve number of sample rates (clock 41)
> >   [   18.012903] blazar kernel: usb 3-4: 10:0: failed to get current value for ch 1 (-19)
> >   [   18.013047] blazar kernel: usb 3-4: 10:0: failed to get current value for ch 2 (-19)
> >   [   18.013181] blazar kernel: usb 3-4: 10:0: failed to get current value for ch 3 (-19)
> >   [   18.013309] blazar kernel: usb 3-4: 10:0: failed to get current value for ch 4 (-19)
> >   [   18.013434] blazar kernel: usb 3-4: 10:0: failed to get current value for ch 0 (-19)
> >   [   18.013565] blazar kernel: usb 3-4: 10:0: cannot get min/max values for control 2 (id 10)
> >   [   18.013690] blazar kernel: usb 3-4: Warning! Unlikely small volume range (=1), linear volume or custom curve?
> >   [   18.013822] blazar kernel: usb 3-4: [10] FU [PCM Playback Volume] ch = 4, val = 0/1/1
> >   [   18.013959] blazar kernel: usb 3-4: 10:0: cannot get min/max values for control 2 (id 10)
> >   [   18.014102] blazar kernel: usb 3-4: Warning! Unlikely small volume range (=1), linear volume or custom curve?
> >   [   18.014239] blazar kernel: usb 3-4: [10] FU [PCM Playback Volume] ch = 1, val = 0/1/1
> >   [   18.014374] blazar kernel: usb 3-4: 11:0: failed to get current value for ch 1 (-19)
> >   [   18.014508] blazar kernel: usb 3-4: 11:0: failed to get current value for ch 2 (-19)
> >   [   18.014635] blazar kernel: usb 3-4: 11:0: failed to get current value for ch 0 (-19)
> >   [   18.014763] blazar kernel: usb 3-4: 11:0: cannot get min/max values for control 2 (id 11)
> >   [   18.014890] blazar kernel: usb 3-4: Warning! Unlikely small volume range (=1), linear volume or custom curve?
> >   [   18.015021] blazar kernel: usb 3-4: [11] FU [Mic Capture Volume] ch = 2, val = 0/1/1
> >   [   18.015151] blazar kernel: usb 3-4: 11:0: cannot get min/max values for control 2 (id 11)
> >   [   18.015278] blazar kernel: usb 3-4: Warning! Unlikely small volume range (=1), linear volume or custom curve?
> >   [   18.015408] blazar kernel: usb 3-4: [11] FU [Mic Capture Volume] ch = 1, val = 0/1/1
> >   [   18.300040] blazar kernel: usb 3-4: new high-speed USB device number 6 using xhci_hcd
> >   [   18.491087] blazar kernel: usb 3-4: New USB device found, idVendor=1397, idProduct=0508, bcdDevice= 1.35
> >   [   18.517036] blazar kernel: usb 3-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> >   [   18.517242] blazar kernel: usb 3-4: Product: UMC204HD 192k
> >   [   18.517398] blazar kernel: usb 3-4: Manufacturer: BEHRINGER
> >   [   23.644013] blazar kernel: usb 3-4: failed to read device descriptor: -110
> >   [   33.884021] blazar kernel: usb 3-4: parse_audio_format_rates_v2v3(): unable to retrieve number of sample rates (clock 41)
> >   [   49.244015] blazar kernel: usb 3-4: parse_audio_format_rates_v2v3(): unable to retrieve number of sample rates (clock 41)
> >   [   59.484034] blazar kernel: usb 3-4: 10:0: failed to get current value for ch 1 (-110)
> >   [   69.725032] blazar kernel: usb 3-4: 10:0: failed to get current value for ch 2 (-110)
> >   [   79.965020] blazar kernel: usb 3-4: 10:0: failed to get current value for ch 3 (-110)
> >   [   90.204027] blazar kernel: usb 3-4: 10:0: failed to get current value for ch 4 (-110)
> >   [  100.444027] blazar kernel: usb 3-4: 10:0: failed to get current value for ch 0 (-110)
> >   [  110.684056] blazar kernel: usb 3-4: 10:0: cannot get min/max values for control 2 (id 10)
> >   [  110.684281] blazar kernel: usb 3-4: Warning! Unlikely small volume range (=1), linear volume or custom curve?
> >   [  110.684397] blazar kernel: usb 3-4: [10] FU [PCM Playback Volume] ch = 4, val = 0/1/1
> >   [  115.804025] blazar kernel: usb 3-4: 10:0: cannot get min/max values for control 2 (id 10)
> >   [  115.812386] blazar kernel: usb 3-4: Warning! Unlikely small volume range (=1), linear volume or custom curve?
> >   [  115.812521] blazar kernel: usb 3-4: [10] FU [PCM Playback Volume] ch = 1, val = 0/1/1
> >   [  131.164026] blazar kernel: usb 3-4: 11:0: failed to get current value for ch 1 (-110)
> >   [  141.404011] blazar kernel: usb 3-4: 11:0: failed to get current value for ch 2 (-110)
> >   [  151.644020] blazar kernel: usb 3-4: 11:0: failed to get current value for ch 0 (-110)
> >   [  161.885033] blazar kernel: usb 3-4: 11:0: cannot get min/max values for control 2 (id 11)
> >   [  161.885326] blazar kernel: usb 3-4: Warning! Unlikely small volume range (=1), linear volume or custom curve?
> >   [  161.885446] blazar kernel: usb 3-4: [11] FU [Mic Capture Volume] ch = 2, val = 0/1/1
> >   [  167.004009] blazar kernel: usb 3-4: 11:0: cannot get min/max values for control 2 (id 11)
> >   [  167.004224] blazar kernel: usb 3-4: Warning! Unlikely small volume range (=1), linear volume or custom curve?
> >   [  167.004341] blazar kernel: usb 3-4: [11] FU [Mic Capture Volume] ch = 1, val = 0/1/1
> >   [  167.005012] blazar kernel: usb 3-4: Quirk or no altset; falling back to MIDI 1.0
> >   [  187.486013] blazar kernel: usb 3-4: USB disconnect, device number 6
> >   [  187.785034] blazar kernel: usb 3-4: new high-speed USB device number 7 using xhci_hcd
> >   ...
> >   [ 1035.327013] blazar kernel: usb 3-4: New USB device found, idVendor=1397, idProduct=0508, bcdDevice= 1.35
> >   [ 1035.353013] blazar kernel: usb 3-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> >   [ 1035.353185] blazar kernel: usb 3-4: Product: UMC204HD 192k
> >   [ 1035.353301] blazar kernel: usb 3-4: Manufacturer: BEHRINGER
> >   [ 1040.476017] blazar kernel: usb 3-4: failed to read device descriptor: -110
> >   [ 1050.717019] blazar kernel: usb 3-4: parse_audio_format_rates_v2v3(): unable to retrieve number of sample rates (clock 41)
> >   ...
> 
> OK, thanks.  Then the only way to introduce some deny list.
> Below is a quick fix.  I'm going to submit & merge this later.

... and now we received another report for the similar Behringer
model, so both should be listed.  I'm going to update the patch and
submit.
  https://bugzilla.suse.com/show_bug.cgi?id=1285896


Takashi
