Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DAE38F250
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809337; cv=none; b=Q4zuaxZpzfI97lhzHgR5LtIcEDPVEJpLLV1xn9tpUe9WXzoGDXdRQVxp2D/hpAFQUufxJ+BkIfcLVvhd8n3mCT5K6SNhk/JmKJXsfZQ0RYCvbw7P3kWRnR1yu8e3bb60XV2HGIrSS227O9AEOLENRquQY/WGN4T3kIkK6yvLNuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809337; c=relaxed/simple;
	bh=bxCnbJv2NHU6LpFtUEyIFPJaOYh5eYwEuIE0ScvRX0U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZfM/5rMb2sr8gnanhSp3xxFajYpQMCntJPUG3LmcK15/5KG1gUb4mC1dkCsEqHWmUkKU89XjPK+bEzKzsL9fiBAbcgEPVp+q9m9OBW3jVjjtMZMrLpDrlHkts33oblgi8y6jt1MQJUmv/KUMeQB5T1jc4bLuUfIUFjcgy5No0GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eSbBYzKZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rfm3HIoR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T0Z73obV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tgg6uuFt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eSbBYzKZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rfm3HIoR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T0Z73obV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tgg6uuFt"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BADA41F770;
	Mon,  7 Sep 2026 19:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788809329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+Hpde8e2aybkeuNuzWphJMB+4Us4v73JxFalFrc+BY=;
	b=eSbBYzKZBUN96+dw/QJstdPAtTEmgI3WlAVAIdUUCUuHF2m/UnZ/hL6CrbjtWpxPlAzOUY
	gsbmjaLQ3MYjOjoVqNXzNyKXcuqHdMGuT7nC2EkCwt3zbLW4T1Bv4cZfZab28J48qx1qXj
	Lj/iLuXS+T99t90Bc7EaV1BjnWqTsNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788809329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+Hpde8e2aybkeuNuzWphJMB+4Us4v73JxFalFrc+BY=;
	b=rfm3HIoRCOdihVeRvKsQk+s6RhsFPJ4A/G5m3Y65g4SnGJOxpmGlw1sqqV5YUsp4fZTyQ/
	3um50TtyDB1uQpBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788809325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+Hpde8e2aybkeuNuzWphJMB+4Us4v73JxFalFrc+BY=;
	b=T0Z73obVEwcbUUThv4jFRmS6oIlOo67YIOMJ15Vm/vcf/McSngE6bQsNgrCOfKUFRPqvDA
	ko+ScJ2VUogOCznrcQsVJySc9zabYrqRt6L0J4z3Woj22nUAZsbLOUhLU6gWCzjZUyiBeN
	Mw2TBmp/mFBM1VV1ZMmVJnAd3G+KgdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788809325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+Hpde8e2aybkeuNuzWphJMB+4Us4v73JxFalFrc+BY=;
	b=Tgg6uuFto45BmpwZeuVcwTwQUOtmGx5mmWZ8xfEjPZOCD5PA5ekhepfiVmCYCZhOqYSblN
	wGpsPH6eXv/1A0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E70613432;
	Mon,  7 Sep 2026 19:28:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5+0IEW0Qn2peRgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 07 Sep 2026 19:28:45 +0000
Date: Mon, 07 Sep 2026 21:28:44 +0200
Message-ID: <87se3krhcj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sasha Levin <sashal@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	tzungbi@kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] ALSA: seq: Fix port lock leak in deliver_to_subscribers()
In-Reply-To: <2026-09-05-daily-reply-0028-alsa-seq-port-lock-leak-6-1-ack@kernel.org>
References: <20260904070349.80497-1-tzungbi@kernel.org>
	<2026-09-05-daily-reply-0028-alsa-seq-port-lock-leak-6-1-ack@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]

On Sun, 06 Sep 2026 15:32:58 +0200,
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
> Jaroslav, Takashi - can either of you Ack this for 6.1.y?

The fix is correct for the stable branches.  Feel free to take my ack

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi
