Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4493DDAF0
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786877135; cv=none; b=uOklfdnnZzUyWXo054Rw9JKhj0jOuNQn8FiGDN0ZJSwUIsO743gtrG39fARI81HbnK4esD1hTZcAJ6oAoDNJjsJLwpBYiYW/Hqj8Mq+sCKvLwcxUxZxZI6W6rIp64FkfINeWrU3VhlK5qUEO/zHcYcxif6cTkiyEwl+ujY8fO9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786877135; c=relaxed/simple;
	bh=VBBRBhYNyAIINV8g13Bp95XFGJdb782H2BTytJfQwUk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZY45hpVoOWnN5nGNcHCcE5ERNa3oJH7fV9HzrycoC4zc4uP42zOJ7Te5C/GubHD+POaP7nfUO/mlRpl9O3Wfy5/AQBKCM4FewU0uPfdT0veaaWZUAv+JFghL9d+c3R32Qy9UjQIEa9CA4xSFNse2zdENMPIIPFEVPskdNVn32y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ha7XXt1S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ToK+YGa4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C9reJAeg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jd/GeASw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ha7XXt1S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ToK+YGa4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C9reJAeg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jd/GeASw"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4163C3E25;
	Sun, 16 Aug 2026 10:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786877043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xsd0giZowRyO7s6xgALZUr1zoOCjQCgaiy9LzKVAnbY=;
	b=ha7XXt1SPCwKEpCNyLK3A4y26BGS1JwebpNFdTBqLppyRQljU/12NpSlefAZIa4vvlI1qQ
	Kl45WGXUV3Y02pY+wdNNNQszJzYtfD9+a20Myu0nKhq+5WzbHn9yKwKQLGpQ8t525pIlWB
	omZWzZm7q6LH4Eiu6y4z3f2z29f0Ixw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786877043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xsd0giZowRyO7s6xgALZUr1zoOCjQCgaiy9LzKVAnbY=;
	b=ToK+YGa4HHJkmgsYhBePKkfG8loWFlm2dcMv/HoFfpdERhvVNYgrz3ka1hP0HSpVkNdoiO
	kj7JiiUgKlABiCBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786877039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xsd0giZowRyO7s6xgALZUr1zoOCjQCgaiy9LzKVAnbY=;
	b=C9reJAegS7k+sO6ugiaoeKohnIul2ufC+3Ly5XwS/lz74rtQbdX0YWhce3p3KrGV+L+T1W
	PGS1PZt4EwFdrii56L89xehiWM4KKtN6LeqwfjI2g/Ur4ZpIDq+yTAXWCSJ6hIbxpqO/eb
	gdHr5J7FsP2rwlb3BqK9+XWwpuKce1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786877039;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xsd0giZowRyO7s6xgALZUr1zoOCjQCgaiy9LzKVAnbY=;
	b=jd/GeASwNMJ6pDkzkYuNLFxoKzq/qjRgGcNyh6MlMC5RgFGyWIMkhW7Y+ZSeqlp4EJckd3
	Zm6oxTlJNjxNGICg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7298B78E6C;
	Sun, 16 Aug 2026 10:43:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id np/WGW6UgWo+bAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 16 Aug 2026 10:43:58 +0000
Date: Sun, 16 Aug 2026 12:43:58 +0200
Message-ID: <87wltqcpld.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: gregkh@linuxfoundation.org,
	victor.krawiec@arturia.com,
	fanwu01@zju.edu.cn,
	christophe.jaillet@wanadoo.fr,
	kees@kernel.org,
	balbi@kernel.org,
	tiwai@suse.de,
	dave@stgolabs.net,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+d5fa3d224505c8610702@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: gadget: f_midi: initialize work in f_midi_alloc()
In-Reply-To: <20260815054006.102325-1-jeffinphilip14@gmail.com>
References: <20260815054006.102325-1-jeffinphilip14@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[d5fa3d224505c8610702];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,wanadoo.fr];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,arturia.com,zju.edu.cn,wanadoo.fr,kernel.org,suse.de,stgolabs.net,vger.kernel.org,syzkaller.appspotmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,syzkaller.appspot.com:url]

On Sat, 15 Aug 2026 07:40:06 +0200,
Jeffin Philip wrote:
> 
> f_midi_alloc initializes free_ref to 1 and it can only be incremented
> when a sound card is registered via f_midi_register_card().
> f_midi_register_card() is only called in f_midi_bind() which actually
> performs INIT_WORK. If f_midi_bind() is never run, work is not
> initialized and the if condition in f_midi_free becomes true,
> this results in a warning later in __flush_work as work->func = 0.
> Fix this by moving INIT_WORK from f_midi_bind() to f_midi_alloc().
> 
> Reported-by: syzbot+d5fa3d224505c8610702@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d5fa3d224505c8610702
> Fixes: 8653d71ce376 ("usb/gadget: f_midi: Replace tasklet with work")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi
