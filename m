Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793462442;
	b=uMa76AqeUoXadQ7X8Sdk7OSfx50sIa8lS7SLgKA0t3o2rgO+zU68F1kt8E/kWxf1dzMz
	 p2NvWsokxSg5Xa58DiP5Um5alUKw8Mvoep0co1t6Ey2N0YcwNuqkvxHpvSE6PR7e/GEnT
	 cl7kK2aybM/54opqix+j4qbheudK1Z2V0bl8iRfruBNRYkNEDwk3pEfMM91oqaOOZwHG5
	 dTCF/AAzhLm27v62HDHQ/Sadr30/y3MazoRb+YkcfZbCfoE5UlxrWM4xkqCvNHz7wj0c9
	 ED7hURdUH258/KEOnqPVCJ8NGr/3ufuMnb06z3SY/aVGYiz8CULic1GSGX74js3QGVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793462442;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=/nagfbrdIPWsHIIQYCqylNa+OHehKf/jEtswsRV35fg=;
	b=UlGVyfAUaodIco1aGnOxYj1lymc/4ALrPMKoSO+DGTwTY0u003l7W5baknCFB4d4EtGe
	 9s8wG913W+kIk+WokKC6BKQKVk0IjGlJNce81zZAvOEFsKo0ljvQp33o/iPZ9X7itMBMX
	 6KVvZhlwG4a2NYoAt5tfGeQ4UhPVxapOF1VjCtoQLayT5WA7dHw67C6jO0Nu5IE8abNZw
	 bbD90OhPo/OHQiOExplttGleD4oKGNz3USfmF5itED7HVTOLbwuOfHd/TD9RIHCfNcH5C
	 tv2RvOZC8sHsInLmVNTDaUPkcRalPXajjAIVRNLFVHYG1aUxtyrhQjkDvNJu1quxQqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MX7i4hoH;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6SJVXukZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0OVyCxUX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wFe6zLVE;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4BD606A31C;
	Sat, 31 Oct 2026 16:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F4BD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MX7i4hoH;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6SJVXukZ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0OVyCxUX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wFe6zLVE
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AB5C92229F;
	Sat, 31 Oct 2026 16:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793462440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/nagfbrdIPWsHIIQYCqylNa+OHehKf/jEtswsRV35fg=;
	b=MX7i4hoHyo/F6wTsbZnwh9FZGRFm6G3fZACYf8cg3bd14ZxnNJsh3DiIBCWOFlTPXOQV8e
	PptjpXvbwgCMwOGekLgJKRqncl9tDjrrQV9NulcG3XwXufm3JvQsidYNU4uEv49q+ZZrPb
	DwayCME/9G7LkiHyT15+P8dZTwYWGUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793462440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/nagfbrdIPWsHIIQYCqylNa+OHehKf/jEtswsRV35fg=;
	b=6SJVXukZAnV/SuAPcuPZZVmYKiL5U2DzBC8pInm29i6bl0NHwsyjj7nhG80wAaLNNxUibA
	KvIhX0Y10tk1IuDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793462439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/nagfbrdIPWsHIIQYCqylNa+OHehKf/jEtswsRV35fg=;
	b=0OVyCxUXRX1Gc84U+R8iLvKBQ8ClP7C0DwEc7lFYI0TlkOTYXS3laZcPm+/aLrtT+wqe6Y
	rmTfKM0czl2MgbHGm++0IFLFKqxf7mTi4nESpIMyXZvFSPKVoAVo57IcVQVkt528125/Vj
	CroJLPk8y2E4rQ7uAvSropYBCUTNGyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793462439;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/nagfbrdIPWsHIIQYCqylNa+OHehKf/jEtswsRV35fg=;
	b=wFe6zLVE7X+vjCiNh7AHg/Nn8uwcKWgt6rgfhKuypstvwIJaY7T6MKyycCJ/QVP4GngCE1
	b+OQAoUboB8nAiBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E4AA13432;
	Sat, 31 Oct 2026 16:00:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xaKBCacQ5mqQLQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 31 Oct 2026 16:00:39 +0000
Date: Sat, 31 Oct 2026 17:00:38 +0100
Message-ID: <871p95svvd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ALSA: usx2y: Avoid WARN on a repeated DSP load
In-Reply-To: <20261029084810.21910-3-25031212351@stu.xidian.edu.cn>
References: <20261029084810.21910-1-25031212351@stu.xidian.edu.cn>
	<20261029084810.21910-3-25031212351@stu.xidian.edu.cn>
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

On Thu, 29 Oct 2026 09:48:10 +0100,
YuanZhe Liu wrote:
> 
> snd_usx2y_hwdep_dsp_load() sets up the asynchronous sequence URBs and
> the interrupt URB when the FPGA firmware image (index 1) is loaded.  If
> a later step of the same request fails, for example the creation of the
> ALSA devices, a following DSP load request from user space enters the
> initialization functions for a second time.
> 
> usx2y_async_seq04_init() and usx2y_in04_init() assert with WARN_ON()
> that they are called only once, so such a request triggers a kernel
> warning before returning -EBUSY, although nothing is corrupted: the
> functions bail out without allocating again and the leak that the check
> was added for is still prevented.
> 
> Return -EBUSY without the warning.
> 
> Fixes: 02d382af1c4e ("ALSA: usx2y: Fix potential memory leaks")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

IMO, it's better to fix the error path in snd_usx2y_hwdep_dsp_load()
instead.  The WARN_ON() was meant that it shouldn't happen, and if it
happens, it's something to be fixed, instead.


thanks,

Takashi
