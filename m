Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8CF49A3CC;
	Mon, 28 Sep 2026 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790593894; cv=none; b=hQRWylm3sIK34xrAw7RrJWNqSXw0irgTUeVrq0tM/uzhywLzh4BLi+QET4I+ZTCo9qbXHZ21hLT/2Uv2ABffzRFTQvbSeZjb9RQOrvqOdyazw6Mb+gLgtDKBrdapkzE6SByaMrTAr2VwPVEggceX/CPCMfrW/YbSayGv52DklCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790593894; c=relaxed/simple;
	bh=NbCiFWqnGxbYaCRcjj67KiMGW4AXKN8jJ+S9aI/SteY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBWrd2xmxivJgZtWOQCJ1dS+BhCCuHhWZoNAEyNJEGzxbrKsghM5O4t/fD+bJFZ5U9XahH9o7vIvnunZ7N2n8tDz8x0mPj2qsQTzxckDgYHS1YROtd6lZDiWEHbSGoeae0PmkSlF90bCI9q5Y6dpKBDN1pDUGTyMGe+oyg6UxcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dyRTkc/V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zuXeg/xf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=usEbJrGG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QNaRSMbd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dyRTkc/V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zuXeg/xf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="usEbJrGG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QNaRSMbd"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE41E226EE;
	Mon, 28 Sep 2026 11:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790593886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sN0ChmT1PKvUnPHmCR7IvpmNNaU6CxDz7TXzojTsKK4=;
	b=dyRTkc/VnZVYKDbm9kWWCgyVMqSwTvgD3ysj2oKN/DR/als4KoZ1iZJIXH6aqdAuQmjp7R
	7zAUj62Y1S05HJ+5PeEsU8O7bzc7L3rbSc0ZcnAz/U2nkREBQr1RU79Lu08HyRVtoqRavG
	w8yBeQXuPfMbESvxv9wJjUDspJr9ihw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790593886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sN0ChmT1PKvUnPHmCR7IvpmNNaU6CxDz7TXzojTsKK4=;
	b=zuXeg/xfwl/qg+F/WOwZGh3YogGP0gPikC7ZPU8RmOlD5v+35xU7bFe1z8rMKXeF7MbDnM
	TFpCIBNoTi5qjtBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790593882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sN0ChmT1PKvUnPHmCR7IvpmNNaU6CxDz7TXzojTsKK4=;
	b=usEbJrGGc0GBXFgE4C2L0J+mWGcnIxzDmAM/ebicTwHgsEANdMgokBj4PyO8mEtMGHgX38
	6WVTYHZTrMKWJt32uEXEYb6dJtCkQ+79o8ApAAS09VuToAQ6AhMG4WVeqHwMT03AUivv6d
	OikAgnP6npxGkkpX2V3/M9hfKCnk/BQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790593882;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sN0ChmT1PKvUnPHmCR7IvpmNNaU6CxDz7TXzojTsKK4=;
	b=QNaRSMbdptRs2FmQuNxPkISzENxzbib5WdHX8Vs7DZ1/eNyo1lenM3ESNy5gjRlcwxHV3u
	ARNg5HLHK4i+3KDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 699941340F;
	Mon, 28 Sep 2026 11:11:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ziWxEFpLumqkKwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 28 Sep 2026 11:11:22 +0000
Date: Mon, 28 Sep 2026 13:11:21 +0200
Message-ID: <877bk57hra.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Xiang Mei <xmei5@asu.edu>
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+be8fa7ea6f77fdce@bugs.sh,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: line6: reject oversized playback packets
In-Reply-To: <20260918234014.1318325-1-xmei5@asu.edu>
References: <20260918234014.1318325-1-xmei5@asu.edu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[be8fa7ea6f77fdce];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO

On Sat, 19 Sep 2026 01:40:14 +0200,
Xiang Mei wrote:
> 
> Each playback URB is handed a slice of out.buffer that is exactly
> LINE6_ISO_PACKETS * max_packet_size_out bytes, sized from the OUT
> endpoint, but the number of bytes written into that slice is never
> compared against it.
> 
> submit_audio_out_urb() takes the frame count from prev_fsize, which
> audio_in_callback() derived from the *IN* endpoint's received packet
> length, and rescales it with the playback frame size; when prev_fsize is
> still zero it synthesizes a length from the sample rate instead.  On a
> device declaring a large IN wMaxPacketSize and a small OUT
> wMaxPacketSize, the resulting memcpy(), or the memset() when the
> playback stream is idle, runs past its slice and, as the reproducer
> below shows, beyond the allocation.
> 
> usb_submit_urb() is not a backstop.  max_packet_size_out comes from
> usb_maxpacket(), which returns only the low 11 bits of wMaxPacketSize,
> while USB core validates a high-speed isochronous length against that
> base scaled by usb_endpoint_maxp_mult().  A length of up to three times
> the allocated slice is therefore accepted, and even a rejected URB is
> only rejected after the write.
> 
> Reject a packet that does not fit the slice the driver allocated for it.
> Clamping it instead would silently shorten the capture-derived rate
> feedback and desynchronize the two streams.
> 
>   BUG: KASAN: slab-out-of-bounds in submit_audio_out_urb (sound/usb/line6/playback.c:229)
>   Write of size 1024 at addr ffff888100bbd400 by task kworker/1:2/5002
>   Workqueue: events line6_startup_work
>   Call Trace:
>    __asan_memcpy (mm/kasan/shadow.c:106)
>    submit_audio_out_urb (sound/usb/line6/playback.c:229)
>    line6_submit_audio_out_all_urbs (sound/usb/line6/playback.c:291)
>    line6_stream_start (sound/usb/line6/pcm.c:194)
>    line6_pcm_acquire (sound/usb/line6/pcm.c:337)
>    line6_startup_work (sound/usb/line6/driver.c:728)
>    process_one_work (kernel/workqueue.c:3396)
>    worker_thread (kernel/workqueue.c:3479 kernel/workqueue.c:3560)
>    kthread (kernel/kthread.c:436)
>    ret_from_fork (arch/x86/kernel/process.c:158)
>    ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> 
>   The buggy address belongs to the object at ffff888100bbd400
>    which belongs to the cache kmalloc-256 of size 256
>   The buggy address is located 0 bytes inside of
>    allocated 256-byte region [ffff888100bbd400, ffff888100bbd500)
> 
> Cc: stable@vger.kernel.org
> Fixes: 7a0f55aeeb8f ("ALSA: line6: Support assymetrical in/out configurations")
> Reported-by: <co+be8fa7ea6f77fdce@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Applied now.  Thanks.


Takashi
