Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD430C152;
	Tue,  8 Sep 2026 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849184; cv=none; b=tBJYGsTq6F2YegTRBCwH1zQGHPNgrFIOojfb/fXHyvwV1R4JE6UBF+T8KRlVWB93wKhx9neLkoS84+uwTDIgRMPlKx1cm8SXUW57NajNRxleY8qRfahHg0Ufwac2mULrGNzRISVAMfJX8yQ11713TN/dR7xQRDIj/b/aqYO52Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849184; c=relaxed/simple;
	bh=MsAUywdv6FKEUBihRxALEMcisW3BLUkPYlh8XXCvDck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mag/E9oBR1D9UyGmA1oo11Xmc/qSgZa8n7W2UzlmjkjSbYRHQjSIpNtq6uYKw8ta0xmvdzxp/vxtvNIkM8CMIOa4xL+ktXE9REV7H3p1GtGJPHSyvEsvJVLD8Qcjcjh9T15qPOar3TeP6SxqGnhCpP6KM+n4+BKb4gqQs37rHpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FiQCn5VO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B6DSuA1j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JQJACMV0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5H0FtDEQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FiQCn5VO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B6DSuA1j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JQJACMV0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5H0FtDEQ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E60FE1F796;
	Tue,  8 Sep 2026 06:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788849171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q5KZD/XW23R32T6r6MBWpZy3syCbREHJcxvpt9GzgO0=;
	b=FiQCn5VO93vIro4DbxQjaMTXfB3OwK+wye9IHY0fJyDejt9C3oq1Vghuo1c9kG2a+GEkMf
	sc2+3EBqfD1iil1EpfU1UOw9RkCtJAynTckJWzhLiIDd48GH11NSP4hnVYEP6uMXPzGfWD
	iqSNKcSRD+E3jvOlmZsjKvhoCtLVRhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788849171;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q5KZD/XW23R32T6r6MBWpZy3syCbREHJcxvpt9GzgO0=;
	b=B6DSuA1jF6uocTW0EBLNFiOwTMypvQOCQm/JLsQ65WD6jQzP39qVOq7KJp9pojpHPG51Bi
	no3FC320ZfoTNjCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JQJACMV0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5H0FtDEQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788849166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q5KZD/XW23R32T6r6MBWpZy3syCbREHJcxvpt9GzgO0=;
	b=JQJACMV0xqgNsFSnyQ+NXxTolXIMTlPbTo7E2OQ8iyYbEXmhlSdlcvjPLVePOIUbJurWb+
	BQsZMzmfMaud63pRVvVEl2ZypWVA0blE9FdTKPkKKNtP0lPeOCADZ62biZgiEv6xPOcQIY
	3LQ/l87Lg1FJvYt1DIV0w2FWKGWaFmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788849166;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q5KZD/XW23R32T6r6MBWpZy3syCbREHJcxvpt9GzgO0=;
	b=5H0FtDEQszLjrvW13ZnLjgfLMhQo140RQCwg7HpVdPHu91ywRCKwatJGI2norkIkY2ufSc
	tyZHCOM8SxjpOEAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA2DD1347F;
	Tue,  8 Sep 2026 06:32:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +CsDKA6sn2rWKgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 08 Sep 2026 06:32:46 +0000
Message-ID: <8c592732-6025-4073-b075-0e3e6911c935@suse.de>
Date: Tue, 8 Sep 2026 08:32:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gud: Merge damage clips in full update mode
To: Sophie D <patches@scd31.com>, rubenru09@aol.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260907230849.31032-1-patches@scd31.com>
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
In-Reply-To: <20260907230849.31032-1-patches@scd31.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E60FE1F796
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[aol.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[scd31.com,aol.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,bootlin.com:url,scd31.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51

Hi

Am 08.09.26 um 01:08 schrieb Sophie D:
> When running in full update mode, previously small updates (such as
> moving the mouse across the screen) would cause many full frames to be
> generated. This would bog down the bus and lower the effective framerate
> significantly - I was seeing a drop from 60 FPS to 2 FPS.
>
> This patch fixes the bug by merging damage clips together.
>
> Fixes: 73cfd166e045 ("drm/gud: Replace simple display pipe with DRM atomic helpers")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: Sophie D <patches@scd31.com>
> ---
>   drivers/gpu/drm/gud/gud_pipe.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
> index 5ef887d84..20418bf81 100644
> --- a/drivers/gpu/drm/gud/gud_pipe.c
> +++ b/drivers/gpu/drm/gud/gud_pipe.c
> @@ -647,9 +647,14 @@ void gud_plane_atomic_update(struct drm_plane *plane,
>   	if (ret)
>   		goto out;
>   
> -	drm_atomic_helper_damage_iter_init(&iter, old_state, new_state);
> -	drm_atomic_for_each_plane_damage(&iter, &damage)
> -		gud_fb_handle_damage(gdrm, fb, &shadow_plane_state->data[0], &damage);
> +	if (gdrm->flags & GUD_DISPLAY_FLAG_FULL_UPDATE) {
> +		if (drm_atomic_helper_damage_merged(old_state, new_state, &damage))
> +			gud_fb_handle_damage(gdrm, fb, &shadow_plane_state->data[0], &damage);
> +	} else {
> +		drm_atomic_helper_damage_iter_init(&iter, old_state, new_state);
> +		drm_atomic_for_each_plane_damage(&iter, &damage)
> +			gud_fb_handle_damage(gdrm, fb, &shadow_plane_state->data[0], &damage);
> +	}

Such state needs to be checked much earlier. Please set 
plane_state->ignore_damage_clips [1] at the end of 
gud_plane_atomic_check [2] if in full-update mode.  The damage iterator 
will then do the right thing.

[1] 
https://elixir.bootlin.com/linux/v7.2.2/source/include/drm/drm_plane.h#L207
[2] 
https://elixir.bootlin.com/linux/v7.2.2/source/drivers/gpu/drm/gud/gud_pipe.c#L569

Best regards
Thomas

>   
>   	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


