Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792496455;
	b=QTQTGWBopJ/CK1XWVT5+LSmyaLS+f+lO0WZLDvOn/HR5qjSytgfvgvWlYkkGctXVDH4l
	 3+1xKOaqoqx/IMED3z9rEvIIlkv//yw+kcaPJxsf0EwuFmoZkAxMbrVamSO5xr0B0vcQd
	 KGSsSwOWMUi4FvZSL6Z1UhixZMCSkSZoXfSiz1cw2hY5N89ZrikVz/23T5c7A9OWtS7lw
	 Hx88TgsnhtPTBqm/u5wDeWmZdhvKiiPx1hbJ3ako5dV+hRf67wFansE/AnYJ4pI1Ma7Cb
	 4KSg2A6HwL2yQVcyGJpTVrHLPBmTx1myiAepJNLX+ZbOlz/EPg1gJmIcCgtIVlFDD7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496455;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Spamd-Result;
	bh=1tuZyV44t4P69kcVnXl66QFtZQO9JF1Ph9e8Q8cwgIE=;
	b=ryyGdfhl34TcpCCWYoLQvKGp+qF5RzuMfiw/s+Oon0BMpkpVfEn9ke+POCkOxkR0nHrL
	 633HdWpe+i2vuhNNGkHWpQ3bkTzmtYkEFmfmKHzNmtmum8SRR+LsHjNoCzBkAcoUXDkJ5
	 TWdH+0B97JnVh5cmVR+j++mDTZx1NTzsEI4WJKXmuyJBCxn7nnsIp69oKenHTN796rgcJ
	 Y3UmoSducll4cLG73uwru2xLuRX7ybEd56WEAychewpOX4LYMvUHLK0u/nvJTfbsTTKcW
	 VycFSxpFevLzMg6TEAM9uS6jPshKgDdlMzPMv6xfCZKEVU9f9s/OUaEIuhSTkZvuRJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oMZTZiUt;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nEJTvPJ0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oMZTZiUt;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nEJTvPJ0;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E536606A324
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 11:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E536606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oMZTZiUt;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nEJTvPJ0;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oMZTZiUt;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nEJTvPJ0
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 666751F79E;
	Tue, 20 Oct 2026 11:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792496445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1tuZyV44t4P69kcVnXl66QFtZQO9JF1Ph9e8Q8cwgIE=;
	b=oMZTZiUtqRTMwP2ImRD1ja7hn9PaLPxQjg4GEwt1yhwYDQkzbptvhdnPF7dTYJBP1k1aop
	8b+oCo9TISXscQrEs5BV0m6NZnm8diYAG3gG7J4Y6G30VBspfOR4QECD+aM9lKVABvGbm/
	YkOO64+OL7aqsajkJcjTE3r5+pJqj9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792496445;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1tuZyV44t4P69kcVnXl66QFtZQO9JF1Ph9e8Q8cwgIE=;
	b=nEJTvPJ04pvnLGmDZZqAKfTyJNUYY2/k179V5yUUJ05c1UbFLEfqM3vlyvFs1D5+oZ5jvP
	s75ww03ph1292VBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792496445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1tuZyV44t4P69kcVnXl66QFtZQO9JF1Ph9e8Q8cwgIE=;
	b=oMZTZiUtqRTMwP2ImRD1ja7hn9PaLPxQjg4GEwt1yhwYDQkzbptvhdnPF7dTYJBP1k1aop
	8b+oCo9TISXscQrEs5BV0m6NZnm8diYAG3gG7J4Y6G30VBspfOR4QECD+aM9lKVABvGbm/
	YkOO64+OL7aqsajkJcjTE3r5+pJqj9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792496445;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1tuZyV44t4P69kcVnXl66QFtZQO9JF1Ph9e8Q8cwgIE=;
	b=nEJTvPJ04pvnLGmDZZqAKfTyJNUYY2/k179V5yUUJ05c1UbFLEfqM3vlyvFs1D5+oZ5jvP
	s75ww03ph1292VBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E863136C6;
	Tue, 20 Oct 2026 11:40:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X/A/KjxT12oSDQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 20 Oct 2026 11:40:44 +0000
Message-ID: <d2490a35-df4e-450f-955a-0491529a3772@suse.de>
Date: Tue, 20 Oct 2026 13:40:44 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: bitblit: Fix glyph clipping when fbcon pans
To: CatMe0w <CatMe0w@live.cn>, Helge Deller <deller@gmx.de>,
 Simona Vetter <simona@ffwll.ch>,
 Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <TYYP301MB1525C03FE71D47908263EBFCF69A2@TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <TYYP301MB1525C03FE71D47908263EBFCF69A2@TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[live.cn,gmx.de,ffwll.ch,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de,live.cn];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:url,imap1.dmz-prg2.suse.org:helo]

Hi

Am 17.10.26 um 10:53 schrieb CatMe0w:
> Commit 3637d34b35b2 ("fbdev: Add bounds checking in bit_putcs to fix
> vmalloc-out-of-bounds") made bit_putcs() clip glyphs to var.yres. When
> fbcon scrolls by panning, it draws text rows up to var.yres_virtual,
> so after the first pan most new text is not drawn until the next full
> redraw. This affects fbdev drivers that set FBINFO_HWACCEL_YPAN or
> FBINFO_HWACCEL_YWRAP, such as vesafb with the ypan option, when
> CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=y.
>
> Clip to GETVYRES() instead, which fbcon_ud.c and fbcon_ccw.c already
> use as the drawing area height. When fbcon does not pan, GETVYRES()
> returns var.yres, keeping the existing bound. When fbcon pans, it
> returns var.yres_virtual, which the framebuffer memory must cover
> anyway for panning to work.
>
> Fixes: 3637d34b35b2 ("fbdev: Add bounds checking in bit_putcs to fix vmalloc-out-of-bounds")
> Cc: stable@vger.kernel.org
> Signed-off-by: CatMe0w <CatMe0w@live.cn>

This patch restores fbcon on my test system with sisfb.

Tested-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
Closes: 
https://lore.kernel.org/linux-fbdev/b8b52ffd-ecec-4fba-b432-ba32135c2f99@suse.de/

Best regards
Thomas


> ---
>   drivers/video/fbdev/core/bitblit.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
> index 39f44258d793..323a9e79a684 100644
> --- a/drivers/video/fbdev/core/bitblit.c
> +++ b/drivers/video/fbdev/core/bitblit.c
> @@ -18,6 +18,7 @@
>   #include <linux/console.h>
>   #include <asm/types.h>
>   #include "fbcon.h"
> +#include "fbcon_rotate.h"
>   
>   /*
>    * Accelerated handlers.
> @@ -150,7 +151,9 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
>   		      const unsigned short *s, int count, int yy, int xx,
>   		      int fg, int bg)
>   {
> +	struct fbcon_par *par = info->fbcon_par;
>   	struct fb_image image;
> +	u32 vyres = GETVYRES(par->p, info);
>   	u32 width = DIV_ROUND_UP(vc->vc_font.width, 8);
>   	u32 cellsize = width * vc->vc_font.height;
>   	u32 maxcnt = info->pixmap.size/cellsize;
> @@ -167,10 +170,10 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
>   	image.height = vc->vc_font.height;
>   	image.depth = 1;
>   
> -	if (image.dy >= info->var.yres)
> +	if (image.dy >= vyres)
>   		return;
>   
> -	image.height = min(image.height, info->var.yres - image.dy);
> +	image.height = min(image.height, vyres - image.dy);
>   
>   	if (attribute) {
>   		buf = kmalloc(cellsize, GFP_ATOMIC);
>
> base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


