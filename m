Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF4D2D12ED
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087053; cv=none; b=fsNIWHW2LDspotNeELHCxZrjpEoQUpzvHRjk8AU5V7VVSUpLeeV1tywlgy0fwV4vbg07VF1T/Px3I0Q4yZgR3tsSlCbVVtvWuQOHBWltq5z9J+mboO/YiH6/UBiXV+IT52pA0ToqjDSndfoQ13+DSwLXdcaIvgl6yBGdztlNb8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087053; c=relaxed/simple;
	bh=ZAf4VTxvHfZ0wE+nCmc1yJ7jlFQXJdtrMpQf7ScWn3Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2k6BkkgIAHIemKDMjjGEP/4wAsXKj8qZzFt/MzZfGDoRQJ69adfT5RvPskcS+mxDb3fwv/3tvo1abR37ZxG5O7XVlNklhuB+Cf6XFpOcAk5sRrRJXT+ahzbs2/b2at2yeA++5Whd9guptdcWBkrGAA/ABS/LVcvbsqTM6458l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dVRGPNqF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vnTSOAzd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dVRGPNqF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vnTSOAzd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dVRGPNqF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vnTSOAzd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dVRGPNqF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vnTSOAzd"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A76911F461;
	Thu, 15 Oct 2026 17:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792087031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7NLljXwTg7Mg5xcMnK8Uzm0ExBtZWS623cmIu20sic=;
	b=dVRGPNqFY3qbHThKn0Al2xSBkwqzKCFI4rx9cJLPjSCc6f/fy0qTX7rJEYduM8c0vZRtiI
	7CRiL/1g5TYWtY2xLlx7YXMDueAK+mrgXsN5gsL0MHJtN6XgY4iq+/mZOIke2Qv9F81xiZ
	PcdD/cCKmMnftxFOts4adYQaRVwx6M4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792087031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7NLljXwTg7Mg5xcMnK8Uzm0ExBtZWS623cmIu20sic=;
	b=vnTSOAzdg4+yROjj4eEUobg9AA9qevRWVQ/CyRvIOAD3pSdFk5ThjRSTEosCS1vb+vkFkW
	DHNva8HKo+gE54BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792087031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7NLljXwTg7Mg5xcMnK8Uzm0ExBtZWS623cmIu20sic=;
	b=dVRGPNqFY3qbHThKn0Al2xSBkwqzKCFI4rx9cJLPjSCc6f/fy0qTX7rJEYduM8c0vZRtiI
	7CRiL/1g5TYWtY2xLlx7YXMDueAK+mrgXsN5gsL0MHJtN6XgY4iq+/mZOIke2Qv9F81xiZ
	PcdD/cCKmMnftxFOts4adYQaRVwx6M4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792087031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7NLljXwTg7Mg5xcMnK8Uzm0ExBtZWS623cmIu20sic=;
	b=vnTSOAzdg4+yROjj4eEUobg9AA9qevRWVQ/CyRvIOAD3pSdFk5ThjRSTEosCS1vb+vkFkW
	DHNva8HKo+gE54BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 120AE13223;
	Thu, 15 Oct 2026 17:57:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id geEpNvYT0WpRZAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 15 Oct 2026 17:57:11 +0000
Date: Thu, 15 Oct 2026 19:57:10 +0200
Message-ID: <87a4oe7sp5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	phucduc.bui@gmail.com,
	cassiogabrielcontato@gmail.com,
	cezary.rojewski@intel.com,
	kees+treewide@kernel.org,
	yilinzhang@moonshot.ai,
	tiwai@suse.de,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com
Subject: Re: [PATCH] ALSA: pcm: Keep linked drain wait entries safe across unlink
In-Reply-To: <pm-alsa-pcm-drain-wait-lifetime-20261014-v1-face1209fbc882aabda2@gmail.com>
References: <pm-alsa-pcm-drain-wait-lifetime-20261014-v1-face1209fbc882aabda2@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,gmail.com,intel.com,kernel.org,moonshot.ai,suse.de,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[treewide];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Thu, 15 Oct 2026 19:10:29 +0200,
Cen Zhang wrote:
> 
> snd_pcm_drain() queues an on-stack wait entry on a linked playback
> peer's runtime->sleep. After sleeping, it calls finish_wait() only if
> that runtime is still found in the caller's group, since the peer may
> otherwise have been freed.
> 
> Unlink wakes the group members before removing them, but the generic
> autoremove_wake_function() removes an entry only when the wake succeeds.
> If a signal or timeout has already made the drainer runnable, the entry
> can remain queued after unlink. With unlink performed before DROP at
> final close, the following ordering is possible:
> 
>   Drainer on A                       Final close of linked B
>   ------------                       -----------------------
>   Queue stack wait on B->sleep
>   Signal wakes A: TASK_RUNNING
>                                      snd_pcm_unlink(B)
>                                        Wake returns 0; wait stays queued
>                                        Remove B from the group
>   Cannot find B; skip finish_wait()
>   Return due to the pending signal
>                                      snd_pcm_drop(B)
>                                        Wake traverses the stale wait
> 
> Use a drain-specific wake function that removes the entry under the
> waitqueue lock even when the task is already runnable. Preserve the
> ordinary wake result. This lets unlink detach the stack entry before
> changing membership, while keeping the runtime check around finish_wait()
> so drain does not access a freed peer.
> 
> Also hold the existing group lock from selecting the peer through
> reading its runtime fields and queuing the wait. Releasing it before
> registration lets unlink perform its wake before the entry is queued,
> and can let the peer runtime be freed before it is accessed. Release
> the group lock after registration and on the no-peer exit path.
> 
> Fixes: f57f3df03a8e ("ALSA: pcm: More fine-grained PCM link locking")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

This doesn't look needed / fitting for the latest code?


Takashi
