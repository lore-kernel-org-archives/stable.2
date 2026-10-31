Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793461285;
	b=5R9NhW7wxtHycGzMvDbm1tpF7ROuL6GSZU2coGrRbypV9uP5e1dnknVOxSCMv8ho/H9I
	 2DfA/WaphGCshFm3fjmvcytSj0wJ80RhwxAMZ4gHeeaxCl8EodGGPNxXRhyyDYLF/dyP/
	 f6tu2I1r4iAZPbjOHVhroJ44FwuRfPNa+23WPMTOjXPNoWiSKF6kOX09ZBQNcfHxit/SS
	 VBTlOie70eSk+WKvK0ico4gKjAwxbBgGALi95mbCsIaZ6YNTA9jlj9sur/qCklgzAA5zm
	 Au2MUDYwfzML0NMV8eZkXycnaySJWj6pEwFV6g0JYOzOfPRBIF4JPucI32cR0x9euOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793461285;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=adKF+/16oB5fPj8XuXUVBYhv33mreVQ4r+QFdURTeYk=;
	b=Vjdjgu/xZJXxOh6z+5jr/icdeOTbOvD+nmq65Oh48Pyd8q/1cHrJYYsoHBqo6DhwWGc5
	 WDUiSHe2uej+nU89Si1rBPPslYR8c3pWhxadFbvCudNXhJ+ALBnl1T4c7rZamoZBI7u2q
	 SNfcgW1v1q5hhTRe/84Me4xaA4tElNY7xm9/8/QhiDA6aSE4DBQMbKxNG6SeDwlG3BRaz
	 V+qerNopAmgftcQi6VbB4bCWH6gSZ0sHAdbtLRO8M7r0wjJFYN/KWOCFvS3bDOLS2JBaY
	 uETWrVNjiag011yyiEkLhs+FEJf1HlFJFJEvELlBCzaV247KBRTY5TqjvBxSsyO/j8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=WG4wubgw;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+oXxkp12;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oX9tkGSa;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=f2S0zSis;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDDA606A31A;
	Sat, 31 Oct 2026 15:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DDDA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=WG4wubgw;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+oXxkp12;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oX9tkGSa;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=f2S0zSis
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 11D641F749;
	Sat, 31 Oct 2026 15:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793461283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adKF+/16oB5fPj8XuXUVBYhv33mreVQ4r+QFdURTeYk=;
	b=WG4wubgwo4c24LCD2ds2qK03ch5jjzx9Etfb04CGfYNvyi54VQoMkO7q3d1h0rSKzEuZHh
	4uxrjy3ANg1Ksj2z0zsVUcQnZf76G7ewH/n1Vz+b/9nrMfCyiIO+Xy45uvkDVFmsLUZ+N9
	A7SFbx4FUwaM6dLHTYw9U1qnZuS6XbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793461283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adKF+/16oB5fPj8XuXUVBYhv33mreVQ4r+QFdURTeYk=;
	b=+oXxkp121PRo8TbHXbbtQktXd0JSxMidsQh/65f6RblqzW6i3oFLIgFcDFXNULnG2E0Szz
	eI5ecYKO1eeFuPCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793461282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adKF+/16oB5fPj8XuXUVBYhv33mreVQ4r+QFdURTeYk=;
	b=oX9tkGSaKEjFMt67jmxuwAbpL8+qopQobnf4hZAYXgCeEEuSrctYiGJnpnMaXg3Q+e1Mh8
	VAmI+ypRpd3uS2yqje+LHeyIFXo3TYoEN+TZjSDcLqiHk4PfdamyJwPgfVd+UOiYBq3DhR
	V2V23aUxuKo3s+SaQZIbhuMSmIG1S58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793461282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adKF+/16oB5fPj8XuXUVBYhv33mreVQ4r+QFdURTeYk=;
	b=f2S0zSisRGFXy+MkBz4IlvSSrK6ok+8QksBB8ZyLLx8nj2Q2+00abpPR4McPzVjmDvOR11
	pmxTBLudUkJtUeDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAAE613432;
	Sat, 31 Oct 2026 15:41:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1DopICEM5mpIGgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 31 Oct 2026 15:41:21 +0000
Date: Sat, 31 Oct 2026 16:41:21 +0100
Message-ID: <87a4ntswri.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] ALSA: us122l: Fix NULL dereference at hwdep open and release
In-Reply-To: <20261028074143.14440-1-25031212351@stu.xidian.edu.cn>
References: <20261028074143.14440-1-25031212351@stu.xidian.edu.cn>
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
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,xidian.edu.cn:email]
X-Spam-Score: -12.30

On Wed, 28 Oct 2026 08:41:43 +0100,
YuanZhe Liu wrote:
> 
> usb_stream_hwdep_open() and usb_stream_hwdep_release() pass the result of
> usb_ifnum_to_if() straight to usb_autopm_get_interface() and
> usb_autopm_put_interface(), without checking it for NULL.
> 
> usb_ifnum_to_if() returns NULL once the device is gone, since
> usb_disable_device() clears udev->actconfig on disconnect.  The hwdep file
> can outlive the disconnect: the card is released with
> snd_card_free_when_closed(), so a process that keeps the character device
> open reaches the driver's release callback after the USB configuration has
> been dropped, and interface_to_usbdev() then dereferences the NULL
> interface at offsetof(struct device, parent).  The open callback has the
> same problem when it races with the disconnect.
> 
> Check both lookups and fail the open with -ENODEV; in release, skip the
> runtime PM put when the interface is already gone and still run the rest
> of the per-file cleanup.  Move the us122l->first bookkeeping after the
> checks so that a failed open no longer leaves a stale file pointer behind.
> 
> Fixes: 030a07e44129 ("ALSA: Add USB US122L driver")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

Applied now.  Thanks.


Takashi
