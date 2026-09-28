Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95754349A5;
	Mon, 28 Sep 2026 06:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577113; cv=none; b=oirYbygwhRqKu7c3amwFFD77YfBHJzaLpZF0yrNHhL1I2QceA5X8c9l/gWOtLz4ubCzTcoOrVkODfttnGHwOO92GIeOooPXkMSR/YXhLAzrCgPxXah6y/XIc5syJWvSiqdubsf+WtqFTJZ0p6Esa3E2A8z2N7nPCuySoJaVX+fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577113; c=relaxed/simple;
	bh=9Il285388BxybXTDxTH1+2t+t53nD/PZTdFKZGc8FA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxs/cKMDYAEYuQ9Nb1dSRrj5dbZaOk5REOozZn0Wre/e0n33xln6QPYesWe8kpAkcitAxhvr54AvqdBYMjaLAm3LVsU/9RyFvWYabzMa4YA/sNyNWI6LdqZFlrF2RnMKO7Y0Xoq6F8PHiRHDwdXDWUG2UZDRPmYaOX+FVxI6sLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PGxSZnNt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ABLGZDmA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RTpY1fyP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YXDKyG7u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PGxSZnNt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ABLGZDmA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RTpY1fyP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YXDKyG7u"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6513221D31;
	Mon, 28 Sep 2026 06:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790577105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FDaDfs212NgUvCmr9pWEaywlhgSFzA9dZFzGmRyIntI=;
	b=PGxSZnNtJLiZ/ZJFkoLz58FtMKW99QZPDqNVsDvMoFRWHNJ1mvX8xCIQZsawXALCNsr3p8
	J3zLKGw6LtSfa/Mup528JvdJBVYWSR9KHam/jFPXOJCu5rhphU/ESrjOwbh133vaWxxEEz
	4WgdABxtwNrB+i/eoXU7lPHkZ7ViSl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790577105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FDaDfs212NgUvCmr9pWEaywlhgSFzA9dZFzGmRyIntI=;
	b=ABLGZDmAIOgZQT6P2ak1da6ELiW1C6dFzqx52k9DezRSSddkBpRkRN2sL65KGHnz9cuwtF
	6QtHlclj6yKIdzCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790577101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FDaDfs212NgUvCmr9pWEaywlhgSFzA9dZFzGmRyIntI=;
	b=RTpY1fyPsjdZQlvQAEP2IV/0L7wujxktcmMHjtZskaY68baNv8DZGJ3G1dZC6nt0IqKV3l
	sfwy1eSk7gg24rOtfZRih+vzIN96vYEU7UzA1sMterSRdqaos4akzXo/inRYatTMMpMS+T
	3wzMkRGNQKwmfgrWDaEvczGsM59IVL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790577101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FDaDfs212NgUvCmr9pWEaywlhgSFzA9dZFzGmRyIntI=;
	b=YXDKyG7u8F6YWdZyuZJ3xKHtmHRf6spUbbDLENJB/SXNeI6UTrTXo4/wxJEuRkL8+0OAW2
	xl9bnjCqv+ty8XAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0701A133F3;
	Mon, 28 Sep 2026 06:31:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7RUqKMwJumpOfwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 28 Sep 2026 06:31:40 +0000
Message-ID: <21221a01-2533-44e0-881e-8225cd63fe02@suse.de>
Date: Mon, 28 Sep 2026 08:31:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/fb-helper: defer setup when fbdev_probe() fails, not
 just on -EAGAIN
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 syzbot+ca23c8570669ead78867@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20260927075434.72658-1-ngocthang2710.1999@gmail.com>
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
In-Reply-To: <20260927075434.72658-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[ca23c8570669ead78867];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,syzkaller.appspotmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,appspotmail.com:email,imap1.dmz-prg2.suse.org:helo,syzkaller.appspot.com:url,suse.com:url]
X-Spam-Flag: NO

Hi

Am 27.09.26 um 09:54 schrieb Nguyen Ngoc Thang:
> __drm_fb_helper_initial_config_and_unlock() calls
> drm_client_modeset_probe() first, which already fills in each
> mode_set->mode/num_connectors for every connected output, and only
> afterwards calls drm_fb_helper_single_fb_probe() to create
> fb_helper->fb and wire it into those mode_sets via
> drm_setup_crtcs_fb().
>
> If drm_fb_helper_single_fb_probe() fails with anything other than
> -EAGAIN (e.g. dev->driver->fbdev_probe() itself fails), the function
> bails out before drm_setup_crtcs_fb() runs and before setting
> fb_helper->deferred_setup. The client is left with mode_sets that
> have a mode and connectors but mode_set->fb == NULL, and nothing
> marks this fb_helper as needing a retry.
>
> __drm_fb_helper_restore_fbdev_mode_unlocked() only skips committing
> when fb_helper->deferred_setup is set, so a later .restore() call
> (drm_lastclose() on process exit, in this report) commits the stale
> mode_set through drm_client_modeset_commit() ->
> drm_client_modeset_commit_atomic() -> __drm_atomic_helper_set_config(),
> which hits WARN_ON(!set->fb).
>
> Mark fb_helper->deferred_setup on any drm_fb_helper_single_fb_probe()
> failure, not just -EAGAIN, so restore keeps skipping the commit until
> a later hotplug event successfully re-probes and re-populates
> mode_set->fb. The real error code is still returned to the caller
> unchanged.
>
> Reported-by: syzbot+ca23c8570669ead78867@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ca23c8570669ead78867
> Fixes: ca91a2758fce ("drm/fb-helper: Support deferred setup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks a lot for the fix.

Best regards
Thomas

> ---
> Tested in QEMU (KVM, x86_64) with the syzbot C reproducer, which enumerates
> a USB device over raw-gadget matching drm/gud's ID (idVendor 0x1d50,
> idProduct 0x614d) then opens the resulting DRM node. In our test VM gud
> lands on a different card minor than in the syzbot report since other
> drivers (vgem/vkms/bochs-drm) register first, but retargeting the
> reproducer's open() at gud's actual minor reproduces it directly on the
> very first probe:
>
>    gud 1-1:1.0: [drm] format XR24 little-endian (0x34325258) not supported
>    gud 1-1:1.0: [drm] No compatible format found
>    gud 1-1:1.0: [drm] *ERROR* fbdev: Failed to setup emulation (ret=-22)
>    ------------[ cut here ]------------
>    !set->fb
>    WARNING: drivers/gpu/drm/drm_atomic.c:2031 ...
>
> On the unpatched kernel this isn't benign: __drm_atomic_helper_set_config()
> warns and then continues, committing an active CRTC/plane with a NULL
> framebuffer, which escalates into a NULL-pointer dereference and a fatal
> kernel panic a few lines later in our runs. With this patch applied, the
> same gud probe failure (ret=-22) still happens every time as expected, but
> restore() no longer commits the stale mode_set: no warning, no panic,
> clean shutdown across repeated runs.
>
>   drivers/gpu/drm/drm_fb_helper.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index d4664ed468b2..0817b639b3fa 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -1724,10 +1724,10 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper *fb_helper)
>   
>   	ret = drm_fb_helper_single_fb_probe(fb_helper);
>   	if (ret < 0) {
> -		if (ret == -EAGAIN) {
> -			fb_helper->deferred_setup = true;
> +		/* modesets are probed but fb_helper->fb isn't; defer restore too */
> +		fb_helper->deferred_setup = true;
> +		if (ret == -EAGAIN)
>   			ret = 0;
> -		}
>   		mutex_unlock(&fb_helper->lock);
>   
>   		goto err_drm_fb_helper_release_info;

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


