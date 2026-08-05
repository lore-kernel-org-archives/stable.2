Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3BB3E168C
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915415; cv=none; b=RgL/+dDfelvG+P0aKq4bIfTdGdwOujtzYulwf0zegVwX1JpRmrs1lTSxcntWaDkwXbURQPadVHiM6X1hTPmcBU4T/K2XJF/flIv2amCGpSIj8JFhtKXgJ0MwM2bnJ77hFF3wBpzVSd2QgulYMUyaeurdqfbVhDVJKpoEba0r2B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915415; c=relaxed/simple;
	bh=zkcbzNKqZ026JxHeb9/8xJIhH5nslnmzclXRZ8hs7nA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJODJSWwUry0FOvUc67ts/PH1WAAAa+VDk/4VMtOoLbT5vPgxNdZt2RILdJVYd3r5s8VFfmL/9BJfkLw7heRAIUJjfauacxerrjGJnAhIVFyno+4gWpZu8+upLhDYf4+gRdohXKLn/D5mZe+BrkMfsdZkU2x2BG6eu55VyV9qMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KPvHikcL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uvlGNPrp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nLQMTrIx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mx+uCCUt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KPvHikcL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uvlGNPrp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nLQMTrIx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mx+uCCUt"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C0EE7FBF7;
	Wed,  5 Aug 2026 07:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785915407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XnCd+dRJ17nIknXccjO0GgGwQJEMMh4aMl/3loq9md8=;
	b=KPvHikcLkmH1SSX5eZsPuOzyYxOee0odmcKhRgo6/1BmDWbS0B/vGNlOVriG2hpqtf4J6q
	FH02s1+hTsw7MCpcX3Sr88aI7FsQNT6tLUOvYNDFCPXMrZl/nYsFZwiDXBgFyAVrgIpaLc
	5z6Ax8mBPF68zSWRvsEINIfNiLa2+e4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785915407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XnCd+dRJ17nIknXccjO0GgGwQJEMMh4aMl/3loq9md8=;
	b=uvlGNPrpL613jMlvEtbtT3ix9BPthRqUVKcWVd0KLDVxv2GD7C2vxJOyD/1qrW5Mce5Y0I
	NSC57SFIPt46dlBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785915403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XnCd+dRJ17nIknXccjO0GgGwQJEMMh4aMl/3loq9md8=;
	b=nLQMTrIx9+zThnZjlkRHJsxngiHlX0Rgv/85UYYy2QIoEr/roKHwsGc1vY0h0Bu+Gy1HCm
	Ha+HY5xqsEL9LFp6E2Lxk+u9cJm80+T4HB4Ergsry8d+JyiJEbRCFPu5VQQFLtyvOUYvI8
	LK5P0EeVTg6lGrG3hKiGPCmTIgqXIIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785915403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XnCd+dRJ17nIknXccjO0GgGwQJEMMh4aMl/3loq9md8=;
	b=mx+uCCUtzWrfF3KzoRSNL/B25OV2JsgRgT8FjF6qDaHzDyPc1oXb3JCxziecsG/9SH1+I4
	z9T+WxFbmiDsYECg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 445A8779B6;
	Wed,  5 Aug 2026 07:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5dm8DgvocmpMRQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 05 Aug 2026 07:36:43 +0000
Date: Wed, 05 Aug 2026 09:36:42 +0200
Message-ID: <87h5l9ggs5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baul Lee <baul.lee@xbow.com>
Cc: g@b4.vu,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: FCP: do not copy out an uninitialised init response
In-Reply-To: <20260805013804.38839-1-baul.lee@xbow.com>
References: <20260805013804.38839-1-baul.lee@xbow.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.968];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xbow.com:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.29
X-Spam-Level: 

On Wed, 05 Aug 2026 03:38:04 +0200,
Baul Lee wrote:
> 
> fcp_ioctl_init() allocates its response buffer with kmalloc() and copies
> the whole buffer back to userspace:
> 
> 	buf_size = init.step0_resp_size + init.step2_resp_size;
> 
> 	void *resp __free(kfree) =
> 		kmalloc(buf_size, GFP_KERNEL);
> 	...
> 	if (copy_to_user(arg->resp, resp, buf_size))
> 		return -EFAULT;
> 
> Nothing clears the buffer, and the only writer of its leading
> step0_resp_size bytes is the step-0 control transfer:
> 
> 	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
> 		FCP_USB_REQ_STEP0,
> 		USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
> 		0, private->bInterfaceNumber,
> 		step0_resp, private->step0_resp_size);
> 	if (err < 0)
> 		return err;
> 
> usb_fill_control_urb() does not set URB_SHORT_NOT_OK, so a short or
> zero-length data stage completes with status 0 and snd_usb_ctl_msg()
> returns a small actual_length.  The only check is err < 0, so a short
> transfer is accepted as success.
> 
> snd_usb_ctl_msg() copies the full size back unconditionally:
> 
> 	buf = kmemdup(data, size, GFP_KERNEL);
> 	...
> 	memcpy(data, buf, size);
> 
> Bytes the device never wrote are therefore restored into resp unchanged
> and copied to userspace.  step0_resp_size and step2_resp_size are each
> validated only to 1..255, so the caller also picks the slab cache, from
> kmalloc-8 up to kmalloc-512.
> 
> On 7.2.0-rc5 (arm64), device answering step 0 with a zero-length data
> stage, s0 = s2 = 255:
> 
>   # init_on_alloc off, no spray
>   step0 window [0,255): nonzero=94/255
>   000: 00 80 60 06 00 00 ff ff 18 00 00 00 57 01 ea 01
>   010: 08 78 22 13 00 00 ff ff a8 c4 5f 80 00 80 ff ff
> 
>   # same kernel, kmalloc-512 pre-seeded with an 8-byte tag
>   step0 window [0,255): nonzero=219/255  tagbytes=232
> 
>   # identical run, init_on_alloc=1
>   step0 window [0,255): nonzero=0/255  tagbytes=0
> 
>   # all three runs
>   step2 window [255,510): device words matched=62/62
> 
> a8 c4 5f 80 00 80 ff ff is the little-endian kernel text address
> ffff8000805fc4a8.  The step-2 window is unaffected, so the disclosure is
> exactly the step-0 region.
> 
> Zero the buffer, and require the step-0 transfer to deliver the full
> step0_resp_size bytes so a short data stage is reported as an error.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: 46757a3e7d50 ("ALSA: FCP: Add Focusrite Control Protocol driver")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>

Applied to for-next branch now.  Thanks.


Takashi
