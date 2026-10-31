Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793462707;
	b=FJhXUho0JBW9YHw+cgM6I6EqN43SNNpvWHT8lMRGbtp3kc9WIGIZgBC5Lnu1NkPCkns2
	 XINsk+abw4jE9bJihO8ubqR6QtmhupWx6E47TpQEipwOU9BZJ5nh1bqzc1s3b2BSEUvus
	 lZTaGAGoFiH3qdmwA31gi6g+P5hUB/m71yQd/cIpCQbNjCEmrU+H2LC5l+GEZhv+BAQH5
	 BMLcauFmTmz7xtafxWdutV1ta7dgh808eIUMsudbKoL8Wr5zQJpmloLqbJLVAUDJwkEta
	 V8kexn63otcaolR0/oxYXs2sF3ULN0gZeRIowuGwVGoyNzX8IBIBu+V16p012W6oiiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793462707;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=uHdBAGKxNpYQx5L7VG+OolF5sikmRSMFd45XczdhFoA=;
	b=rllM8VXLfo/aWVmuH/zbhTItmWlijFXocU2MagJhvkMZt5WhOn6C7pmpwimjieNQQr4L
	 YUuwfMziW3AtDsDzEiLSv8ngMzGYGryHSqU8iXAoXN13p+K/XqtNedcQ9Xaf6fVVLBvtJ
	 gpmVgyx0QjXGPWf2Zd6MlULzEhKde0QAGA+6iipA847OPw3PXZLAp4Ba8THAHsmLELbzp
	 wBIccTuU+6b+09pava/gkaDM68SKmafF14DZg1QsoUFoidjEqEcakt4qOYIAWMTTCqlqf
	 zPU0RG6/qIBenKY8XMSXXF45pApg4gJotkWCi6JsIGEeW4F3yIEfoznbrphujY5GxvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vH9Y4anJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=auAW+fm5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vH9Y4anJ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=auAW+fm5;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780C1606A31C;
	Sat, 31 Oct 2026 16:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 780C1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vH9Y4anJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=auAW+fm5;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vH9Y4anJ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=auAW+fm5
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B782222C8;
	Sat, 31 Oct 2026 16:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793462704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uHdBAGKxNpYQx5L7VG+OolF5sikmRSMFd45XczdhFoA=;
	b=vH9Y4anJTJfCZne4ZOQofOwcpRJkXeP8iIaDpF0NIUikwkz/PeeizFYRnQpQBZ5fJWF5kh
	nVY7YxsCecy7BSCK4q+RkU1pLUxOp3m1Szu33pzDUfZxIYKvBYS+/6hcdnWhBptNWG+aNM
	kVPS/gZmgzhDkCt0vpdh5eHxV2+F75Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793462704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uHdBAGKxNpYQx5L7VG+OolF5sikmRSMFd45XczdhFoA=;
	b=auAW+fm58VMP6sK6e6x+DRxSzfOvjUdIm3GqFtQTDBzHANATokJd5w5GVFIxIs3t1c3tNj
	YvRXEI/cmhIncYDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793462704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uHdBAGKxNpYQx5L7VG+OolF5sikmRSMFd45XczdhFoA=;
	b=vH9Y4anJTJfCZne4ZOQofOwcpRJkXeP8iIaDpF0NIUikwkz/PeeizFYRnQpQBZ5fJWF5kh
	nVY7YxsCecy7BSCK4q+RkU1pLUxOp3m1Szu33pzDUfZxIYKvBYS+/6hcdnWhBptNWG+aNM
	kVPS/gZmgzhDkCt0vpdh5eHxV2+F75Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793462704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uHdBAGKxNpYQx5L7VG+OolF5sikmRSMFd45XczdhFoA=;
	b=auAW+fm58VMP6sK6e6x+DRxSzfOvjUdIm3GqFtQTDBzHANATokJd5w5GVFIxIs3t1c3tNj
	YvRXEI/cmhIncYDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A346132D3;
	Sat, 31 Oct 2026 16:05:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zGDwCLAR5mrtMQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 31 Oct 2026 16:05:04 +0000
Date: Sat, 31 Oct 2026 17:05:03 +0100
Message-ID: <87se1lrh3k.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: chris@nilk.net
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable bass speakers on Alienware m17 R3
In-Reply-To: <20261029-alc289-m17r3-v1-1-5d3eac605e7a@nilk.net>
References: <20261029-alc289-m17r3-v1-1-5d3eac605e7a@nilk.net>
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
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30

On Thu, 29 Oct 2026 23:49:10 +0100,
Chris Simpson via B4 Relay wrote:
> 
> From: Chris Simpson <chris@nilk.net>
> 
> The Alienware m17 R3 (ALC289, PCI SSID 1028:09d1) has a second speaker
> pair, the bass speakers, on pin 0x17, which the BIOS leaves unconnected
> (0x411111f0). No PCI SSID quirk matches the machine, so it gets
> ALC269_FIXUP_DELL4_MIC_NO_PRESENCE from the fallback pin quirk table,
> and only the speakers on pin 0x14 play.
> 
> Use ALC289_FIXUP_DUAL_SPK, as on the Alienware x16 R2 and Dell XPS 15
> 9510/9520: it sets pin 0x17 up as a speaker on DAC 0x02, so one volume
> control covers both pairs, and chains to
> ALC269_FIXUP_DELL4_MIC_NO_PRESENCE, so the headset mic setup is
> unchanged.
> 
> Tested on an Alienware m17 R3 (BIOS 1.38.0), Linux 7.3 with this change
> applied: the bass speakers play, and volume and mute cover both pairs,
> also after suspend and resume. Headphones and a headset mic were not
> tested.
> 
> I used Claude Code (Claude Opus 5.5) to find the unused pin, pick the
> existing fixup and write this patch and changelog; I did the listening
> tests myself.
> 
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Chris Simpson <chris@nilk.net>

Applied now.  Thanks.


Takashi
