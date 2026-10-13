Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E73EC832;
	Tue, 13 Oct 2026 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791875337; cv=none; b=mbLdTFPsfktir6PVjqKJQ3TICNDv6igB7jsxD9V1rPemXZJ462T5OtUy4hln6XbyAlbvUAi6q506mJRTRLqDOGP5J8768Ce4g6rnXzQLiS8Z1lCdPdh5itOA4+rzHjaLb2ct8cdPFDRvn+JmxllNvu3twNQh+jIDooKpEbDExNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791875337; c=relaxed/simple;
	bh=xzhuf8a3G/yxRZCY2nwsVEPZErnxAUGz5psyiIf3LVg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuVA9jWNHl7X+i9zDxBq06QLzZArmjBEkc3SZDJqTtFqDaVMEjW8ByksPiOdJPgJHwpTx06ucJIdfOkIAy4V5Kf9YSYvLGLfDWN5eB2frtJI6d3k8qD2D6uIBNFTo3KVuJhpfhhfmJXjkXCiupSyJKayQl9SxtiA3I4pFmkUmv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jva6r1C6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VA1cs4a/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jva6r1C6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VA1cs4a/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jva6r1C6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VA1cs4a/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jva6r1C6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VA1cs4a/"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2DA7021FAD;
	Tue, 13 Oct 2026 07:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791875333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6un9ydNa8WO2U6ub8r+hhTamB2qDnnKMVBME28k5wc=;
	b=jva6r1C6W1ScY0eYPb9dLLIeolSQpi1ckoU5SZPqQ/tKovBm7luIcvJWG+d5wLkAWDVlp6
	SseI216ueiEksGJywTF1z/Dtq0zo3EQaikWgDAmyJA2GreeXWCAXpkTga5NdaL6WzL941i
	It/YQTM654VPIqqmWJcPremYt9N1dcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791875333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6un9ydNa8WO2U6ub8r+hhTamB2qDnnKMVBME28k5wc=;
	b=VA1cs4a/ASvEvQQ6O95DNnjYmgNNqRj//sS60m3MSG0cBlQIINEeJdFdqEJppfZo9TQHbS
	xhiMBUqYMGbyObDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jva6r1C6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="VA1cs4a/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791875333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6un9ydNa8WO2U6ub8r+hhTamB2qDnnKMVBME28k5wc=;
	b=jva6r1C6W1ScY0eYPb9dLLIeolSQpi1ckoU5SZPqQ/tKovBm7luIcvJWG+d5wLkAWDVlp6
	SseI216ueiEksGJywTF1z/Dtq0zo3EQaikWgDAmyJA2GreeXWCAXpkTga5NdaL6WzL941i
	It/YQTM654VPIqqmWJcPremYt9N1dcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791875333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6un9ydNa8WO2U6ub8r+hhTamB2qDnnKMVBME28k5wc=;
	b=VA1cs4a/ASvEvQQ6O95DNnjYmgNNqRj//sS60m3MSG0cBlQIINEeJdFdqEJppfZo9TQHbS
	xhiMBUqYMGbyObDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2C9C1349D;
	Tue, 13 Oct 2026 07:08:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NwX6JQTZzWqlSwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Oct 2026 07:08:52 +0000
Date: Tue, 13 Oct 2026 09:08:52 +0200
Message-ID: <87bj8yoz5n.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Yuanzhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH] ALSA: line6: Clear prev_fbuf on capture buffer release
In-Reply-To: <20261013063554.571-1-25031212351@stu.xidian.edu.cn>
References: <20261013063554.571-1-25031212351@stu.xidian.edu.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2DA7021FAD
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,xidian.edu.cn:email,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Score: -3.51

On Tue, 13 Oct 2026 08:35:54 +0200,
Yuanzhe Liu wrote:
> 
> From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> 
> A KASAN slab-use-after-free read was reported in submit_audio_out_urb()
> when generating an impulse test signal:
> 
>   BUG: KASAN: slab-use-after-free in create_impulse_test_signal sound/usb/line6/playback.c:76 [inline]
>   BUG: KASAN: slab-use-after-free in submit_audio_out_urb+0x1848/0x1b20 sound/usb/line6/playback.c:249
>   Read of size 2 at addr ffff888008d74870 by task syz.2.3214/7785
> 
>   Allocated by task 11:
>    kmem_cache_alloc_noprof+0x2f0/0x390 mm/slub.c:4144
>    line6_buffer_acquire+0x1a1/0x220 sound/usb/line6/pcm.c:158
>    line6_pcm_acquire+0xb6/0x230 sound/usb/line6/pcm.c:329
>    line6_startup_work+0x3c/0x50 sound/usb/line6/driver.c:728
> 
>   Freed by task 7785:
>    kfree+0xf8/0x390 mm/slub.c:6566
>    line6_buffer_release sound/usb/line6/pcm.c:176 [inline]
>    line6_buffer_release+0xa5/0xf0 sound/usb/line6/pcm.c:170
>    __line6_pcm_release sound/usb/line6/pcm.c:305 [inline]
>    line6_pcm_release+0x5a/0x80 sound/usb/line6/pcm.c:313
>    snd_toneport_monitor_put+0x11b/0x190 sound/usb/line6/toneport.c:183
> 
> line6pcm->prev_fbuf points into the capture PCM stream buffer
> (line6pcm->in.buffer), which is updated during audio_in_callback() to
> feed rate synchronization, software monitoring, and impulse test signal
> generation on playback side.
> 
> When all capture streams are closed, line6_buffer_release() frees
> pstr->buffer with kfree().  However, it does not clear line6pcm->prev_fbuf.
> If playback is subsequently started (e.g. via impulse test signal
> volume control snd_line6_impulse_volume_put()), submit_audio_out_urb()
> dereferences the stale pointer line6pcm->prev_fbuf under in.lock,
> resulting in a slab-use-after-free read.
> 
> Clear prev_fbuf and prev_fsize in line6_buffer_release() when releasing
> the capture stream buffer under in.lock, ensuring that no stale buffer
> pointer can be accessed by submit_audio_out_urb().
> 
> Fixes: 63e20df1e5b2 ("ALSA: line6: Reorganize PCM stream handling")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

Applied to for-next branch.  Thanks.


Takashi
