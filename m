Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2A8349CD1
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788681784; cv=none; b=F2giZ5sTiY4mj5q+gBup+ISYHj7rNvWnfBHqFatpXRO+jAcXV7TuYHhByVyset5yAQULBkJpR66qnxGYXxahflrvyb04WUbrMZG2Ajm6AIs1kOZ9b66rTJFyWxLvYc1E5pEHb1D5ESzy4Cj0rJuBFtBqC9M5HsGurJRc25N3OhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788681784; c=relaxed/simple;
	bh=BWJG8hgiwvIi26aZFTgv5NewxMednrzjP9lQUJfSwzc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+Npg3D4ZD0HQCqC6eXr9sfetcyYazWAB8i1i0sci3r9RtIsGMZETezDmXb2kL6ZPLrsaabKkuS3dEXC/s/Xw2H35vjz6PZmdhP7KsDWZUpPWnHEFA1T1La+kgCDL9EicPzX6PtAfA8FaelpoK1zEl99EvZVSUzFerPY1xdxZg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aVI+iROU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RACOOrgA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ae+jJ9PZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c00BUmNq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aVI+iROU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RACOOrgA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ae+jJ9PZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c00BUmNq"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BCFB3222D4;
	Sun,  6 Sep 2026 08:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788681768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=67Fv1jILZAUwM1g0mfsgzMgEA0VRopTihuzg0i7Amlg=;
	b=aVI+iROUav9KjPRzfhn7Bm4eQ4x7WFTNh1FYgbVMIyyS/ZuFaBxjwm1FSLU0TB/6WBOK7z
	Ln9PnIQ1yzeDiLIBQ+5SHM38Yz5uZhvexyeOyB56Zjab2nExj4s7rPieg3q/Jcofq9VaLT
	1vynERw0PSefad4tv/wFRcLR49Ddv64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788681768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=67Fv1jILZAUwM1g0mfsgzMgEA0VRopTihuzg0i7Amlg=;
	b=RACOOrgA34Wb2Rm93s/kmMiUx6zDuuKLvv3+o/qtV2xUkjMqE8DA7yrITBNMt2yqNeOWir
	ITO7LJK3hxrJDYAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ae+jJ9PZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=c00BUmNq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788681764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=67Fv1jILZAUwM1g0mfsgzMgEA0VRopTihuzg0i7Amlg=;
	b=Ae+jJ9PZ9AZ+mHFhkReGf2W4anh08WRMWhBfVbHavKopiQJfN4/JmGJ6oNBT4JOw8RjLmE
	BpvuW2DkhgcPQPv51jsqT0q8U4dXarVFV/EmOvOU9gWvHDdbPCClhedAErxinSd6w1RPh4
	w9T+mPNNppVd5nVQgmxNZag4pybz6bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788681764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=67Fv1jILZAUwM1g0mfsgzMgEA0VRopTihuzg0i7Amlg=;
	b=c00BUmNqHaXJsnpp8/PrLf1FNGS/lDQjYy/vEN7tIrQIEmgwHZzu3Sn6c+ePbnccO0aVgn
	cMUH++VHLrda3UBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6091D13432;
	Sun,  6 Sep 2026 08:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X6c+FiQenWqeaQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 06 Sep 2026 08:02:44 +0000
Date: Sun, 06 Sep 2026 10:02:43 +0200
Message-ID: <87ld9e4xjw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: zorgan.roman@gmail.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: ctxfi: Fix CA20K2 S/PDIF passthrough
In-Reply-To: <20260903-ctxfi-spdif-conf9-fix-v1-1-5e4e3e1f801c@gmail.com>
References: <20260903-ctxfi-spdif-conf9-fix-v1-1-5e4e3e1f801c@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -2.01
X-Rspamd-Queue-Id: BCFB3222D4
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,gmail.com,suse.de,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Spam-Flag: NO

On Thu, 03 Sep 2026 23:14:44 +0200,
Roman Prucha via B4 Relay wrote:
> 
> From: Roman Prucha <zorgan.roman@gmail.com>
> 
> dao_rsc_init() encodes the DAIO configuration as
> 
>     conf = (desc->msr & 0x7) | (desc->passthru << 3);
> 
> S/PDIF passthrough uses msr=1 and passthru=1, resulting in
> conf=9.
> 
> daio_mgr_dao_init() masks conf with 0xf, but handles only values
> 1, 2, 4 and 8 when programming ATXCTL_NUC. As a result, conf=9
> falls through to the default case and leaves NUC at its previous
> setting.
> 
> On a Creative X-Fi Titanium HD SB1270 (CA20K2), this breaks AC3
> IEC61937 passthrough when snd_ctxfi runs with
> reference_rate=48000,multiple=2. The receiver detects a non-audio
> stream but cannot decode the AC3 payload.
> 
> With the unmodified driver, multiple=1 makes the same stream work.
> Handle conf=9 through the same NUC=0 path as conf=1.
> 
> The change was runtime tested on the SB1270 with multiple=2 using
> IEC958 stereo PCM, pre-encoded AC3 IEC61937 passthrough and ALSA
> A52 live 5.1 encoding.
> 
> Fixes: 26a9630c72eb ("ALSA: ctxfi: cthw20k2: fix mask on conf to allow 4 bits")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Roman Prucha <zorgan.roman@gmail.com>

Applied now.  Thanks.


Takashi
