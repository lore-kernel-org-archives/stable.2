Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EC843F8CB
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137592; cv=none; b=ZhIhJyU6CRgw0IBovJ8+LCj2z1Hii/tQblVEPA3fwDV5wkhfTiLIuBqLEzHz8Fx1xKsPa+Dn/FnNYKiGFBWpUZoY9WnJRkAnZTP2w9+DXJU++akafuigNN9snNZP6/fArxZn9rASHLG12WlCdqQJii+OnWjpUc3vsJCEpusWph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137592; c=relaxed/simple;
	bh=BgmtyitbBYeLmFOBqImLlgPwGZgZ74MIAtnveeHA86c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8+nNyjEbMtI4crYyaq8aEJzc8pI1R5vcfJDDwBc/LFAl6b4sVosiK5yvpRrcdHEmWkbcWMsr4gQ1izAFk8OQ76jOL9BD9inSzA48bGvMd8mp/AVOq4KMiFPcAA2Dl/cdRJLt61qea84RHu7ILPHk2Y2EkxLpcHFFnS1CXLl86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xx+Ok6Yn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f+CC9yvM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xx+Ok6Yn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f+CC9yvM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xx+Ok6Yn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f+CC9yvM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xx+Ok6Yn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f+CC9yvM"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 93BFB21E78;
	Fri, 16 Oct 2026 07:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792137577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=N0RmPF4u4ttHUAHkoC+0f4DoZQVaNZj5Y1YwZeY3lgg=;
	b=xx+Ok6Yn6gATsaJT/VQTRNbo8sSv5qteghadulOBq1J5YckzyTkcG+OOMrQ32UOH5wbpW+
	+e6b2o0J5rg5WXYdVrDBuom0a/RfB20clk4fwnR/13ovmaDIYgiP0nvaeURHV+gt0foL/P
	lhjZ7Bic7eWiqHym2yBMSDu6+3x7cRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792137577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=N0RmPF4u4ttHUAHkoC+0f4DoZQVaNZj5Y1YwZeY3lgg=;
	b=f+CC9yvMsNvhIaAGUo27xpYH3uGlaIp3WnW+23Bk7HTDo5/yqv7SQuHoH9Xv3U73YD4Sod
	A94nrWRZ6eIf5QCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xx+Ok6Yn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=f+CC9yvM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792137577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=N0RmPF4u4ttHUAHkoC+0f4DoZQVaNZj5Y1YwZeY3lgg=;
	b=xx+Ok6Yn6gATsaJT/VQTRNbo8sSv5qteghadulOBq1J5YckzyTkcG+OOMrQ32UOH5wbpW+
	+e6b2o0J5rg5WXYdVrDBuom0a/RfB20clk4fwnR/13ovmaDIYgiP0nvaeURHV+gt0foL/P
	lhjZ7Bic7eWiqHym2yBMSDu6+3x7cRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792137577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=N0RmPF4u4ttHUAHkoC+0f4DoZQVaNZj5Y1YwZeY3lgg=;
	b=f+CC9yvMsNvhIaAGUo27xpYH3uGlaIp3WnW+23Bk7HTDo5/yqv7SQuHoH9Xv3U73YD4Sod
	A94nrWRZ6eIf5QCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC5AE1378C;
	Fri, 16 Oct 2026 07:59:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FgOWKmjZ0WpQPQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 16 Oct 2026 07:59:36 +0000
Message-ID: <3382a02c-ed79-4214-99c5-dc81ee59d633@suse.de>
Date: Fri, 16 Oct 2026 09:59:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] fbcon: Rebuild rotated font buffer on font change
To: Yao Yiqi <yyaqia@gmail.com>, deller@gmx.de, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com, stable@vger.kernel.org
References: <20261016073023.490430-1-yyaqia@gmail.com>
 <20261016073023.490430-3-yyaqia@gmail.com>
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
In-Reply-To: <20261016073023.490430-3-yyaqia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spam-Score: -4.50
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,gmx.de,ffwll.ch];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huawei.com:email,suse.com:url]
X-Spam-Level: 
X-Rspamd-Queue-Id: 93BFB21E78
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Hi

