Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793461356;
	b=SFLU5oyibY6ttdP5ZifkNbA033UKSwjryQqr28VM+G4xJX5fg9+8NTd15ZHkEAiwThYh
	 1div9EThF4afu1hscrnyvBiiFE8gSlyLaIWU3oVCP56TB7wn4nCnsT5sy6oGklOQVTvxw
	 C8rXfUvjLlpbRZwOl/KyDnGKcLmQ40/hNbayKuJnCpPJ7zYQDE7Dh/hnI6RK6g+6jSXO5
	 eMCp3bhk9BKcCSCV2dYJ0SIEz6SVM0+7K5+/1gZNSX58oOugZM825+LD1F96jOF+fkKXi
	 3zNrmLl1QNwI29k3k/iL8ILqKB3ycP6mcEM2ajCB+7EmkjSdRR0qlcEgIQOZZMbY+sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793461356;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=+HCqbyvL9MfEDwnLplDU6XELRdfevqAJufdv6Zeo1jM=;
	b=OuaE40d1C782bn5QMU3HmRUfGIbXe09KjPpHrszyyoSBCH6F+Ll7E+vJ2txTjMkr5QE8
	 hZ4rRv9o7Y8AI8Izl3dhRj3a4wiSb7MNMweX9E/5hKK2Whp2UuKRmmVTRvJSAKWKUPkZU
	 ZbDmF96Hy5/IEOsonGPD99Mdeiik21iUHwom9ifTxOxrIwOhSYQLJCEp3hC7E4WD14VAL
	 WzvWuelDmAx9ZPExjFUrDXg5HNkO3SCRke8Y0dzCJITmvr3AeXdLqbdJ4nRAnescsao2K
	 oGcaQIqlmwQopm2dPjnbbaGGAQEwHfZVFqN0pP0vc7CyZs4cRwd3zqjdsP91hZcaEag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KMW02RnY;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=fjxhC4zD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mzMS91cA;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=F0BH9SUn;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD5E606A31A;
	Sat, 31 Oct 2026 15:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBD5E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KMW02RnY;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=fjxhC4zD;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mzMS91cA;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=F0BH9SUn
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C16B022313;
	Sat, 31 Oct 2026 15:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793461354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+HCqbyvL9MfEDwnLplDU6XELRdfevqAJufdv6Zeo1jM=;
	b=KMW02RnYzvplvbjxFwIw90in39JmjG4apt12CBzJ3y+Yio+eibrBF6/tz/VpwPGTvPq0fh
	1Vc4FX5C/cOV5w2qtJd+z/CXGUDJJiEKXKloS0247HEgK1qilWYsIpJI1EHmxvY0lQKC+P
	Bmax+ocL7PCLUB8eMrUwpKnGImqdnWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793461354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+HCqbyvL9MfEDwnLplDU6XELRdfevqAJufdv6Zeo1jM=;
	b=fjxhC4zDiJcYepN62Ny5m/1M/+HcOcsFRaZ1U+phlhCzN3YT82EzHvqbeQgirNdjd1iGxI
	sLzSANkuWRsGRIAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mzMS91cA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=F0BH9SUn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793461353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+HCqbyvL9MfEDwnLplDU6XELRdfevqAJufdv6Zeo1jM=;
	b=mzMS91cAjBUX2P4d48u8amUJodGhU7hhUVAuNyZvIsX+Jhmx7G3KZPxq61/IVTu2kXeFWS
	hScOo0qyjQayqvPc/uKw1h7VTAjbXVeI9D9N6K9BIktK5YNvzwtbrElXgaPq1xziM9t5U5
	4ILg+hGXOQqaRvH4MzazWgFmdykaIg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793461353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+HCqbyvL9MfEDwnLplDU6XELRdfevqAJufdv6Zeo1jM=;
	b=F0BH9SUnGj9jSYJA6O76d42OkjlRfjkV34v6Qegsk2WcVQAVX/+iPqRAwnrqjmSzytwep2
	w7t2PNT/uV4Z77Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68AD413432;
	Sat, 31 Oct 2026 15:42:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jnhFEGkM5mpfGwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 31 Oct 2026 15:42:33 +0000
Date: Sat, 31 Oct 2026 16:42:32 +0100
Message-ID: <878q3dswpj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH] ALSA: usx2y: Initialize idle URBs before submitting streams
In-Reply-To: <20261028103158.22996-1-25031212351@stu.xidian.edu.cn>
References: <20261028103158.22996-1-25031212351@stu.xidian.edu.cn>
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
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xidian.edu.cn:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.51
X-Spam-Level: 
X-Rspamd-Queue-Id: C16B022313

On Wed, 28 Oct 2026 11:31:58 +0100,
YuanZhe Liu wrote:
> 
> usb_stream_start() submits the first two capture and playback URBs and
> only afterwards assigns sk->idle_inurb, sk->idle_outurb,
> sk->completed_inurb and sk->completed_outurb to the remaining two URBs
> of each direction.
> 
> A transfer can complete as soon as usb_submit_urb() has been called, so
> the completion handler i_capture_start() or i_playback_start() may run
> before those pointers are set.  While the stream is still being
> synchronized (state below usb_stream_sync1), stream_start() then calls
> playback_prep_freqn(sk, sk->idle_outurb) with sk->idle_outurb still
> NULL, and the packet descriptors are written through that NULL pointer:
> 
>   Oops: general protection fault, probably for non-canonical address
>   0xdffffc0000000018: 0000 [#1] SMP KASAN
>   KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
>   RIP: 0010:playback_prep_freqn+0x11c/0x4a0 sound/usb/usx2y/usb_stream.c:33
>   Call Trace:
>    <IRQ>
>    stream_start+0x5dc/0x8d0 sound/usb/usx2y/usb_stream.c:596
>    i_capture_start+0x3da/0x710 sound/usb/usx2y/usb_stream.c:654
>    __usb_hcd_giveback_urb+0x238/0x550 drivers/usb/core/hcd.c:1657
>    usb_giveback_urb_bh+0x20b/0x530 drivers/usb/core/hcd.c:1691
>    tasklet_hi_action+0xa/0x20 kernel/softirq.c:994
>    handle_softirqs+0x16f/0x440 kernel/softirq.c:645
>    </IRQ>
> 
> The four URBs referenced by these pointers are allocated long before and
> do not depend on any transfer state, so assign them before the submit
> loop.  Keeping the assignment inside the retry path also restores a
> well-defined URB rotation when the start frame mismatch handling kills
> and resubmits the streams.
> 
> Fixes: 030a07e441296c372f946cd4065b5d831d8dc40c ("ALSA: Add USB US122L driver")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

Applied now.  Thanks.


Takashi
