Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439AB42CB14
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507621; cv=none; b=Ty1z3FTj/YMU/ws5Jrl+wmwN2RBgpSx6YdorQ4rZckUBgIHQPyBaWvMj5B3BdyMDgIqY09zqdUHCzrzsf9AKF1UnlC6w7EpS5fVYdPbEanMTiLw8k9QlYgz16FooAsKqQb2MfDcqXyLS+iW7DU3hDTO6zzZaitRCDMQIIA3X36U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507621; c=relaxed/simple;
	bh=bOMa4EkdEh5fxeRl3p+0yOtckORaywH63k4IC//kDCo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXKMZGjAlq2yUYSCaCOi+UlW1Bov6j9pzuU/EOUGvrXj7OCzEOZJKkxntSES4e8lQ7BCAt7H5zwD44R+19Ih1amj7/XNE1b8ubui8lWv8+2mn3wLC9RbE8nLo2wlp5p5G3vS67YcC0Wohz4ZDgvUCC20zJVmnoB/DCLdRctmlWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Havy4MoB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RcZfaZ9d; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Havy4MoB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RcZfaZ9d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Havy4MoB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RcZfaZ9d";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Havy4MoB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RcZfaZ9d"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0247375FE2;
	Wed,  8 Jul 2026 10:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783507608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LtLbUIp99s/i/aLzEwtBFaL1dX0tk56cyLN9FLY9s2w=;
	b=Havy4MoBmDJEX7Ba35/FQDy7+j6cDbMYZJbSBzLuatdSMA2Ph4ISBARt2V0c+A9x26CXY7
	Q7cV39iUZtbL/1VvbZwpbqQPAS3vJn/X6VqT5A+cUPBiMr1OV5rycwM4iiLieafnWtT1mx
	wNHLL1odeAolY+JfnyFqIR364+IghaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783507608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LtLbUIp99s/i/aLzEwtBFaL1dX0tk56cyLN9FLY9s2w=;
	b=RcZfaZ9dKYPgyiNwdKfSi6nl7ih0pz9DZKn514rEwsWTUxY9g4VtUwHGonFpS4WavRhArA
	3nclMVjHbndkTpBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783507608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LtLbUIp99s/i/aLzEwtBFaL1dX0tk56cyLN9FLY9s2w=;
	b=Havy4MoBmDJEX7Ba35/FQDy7+j6cDbMYZJbSBzLuatdSMA2Ph4ISBARt2V0c+A9x26CXY7
	Q7cV39iUZtbL/1VvbZwpbqQPAS3vJn/X6VqT5A+cUPBiMr1OV5rycwM4iiLieafnWtT1mx
	wNHLL1odeAolY+JfnyFqIR364+IghaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783507608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LtLbUIp99s/i/aLzEwtBFaL1dX0tk56cyLN9FLY9s2w=;
	b=RcZfaZ9dKYPgyiNwdKfSi6nl7ih0pz9DZKn514rEwsWTUxY9g4VtUwHGonFpS4WavRhArA
	3nclMVjHbndkTpBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFB1D779AE;
	Wed,  8 Jul 2026 10:46:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cSrUKJcqTmpEJAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 08 Jul 2026 10:46:47 +0000
Date: Wed, 08 Jul 2026 12:46:47 +0200
Message-ID: <87zf014v3c.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Evgenii Burenchev <evg28bur@yandex.ru>
Cc: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kees@kernel.org,
	eblennerhassett@audioscience.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] ALSA: hpi: Check transport errors during HPI6000 adapter initialization
In-Reply-To: <20260707151400.16437-1-evg28bur@yandex.ru>
References: <20260707151400.16437-1-evg28bur@yandex.ru>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.29 / 50.00];
	BAYES_HAM(-2.99)[99.93%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[yandex.ru];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[yandex.ru];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Level: 
X-Spam-Score: -3.29

On Tue, 07 Jul 2026 17:13:58 +0200,
Evgenii Burenchev wrote:
> 
> create_adapter_obj() retrieves adapter information by calling
> hpi6000_message_response_sequence(). This function reports transport-level
> errors through its return value and DSP-reported errors via hr0.error.
> 
> The current code only checks hr0.error, causing transport-level errors to
> be ignored. As a result, adapter initialization may continue with an
> invalid response.
> 
> Check the return value of hpi6000_message_response_sequence() before
> examining hr0.error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 3285ea10e9b0 ("ALSA: hpi: Add AudioScience HPI driver")

This Fixes commit ID and the commit subject don't match.
Please correct and resubmit.


thanks,

Takashi
