Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793462458;
	b=D1kibwmnV6z8UZjDab4EmXLwPTQaK4KRzySTIcx94oeHpmojZpeOSR2xg6XjneGGOYVf
	 B1I2X4ZJVNWVUIrLGi7GIUwLR+Uojj2rq/fgg9UbeTKr5XmPfRoeh4YLWCf1FQiAFr0KP
	 /9ZXkl/r2/RY7TIkzIaRBiScVCp1MB+lBdvIHDZPQxSBgo8stdEfA+a2uVE75JFuili7W
	 uIIrqEC4BuH5WyYaUs6s8J4xiaZhn/iBGvxX+DZlrt3cMpJaeDnKzsvCbH8nvF0ez/Q5k
	 eeM2HnEQecTQYPUv+aUNc0p1wbdwabtlMdmKj8lUiDPnHJUMmtnx6KT1yfWeqFZELZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793462458;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=MNotx4ctJ7Sv8VXy1bkUgfm/iUsmnbgUAgePiQUKfFc=;
	b=PyUJxxJDDmXczdZcg2hymhbAb5BMRJEo09LetWlEi7vRXt+rXkEkjhTWbTB22BFB7Sgb
	 aTorTzrEU9CC09C9Yq488cif/nAP+4I0vYYCXXSNKyMxFBUONuAwQT8fbdopfJmm6DSs9
	 pYfars7HRPGDHMnTi5vUMhzjYXHoBhL7LPRKiQBIk4bUGtGqoIqFYGDxf0Y6/RMSxgUNJ
	 a5iyg88P9aXsbYj5jmwivvedSWpll3NxcsST2cWFdqTEiPdK1M/pBYlw2QJIC092oOGT+
	 udmhTVzIQTA9ga0TRcQtpuhYuIDkYXi+zLIZlzpe28PNJUxZRH6sCbyxXWjMkIYfGzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=REjGAP7O;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7Z6f1608;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=l31M0BWs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aLCtAd3s;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BD5606A31A;
	Sat, 31 Oct 2026 16:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8BD5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=REjGAP7O;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7Z6f1608;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=l31M0BWs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aLCtAd3s
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B7B22229F;
	Sat, 31 Oct 2026 16:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793462456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MNotx4ctJ7Sv8VXy1bkUgfm/iUsmnbgUAgePiQUKfFc=;
	b=REjGAP7ORQJ5jVjwEdTyvGT6fpV4HdFrkE2oAeMbYpDOOLz7dGd7JOTbxLI9Y1GrLfksGv
	d6RUNLaSdZeVJvWyzO3jFnUg8ZVFexMeZWBCrEAVlY9Ce8tVl6yPy+/HOkSgMBBNjw+XBi
	GlATvULC5eW5YCqAXMJfeHVlA1fQwPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793462456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MNotx4ctJ7Sv8VXy1bkUgfm/iUsmnbgUAgePiQUKfFc=;
	b=7Z6f1608j6NhsC/N0HyTOcV0nJuu+4MGsBd4v3BNLeyOvW+L1Mox0GYjMbvU8athPV2Xpr
	woZCRzjUrFwgmiDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793462453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MNotx4ctJ7Sv8VXy1bkUgfm/iUsmnbgUAgePiQUKfFc=;
	b=l31M0BWsj44kWSHta7tbm+KjiLH8+EyAUGIrWuuR75ltqd6XnEqG40Xn+5a+tz1DH6j+Jo
	Ru5dJ6dUvhy906m227Z2s2wh3XuKHq5NpP/I+IxgbldHMPXj433fiHkjFJdhsw/0/xYKVe
	tnwhWkHf9Jc1DrYP8DsXG+c3AfabGJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793462453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MNotx4ctJ7Sv8VXy1bkUgfm/iUsmnbgUAgePiQUKfFc=;
	b=aLCtAd3stDSa2xh8xPwoHOpSWewJc9z6wqiJkG2ccAk2M1DzfAaLn4+JZTP4JHH7kJ3ugR
	+xB5DO5qVq+MdoBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44A1813432;
	Sat, 31 Oct 2026 16:00:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 65DdB7UQ5mpCLgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 31 Oct 2026 16:00:53 +0000
Date: Sat, 31 Oct 2026 17:00:52 +0100
Message-ID: <87zevtrhaj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] ALSA: hwdep: Serialize DSP load requests
In-Reply-To: <20261029084810.21910-2-25031212351@stu.xidian.edu.cn>
References: <20261029084810.21910-1-25031212351@stu.xidian.edu.cn>
	<20261029084810.21910-2-25031212351@stu.xidian.edu.cn>
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
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xidian.edu.cn:email]
X-Spam-Score: -12.30

On Thu, 29 Oct 2026 09:48:09 +0100,
YuanZhe Liu wrote:
> 
> The check of the loaded DSP indices and the call of the driver's
> dsp_load callback in snd_hwdep_dsp_load() are not serialized.  A hwdep
> file descriptor can be shared among threads, or inherited across fork,
> so two SNDRV_HWDEP_IOCTL_DSP_LOAD requests for the same index can both
> observe the index as unloaded and enter the driver's callback
> concurrently, even though the device itself is opened exclusively.
> 
> This breaks the assumption behind hw->dsp_loaded that a firmware index
> is loaded only once.  For example, snd-usb-usx2y hits
> WARN_ON(usx2y->as04.buffer) in usx2y_async_seq04_init() and may
> allocate the US-428 sequence URBs twice.
> 
> Serialize the check, the callback invocation and the bookkeeping with a
> per-hwdep mutex, so that the second request returns -EBUSY.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

Applied this one.  Thanks.


Takashi
