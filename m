Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E713DDDA1
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782388384; cv=none; b=i3Br/u0HUULo24FALHnbt8RjU/dJ/tpUS5wtdUmwe1OemQfX1KDeDg7i+s9fbWUaptaFwbw3NsIT1Ec1CjpgspLFNwLg31TshjGJ4WLQFSaOOL/cEYFMuWg6AFQLq73xCP3znM1rBfbjbbjQcysVdz4CThVaA0t4Z1bw402WOHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782388384; c=relaxed/simple;
	bh=jrBCAYYtFmZ59LxFcrWWQftFhm4twriePx+2/nHbRvY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+W51rvTdsRwCNw/xeBKBBdUwFfLtTi8Go/owZCveYDlh4XSpbffE12oI6ueylPQoeswS//GBBzVwoJV/8PSa+FZL7rLB3a4iSiqQSnTdTfyHXJigvCg721riuTs/1vwgOyr7vKSCYQ5f/LDAYR+91nBkKc88vv2i1XLTDC0/XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Abwx7VKl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A5jb2rbm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1zjJX7qc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pNthpy5O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Abwx7VKl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A5jb2rbm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1zjJX7qc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pNthpy5O"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6DD8771AFE;
	Thu, 25 Jun 2026 11:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782388379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWfIbRiq3pUIbkqvkNhafBzQwY/dIy5+RX96V68LkSE=;
	b=Abwx7VKli0TOUE8e7fbEGMfDUknqyuV4Z8Hq/FJv60rTFV7jcbBmgtAUricn+cXuTsyTCR
	IFHOeJG8SbLBn+1svtObLLzsFR4GiPkRjW5Pvx0Xsg0wjIGEYtMYoeKSah+KeGA6Pzj67v
	NoSdaMpdCrXucLNG5H8ujFMS876lQbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782388379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWfIbRiq3pUIbkqvkNhafBzQwY/dIy5+RX96V68LkSE=;
	b=A5jb2rbmWS8KXOmI2r8+8K/O6IPGwmPNrkC4MbFwwdAcv5GXQBqZMO/tc9BQRHV606F4jF
	VdOZUfpEYVwVsbCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1zjJX7qc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pNthpy5O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782388378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWfIbRiq3pUIbkqvkNhafBzQwY/dIy5+RX96V68LkSE=;
	b=1zjJX7qcsfvfvTAgm9KkAAHgp70MqWuKqPxspaviiZRDo6zFu8qwUi7hm0FYhZuOnRQOrh
	i0lRq3QdxVh3n0Tof+BSDvcUETQwxXTXCo4b6phmdYbqg6pyc42azbw3oh+raEZGrjZ5cP
	BB8uLzgch6HLE41zc4yvHM1/DqB13Nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782388378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWfIbRiq3pUIbkqvkNhafBzQwY/dIy5+RX96V68LkSE=;
	b=pNthpy5ObKYWHMkrlBvDvLM05U9T0BlN6vPTCR056lVAm0yqsBnvoQEotunxxd6QX7tZLA
	Lut9c/XZX06NiYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42E99779A8;
	Thu, 25 Jun 2026 11:52:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ISVSD5oWPWpUfgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 25 Jun 2026 11:52:58 +0000
Date: Thu, 25 Jun 2026 13:52:53 +0200
Message-ID: <87bjcyvnu2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Darvell Long <contact@darvell.me>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: avoid kobject path lookup in DualSense match
In-Reply-To: <20260624143723.2986353-1-contact@darvell.me>
References: <20260624143723.2986353-1-contact@darvell.me>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6DD8771AFE
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,darvell.me:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, 24 Jun 2026 16:37:23 +0200,
Darvell Long wrote:
> 
> The DualSense jack-detection input handler verifies that a matching input
> device belongs to the same physical controller by building kobject path
> strings for both the input device and the USB audio device, then comparing
> the path prefix.
> 
> This was observed when a weak physical connection caused the controller
> to rapidly disconnect and reconnect. During that repeated hotplug,
> snd_dualsense_ih_match() can run while the controller's USB device is
> being disconnected. kobject_get_path() walks ancestor kobjects and
> dereferences their names; if the USB device kobject name is no longer
> valid, this can fault in strlen():
> 
>   RIP: 0010:strlen+0x10/0x30
>   Call Trace:
>    kobject_get_path+0x34/0x150
>    snd_dualsense_ih_match+0x49/0xd0 [snd_usb_audio]
>    input_register_device+0x566/0x6a0
>    ps_probe+0xb89/0x1590 [hid_playstation]
> 
> The same ownership check can be done without building kobject path
> strings. The input device is parented below the HID device, USB interface
> and USB device, so walking the input device parent chain and comparing
> against the mixer USB device preserves the check without dereferencing
> kobject names during disconnect.
> 
> Fixes: 79d561c4ec04 ("ALSA: usb-audio: Add mixer quirk for Sony DualSense PS5")
> Cc: <stable@vger.kernel.org>
> Assisted-by: Cute:gpt-5.5
> Signed-off-by: Darvell Long <contact@darvell.me>

Thanks, applied now.


Takashi
