Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25C31F942
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785306702; cv=none; b=My2CbpGBtEYPREE7pkKHt7/4LWCJHoZa5Ya9YDzQVmrbJTBfyxM9gJXiGCbFiyYbI+/DRmmnI1N7OCVrG9X8rgV3oDJGbjCWJtWKnx5Ycc4sMC+0Pr83M8RbmuJcV1B4jo9pF/vO1CHmsQE3ih6bn4nq5hfASZJlbDG4K3FEWmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785306702; c=relaxed/simple;
	bh=IHuJABJeN+wc3l4Gx6pZS3BTtFApWSuLjOmnd1tYXVM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbW+q1/1VoEaWrFo+DHlfn2vcnRZ5aNm7Ui48gRqS9wdQJ8tOMDUcWHa0bDMkVu32IJvrhBwyUSkOZWcSwod9xAEiKiciCxcKUJLs11bLYtJEWmppreEaWZwX8IW2t64Yj6nbVq3SmjXJJA3rOJFITME31CSHNNFCSWN51h6AGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X4DheBIn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MxBXvtwh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qGPjnf2g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yGuFkIzP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X4DheBIn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MxBXvtwh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qGPjnf2g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yGuFkIzP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C19927BBD5;
	Wed, 29 Jul 2026 06:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785306694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MbEVYF6WlYDlqekVl+oajNTWhlC+d3HhPHjD2gszl6Q=;
	b=X4DheBInZe5lHmUC/NL0Svpds15uAiFTqvRhZas+cy3BIQkvOD0tfwy2FtC/yF2h15ouC8
	G7R+ts3PpYIKKoLeLFGlvAJ3lgnVhdApZP10zXfQJuox9wlvHYW8cOsm0tKsfhFTBLw7EM
	UcV9NaxbK6h1ssfl/dnFWFGZs6hWgQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785306694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MbEVYF6WlYDlqekVl+oajNTWhlC+d3HhPHjD2gszl6Q=;
	b=MxBXvtwhisYGq1etSnkECJfeFUUvIivV0+jjtLxn7TnBvHlOBG6xg1nGFf/LeUlOgofJsy
	wnxEE6JRfjvOqFCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qGPjnf2g;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yGuFkIzP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785306690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MbEVYF6WlYDlqekVl+oajNTWhlC+d3HhPHjD2gszl6Q=;
	b=qGPjnf2gNAEwjI5YEPC44GYKB+z0VhONh0pfOROz3ogGpuLKaf6OEJ7NsardYvRnTL2zwX
	WlbqS3zNXpKG9KUHkEVd8nRX9TRlhR3okO8UyfzbqWm0khGWU9RRJCmvdw9+TczldUa3Ni
	LaaQbwO029Dp+XqdsVrriMUy4z+x8Xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785306690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MbEVYF6WlYDlqekVl+oajNTWhlC+d3HhPHjD2gszl6Q=;
	b=yGuFkIzPsepSYStwSBVsTXhFnAUKJhM8lYicaRR3krY74PTqMbH2l3/aKzBMLTojlQ5u4x
	E8StD7BFbc+Hq7Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76806779A1;
	Wed, 29 Jul 2026 06:31:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J3eeG0KeaWo7XAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 29 Jul 2026 06:31:30 +0000
Date: Wed, 29 Jul 2026 08:31:30 +0200
Message-ID: <87qzkm5mt9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sonali Pradhan <sonalipradhan@google.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Eldad Zack <eldad@fogrefinery.com>,
	Gordon Chen <chengordon326@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jussi Laako <jussi@sonarnerd.net>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Clamp frame size in implicit-feedback mode
In-Reply-To: <20260728202432.2354994-1-sonalipradhan@google.com>
References: <20260728202432.2354994-1-sonalipradhan@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C19927BBD5
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,fogrefinery.com,gmail.com,kernel.org,sonarnerd.net,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Tue, 28 Jul 2026 22:24:32 +0200,
Sonali Pradhan wrote:
> 
> snd_usb_handle_sync_urb() scales received sync packet sizes by the sender's
> stride and stores the result directly in out_packet->packet_size[i]. If a
> connected USB device sends an oversized sync packet, this frame count can
> exceed ep->maxframesize.
> 
> The un-clamped frame count then propagates to the playback endpoint queue,
> potentially driving packet transfers beyond the endpoint's hardware frame
> limits.
> 
> Cap the calculated frame count against ep->maxframesize in
> snd_usb_handle_sync_urb() to prevent oversized packets from entering the
> playback queue.
> 
> Fixes: 28acb12014fb ("ALSA: usb-audio: use sender stride for implicit feedback")
> Cc: stable@vger.kernel.org
> Assisted-by: Jetski:Gemini-3.6-Flash
> Signed-off-by: Sonali Pradhan <sonalipradhan@google.com>

Applied now.  Thanks.


Takashi
