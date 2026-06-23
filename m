Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3ED3CF20E
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205035; cv=none; b=GT8Ogw5EmTwxu+FNP32jAecBU+JzCiL+xhw5ytwBNqWNd7aqF6aY4KC1homTeaLm6MIL9/19srClqN3gG2WD/uJ0aiUyK4BSF3Z8ffTHy2c4iigBR6jw+vjT5zgK4Y1DjifFGcIK9zQXdEYl9MwiordY50KnNyQSck2Gv+pbHc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205035; c=relaxed/simple;
	bh=nkE2xvr+hQqQ0r5hE1cc/qumF5tMIZuFMp4dGeqRPoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gc5XQeBClfqrX/+Rjut4ZBpQJYQWxL5RSzvzGqAZKr2sFJ6mCY2//tA/7sFvcgOLpztkHdTWfkySKMKJJfyuFBJhXaJf22+32hWI48L49MkkzugLpbP0woVKxTdcz9fHegjD8EHy8LYT55Q1SWlbqi5GrqkKr1vZ7NM8QQCODeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=clHebJ78; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kBaW+rdI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=clHebJ78; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kBaW+rdI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="clHebJ78";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kBaW+rdI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="clHebJ78";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kBaW+rdI"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A49F875A77;
	Tue, 23 Jun 2026 08:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782204694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5dkq88s2J10K3XFOmbDzoGXv3fOMVTikGa20HgpJhv4=;
	b=clHebJ78UXYG7azFrkfVWizMA40Ip5ALkADsh2Qd1qP0sK8Afl5Al332t0R2xssXvQw8c4
	WemeMqhPuuCjLODJSQ33B4TVzggY83/s+BTwvspTAX/uKIxehB6QeLIAcxrFwUfBxpsfkC
	VL3FGmlomTGEJGYY0s9Swt4B6VFcuRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782204694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5dkq88s2J10K3XFOmbDzoGXv3fOMVTikGa20HgpJhv4=;
	b=kBaW+rdIYRvfiS6NHkVka371EGJZ4v3PWEdwG3A3Ar4gOKpAf19pXKNXxjZ2GS0x8zRnwp
	2rBSe2nXjgroxKCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=clHebJ78;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kBaW+rdI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782204694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5dkq88s2J10K3XFOmbDzoGXv3fOMVTikGa20HgpJhv4=;
	b=clHebJ78UXYG7azFrkfVWizMA40Ip5ALkADsh2Qd1qP0sK8Afl5Al332t0R2xssXvQw8c4
	WemeMqhPuuCjLODJSQ33B4TVzggY83/s+BTwvspTAX/uKIxehB6QeLIAcxrFwUfBxpsfkC
	VL3FGmlomTGEJGYY0s9Swt4B6VFcuRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782204694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5dkq88s2J10K3XFOmbDzoGXv3fOMVTikGa20HgpJhv4=;
	b=kBaW+rdIYRvfiS6NHkVka371EGJZ4v3PWEdwG3A3Ar4gOKpAf19pXKNXxjZ2GS0x8zRnwp
	2rBSe2nXjgroxKCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68562779A8;
	Tue, 23 Jun 2026 08:51:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q4YSGBZJOmqEYQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 23 Jun 2026 08:51:34 +0000
Message-ID: <e313b1d0-32a7-4312-acbb-54c34894e9c7@suse.de>
Date: Tue, 23 Jun 2026 10:51:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] drm/sysfb: simpledrm: Improve panel-size
 validation
To: Thierry Reding <treding@nvidia.com>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, rayyan@ansari.sh,
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 stable@vger.kernel.org
References: <20260622132433.722823-1-tzimmermann@suse.de>
 <20260622132433.722823-3-tzimmermann@suse.de> <ajlce8LJQVXm2eic@orome>
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
In-Reply-To: <ajlce8LJQVXm2eic@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ansari.sh,lists.freedesktop.org,lists.linux.dev,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:url,nvidia.com:email,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A49F875A77
X-Spam-Score: -4.51

Hi

