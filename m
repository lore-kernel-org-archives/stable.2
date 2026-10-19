Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6DB489FB1
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395384; cv=none; b=e+uq3kIjkPBvBW+I7wbUI01UHDGrCIVdixLeTbxXfRzevzxsPUGMVQ+BrlcxVbiZ6wfNoJ9XtlNo9qbJeotayXq3w/KJKT0GhUipmtZRsw0nwMD0BxLKYeNA+9dwNjPLcJkZ1tohY5+TgPIvH3KOs+Et+j930Eqesp2ovEaGcsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395384; c=relaxed/simple;
	bh=4XfcpeDqELvt1DkF3dbMuEEccglxwIYHWZ58GO1+JxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfLRqqrOZqK3cL7gckxZIRghNguSfeMe5bqculxeZRCRJ7u37/Ns+f+fG3Kj7el9ZcD6qL9rmSddvHJZL27PJTYo1amVF1XBk/TS/zuwDfGVKBFC4322jD/s8UsWEVC2T4lJKrkIzZOe43iAMmF1qfbsHlnge3vVjBfgPDCnsKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k9jY//tn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rkQsG9ms; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k9jY//tn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rkQsG9ms; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k9jY//tn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rkQsG9ms";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k9jY//tn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rkQsG9ms"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 11EC821E2D;
	Mon, 19 Oct 2026 07:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792395373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8nQUL6BAT1jXGqmh3FAOn1A9KYuAO9FbrCjrnMbJpDc=;
	b=k9jY//tnFJOaiF1B2azDwhv244Q9WuB1EseGtNaBO0wKHsjrzHi0ehT6l9Co/c+x6oO2TG
	1VNPAEq/p8ioYWkfJGEjOCa2BaY8teplu6qLAtfgmsryCbMihFMON7EHxFwdAJ562sg3EF
	otm1I6F/7X7KaGi76tNVErv0ZTnCidU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792395373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8nQUL6BAT1jXGqmh3FAOn1A9KYuAO9FbrCjrnMbJpDc=;
	b=rkQsG9ms9IacDQzBS4ihfUIE5DXdZQE6DKwjAEgyq6W+R8lEJsXsp9jashArTNqqHA70bZ
	OJoXluJ18bQCTHBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="k9jY//tn";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rkQsG9ms
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792395373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8nQUL6BAT1jXGqmh3FAOn1A9KYuAO9FbrCjrnMbJpDc=;
	b=k9jY//tnFJOaiF1B2azDwhv244Q9WuB1EseGtNaBO0wKHsjrzHi0ehT6l9Co/c+x6oO2TG
	1VNPAEq/p8ioYWkfJGEjOCa2BaY8teplu6qLAtfgmsryCbMihFMON7EHxFwdAJ562sg3EF
	otm1I6F/7X7KaGi76tNVErv0ZTnCidU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792395373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8nQUL6BAT1jXGqmh3FAOn1A9KYuAO9FbrCjrnMbJpDc=;
	b=rkQsG9ms9IacDQzBS4ihfUIE5DXdZQE6DKwjAEgyq6W+R8lEJsXsp9jashArTNqqHA70bZ
	OJoXluJ18bQCTHBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CEBB134B3;
	Mon, 19 Oct 2026 07:36:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4tfuGGzI1Wo7KwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 19 Oct 2026 07:36:12 +0000
Message-ID: <c238f4ff-d5d8-4a9a-8773-793bd9056c9b@suse.de>
Date: Mon, 19 Oct 2026 09:36:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/hyperv: add a parameter to disable the vblank timer
To: Lanfeng Wei <xlfylawarthur@gmail.com>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-hyperv@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <20261017153524.8870-1-xlfylawarthur@gmail.com>
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
In-Reply-To: <20261017153524.8870-1-xlfylawarthur@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spam-Score: -4.50
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com,microsoft.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,vger.kernel.org,lists.freedesktop.org,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:url,suse.de:dkim]
X-Spam-Level: 
X-Rspamd-Queue-Id: 11EC821E2D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Hi

