Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D93D170C;
	Mon, 17 Aug 2026 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960840; cv=none; b=Dth5J9JFtFh18cd4HfZr9IZqy6O4c3MIEa3htbVe/76ZpRrcV9iKaTbJpjnrIYyPbDf24TvwmZADxLJLunrvu1uQmmINVMEtrVMCjxlKRiLdnL7AJUO1FP+wJn0AKWH0hyUsyKQ8eKqrNU16gozX2xq2qviWV4f4fZ/6bIowpHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960840; c=relaxed/simple;
	bh=OCpiBkLlYK32l1khq85SLJc2JJ5UGXLLH1v2E/M84DQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZ1hCZ3y07TcyKnBtglpiv2lw5vPENxYfN21Af88ICO4wxkVZeKZd/4Yo5lFtU5Uz2t49G9HhAXiHMcZr+mgCQxP7/FEltlNBdLnr26vxldujLu2MUgqsh3RjQrL1CDvwnpp0ilSm3DfHYWNrnXK5mWVadnUBojltcSIJiNg7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zlQnDSca; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FjL+RPcR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wu5WNejd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nHU1zTEp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zlQnDSca";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FjL+RPcR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wu5WNejd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nHU1zTEp"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E8CA33E12;
	Mon, 17 Aug 2026 10:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786960821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TMaT7EPfkpf7Rh22V+CQpue3qKaJSeqR4My4A4x63oY=;
	b=zlQnDScafvo10Tg6NM4Cu5UjvjvV7+tkuSTZa0VPFflE33jbuKdmI+Sdt3crmoEzAXJEY8
	2YGo8A2mbQpAn055b4mPXixh1OKUuaI4yYhnt4ZB2bVJpM0VgIybaGlp9gFPVyP0c56hhq
	nk1rb+BJrUDUSdJ5HOBk/ooPJKrnbzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786960821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TMaT7EPfkpf7Rh22V+CQpue3qKaJSeqR4My4A4x63oY=;
	b=FjL+RPcRnxAeh77jlw7MqVTwmeKdVkyCMs2KN6WDf5PaSQu99q7Arb5epAi9sttwoNkUix
	zmeNFhCYn3I5HUCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wu5WNejd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nHU1zTEp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786960816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TMaT7EPfkpf7Rh22V+CQpue3qKaJSeqR4My4A4x63oY=;
	b=wu5WNejdikBn9IdY3ZEt8ag73Te7dzUpom236gz5dj1EC95spT8qgw85rlsrXg3gms05/P
	kQFgohbjTt56dAuFsUYYliTyO9S3PpBuZmW+v4e427gesd3jzueC+UgvZQTx4FohTd4qc5
	4l5F5kxXuY8GWZyQiqqbq5C6dXOQ82M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786960816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TMaT7EPfkpf7Rh22V+CQpue3qKaJSeqR4My4A4x63oY=;
	b=nHU1zTEpVQDTXMii6m88mu7KNA1Yu2UYSTTdrPCqed8/6+e3R3cq7UW6rGPViLIqFMzLXA
	nEq/+s6uiqnn9VAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDBD0793DE;
	Mon, 17 Aug 2026 10:00:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DYsLLbDbgmrpWwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 17 Aug 2026 10:00:16 +0000
Date: Mon, 17 Aug 2026 12:00:16 +0200
Message-ID: <87se4dkqxb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: tiwai@suse.de,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] ALSA: hda/realtek: Fix Lenovo Yoga Slim 7 14AKP10 quirk ordering
In-Reply-To: <20260817094708.222154-1-zhangheng@kylinos.cn>
References: <871pbxmb4v.wl-tiwai@suse.de>
	<20260817094708.222154-1-zhangheng@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: E8CA33E12
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Mon, 17 Aug 2026 11:47:08 +0200,
Zhang Heng wrote:
> 
> The Yoga Slim 7 14AKP10 has a PCI SSID of 17aa:38b4 but a codec SSID of
> 17aa:391a. The current quirk table contains a PCI quirk for 17aa:38b4
> (for the Legion Slim 7 16IRH8) which matches first, so the codec-specific
> quirk for 17aa:391a is never applied.
> 
> This results in the wrong fixup being used (CS35L41_I2C_2 instead of the
> correct bass speaker fixup), leaving the internal speakers misconfigured
> or silent.
> 
> Remove the 17aa:391a entry from its PCI-SSID-sorted position and add it as
> an HDA_CODEC_QUIRK directly before the 17aa:38b4 entry, because it must
> match on the codec subsystem ID rather than the PCI SSID and it has to win
> over the colliding PCI quirk for the Legion Slim 7 16IRH8.  A comment is
> added to explain the out-of-order placement, following the same style
> already used for the 17aa:38bb and 17aa:38f9 codec-SSID overrides.
> 
> With this change, the correct ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN is
> applied, restoring speaker output and auto-mute functionality.
> 
> The original quirk added in commit e6c888202297 ("ALSA: hda/realtek: Add
> quirk for Lenovo Yoga Slim 7 14AKP10") matched on the PCI SSID 17aa:391a,
> but this model actually exposes PCI SSID 17aa:38b4 (shared with the Legion
> Slim 7 16IRH8), so that quirk never matched and the bass speaker remained
> silent.  Fix it by matching on the codec SSID and placing the entry before
> the colliding 17aa:38b4 PCI quirk.
> 
> Fixes: e6c888202297 ("ALSA: hda/realtek: Add quirk for Lenovo Yoga Slim 7 14AKP10")
> Cc: stable@vger.kernel.org
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221298
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
> ---

Applied now.  Thanks.


Takashi
