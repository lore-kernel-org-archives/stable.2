Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485642;
	b=359GfK/1yMQqp3mRQzT1NFXbd8LafA46zI1z4GPHGTD8sn1WGRykL0updLAXAbRd2knc
	 ZnNhoDAqsZaZm1iIuqB2PdjXkrHLAY4/0360/Lpby6DLqXfhY/1i2aezH/HyaVb6LiAnj
	 jDqGcd6rt0CB+5CMkWt3plg+3jvyU66KNwlzDdgZCZbNxFXiriU2raWnY8JYZqwtpqJ6r
	 ux1u8E1YBX6h0f0iVnkq4yCeDrXHuzwxqhNDgVLlZSGxep5TVCmLXrlqqH8HnTKT2BKrQ
	 eaS9gERxAAJpf3Hp2SsdijS44hbNhvt6uDpuft6rDJh037uHwnN7KxiDMBc/efmGfVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485642;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Rspamd-Action:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Flag:X-Spam-Score;
	bh=9D8+32ge40Nx3n1qnTPFKi5ixMQDJp4uzpLb91F2J9c=;
	b=wfah7HOaG7gMiiEG3kQbcMVITJmjCsEhSfnsw88I4uqhQcQ2g1GOefAqHuRc8VNjiytC
	 jKv0TFH2k84/uyk/oI/TvN/YKuu7wtzhcIn6sX9t/tuxHNnI5yqKI1JHAjhP8vslL7Zqx
	 4eO/OO5sUPXU+xF1Ad9g7TcO8ewg+EhVcZ++oHX+hArAM6hykkTnczB3V7SZOIhISTfaz
	 wFLCiD91qKpsjQ1VX7zj0UHGmxThkhXqzGwxUb4dimoaN+RrdsK4gF4wCJd7WCijnoFRM
	 yHqoHiZ5dGY6SCSmXxZXdFkMHqJMaUaZkAn2V3xBPAcWsTpFY5VDD29NQD6fOe5wXUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jIdR+sl3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oBmJImuh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ooiha0q8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YG6m8lxO;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80C5606A319;
	Tue, 20 Oct 2026 08:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B80C5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jIdR+sl3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oBmJImuh;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ooiha0q8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YG6m8lxO
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D18DF1F388;
	Tue, 20 Oct 2026 08:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792485640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9D8+32ge40Nx3n1qnTPFKi5ixMQDJp4uzpLb91F2J9c=;
	b=jIdR+sl3tZj8tJBVd2BJ0kiqNyY8lJM4x9uziQyMHeKjaLpHx7qZ6er7B1l95WZwU/tWFc
	KFfxnwXfZlwCwC8TNtNZmCWPIbOSFxAaGHQpGZcnpHT1XMXkktFnzMoOVklGAJKNhZcBMX
	7W7oQAlZ+dO9h/mH8W99hkJAd9MpTDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792485640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9D8+32ge40Nx3n1qnTPFKi5ixMQDJp4uzpLb91F2J9c=;
	b=oBmJImuhbq4Cv+Ul16LwIIZLC+4jGRdjwy4BrV7NueRsDqllomfZPwyMMOTPIsbxzliqSx
	zCNbroaj/3v4ItBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ooiha0q8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YG6m8lxO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792485639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9D8+32ge40Nx3n1qnTPFKi5ixMQDJp4uzpLb91F2J9c=;
	b=Ooiha0q8FEyPPeynUmtgkme05GoI+CHPsFNczCJ9Ax9vtVDuLBUP4eEMzFJu9yWPsvAZQV
	vZ+ddif9QhT2ZXnDYzmaiOtUyMu/+SxJ+fFobOa3AZR//jCEgV0XjMY5rX1uqySgxnBQ+C
	0IqCUon/JJQ9oAE46OzLInJ13V/Eztc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792485639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9D8+32ge40Nx3n1qnTPFKi5ixMQDJp4uzpLb91F2J9c=;
	b=YG6m8lxOfTSHb1J5nRrxeak2TkKQYSY6TfCTif3Q/Zd68jdk5p5jFIitiFevw3Oe7b+o59
	xs+WMnBLPn/lt3DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8602E136CC;
	Tue, 20 Oct 2026 08:40:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UzGsFwcp12qlSQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 20 Oct 2026 08:40:39 +0000
Date: Tue, 20 Oct 2026 10:40:39 +0200
Message-ID: <87fqy0ix2w.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Thomas Nemer <thomas.nemer@fortytwo.fr>
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Skip sample-rate read-back on PreSonus AudioBox USB
In-Reply-To: <20261019204944.28302-1-thomas.nemer@fortytwo.fr>
References: <20261019204944.28302-1-thomas.nemer@fortytwo.fr>
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D18DF1F388
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Score: -3.51

On Mon, 19 Oct 2026 22:49:44 +0200,
Thomas Nemer wrote:
> 
> The AudioBox USB stalls the UAC1 GET_CUR SAMPLING_FREQ request on both
> streaming endpoints. After the sample rate is set, the read-back
> verification in set_sample_rate_v1() fails and logs
> 
>   usb 1-3.1.2: 2:1: cannot get freq at ep 0x1
>   usb 1-3.1.2: 3:1: cannot get freq at ep 0x82
> 
> on each endpoint configuration until the sample_rate_read_error counter
> gives up. Set QUIRK_FLAG_GET_SAMPLE_RATE to skip the read-back on this
> device.
> 
> Fixes: 1869c47e5d59 ("ALSA: usb-audio: Fix missing sample-rate control for PreSonus AudioBox USB")
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Nemer <thomas.nemer@fortytwo.fr>

Applied now.  Thanks.


Takashi
