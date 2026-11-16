Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794831478;
	b=X5ytdyyMaXjJbzYmHwGe74NCccaa9JvqH1cB11aI7hFym8y4CdINmgAIGHEudIlI3PZS
	 Rme04L99lYSV6KzeAGUAzMtTqnzTNv1bCn9nqwo/PqZPgNVGKObIgvNwirxstjOiMOPgl
	 v8HR8B1mBR3rjCCUKrji0Ga/I916yXGp44Yg051EA3TZIsRIk+JPPpfpDYzHOTRJqg1pm
	 weuXaFWogEakO2xgtPosiQiXFFM9t/lr7+YPt9Tol34uufjrif69VhpotPQgGL3yJ5rBq
	 /lphQS0XXNc05pNflKQ0NedoV/rg+lU62lkuf+Ns/0sZuqiJ3lXYW9FF2kzUZQuF9pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831478;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=iYmNMjvL7eqXS0nOpp2ykcQs55RTDoJm1RUBdh5TpA4=;
	b=lHBYQOigfCq/RH/H88clrO+tuNvcKUTjVesFoni2EqoH/8GHySb/WODCynU9D3RJzhLK
	 3HZ5GNSOdlO43fuHXajGwwW0QeACX2BJyBztowHvT7ma3Qs7ghdLEdaHzY+51ftkPCKdZ
	 yRfXelWJHKCsTrl4drbU7Q+w1p/V/tPHjA16F/oYs8uw66j9bOmgIaq7kztiJoXpIRlgD
	 7c/P1r5ETfyWszv6co5eUSULVT4nLble2CruU0tt0hz2u+LBOlN64RC5Sh3/CT3IO1mLU
	 1LJZzfwnV6aD5Y0yYjAI7Tv+4sBqoOcGbfcmF4/XQuDp544XIH7YTJwaJ7kYETxFuDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=d0g9Cl6O;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dwqtrSqP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=d0g9Cl6O;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dwqtrSqP;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61112606A32F;
	Mon, 16 Nov 2026 12:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61112606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=d0g9Cl6O;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dwqtrSqP;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=d0g9Cl6O;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dwqtrSqP
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F67B1FBA8;
	Mon, 16 Nov 2026 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794831476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iYmNMjvL7eqXS0nOpp2ykcQs55RTDoJm1RUBdh5TpA4=;
	b=d0g9Cl6OXgaASlNcbqWMPR2+9XybqQ/HVrowoyg8gFNE4MvRU++8pMCGJt0Yfb1wrKF6rP
	h8yfdcFSvHnjNTwHWteWRJ//H7rLg6z0ZTezgvJPExuuS5OdRqGSI+82S/D6woEjQZr8Us
	Rl+aFXAU/AF2LLQnIlHFSM87Vfev08c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794831476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iYmNMjvL7eqXS0nOpp2ykcQs55RTDoJm1RUBdh5TpA4=;
	b=dwqtrSqP8QkKz+etI2liiGk0g7/lBq0Jj/bd451RrWeLG3rqqkanZ3j6Z19J7TMQCezmwt
	qT1LN3Y71arbCJDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794831476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iYmNMjvL7eqXS0nOpp2ykcQs55RTDoJm1RUBdh5TpA4=;
	b=d0g9Cl6OXgaASlNcbqWMPR2+9XybqQ/HVrowoyg8gFNE4MvRU++8pMCGJt0Yfb1wrKF6rP
	h8yfdcFSvHnjNTwHWteWRJ//H7rLg6z0ZTezgvJPExuuS5OdRqGSI+82S/D6woEjQZr8Us
	Rl+aFXAU/AF2LLQnIlHFSM87Vfev08c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794831476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iYmNMjvL7eqXS0nOpp2ykcQs55RTDoJm1RUBdh5TpA4=;
	b=dwqtrSqP8QkKz+etI2liiGk0g7/lBq0Jj/bd451RrWeLG3rqqkanZ3j6Z19J7TMQCezmwt
	qT1LN3Y71arbCJDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DAC4134B8;
	Mon, 16 Nov 2026 12:17:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hHVXO3P0+mqeXAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 16 Nov 2026 12:17:56 +0000
Date: Mon, 16 Nov 2026 13:17:55 +0100
Message-ID: <875wxxynpo.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Vytautas Liuolia <vytautas@liuolia.eu>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Add quirk for VF0790
In-Reply-To: <20261115181324.97843-1-vytautas@liuolia.eu>
References: <20261115181324.97843-1-vytautas@liuolia.eu>
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
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30
X-Spam-Level: 
X-Spam-Flag: NO

On Sun, 15 Nov 2026 19:13:24 +0100,
Vytautas Liuolia wrote:
> 
> The Creative Live! Cam Chat HD VF0790 (041e:4097) has the same audio
> interface layout as the VF0770: interface 3 offers S16_LE and S24_3LE
> capture altsettings at 8, 16, 44.1 and 48 kHz. The 24-bit altsettings
> advertise the same wMaxPacketSize as their 16-bit counterparts, e.g.
> 216 bytes at 48 kHz, which holds 54 frames of S16_LE but only 36 frames
> of S24_3LE instead of the 48 needed per 1 ms packet. The device then
> delivers only 36 frames per packet.
> 
> PipeWire picks S24_3LE by default, so 1/4 of the samples are lost: the
> captured audio sounds chopped and carries a constant 1333 Hz buzz, one
> discontinuity every 0.75 ms. Timed raw captures at 48 kHz with arecord
> deliver about 36000 frames/s with S24_3LE and 48000 frames/s with
> S16_LE.
> 
> As done for the VF0770, only report the 16-bit 48 kHz altsetting. The
> other 16-bit rates have not been verified, so leave them out as well.
> 
> Tested with this patch applied to snd-usb-audio from v7.0: the capture
> stream now only lists the S16_LE 48 kHz altsetting, PipeWire uses it
> without any local configuration, and recordings no longer show the
> 1333 Hz artifact.
> 
> The problem was diagnosed, and this patch written, with the help of an
> AI coding assistant (Claude Code).
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Vytautas Liuolia <vytautas@liuolia.eu>

Applied to for-next branch now.  Thanks.


Takashi
