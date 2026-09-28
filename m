Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6572367D3;
	Mon, 28 Sep 2026 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598286; cv=none; b=mD1sj3R185Zy0yttTqouTo0kg1onJ9CA8hsCoyNH2O3hbPWq/GUeV6ixefl7JIUs1wqfMi1a/C51VaOjP3cRgF3Q9rM899p/MgZUaiJfK0hpmUVBNdcqjSwoim4NoQqCHhHNHOh156z4Xl51TeRxe6tbHNw5aYh16aQocAAY26k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598286; c=relaxed/simple;
	bh=uc0MUoMdSLJvuhnF56W9Xx19TzgaS8/1c8xXbOdAJBw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KC8DV49oppeRXtiDL7JOTLV6T8vfKaSrzXOhH2bWozr+0MYBa5j6/ViAhidxevjj68KVq/HYNR7bnWMlaGTmxgZdkmETDsoP8VEc+vZ7TLrXlNXABLVd+okrfp9/91Ln+hDpwQ1NoVvIhtWdP+t/lC201YZR2mSVujYAinxLJpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2DPSZgrz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u+II5QUa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0PvowrnK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Lx3oLs7F; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2DPSZgrz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u+II5QUa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0PvowrnK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Lx3oLs7F"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0AB922321;
	Mon, 28 Sep 2026 12:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790598273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oRwtQFoB2U+SnHxyYWXDVJjVDPN/fHCTdL2H6npSTe4=;
	b=2DPSZgrzkbxlaqi2J4LNNXlZBcsHX3BUmZlel9+KGgzozpXrVLNxChCtTP4LjMnBejaiUF
	iwexwZ51FPviSEY81PLcLvIWzQwYr6x5ToiEj8nTQgNAjwxPcC6Q6JQLgdztuIeW1px77N
	Af64rKFvacShsDWR0R6uIC6l3WEeVRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790598273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oRwtQFoB2U+SnHxyYWXDVJjVDPN/fHCTdL2H6npSTe4=;
	b=u+II5QUaJrbK1hbbMDW8ErhnJpucilOd5T5lmPqcSoNFX8qTRT/6G3H7Q9kiZSNRPvRkYx
	lvRAfHGtH4w/KTAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0PvowrnK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Lx3oLs7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790598269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oRwtQFoB2U+SnHxyYWXDVJjVDPN/fHCTdL2H6npSTe4=;
	b=0PvowrnKdlAekA9E+5hYEq399qN9nvWTWqJ0Usd2m2p1w+UoilMyKeheNVh3+bgY6zDiP2
	kgk5JeHuxmhSj4Nz0ycb8nYEEuLs2mDowbOSiiTyXSrqRyGp8VdV+0uCz6w2Xe/ygrJ1Vb
	fII0Pqg26nUQDgnMre8CYBjJJ8O59AI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790598269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oRwtQFoB2U+SnHxyYWXDVJjVDPN/fHCTdL2H6npSTe4=;
	b=Lx3oLs7FRGq75a3/fibx7JxP6sQQj34/htGmQd5MlxqSjnZ+dcGJ8qGWd26TfEyNErbVhM
	KOMLY1ZcmLsZ+qDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7670A133F1;
	Mon, 28 Sep 2026 12:24:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ikp7EnxcumoKdgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 28 Sep 2026 12:24:28 +0000
Date: Mon, 28 Sep 2026 14:24:27 +0200
Message-ID: <87jyo55zt0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] ALSA: mpu401: shut down timer before freeing MPU
In-Reply-To: <20260927093809.681726-1-runyu.xiao@seu.edu.cn>
References: <20260927093809.681726-1-runyu.xiao@seu.edu.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: F0AB922321
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,seu.edu.cn:email]
X-Spam-Flag: NO

On Sun, 27 Sep 2026 11:38:09 +0200,
Runyu Xiao wrote:
> 
> When an MPU401 interface has no usable IRQ, the driver polls raw-MIDI
> input and output with a timer. During raw-MIDI teardown, the timer callback
> can already be running when snd_mpu401_uart_remove_timer() clears the last
> mode bit and calls timer_delete(). That API neither waits for a running
> callback nor prevents it from rearming the timer, and free_irq() does not
> synchronize timer callbacks. snd_mpu401_uart_free() can therefore release
> mpu while the timer callback still uses it.
> 
> Initialize the timer once when the MPU object is created and only rearm it
> while a timer mode is active. Shut it down synchronously after freeing the
> IRQ so an in-flight callback completes before mpu and its resources are
> released.
> 
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Applied to for-next branch.  Thanks.


Takashi
