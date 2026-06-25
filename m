Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A06B26ED25
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399900; cv=none; b=L+tImO376Qargc4wnOCvfyfWOJ7SI9VxzQ0hKjfoOgY1Xfzi7JgyqID+je7uBgPdGR24K0SsgwmL4O5CZh+FRvhqdeWXS6AwHQVeak1agtBH25QduLrLMs7nCuH7D6KUuyPQyJ2ZcJWgHwyVJAkOejz6kIFezRbXshSA6K59OSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399900; c=relaxed/simple;
	bh=6tx4Bj5p/W5ZyYRHsOq0eMuZbcediTREx9mrc3HpU/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdYdN7DnsOn7lLGbT0IDJz/M+hgrQZy9uXnSETtVbkcYYSRw/x0TWif1xqWfr7W7w9LYSxENa3mN4+p76eHwL1f1MVSb+O4qn0N96gkBYLLtOalw6MiJBX1xHdMALFMkmimun8ngWuvid9BpPatgsIBvbJIq8QCCc3WE32kjpfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BPfrj+sv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HKRm90AE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aw+WTHqT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I/773ghd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BPfrj+sv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HKRm90AE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aw+WTHqT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I/773ghd"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC4D871C6A;
	Thu, 25 Jun 2026 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782399895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KzggUgTvPO75sojZnEGWKA6d2yXkTbrwYEONUppR//8=;
	b=BPfrj+sv6w7n+gmiG2iIdGXmJxUlDbu3HSpcquG2SAcsnFeyp17ZidKBm/D46BZHt7EUUb
	THUg5zqBz0Nj+5Ct+/Arm25WxQx93eaFxCwCr2Z3QYZXucGx3diYMMH9iq6PggoB0E6Xzk
	PKLb8tBZbnpNV4yRhpD+JWAo7mxgzHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782399895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KzggUgTvPO75sojZnEGWKA6d2yXkTbrwYEONUppR//8=;
	b=HKRm90AEAb+BVSkFlsfYRXtYho6u4uL+vtQv9mZVZ7utmzu2VYLoKfnognyftVimbpvzWb
	UzxP9KzFkrqdnJCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aw+WTHqT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="I/773ghd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782399891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KzggUgTvPO75sojZnEGWKA6d2yXkTbrwYEONUppR//8=;
	b=aw+WTHqTaud8aM2myU4+DWvoJBJfDfIwzNdUuRID+AnyTEbLB4FtAHI3E4aWc4dYzyYZSw
	DFBHJfbqJmZ15BXgIOPxR4GD3+MUanJDmtLAQUaWSrLCXKaHpF4LtSno0+1mNxO8hGEnDk
	JIIJ7mUu2qaOrAr1kHQ93Z+ymtVXgL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782399891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KzggUgTvPO75sojZnEGWKA6d2yXkTbrwYEONUppR//8=;
	b=I/773ghdFNhqVT7xorQZLCxBA31dTB7MWLqkneyXb6Z71BdxfWLoCpH9SSP6ukb/2IcuJ6
	0P+HN6vNhtRf5HCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73CA0779A8;
	Thu, 25 Jun 2026 15:04:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7E/SGpNDPWrSOAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 25 Jun 2026 15:04:51 +0000
Message-ID: <7dd87e55-5170-4317-8c9e-38a7868f68fc@suse.de>
Date: Thu, 25 Jun 2026 17:04:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: fbcon: fix out-of-bounds read in err_out of
 fbcon_do_set_font()
To: w15303746062@163.com, deller@gmx.de, simona@ffwll.ch
Cc: syoshida@redhat.com, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>, stable@vger.kernel.org
References: <20260624083316.389677-1-w15303746062@163.com>
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
In-Reply-To: <20260624083316.389677-1-w15303746062@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AC4D871C6A
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Spam-Level: 
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.19)[-0.975];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmx.de];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[163.com,gmx.de,ffwll.ch];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,xidian.edu.cn:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi

Am 24.06.26 um 10:33 schrieb w15303746062@163.com:
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
>
> When fbcon_do_set_font() fails (e.g., due to a memory allocation failure
> inside vc_resize() under heavy memory pressure), it jumps to the `err_out`
> label to roll back the console state. However, the current rollback logic
> forgets to restore the `hi_font` state, leading to a severe state machine
> corruption.
>
> Earlier in the function, `set_vc_hi_font()` might be called to change
> `vc->vc_hi_font_mask` and mutate the screen buffer. If `vc_resize()`
> subsequently fails, the `err_out` path restores `vc_font.charcount`
> but entirely skips rolling back the `vc_hi_font_mask` and the screen
> buffer.
>
> This mismatch leaves the terminal in a desynchronized state. Because
> `vc_hi_font_mask` remains set, the VT subsystem will still accept
> character indices greater than 255 from userspace and write them to the
> screen buffer. Subsequent rendering calls (e.g., `fbcon_putcs()`) will
> then use these inflated indices to access the reverted, 256-character
> font array, leading to a deterministic out-of-bounds read and potential
> kernel memory disclosure.
>
> Fix this by adding the missing rollback logic for the `hi_font` mask
> and screen buffer in the error path.
>
> Fixes: a5a923038d70 ("fbdev: fbcon: Properly revert changes when vc_resize() failed")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>

The email in your S-o-b tag differs from the one in the mail's From: 
line. I think this is not accepted in the kernel. Can you please 
resubmit with the email addresses synchronized.

Apart from that:

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for fixing this problem.

Best regards
Thomas

> ---
>   drivers/video/fbdev/core/fbcon.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 9077d3b99357..5880ab9f3cde 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2405,6 +2405,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
>   	int resize, ret, old_width, old_height, old_charcount;
>   	font_data_t *old_fontdata = p->fontdata;
>   	const u8 *old_data = vc->vc_font.data;
> +	int old_hi_font_mask = vc->vc_hi_font_mask;
>   
>   	font_data_get(data);
>   
> @@ -2451,6 +2452,12 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
>   	vc->vc_font.height = old_height;
>   	vc->vc_font.charcount = old_charcount;
>   
> +	/* Restore the hi_font state and screen buffer */
> +	if (old_hi_font_mask && !vc->vc_hi_font_mask)
> +		set_vc_hi_font(vc, true);
> +	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
> +		set_vc_hi_font(vc, false);
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
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


