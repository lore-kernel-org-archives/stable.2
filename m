Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136E1440A19;
	Thu, 17 Sep 2026 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627835; cv=none; b=f01lBYF5WT1WE3m9locyRFKK12akHoaCIBg6F2LPS/A9LcGvDyeySFrrfCB48NHzFNKFwTsaMzDTaHoHHqiFIqGxqoEyXinU5BpaJzDvnPN/H/PhFPHpSUdJBipGvqMqULq1KBVbKOb8mYvdbDiX5E3zI2vuTB9n/jv0EU7l0aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627835; c=relaxed/simple;
	bh=brNwFc7lJ4BF+lEULw3lKPrx9lBppOwG+zdBdOV5nuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5mGg26xIJC+L8gIZHHRgWYJoKvjWKA9UWs9ees+by1QbnobvGJ2ZS2gC37eAB5wmoXRfsjL7P6DWXGoeNh0EjX8BgMfhBj66ukTRmiBmJioVg+CSq3bie+3+UqntveiVHo7kzqXmAzPZ+8tpqndKnkXRB8EXtJxEEq5fdg08Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wblOtbjC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TBLLsnlz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gQhVQK0B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SJHCDlh/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wblOtbjC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TBLLsnlz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gQhVQK0B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SJHCDlh/"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B125221D61;
	Thu, 17 Sep 2026 06:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789627827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9fYHboSVW8fHJcZFTTtzAscQSNcUswBho2XC+wgFeyw=;
	b=wblOtbjCE//IH8attoEp0g1epeDKUawS9gJsxjU/mZksVZaIIjFa35XNjOEGbuP8lETKD9
	HdvOpHBY+IDduP8LVq1GbmSSWI2RUS821kUGhMUjDKBK029GYomo0szb5xWQqVFaZEbQgM
	LSd5fRCEZXJP5tOHOLC87mOLBAxSoj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789627827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9fYHboSVW8fHJcZFTTtzAscQSNcUswBho2XC+wgFeyw=;
	b=TBLLsnlzTwp22yCsGddbv3GJf2nk7s1WWVswpygffnN943EoX7lRNw8v988EXxYW78JsIy
	JfE5eB3WCk6L7DDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789627823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9fYHboSVW8fHJcZFTTtzAscQSNcUswBho2XC+wgFeyw=;
	b=gQhVQK0BrtfaZD8x15/rUb9ZH2/3ksZsfnFmF2eEdbA202P7ncRcVZ6lECeWNaI09eeFnL
	FbjIo9YT6INisB6b1pLT8rN3amrbO6OmzV8YWdbKZeEgOOut8V7SGnbMq6xpgIUi0UFTjs
	BBvOSANYXQTa5ltrU1Xs4RW2H8JGxOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789627823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9fYHboSVW8fHJcZFTTtzAscQSNcUswBho2XC+wgFeyw=;
	b=SJHCDlh/43hkJkJteA7inZN1LtAZxNeSyLHyu2F5N7OqTCmZZKk3m7tXH080OTSXfHSvgL
	hA6WvG0AUyU+B4AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 617E0134B3;
	Thu, 17 Sep 2026 06:50:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P/zaAq+Nq2pieAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 17 Sep 2026 06:50:23 +0000
Message-ID: <2d89b88f-863c-4e8d-839c-5e800b4c4902@suse.de>
Date: Thu, 17 Sep 2026 08:50:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware/sysfb: Fix device reference count leak in
 sysfb_disable()
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Wentao Liang <vulab@iscas.ac.cn>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "javierm@redhat.com" <javierm@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260916073815.1972045-1-vulab@iscas.ac.cn>
 <BN9PR12MB5146B7A8975825C3623CFF97F7B92@BN9PR12MB5146.namprd12.prod.outlook.com>
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
In-Reply-To: <BN9PR12MB5146B7A8975825C3623CFF97F7B92@BN9PR12MB5146.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,iscas.ac.cn:email,amd.com:email,suse.de:email,suse.de:mid]

Hi

Am 16.09.26 um 23:06 schrieb Deucher, Alexander:
> Public
>
>> -----Original Message-----
>> From: Wentao Liang <vulab@iscas.ac.cn>
>> Sent: Wednesday, September 16, 2026 3:38 AM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: dri-devel@lists.freedesktop.org; javierm@redhat.com; linux-
>> kernel@vger.kernel.org; tzimmermann@suse.de; Wentao Liang
>> <vulab@iscas.ac.cn>; stable@vger.kernel.org
>> Subject: [PATCH] firmware/sysfb: Fix device reference count leak in
>> sysfb_disable()
>>
>> In sysfb_disable(), parent is obtained via sysfb_parent_dev(si), which calls
>> screen_info_pci_dev(si) and returns a pointer to &pdev->dev with an acquired
>> reference count. However, sysfb_disable() does not release this reference
>> before returning, leading to a device reference leak.
>>
>> Fix this by checking if parent is not an ERR_PTR and calling
>> put_device(parent) before releasing the mutex.
>>
>> Fixes: b49420d6a1ae ("video/aperture: optionally match the device in
>> sysfb_disable()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>> ---
>>   drivers/firmware/sysfb.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c index
>> 8833582c1883..11c5ce128a6c 100644
>> --- a/drivers/firmware/sysfb.c
>> +++ b/drivers/firmware/sysfb.c
>> @@ -71,9 +71,12 @@ void sysfb_disable(struct device *dev)
>>
>>        mutex_lock(&disable_lock);
>>        parent = sysfb_parent_dev(si);
>> -     if (!dev || !parent || dev == parent) {
>> -             sysfb_unregister();
>> -             disabled = true;
>> +     if (!IS_ERR(parent)) {
> Are there cases where sysfb_unregister() would need to be called even if parent returns an error?

It could be seen as a defensive measure. Usually we want to unregister 
the system framebuffer only if the native driver's device equals the 
parent. But if we fail to retrieve a parent, it might be better to 
unregister unconditionally.  Otherwise the sysfb driver might interfere 
with the native driver.

I think that would be a good idea.

Best regards
Thomas


>
> Alex
>
>> +             if (!dev || !parent || dev == parent) {
>> +                     sysfb_unregister();
>> +                     disabled = true;
>> +             }
>> +             put_device(parent);
>>        }
>>        mutex_unlock(&disable_lock);
>>   }
>> --
>> 2.34.1

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


