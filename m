Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3363EB0F5
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728347; cv=none; b=EfGA4qz2SG5XCSvD06MSQTLjwGAxUTJezksTUdhoHRcnQAz9oQkNgUzpp6UkV84IIWxGpvhBCZE08CM57NZbF68//qAv+0zaTEFqvNSEAYFfw9qUUdOhl+sZh+FCRuHMOQwQ04HgKzbzvsN9CjSPupBgMZZPBoU36E2G++93IuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728347; c=relaxed/simple;
	bh=0kreSd55Mg20LS910ypPNq6bivAtOIE+vYsYkASCNnA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVdET5UoCif2zPkZzZQNyGawwaMYkTRmYWtIYKSO1OZdFiWIhqhNXDk5mCNQZlpoWZ7uXPlL8JXzWzpyvh/+xWbmgFLyT13rek3xJfVN1Qoc73gPHHc8jseXnv2o5+LWCF/Lyme1Qt8v/fU++6shS21lNGP7bCgvPjQnddonB4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0m8vXRIM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aBp2k8ul; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0m8vXRIM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aBp2k8ul; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0m8vXRIM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aBp2k8ul";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0m8vXRIM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aBp2k8ul"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C1FC75D7C;
	Mon, 29 Jun 2026 10:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782728343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kJ9s+qtSTB+ZD2S2XRPhm6T3dysnhqX/geMXd2UJGi4=;
	b=0m8vXRIMHwzsWseiRDCl5o3zsKtjE6TtqCu0X9nNTsI38Dn0eybO4wWn0pmx12NNVJFQXm
	7aGYrTarULmINJNwradDgHsIIRUeOg/+OsfPP4b4jUjJrjxYm73+A67tsMk83EhqUgpaJy
	G3i8L5mqtaNJ+mFVyCzctcSHP3h3BrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782728343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kJ9s+qtSTB+ZD2S2XRPhm6T3dysnhqX/geMXd2UJGi4=;
	b=aBp2k8ulb1s2V8lSl8NU48V/ArNm+l6Dr1s6xfYqOx4dmQ8picGDNempHycAcnM0PvyeED
	of86LIe7WmZOXFAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0m8vXRIM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aBp2k8ul
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782728343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kJ9s+qtSTB+ZD2S2XRPhm6T3dysnhqX/geMXd2UJGi4=;
	b=0m8vXRIMHwzsWseiRDCl5o3zsKtjE6TtqCu0X9nNTsI38Dn0eybO4wWn0pmx12NNVJFQXm
	7aGYrTarULmINJNwradDgHsIIRUeOg/+OsfPP4b4jUjJrjxYm73+A67tsMk83EhqUgpaJy
	G3i8L5mqtaNJ+mFVyCzctcSHP3h3BrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782728343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kJ9s+qtSTB+ZD2S2XRPhm6T3dysnhqX/geMXd2UJGi4=;
	b=aBp2k8ulb1s2V8lSl8NU48V/ArNm+l6Dr1s6xfYqOx4dmQ8picGDNempHycAcnM0PvyeED
	of86LIe7WmZOXFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38E89779A8;
	Mon, 29 Jun 2026 10:19:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fLCKDJdGQmrYEwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 29 Jun 2026 10:19:03 +0000
Date: Mon, 29 Jun 2026 12:19:02 +0200
Message-ID: <878q7xr6nd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	ramiserifpersia@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] fix: sound/usb/usx2y: capture_urb_complete: redundant usb_anchor_urb corrupts anchor list on each resubmission
In-Reply-To: <20260627042949.61767-1-vulab@iscas.ac.cn>
References: <20260627042949.61767-1-vulab@iscas.ac.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,gmail.com,vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6C1FC75D7C
X-Spam-Score: -3.51

On Sat, 27 Jun 2026 06:29:49 +0200,
WenTao Liang wrote:
> 
> In capture_urb_complete(), usb_anchor_urb() is called on every
> completion callback, but the URB is already anchored from the
> initial submission in tascam_trigger_start(). Each redundant call
> corrupts the anchor's doubly-linked list and inflates the URB
> refcount. When usb_kill_anchored_urbs() traverses the list during
> stream stop / suspend / disconnect, the corrupted list leads to
> use-after-free.
> 
> Remove the redundant usb_anchor_urb() from the resubmit path.
> 
> Cc: stable@vger.kernel.org
> Fixes: c1bb0c13e430 ("ALSA: usb-audio: us144mkii: Implement audio capture and decoding")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

Applied now.  But, at the next time, please try to adjust the subject
prefix; for sound/usb, it's "ALSA:"


thanks,

Takashi
