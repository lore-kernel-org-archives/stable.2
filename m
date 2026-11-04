Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804599;
	b=akkQSB/L6fQzS9AgdgGKpcqm6imYJ4oKFv2IgseNYgqtxiNGSuc36L7lZ3X9c/vLl9I2
	 8WWOe5k6E/EdMHxV8oN0hoUNyA1NlZM+Q7abefgX8xTyfFf8HjQFdLoBcPt0IYjXQ+pQg
	 2CdRbN/xiuzEyDjUCTGNVEPGPm2XAczZPlFYez7cF6BqQ6Qw6TkX29sXQ+8jbJ+zmAqEa
	 j0bElVYCfm6nIr/Jd0OvD+AEsKDCCr6UKZE7BNLnCIPrR9RgtXpqeph9w2TFwtQKQCf4j
	 00Uc+WjmPrT1wp+fsLRlZqxlwCpGxj3Aghx6wMOQtyt2YBGVMH/0oulS57TCNwHTdog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804599;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=+P5gL9m6Jyb/Bky3cak3kQaT6qa1hpJwvcCZC+IMB28=;
	b=Q0C60VdeZJ9EZTwE2AE2T8wWjfhy90JM0qRabulbafqA4WdngQTpfnOhWUcjRvZ7FQB6
	 mDAQGlHny53NOn4RGcv43oJ3x1KKiOdxtn2wtgQg1g4mrVgn1f2QawOpPDitE1nfFDnwg
	 N2s5Vzq+crLlHYHTH0OJ9xLzzLPY0zTfidGJwrAkZUFuT1sav8XDC23S6FVwFJzmR44a+
	 VRYSnJsl3qNlo+rXp5+4ZCbRBDe1t34MGDzN4VVixqR7biIQcPJr8bsZ0LUY9Ygk0XyjA
	 m66sWKG/1cRfKe1FbvTEumfrD5KtmothSn4bcihIzCZ3i8cYjUIpglaLGW/jI5MOxdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tDM5kKq8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nw2J5e2F;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EdRE7sou;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7myMNNSZ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AD3606A328;
	Wed,  4 Nov 2026 15:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61AD3606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tDM5kKq8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nw2J5e2F;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EdRE7sou;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7myMNNSZ
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C9D8A1F7DD;
	Wed,  4 Nov 2026 15:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793804591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+P5gL9m6Jyb/Bky3cak3kQaT6qa1hpJwvcCZC+IMB28=;
	b=tDM5kKq8pf8GVfG9fOExlLk1TxNLOOappoytcpGAHjvDV3oTSsku1yW4s2AjXedCH4Jhsn
	MJEYKrAWjVQy1GLbT4erjNQR+7Km4m3f57fx83jaCDdFxktPwsgtiC5SYDed+hE/8Pzmuv
	PvoaDr03dkE5Z7NfhhhOvFOR9g009uY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793804591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+P5gL9m6Jyb/Bky3cak3kQaT6qa1hpJwvcCZC+IMB28=;
	b=nw2J5e2FUgZeWlBJM3rxi9aQdLWKEM/kgGKqM1TQ7MCEXMbBqFJRM6fsjACKzNRwAQ5MgE
	HzNDh7I/wPV42ODg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EdRE7sou;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7myMNNSZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793804588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+P5gL9m6Jyb/Bky3cak3kQaT6qa1hpJwvcCZC+IMB28=;
	b=EdRE7souunZDZuLHhjG3578kCbOX8zfp5ad7pke8lJFhSuHw0sV/8gRF8L8aCK3lBpuP0K
	uTWSuRSmdNdVyRLBhFNum9jbpwRmEPBHG/T2MFtlcLeIaU4hi6kp+5q+67ajSoNzAy38fD
	1FpvQV4NUPJnZT6fRp0UQ9Tajk5ak1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793804588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+P5gL9m6Jyb/Bky3cak3kQaT6qa1hpJwvcCZC+IMB28=;
	b=7myMNNSZInCmi3MKr9n2P4XJRcdgWiUcWOc1yrAUETx6ilqNUm4MPtgffPYNsEDBZKdQdA
	H8tLzvTyZWYNJ2Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7912F134A5;
	Wed,  4 Nov 2026 15:03:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g+XYEyxJ62pmEwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 04 Nov 2026 15:03:08 +0000
Date: Wed, 04 Nov 2026 16:03:07 +0100
Message-ID: <87qzh0tz9w.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sinan Turunc <enscrpt@pm.me>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v4 0/2] ALSA: usx2y: Bound the PCM buffer by the URB size
In-Reply-To: <20261104122136.1518-1-enscrpt@pm.me>
References: <20261104122136.1518-1-enscrpt@pm.me>
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.51
X-Spam-Level: 
X-Rspamd-Queue-Id: C9D8A1F7DD

On Wed, 04 Nov 2026 13:21:52 +0100,
Sinan Turunc wrote:
> 
> v4 of the usx2y buffer fix. Patch 1 changes only its comments and the
> nrpacks note in the changelog. Patch 2 now also sizes the playback ISO
> descriptors from whole frames, after the review of v3 found that they
> were filled from the raw capture actual_length while
> transfer_buffer_length used whole frames, and gives the maxpacksize
> check its own message.
> 
> Patch 1 replaces the two-packet BUFFER_BYTES bound of v2 with a
> two-URB BUFFER_SIZE bound in frames that does not read the endpoint,
> and keeps the capture drop guard. Patch 2 adds guards in the playback
> prepare path for a URB larger than the buffer and a packet larger than
> the playback endpoint's maxpacksize, and sizes each descriptor as
> counts * stride, all pre-existing and unchecked.
> 
> Tested on 7.3-rc7 with a USB/IP device presenting the US-122 interface
> layout. The playback case of patch 2 reproduces on the unpatched driver
> with ordinary 48-frame packets and a 100-frame buffer, which the stock
> constraints allow. With both patches, buffers below the bound are
> refused at hw_params and 400-frame buffers stream in both directions
> with no KASAN report, for S16_LE and, on capture, S24_3LE. With
> 195-byte capture packets the descriptor sizing of patch 2 shows through
> USB/IP's completion check, which refused the v3 URBs (descriptors of
> 780 bytes for 768 bytes of data) and accepts the v4 ones. The results
> are in the patch messages.
> 
> Sinan Turunc (2):
>   ALSA: usx2y: Require a buffer of two URBs
>   ALSA: usx2y: Guard the playback copy

Applied both patches now.  Thanks.


Takashi
