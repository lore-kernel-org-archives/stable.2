Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E48E443E4D
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517573; cv=none; b=rLVFVkT8xd3Aei/iZpI0gvmR9YhgRuI4LbU4fpRQK8qG6g8f5LPFwFtw+9Br2PxTb5elfEy+SHVfj4/6jl56qtqXDEKCkVT1YXb0GfkQAW4pTGBJ79HBZHORltWBqGHInYUhC98HMYYrqGYzQOrz4rOtiZso3aM9Xa/ilT003RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517573; c=relaxed/simple;
	bh=rm0cgSkyePdb0TIKGTVPe5pgNno3rpqxW6Qht5RNYKs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpBhH2Pxc5eAQPiEOFhGK7jZ0CYa17TufRa0fiHJ9AVN3dF3+0TohaoXcPiAUHqpeeX++69tK4qa6Qd/zsHoTKLbDdJyNfHaXzbGVsfsX7j8UcExhDBbzUW9ia8bGbH1UCPXzcUdyA5dvW/e3CTZUarVkUyxRB5KtvRGQ4EuZSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QPY9G30p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8LQEZ4Kf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SCdzZpgM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ji4tOIVZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QPY9G30p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8LQEZ4Kf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SCdzZpgM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ji4tOIVZ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A8D4E228D0;
	Fri,  4 Sep 2026 10:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788517551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXZEZTVRA+G8eyu4HzT/YM+2x3IU6orNt2nSuWc118Y=;
	b=QPY9G30pxOlRQRLr5YlyLoHbkh6aFAU9g2OYo5NOwSpB9m+H36/lgC4bReDkFkx9KcFkXP
	ybOR1yRcoPbjSpSXQK8jT+W/Ce9WEZ0H/zSqvR6oh26cC3uKNuvyG5jnBipC2tDJCzGKvC
	Y3AO9aTC7IhAA5nKWxI162ugodOdreA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788517551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXZEZTVRA+G8eyu4HzT/YM+2x3IU6orNt2nSuWc118Y=;
	b=8LQEZ4KfvUHzZzBeyy9xcgDmcq4yqYNy4uaMVE/0jhTz2f1JUArZPeSIUCXtE6hx0IcO4Q
	fVIAtEGm8xWfFeAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788517547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXZEZTVRA+G8eyu4HzT/YM+2x3IU6orNt2nSuWc118Y=;
	b=SCdzZpgMnC50Q6XsMEXDtrdQc3ZhJhRYAf8XTSKlMOua4y+MWY/jzxc+yNjNdReMB+lH6f
	ycng1EO2shL9oTuroN+l1Uv3NxZmwvbitIOQRT0NYjZoRqrtcgp788KetJTwMxvYRAyOll
	c4+I+RubjVRrmaJ+tFgR6W7yFGUqtaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788517547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXZEZTVRA+G8eyu4HzT/YM+2x3IU6orNt2nSuWc118Y=;
	b=ji4tOIVZRHthdxKah7QMOHsXvy2K/8lnOHt9K7eGXy1RofQLAVTm5sslbWh3vx2hA6fj5d
	qmnndcdMjcqbcsCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61C5713726;
	Fri,  4 Sep 2026 10:25:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pgSiFqucmmqESwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 04 Sep 2026 10:25:47 +0000
Date: Fri, 04 Sep 2026 12:25:46 +0200
Message-ID: <87wlt15n4l.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Tristan Madani <tristmd@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] ALSA: usbusx2y: fix in04_last array size causing slab OOB read
In-Reply-To: <20260904095154.3905899-1-tristmd@gmail.com>
References: <20260904095154.3905899-1-tristmd@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,talencesecurity.com:email,imap1.dmz-prg2.suse.org:helo]

On Fri, 04 Sep 2026 11:51:54 +0200,
Tristan Madani wrote:
> 
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> The in04_last array in struct usx2ydev is declared as char[24], but
> in04_buf (the source for memcpy) is allocated with kmalloc(21).  In
> i_usx2y_in04_int(), when ctl_snapshot_last == -2 (initialization path):
> 
>     memcpy(usx2y->in04_last, usx2y->in04_buf, sizeof(usx2y->in04_last));
> 
> This copies 24 bytes from a 21-byte slab allocation, reading 3 bytes
> past the end of the kmalloc-32 object.
> 
> The comparison loop already uses the correct bound of 21:
> 
>     for (i = 0; i < 21; i++) {
> 
> Fix by reducing the in04_last array to 21 bytes, matching the actual
> USB interrupt transfer size and the in04_buf allocation.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Better to introduce a constant definition and use it in all places
instead of magic numbers.  Could you rework your patches with it?


thanks,

Takashi
