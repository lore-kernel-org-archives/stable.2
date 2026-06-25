Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2553DC87B
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782388981; cv=none; b=KQGpbxxQhQ+ngm/bap7w3B2NQ/W2AmGt/hVv2lPeVMo1C6ngcdp2fQGCO9I86vTgUDarR48HTXdVbaTuTdO1rbzXuPHxm/heoFKrCmwWuKFvDfY2/M3cXsBRk2qS4nYja4oPQIMKOEXWYLXUOyGgfs7bBiF8tGbtX8ptkNw3NXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782388981; c=relaxed/simple;
	bh=xyjYE+wdCRqfeXrLoCjAccvmSLZbMOpLrWkbvLXVmmY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGOzuW/NhcP2ggQWjP3HhlUP7lletlmOqIIe84vaDVM5rEudRqY6y27YGd5CECwiq0YYkfCnXhZIPE+9BNefv+uKP7o2nlbhGaaWzQmRmT0hvSK7LSMgWbZ1td6x4sLJ0iZBRAgPn8s+P/w49JPrwGhBSkQJj5hEC54VulEX/WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Efm1c2SR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m46NOzkK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rXg3UsSV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PGgCAjbw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Efm1c2SR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m46NOzkK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rXg3UsSV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PGgCAjbw"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 166E271B00;
	Thu, 25 Jun 2026 12:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782388977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cPS0ijg5scPFhq5gmIRPoChf+Roc+10cb3JS4k6uAcU=;
	b=Efm1c2SR5cf8AO19tbRlWmG45eSot0YIIOde1bhJX1hsy8Qvy+0w93Lu/MhPAhKGELn91u
	XTVMV04GrNw2ht7JO8jbFV/Aetls+HVsJ2n1wzevtOfvvoov4b2qiwRj8PrvQ4rrABAKEI
	Q1x4LkxWdrBjYMgnY0D3fAlA2eTG5J8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782388977;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cPS0ijg5scPFhq5gmIRPoChf+Roc+10cb3JS4k6uAcU=;
	b=m46NOzkKBeuSEsQenk4/EWjCil4ConygAczDw/m8movtvFeh0q7qCwwxejcomqF27WgICn
	6Cquffn69hn6AEBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782388976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cPS0ijg5scPFhq5gmIRPoChf+Roc+10cb3JS4k6uAcU=;
	b=rXg3UsSV8xbC4U5qEXG1BmO4VFwGugx36jhsQ32yPk2AVSKwn1nopsBuDNBzecGACpBjM1
	nmi2SS/EWAcWq+N8oVu28glRJESn8fiSDETmMSkiLffOdgNrfbtcKufNnowrMFzv/br3gl
	e/J07JjXjP4uEpc/qc21XL59YV4uyXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782388976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cPS0ijg5scPFhq5gmIRPoChf+Roc+10cb3JS4k6uAcU=;
	b=PGgCAjbwplxstk0ADQoYutIuJinvUhk+MUi6Mhc6GcaSg7E/6KvYtcQmSh8dtNHP+7bNkq
	K1ZecFmSBn3+hRBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D87B6779A8;
	Thu, 25 Jun 2026 12:02:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 36vSM+8YPWruCAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 25 Jun 2026 12:02:55 +0000
Date: Thu, 25 Jun 2026 14:02:51 +0200
Message-ID: <877bnmvndg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Clemens Ladisch <clemens@ladisch.de>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: firewire: isight: bound the sample count to the packet payload
In-Reply-To: <178205454729.1900991.7807310178296762772@maoyixie.com>
References: <178205454729.1900991.7807310178296762772@maoyixie.com>
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
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Level: 

On Sun, 21 Jun 2026 17:09:07 +0200,
Maoyi Xie wrote:
> 
> isight_packet() takes the frame count from the device iso packet and
> checks it only against the device claimed iso length.
> 
> 	count = be32_to_cpu(payload->sample_count);
> 	if (likely(count <= (length - 16) / 4))
> 		isight_samples(isight, payload->samples, count);
> 
> length is the iso header data_length. It can be up to 0xffff. So the
> gate allows a count up to about 16379. isight_samples() then copies
> count frames out of payload->samples into the PCM DMA buffer.
> 
> payload->samples holds only 2 * MAX_FRAMES_PER_PACKET values. The
> device multiplexes two samples per frame. A count past
> MAX_FRAMES_PER_PACKET reads past the payload. A count past the buffer
> size writes past runtime->dma_area. The smallest PCM buffer is larger
> than MAX_FRAMES_PER_PACKET. Bounding the count to MAX_FRAMES_PER_PACKET
> keeps both the read and the write in range.
> 
> A malicious or faulty Apple iSight on the FireWire bus reaches this
> during a normal capture.
> 
> Add the MAX_FRAMES_PER_PACKET bound to the gate.
> 
> Fixes: 3a691b28a0ca ("ALSA: add Apple iSight microphone driver")
> Suggested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Thanks, applied now.


Takashi
