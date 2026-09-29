Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE4651C04E;
	Tue, 29 Sep 2026 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694592; cv=none; b=ObldRiYFEdu1K0VB7BOXBTHU5sBr1r9xgAI5lcdoXyca+CxLU+SO+T8dhnJg1UCCmnFrJpBDI8Q6Sx5NiLbJdXG0dPeQxH/HC7yB1qPtoBXWNx5RKmeRSAnlm87ParVeJVFI0NI5h2ivr/SCcajQAKprUtOvzUgEC4jINEzu870=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694592; c=relaxed/simple;
	bh=CbVzNnoby7IW7M48m5afpmsoQzZzF3H+dYujn6CSsKs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dpq4ZPg2vNy8M4tAleYeTTpzjzeppvQItnptQmmj4QBt8Ib1BKL7iWGxNGRYHq0fjkIWL0W6lJZ1ZEW3giE4A2hlGne6KONAPCs0u02e23UlXNq+pjWorFcxtjOqGPFX6R016k9JF2AaPPgqZTEJLf4Ot556WWyhGSd4yVgOFHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l0x5UN/V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nagovMWI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R4KatNak; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FviMthxE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l0x5UN/V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nagovMWI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R4KatNak";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FviMthxE"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54FC521C2D;
	Tue, 29 Sep 2026 15:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790694569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2vqfiKyYuDAYzRJHUTFhndcJh2kcuU3cIAIbLN/BVY=;
	b=l0x5UN/VqnrEGULy67/1G+JHvbs39UBDy5Ez5Lz1SRumfxwOffe+NAcp0yT6lams9m8R16
	5qc8o/WZ4N+/nFPibz5x6XrdhZirP2d75TKPaYL7jIF7zLL5PG7xlBUyALAO3qnXeFs7UU
	b+q1tZqXlQ+dITQsHBsy/aJhI08MyVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790694569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2vqfiKyYuDAYzRJHUTFhndcJh2kcuU3cIAIbLN/BVY=;
	b=nagovMWId8dIQ307V4+hQwglytIXkJTY3f9uBbze5Xalu9APMNfRKwlMst9oQy4IUx/rOu
	WGhe/E8OpSXgzhDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=R4KatNak;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FviMthxE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790694565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2vqfiKyYuDAYzRJHUTFhndcJh2kcuU3cIAIbLN/BVY=;
	b=R4KatNakByaHWpjxwMeQKeXpb/s7t9IdP8CWvrACOHnjaVSKZxxLt+8CW1UI6zxj8AZsO5
	YDOpGEX7K08Seo4vnef+YO6oQx5r8bU5hQqWXo9TxUdN3p9+tgyercH2FCaHTRkLdSTvzS
	uhciLRRg/uFtJ3yyBQfwU3hBLO7/koQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790694565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2vqfiKyYuDAYzRJHUTFhndcJh2kcuU3cIAIbLN/BVY=;
	b=FviMthxEpODR6ITmFYcyWMqZNfV6nY4mtVPk6oVJV2eoNBevmk4OB4Fiwn3bzq0Wen+FKC
	CWX6jbQ0iIptlMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 151DD133F1;
	Tue, 29 Sep 2026 15:09:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fcCdN6TUu2rqCwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 29 Sep 2026 15:09:25 +0000
Date: Tue, 29 Sep 2026 17:09:20 +0200
Message-ID: <87jyo4ytzz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH] m68k: dmasound: Keep the Q40 IRQ handler registered
In-Reply-To: <20260929085400.2068977-1-runyu.xiao@seu.edu.cn>
References: <20260929085400.2068977-1-runyu.xiao@seu.edu.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 54FC521C2D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,seu.edu.cn:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

On Tue, 29 Sep 2026 10:54:00 +0200,
Runyu Xiao wrote:
> 
> Q40PlayNextFrame() re-registers the sample IRQ after stopping it. This
> function can be called with dmasound.lock held and from the sample IRQ
> handler, so free_irq() and request_irq() can sleep or deadlock. A failed
> re-registration can also leave playback without an IRQ.
> 
> Register one handler for the lifetime of the driver and select mono or
> stereo sample handling inside that handler. Call the frame completion
> path after releasing dmasound.lock so it can refill the queue safely.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Applied to for-next branch.  Thanks.


Takashi
