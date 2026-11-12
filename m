Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487002;
	b=iKu5C1ELHipcT80yBOf8oOCv/NOW9bYK8k7I7W1HHHEhxIM46b4VdrRq3vdnlSy6yit0
	 ZG8LO4PCgwQINjZ88mEyjkG2cADkObrPe4Kbd6co5U0OfsBtA4di2ileLn6Tjf0lmrmLx
	 XpNSdwAQzuV1egzrLc5B2VuvXbdS9YnMnOBtu8gnIQEGQFNfeqDhQsjZmoKakLoWwNxMV
	 8nA7xYb3HtyH3YiHZ0MCDv+n1soOoTaFEebNDXSG3Kb1pPOkkPQASFBCtl96dqxVxqOxU
	 bU1vduBuX+C0QkGGE7bgIuqVw0hRyX8O3vh0E1NRQHG81ZK7TfDUdFJ0VG7Tgr/BRtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487002;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=HyllCKR4MF2ZMCZhylsLeCOzuHqRvCbaNHbZtaaQqIw=;
	b=L6ARCkOPPmUqSIvp8U0FChA0GZi7PLY7BjjyKas27WU3yUmYW5IvdutgrmD5wAqiZGsl
	 uyfHH0QrGqT1L368X4DC6hRpzZzImCUL93kov6ke7BNrUqwybHU4PNkZ0l1hW1QBVpAim
	 uqB+zA20yKdiQLa7TzNXRnJFrr61Klva4jxZYh3nooj+Lajcm8FT/EK1cGc+alhgMwyLa
	 6hSlL/bY0tCy4LrvCFMni6O+3ouf9eoJVE55C5M07rTUvy0qEF0iY7H3iWrFcXqoT7722
	 V8CHg8lXkzmfmt95qZpzAuTZqKlsrfMZOebh+9kWhp6LNGdQf0jIpr+nt8q1Qqj0sAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lroyVnPe;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0LD8RjGO;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lroyVnPe;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0LD8RjGO;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DA6606A323;
	Thu, 12 Nov 2026 12:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98DA6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lroyVnPe;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0LD8RjGO;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lroyVnPe;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0LD8RjGO
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C94821E08;
	Thu, 12 Nov 2026 12:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794486998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HyllCKR4MF2ZMCZhylsLeCOzuHqRvCbaNHbZtaaQqIw=;
	b=lroyVnPeeuEYsVlKinnrf1OVO7/u0Ep2nvdnUM3P+NBTf7Nx86+da1+j3RGLA1A4bM/xnV
	4pSl+jFN6Bpr4CcRpbPDz29h3wVC2ZZWblYQrXusKsGPH394+lYw61itzyD9J4vrN5kJ5J
	Od8Ph0xDYFOI6mjOjOEyWWMNdHGJblA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794486998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HyllCKR4MF2ZMCZhylsLeCOzuHqRvCbaNHbZtaaQqIw=;
	b=0LD8RjGOE0g2N95YBCZY8cxNUegh/AkSTaoezHwIIsD0LRkhFfe8vBvoGMUgT2B3srX2mV
	3XjzcO5UgZPJYiCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lroyVnPe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0LD8RjGO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794486998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HyllCKR4MF2ZMCZhylsLeCOzuHqRvCbaNHbZtaaQqIw=;
	b=lroyVnPeeuEYsVlKinnrf1OVO7/u0Ep2nvdnUM3P+NBTf7Nx86+da1+j3RGLA1A4bM/xnV
	4pSl+jFN6Bpr4CcRpbPDz29h3wVC2ZZWblYQrXusKsGPH394+lYw61itzyD9J4vrN5kJ5J
	Od8Ph0xDYFOI6mjOjOEyWWMNdHGJblA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794486998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HyllCKR4MF2ZMCZhylsLeCOzuHqRvCbaNHbZtaaQqIw=;
	b=0LD8RjGOE0g2N95YBCZY8cxNUegh/AkSTaoezHwIIsD0LRkhFfe8vBvoGMUgT2B3srX2mV
	3XjzcO5UgZPJYiCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 454E113432;
	Thu, 12 Nov 2026 12:36:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GHiUBtay9Wr4SwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 12 Nov 2026 12:36:38 +0000
Date: Thu, 12 Nov 2026 13:36:37 +0100
Message-ID: <87mrrerzu2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sergei Nizovtsev <snizovtsev@cloudlinux.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Daniel Mack <zonque@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: caiaq: Kill EP1 URB before unregistering the input device
In-Reply-To: <20261112094904.2430318-1-snizovtsev@cloudlinux.com>
References: <20261112094904.2430318-1-snizovtsev@cloudlinux.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,gmail.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 9C94821E08

