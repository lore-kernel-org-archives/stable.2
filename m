Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776748;
	b=f0qz5kZrRXFQQgLScQ3WSzxQjwzfjTPLdKqSTMvbyhA7OZ2Y6I8fPlIFk/HsBsOHsDrU
	 qRLTOpM2regRzyjCeWc0ym/SuxOtLI8eXcazTrxkf0dbRnvinhy+h/yIaL0uB8bONFQbc
	 LvSk5dhyB+etuuiVRczMcOsnOdm2S3mZ1862OWP0K+NEgOooLHpNo0L4pcbOs4Z57kFM6
	 map2GpkFscgjiCg0wEzJksxx45oASrV6BQrKjyrDa0SanZ+0FVBXUWuJWr+sIlHYB2v6L
	 vRTdP04RbjnXY3QDeqqpIoZJI1H0mTI4uPbGA943Lrt3Wg1rm3CPDvh6yN4bnvl6B9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776748;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=ymOcuMBWnAn17teBtaL6Dzcc0kww8/jEOnpn70gq8yE=;
	b=Z4UmbqyNVC9xgoSpk34/R36RePSPH8mcVXII6wd1weU82RzlkxUqilnTXB1rrIaWpquR
	 +Epqp75ai0UNvUzYosl68FZ8PSsa9YL5Hr/S5dS2O55yBMh9lpuOJ//IPtL9pY+TkzxqK
	 Nt07R8al1UipGGoBwlZkNzLuh1+Gi75I4ZVHKVBn06VBXb9RiIV20wM43EKJqUwGTePT4
	 VaDWVeO1IwLBuaOzf4ec0aM2oWu5gtsrDdtJjlxDooaVlAS2yahql1PWZnZWRJNZX6Hmf
	 DrwaSdjWgEYqQpAshB/OQOI4A7QPQ1eYB3n9qFCCaU261fcXzKtqQxm7nZlJgW71TLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XUQegrQO;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wpbzvbpb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XUQegrQO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wpbzvbpb;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE37606A31B;
	Wed,  4 Nov 2026 07:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAE37606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XUQegrQO;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wpbzvbpb;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XUQegrQO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wpbzvbpb
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C48ED21FDE;
	Wed,  4 Nov 2026 07:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793776745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymOcuMBWnAn17teBtaL6Dzcc0kww8/jEOnpn70gq8yE=;
	b=XUQegrQOftUdiu3KtLG6WpjWZuQ/ICkRgUd+H/tatQwBVbfKaXk7uYL67XlpZ6EflEnMUg
	rUvG7gJB/mIHQqeNcz4F90ooV/oi2yHyjwzCqhd2zUThZdaTh4sHZkCujAo/cSMDeyWXab
	Y6kv1Ow1vZBkrCb4kwq/QYDOHc/a5i0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793776745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymOcuMBWnAn17teBtaL6Dzcc0kww8/jEOnpn70gq8yE=;
	b=wpbzvbpbcPA0oA8X0JNh7jbS0wBxo63qZ0XrbEMK5N/1vgCo5WbnEZw8qhC0p3Ja0l0Kiw
	1eRGDkLwM/Hhm3CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XUQegrQO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wpbzvbpb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793776745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymOcuMBWnAn17teBtaL6Dzcc0kww8/jEOnpn70gq8yE=;
	b=XUQegrQOftUdiu3KtLG6WpjWZuQ/ICkRgUd+H/tatQwBVbfKaXk7uYL67XlpZ6EflEnMUg
	rUvG7gJB/mIHQqeNcz4F90ooV/oi2yHyjwzCqhd2zUThZdaTh4sHZkCujAo/cSMDeyWXab
	Y6kv1Ow1vZBkrCb4kwq/QYDOHc/a5i0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793776745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymOcuMBWnAn17teBtaL6Dzcc0kww8/jEOnpn70gq8yE=;
	b=wpbzvbpbcPA0oA8X0JNh7jbS0wBxo63qZ0XrbEMK5N/1vgCo5WbnEZw8qhC0p3Ja0l0Kiw
	1eRGDkLwM/Hhm3CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CA6B134A5;
	Wed,  4 Nov 2026 07:19:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GD7OFGnc6mo1MAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 04 Nov 2026 07:19:05 +0000
Date: Wed, 04 Nov 2026 08:19:05 +0100
Message-ID: <87tslxukra.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Alexandr <youdoit@mail.ru>
Cc: linux-sound@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable mute and mic-mute LEDs on HP ENVY 17-cr0xxx
In-Reply-To: <20261103142121.74032-1-youdoit@mail.ru>
References: <20261103142121.74032-1-youdoit@mail.ru>
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
	FREEMAIL_ENVRCPT(0.00)[mail.ru];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[mail.ru];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.51
X-Spam-Level: 
X-Rspamd-Queue-Id: C48ED21FDE

On Tue, 03 Nov 2026 15:21:21 +0100,
Alexandr wrote:
> 
> The HP ENVY Laptop 17-cr0xxx (subsystem ID 103c:8a2e) has mute and
> mic-mute LEDs on the F8 and F5 keys that never light up on Linux: the
> existing quirk entry only sets up the CS35L41 amplifiers.
> 
> The board uses the same LED wiring as the HP ENVY x360 15-ey0xxx
> (103c:8a31): the mute LED is driven by COEF 0x0b bits 3:2 and the
> mic-mute LED by GPIO2 with inverted polarity. Both were verified with
> hda-verb on the actual hardware. Switch the entry to
> ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS, which chains the amplifier
> setup with ALC245_FIXUP_HP_X360_MUTE_LEDS, and use the DMI product name
> of the board.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Alexandr <youdoit@mail.ru>

Applied now.  I added Fixes tag pointing to the original quirk
commit.


thanks,

Takashi
