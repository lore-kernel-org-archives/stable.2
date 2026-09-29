Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43035383F8;
	Tue, 29 Sep 2026 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694577; cv=none; b=oryxeb9JFNzV17GZhmfAnjSq6IEovadKuDl+IbxCrpe9YeRx8CS4LHIh24pwOI2uaJkI67D7lQ0rd0TvFPBitI11o0W1fbNnveWFL7m/ylsfV9z8jIQ0xkw85jeBxC9bzMaT5suz5dsGIGH1UptxnSFimk66f0tU2z5Sho3bcKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694577; c=relaxed/simple;
	bh=qPE8L6OJ9BcQVpA6etspWXjhpppoEWMeLPP7UNhx5rI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7dHa3MJplxvI0QrOT0EUeBwc5ZdQkN6BZ2B/r5XqSOIUaNV8msYKKxMcYQabCtg3jqKSkQOn4dw3PQCV2177ayqs1RQ4Tl5nbGgSC3+oXVlWsQWVJkaKmkvu94K4lWd4LzrgANfmBZ717Ku1bsAuBJyOZofJonVyzESONsZG04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SC+I9GUx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7Z/ezAyH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HpLWIVGW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SgW/yOya; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SC+I9GUx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7Z/ezAyH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HpLWIVGW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SgW/yOya"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8701D21BED;
	Tue, 29 Sep 2026 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790694554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=laGINfs/vcoQYqRRn6JuowLlarLD9nHJ92K2fMjwm9s=;
	b=SC+I9GUxceNQ9qiZRwmQrzXXD1/DA6W7LnhmJmHYsBcPnM5hCFssb9GIuyCV830L8HNy4H
	8tEyCN+OtTwSAISAgEAsnaBtZ8gXxK2pUBqxGVu2ZqJBU6z7wsjLtE8pmGIXPpGsSi7fSW
	wR58ALOsNRhw5YbVHIJd7l+J0MBkGu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790694554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=laGINfs/vcoQYqRRn6JuowLlarLD9nHJ92K2fMjwm9s=;
	b=7Z/ezAyHkGe8hLDDynMJYjh4pjSolfYhQKyVsPHwtYz+jvO45LjSBmtLhP8vVzONBJazGY
	bPcCemmwMF9mb2Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790694550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=laGINfs/vcoQYqRRn6JuowLlarLD9nHJ92K2fMjwm9s=;
	b=HpLWIVGW9fV0mROJp7WM2RxBY1i/MzjZ5PHH1T0bu75cx77zMXXn2AjwiYLs/BAcry5Y/6
	L/zpHeGdUroyAxruClmjZqAMWhjYXFy0rrVsS4Er3fGWW8ziKJul13cYU9+H9WiSfNmqSe
	CWN8kCNsxh3jXo83rmobgmetFJm/yRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790694550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=laGINfs/vcoQYqRRn6JuowLlarLD9nHJ92K2fMjwm9s=;
	b=SgW/yOyajevmG9xbCfkMNSZFxEMyvvuEW5DXp3/b6f+z3gORPemSit6SQueyL/wByr89Kx
	Vay5lCPcg47XGbAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47712133F1;
	Tue, 29 Sep 2026 15:09:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cLjmBpbUu2rPCwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 29 Sep 2026 15:09:10 +0000
Date: Tue, 29 Sep 2026 17:09:09 +0200
Message-ID: <87ld8kyu0a.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] ALSA: sgio2audio: Only free successfully requested IRQs
In-Reply-To: <20260929084540.2065213-1-runyu.xiao@seu.edu.cn>
References: <20260929084540.2065213-1-runyu.xiao@seu.edu.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:mid,seu.edu.cn:email,imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO

On Tue, 29 Sep 2026 10:45:40 +0200,
Runyu Xiao wrote:
> 
> snd_sgio2audio_create() calls snd_sgio2audio_free() when an IRQ
> request fails. The cleanup helper currently walks the complete IRQ table,
> including entries whose request_irq() calls have not been attempted yet.
> free_irq() then receives an IRQ and dev_id pair that was never registered.
> 
> Pass the number of successfully requested IRQs to the cleanup helper on
> the request failure path, while retaining the full-table cleanup for
> teardown after all requests have succeeded.
> 
> Fixes: 862c2c0a61c5 ("ALSA: ALSA driver for SGI O2 audio board")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Applied to for-next branch.  Thanks.


Takashi
