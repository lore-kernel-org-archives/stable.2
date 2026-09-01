Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06437470EB5
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259055; cv=none; b=RSSUCHtYOlzyWusmlQg3IlmA7qcQfyRgoeQPeu5KaNpllvNBjLJpK40Q4kvRz9SK++7TiD0H7wvq1D5G2GypfgJMas8yWcr8sPniYO3N6JFdsoUzEu74klUm5JPH4ezzu+9phj+qNWnDHlMT9l4qOHE15uBLRUTJdok672BJpfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259055; c=relaxed/simple;
	bh=MKAN7FuNPdql2ijvJSwXgesFhgJoNaFlzr5XXnC7c/g=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W70k2MFO6+/4BQIM1uTTnVyjyMbBrl/5FX6TIwGKA4e5MagZ6UHBdxl65o6j3dndoucMRCpfouT+GV0WJSJCRF1p8336POhSi85ebR+iT4s2j24VQWcsKbFjshRqrl/dmxfUXjkT9IyN9KL9PLV0mo0AgV6jJSEVGgvMZVjFmic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jT4G6yla; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tZlqsoHa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JF2R12Cy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DRd61sJz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jT4G6yla";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tZlqsoHa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JF2R12Cy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DRd61sJz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBED0223F1;
	Tue,  1 Sep 2026 10:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788259039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FN/q+EaJzmidy+Gw4FqvGJbssgUzfJFrQjNzUcTKvCA=;
	b=jT4G6yla+AhilAdTquk1YSzk0nVaXiK9Tgs7dXDe9kmsPcpr+QV3y5qLpDs7o8T/WHn5zj
	oi1Yp1bJlHg4bfIe14x6fc0ktwQkThwerhsyRHee06eW5o4vaGTKAUHru57OGLpKAohTLP
	nvM4IIJpivdjtAQQypdaHU2jyLJeTvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788259039;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FN/q+EaJzmidy+Gw4FqvGJbssgUzfJFrQjNzUcTKvCA=;
	b=tZlqsoHa5Q6p1YUALjreIPT0Uex/O0GMExNVyvX2XLhTBBS8ATTKiUR1Let/YjGIJd2L9S
	63lUo1OqHKDw3uDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JF2R12Cy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DRd61sJz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788259034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FN/q+EaJzmidy+Gw4FqvGJbssgUzfJFrQjNzUcTKvCA=;
	b=JF2R12Cyp/aJ//8FFd20L7xpdITiCQOuXB87a+tjL1Sn0RRRRdbOt3lyptLwkYnwk25p45
	X/oCoOhO/ZdLeWjJ/56YVeJOZUdei31GN3uTI/0zcbFOSWW2FCrmUDXzE3qbHlPiaVNEtn
	zdE6gZ1YCIo9NYsVPQcoLTWXaUnh+qE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788259034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FN/q+EaJzmidy+Gw4FqvGJbssgUzfJFrQjNzUcTKvCA=;
	b=DRd61sJzkniEoNPpxba440AqldQbb5yyuJCwsTctc8EXrZhz13IwGXfTSi9RDZRcuLZ4fG
	KvLkqgHg81BQI/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9FED1369E;
	Tue,  1 Sep 2026 10:37:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xlfVLNqqlmpQCAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 01 Sep 2026 10:37:14 +0000
Date: Tue, 01 Sep 2026 12:37:14 +0200
Message-ID: <875x0pdzqd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: HyeongJun An <sammiee5311@gmail.com>
Cc: clemens@ladisch.de,
	tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: fix OOB write in snd_usbmidi_us122l_output()
In-Reply-To: <20260901090409.1478573-1-sammiee5311@gmail.com>
References: <20260901090409.1478573-1-sammiee5311@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: EBED0223F1
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
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

On Tue, 01 Sep 2026 11:04:09 +0200,
HyeongJun An wrote:
> 
> The snd_usbmidi_us122l_output() picks a count of 2 on anything slower
> than high speed and never relates it to ep->max_transfer.  The URB
> buffer holds exactly max_transfer bytes, so a device declaring a one
> byte bulk endpoint takes two bytes from snd_rawmidi_transmit(), and the
> memset that pads the rest computes 1 - 2 in int and wraps to SIZE_MAX.
> 
> Only 0x800e and 0x800f are pinned to nine bytes.  The US-122MKII at
> 0x0644:0x8021 falls to the default and takes usb_maxpacket(), which the
> USB core only clamps downward.
> 
> The akai and novation output ops in this file were given the same guard
> recently.  Do the same here.
> 
> Fixes: 030a07e44129 ("ALSA: Add USB US122L driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>

Applied now.  Thanks.


Takashi
