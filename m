Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794042476;
	b=eIjRshofwnDVwTGipLbOwlLNaWVEgKDuY9E/iYJgob9h9dggRarfDc9TO7PsGl4rnb+2
	 KSGwwvaALwV0i8EkU3h95lsnx2nFaFVsbI+Xdo4pBIA5YXNOc+nfP4k/jQTzTlj4X7/sn
	 KqVl45KIS2KGGAdpaPFtwbhvfDTvBg4ay7O1mY4HFqA+K1l+4Boc2stp9RW9LcHb+cwBg
	 UcoJT1R7HfWsL8j090ZYaxvmY6rFsKULI3fiusERKG7tPLUYHZC64Iu5rfQ18Tb3i317j
	 nI8sVO5Mu8yOHxmWCXUDN9oAxi/+bLAvtbhlzb7yMpJDAjua/S/kbXMecLEiraxHUAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794042476;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=pUEOI/mRSXOGiq0N50HWR5d+yLtX8x0qUDl0Yb8MEiY=;
	b=PDyrmXdKymX2Z4vnUKhqcey59vJinqUB1GUNo+ay3SFSLd2zAzD0QKz9RDSuO1CC5mVf
	 2mzWXiBiFr0wjMzdyLDuBEGGMYjzG6K+znqOTUkviIn/nBgJiCb21YnaoGA+iQsj0/e90
	 8EQb0tO1TWc+jeB8w2Bqf9EZDT35wFOyj49TyThnzklaA5oLLO1MzkNA/ebJNKL/FQHf+
	 alRHre3p72WwtATJa2ei9v75djFoiZrmVp0kYTOq3IHdydbWKG0g3JGSSlXIUO30EWVdi
	 /Pv6ird37TanwM2y5C7ppRD4EXiG931qpQl+LccSkKLk6aZ7NMHzGcn53mAMIiYk3eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=YkdxE30G;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JtNwWQiI;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=YkdxE30G;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JtNwWQiI;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF47606A326;
	Sat,  7 Nov 2026 09:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CF47606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=YkdxE30G;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JtNwWQiI;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=YkdxE30G;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JtNwWQiI
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B8212204E;
	Sat,  7 Nov 2026 09:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794042473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pUEOI/mRSXOGiq0N50HWR5d+yLtX8x0qUDl0Yb8MEiY=;
	b=YkdxE30GGSR+0QZYcEDYxlt9448SmBJhveVwGjlk9KC689vP9BbGMEkl+mi0Zd+C/5RmSq
	Q8M0oO51z1zsWDkvnSpdTevyYFhlgLDyqbMv7wczlFVfeq+T/GFVKo8jM9+3+vCPrQlWPK
	srazP/uhGfYB7sEi1HV425VyaoXuHpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794042473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pUEOI/mRSXOGiq0N50HWR5d+yLtX8x0qUDl0Yb8MEiY=;
	b=JtNwWQiI8pb8JM4Dbu3u5CVAYahXrfdNcIPAhD/QnKzmC/HOGei7bEd47vNHEtMfLcXleU
	OJqGvoYf/+3HNWCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794042473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pUEOI/mRSXOGiq0N50HWR5d+yLtX8x0qUDl0Yb8MEiY=;
	b=YkdxE30GGSR+0QZYcEDYxlt9448SmBJhveVwGjlk9KC689vP9BbGMEkl+mi0Zd+C/5RmSq
	Q8M0oO51z1zsWDkvnSpdTevyYFhlgLDyqbMv7wczlFVfeq+T/GFVKo8jM9+3+vCPrQlWPK
	srazP/uhGfYB7sEi1HV425VyaoXuHpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794042473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pUEOI/mRSXOGiq0N50HWR5d+yLtX8x0qUDl0Yb8MEiY=;
	b=JtNwWQiI8pb8JM4Dbu3u5CVAYahXrfdNcIPAhD/QnKzmC/HOGei7bEd47vNHEtMfLcXleU
	OJqGvoYf/+3HNWCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D326132C9;
	Sat,  7 Nov 2026 09:07:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QbpMOGjq7mqhXwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 07 Nov 2026 09:07:53 +0000
Date: Sat, 07 Nov 2026 10:07:52 +0100
Message-ID: <87fqxdypp3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andrew Davison <andy@dvsn.net>
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: Fix [codec] ID matching in patch files for IDs with bit 31 set
In-Reply-To: <20261106175518.18629-1-andy@dvsn.net>
References: <20261106175518.18629-1-andy@dvsn.net>
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

On Fri, 06 Nov 2026 18:55:18 +0100,
Andrew Davison wrote:
> 
> parse_codec_mode() reads the vendor and subsystem IDs of a patch file's
> [codec] line into an int, and skips the check when the value is zero or
> negative, as documented. An ID with bit 31 set, such as SigmaTel's
> 0x8384xxxx or Intel's 0x8086xxxx, comes out negative, so it is taken as
> a wildcard and the section is applied to every codec instead of the one
> it names.
> 
> This was seen on an OpenPeak OpenFrame 2 with an IDT 92HD75B2X5
> (0x111d7608). A patch file written for the STAC9202 (0x83847632) in the
> related OpenFrame 1 was applied to it, swapping the headphone and
> speaker pin configurations, so auto-mute never muted the speaker.
> 
> Read the IDs as long long, so real IDs are compared exactly. Values
> written as negative numbers (e.g. -1) still act as wildcards, as
> documented; a hex value such as 0xffffffff is now compared as written.
> 
> Tested on 6.18.60 on an OpenFrame 2, with a rebuilt snd-hda-codec and
> the STAC9202 patch file: user_pin_configs stays empty for the IDT codec,
> and the headphone and line-out pins are assigned as the BIOS sets them.
> Not tested on a STAC9202 itself.
> 
> The bug was tracked down and this fix written with an AI coding
> assistant (Claude Code, Claude Opus 5.5), which also ran the tests
> above. I have reviewed the change and the tests.
> 
> Fixes: ef940b0403d4 ("ALSA: hda - Allow patching with any vendor/subsystem ids")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrew Davison <andy@dvsn.net>

Applied now.  Thanks.


Takashi