Am 17.10.26 um 17:34 schrieb Lanfeng Wei:
> A performance regression has been observed on Hyper-V causing serious
> frame rate drops since commit 52e6b1988334 ("drm/hypervdrm: Use vblank
> timer").
>
> The regression occurs when using Xorg with a software rendered cursor.
> The offending commit uses the DRM vblank hrtimer to pace atomic update
> completion events, making each event wait for the next simulated vblank.
> However, cursor damage invoked by mouse movement is unconstrained by
> screen refresh rate, and therefore consumes most of Xorg's update
> opportunities, starving normal graphical updates, resulting in
> plummeting frame rate.
>
> Hyper-V virtual display framebuffer is able to accept multiple writes in
> one update window, so the commit broke this expected behavior.
>
> The regression is also reported by other users:
>
> Link: https://www.mail-archive.com/ubuntu-bugs@lists.ubuntu.com/msg6302857.html
>
> Add a read-only module parameter hyperv_drm.vblank_timer, which is
> enabled by default. Disabling it prevents the timer's enable callback
> from starting the timer. The vblank framework and the existing atomic
> callbacks remain registered. When disabled, the first
> drm_crtc_vblank_get() fails through the callback, so the existing helper
> sends the atomic event immediately and skips the vblank wait, matching
> the behavior before the timer was introduced.

Yeah, what's the cause of it? Switching off features does not fix any 
bugs or improve the status quo.


We had another fix for a problem with vblank timers:

https://lore.kernel.org/dri-devel/20260914110004.211027-1-tzimmermann@suse.de/

Did you validate that this fix is unrelated?

Best regards
Thomas


>
> This provides an opt-out for affected virtual display users.
>
> Benchmark results:
>
> Workload: Inject mouse movement at 125 Hz against a flashing
> animation running at 60 Hz, matching the screen refresh rate, for 4
> seconds.
>
> Tested versions: 6.18 (the last major version before the offending
> commit), version 6.19 (the first major version containing that commit),
> version 7.1.8 (on which the patch is based), and its patched version.
>
> Version  Anim. Hz            Mouse Hz         Max client-request gap
> ====================================================================
> 6.18     59.66-60.00        122.00-123.33     17.0 ms
> 6.19     0-0.162            59.73-59.86       7.53 s
> 7.1.8    0.133-0.162        59.83-59.86       6.16 s
> Patched  59.75-60.00        122.75-124.50     14.0 ms
>
> The patch restores both animation and mouse update rates, and reduces
> the maximum client-request gap from seconds to milliseconds.
>
> Fixes: 52e6b1988334 ("drm/hypervdrm: Use vblank timer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lanfeng Wei <xlfylawarthur@gmail.com>
> ---
> The parameter defaults to enabled to preserve the current kernel
> behavior. I do not know the full set of users who rely on the vblank
> timer, so changing the default could introduce a different regression.
> Affected users can set hyperv_drm.vblank_timer=0.
>
> If the maintainers prefer the parameter to default to disabled, or if
> there is a better way to detect the affected configuration
> automatically, I'm happy to send a v2.
>   drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 23 ++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> index d48ca6c23..527385748 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <linux/hyperv.h>
> +#include <linux/moduleparam.h>
>   
>   #include <drm/drm_atomic.h>
>   #include <drm/drm_crtc_helper.h>
> @@ -25,6 +26,19 @@
>   
>   #include "hyperv_drm.h"
>   
> +static bool vblank_timer = true;
> +module_param(vblank_timer, bool, 0444);
> +MODULE_PARM_DESC(vblank_timer,
> +		 "Enable the Hyper-V DRM vblank timer (default: true)");
> +
> +static int hyperv_crtc_enable_vblank(struct drm_crtc *crtc)
> +{
> +	if (!vblank_timer)
> +		return -EOPNOTSUPP;
> +
> +	return drm_crtc_vblank_helper_enable_vblank_timer(crtc);
> +}
> +
>   static int hyperv_blit_to_vram_rect(struct drm_framebuffer *fb,
>   				    const struct iosys_map *vmap,
>   				    struct drm_rect *rect)
> @@ -132,7 +146,14 @@ static const struct drm_crtc_funcs hyperv_crtc_funcs = {
>   	.page_flip = drm_atomic_helper_page_flip,
>   	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
>   	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
> -	DRM_CRTC_VBLANK_TIMER_FUNCS,
> +	/*
> +	 * expanded DRM_CRTC_VBLANK_TIMER_FUNCS to override
> +	 * enable_vblank with hyperv_crtc_enable_vblank
> +	 */
> +	.enable_vblank = hyperv_crtc_enable_vblank,
> +	.disable_vblank = drm_crtc_vblank_helper_disable_vblank_timer,
> +	.get_vblank_timestamp =
> +		drm_crtc_vblank_helper_get_vblank_timestamp_from_timer,
>   };
>   
>   static int hyperv_plane_atomic_check(struct drm_plane *plane,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


