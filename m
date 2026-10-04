Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1C247F78E;
	Sun,  4 Oct 2026 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791139095; cv=none; b=JW4t6B+f+ZkkmtvK4SPSbPXJVrDU2saLr3bVg8r+WXsB1+XpSSRKuMgQ1AhGU+JmAYrbLGv5fedQvmXvPKgGtPfWvMpx6Xq6fxFQKcMUjb0kikqTZqNouH48zO9jX+JTsZIC6QoRN98pyBbJhvfVvD3CEi/23HkifnT0ItaZI2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791139095; c=relaxed/simple;
	bh=5OIeb0KQYJAZBbByRplOstp/j05el8GbcAhhBlJrMW0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYoFLJd8fQCUZ8LbrQHQOHKJpocW1XWbaL3niv4B4k7BjEzRD+8W4F/mGeb4OEuNq6v4QDNhK8nW8mB7hoDMnlER2cTOhx0uxlXf4tzZnDBIyaV1mqKAXM8VFYnC1gHpmphbbvcy3qsWeXUd9uyV6WcKah0u1+0kKesFmKGI0/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1MTppv3z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/+MGWodF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qyd0DvFE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5EcoDPj/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1MTppv3z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/+MGWodF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qyd0DvFE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5EcoDPj/"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B03F221D45;
	Sun,  4 Oct 2026 18:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791139078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GqMoXyq5mQHGq/QPLbs3A/r06cDlnqm6ZY93gy7/96Y=;
	b=1MTppv3zeq0crJHluy1zJX1qaQqlEbRL+WG+jew4e4MhmNu27UlSqaZ210nO31Xw1PBFyc
	tyVeA1NeSdtFfoiC5ECKhVYVYqhmDgT5nhO3GstRMrjOey+6FEjk2bITb/ulpEXorCtjBS
	gZZK4iWzn6DMOjswosSVZVGjywdTDa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791139078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GqMoXyq5mQHGq/QPLbs3A/r06cDlnqm6ZY93gy7/96Y=;
	b=/+MGWodFWjLcz3o/r/xJCN1eG6P6uCzZZUS/hMOBEA7XHT43pfwDyCIX4NPHVMuGGvCexn
	0hvvis+U0quV/MCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qyd0DvFE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="5EcoDPj/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791139074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GqMoXyq5mQHGq/QPLbs3A/r06cDlnqm6ZY93gy7/96Y=;
	b=qyd0DvFE60qzwNHV5Gb46/Fln7MtbjujdMhoBCPhwFbz6ATqqKnJsQAeQqlTHiH74c/jj/
	YBV1Mr3mqAuDduzjR3Y2PD/pugSKXzNt1Kehqokbj8fZw5hVrHHEnmNIYwIETloUxzabSJ
	8zrAX6U+yncbqsBgis4CRWLCX0Vzxuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791139074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GqMoXyq5mQHGq/QPLbs3A/r06cDlnqm6ZY93gy7/96Y=;
	b=5EcoDPj//Sb8VtjL6E0udAJWNsYBsyUVWj2rSlPEEQVGBtYf8M6FS7Q/lkVxd/ywUVoVcF
	dtyUUVX0QGFOD0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA823133CF;
	Sun,  4 Oct 2026 18:37:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TF7YJwGdwmpCXgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 04 Oct 2026 18:37:53 +0000
Date: Sun, 04 Oct 2026 20:37:53 +0200
Message-ID: <874if1ia66.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: henrik.enquist@gmail.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Pavel Hofman <pavel.hofman@ivitera.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] ALSA: aloop: Fix notify mode, add a selftest
In-Reply-To: <20261003-aloop-notify-fix-v1-0-ba5dfb831bf5@gmail.com>
References: <20261003-aloop-notify-fix-v1-0-ba5dfb831bf5@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B03F221D45
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Spam-Level: 

