Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7253F8ED3
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699805; cv=none; b=R3aH+MeEuH/PbbF2qfiZCZViMjFpBRGrgbngyKrzjW4p6xzjC86S8n4yvCUOnII26D/kFqaNxKKYRePK8MHHUM829jiZtiiK68+xRCKPB6qBIC85OA/qyhzQxFh7/HJwurtiUiCFbvhiNcUMYPecUPIKx34DeWLt7y3mHMdUckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699805; c=relaxed/simple;
	bh=BLhbvrRR/HJ2UXcFhZDaXzn6kzxtWODktq5uNU4CFu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4N0Sri/gISDpeVYJq9NciGJbPBVRHe+Al1VaCOMRix1acfkb4RkfjhQI9aQrYzxDjRXtH1O0Sj/8RG4FoLiz1YQsbCKT2eFJmYWTVirehq1e4pZt7Xgxl0kGdoMFyb9vUmZzJZgvGmsPDBMWXuMfK+Wn0qwzz2YeA6coIEShJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SB1YPUr3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jq2mttOj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SB1YPUr3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jq2mttOj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SB1YPUr3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jq2mttOj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SB1YPUr3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jq2mttOj"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 52C9E75AE4;
	Wed, 17 Jun 2026 12:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781699800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uMwmD5ZVKo48graesQDZg+wP6nz0U0LlLpQHB/3WxOs=;
	b=SB1YPUr3ni0ThVz0W1qRVpKO0aHK2y+Po0bTOFTdQYTHtoQ32wTt7J1QUmNY/Kb9QCsvsM
	Hi5nx/TkR+fm+OgKjjsHs9eXWXhwYHgNuL9VG5sgpq8kfRhd+H8XjjJzGfgPC+exBIuZt+
	b2id3KN0pse/eexwj9Y+MMrPGN0F2Hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781699800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uMwmD5ZVKo48graesQDZg+wP6nz0U0LlLpQHB/3WxOs=;
	b=Jq2mttOjjS3NHtXBy5w6IKCUu57tgAfIFSWY28UgO5fmNXvN3WhV2Io/LZGGyikWW5Wwln
	T9aWM21NfzZFS2Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781699800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uMwmD5ZVKo48graesQDZg+wP6nz0U0LlLpQHB/3WxOs=;
	b=SB1YPUr3ni0ThVz0W1qRVpKO0aHK2y+Po0bTOFTdQYTHtoQ32wTt7J1QUmNY/Kb9QCsvsM
	Hi5nx/TkR+fm+OgKjjsHs9eXWXhwYHgNuL9VG5sgpq8kfRhd+H8XjjJzGfgPC+exBIuZt+
	b2id3KN0pse/eexwj9Y+MMrPGN0F2Hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781699800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uMwmD5ZVKo48graesQDZg+wP6nz0U0LlLpQHB/3WxOs=;
	b=Jq2mttOjjS3NHtXBy5w6IKCUu57tgAfIFSWY28UgO5fmNXvN3WhV2Io/LZGGyikWW5Wwln
	T9aWM21NfzZFS2Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C5BC779A8;
	Wed, 17 Jun 2026 12:36:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uI6gBdiUMmrXKwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 17 Jun 2026 12:36:40 +0000
Message-ID: <ebf3a909-99e4-47f3-9c1c-b329d6000996@suse.de>
Date: Wed, 17 Jun 2026 14:36:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/sysfb: Do not page-align visible size of the
 framebuffer
To: Javier Martinez Canillas <javierm@redhat.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 stable@vger.kernel.org
References: <20260617112932.511657-1-tzimmermann@suse.de>
 <20260617112932.511657-2-tzimmermann@suse.de>
 <874ij1z90y.fsf@ocarina.mail-host-address-is-not-set>
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
In-Reply-To: <874ij1z90y.fsf@ocarina.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:email,suse.de:mid]
X-Spam-Level: 

Hi

Am 17.06.26 um 13:44 schrieb Javier Martinez Canillas:
> Thomas Zimmermann <tzimmermann@suse.de> writes:
>
> Hello Thomas,
>
>> Only return the actually visible size of the system framebuffer in
>> drm_sysfb_get_visible_size_si(). Drivers use this size value for
>> reserving access to framebuffer memory. Increasing the value can
>> make later attempts to do so fail.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Fixes: 32ae90c66fb6 ("drm/sysfb: Add efidrm for EFI displays")
>> Fixes: a84eb6abe2b6 ("drm/sysfb: Add vesadrm for VESA displays")
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Javier Martinez Canillas <javierm@redhat.com>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: <stable@vger.kernel.org> # v6.16+
>> ---
>>   drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
>> index 749290196c6a..361b7233600c 100644
>> --- a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
>> +++ b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
>> @@ -67,7 +67,7 @@ EXPORT_SYMBOL(drm_sysfb_get_stride_si);
>>   u64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct screen_info *si,
>>   				  unsigned int height, unsigned int stride, u64 size)
>>   {
>> -	u64 vsize = PAGE_ALIGN(height * stride);
> Do you know why the original efidrm_get_visible_size_si() (from where
> you took this code to make it generic) did the page align ?

There's nothing in the old reviews AFAICT. I think, it was an oversight 
from prototyping the driver. I certainly wanted to return 0 for errors 
at first, but later changed it to an errno code. There, I forgot to 
update the code accordingly.

>
> The change makes sense to me though from your explanation:
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks.

Best regards
Thomas

>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


