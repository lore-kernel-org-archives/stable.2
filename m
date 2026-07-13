Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4607931C56D
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955088; cv=none; b=dOfm8dKi398PJ+5S0NF86z4yLEab4s1IsDgBKM0OWNKV/MfvN+hvi6C7AWcmykFzhEcHLfqfrHhKg6USj8ZDUsHMXTPWArt/dUdQD9bp/g68zC4dgPwTHonRSOFD4or4YdwB2qZETZmU5BFtltDGqsQF74PzB9h1Y2vM+Vy6nE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955088; c=relaxed/simple;
	bh=CcUxOCYJu+kCaoHe9zAA6HFPq1oFXw4srhy8scQRLLM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZFV9P6JsCeHX7FcCZcANc3p4EwdUm0FMei0uMfPPli9qXf+yhsvSZca5O67ui5nrCLPrEzFH1NF40++yTT+A+86/z/cScrsTxtHGOsKZH0JzwIZPw8m+9SZA04cEokL3DTB72H/2MHkRPDbHJdZW2h9w+Rz7KgAmh69i5O/nHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VKq6fCHq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kk81RgFJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VKq6fCHq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kk81RgFJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VKq6fCHq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kk81RgFJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VKq6fCHq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kk81RgFJ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 346FF77941;
	Mon, 13 Jul 2026 15:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783955085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SIOvXaew/x5orSgLKcP5Gf9LyiNxo32RHsPyKfFhkIo=;
	b=VKq6fCHqU2C3PZ57bsq0zgFAmM+yxTFGoD004x1pzaSwj+EAPEv1LN6y5wWuV2cyHbOUXj
	295dv1MMy/KLm3MANv7TCona/xbOlg8Ap00BMsfZjaufcMVnTsP3y2cgNuHPN7SMj4OEYz
	lv/23XIFD83qYZM7i/1liawZe2HXntE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783955085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SIOvXaew/x5orSgLKcP5Gf9LyiNxo32RHsPyKfFhkIo=;
	b=kk81RgFJuKOukj9RFxw0QXJ4qbPx950mg8hSQsniUA0W3KG1Ok/x22TBmHkxebpeY9OHBw
	KsXr9obi9Z6rpDBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783955085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SIOvXaew/x5orSgLKcP5Gf9LyiNxo32RHsPyKfFhkIo=;
	b=VKq6fCHqU2C3PZ57bsq0zgFAmM+yxTFGoD004x1pzaSwj+EAPEv1LN6y5wWuV2cyHbOUXj
	295dv1MMy/KLm3MANv7TCona/xbOlg8Ap00BMsfZjaufcMVnTsP3y2cgNuHPN7SMj4OEYz
	lv/23XIFD83qYZM7i/1liawZe2HXntE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783955085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SIOvXaew/x5orSgLKcP5Gf9LyiNxo32RHsPyKfFhkIo=;
	b=kk81RgFJuKOukj9RFxw0QXJ4qbPx950mg8hSQsniUA0W3KG1Ok/x22TBmHkxebpeY9OHBw
	KsXr9obi9Z6rpDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2072779AE;
	Mon, 13 Jul 2026 15:04:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aS7aOYz+VGpEUgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 13 Jul 2026 15:04:44 +0000
Date: Mon, 13 Jul 2026 17:04:44 +0200
Message-ID: <871pd7ylpv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	bo.liu@senarytech.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: conexant: Remove mic bias threshold override
In-Reply-To: <20260713100329.306892-1-zhangheng@kylinos.cn>
References: <20260713100329.306892-1-zhangheng@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Level: 
X-Spam-Score: -3.30

On Mon, 13 Jul 2026 12:03:29 +0200,
Zhang Heng wrote:
> 
> Remove the mic bias current comparator threshold override (NID 0x1c,
> verb 0x320, value 0x010) from Conexant codec driver.
> 
> This override was originally intended to support volume up/down controls on
> headsets with inline remote controls, but it causes microphone detection
> failures on some headsets with impedance less than 1k ohm.
> 
> After consulting with the vendor's engineers, it was confirmed that this
> setting is board-specific and should be handled by BIOS/firmware rather
> than the generic codec driver, especially since inline remote support
> is not currently implemented.
> 
> Fixes: 7aeb25908648 ("ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>

Applied now.  Thanks.


Takashi
