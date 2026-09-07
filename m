Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C18C4052AA
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809368; cv=none; b=H9jaBUMddTNOGt3IasypNa4AJoqStfYf9ozosI3llGBWxtvnsntAl3mhqaoNKlKz0ndXIM+2dUuKvfbOPepyoENWlkYTDOqqdCaNw/DAmTZ2IPtbq5B4tTqbiB/woII+T7PC+6hFVqA7geLYAsAIqiam6VeQAUaVCav4ScE2tEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809368; c=relaxed/simple;
	bh=KpGqBl13nn4DPR5k/TSPm1PxekCvu8cNp3XWXyscq0c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxvcimKYpwSy+WCCCL30xOfluV0+/eTEspuh8B2V9A7e4xXpVCW63ahY1PgN57gc05Bmw0fnFJd5iEhOHfEN6I8LkyN5kzXbbKQ3XTIby4quDlUPnA290/duoMv9KPYrD0PyXr5BrpvnbXjQudX93MKFFdveTmz6sngCxBFF9Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vy6UY5Ao; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IWnD2QkB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZA8/+/ej; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v4CwVYGM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vy6UY5Ao";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IWnD2QkB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZA8/+/ej";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v4CwVYGM"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 445661F456;
	Mon,  7 Sep 2026 19:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788809360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yyRykY7n9TjE6RWlEb4cJkZfh+EywU6P8QqTsSWIsO8=;
	b=Vy6UY5AoOOzZsx7t+qaW21PSObblxxopNLxajS9waGPEa3EwkDOjdQ2jLhbzTRqI5KkVTx
	9QUyWLgiaFleW50ZjdycaX77D3PoYvlV4hL2eO+KfaeszdZweZ9Joa+bwXpCZOaxH1ryE9
	OkFlLnJ1n4x+5iuMSgba1qstFpVYvcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788809360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yyRykY7n9TjE6RWlEb4cJkZfh+EywU6P8QqTsSWIsO8=;
	b=IWnD2QkBy/MQLex7J3UlrrxXPckNvK3Ql/4DPdsmUYRw95GIV+qBxUktlxzqNFPzTVHhbv
	fFi6dzTZo/WZxaBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="ZA8/+/ej";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=v4CwVYGM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788809356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yyRykY7n9TjE6RWlEb4cJkZfh+EywU6P8QqTsSWIsO8=;
	b=ZA8/+/ejaI87CyNIbATD2llGlLOwbwtFd03c1IFbY2+IVqN09MHhBu/vlucnjfujM5/bHA
	YQWo4X/WkLVqq5ald0YIOo+9m60g/802pzdWta+dgGb2U9vmC6MC2XtOzC387lWDqq9e62
	Jl42If9xirQ0a5XgAbudTvL8vh9sApA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788809356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yyRykY7n9TjE6RWlEb4cJkZfh+EywU6P8QqTsSWIsO8=;
	b=v4CwVYGMIUteKJQb13/Bxx+71UhejwUIIJ4KvDDWXSW5fA21IIQQZE71UGFrUrI/7nYBSe
	B5GdTUaVRwBHwbDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECA8413432;
	Mon,  7 Sep 2026 19:29:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bT+dOIsQn2pwRgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 07 Sep 2026 19:29:15 +0000
Date: Mon, 07 Sep 2026 21:29:15 +0200
Message-ID: <87qzj4rhbo.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sasha Levin <sashal@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	tzungbi@kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] ALSA: seq: Fix port lock leak in deliver_to_subscribers()
In-Reply-To: <2026-09-05-daily-reply-0029-alsa-seq-port-lock-leak-5-15-ack@kernel.org>
References: <20260904070409.80648-1-tzungbi@kernel.org>
	<2026-09-05-daily-reply-0029-alsa-seq-port-lock-leak-5-15-ack@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 445661F456
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.51

On Sun, 06 Sep 2026 15:32:59 +0200,
Sasha Levin wrote:
> 
> > Commit 46397622a3fa ("ALSA: seq: Add UMP support") mistakenly removed
> > the `snd_seq_port_unlock(src_port)` call in deliver_to_subscribers().
> > As a result, every time an event is delivered to a subscriber, the
> > source port's `use_lock` atomic counter is increased but never
> 
> The fix itself looks right - restores exactly the unlock that
> 46397622a3fa dropped, nothing else touched. But there's no mainline
> commit backing it (the actual upstream fix would be 177ccf811df4, which
> is a MIDI 2.0 feature commit and not stable material on its own), so
> this is a stable-only fix and needs a subsystem Ack before it can go in.
> 
> Jaroslav, Takashi - can either of you Ack this for 5.15.y?

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi
