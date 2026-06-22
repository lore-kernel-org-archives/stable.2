Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7E30FC27
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140080; cv=none; b=O3IqWA3E6QUgiDbFudsqZKdsvr7Yf+mzuueduresVIQ5iVjNvNUlOBCpFh60CzDysNhbkUuuYtK5dGXgc5JFfMBhYj26gqDZDqRLkKj0F5WlkpRLcBRhsLvhjN2lPwSufZyu3Z0MZZh/tkBH+ykkz4qf+KVYlG39SmBOk5NbFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140080; c=relaxed/simple;
	bh=4O/Lk+bmL14dJHrMXVZE6YRVaBcltePxcx51t7J73hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOegZgRxFslWi640z4s8/+qH3CM8HYjjICb8He2q4zQZVQ1hcjtEKpSIM+WLQhVJ9ClLZBHa3j10HwVNgzdM/xwg0B40FdBcAXU3AndDfM6ky/E1TreKpXX/I7S3rYxfpzxP50vtaHaNLaUZ5O9Zhpd3PHwPBUjynRV1yYNy+xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oEr7QA3m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=844/Hlof; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oEr7QA3m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=844/Hlof; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oEr7QA3m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="844/Hlof";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oEr7QA3m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="844/Hlof"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 62E1C75991;
	Mon, 22 Jun 2026 14:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782140076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jxh1gHLoGNtM52tLMMkGn2yRHkmuZf/Zujd0BM3u68s=;
	b=oEr7QA3mKbhoVPXJ4rVR6K/mwPDkNHBzxLnqHDWCsO4VKPlZjwYj3eRdi2Gf/G3X+QNhXB
	FUt27PsTIkvIEkgszs0m47WlitGv2qz464gNGHwnl+Mv1ymscQc8SF1bSLShI1Q0tALWBo
	JRiVozWVzx0FHDh3nj0XWWVT+fksojY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782140076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jxh1gHLoGNtM52tLMMkGn2yRHkmuZf/Zujd0BM3u68s=;
	b=844/HlofZeD0Pz5Js3SnEw2w3Srz5DH8PDQv+1zn4ZJw7uKsbX3Cqt5dnct4KSDwXol9pf
	f/D+uc5gFMBL2nBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782140076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jxh1gHLoGNtM52tLMMkGn2yRHkmuZf/Zujd0BM3u68s=;
	b=oEr7QA3mKbhoVPXJ4rVR6K/mwPDkNHBzxLnqHDWCsO4VKPlZjwYj3eRdi2Gf/G3X+QNhXB
	FUt27PsTIkvIEkgszs0m47WlitGv2qz464gNGHwnl+Mv1ymscQc8SF1bSLShI1Q0tALWBo
	JRiVozWVzx0FHDh3nj0XWWVT+fksojY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782140076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jxh1gHLoGNtM52tLMMkGn2yRHkmuZf/Zujd0BM3u68s=;
	b=844/HlofZeD0Pz5Js3SnEw2w3Srz5DH8PDQv+1zn4ZJw7uKsbX3Cqt5dnct4KSDwXol9pf
	f/D+uc5gFMBL2nBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10382779A8;
	Mon, 22 Jun 2026 14:54:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DRWPAqxMOWrdeQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 22 Jun 2026 14:54:36 +0000
Message-ID: <926d9d5f-be68-4377-9a90-0d9ace2c2c53@suse.de>
Date: Mon, 22 Jun 2026 16:54:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/fb-helper: Only consider active CRTCs for vblank
 sync
To: Jani Nikula <jani.nikula@linux.intel.com>, hns@goldelico.com,
 zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, akemnade@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
 sashiko-reviews@lists.linux.dev, stable@vger.kernel.org
References: <20260622113434.682292-1-tzimmermann@suse.de>
 <395f15bb770b4be0ffeeb09e7cdeef49340f910c@intel.com>
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
In-Reply-To: <395f15bb770b4be0ffeeb09e7cdeef49340f910c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[linux.intel.com,goldelico.com,iscas.ac.cn,kernel.org,gmail.com,ffwll.ch];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[iscas.ac.cn:email,suse.com:url,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,goldelico.com:email];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,iscas.ac.cn:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

Hi