Am 16.10.26 um 09:30 schrieb Yao Yiqi:
> From: Yao Yiqi <yaoyiqi3@huawei.com>
>
> fbcon_rotate_font() caches a rotated copy of the console font in
> par->rotated.buf. The buffer is sized from the font's width, height
> and charcount, and is rebuilt in fbcon_init(), fbcon_switch() and
> fbcon_modechanged(), but not in fbcon_do_set_font().
>
> When the console font is changed through KDFONTOP/KD_FONT_OP_SET, the
> new font data and geometry are installed and vc_resize() is called.
> The redraw that follows reaches the rotated bitops while the buffer
> still holds the old font: the rotated putcs/cursor ops index
> par->rotated.buf with the new cell size and character codes, so a
> stale, too-small buffer is read out of bounds.
>
> KASAN reports, for example:
>
>    BUG: KASAN: slab-out-of-bounds in soft_cursor
>    Read of size 64 at addr ...
>     memcpy
>     soft_cursor
>     cw_cursor
>     fbcon_cursor
>     hide_cursor
>     redraw_screen
>     vc_do_resize
>     fbcon_do_set_font
>     fbcon_set_font
>     con_font_op
>     vt_ioctl
>
> Rebuild the buffer for the visible console right after the new font
> geometry has been installed and before any redraw. Select the
> console's blitting state with set_blitting_type() first, as
> fbcon_init(), fbcon_switch() and fbcon_modechanged() do before their
> rotate_font() calls: fbcon_rotate_font() reads the source font
> through par->p, which may otherwise still refer to another console of
> this framebuffer. On tile-blitting hardware, the same call uploads
> the new font's map to the text engine, which previously happened only
> when the console was switched. Background consoles keep their rebuild
> at fbcon_switch() time, as the buffer is shared per framebuffer and
> must not be rebuilt for a console that is not being displayed.
>
> If vc_resize() fails, err_out restores the previous font. The rotated
> buffer that was rebuilt for the new font earlier in the function
> cannot be restored with it: font_data_rotate() has already reused or
> freed the buffer that belonged to the old font. Select the blitting
> type and rebuild the buffer again after the restore: the upload to
> tile-blitting hardware and the rotated cache would otherwise keep
> describing the rejected font, and par->rotated.fontdata would keep
> referencing the font data whose last reference the error path drops.
> A failing rebuild leaves par->rotated.buf NULL, so the rotated ops
> skip drawing instead of reading a mismatched buffer; the next patch
> retries the allocation on the following call.
>
> Unlike the other callers, this one does not fall back to unrotated
> rendering on failure. The "par->rotate = FB_ROTATE_UR;
> set_blitting_type(vc, info);" fallback they use does not actually
> switch to unrotated rendering: set_blitting_type() calls
> fbcon_set_rotation(), which immediately re-derives par->rotate from
> par->p->con_rotate. Replicating that pattern here would not change
> the outcome; repairing the fallback is left to separate work.

It's way too long and boring to read. Can you please try to shorten the 
AI-generated commit description?


>
> Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
> ---
> Changes in v3:
>
> - Also select the blitting type again in the error path of
>    fbcon_do_set_font(). On tile-blitting hardware, set_blitting_type()
>    uploads the font map to the text engine; without the second call, a
>    failed vc_resize() left the engine with the rejected font (found by
>    the Sashiko review).

The problem is that rotate_font can fail as well. Handling that in the 
error path is not possible; hence results might be worse than keeping 
the rejected font.  Can you try to keep the original rotated font and 
reinstall that directly?

Best regards
Thomas


>
> Changes in v2:
>
> - Rebuild the buffer again in the error path of fbcon_do_set_font().
>    Without this, a failed vc_resize() left the rotated cache describing
>    the rejected font while the console rendered with the restored one,
>    and par->rotated.fontdata referenced freed font data (found by the
>    Sashiko review).
> - Select the console's blitting state with set_blitting_type() before
>    rebuilding, like the other rotate_font() callers, instead of writing
>    par->p directly.
> - Reworded the note about the unrotated-rendering fallback, which is
>    now left to separate work.
> ---
>   drivers/video/fbdev/core/fbcon.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 01715873ea49..d90a2ad45053 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2432,6 +2432,17 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
>   	else if (!vc->vc_hi_font_mask && charcount == 512)
>   		set_vc_hi_font(vc, true);
>   
> +	/*
> +	 * Select the console's blitting state and update par->rotated to
> +	 * match the new font, so that the rendering below does not use a
> +	 * cache that was built for the old font.
> +	 */
> +	if (con_is_visible(vc)) {
> +		set_blitting_type(vc, info);
> +		if (par->bitops->rotate_font)
> +			par->bitops->rotate_font(info, vc);
> +	}
> +
>   	if (resize) {
>   		int cols, rows;
>   
> @@ -2466,6 +2477,18 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
>   	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
>   		set_vc_hi_font(vc, false);
>   
> +	/*
> +	 * Restore the rendering state for the old font: re-select the
> +	 * blitting type, which re-uploads the font map on tile-blitting
> +	 * hardware, and overwrite par->rotated with the restored font's
> +	 * state.
> +	 */
> +	if (con_is_visible(vc)) {
> +		set_blitting_type(vc, info);
> +		if (par->bitops->rotate_font)
> +			par->bitops->rotate_font(info, vc);
> +	}
> +
>   	font_data_put(data);
>   
>   	return ret;

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


