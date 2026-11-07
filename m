Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794043424;
	b=k1ltMoZexUhKdOZJZzof0gcpj0D4iGbFwJzudaN/ds2xfgcVOf7wTgELv89VKXdmr86p
	 t89vuX7+za4T9j1NyDsTVxf4F17zRYc6+Hz8+8O9fbGDJ41+FlfFKtudeApyBZars0x43
	 HF0I1EeNIMIRgPQ2t203eHQy8n5whK2esfV+SHVGaCu4yO+UWPzJX9quQfXzIU6RVrjmM
	 AmMpqU7gx5EejpyBnIblxoPekYBWo65WiPKeNS0NGeeemGqpvT0jf0I5EKRaZFN96FdGy
	 J25/GvrGZLJFoMG7iT5phuuqj4fhIwTN2pXF+sqfIjP5vNz3ONpyGUcHI7FPP9DQRIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794043424;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=Ht1I7RV4Sehfh9ggKapwU4UF2tcxF6K737njmO0bQyc=;
	b=tPMKDaipWtPN0e7H8SzqtbAN6JmbWLviMGDImmWH1BfXLHvjkQH6HnHIogxaEIJV+RxM
	 RluiKMB4edoswlJFYPG7ODaXXWhr4FBd7VyxK2HGDExhy/e8hyGJtvLLlah3dGtiRm1tE
	 /Y+7mwU1Ika8PKayHXRQ2gMkfLe2pByL4/A+z8kE6d9gL9dRI2FhJF6NVFTb4xzdpRaM4
	 +Jun9TNXlFvilaLA8oo7Sv2Xh936Grhw58j2KJG5DoV+i+qKU0hdFKusgF9Ed2FkygdJo
	 DrKx9myrg4QEkiwc7OWM/xn3ZeK5gll3ZQ/EzUQ7pQeGAbfpqg8+7O02MS/PbT2ZBxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2B0ffEDs;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pWwI7GaB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2B0ffEDs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pWwI7GaB;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C87606A326;
	Sat,  7 Nov 2026 09:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87C87606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2B0ffEDs;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pWwI7GaB;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2B0ffEDs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pWwI7GaB
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BCDC1F74D;
	Sat,  7 Nov 2026 09:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794043421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ht1I7RV4Sehfh9ggKapwU4UF2tcxF6K737njmO0bQyc=;
	b=2B0ffEDsuh7PD9BFC2cmHOk8+JP+/D+RZSi9tXZOsD08QGxFfaWGkiXuaO8hzHgue32AJ8
	PPU3OntWX3Ad258cOX+LEiB/QTBPl00p//tcAsvD6FnU7CoHLMUDgPw3folDYDnnyvbej+
	KrZq0OmXzb7xnH/AuUsH1ja0nDzbSkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794043421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ht1I7RV4Sehfh9ggKapwU4UF2tcxF6K737njmO0bQyc=;
	b=pWwI7GaBumYIYdzkT1Sn8n7kQiwc/3YR0SlMVphRtPL3k8R4wVKwqvxLi5JHQ9r68Enp7e
	pBbFvWdHTmuFyKBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794043421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ht1I7RV4Sehfh9ggKapwU4UF2tcxF6K737njmO0bQyc=;
	b=2B0ffEDsuh7PD9BFC2cmHOk8+JP+/D+RZSi9tXZOsD08QGxFfaWGkiXuaO8hzHgue32AJ8
	PPU3OntWX3Ad258cOX+LEiB/QTBPl00p//tcAsvD6FnU7CoHLMUDgPw3folDYDnnyvbej+
	KrZq0OmXzb7xnH/AuUsH1ja0nDzbSkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794043421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ht1I7RV4Sehfh9ggKapwU4UF2tcxF6K737njmO0bQyc=;
	b=pWwI7GaBumYIYdzkT1Sn8n7kQiwc/3YR0SlMVphRtPL3k8R4wVKwqvxLi5JHQ9r68Enp7e
	pBbFvWdHTmuFyKBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25747132C9;
	Sat,  7 Nov 2026 09:23:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id guNTOhzu7mqhbgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 07 Nov 2026 09:23:41 +0000
Date: Sat, 07 Nov 2026 10:23:40 +0100
Message-ID: <877bipyoyr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Cristiano Souza <cristianocps@gmail.com>
Cc: linux-sound@vger.kernel.org,
	tiwai@suse.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] ALSA: usb-audio: Skip broken playback feature unit on XiiSound chips
In-Reply-To: <20261107022643.135168-1-cristianocps@gmail.com>
References: <20261107022643.135168-1-cristianocps@gmail.com>
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
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Score: -12.30
X-Spam-Level: 
X-Spam-Flag: NO

On Sat, 07 Nov 2026 03:26:43 +0100,
Cristiano Souza wrote:
> 
> Weltrend XiiSound-based devices (040b:0897, e.g. Redragon H878
> wireless headset) expose a UAC1 playback feature unit whose volume
> and mute controls are unusable in practice: the reported per-channel
> dB range is only 0..+0.39dB, yet setting any volume below the
> maximum mutes one or even both channels, and the mapping between
> logical and physical channels is unreliable.  Any attempt by
> userspace to drive the hardware volume therefore results in muted
> or one-sided audio.
> 
> Ignore the playback feature unit via a usbmix_name_map so that
> userspace falls back to software volume, and pin the unit's master
> and per-channel volumes to the reported maximum with mutes cleared
> when the mixer is created, so the signal path always stays fully
> open.  The capture path (microphone feature unit) is not affected
> and keeps working.
> 
> Tested with a Redragon H878 wireless headset on PipeWire/PulseAudio:
> stereo output works on both channels at any volume, software volume
> applies smoothly, and mute/unmute works.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Cristiano Souza <cristianocps@gmail.com>

Applied to for-next branch.  Thanks.


Takashi
