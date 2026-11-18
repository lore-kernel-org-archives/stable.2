Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006256;
	b=uGqDnPcV7Mlv4UlAn6YnvF874u2hXMJ7smoWw5VirT5v/gmTJqqWcZ5pyUHmeuWfC185
	 8R6o+RPQLmWsHIWOnL4necZiiLKCG61shN+DMSfkZ+K6DJOlkF0YmH5D4RbHf0Mi9lRvj
	 /mjrWBG28djHTq6CfLtDf4iFSzd/TAh2S5yIEx4Ko3OnyROY2teXXL+/ddabPlU5q7OJU
	 hhkUvAzK1rBWef9gTjHsxO9ua8QzBFnFK+6UWwrX9XeK2XzBwkxhzmHxMTMUjM/PwmNUx
	 nAJFD0h9NzSD9n6wRHpv6s3iiL431oih9Cql39u+ESWmuu4Muco2okCq1ao76Y4RiBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006256;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=GDH0Uc8xA8nFTHB+QczAoC92j01+8FV/Hvk/je9m3jE=;
	b=0kg+jdIiF0yQN1z1NHURCAJEofKY8vpcY2JmVPFEHUhP2zFZeU+7g9/jYfajJDKv+TZg
	 YneQd8g9d6q6xk0gnTQzLBxZxbHn/qygGelURN3R2qVZnZ+htBF0BADT+1Y2ZR0hXBcQq
	 bHXWap/0Z8lH9FpAixSujiedGNkXAoOfE0HIzjiFdyZp+DA19Y07sR1wB7OISiU+FQNo7
	 036GLIr9t6/RUmJg6cqgnikSjXLDXvyEpveymNRHzgxsG1RRFFhgJJ5cB6hMbZOpnw5Ke
	 x4htCb20kWjSMi/GyU4ln3wqSNtILd0QmOMX59C2JCPbtYzp42AHEX5yf+8JcnUbb+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zweV+myS;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9Aipow9u;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zweV+myS;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9Aipow9u;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517B2606A31C;
	Wed, 18 Nov 2026 12:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 517B2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zweV+myS;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9Aipow9u;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zweV+myS;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9Aipow9u
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F0C41F8CD;
	Wed, 18 Nov 2026 12:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795006253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GDH0Uc8xA8nFTHB+QczAoC92j01+8FV/Hvk/je9m3jE=;
	b=zweV+mySX0Pp0JxCuhifRvXnL/PjK3fwmoh4KKCDcTeUak5b3mQMmOb5E+GBYKTv3rLm5Y
	k1+Ehen54lPVJmcWt8ModUeVwpizQ45CrxktMPeisNhjcdSTPyjJ+k4ADVj5epWc9lDjKl
	w+z2BjEZJhYhvFu/9dxcYEz/1459/MQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795006253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GDH0Uc8xA8nFTHB+QczAoC92j01+8FV/Hvk/je9m3jE=;
	b=9Aipow9u9Etxk5EVjUhlDpTpNktwJfTGf8G8Q7rWQKXtrArvDeFsFdL2mk3vY0DmvZHsSC
	mbRKVw2KEd6OYDBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zweV+myS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9Aipow9u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795006253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GDH0Uc8xA8nFTHB+QczAoC92j01+8FV/Hvk/je9m3jE=;
	b=zweV+mySX0Pp0JxCuhifRvXnL/PjK3fwmoh4KKCDcTeUak5b3mQMmOb5E+GBYKTv3rLm5Y
	k1+Ehen54lPVJmcWt8ModUeVwpizQ45CrxktMPeisNhjcdSTPyjJ+k4ADVj5epWc9lDjKl
	w+z2BjEZJhYhvFu/9dxcYEz/1459/MQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795006253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GDH0Uc8xA8nFTHB+QczAoC92j01+8FV/Hvk/je9m3jE=;
	b=9Aipow9u9Etxk5EVjUhlDpTpNktwJfTGf8G8Q7rWQKXtrArvDeFsFdL2mk3vY0DmvZHsSC
	mbRKVw2KEd6OYDBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30C9E134E9;
	Wed, 18 Nov 2026 12:50:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cmNqAi2f/WrgVQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 18 Nov 2026 12:50:53 +0000
Date: Wed, 18 Nov 2026 13:50:52 +0100
Message-ID: <871p8ixpzn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: william <assassinshalo29@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	evgeny@devduty.com,
	stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] ALSA: hda/realtek: no speaker sound on Lenovo Legion 16IRX9H since f2293e7b2ddd (PCI SSID 17aa:3842 shared with ThinkBook X G2 IAH)
In-Reply-To: <CAFjFWEgAJWe1q-3U2=5x4Tu0DcGcAano7nownXjg-uF9FADbRQ@mail.gmail.com>
References: <CAFjFWEjt+DPJ_gM1uTBZ_NoV6-3mi57ArjZ_Qdah2DqY-GCD1w@mail.gmail.com>
	<87v75vzuvb.wl-tiwai@suse.de>
	<CAFjFWEgAJWe1q-3U2=5x4Tu0DcGcAano7nownXjg-uF9FADbRQ@mail.gmail.com>
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
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 7F0C41F8CD

On Wed, 18 Nov 2026 03:08:41 +0100,
william wrote:
> 
> Hi Takashi,
> 
> Thanks for the quick patch.
> 
> To answer your question: I have not built a kernel with this patch, so I cannot
> say I tested it. What I did was boot 7.3.4 with snd_hda_intel.model=17aa:38cd,
> which selects the same ALC287_FIXUP_TAS2781_I2C fixup through the 17aa:38cd
> entry. The log then shows "picked fixup for alias SSID 17aa:38cd" and
> "bound i2c-TIAS2781:00", and the speakers work. The effect is the same, but it
> is a different code path, so it is not a Tested-by for the patch.
> 
> About the Y790 entry: on this Legion 16IRX9H, /proc/asound/card*/codec#0
> reports "Subsystem Id: 0x17aa38cd", so the codec SSID is the same one used by
> the existing "Y790 VECO DUAL" entry. On 7.2.10 the speakers worked without any
> parameter.
> 
> One clarification on my first message: the last paragraph about silence after
> suspend is a separate issue, unrelated to this regression and to this patch.
> Please ignore it here.
> 
> I would prefer not to be credited.
> Please leave the Reported-by tag out of the commit.

OK, now I submitted a proper patch and will merge it for the next PR.


thanks,

Takashi
