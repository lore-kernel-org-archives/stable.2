Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE7D4A0151
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355884; cv=none; b=WMvyn5MpGNvNVASUrDhOniDW+Y6mfpoy6DepIb0dI+a7w5JTgIfqIk2hLbWLozoCEmpz34wfSO0WEX3svsp024L0m5XeCLo37MHMKT0X57uJzXudfp8Uq7QBY1+fKjB4DoUFPOiZA8zMn7OaRCoVvCahfhEWuR9H7jVhC9uJCNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355884; c=relaxed/simple;
	bh=JIRxKavBe+DvymIugmgjMnOUBX4MpWbeh9OBzJEuUX0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUESDjF1nS8Yh7ELsIF5B8089eWHXSghBlSX/d18fEeE/8/b8BRJ2x8+EEozKCIFn73HI/7jmEUP2n3C1pqqpdczPkh5/IAGsHGqhCfpxoT/DDZQkiM6GjwMiMLmAoE8hcck8QSOHAeEOJbcGajANIai3XYeatGCuVzMAs/rFXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EUJWnTXs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XmNfTaar; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nD47AEwm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dJRdnPdw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EUJWnTXs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XmNfTaar";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nD47AEwm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dJRdnPdw"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB2BC1F7F0;
	Wed,  2 Sep 2026 13:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788355868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Oq/y51KYOTLhg4tsP8IxpDLeU/AspuBu+A/pKNa2Yo=;
	b=EUJWnTXsmj0tG/7sIvNSo8tl5AJ4lonze6LL/AU5kG1l+HyEZuqTzTzN2vR43V2/U9BLgP
	6w24RLUUL83RooQuNzz6YAQD2649jUEfNPuSYdpn/05kkme//CHVy09PMhwalQLbBURrsC
	6aMNeSeX+V5KGwLISOXsRnl+IUckWgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788355868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Oq/y51KYOTLhg4tsP8IxpDLeU/AspuBu+A/pKNa2Yo=;
	b=XmNfTaarpwMn9SfCplacaNfdodOxn9hIZ4/CpDCU9pjll5rxwZ5xqBGNqa4lU4LoOnCoL0
	56Itl82sbIbMaJAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788355863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Oq/y51KYOTLhg4tsP8IxpDLeU/AspuBu+A/pKNa2Yo=;
	b=nD47AEwmQ0qcfbjnhZceZ3EV0yQskM/BJal9/bZAk7SZVjSDKPRQ68mg+3pi8TNH+l2bJc
	KyjcutSLKogxtyNnH5FVuqYz3ip54HZhG1zwS+hBxAuAbA40yU38sH9uP51mOU8hLUmZqX
	ey6bjB8g8P71hF5iqywYKqfdgrxxjwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788355863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Oq/y51KYOTLhg4tsP8IxpDLeU/AspuBu+A/pKNa2Yo=;
	b=dJRdnPdwH4Q1y6Frwssn8EeZxR9Q/xTdl8XVJQuCqNbILdGhvi5VKYIitpfgDkHd+RuPgK
	I9VwrpWrMaRgAdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3765D13888;
	Wed,  2 Sep 2026 13:31:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yVZaDBYlmGrMWgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 02 Sep 2026 13:31:02 +0000
Date: Wed, 02 Sep 2026 15:31:01 +0200
Message-ID: <87ld9jaiga.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: HyeongJun An <sammiee5311@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: rawmidi: Return the error from snd_rawmidi_input_params()
In-Reply-To: <20260902125058.19499-1-sammiee5311@gmail.com>
References: <20260902125058.19499-1-sammiee5311@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Wed, 02 Sep 2026 14:50:58 +0200,
HyeongJun An wrote:
> 
> The snd_rawmidi_input_params() computes err for the three invalid mode
> combinations and for resize_runtime_buffer(), applies the new framing
> and clock type only when err is zero, and then returns 0 anyway.  A
> caller that asked for parameters the kernel rejected is told the change
> succeeded, and the substream keeps its old buffer.
> 
> The open_mutex conversion turned the early returns into assignments.
> It handled the output sibling correctly, which still returns err, and
> left this one behind.
> 
> Fixes: 94b98194b62e ("ALSA: rawmidi: Take open_mutex around parameter changes")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>

Applied now.  Thanks.


Takashi
