Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE2F381E8F
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783937144; cv=none; b=T3tWiw7FUhE7c0IyPeV3QrJTClZD8y2KLNmQN+2/Vg/heolePclVw4LjIVjSpeS9P09bsgmWs41xLoz9p0AxLCE0vVHZVZzDyGlAYlNxnT2xFRRpJl0AsVUutip5554AWX4lcMvNnjF8/Huw7+RyGmu4szEiHfj0ocFBFUAkb/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783937144; c=relaxed/simple;
	bh=CWUjlakXHUNq91p+MX+0FoYHSkSJ5N4I219o9rDMv5s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlCHVb1tbYSiTZ+G+fc6IOpidZSM2t1EMsEZctORNriSFT6Z4MjHV7v+1WeW+dnQNvtWWfPgi2856Obv1ZcEd6V1WzuLtw5q2S9M4gDfVbjyXW9KbwGB2cEVP2Kosvlk4lvkkPEyrzjoNMT/RVA+8mZuL7ikGmDAE1+DiHWVHVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j79GI0X1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jSEGnLrX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CC10pH/C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K1D1TaoP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j79GI0X1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jSEGnLrX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CC10pH/C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K1D1TaoP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F176A774D8;
	Mon, 13 Jul 2026 10:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783937141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OC54V+i9Zl30wrHXbdGiyL0OWpwGu7v7FYGc0CYHgZM=;
	b=j79GI0X1OwBx8vfwg8hKTgyTqcNQIeGZmZMlNyGoDS/os5DidRzUFYAFQxUxcgwYfuUlho
	SkL2SktP7gwCdZpxfdfQwcNspaFDkYycR+AeFNIBC8NxIsTCCWy87zotibRzhBMXaNbr07
	lAc+0XmWiF3zK19mdEl6WGJ9gQ+2oX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783937141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OC54V+i9Zl30wrHXbdGiyL0OWpwGu7v7FYGc0CYHgZM=;
	b=jSEGnLrXvvPGazBkBIUyPepCGICx4OPsrvct6mpaAaLXKi/uScGvaZVKhfaXH3xelF+bKV
	7IiupEkQGrDJGsAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="CC10pH/C";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K1D1TaoP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783937140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OC54V+i9Zl30wrHXbdGiyL0OWpwGu7v7FYGc0CYHgZM=;
	b=CC10pH/CcRkXI2SUP2m/7VYRu0AZpPSqQXV1S82RNl8gj1NGV6l9UGT3mEJAX1ixyH/j0D
	PNBonjgQ3OI71YsqgcWfU2Gx5lHYPCcEWvX7uQ0VBFjsd2ZzzUasbQQu0txp8TvheHBM0X
	zGz1S7zJXv9UWByUEBhj9gp+m9OtlWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783937140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OC54V+i9Zl30wrHXbdGiyL0OWpwGu7v7FYGc0CYHgZM=;
	b=K1D1TaoP7Oh3YH6OUcsVqjSq14s0OnMBdEPZhGScXcAo1tHOdNDR+Xk+eB6GpRfY1lAZzh
	523o0WzDSbFIhpBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0839779AE;
	Mon, 13 Jul 2026 10:05:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QpiDLXS4VGogHgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 13 Jul 2026 10:05:40 +0000
Date: Mon, 13 Jul 2026 12:05:40 +0200
Message-ID: <87se5nyzkb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Damien Laine <damien.laine@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Fix speakers on Legion Pro 7 16ARX8H with codec SSID 17aa:38a7
In-Reply-To: <20260712213708.1835469-1-damien.laine@gmail.com>
References: <20260712213708.1835469-1-damien.laine@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F176A774D8
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Spam-Level: 
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Sun, 12 Jul 2026 23:37:08 +0200,
Damien Laine wrote:
> 
> Some units of the Lenovo Legion Pro 7 16ARX8H (82WS) report codec
> subsystem ID 17aa:38a7 instead of 17aa:38a8. Since only 38a8 has a
> codec SSID quirk, these machines fall through to the PCI SSID match
> 17aa:386f (Legion Pro 7i 16IAX7) and get ALC287_FIXUP_CS35L41_I2C_2,
> which probes the Cirrus amplifiers of the Intel variant. The TI
> TAS2781 amplifier (ACPI TIAS2781:00) present on this AMD variant is
> never bound and the internal speakers remain silent.
> 
> Add a codec SSID quirk for 17aa:38a7 pointing to
> ALC287_FIXUP_TAS2781_I2C, mirroring the existing 38a8 entry.
> 
> Tested on a Legion Pro 7 16ARX8H (82WS, BIOS LPCN62WW): with the codec
> SSID overridden to 17aa:38a8 via the HDA patch loader, the TAS2781
> amplifier binds and the internal speakers work.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Damien Laine <damien.laine@gmail.com>

Applied now.  Thanks.


Takashi
