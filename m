Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C0D38330E
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788682293; cv=none; b=mOnsWc7gmsklm8cjfUDfrnrYswl8cZ1l60ugrIkxpbCKwk7iwMDAD7yYkmdmB9BIhJ/D+XiJYrmVXKjIz2zGgtJReLvKAxcxVDNj8ORIdv+l2m8p3yXNNnEOrv4yOTUIMfb1PJwelMhbbX1Z4pPMeA0jPNanEh5MajOkIe5myvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788682293; c=relaxed/simple;
	bh=yRK5JS3HHPRXGfSaecDps9odtxD870Aau+IWBYAmICs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qp/itOWBIs7BNYuBqO9EPwE1bKCo0Bcxjl8LKX7MENPaSuwM3s/f7CmOjxtLPdJgvU8XH8PPb7IZ7xPEQxnxkPTh1iiiNYGlefApaPb/gjMLzSvuFcUplQzy4rjwl9ju053rH5ks075qQVE+uB+7bI0dRJWSeSUxwRvqxbEHDQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jKk31+zz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FsN1d4jb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wvrzC4N4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9MfLXOr3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jKk31+zz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FsN1d4jb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wvrzC4N4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9MfLXOr3"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E835922722;
	Sun,  6 Sep 2026 08:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788682278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1zqgj8HLHFesvx8Fl0smcNw7EATmAUNk6nPCqMBwROM=;
	b=jKk31+zzpoHHAAefzvsJ8vopnPSrSQhhkVBfFhfxsd3s8ZtRjN89tBy3fFGYSD5CdLX+ID
	+vg0LVn9NJwgELsQrQL3cIMswKzNjTOV+Z2pGaXEChOkx9KS8Y767uSsyspgoD2Z0eSXK3
	r81rxGIh316l80a0mILu89JZTrEEPM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788682278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1zqgj8HLHFesvx8Fl0smcNw7EATmAUNk6nPCqMBwROM=;
	b=FsN1d4jb142KtEWtArlGszpB1aBrDcrmaa8K9sSWMjtci9Hi71PwEjfRQU8dBN7qeQarmU
	cCYFjhu6RW+OCfAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788682273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1zqgj8HLHFesvx8Fl0smcNw7EATmAUNk6nPCqMBwROM=;
	b=wvrzC4N4g8U3Iwec4NzhTEdfLnUHZPXtHZuI2gJqjNkgWevMbcKt2ngGPEF7BITngdQ0hX
	5EHkpNuBAKgz8TnnN4EHlhcCuYycK0J1tebwdr/Dp+ERCoIPNeJFlT44K4iXQKK13v8qz/
	4KlNYvpGhcu0KtNpqOXwPHXhOG/xpZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788682273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1zqgj8HLHFesvx8Fl0smcNw7EATmAUNk6nPCqMBwROM=;
	b=9MfLXOr3eJ+D4sDhAeSByMWdQ69hhdlmuS5AxdNShv5uBZ4V7rH9f2sF0KMcXVhbUe7bgg
	JeWPsl4bWLzlRTBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 913E513432;
	Sun,  6 Sep 2026 08:11:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bR8yIiEgnWrDcQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 06 Sep 2026 08:11:13 +0000
Date: Sun, 06 Sep 2026 10:11:13 +0200
Message-ID: <87ik4i4x5q.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Tristan Madani <tristmd@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v2 1/2] ALSA: usbusx2y: fix in04_last array size mismatch with in04_buf
In-Reply-To: <20260904205826.4071119-1-tristmd@gmail.com>
References: <20260904205826.4071119-1-tristmd@gmail.com>
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
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,talencesecurity.com:email,suse.de:mid]
X-Spam-Flag: NO

On Fri, 04 Sep 2026 22:58:25 +0200,
Tristan Madani wrote:
> 
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> The in04_last array in struct usx2ydev is declared as char[24], but
> in04_buf is allocated as sizeof(struct us428_ctls) which is 21 bytes.
> In i_usx2y_in04_int(), when ctl_snapshot_last == -2 (initialization
> path):
> 
>     memcpy(usx2y->in04_last, usx2y->in04_buf, sizeof(usx2y->in04_last));
> 
> This copies 24 bytes from a 21-byte slab allocation, reading 3 bytes
> past the end of the source object.
> 
> Introduce a USX2Y_IN04_SIZE constant defined as sizeof(struct
> us428_ctls) and use it consistently for the in04_last array, the
> in04_buf allocation, the URB transfer length, and the comparison loop,
> replacing the bare 24 and 21 literals throughout.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Applied both patches now.  Thanks.


Takashi
