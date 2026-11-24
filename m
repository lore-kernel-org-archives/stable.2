Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524501;
	b=gQFZWmD7uarTjxGAz50tY3kI6eRGjbRpcWfi7+Pww3bAYXCdJYmwRc9bLbSNzaW74FOV
	 xOQmaY8KPbPoGwH8xT0XT5lc/+GGMt1X5wcgYy7bfLgyqsPd5V/adgGxCoFwiW90ruDDa
	 Ih4B0K65Mz6LuWZk15pWSYyAQ2UF7SO1/pzlVVDqTptYeeof4K3vpzjKub0tVC9OC+KkP
	 3snIDbrm4lYTt++/tH26pNs9/xURp8DqmQrPNz1JdCS9h1LvEvINNWGvFcqEEt59VfYEv
	 l1tyAbVgleiXEeCw2AuMPoMACzUfBirajVkUMIC3JS9Jm2iu1+JnNgIy4OiDpSbl2Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524501;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=DVCNnYLJZY3e50i2E0AcjEM5G+l/ZQuX7ihheHT8Xsg=;
	b=XNST/3aKKMOofp1gYlJzNIO5aAZ7IOV5Y/1WaEwu8qBxtoLKTk2cYp4vRjp4lZW/t5Rt
	 ySUqiGhO97XLj64Jy6gjzJOHwwmdKor81KkZd6E0PBUkfgASMW8tIOA3ThLzz9+5P/xTN
	 univRM2MXYQWHoP9+qO+bpKSewnVzYmhBrPoIgxPzEZuQRsicM+Re8eWY8gQ6V5vhK/Ub
	 WkejHuNaA61n32UIowiwLj3FaDDSkTyyTo19i7vLoYEACxsKK2d0wHfcnpZ8hsvp/inCc
	 NG69UheLC9Qib+JLulr4AtRjW6b7eeZFHnb3pnti7hb0mzm7zjV/D0AIZbcCZErTk2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VIJrtD2Z;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DckehWoY;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VIJrtD2Z;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DckehWoY;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBCE606A333
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCBCE606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VIJrtD2Z;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DckehWoY;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VIJrtD2Z;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DckehWoY
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DDE2C1F7A0;
	Tue, 24 Nov 2026 12:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795524491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVCNnYLJZY3e50i2E0AcjEM5G+l/ZQuX7ihheHT8Xsg=;
	b=VIJrtD2Z4Y3waGoOlu+yxgBDR/tIJsGzZyVvy6jJ9fsoLq+Y+DJD+NA1RW4av10gzXhpMf
	q+8QGxrqBASvqARqIUM0WBS1Wsey/JAAHtOnFpua8s2HMq2JxNYNio+5Q5EBmuS3CFJGxh
	pNsbYHx8mZWoN+bbeMkIrHRmXWmk0Zc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795524491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVCNnYLJZY3e50i2E0AcjEM5G+l/ZQuX7ihheHT8Xsg=;
	b=DckehWoYaKTUXjaT8lvEStmnoQ4A0gpO3ilH0WfyijB2YEQVqt3YVffQh8vfvMirMWBICj
	5i0s9b0WgZKQkCDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795524491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVCNnYLJZY3e50i2E0AcjEM5G+l/ZQuX7ihheHT8Xsg=;
	b=VIJrtD2Z4Y3waGoOlu+yxgBDR/tIJsGzZyVvy6jJ9fsoLq+Y+DJD+NA1RW4av10gzXhpMf
	q+8QGxrqBASvqARqIUM0WBS1Wsey/JAAHtOnFpua8s2HMq2JxNYNio+5Q5EBmuS3CFJGxh
	pNsbYHx8mZWoN+bbeMkIrHRmXWmk0Zc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795524491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVCNnYLJZY3e50i2E0AcjEM5G+l/ZQuX7ihheHT8Xsg=;
	b=DckehWoYaKTUXjaT8lvEStmnoQ4A0gpO3ilH0WfyijB2YEQVqt3YVffQh8vfvMirMWBICj
	5i0s9b0WgZKQkCDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2ED41339F;
	Tue, 24 Nov 2026 12:48:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b0qDHouHBWugGAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 24 Nov 2026 12:48:11 +0000
Date: Tue, 24 Nov 2026 13:48:11 +0100
Message-ID: <87v75m9z04.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: abhirajdutta7@gmail.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Fix duplicate LEDs on HP Spectre x360 16-f2xxx
In-Reply-To: <20261123-hp-spectre-16-f2-led-fix-v1-1-a2a333dceeb5@gmail.com>
References: <20261123-hp-spectre-16-f2-led-fix-v1-1-a2a333dceeb5@gmail.com>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30

On Tue, 24 Nov 2026 03:17:57 +0100,
Abhiraj Dutta via B4 Relay wrote:
> 
> From: Abhiraj Dutta <abhirajdutta7@gmail.com>
> 
> The EU0XXX fixup already sets up the mute and mic-mute LEDs, so chaining
> ALC245_FIXUP_HP_X360_MUTE_LEDS after it registers both LEDs twice
> (hda::mute_1 and hda::micmute_1 appear). Use the EU0XXX fixup directly.
> 
> The original commit message also got the SSID wrong: under SOF the PCI
> SSID is 103c:891e, not 103c:0000.
> 
> Fixes: e30ec632e1f0 ("ALSA: hda/realtek: Add quirk for HP Spectre x360 2-in-1 Laptop 16-f2xxx")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhiraj Dutta <abhirajdutta7@gmail.com>

Applied now.  Thanks.


Takashi
