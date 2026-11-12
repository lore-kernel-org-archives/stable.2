Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487074;
	b=JmI5/dfoAde5rzsNNuZ1MqOABQThAh+PzylJjCFK/MCQS4EHxmXQI4l7RdJ7/8IwCvQA
	 D9qeQBR9ydgcHr7Pfplore6IKS9cJvjoKotpUVi9sTKWBrH7Ndi9RcDaYuaouLx7dazom
	 sFLiJntn47Szlzmk5JFstwAajOXYI/mbKEseuxgEaO/pHlDgnsgU6TN8GoA3n2qOzxVs1
	 b8CMbDInzXNJ8RZALVCQxMVnF/pK6RdVO2r6chRewjfXyYxcYOXkCD1qqJwU/qj2omsKx
	 vhRsixaXHVYTifi66ZWoT82K57d9i9O/OVDNwthnrU4XfYiDt9tMG1yQXwvAHrrwkXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487074;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=TqA1A0Utd/xXDxOpPCOZpyywoG2iCNWwVzQmdLil5HQ=;
	b=ILreGFL4ZOeG7Tx5Skt9bX7swnKytQXgdIjHzzvKo7ISd4kyRjUawnA1NqhO5t4JmQK9
	 IzdyNZgVbjp4mPqwgaTzxthkuskTYhLta+zb13XlS/3N5vpQOd1XFZAgluASfCP5vlCw3
	 aO24fMQmnwqkRg3vzPjla85uHlIf6KdAnmUCEG+FZKPOYoiP8bgRkHyYTH3RVbpd6/I9w
	 3STTmO0ZT7NB/rXqZCyodUGyuxH4Yhw56IVtTCJqBohl57WkX3OoHUhwsdx9xS6OLY8RA
	 XoaZYO5TDwI5yRxMe3vjUFl/9HyhqBpI+rJhRSz0SIDgB/Meyyih+WaK2graJafVdxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fNCVTHZJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nGee8469;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fNCVTHZJ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nGee8469;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23468606A32A;
	Thu, 12 Nov 2026 12:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23468606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fNCVTHZJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nGee8469;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fNCVTHZJ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nGee8469
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 52E9E1F788;
	Thu, 12 Nov 2026 12:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794487072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TqA1A0Utd/xXDxOpPCOZpyywoG2iCNWwVzQmdLil5HQ=;
	b=fNCVTHZJDPn4YtBmLxhVT7APNoX1fO+OMGCH0s2NKLLuTs8gWtAhFGPyEOfdZmlbGejSXB
	VKw68ym1o9/bKxBT2QCp1if8WWyF58Ob8uLOCQ2C2Kd3pe7wmTExd6zqpWjo60jJaO3maY
	3ztXV4Y29P9jiC2BA4DtpkbIuXA6cfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794487072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TqA1A0Utd/xXDxOpPCOZpyywoG2iCNWwVzQmdLil5HQ=;
	b=nGee8469OY3py4LXkaBEqBWcix+JFku2Ix5kU/B4706g/vdm/a7XHUsTjlxVpo4DSOijB1
	/hlqt683XhHQbECg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794487072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TqA1A0Utd/xXDxOpPCOZpyywoG2iCNWwVzQmdLil5HQ=;
	b=fNCVTHZJDPn4YtBmLxhVT7APNoX1fO+OMGCH0s2NKLLuTs8gWtAhFGPyEOfdZmlbGejSXB
	VKw68ym1o9/bKxBT2QCp1if8WWyF58Ob8uLOCQ2C2Kd3pe7wmTExd6zqpWjo60jJaO3maY
	3ztXV4Y29P9jiC2BA4DtpkbIuXA6cfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794487072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TqA1A0Utd/xXDxOpPCOZpyywoG2iCNWwVzQmdLil5HQ=;
	b=nGee8469OY3py4LXkaBEqBWcix+JFku2Ix5kU/B4706g/vdm/a7XHUsTjlxVpo4DSOijB1
	/hlqt683XhHQbECg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB2BD13432;
	Thu, 12 Nov 2026 12:37:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vIbYLx+z9WqDTQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 12 Nov 2026 12:37:51 +0000
Date: Thu, 12 Nov 2026 13:37:51 +0100
Message-ID: <87ld6yrzs0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: London grad <londongrad@gmail.com>
Cc: clemens@ladisch.de,
	linux-sound@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz,
	Xiang Mei <xmei5@asu.edu>,
	co+24304d323d28f156@bugs.sh,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: ua101: reject mismatched capture/playback packet sizes
In-Reply-To: <CANd6Td+b6ituLFzkhvX09vricCY541fQapNOk3rTa=74zWA5LA@mail.gmail.com>
References: <CANd6Td+b6ituLFzkhvX09vricCY541fQapNOk3rTa=74zWA5LA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-10.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[24304d323d28f156];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -10.80
X-Spam-Level: 
X-Spam-Flag: NO

On Thu, 12 Nov 2026 10:25:39 +0100,
London grad wrote:
> Hello all
> 
> This patch may have broken ua-101?
> 
> Kernel 6.8.0-146 still works for me
> 
> In kernel 6.8.0-149 my UA-1000 fails with
> 
> `snd-ua101` rejects the device during probe at every physical sample rate
> setting (44.1, 48, 88.2, and 96 kHz), leaving the interface unregistered in
> ALSA.
> 
> ### Relevant `dmesg` Output
> [ 2622.796887] usb 3-3: new high-speed USB device number 5 using xhci_hcd
> [ 2622.928793] usb 3-3: New USB device found, idVendor=0582, idProduct=0044,
> bcdDevice= 1.07
> [ 2622.928798] usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber
> =3
> [ 2622.928800] usb 3-3: Product: UA-1000
> [ 2622.928801] usb 3-3: Manufacturer: EDIROL
> [ 2622.928802] usb 3-3: SerialNumber: ZT02743
> [ 2622.934792] usb 3-3: playback packet size 560 too small for 15 capture
> frames
> 
> Submitted bug report here
> https://bugzilla.kernel.org/show_bug.cgi?id=222261

Could you verify that just reverting the commit fixes your problem?
It's quite possible that this patch is the cause, but just to be sure.


thanks,

Takashi
