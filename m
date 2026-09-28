Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D6E4A4857
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595498; cv=none; b=cQfk12KrWhXp+eAnezB0DDRV4uP0Xf2HUWw2qdYpIhSF2Px/SWd/InYCLNDUs2YG/EbbDfTvkLeYl8spLfuXpMpxRcnnrmWzL4dnk65G12fGbu8ITLswOCFMLMgnRvx+6V64L9ZX8yk77jM1icXPNB1bH2zugvCmCaOiL5s2Wag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595498; c=relaxed/simple;
	bh=+FcoN7dq/tjvhAPCVNzEfd6LNfp4AUHpNFZXDQs4LqY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8bwYDF2+/hYm3ottkONcJJO6RPbOdlos5z/7BBS8/37wpO6FncvEe+S0w5teeNME4odoUtkHsjXyp42EBiNJcKP4lNpEFWI/m+/TuF9m11T4LkWO61z37+95xbSY9uGRRJTpg7TSilMsHqtNqh1CXNpnYX5IyeURft0Dciobvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nZdmuhUP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+rc0SEd4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GiO+r+Xc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3rkn9cDY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nZdmuhUP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+rc0SEd4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GiO+r+Xc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3rkn9cDY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 094C421DC0;
	Mon, 28 Sep 2026 11:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790595482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcwoN1WOBAXUs0E8Imk6lwewdlRsvndfIM795I/UTxs=;
	b=nZdmuhUPMnSmE0NMo62gitTdNnCL3yigO3St0q3KOfhZeIp3WJYyplmhzs7UAC51i+uEib
	xqEvWfKqL0S0r9bUGvyZWR322mK15kjR5WxPTXmqBEr99+hmggWGdV7i+nyVMr3QFBylcm
	HY+WNYffCKt5Cnlvpv/9FXlHBzEnqyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790595482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcwoN1WOBAXUs0E8Imk6lwewdlRsvndfIM795I/UTxs=;
	b=+rc0SEd4RXIj6hXTVwvbROpAnFu4ZuPY/6FUWhqDQHon0WHBcRM38OgD1RFf6B01dWUPjI
	qopDBa9Z/KwH/EBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GiO+r+Xc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3rkn9cDY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790595478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcwoN1WOBAXUs0E8Imk6lwewdlRsvndfIM795I/UTxs=;
	b=GiO+r+Xcb3sMt8nJDWg7ajdzByC0MFwq4cuT48tpiv7N70K/sowVhWts+Uq9cnMHMfsAOL
	QT2f60sbo2hfsAW6VdV8nb0N7oN9lTb5UULsqQSfbCJVseZmZM8+mX45lb40Kb+sAhN51I
	TgHxkV0qv89tf0MfW6G3sLO415Rq/U4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790595478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcwoN1WOBAXUs0E8Imk6lwewdlRsvndfIM795I/UTxs=;
	b=3rkn9cDYALgDy6nLKdXaAa3bvBwPAJZHkTdbDKV1EynXRY5v/ttEZ14CVnTKtN3zoA1jLT
	NwGzZzQDsdDkBkAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B24B6133F3;
	Mon, 28 Sep 2026 11:37:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2TsmIpVRumrqRgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 28 Sep 2026 11:37:57 +0000
Date: Mon, 28 Sep 2026 13:37:57 +0200
Message-ID: <87se2t61yi.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Yu-Hsiang Tseng <asas1asas200@gmail.com>
Cc: linux-sound@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Fix silent speaker on Higole F9B
In-Reply-To: <20260923141344.1543158-1-asas1asas200@gmail.com>
References: <20260923141344.1543158-1-asas1asas200@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 094C421DC0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Spam-Flag: NO

On Wed, 23 Sep 2026 16:13:44 +0200,
Yu-Hsiang Tseng wrote:
> 
> The Higole F9B is an Alder Lake-N mini PC with a 7" touchscreen and an
> ALC269VC codec (subsystem ID 0x10ec111e). Its DMI strings are all
> "Default string", so the SSID is the only way to identify it.
> 
> The internal speaker is silent out of the box. The generic parser
> assigns DAC 0x03 to the speaker pin 0x14 and DAC 0x02 to the headphone
> pin 0x15, but the speaker only reproduces what DAC 0x02 plays, whatever
> its connection selection says. Checked one path at a time, only the
> gain of DAC 0x02 and the mute of pin 0x14 change what comes out of the
> speaker. User space only knows the path it was told the speaker uses,
> so selecting the speaker turns the path that actually reaches it all
> the way down.
> 
> Route both 0x14 and 0x15 through mixer 0x0c (DAC 0x02), which is what
> ALC290_FIXUP_MONO_SPEAKERS already does. Tested on the device: the
> speaker plays.
> 
> Cc: <stable@vger.kernel.org>
> Assisted-by: LLM
> Signed-off-by: Yu-Hsiang Tseng <asas1asas200@gmail.com>
> ---
> The quirk line and this changelog were drafted with an LLM (Claude Code);
> the path-by-path analysis and the test were done by hand on the device.

Applied now.  Thanks.


Takashi
