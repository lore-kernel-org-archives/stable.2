Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A62F3AB291
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 07:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789283580; cv=none; b=JS3WYi6vz7NmIp8WAv0xlVnKt9LpvkGhNbgRBWiObOqXTRn82Rea2apP/ZRoFxfBAzeQXoxTiDu/1aDXuRrARh95zvSzp29GwRBh1TnPelSyAgmVOCGvh5xXG3t3ivMa1xUkMzNDQlxt/5p9Fdm+mEiqqlaURqaNCfwKrsY0Qyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789283580; c=relaxed/simple;
	bh=ChPXcgncMs8XhdFql6JGwsQUrDmsDBKqkVqRDMf8T7A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDhj90rQPSHAI6jroZ8BP6H4W5fsLPg3J8sos8Dc4SOmmiM8MjeHXytoePPVlkf+xRSJ0MRKOuDHiFU7PEgHM4IEivfmzp+pwHZQHFXaU9cHmRRGSRI4Ql9GPhOhK6G6X7ry1OJ4DxEDrvBiK6cKOy7FCC+o6ZSt97hSiLypskQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RNqVw1iJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vmJtr24Z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f+6W/0ej; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fQMW9r6W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RNqVw1iJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vmJtr24Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f+6W/0ej";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fQMW9r6W"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AB78121D99;
	Sun, 13 Sep 2026 07:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789283564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OyV6yR/wT3tcu1I/199NoZt8SQ/ERdl+CssYjgFLqhI=;
	b=RNqVw1iJObUd9EQKNLIneyesr3kpj01X4505QL0gPPh7uS1yQxgV8tvNY27+RSPBoBvz0g
	Lm5aVevZjNarLn6i/7Q6OCoY0bTWGXpNZIA915NjbxEnHRI6+4sZ6ZwehFPVWw68TXPxwk
	EAy2jqVR1tsPELqeL3VUkJ7sjeFJLGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789283564;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OyV6yR/wT3tcu1I/199NoZt8SQ/ERdl+CssYjgFLqhI=;
	b=vmJtr24ZiZjEn0ajzs7amUdtT4ElmI1hxTaczK7dYN+mIZWH7nshsMplUwAI2d1FoE8dt9
	TaXUbkKbDxSELqDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="f+6W/0ej";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fQMW9r6W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789283560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OyV6yR/wT3tcu1I/199NoZt8SQ/ERdl+CssYjgFLqhI=;
	b=f+6W/0ejSpqu1BJTiTzJiqNiJIWfPAaFxMOMgmw4LkZ6Guhhw6QZd3eufS29kRpVFev7pU
	y6/yFej6NcTztD4eU0fcU5zLfizictyiVaBCIckQ5n3+pJrv9KmamJrEB3lSf4Ljj4aTiI
	QwhQnewc/1xeCkUD5PF2NFJHFLd2WiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789283560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OyV6yR/wT3tcu1I/199NoZt8SQ/ERdl+CssYjgFLqhI=;
	b=fQMW9r6WSYbS3PE2EcXgycGW/g0Z9chkvOyYqM7quegvR9TPYu+iANYB5QLzf/igs++0hw
	lc2oYb+hEBF67TBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C6B613675;
	Sun, 13 Sep 2026 07:12:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id teOOCOhMpmoTPwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 13 Sep 2026 07:12:40 +0000
Date: Sun, 13 Sep 2026 09:12:39 +0200
Message-ID: <87h5jtwro8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] ALSA: virtio: reset device before deleting virtqueues
In-Reply-To: <20260911031121.1542502-1-oss.patchbox@gmail.com>
References: <20260911031121.1542502-1-oss.patchbox@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -2.01
X-Rspamd-Queue-Id: AB78121D99
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

On Fri, 11 Sep 2026 05:11:21 +0200,
Yuho Choi wrote:
> 
> virtsnd_remove() and virtsnd_freeze() delete the virtqueues before
> resetting the device. del_vqs() frees the vring backing, but does not
> provide a generic device quiesce operation. In particular, modern
> virtio-pci keeps enabled queues active until the device is reset.
> 
> Reset the device before deleting the virtqueues so it can no longer
> access the vring memory when that memory is released. This also covers
> probe failures after DRIVER_OK, which unwind through virtsnd_remove().
> 
> Fixes: de3a9980d8c3 ("ALSA: virtio: add virtio sound driver")
> Fixes: 575483e90a32 ("ALSA: virtio: introduce device suspend/resume support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Applied now.  Thanks.


Takashi
