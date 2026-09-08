Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9B12DA749
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877527; cv=none; b=PzuwKGYCyCE4ELoSxfypkHQoPigdbeYO6wCUIf3EdVKwlLj00JnNTHtrktWk87FFCRl1G3XHCKfHeD8xCgQrAdv0hVIgSUeWWpX/kR1+fQn6JyVwFQMJXWBk60NMFXc/fl7GzbAbBEV1JaQLQC7jlhcJzm1fN1FziyoOsUZR9co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877527; c=relaxed/simple;
	bh=0zTWRMOSrIPyxHH4DhfPpkrmaXsO0+MIuSmvP0/RniY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nc9uoc9sxwiNVeaHGzPpxRiOQ8evZ7Z+pUMkJbhKrijrJWbOqZRXqTLqoKWi77l0+EsuzDPplrxKQ5ZMgiDP7OBvjc5+aPUft4Di6BqrfJJFMPe/FduFBc2JqecS8LQOVm/Fx1/7Ur3Hog84F7/lJmqPH4vCf2pDj9arnICt24c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w3sGhBk0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hwD3ytoY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eJYsAkg0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q3asSZUQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w3sGhBk0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hwD3ytoY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eJYsAkg0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q3asSZUQ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EA7D521ADF;
	Tue,  8 Sep 2026 14:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788877489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHJKGSD2nFK/r/6f73cKpn6t2cf00+z7JQKS548yRy0=;
	b=w3sGhBk08adRcOYfsOAa5bJwIaDpeCMdy/oP3XnrsrMTW1rD9O3l+FEXOhsICqiCJOzz8b
	mCvSbcPkKM3BqFkJXQynZzT248uX/AHA720tAbeYdyxL9+gQ+Ghd/09UWZJBkuDMjLMJZs
	IWvNj2RbP58mouFOnmrb2NfH0nUP4Xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788877489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHJKGSD2nFK/r/6f73cKpn6t2cf00+z7JQKS548yRy0=;
	b=hwD3ytoYukqf1ABQS9gMwWY0Rj7qs/UtkR+FRNrGh2pUQp5PE0c92i2jeM4NwIuilHsQ07
	hCKmTbhE9bfQzKAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eJYsAkg0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Q3asSZUQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788877484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHJKGSD2nFK/r/6f73cKpn6t2cf00+z7JQKS548yRy0=;
	b=eJYsAkg0GEpmeTUKR9aXVqBdhNnq8tDwsHQh1JwUP7unnAV9GnUCaLoX34zz49DFUH8eF7
	H9QNW52tcP8VZOUg3jOINoXxtjXnQWd/Adfe+Orsj1tD+Z1yWew5s6xk2DG8pTIhER6k+1
	Xh1CQO4e8Q44A462WJtcZ9vC7qzUmV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788877484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHJKGSD2nFK/r/6f73cKpn6t2cf00+z7JQKS548yRy0=;
	b=Q3asSZUQHNAxn4o6t6CDBr0zCkhEv9kDY1V+iifBodboLftNQGwoFbLgrntoogjXANTlsf
	MfLYCLDck778lFAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD5701364A;
	Tue,  8 Sep 2026 14:24:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j+2qLawaoGq3BwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 08 Sep 2026 14:24:44 +0000
Date: Tue, 08 Sep 2026 16:24:29 +0200
Message-ID: <87ik4fq0rm.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kazuki Hanai <hnkz.64@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: us122l: Prevent write upgrades for read mappings
In-Reply-To: <20260908110053.2950767-1-hnkz.64@gmail.com>
References: <20260908110053.2950767-1-hnkz.64@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -2.01
X-Rspamd-Queue-Id: EA7D521ADF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Spam-Flag: NO

On Tue, 08 Sep 2026 13:00:53 +0200,
Kazuki Hanai wrote:
> 
> The hwdep mmap callback rejects read-buffer mappings that are initially
> writable, but leaves VM_MAYWRITE set on mappings created with PROT_READ.
> A process that can open the hwdep node O_RDWR can later use mprotect() to
> make the mapping writable.
> 
> The read allocation begins with struct usb_stream. Its read_size member is
> used by the fault handler to decide which pages belong to the read buffer.
> The read VMA intentionally remains expandable because pcm_usb_stream uses
> mremap() after reading that size. Changing read_size first can therefore
> map and access pages beyond the allocation. The same member is also
> consumed by usb_stream_free(), where changing it can make
> free_pages_exact() release pages outside the allocation.
> 
> Clear VM_MAYWRITE for read-buffer mappings after rejecting an initially
> writable VMA. This keeps the separate output-buffer mapping writable while
> preventing later permission upgrades.
> 
> Fixes: 030a07e44129 ("ALSA: Add USB US122L driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>

Applied now.  Thanks.


Takashi
