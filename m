Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776818;
	b=FbVv02Us2DXszjBMPuETzvahvME3AfDLdWcKzx/pz/glFBT+zqr3q200dNLW5dTXdAUf
	 6SUz+f7oBY4Duy9BsLvEDeccMfLWe38g9ZjMXxA2uMSiSwBvyfwlxQJzaF95oGzYogfBK
	 sqSOskwdOFMdYyYbiuKo/156XUXQIJjRAMXB9Er+q6krQnXhEXZHBZ/nOLyAKO9nm0dEz
	 CpwJypxR8U/HikqiqZru2KBDsP3quasqBqKqeayKWjG8tuDrL3TFnRvdOCkXFpAyShsFx
	 cOorS/qvIJUZNgIjhMgfMZgbW0gbmAnmaJrPsyWoWoL8SF+q6nM3Xn7AEpSsS+K8vCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776818;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=Ujn0zESg817OmGm9nz5PRQbhLpqdayMti7SZ0+hOQZk=;
	b=FbI+LXXyfTHTOkhAszOC9v0SOz3M0i8QsxVaTp+mdhVRZ83HnJRqLtYHbovyBCFoqI/G
	 XrPn1W5LGENWsypXX2cnTsI9u3RwwaPRKk0PE9nUJGs7MQ0uBkaN+ahgD/1OlrICvtrjc
	 +myPkcehC1sbiB1Cpo8TD7IzJnbFugKn9H4qBHaS0O+gMqVsIknT9ew9sUDZUklU/WwkC
	 NyDdsol1yIyexnwfR+2LOGIYPp4QF6hAupy0uueJQJMns3FdRB+dUp0M4TS42hjSk2/Su
	 os0UrXtR3j/7Spx8IP0Dvh1574yHQUaH3mqGaAL3lUCdYDmkdXtALqorV2V0O7w71eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sWYZIoZ0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FsxFcpgX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sWYZIoZ0;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FsxFcpgX;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001F5606A31B;
	Wed,  4 Nov 2026 07:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 001F5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sWYZIoZ0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FsxFcpgX;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sWYZIoZ0;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FsxFcpgX
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 630AE21FDE;
	Wed,  4 Nov 2026 07:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793776816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ujn0zESg817OmGm9nz5PRQbhLpqdayMti7SZ0+hOQZk=;
	b=sWYZIoZ0HPE9h9dB1dsiJ40svkvO2dWIhBi6yknCsAzBaCNPBowkXYqEJn3Q0oMeYrNu9Y
	PoD/ahek9PfaD/Cu6FIVgf+ED787Q4SktB8FmCFcdUzLOjeVNXsrYW3s91onyHOTX2ow3u
	NmF7GdyvaqerujYRgldi9FefyiZMhlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793776816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ujn0zESg817OmGm9nz5PRQbhLpqdayMti7SZ0+hOQZk=;
	b=FsxFcpgXuOZZV0K/79PgGENrkhSJjTOidCi+nZadeJyiXxnpPZZgvD88zdANAoQSIdpUDO
	pvj4slTDXTdlgqDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793776816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ujn0zESg817OmGm9nz5PRQbhLpqdayMti7SZ0+hOQZk=;
	b=sWYZIoZ0HPE9h9dB1dsiJ40svkvO2dWIhBi6yknCsAzBaCNPBowkXYqEJn3Q0oMeYrNu9Y
	PoD/ahek9PfaD/Cu6FIVgf+ED787Q4SktB8FmCFcdUzLOjeVNXsrYW3s91onyHOTX2ow3u
	NmF7GdyvaqerujYRgldi9FefyiZMhlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793776816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ujn0zESg817OmGm9nz5PRQbhLpqdayMti7SZ0+hOQZk=;
	b=FsxFcpgXuOZZV0K/79PgGENrkhSJjTOidCi+nZadeJyiXxnpPZZgvD88zdANAoQSIdpUDO
	pvj4slTDXTdlgqDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E6F3134A5;
	Wed,  4 Nov 2026 07:20:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1Kq3Na/c6mokMQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 04 Nov 2026 07:20:16 +0000
Date: Wed, 04 Nov 2026 08:20:15 +0100
Message-ID: <87qzh1ukpc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sinan Turunc <enscrpt@pm.me>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: line6: Reject capture buffers smaller than two packets
In-Reply-To: <20261103132227.696-1-enscrpt@pm.me>
References: <20261103132227.696-1-enscrpt@pm.me>
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
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,pm.me:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30

On Tue, 03 Nov 2026 14:22:44 +0100,
Sinan Turunc wrote:
> 
> line6_capture_copy() splits the copy into the ALSA ring buffer once at
> the buffer end and wraps pos_done once, which is only correct when one
> packet holds at most buffer_size frames. The packet size comes from the
> device's endpoint, and the per-device hw structs allow 64-byte periods
> with periods_min 1, so a packet can be larger than the whole buffer.
> audio_in_callback() logs an oversized packet and then copies it anyway.
> 
> The packet size is known at probe time, so constrain
> SNDRV_PCM_HW_PARAM_BUFFER_BYTES in snd_line6_capture_open() to at least
> twice the larger of the two endpoints' packet sizes. Two rather than
> one, because pos_done advances by the packet and wraps once, so a buffer
> of exactly one packet leaves the position unchanged after every packet.
> hw_params then rejects a buffer that cannot hold two packets, and the
> single wrap is valid for every configuration that gets through. Keep a
> guard in line6_capture_copy() that drops an oversized packet with a
> ratelimited error, for the case that should no longer be reachable.
> 
> Reproduced on 7.3-rc7 with a USB/IP device presenting the GuitarPort
> interface layout and 1024-byte packets into a 128-byte buffer: ALSA
> logged "invalid position: pos = 224, buffer size = 32" and the driver
> logged "driver bug: len" on every following packet. With this patch a
> 1024-byte buffer is refused at hw_params, and a 2048-byte buffer streams
> for 30 s with no report and with the position moving inside the buffer.
> 
> Fixes: 705ececd1c60 ("Staging: add line6 usb driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sinan Turunc <enscrpt@pm.me>

Applied now.  Thanks.


Takashi
