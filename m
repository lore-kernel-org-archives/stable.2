Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424594;
	b=VegsrDbvVkur9z0GkkIirsQoOaxEzxVdRu5Q6n3jIXq+j6Py4KmuZ6Qzl6hQwL5HFvHF
	 7R1ppYeiZJagewJ9Qfw/UU2ig/0KYUeQeTF9Uq8FjwvXdadKQmSbQHFlM2VyXGKqBwReu
	 lDomFd+9Ls4I2R9mm0mrv5wZpWTxnvGLJS6Ol2Ne9osYuqd3CEF71mMWPVA0hElJya68b
	 vScnIF8Rv9zHK8o2CvIBj43Tiz5/OTLvCFE1leUhUzlQBjOEarv22ohZldPlb7W0eMkOu
	 Oon65sG0p7/rSerZkjaTy/b9qqNbXIL/+WMZ11Q+yoexUST+NzeutRBRwlbi5VYjDJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424594;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=cIH97X8UXW0rRrMtUujdb87OCK5+AyePt7eIPmnRob8=;
	b=XvWlB0H3od+7+INMHH/iG+jqSHRbRobU2SnYBn2c0Ey555tsjQWP5kyoXAYVqg/7YuuZ
	 zf5MLDQYg89m/PKCVD5145ioGjqXXG/EUZdKx3sNQlkpY6ICffWhNl1JIMVrvG34EvFHc
	 rFtB4ot2WARg/zqNyFCciOuu2ZyEbv9XYkkbSECnAjJKs0e3Kni83pLHWphhB7Yry/n0h
	 jf4ocXcfg0WEFYKFtYWgkuwTpZDYhOnmXO4Zz+4bee2+3/Z32MJFOnXmnzp2dojKB77+3
	 RupgUt9JZQE94UaeRNgiuAv8PDCa4bJsltAwRAnemwtW1RruXIaRJ8DSF342jUge3Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rvg7vokS;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CWGparYQ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rvg7vokS;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CWGparYQ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDE6606A321
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 09:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFDE6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rvg7vokS;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CWGparYQ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rvg7vokS;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CWGparYQ
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 85D9A1F7E5;
	Mon, 23 Nov 2026 09:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795424584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIH97X8UXW0rRrMtUujdb87OCK5+AyePt7eIPmnRob8=;
	b=rvg7vokSjd3dODkkeg9srkOQTIZ/xb9FYojTPp0/3euWtqkYSPxzPYfQTR2ds8mX/cX7wj
	Zn9YgVcmp+zbNOM9UXUQojF7Yl3Ctj+xrDnBAlwwvOvVVfk1Is1iokOaYmChBDRh6vyFJy
	j5Vdv10w2mqh/q/UNSP6N9m0+0mZM9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795424584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIH97X8UXW0rRrMtUujdb87OCK5+AyePt7eIPmnRob8=;
	b=CWGparYQfYzXka4Gp40GaiSeqO7ryjiu5/U1Jpek3r6u7zzyYFePVqWEisPGtRfHi8viPc
	aSUv+9nOTUhsEbDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rvg7vokS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CWGparYQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795424584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIH97X8UXW0rRrMtUujdb87OCK5+AyePt7eIPmnRob8=;
	b=rvg7vokSjd3dODkkeg9srkOQTIZ/xb9FYojTPp0/3euWtqkYSPxzPYfQTR2ds8mX/cX7wj
	Zn9YgVcmp+zbNOM9UXUQojF7Yl3Ctj+xrDnBAlwwvOvVVfk1Is1iokOaYmChBDRh6vyFJy
	j5Vdv10w2mqh/q/UNSP6N9m0+0mZM9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795424584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIH97X8UXW0rRrMtUujdb87OCK5+AyePt7eIPmnRob8=;
	b=CWGparYQfYzXka4Gp40GaiSeqO7ryjiu5/U1Jpek3r6u7zzyYFePVqWEisPGtRfHi8viPc
	aSUv+9nOTUhsEbDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 384451352B;
	Mon, 23 Nov 2026 09:03:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id STu9BEgBBGvMCAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 23 Nov 2026 09:03:04 +0000
Date: Mon, 23 Nov 2026 10:03:03 +0100
Message-ID: <87tsl7dins.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: abhirajdutta7@gmail.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for HP Spectre x360 2-in-1 Laptop 16-f2xxx
In-Reply-To: <20261122-hp-spectre-16-f2-quirk-v1-1-2011ef8986fb@gmail.com>
References: <20261122-hp-spectre-16-f2-quirk-v1-1-2011ef8986fb@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 85D9A1F7E5

On Sun, 22 Nov 2026 23:02:47 +0100,
Abhiraj Dutta via B4 Relay wrote:
> 
> From: Abhiraj Dutta <abhirajdutta7@gmail.com>
> 
> The HP Spectre x360 16-f2xxx (SSID 103c:891e) has the same speaker
> problem as the 14-eu0xxx and 16-aa0xxx: the BIOS marks the treble
> speaker pin 0x14 as unconnected, so only the bass speakers on 0x17
> play. The mute and mic-mute LEDs don't work either.
> 
> Use the existing EU0XXX pin fixup and chain ALC245_FIXUP_HP_X360_MUTE_LEDS.
> The mute LED is on COEF 0x0b bits 2-3 and the mic-mute LED on GPIO2
> (active low), which is what that fixup already handles. Unlike the
> 16-aa0xxx, the bass speaker amp works without toggling GPIO0, so the
> EU0XXX variant is enough.
> 
> Under SOF the PCI SSID on this machine reads as 103c:0000, so the entry
> is matched against the codec SSID.
> 
> Tested on a 16-f2xxx: all four speakers play and both LEDs follow the
> mute state.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhiraj Dutta <abhirajdutta7@gmail.com>

Applied now.  Thanks.


Takashi