Am 22.06.26 um 15:34 schrieb Jani Nikula:
> On Mon, 22 Jun 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Only synchronize fbdev output to the vblank of an active CRTC. Go over
>> the list of CRTCs and pick the first that matches. Fixes warnings as
>> the one shown below
>>
>> [   77.201354] WARNING: drivers/gpu/drm/drm_vblank.c:1320 at drm_crtc_wait_one_vblank+0x194/0x1cc [drm], CPU#1: kworker/1:7/1867
>> [   77.201354] omapdrm omapdrm.0: [drm] vblank wait timed out on crtc 0
>>
>> This currently happens if the fbdev output is not on CRTC 0.
>>
>> Atomic and non-atomic drivers require distinct code paths. As for other
>> fbdev operations, implement both and select the correct one at runtime.
>>
>> Not finding an active CRTC is not a bug. Do not wait in this case, but
>> flush the display update as before.
>>
>> v2:
>> - move look-up code into separate helper
>> - support drivers with legacy modesetting
>> v1:
>> - see https://lore.kernel.org/dri-devel/1c9e0e24-9c4a-4259-8700-cf9e5fd60ca3@suse.de/
>>
>> Co-authored-by: H. Nikolaus Schaller <hns@goldelico.com>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Fixes: d8c4bddcd8bcb ("drm/fb-helper: Synchronize dirty worker with vblank")
>> Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
>> Closes: https://bugs.debian.org/1138033
>> Cc: <stable@vger.kernel.org> # v6.19+
>> ---
>>   drivers/gpu/drm/drm_fb_helper.c | 71 ++++++++++++++++++++++++++++++++-
>>   1 file changed, 70 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
>> index 7b11a582f8ec..cbf0a9a7b8e5 100644
>> --- a/drivers/gpu/drm/drm_fb_helper.c
>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>> @@ -225,16 +225,85 @@ static void drm_fb_helper_resume_worker(struct work_struct *work)
>>   	console_unlock();
>>   }
>>   
>> +static int find_crtc_index_atomic(struct drm_fb_helper *helper)
>> +{
>> +	struct drm_device *dev = helper->dev;
>> +	struct drm_plane *plane;
>> +
>> +	drm_for_each_plane(plane, dev) {
>> +		const struct drm_plane_state *plane_state;
>> +		const struct drm_crtc *crtc;
>> +
>> +		if (plane->type != DRM_PLANE_TYPE_PRIMARY)
>> +			continue;
>> +
>> +		plane_state = plane->state;
>> +		if (plane_state->fb != helper->fb || !plane_state->crtc)
>> +			continue; /* plane doesn't display fbdev emulation */
>> +
>> +		crtc = plane_state->crtc;
>> +		if (!crtc->state->active)
>> +			continue;
>> +		if (drm_WARN_ON_ONCE(dev, crtc->index > INT_MAX))
>> +			continue; /* driver bug */
> I take it this is here because crtc->index is unsigned, and this
> function returns int so you can have negative error codes. Ditto the
> other function below.
>
> I feel like this is something that should be checked once somewhere, if
> that. I think adding arbitrary checks like this invites more arbitrary
> checks everywhere. crtc->index is supposed to be invariant over the
> lifetime of the CRTC.

Ok, makes sense.

Best regards
Thomas

>
> BR,
> Jani.
>
>> +
>> +		return crtc->index;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int find_crtc_index_legacy(struct drm_fb_helper *helper)
>> +{
>> +	struct drm_device *dev = helper->dev;
>> +	struct drm_crtc *crtc;
>> +
>> +	drm_for_each_crtc(crtc, dev) {
>> +		struct drm_plane *plane = crtc->primary;
>> +
>> +		if (!crtc->enabled)
>> +			continue;
>> +		if (!plane || plane->fb != helper->fb)
>> +			continue; /* CRTC doesn't display fbdev emulation */
>> +		if (drm_WARN_ON_ONCE(dev, crtc->index > INT_MAX))
>> +			continue; /* driver bug */
>> +
>> +		return crtc->index;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int drm_fb_helper_find_crtc_index(struct drm_fb_helper *helper)
>> +{
>> +	struct drm_device *dev = helper->dev;
>> +	int crtc_index;
>> +
>> +	mutex_lock(&dev->mode_config.mutex);
>> +
>> +	if (drm_drv_uses_atomic_modeset(dev))
>> +		crtc_index = find_crtc_index_atomic(helper);
>> +	else
>> +		crtc_index = find_crtc_index_legacy(helper);
>> +
>> +	mutex_unlock(&dev->mode_config.mutex);
>> +
>> +	return crtc_index;
>> +}
>> +
>>   static void drm_fb_helper_fb_dirty(struct drm_fb_helper *helper)
>>   {
>>   	struct drm_device *dev = helper->dev;
>>   	struct drm_clip_rect *clip = &helper->damage_clip;
>>   	struct drm_clip_rect clip_copy;
>> +	int crtc_index;
>>   	unsigned long flags;
>>   	int ret;
>>   
>>   	mutex_lock(&helper->lock);
>> -	drm_client_modeset_wait_for_vblank(&helper->client, 0);
>> +	crtc_index = drm_fb_helper_find_crtc_index(helper);
>> +	if (crtc_index >= 0)
>> +		drm_client_modeset_wait_for_vblank(&helper->client, crtc_index);
>>   	mutex_unlock(&helper->lock);
>>   
>>   	if (drm_WARN_ON_ONCE(dev, !helper->funcs->fb_dirty))

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


