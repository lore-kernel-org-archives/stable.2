Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213224AB1D4;
	Mon, 28 Sep 2026 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595462; cv=none; b=ayd3air/pTWt3mpCKGgRmRyAotLzpWFFMFzHhQ6s/pQWWhJFLoAAWpB9ATS3X4DSU8C7JXL/jMWt7lHySdlKj4dKZGZ1rIzCm9UdPxC5mHJibnXof4oFIzN5ae3MMKTeTk4+6NVrOje1/cqqiTF3Jl8sRf3Vdf3bLVpbKOpMv3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595462; c=relaxed/simple;
	bh=MyANLQDacem1DqUhKEtsj/eGqu6wLCiurK/7OTBCres=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSAye8gvbtK0CsHL8NI0N5u46/FEGNLNQHeX5QFFQx2LGpyahAaWmHe6GFRYdqWBCZb+yVRyW7j9URDE3CMK0vPVAkwkbzZJE/QxvopJWgsbolbmjMERAwMNXf88YROZRWP1MhGoLGOh4MfdjKilCypvfBqPiTBtwEsXtFTMzY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ToSeXF6l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dERxkMgx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m5Rbib9a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xLlAlOE3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ToSeXF6l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dERxkMgx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m5Rbib9a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xLlAlOE3"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E868021BFB;
	Mon, 28 Sep 2026 11:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790595455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yMMnnS503saei+arI/xJAQ6qSFE4KksrvKgj6Ql4izM=;
	b=ToSeXF6l1sO/9x6VBjSebWkFBiBJ/RNCdpHXMcNt6bBjgz9keol7zcHOHZpfz7kLNegZSy
	LVknXUqqOhlyb7y1lxeOc0/WQQ8REpqrcG1LgmMYP+q7RXuuI3TNWktIsrXOqJwivHk3uP
	Y0LOzUEVrs3OB0mdsVXG00U9nzhNAwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790595455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yMMnnS503saei+arI/xJAQ6qSFE4KksrvKgj6Ql4izM=;
	b=dERxkMgxAyj3SpHDAmJJVLiRq6vQc0rxkc4FqcEuNw45YM5R3bxLOqDtBsc9AU+6lDba/f
	AFnVHo5OyG8IdXAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790595450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yMMnnS503saei+arI/xJAQ6qSFE4KksrvKgj6Ql4izM=;
	b=m5Rbib9aMZSsUVEDVjx0+ABSWSPb0PQ3idJuV29shzjlzdH4myK/6UGVOPoQuokYJyfIdT
	jhvF5rOIfhGGQvs+r8FPHQ3jsAG1SqMym8lADGfzfqZ/QTev/BSYX3V7uUSfxiy/WZU7QV
	BhfzsOjVEgQpXHHVDMK8tOpPw8rh55M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790595450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yMMnnS503saei+arI/xJAQ6qSFE4KksrvKgj6Ql4izM=;
	b=xLlAlOE3nx6lvhw0kXZdHmrGaclvkJMMXfn97QxlH9angiN/0UOIN7CzAlk0fVYxI2gezN
	PMBMb4PTNhHL4BAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E43F1340F;
	Mon, 28 Sep 2026 11:37:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3wD4FnpRumo9RgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 28 Sep 2026 11:37:30 +0000
Date: Mon, 28 Sep 2026 13:37:30 +0200
Message-ID: <87tsn961z9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Baojun Xu <baojun.xu@ti.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Aleksei Arsenev <alesharik4@gmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Fix square wave output on ASUS Strix G615LR
In-Reply-To: <20260923121640.272509-1-zhangheng@kylinos.cn>
References: <20260923121640.272509-1-zhangheng@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,vger.kernel.org,ti.com,antheas.dev,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,kylinos.cn:email]
X-Spam-Flag: NO

On Wed, 23 Sep 2026 14:16:40 +0200,
Zhang Heng wrote:
> 
> ASUS ROG Strix G16 G615LR (PCI SSID 1043:3f20) outputs a loud
> full-scale square wave from internal speakers since the TAS2781
> amplifier driver started loading. The quirk was using
> ALC287_FIXUP_TXNW2781_I2C which chains to the ThinkPad headset
> jack fixup, but this is an ASUS device that should use
> ALC287_FIXUP_TXNW2781_I2C_ASUS which chains to ALC294_FIXUP_ASUS_SPK
> for proper EAPD and pin configuration.
> 
> Fixes: f7cede182c96 ("ALSA: hda/realtek: Add Asus quirk for TAS amplifiers")
> Cc: stable@vger.kernel.org
> Cc: Baojun Xu <baojun.xu@ti.com>
> Cc: Antheas Kapenekakis <lkml@antheas.dev>
> Reported-by: Aleksei Arsenev <alesharik4@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=222045
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
> ---
> Baojun, Antheas: several other ASUS Strix Gxx5 entries (0x3ee0, 0x3ef0,
> 0x3f00, 0x3f10, 0x3f30) are still using ALC287_FIXUP_TXNW2781_I2C (the
> non-ASUS variant that chains to the ThinkPad fixup). Could you check
> whether they also need to be changed to ALC287_FIXUP_TXNW2781_I2C_ASUS?
> Ideally with testing on the affected hardware if possible.

Applied now.  Thanks.


Takashi
