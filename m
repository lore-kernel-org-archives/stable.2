Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0E14315A;
	Sat, 17 Oct 2026 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792225702; cv=none; b=hXIsZajJ46bySdUGCO6+Q6g7dlFpF8OmWP48dflsywysw1OBmt9h9ldfSD1+b8pzdIFysKgt333lJTGkOTc1+QNwjNL4ujSa/iaz65Rpgz5NEp3G/380GwvAHiPlsnibvF0w4GG8+m4wRoNCnXgNWHI7Ks3MSu5msfIZTrVDDJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792225702; c=relaxed/simple;
	bh=xBNlNILWdBvg2c3Gb0jF/ZqgBM7J5dqAtDfDSWNI+T0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCNQRsYAoVpkQuU3KhOZFtg4OCby/n+8snaSsqCxcCd+Ho968oFdzjFnS7OGCl8l8KHF6IvRvSeZxr1MHrYoZwrMUkGan3+tUbSZ8s3+/3iGtdpveAvoxgWDMva6TQUNhzeqHbVH3C7NODN61PyLNyd0D04XMpgBt2/16rYol6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q7S21Q6e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B1lYB7Yl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RXLYg4yQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TZqST7xU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q7S21Q6e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B1lYB7Yl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RXLYg4yQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TZqST7xU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B9AA521BE5;
	Sat, 17 Oct 2026 08:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792225699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XI7USDzzBcfJKmNjraZayIHfmmXgQJiwGp1Eg0bettk=;
	b=q7S21Q6er9yr6BqPdhNwRyfQEDeTx1urva8H4WdeMdr9y+vwGftBz3DtFmPnT6J7pDva9W
	jmJmpM3VywyB4LBFp5cGLqlalyi38gYL0xmSLJT8J4cJz7jiD54uOaQabsfx5LdcL2wymI
	ff1Pc+1CDBGL5Gb/dKudMrNs781LzTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792225699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XI7USDzzBcfJKmNjraZayIHfmmXgQJiwGp1Eg0bettk=;
	b=B1lYB7YlCwQS0Ece4l2tv07XEoV04rV/RrNqseTTJD0Ak3NW1bPhFy08fuG8a802ai9cBJ
	ler3Gq+h+tMorqDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792225697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XI7USDzzBcfJKmNjraZayIHfmmXgQJiwGp1Eg0bettk=;
	b=RXLYg4yQNB2JfBm9exLQ7oikdLYyvbDuUCvSf8YY38si752MNnBf0BKnn1ZaHluu96NSCP
	giKXDCaR40oMcyBX2IxWLrZDiB5YGZxp+FZ06uda/9gZWuCL5H+LrDMrx3+8Ayr6FWFN3y
	WtNETafJSxsW7wQPM/SlmIGKcqAUieE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792225697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XI7USDzzBcfJKmNjraZayIHfmmXgQJiwGp1Eg0bettk=;
	b=TZqST7xUptsGzJ0NAQTIsHJdrU+oNhuivKw5lfPNsJ46+l6ShwZ0zEVf3njCWCqV4xRCoP
	G8e2vYm/sTTMrXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FFB8133A7;
	Sat, 17 Oct 2026 08:28:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ROH0EaEx02rQJgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 17 Oct 2026 08:28:17 +0000
Date: Sat, 17 Oct 2026 10:28:16 +0200
Message-ID: <87jyng20kf.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?Jos=E9?= Miguel Castellanos Valladolid
 <josstamy@gmail.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable mute LEDs on HP OmniBook X Flip 14-fm0xxx
In-Reply-To: <20261017050615.14481-1-josstamy@gmail.com>
References: <20261017050615.14481-1-josstamy@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO

On Sat, 17 Oct 2026 07:06:15 +0200,
José Miguel Castellanos Valladolid wrote:
> 
> The HP OmniBook X Flip Laptop 14-fm0xxx (subsystem ID 0x103c8d9f, ALC245
> with two CS35L41 amplifiers over I2C) is currently handled by
> ALC287_FIXUP_CS35L41_I2C_2. That binds the amplifiers but does not set up
> the mute LEDs, so neither the speaker mute key LED nor the microphone mute
> key LED lights up under Linux. With that fixup the codec GPIOs stay
> disabled (IO[0..2] enable=0).
> 
> Switch the entry to ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS, which chains
> cs35l41_fixup_i2c_two with ALC245_FIXUP_HP_X360_MUTE_LEDS. This keeps the
> amplifier setup and adds the speaker mute LED through the ALC245 COEF
> register and the mic mute LED through codec GPIO2. It is the same fixup
> already used for the 17 Turbine OmniBook 7 DIS (0x103c8d9c).
> 
> Tested on the affected laptop with v7.2.11 using the equivalent
> ALC245_FIXUP_HP_ENVY_X360_15_FH0XXX fixup, which has the identical
> cs35l41_fixup_i2c_two + ALC245_FIXUP_HP_X360_MUTE_LEDS chain: hda::mute
> and hda::micmute LED class devices appear and both key LEDs light up
> when muting.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: José Miguel Castellanos Valladolid <josstamy@gmail.com>

Applied now to for-next branch (with Fixes tag of the former quirk).


thanks,

Takashi