On Sat, 03 Oct 2026 15:26:10 +0200,
Henrik Enquist via B4 Relay wrote:
> 
> Hi,
> 
> snd-aloop has a notify mode (the pcm_notify module parameter, or the
> "PCM Notify" control per cable) where the playback side may switch
> format, rate and channels while a capture is running. The driver then
> stops the capture and updates the "PCM Slave" controls, so the capture
> application can reopen with the new parameters. alsaloop enables it in
> its slave mode, and I'd like to use it in CamillaDSP, which captures
> from a loopback and needs to follow whatever the player outputs.
> 
> This hasn't worked since 2018. Commit 898dfe4687f4 ("ALSA: aloop: Fix
> racy hw constraints adjustment") moved the hw rules over to the shared
> cable->hw. That fixed a real race, but it also pins the playback side
> to the capture's parameters in notify mode. Pavel reported it on
> alsa-devel in 2020 [1], and Jaroslav reproduced it and pointed at the
> same commit:
> 
>   It seems that 898dfe4687f4 from Takashi broke this functionality
>   (tied the cable parameters more strictly, so the playback cannot set
>   freely own parameters for the pcm_notify=1 case). We need to find
>   another way to detach capture stream in this case.
> 
> The thread ended there, without a patch.
> 
> The breakage is quiet, which probably explains why it lasted. A player
> that probes the playback device sees only the capture's rate and
> format, and resamples to them. aplay prints a warning, most players
> don't. There's no rate change, no stopped capture and no event.
> 
> Patch 1 skips the hw rules for the playback side when notify is on,
> which gives it back the freedom loopback_open() still intends it to
> have. That makes the capture stop in loopback_check_format() reachable
> again. That path was hardened this year by 826af7fa62e3 ("ALSA: aloop:
> Fix racy access at PCM trigger") and e5c33cdc6f40 ("ALSA: aloop: Fix
> peer runtime UAF during format-change stop"), and with those in place
> I'm comfortable turning it back on. They need to go first in any
> stable backport.
> 
> The period bytes rule is skipped as well. It came later, for the sound
> timer source, but without skipping it a playback that switches rate
> keeps the old capture's period size. The stream then runs with a period
> that doesn't match the timer, and every switch fills dmesg with "Period
> size ... not corresponding to timer resolution".
> 
> Patch 2 adds a selftest, so this doesn't break silently again. It
> doesn't need to go to stable, so it can go via for-next if that's
> easier.
> 
> Testing: for-linus at b4e7fc36e31f, arm64 VM, kernel with KASAN,
> lockdep, DEBUG_ATOMIC_SLEEP and DEBUG_LIST, comparing the patched
> driver with the unpatched one built from the same tree. With the
> jiffies, hrtimer and sound timer (via snd-dummy) sources:
> - With notify on, rate, format and channel changes on the playback
>   side now go through, stop the capture and update the controls. With
>   notify off they're refused as before.
> - A capture that reopens at "PCM Slave Rate" after each stop follows a
>   player alternating between 44.1k and 96k files, 20 of 20 switches,
>   with both RW and mmap access. Unpatched: 10 of 20, the playback stays
>   pinned to the capture's rate.
> - A capture opened second is still pinned to the playback.
> - 2 minutes of random open/start/close on both ends per source gave no
>   KASAN or lockdep reports. The sound timer source logs an occasional
>   "snd_timer_stop ... failed with -16", at the same rate unpatched.
> - The new selftest fails 2 of 4 tests unpatched, and passes 4 of 4
>   patched, 50 runs in a row.
> Not tested: real hardware, other architectures, pause/resume, more
> than two substreams.
> 
> One question, following up on Takashi's point in that thread about
> telling user space that a stream got invalidated. After the stop, the
> capture drains and then reads return -EBADFD. alsa-lib now documents
> -ENODATA as meaning the PCM must be completely restarted, which looks
> like the right signal here. Would you want aloop to report that
> instead? I left it out since it changes what user space sees, but I'm
> happy to do it as a follow-up.
> 
> AI disclosure: I used Claude Code (Claude Opus 5.5) for this. Starting
> from my description of the problem and the 2020 thread, it did the
> root cause analysis from the driver source and git history, set up the
> test kernels and VM, wrote the test scripts, ran the measurements, and
> wrote both patches and their changelogs. I reviewed all of it, and both
> patches carry an Assisted-by tag.
> 
> [1] https://lore.kernel.org/all/b4af9071-f8d7-5b47-4d7a-c5743bd67394@ivitera.com/
> 
> Henrik
> 
> ---
> Henrik Enquist (2):
>       ALSA: aloop: Don't constrain playback params in notify mode
>       selftests/alsa: Add a test for snd-aloop notify mode

Applied both patches to for-next branch now.  Thanks.


Takashi
