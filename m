Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD592FD696
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 06:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791957934; cv=none; b=pSiW/XcUCAp8hFTCdeNQRqxK0llX407TBVCG1eoULpwNf+XW/aAz3Yxq3prEBgkqqzdcVBp4OL6DwDCkjzMQxRjNKyR+/peT3gIBHCrn8gaP1wGJfIWYEAqHHKCW6/h/XyeLlhT4tGw4MloqFbAYzpJNrAawHvWEpe1j1nhX/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791957934; c=relaxed/simple;
	bh=0bjJWtnXgkO1xqsj7xvqXgreSl4mdvXzA0YjIJYftOU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZIi8TOPYzHyQ/NnhwQfU9QAXcTI/OlGKae57Yans6q+ZO95KvilOccLKCoA2K2DbCYjbUNfursLChvIEgwidZzxxx4A6fXdBUXLhj2VC6J8MwvDsL3oqdUcL+/YukWAM3H6aGqEIdQ40jBlHkCt5VbxOGe1xCTdRO1QzfWV3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1gQ/J4fp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QhUNmB61; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1gQ/J4fp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QhUNmB61; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1gQ/J4fp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QhUNmB61";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1gQ/J4fp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QhUNmB61"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 18A5A21EB1;
	Wed, 14 Oct 2026 06:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791957922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pl0reobp6/wGE/7iwNDlh/N7ukMCE6Hco1HZqmAUMfM=;
	b=1gQ/J4fpQXTPmPP3Nlqq6b9y5s/pReZQE4p+rcTlCnPicboiTFegGBb1vvN/MykNdwtSYF
	3pAW/gm8FfJ17aDPnO7dSH9EMyWAdQUNqcAqeay12GMNhE9L5CsQ4wzz9gb3/4h0y+6Iaz
	uiQsXMzV4WUmIHvqOvYcUb6TmgOwmf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791957922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pl0reobp6/wGE/7iwNDlh/N7ukMCE6Hco1HZqmAUMfM=;
	b=QhUNmB61AkvUIZa24k4bUKM23FFNn/VYEjHTSVik4wQikAaaosSbFsVQvg2SJ/m8RgieaZ
	DDXiJ8PYyXX68lDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="1gQ/J4fp";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QhUNmB61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791957922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pl0reobp6/wGE/7iwNDlh/N7ukMCE6Hco1HZqmAUMfM=;
	b=1gQ/J4fpQXTPmPP3Nlqq6b9y5s/pReZQE4p+rcTlCnPicboiTFegGBb1vvN/MykNdwtSYF
	3pAW/gm8FfJ17aDPnO7dSH9EMyWAdQUNqcAqeay12GMNhE9L5CsQ4wzz9gb3/4h0y+6Iaz
	uiQsXMzV4WUmIHvqOvYcUb6TmgOwmf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791957922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pl0reobp6/wGE/7iwNDlh/N7ukMCE6Hco1HZqmAUMfM=;
	b=QhUNmB61AkvUIZa24k4bUKM23FFNn/VYEjHTSVik4wQikAaaosSbFsVQvg2SJ/m8RgieaZ
	DDXiJ8PYyXX68lDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C5641368E;
	Wed, 14 Oct 2026 06:05:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KDETJaAbz2pjHQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 14 Oct 2026 06:05:21 +0000
Date: Wed, 14 Oct 2026 08:05:20 +0200
Message-ID: <87h5iog6lb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?Iv=E1n?= Ezequiel Rodriguez <ivanrwcm25@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	Kailang Yang <kailang@realtek.com>,
	Naser Al-Asbahi <nasserqahtan0@gmail.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: keep headset mic on Acer SSID 0x1640
In-Reply-To: <20261013204219.9649-1-ivanrwcm25@gmail.com>
References: <20261013204219.9649-1-ivanrwcm25@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 18A5A21EB1
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
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,vger.kernel.org,realtek.com,gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Score: -3.51

On Tue, 13 Oct 2026 22:42:19 +0200,
Iván Ezequiel Rodriguez wrote:
> 
> The micmute-LED quirk for the Aspire A315-44P matches PCI SSID
> 1025:1640 before the Acer ALC256 pin fallback. The Aspire Go 15
> AG15-42P shares that SSID and leaves nid 0x19 as 0x411111f0, so
> selecting the LED-only fixup drops the headset-mic pin remap that
> the fallback would have applied.
> 
> Chain ALC2XX_FIXUP_HEADSET_MIC before the GPIO3 micmute LED on that
> SSID. Leave the Swift SFG16 entry (0x169a) unchanged.
> 
> Tested on Acer Aspire AG15-42P (Callisto_BCU): PCI pick 1025:1640,
> Headset Mic=0x19, GPIO3 enabled with no physical micmute LED, speaker
> and capture paths functional.
> 
> Fixes: d830631a128b ("ALSA: hda/realtek: Add micmute LED quirk for Acer Aspire A315-44P")
> Cc: stable@vger.kernel.org
> Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>

Applied now to for-next branch (with a correction of
ALC256_FIXUP_ACER_HEADSET_MICMUTE_LED enum position, so that it can be
cleanly applied to stable trees).


thanks,

Takashi