On Thu, 12 Nov 2026 10:48:54 +0100,
Sergei Nizovtsev wrote:
> 
> snd_disconnect() unregisters the input device via
> snd_usb_caiaq_input_disconnect() and only afterwards kills the EP1
> command URB (cdev->ep1_in_urb). The EP1 completion handler
> usb_ep1_command_reply_dispatch() feeds snd_usb_caiaq_input_dispatch()
> for EP1_CMD_READ_{ERP,ANALOG,IO} replies, which report into
> cdev->input_dev. Since commit b04dcbb7f7b1 ("ALSA: caiaq: Use
> snd_card_free_when_closed() at disconnection") the input device is
> unregistered from snd_usb_caiaq_input_disconnect() but cdev->input_dev
> is cleared only later, in snd_usb_caiaq_input_free() from the card
> destructor. As the dispatch guard only tests cdev->input_dev for NULL,
> an EP1 reply that completes after input_unregister_device() but before
> cdev->ep1_in_urb is killed reports into an input device that has
> already been unregistered and, with no evdev client holding it open,
> freed.
> 
> Normally the window is closed by the USB core: usb_unbind_interface()
> calls usb_disable_interface() before ->disconnect(), which flushes the
> EP1 URB as long as endpoint 0x81 belongs to the interface being
> unbound. But caiaq addresses EP1 through the device-wide pipe
> usb_rcvbulkpipe(usb_dev, 0x1) without checking which interface owns
> the endpoint. If a device declares it in another interface, the URB
> stays live across snd_disconnect() of the interface that owns the card.
> 
> This needs a crafted device descriptor; a device that has EP1 in the
> interface caiaq is bound to is not affected.
> 
> Kill cdev->ep1_in_urb (and the paired midi_out_urb) before the input
> and audio disconnect helpers, so no EP1 completion can run once the
> input device has been unregistered.
> 
> Reproduced under KASAN with raw-gadget + dummy_hcd emulating an Audio
> Kontrol 1 (17cc:0815) with the EP1 bulk pair in interface 1: only
> interface 0 was bound to snd-usb-caiaq and then unbound through sysfs
> while the gadget flooded EP1 with EP1_CMD_READ_ERP replies. With no PCM
> stream running the window is very short and was only hit by stalling
> the unbinding CPU with a kgdb breakpoint at
> snd_usb_caiaq_audio_disconnect(). With the fix applied, the same test
> runs clean.
> 
>   BUG: KASAN: slab-use-after-free in input_event+0x3a/0xc0
>   Read of size 8 at addr ffff8880151a4028 by task sh/118
> 
>   Call Trace:
>    <IRQ>
>    input_event+0x3a/0xc0
>    snd_usb_caiaq_input_dispatch+0xab2/0xf00
>    usb_ep1_command_reply_dispatch+0x1f3/0x580
>    __usb_hcd_giveback_urb+0x246/0x400
>    dummy_timer+0x1415/0x3380
>    __hrtimer_run_queues+0x39d/0x800
>    hrtimer_run_softirq+0x187/0x2d0
>    handle_softirqs+0x1ff/0x930
>    __irq_exit_rcu+0x15b/0x210
>    irq_exit_rcu+0xe/0x20
>    sysvec_apic_timer_interrupt+0x81/0xb0
>    </IRQ>
>    <TASK>
>    asm_sysvec_apic_timer_interrupt+0x1a/0x20
>   RIP: 0010:snd_usb_caiaq_audio_disconnect+0x0/0x70
>    snd_disconnect+0x81/0x110
>    usb_unbind_interface+0x1a0/0x860
>    device_release_driver_internal+0x2c5/0x470
>    unbind_store+0xde/0x100
>    </TASK>
> 
>   Allocated by task 80:
>    input_allocate_device+0x47/0x340
>    snd_usb_caiaq_input_init+0x4c/0x1ac0
>    snd_probe+0xab3/0x1160
>    usb_probe_interface+0x2ea/0x810
> 
>   Freed by task 118:
>    kfree+0x1ea/0x5c0
>    input_dev_release+0xab/0xd0
>    device_release+0xcf/0x250
>    kobject_put+0x169/0x320
>    snd_disconnect+0x79/0x110
>    usb_unbind_interface+0x1a0/0x860
> 
> Fixes: b04dcbb7f7b1 ("ALSA: caiaq: Use snd_card_free_when_closed() at disconnection")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sergei Nizovtsev <snizovtsev@cloudlinux.com>
> Assisted-by: Claude:claude-opus-4-8

Applied now.  Thanks.


Takashi
