Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516612C17A3;
	Sat,  8 Aug 2026 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786172523; cv=none; b=qvDpX+MH0erzYFD+/0zFsmmwTfOVUUKjoC5uoHpykg7pDkPFG3eP0G6f0KHnqYeuYDJncxXopTppaZFlyUOvsIpRr9zc4e7cy5pAjQPTqsaC0ksDa4U4noc07CLRbVZSLyqIG6JfKSpABwdrPnUieZh1E+24d4gn96fnTYzi7gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786172523; c=relaxed/simple;
	bh=NPtcK32F+ASXCbIQ30WRwmn0xCwn1jf2lvyXeqOBMPk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aK7SCHUuSyWPvM/fUeXnrqaCiqaBIGD2WVyDvqN+wcSnK6fg1/8ECYHk0p9xKbl4PZGZLDQazYQcWh7ka6vByn7UAjMCeThoM5unMz0M1BfIAdjZ7hhFaLjheQ3vBqYXYV7ZveK1Le+/S51uznx439GtGyR7fnebjhJt2bT2VSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nM9TkgTq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1N2/edNW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tg1OSycy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Sa+4ywC5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nM9TkgTq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1N2/edNW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tg1OSycy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Sa+4ywC5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 211D53F23;
	Sat,  8 Aug 2026 07:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786172516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UcycKuDX5444Y1/mgfvOKT/FF3E4vevSB714zCkG33k=;
	b=nM9TkgTqPwtn1mj/zXDW3bokzjtYkVxtTr4TsW3P68rCqZmAFnlbLjCeLKHqBcPy/sHFD0
	4rTYruZfs5YAx/HIkPF3W8Y0vHJi3icM3DLrYckk8feAmOY+BEFkYeSMkFJIM5VMNf5034
	MaUvdi2BK27l8bFCgoecUJpJ4ktqAwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786172516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UcycKuDX5444Y1/mgfvOKT/FF3E4vevSB714zCkG33k=;
	b=1N2/edNW6g+Pc4erW+wa0HwihwSoG2XjJRIFellloP1NqPWIeiE+idQ0wwNApkSKJ0f+jW
	FlOTSSES8MoyqDAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tg1OSycy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Sa+4ywC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786172512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UcycKuDX5444Y1/mgfvOKT/FF3E4vevSB714zCkG33k=;
	b=tg1OSycyvB7bOoET1g07q1PtPLz+Ws7vWvZ4jpYA5ZWDSdu8aKv16p+wSKOP4nSRQ/HmvA
	vx3p1gktda/RKr7yTU9Cyt2JtAnUAFpybyfnDKdabr7JRJRC2jncWbgUc2flMFlQWgCdXe
	DD89gRCo5sEf7JmDdeRD80NNCyU9wYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786172512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UcycKuDX5444Y1/mgfvOKT/FF3E4vevSB714zCkG33k=;
	b=Sa+4ywC5DS4KjjuwqWY65VJY4ZQyaSv6NWNWf5lexb09pccN1/5B2irrImvkl639PXnjNH
	Aj+eh9JCZAlLbuAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE156779B2;
	Sat,  8 Aug 2026 07:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z2hkNF/UdmrWNgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 08 Aug 2026 07:01:51 +0000
Date: Sat, 08 Aug 2026 09:01:51 +0200
Message-ID: <87v79l9jts.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: HyeongJun An <sammiee5311@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: ump: Fix corrupted data bytes at MIDI 1.0 SysEx to UMP conversion
In-Reply-To: <20260808014554.3550153-1-sammiee5311@gmail.com>
References: <20260808014554.3550153-1-sammiee5311@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 211D53F23
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Sat, 08 Aug 2026 03:45:54 +0200,
HyeongJun An wrote:
> 
> The cvt_legacy_sysex_to_ump() initialises only the first word of the
> output packet and ORs the data bytes into it.  The second word is left
> alone, and the conversion context is kept across calls, so it still
> carries the previous packet's bytes.  Those stale bits corrupt the new
> data.  Any SysEx longer than six data bytes is affected.
> 
> A SysEx with the twelve data bytes 01..0c comes out as:
> 
>   30160102 03040506
>   30260708 0b0e0f0e
> 
> The second packet declares six data bytes and four of them are wrong,
> inside the declared length.
> 
> The sibling cvt_legacy_cmd_to_ump() already clears the second word.  Do
> the same here.
> 
> Fixes: 0b5288f5fe63 ("ALSA: ump: Add legacy raw MIDI support")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>

Applied to for-next branch.  Thanks.


Takashi
