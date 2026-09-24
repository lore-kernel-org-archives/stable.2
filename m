Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7969A420897;
	Thu, 24 Sep 2026 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233986; cv=none; b=TP8+w+fn4PlHov1Id3nsO3DdmZCwD7+QmGvTyXY32mFrZp1kPO+jJ5/LLO3ovpvBQFHEKouX0WU1yoG+lygc5tQK/xrqqkINgyRGTQ8JnloUAs/f5lY7nJLFmuHzdgKXKX5rcYscHv5kLJoX5LI/EsKOFNOfT5Qu2jeMPq1ahfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233986; c=relaxed/simple;
	bh=W+VIXknoRE2coJYyz3jrlRoKiT3F8++B/RUgJ6Cw9F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OL9w6Gy5IbTzOSPWSBX65kGxaN4aQmHVIDxKy6GPU9gy5qx/2MfAqm2Vun6F7ycyPQ+tH72u0b8pVjJXwbtYQNtyPDPDAVLEASnXw4MSGRodVnfJcrl9/dXMtEvKKD2/Bv4SAqvF1tSooJBkVVTg7M1SwULTs37s9AMJMY2xdZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b4s6UBsX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9OcVumtZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mvF1UAlH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bnCSjTZe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b4s6UBsX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9OcVumtZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mvF1UAlH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bnCSjTZe"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 709B81FFF5;
	Thu, 24 Sep 2026 07:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790233971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IFmCbw1AXLcVDygfc6RLKARsvcPzfF5hCK7aTly65Nk=;
	b=b4s6UBsXSdjD7v/VYQFK9VJlMmtgZkB+IyLwPFzHp5mVa4G28LM1fECv8c9azltiFRXdid
	a8MslDZvDszwwgmBjKMtP9zCpPhAjRXFmIiEREuMNc4SIQqfUlg0/ixA1ixbZQmxeoNNMa
	LFlK5OzDrd6oQ3Ut4iNYiUHBVk6xgHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790233971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IFmCbw1AXLcVDygfc6RLKARsvcPzfF5hCK7aTly65Nk=;
	b=9OcVumtZsdPFzzGrOxU1aDK6S/IPWfBV37qrJUkfmThviqsDLAREiqhqP9hg3U3lPSvCJY
	6Tqn9Fe0AVLhqTDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790233967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IFmCbw1AXLcVDygfc6RLKARsvcPzfF5hCK7aTly65Nk=;
	b=mvF1UAlHmOYDSEMf65/U5ILhWnk61wqonV9bJbvGtT0SqO1PdSHzcah02N/C07MmylFQlb
	RqwFHA5pFXmwgjZwpwZSraFemRovmEihY5nWEct8jAUB+P61ONSXFyr8f2A4W/tjcC1vlO
	H+9piOz3uWC6XZl8qonRpRaEPgU7Bi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790233967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IFmCbw1AXLcVDygfc6RLKARsvcPzfF5hCK7aTly65Nk=;
	b=bnCSjTZevcb8hfB4gg/muzq4Av+BrQRVQDOv+okdaEDGMJOshqq+UP5t9YPsP5shSpKlvp
	A/2thrHwTkvE4xAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1176713354;
	Thu, 24 Sep 2026 07:12:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AHPELW7NtGoPCAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 24 Sep 2026 07:12:46 +0000
Message-ID: <11236038-2c96-4d9e-bfe0-6ebd59d4823c@suse.de>
Date: Thu, 24 Sep 2026 09:12:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/udl: clean up USB resources if
 drm_dev_register() fails
To: Hui Peng <benquike@gmail.com>, jani.nikula@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260919223511.3889061-1-benquike@gmail.com>
 <20260924064434.2541959-1-benquike@gmail.com>
 <20260924064434.2541959-3-benquike@gmail.com>
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
In-Reply-To: <20260924064434.2541959-3-benquike@gmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,suse.com:url]
X-Spam-Flag: NO



Am 24.09.26 um 08:44 schrieb Hui Peng:
> In udl_usb_probe(), udl_driver_create() calls udl_init(udl), which
> allocates USB URBs and DMA buffers via udl_alloc_urb_list() that are
> normally freed by udl_drop_usb() in udl_usb_disconnect(). If
> drm_dev_register() fails in udl_usb_probe(), udl_usb_probe() returns
> without calling udl_drop_usb(udl), leaking the allocated URB list and DMA
> buffers because udl_usb_disconnect() is not called when probe fails.
>
> Call udl_drop_usb(udl) when drm_dev_register() fails in udl_usb_probe().
>
> Tested in QEMU against Linux 7.3.0-rc3 using dummy_hcd by simulating
> a registration error in drm_dev_register(): on the unfixed kernel,
> udl_usb_probe() returned an error without calling udl_drop_usb(udl),
> leaking 8 allocated URBs and DMA buffers; whereas with this fix applied,
> udl_drop_usb(udl) is called on error, freeing all URB and DMA
> allocations.
>
> Fixes: 5320918b9a87 ("drm/udl: initial UDL driver (v4)")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
> Changes in v2:
> - Split out as patch 2/2 as requested by Jani Nikula.
> - Added testing details in QEMU on drm_dev_register() failure cleanup.
>
>   drivers/gpu/drm/udl/udl_drv.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
> index 1922988625eb..239a6983f49f 100644
> --- a/drivers/gpu/drm/udl/udl_drv.c
> +++ b/drivers/gpu/drm/udl/udl_drv.c
> @@ -97,8 +97,10 @@ static int udl_usb_probe(struct usb_interface *interface,
>   		return PTR_ERR(udl);
>   
>   	r = drm_dev_register(&udl->drm, 0);
> -	if (r)
> +	if (r) {
> +		udl_drop_usb(udl);
>   		return r;
> +	}
>   
>   	DRM_INFO("Initialized udl on minor %d\n", udl->drm.primary->index);
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


