Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591667;
	b=4p0xUcL+Bw/WiPs3NVXRcha5WGSkyUnGDz0Fizat8LEUhdt9wh1EcBp5PaCwiFmp7VP1
	 NXfkcyMu0AxlfPGbNyjrwb8QIU83BD8ubVQYDo/IYktYmxoOQxciCOi2xIiAKecOXr5NS
	 +N7szfjtnx1PmB9zMvSiwoby7FjCOhH9soQnhafw487J2ymkQLCkGwXlEengtebFuSsLX
	 NHjLMwA6hCq3njJosruOHgWvPW8m9fqXvDjSFQ4loC/LMh52vyXeu9HyIEp+tER3W9gVU
	 iT8IN76CDcdaZXm6YS93mgQB6ihJMY8UqP1zsyP7kRdF4/0qQlp0d+/1Mgg33F/F2/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591667;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=rhW4xs1lI3QqG/x9PCm0VJvL8v/5j+fPh59EruHxg+c=;
	b=hYMM05qCtCMndzkule+bbCMM504DDeqHkO0rKyDY9/dw8LtlJdVskH62voEZgvy7nUqt
	 cGM0FtR6CrMuBgmKNzhG96qzAwZE9ThHTPiVZNgy22pKeqJ53w+RAegwH6FsFyaI2saZq
	 v6eDQo8wGdXwFAzXlBmLmfiUiiAnTUlBteq2qXXpOFEJkIRldkIwG57KnI00aUDJFnGje
	 wfz6Jfvw6Oa2HF4FHt3E8f5+XRQDZF7W4d3BJjHm63W57hwGr8ixL4Qxz4iAY45mwTR8a
	 SBSOAJFpqUqZ8mThUxfNwubBkhYX9PcAYd4sZawJ4gRigW/vgdG+av1NB8UOhh98jcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=QGIE8ETC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PU3RFc6F;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=QGIE8ETC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PU3RFc6F;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A118606A323;
	Wed, 25 Nov 2026 07:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A118606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=QGIE8ETC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PU3RFc6F;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=QGIE8ETC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PU3RFc6F
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B33B41F395;
	Wed, 25 Nov 2026 07:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795591664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rhW4xs1lI3QqG/x9PCm0VJvL8v/5j+fPh59EruHxg+c=;
	b=QGIE8ETC9Ab6O1TUUxr7+pBLedriDjFUrGs6GnTWNYKQYIQ/fI90uLzKNWqILZ1EvFQ3Fb
	t7yOK5Ty1kJ7nWsW+pfGd7FkoH5HsvANMnsyAQNKz9bj+CP0MdXRLbUtwf4IwNKU4s1+mF
	hcQ7gcFT8VbGolCDWHgvdVBgTaaG9Zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795591664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rhW4xs1lI3QqG/x9PCm0VJvL8v/5j+fPh59EruHxg+c=;
	b=PU3RFc6F6YrCl8uP5vo9OrBdth4ezVzWl5VWKrDnpj+u0Lg+pkrmGTVixL4j0eS23K0KgL
	qosILH4DrGhwK4Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795591664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rhW4xs1lI3QqG/x9PCm0VJvL8v/5j+fPh59EruHxg+c=;
	b=QGIE8ETC9Ab6O1TUUxr7+pBLedriDjFUrGs6GnTWNYKQYIQ/fI90uLzKNWqILZ1EvFQ3Fb
	t7yOK5Ty1kJ7nWsW+pfGd7FkoH5HsvANMnsyAQNKz9bj+CP0MdXRLbUtwf4IwNKU4s1+mF
	hcQ7gcFT8VbGolCDWHgvdVBgTaaG9Zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795591664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rhW4xs1lI3QqG/x9PCm0VJvL8v/5j+fPh59EruHxg+c=;
	b=PU3RFc6F6YrCl8uP5vo9OrBdth4ezVzWl5VWKrDnpj+u0Lg+pkrmGTVixL4j0eS23K0KgL
	qosILH4DrGhwK4Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B0A11339F;
	Wed, 25 Nov 2026 07:27:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UXDxCPCNBmvZKwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 25 Nov 2026 07:27:44 +0000
Message-ID: <257af12c-a18b-4884-9d61-89e16ee44980@suse.de>
Date: Wed, 25 Nov 2026 08:27:43 +0100
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
Subject: Re: [PATCH] firmware: sysfb: Clear the device pointer on registration
 failure
To: Yige Jiang <yigejiang86@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <confirmed-20261105-25-a16124b5ff57@gmail.com>
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
In-Reply-To: <confirmed-20261105-25-a16124b5ff57@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-Spam-Flag: NO



Am 24.11.26 um 16:45 schrieb Yige Jiang:
> sysfb_init() stores the legacy framebuffer device in the file-scope pd
> pointer before adding its data and registering it. If either operation
> fails, the error path drops the allocation reference but leaves pd set.
> A later sysfb_disable() then passes this stale pointer to
> platform_device_unregister().
>
> Clear pd after releasing the failed device, while disable_lock is still
> held. This makes sysfb_unregister() skip it just as it skips an absent
> or already unregistered framebuffer.
>
> Fixes: bde376e9de3c ("firmware: sysfb: Add sysfb_disable() helper function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>

Thanks!

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>


> ---
> AI assistance was used for analysis and patch preparation.
>
> Based on next-20261104 (8b7179210b22).
> Compile-tested: x86_64, GCC 14.2.0, W=1, drivers/firmware/sysfb.o;
> baseline and patched objects built with no warnings.
> Static source review; no hardware, boot, or KASAN test was performed.
>
>   drivers/firmware/sysfb.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> index 8833582c188301afb4a9c9dbdf969828ab9449f6..9cd660a509da939c28e93956d7b6420c794048c1 100644
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -214,6 +214,7 @@ static __init int sysfb_init(void)
>   	goto put_device;
>   err:
>   	platform_device_put(pd);
> +	pd = NULL;
>   put_device:
>   	put_device(parent);
>   unlock_mutex:
>
> base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