Am 22.06.26 um 18:05 schrieb Thierry Reding:
> On Mon, Jun 22, 2026 at 03:19:36PM +0200, Thomas Zimmermann wrote:
>> Validate the panel size from the device-tree node against the
>> limitations of struct drm_display_mode. The type only stores sizes
>> in 16-bit fields. Fail transparently on errors; do not warn.
>>
>> v2:
>> - only use initialized values in debugging output (Sashiko)
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Fixes: 2a6d731a8f16 ("drm/simpledrm: Allow physical width and height configuration via panel node")
>> Cc: Rayyan Ansari <rayyan@ansari.sh>
>> Cc: <stable@vger.kernel.org> # v6.4+
>> ---
>>   drivers/gpu/drm/sysfb/simpledrm.c | 40 ++++++++++++++++++++++++++++---
>>   1 file changed, 37 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
>> index 15dcafa9d524..fa2121f81def 100644
>> --- a/drivers/gpu/drm/sysfb/simpledrm.c
>> +++ b/drivers/gpu/drm/sysfb/simpledrm.c
>> @@ -193,6 +193,40 @@ simplefb_get_memory_of(struct drm_device *dev, struct device_node *of_node)
>>   	return res;
>>   }
>>   
>> +static u16
>> +__simplefb_get_panel_size_mm_of(struct drm_device *dev, struct device_node *of_panel_node,
>> +				const char *name)
>> +{
>> +	int ret;
>> +	u32 value;
>> +
>> +	ret = of_property_read_u32(of_panel_node, name, &value);
>> +	if (ret) {
>> +		drm_dbg(dev, "simplefb: cannot parse panel %s: error %d\n",
>> +			name, ret);
>> +		return 0; /* not an error, simply ignore */
>> +	}
>> +	if (value > U16_MAX) {
>> +		drm_dbg(dev, "simplefb: panel %s of %u exceeds maximum value\n",
>> +			name, value);
>> +		return 0; /* not an error, simply ignore */
> I wonder if it's perhaps better to move this comment to the function
> scope and explain why this can be ignored. I didn't know and had to go
> look at drm_sysfb_mode() to see that if these are 0, it'll compute the
> physical dimensions based on a default of 96 DPI.

Makes sense.

>
>> +	}
>> +
>> +	return value;
>> +}
>> +
>> +static u16
>> +simplefb_get_panel_width_mm_of(struct drm_device *dev, struct device_node *of_panel_node)
>> +{
>> +	return __simplefb_get_panel_size_mm_of(dev, of_panel_node, "width-mm");
>> +}
>> +
>> +static u16
>> +simplefb_get_panel_height_mm_of(struct drm_device *dev, struct device_node *of_panel_node)
>> +{
>> +	return __simplefb_get_panel_size_mm_of(dev, of_panel_node, "height-mm");
>> +}
>> +
>>   /*
>>    * Simple Framebuffer device
>>    */
>> @@ -594,7 +628,7 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>>   	struct drm_sysfb_device *sysfb;
>>   	struct drm_device *dev;
>>   	int width, height, stride;
>> -	int width_mm = 0, height_mm = 0;
>> +	u16 width_mm = 0, height_mm = 0;
>>   	struct device_node *panel_node;
>>   	const struct drm_format_info *format;
>>   	struct resource *res, *mem = NULL;
>> @@ -658,8 +692,8 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>>   			return ERR_CAST(mem);
>>   		panel_node = of_parse_phandle(of_node, "panel", 0);
>>   		if (panel_node) {
>> -			simplefb_read_u32_of(dev, panel_node, "width-mm", &width_mm);
>> -			simplefb_read_u32_of(dev, panel_node, "height-mm", &height_mm);
>> +			width_mm = simplefb_get_panel_width_mm_of(dev, panel_node);
>> +			height_mm = simplefb_get_panel_height_mm_of(dev, panel_node);
>>   			of_node_put(panel_node);
>>   		}
>>   	} else {
> The drm_sysfb_mode() function that width_mm and height_mm get passed
> into accepts them as unsigned int, so maybe that should be changed as
> well for more consistency?

Also makes sense.

Best regards
Thomas

>
> In either case, since they all end up in the u16 in the struct, it's
> obviously correct to check for the range when parsing, so:
>
> Reviewed-by: Thierry Reding <treding@nvidia.com>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


