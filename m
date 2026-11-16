Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843106;
	b=V+gb4AX1KD81Pi4KDGXDkkObhPTjcwetTkYl6vEmfUzS4EtYyNd8WO+6vAtVrCCSQ1fc
	 7P6XynKrKDscXuBud5YsxPSWSIPoL0KYX0PPWYs921B2d843okuGpKpkPnyxV3LvWWM32
	 lMzeC0NGGuzzrNy70CFJuk2yt6uDcGXHm+yQHnotjOMq5wF4+2zGdRdHLgXt5CUjZHEp6
	 WaMDdO7jiMi4afCuhhxOKJML1lm1NvSYw44tFRvMheePudZG3nLYJZvTOAuj8dZOn72MP
	 uXXpI8UEZVuV7K+K0/xVyo9T061iuttaRwBRzn3jyTOQPt2E0I46M77fpqWvStKuKmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843106;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=Idicx8emA2oqvBA/OxBNuiAP4xRKrUiUsD475RwA6E0=;
	b=G7Vq7o1TaFrhJ+4EXj7xw+LGYZucHQtTZ/tYL70qh8jLb63qXwYqL1CEjBtOelDQ3XFJ
	 yxCpEhfluiceQWvKeiiwyASqHpDjgQI21zooI7ElgCqAe/7/LnSBU5Wg7kLreRKVeTet8
	 GkrHbfgFHInEsYat/Qr0HBtIIY9slrnpWTpvtPT4ThK0FkoCvSmYzeAc2UlQ0cuNXsUs/
	 xmQkx50vTJXwsbQB3dC2uots25XBP8RhE4pniGW5CAGbdejndzY4MwuvVjcDkJLXb8abA
	 uPVTih7pfMAB2V8CUHoH5FNYZDbRWfBzBzp54nvqZUgsGWIGVGiyL+zJTT1xpDtO8mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=znWO6M9w;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+27JLGYz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=y4Bl7LUs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="WqlYwjw/";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F91606A339;
	Mon, 16 Nov 2026 15:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74F91606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=znWO6M9w;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+27JLGYz;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=y4Bl7LUs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WqlYwjw/
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 637F5222E9;
	Mon, 16 Nov 2026 15:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794843103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Idicx8emA2oqvBA/OxBNuiAP4xRKrUiUsD475RwA6E0=;
	b=znWO6M9wpsS5mf/SnkNuKM/pDJTqz5RmAtQamiXjfOqWMjTmQN/Ulvx+d+bcqj0aLgyBNU
	FjBKS6YzmL9pUEfStn5YHfRc2+Ru8w64A3NmiHQ9nlPwUNBZmATEAl/mFQ5BBy8tYGvNh7
	NbKW350KE5uQzO4koS3rXUOzbDjqbW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794843103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Idicx8emA2oqvBA/OxBNuiAP4xRKrUiUsD475RwA6E0=;
	b=+27JLGYzcIxM57T30HTPmT3JWkI/tUZoo317Eq6wEfzE2MgBFvGJJvKPYrqxO2KVkdMRap
	5+bdkgyo1MGZJmCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y4Bl7LUs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="WqlYwjw/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794843102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Idicx8emA2oqvBA/OxBNuiAP4xRKrUiUsD475RwA6E0=;
	b=y4Bl7LUscTQ5TQwLCWIBllBNYEakHtfb8MhkESItEYN0nbXLx54dwabz8K1qmQ1KSM0zVi
	Jh8Kng6fRNVaJYZK57aiQ6XJ0JgohUe9i4rdMSqP2lqEm29luS5+GvH4IsP8RAOkj7oHnG
	30DuLHRoTpd1D7sxXRPVonVNKPZ2tVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794843102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Idicx8emA2oqvBA/OxBNuiAP4xRKrUiUsD475RwA6E0=;
	b=WqlYwjw/YdMT532VL2vb+DWwLKQrl8V1AR8f5l986xSh4PXoyRh0XJeEKSne+cNyH2vmy1
	of/NVauX9t7cz/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EE7113408;
	Mon, 16 Nov 2026 15:31:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vI1vO90h+2qgLgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 16 Nov 2026 15:31:42 +0000
Date: Mon, 16 Nov 2026 16:31:41 +0100
Message-ID: <878q2syeqq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ye Weihua <yeweihua4@huawei.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	<linux-sound@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH -next 1/2] ALSA: pcm: oss: Restore params flag after failed reconfiguration
In-Reply-To: <20261116064850.3540576-1-yeweihua4@huawei.com>
References: <20261116064850.3540576-1-yeweihua4@huawei.com>
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
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,huawei.com:email];
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
	RCPT_COUNT_FIVE(0.00)[5];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,huawei.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 637F5222E9

On Mon, 16 Nov 2026 07:48:49 +0100,
Ye Weihua wrote:
> 
> snd_pcm_runtime_buffer_set_silence() may fail with -EBUSY when a
> concurrent PCM transfer is accessing the buffer.  The error path
> releases runtime->oss.buffer and clears the plugins, but leaves
> runtime->oss.params cleared as well.  A subsequent small read/write
> then skips the reconfiguration and dereferences the released buffer:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address
>   0000000000000000
>   pc : __arch_copy_from_user+0x78/0x23c
>   lr : snd_pcm_oss_write+0x10c/0x340 [snd_pcm_oss]
> 
> Restore runtime->oss.params on the error path so that the next OSS
> operation reconfigures and reallocates the buffer.
> 
> Fixes: 47c27c9c9c72 ("ALSA: pcm: Improve the fix for race of buffer access at PCM OSS layer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ye Weihua <yeweihua4@huawei.com>

Applied both patches now.  Thanks.


Takashi
