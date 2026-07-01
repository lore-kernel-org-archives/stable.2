Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A1E436367
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906976; cv=none; b=e0Ch0k6fnehoI9ns0Ij6e28oqTjnmcW8bx3EcGQVhCK7cIOs5MakuYr58FvW7ZqMXGw+jf/Kj4ABmqMS5hPr4iiLh/yrDNZ/UqcR4Pzc8V/XfHtfzTpgPPnOYiSkRfQ4y/IAdH3LyYZ4Fy6Fc5NwSjpCDAe/BNiqyOEFrht78ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906976; c=relaxed/simple;
	bh=xdWuBup5ubjAz5buhIS9hoT7rNPTlXU2jJVUJvO5hRk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqOcZItz7X7QGMZ8+CgI2Cv900vjQRzobokpm1Sq3wI7v8YoFrX888S8W/lGBPuxdyKBTt+tsjxhZ2ybLmJJinacwEOzARriZLzIX6U+Rxhlv4ZS30eRii6MxXIG8u13OyzU1oA7F7TzhFl0OUcWPCYU6dVEPpsjN3BIybRl9QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=otTxxeV7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vpGqYG+n; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EhTOw44i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v7YhbTbB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="otTxxeV7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vpGqYG+n";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EhTOw44i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v7YhbTbB"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20E7A71A6C;
	Wed,  1 Jul 2026 11:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782906973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0oBuriCx++643jX+EuMc7fV9KpRmTnufU63j8vvKNSM=;
	b=otTxxeV7JzNN7452Lmbpom542iesBd/JzhUbGaszscgc6HLiPT3V6Qm+vfqjRBm7ebUYsq
	yiL2M5bI6aToSjtsQihXLmUevtB17g0gjhXq0NXK0x1ed/9OzOnOIyByqAte1ckZfzgTVr
	HGyRUKdTSMO/nUOuENMiuQMUhykOjQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782906973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0oBuriCx++643jX+EuMc7fV9KpRmTnufU63j8vvKNSM=;
	b=vpGqYG+njd5BaCoCHSG5jt7yutxiNQT373bfP/w4S+ZpGdFLH/XshFR4S52aVLUP3AuRVo
	N11rKUBwMX1eRJBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782906972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0oBuriCx++643jX+EuMc7fV9KpRmTnufU63j8vvKNSM=;
	b=EhTOw44iy8T/1/otd8pQFZcc3RvAFRpy8rIa2QuIUpKR81rQn0x6DaNi4iIKMOvOBsZMpM
	agtG2ClqzpjQNXqwW36XfOWV77XlZVhxTPdBQvw/4Qd3F6J+6l+jwyxCcnbjAhH1lI9dY5
	GwK0FwTgKoRHJkPeA5eyI9eG076/g9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782906972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0oBuriCx++643jX+EuMc7fV9KpRmTnufU63j8vvKNSM=;
	b=v7YhbTbBRoAJwjBqXk2FZ+oAw/uKJo7boI0FD/O9pCpzbk7yma/J+lqn8P1e9c9gBhLnT0
	yHy4TPK8uRuwmZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF0C3779AA;
	Wed,  1 Jul 2026 11:56:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XWLqNFsARWrDKQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 01 Jul 2026 11:56:11 +0000
Date: Wed, 01 Jul 2026 13:56:11 +0200
Message-ID: <8733y2vs84.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: HyeongJun An <sammiee5311@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,	Jaroslav Kysela <perex@perex.cz>,
	=?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>,
	linux-sound@vger.kernel.org,	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usx2y: us144mkii: fix work UAF on disconnect
In-Reply-To: <20260701095231.1020811-1-sammiee5311@gmail.com>
References: <20260701095231.1020811-1-sammiee5311@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,gmail.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Level: 

On Wed, 01 Jul 2026 11:52:31 +0200,
HyeongJun An wrote:
> 
> tascam_disconnect() cancels capture_work and midi_in_work before
> usb_kill_anchored_urbs() kills the capture/MIDI-in URBs.  Those URBs
> self-resubmit, and their completion handlers reschedule the work.
> 
> A URB that completes in the small window between cancel_work_sync() and
> usb_kill_anchored_urbs() therefore re-arms the work after its only
> cancel.  Nothing cancels it again before snd_card_free() frees the
> card-private tascam structure, so the work handler then runs on freed
> memory.
> 
> Kill the anchored URBs before cancelling the work; once the work is
> cancelled no remaining URB can complete to re-arm it.
> 
> Fixes: c1bb0c13e430 ("ALSA: usb-audio: us144mkii: Implement audio capture and decoding")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>

Applied now.  Thanks.


Takashi
