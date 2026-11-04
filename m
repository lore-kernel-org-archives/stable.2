Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776794;
	b=ujLmBuk87XRKLvFFPAUKhkxq8oIgmzpM9mlYcorXHFuSGobmOt+PmpoX4416iw/KcGT3
	 ljgdwQrHQh01PFUHnqRAwEQHbTSu0Dp1giKTf6ZHq7MQs8u3LQ8GXkDGDDBuOJX9ILa4J
	 Gtl8cOf2PfRy7/4ENY3v10OJNkbsZIZLBtHTJ4GoRUUXtKr66brIrIbWq3srjJuxqVGEf
	 lrekzNLpJtkFi6yaWck9rN/KV+stHd36fHDSkFPTg4lfwtHehUerNlf5eWWX+QexscTxl
	 +KE4ayWjUCkNOqUDDawm3m42Dsp4LTKMh/qZCj9hwIGL5qXYYl88Bt9twS/ldKraTDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776794;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=mS4AGPeWSbZlrrJ0pHyD9tT5W4oGW3AhVArTGgQ9Ceg=;
	b=Tv9jQClEfDskvKrYu4YnFWpNR+27jR2eDPc5vyBz3UK1O2LW0WSar7BZJRrekoAX0E2z
	 MAguEm1kGtMTIDyLlVUQr6dsHC+Rjj9MeqrPiapYDYpgFx18UxqkhYoRnKlLKrZ0ljzhD
	 EK3dH4SpIDkxt9yRAFjQ7zzeQSCy2UNogaMi1YUc9MnQAPLMBOrlQX9j0tK3osJAvlsaI
	 +DSQpaQ0Q5SFvKmSqamGzJe/iWpQj/EP49c0MY+qEhr1Ks8j/L2VlDh3HBm20qAOm2oQj
	 L11NxHPaRPnwKggVXH8J0p49hxDTufBwYdDBXrF9koIAVixFWQ8LlMWVhZ21NYzH+Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=G9Qs2ZYO;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GbJS70dl;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=G9Qs2ZYO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GbJS70dl;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E458606A330;
	Wed,  4 Nov 2026 07:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E458606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=G9Qs2ZYO;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GbJS70dl;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=G9Qs2ZYO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GbJS70dl
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 877451F79F;
	Wed,  4 Nov 2026 07:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793776791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mS4AGPeWSbZlrrJ0pHyD9tT5W4oGW3AhVArTGgQ9Ceg=;
	b=G9Qs2ZYOWRYFUVmRdmyj9/M9vPBbsaXPR6SQzt3k+FowdRxAdqW0IZe3MYzttaNiOzOCzM
	5no0RtLdS0qgyX7VT9woWCNPvHPvZNzGDC7cArCbNAQ8VuRflseIkPpdpjwYLJ/ZW3oqmd
	ra57iQmBzHgQFluoo2yKjNJNibMFou8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793776791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mS4AGPeWSbZlrrJ0pHyD9tT5W4oGW3AhVArTGgQ9Ceg=;
	b=GbJS70dl812KTcANuEWr//CER32wZIkcz7eiX/zBNRBshXPLbabFmKAXSxs9z2Ti9cAPJ1
	e+1JAZR2msI3qdAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=G9Qs2ZYO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GbJS70dl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793776791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mS4AGPeWSbZlrrJ0pHyD9tT5W4oGW3AhVArTGgQ9Ceg=;
	b=G9Qs2ZYOWRYFUVmRdmyj9/M9vPBbsaXPR6SQzt3k+FowdRxAdqW0IZe3MYzttaNiOzOCzM
	5no0RtLdS0qgyX7VT9woWCNPvHPvZNzGDC7cArCbNAQ8VuRflseIkPpdpjwYLJ/ZW3oqmd
	ra57iQmBzHgQFluoo2yKjNJNibMFou8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793776791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mS4AGPeWSbZlrrJ0pHyD9tT5W4oGW3AhVArTGgQ9Ceg=;
	b=GbJS70dl812KTcANuEWr//CER32wZIkcz7eiX/zBNRBshXPLbabFmKAXSxs9z2Ti9cAPJ1
	e+1JAZR2msI3qdAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31D3B134A5;
	Wed,  4 Nov 2026 07:19:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZboCAZfc6mr1MAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 04 Nov 2026 07:19:51 +0000
Date: Wed, 04 Nov 2026 08:19:50 +0100
Message-ID: <87se1hukq1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sinan Turunc <enscrpt@pm.me>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: usx2y: Reject buffers smaller than two packets
In-Reply-To: <20261103132247.713-1-enscrpt@pm.me>
References: <20261103132247.713-1-enscrpt@pm.me>
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
X-Rspamd-Queue-Id: 877451F79F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,pm.me:email];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.51

On Tue, 03 Nov 2026 14:23:03 +0100,
Sinan Turunc wrote:
> 
> usx2y_urb_capt_retire() splits the copy into the ALSA ring buffer once
> at the buffer end and wraps hwptr_done once, which is only correct when
> one packet holds at most buffer_size frames. The packet size is the
> endpoint's maxpacksize from usb_maxpacket(), while the hw constraints
> allow 64-byte periods with periods_min 2, so a packet can be larger than
> the whole buffer.
> 
> The endpoint is known at probe time, so constrain
> SNDRV_PCM_HW_PARAM_BUFFER_BYTES in snd_usx2y_pcm_open() to at least
> twice the endpoint's packet size. Two packets, matching the line6 fix.
> The bound makes the copy safe, but it does not make every larger buffer
> progress: the position is reported once per URB of 4 packets, so a
> buffer that divides one URB's data returns to the same position at every
> callback. That was already the case before this patch and is not changed
> here. Keep a guard in usx2y_urb_capt_retire() that drops an oversized
> packet with a ratelimited error, for the case that should no longer be
> reachable.
> 
> Reproduced on 7.3-rc7 with a USB/IP device presenting the US-122
> interface layout and 1024-byte packets into a 512-byte buffer:
> 
>   BUG: KASAN: out-of-bounds in i_usx2y_urb_complete+0x1285/0x1ac0
>   Read of size 18446744073709551104 at addr ffff88800e448800 by task vhci_rx/83
> 
> With this patch a 1024-byte buffer is refused at hw_params; a 2048-byte
> buffer is accepted and safe but barely advances (hw_ptr 9216 after 30 s,
> for the reason above); a 3072-byte buffer streams for 30 s with no
> report and with the position moving inside the buffer.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sinan Turunc <enscrpt@pm.me>

Applied now.  thanks.


Takashi
