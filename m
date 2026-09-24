Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90D040D587;
	Thu, 24 Sep 2026 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234084; cv=none; b=owTiOw50963Ns6Nt+RmqPJZnpC9mTnqhCKmewHyd8FBuPaf7RQUBGAhEoDiJBglnj4mKbN1cRR2sg26261Y68LliRm8naiLOU1OK1Poxyo6+U4HsMG6cqugdc7RNm3AzaqNRkGOuLHWC6pzw6I9o2pTgiS2Ls08H1Qpq38FAAOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234084; c=relaxed/simple;
	bh=NBZ+eic9CfIEwgnBewHMCalGbR6k3uxner4TVUF83uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okihCd4RKQfhhmeziSV1nKFqm0ANYh6vMhVxn3jZn6TMWtWp4a8iDzrV5DC7Xrml4XQNeuNeR6Idub0qgrUxgQh2C7aGZPHUS+Cb2lMizBvjGmcYgS5hXjBZMgR+Gf8eVhviC1M8xqb5tEIkZLuFoLkr+Nvg9BpiFBdl7pn57JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lEB74waK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=heyBVIvW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bGgQDb2V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MdeQGqzD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lEB74waK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="heyBVIvW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bGgQDb2V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MdeQGqzD"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6618D21C40;
	Thu, 24 Sep 2026 07:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790234070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l1UzpKZExQHMgq+sq0aemQthY02cjPSoIUfciqIEIaE=;
	b=lEB74waKjCNzIPQgRSgy6lHlkj+gwyoJwFri8Zfs/+e21A1Pp6DGEuqkf2Qg18xfuVDFpa
	68Q1r0l06H4sgKPWMUQrbYGAKLvgO4KjTAsj1L8u+5drEEdJwaEsp3QdG7q9BkZPVrmUe6
	ucO1+/A4oHlFp9vJzuf+kiWbDfBg+kI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790234070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l1UzpKZExQHMgq+sq0aemQthY02cjPSoIUfciqIEIaE=;
	b=heyBVIvWHWTwiCNdC/5RpW9/oY2sJg8Hst2cP7sXtj7gS8Nd+vOHEHMJkhyq3mmnhNVh3q
	8KjeGrO2995JoYCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790234066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l1UzpKZExQHMgq+sq0aemQthY02cjPSoIUfciqIEIaE=;
	b=bGgQDb2V5m3rkqavrer2ZCW4Ya2tX+tiGP7mna3pk9KD4fBeC6hf89OcWFTY5krxBCSP+o
	2igWuiFmqHvf7Wzct0o8i38aSnUTbu76I7gIhiyOH5bm/xAVRj1UDnTURzLtq1icvGqMk2
	IbTUhCh97u3ZFfCkXx/g3TOylBwi9S0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790234066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l1UzpKZExQHMgq+sq0aemQthY02cjPSoIUfciqIEIaE=;
	b=MdeQGqzDCxiNWGlYm3VoqJE7inIR2oistRjtJVNnWy6ewu6YORpH3ArvHjjLV4jaazuenq
	KwE6NbhTVEpwjYDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F110D13354;
	Thu, 24 Sep 2026 07:14:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oTP2LtHNtGoqCQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 24 Sep 2026 07:14:25 +0000
Message-ID: <35bc19a3-27d7-4d3e-978e-0692de78f8a0@suse.de>
Date: Thu, 24 Sep 2026 09:14:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/udl: reject short USB control transfers in
 udl_read_edid_block()
To: Hui Peng <benquike@gmail.com>, jani.nikula@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260919223511.3889061-1-benquike@gmail.com>
 <20260924064434.2541959-1-benquike@gmail.com>
 <20260924064434.2541959-2-benquike@gmail.com>
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
In-Reply-To: <20260924064434.2541959-2-benquike@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org,ffwll.ch];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.com:url]
X-Spam-Flag: NO

Hi

Am 24.09.26 um 08:44 schrieb Hui Peng:
> In udl_read_edid_block(), usb_control_msg() requests 2 bytes into
> read_buff for each EDID byte, and read_buff[1] is stored into buf[i].
> Currently the short-transfer check tests ret < 1 instead of ret != 2, so
> if a short USB control transfer returns 1 byte, read_buff[1] is not
> written by usb_control_msg() and retains the previous iteration's byte (or
> uninitialized kmalloc(2) memory on the first iteration), which is then
> copied into buf[i].
>
> Change the check from ret < 1 to ret != 2 so any short USB control
> transfer fails with -EIO.
>
> Tested in QEMU against Linux 7.3.0-rc3 using dummy_hcd and raw-gadget
> emulating a DisplayLink UDL USB device: on the unfixed kernel, when
> usb_control_msg() returned 1 byte for an EDID read (short transfer),
> udl_read_edid_block() accepted ret = 1 and stored stale read_buff[1]
> data into the EDID buffer; whereas with this fix applied, ret != 2
> correctly fails with -EIO and prevents EDID buffer corruption.
>
> Fixes: 5320918b9a87 ("drm/udl: initial UDL driver (v4)")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v2:
> - Split out as patch 1/2 as requested by Jani Nikula.
> - Added testing details in QEMU on short USB EDID control transfers.
>
>   drivers/gpu/drm/udl/udl_edid.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/udl/udl_edid.c b/drivers/gpu/drm/udl/udl_edid.c
> index af4cff2a7c51..b7c462436573 100644
> --- a/drivers/gpu/drm/udl/udl_edid.c
> +++ b/drivers/gpu/drm/udl/udl_edid.c
> @@ -36,7 +36,7 @@ static int udl_read_edid_block(void *data, u8 *buf, unsigned int block, size_t l
>   		if (ret < 0) {
>   			drm_err(dev, "Read EDID byte %zu failed err %x\n", i, ret);
>   			goto err_drm_dev_exit;
> -		} else if (ret < 1) {
> +		} else if (ret != 2) {

Please test for (ret < 2) instead. It makes the test a little less 
dependent on the earlier calls.

Best regards
Thomas

>   			ret = -EIO;
>   			drm_err(dev, "Read EDID byte %zu failed\n", i);
>   			goto err_drm_dev_exit;

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


