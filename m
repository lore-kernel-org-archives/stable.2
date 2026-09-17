Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601F5304D0;
	Thu, 17 Sep 2026 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664484; cv=none; b=Ubaa4XdPAgPhSIHZNe8Ze2+GEVaNINL9Fzh1zn1q1MPhgkP88MtPZNfKCLi927LwIF6x0o4mHbvMh5CKl0v7SMjM1tmDpUMsyunsMuqFD97ATSfN/qTtgcQQq0CPLAWJzmzcA+tcuneperq1W9DZc4JPjhPCSfwOh64JDfNAnPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664484; c=relaxed/simple;
	bh=MuXRCTMFF1+DXrArzcMNSZ4vAfeJNg15+r0bo7TX/JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qiq5fwZrD8ICjhMJRYOmTdMrBmHqkmcWpyC9YpArxQuev5q/ywTZwoNrkyjreGXVb5CKfLKPg6UAHtvvbgz7bT4oLb4IEVFmP35GtsOwuIKGZRtw9hzYhnG1QxXgjCh80EwycQ4v75Ust7ko9TtmBCPyUuriDYFWMgGWQ5FE+7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B3hVcA4l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=turxnDHO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ic2Q2o2t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QJGRZrOn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B3hVcA4l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="turxnDHO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ic2Q2o2t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QJGRZrOn"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4AE6B1FF79;
	Thu, 17 Sep 2026 17:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789664475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5uhCQu1LsR2DxLlwe1opPC+yCFUyyvPxUdPcJQiuwgQ=;
	b=B3hVcA4lgerhjCfqx+uuP2w5bXDTmTEgMSIk4jf++hTUpfJmrilnotZLv6tIyDpcb/6F7Z
	uEji71sKc7nbU7NMiO5W54aVpiOcTTTtzMPwSunSi+BNqw2wR8dfbvT6Bp4uB7++jp7MND
	yhTFVhvooUWQIhHlskmIpaC+lEFqnA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789664475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5uhCQu1LsR2DxLlwe1opPC+yCFUyyvPxUdPcJQiuwgQ=;
	b=turxnDHO1F5xNtO3nEHg1oGSRWCgjaKv5nP29nQFVR/yXMl+jwv371OsTlo2DXacA/vS/v
	RZdJV9gwxcQlT3Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789664471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5uhCQu1LsR2DxLlwe1opPC+yCFUyyvPxUdPcJQiuwgQ=;
	b=ic2Q2o2tvFk2AE872FumL8erSziaX7E7YYsCvvaPSUV31WuB17F4tDLME7oQrdqBpAFbgr
	juITDLkcLqddUmKL1G/DP60TdJI47nC01FJVeq3xH2aOlYFraFtQVpEcu3SdnKstk3HYCL
	b7jhJ+oV1VaHPDCcHRLDBCmufaTVCFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789664471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5uhCQu1LsR2DxLlwe1opPC+yCFUyyvPxUdPcJQiuwgQ=;
	b=QJGRZrOnYGKSfVhgApSGkGrqK1CgcrVPHMisCBt21I/J4wk+Htu21dRrGuIIQZrBV22bMI
	3lDn16e+kNsZWmDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9E40134B3;
	Thu, 17 Sep 2026 17:01:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pGf7JtYcrGoTLAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 17 Sep 2026 17:01:10 +0000
Message-ID: <0c61889e-8632-4c68-9c98-bdd639abef66@suse.de>
Date: Thu, 17 Sep 2026 19:01:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/client: fix restore of partially initialized
 client
To: shechenglong <shechenglong@xfusion.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stone.xulei@xfusion.com, chenjialong@xfusion.com, stable@vger.kernel.org
References: <20260907035147.1339-1-shechenglong@xfusion.com>
 <20260917154743.1621-1-shechenglong@xfusion.com>
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
In-Reply-To: <20260917154743.1621-1-shechenglong@xfusion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[xfusion.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xfusion.com:email,suse.com:url,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]

Hi,

I merged the patch into drm-misc-fixes.

Best regards
Thomas

Am 17.09.26 um 17:47 schrieb shechenglong:
> I got a null-ptr-deref report when closing a DRM file descriptor:
>
> WARNING: drivers/gpu/drm/drm_atomic.c:2031 at
> __drm_atomic_helper_set_config+0x18e/0x1b0 [drm]
>
> Call Trace:
> drm_client_modeset_commit_atomic+0x16b/0x220 [drm]
> drm_client_modeset_commit_locked+0x56/0x160 [drm]
> drm_client_modeset_commit+0x21/0x40 [drm]
> __drm_fb_helper_restore_fbdev_mode_unlocked.part.0+0x7b/0x80
> drm_fbdev_client_restore+0xe/0x20 [drm_client_lib]
> drm_client_dev_restore+0x9f/0xc0 [drm]
> drm_release+0xc5/0xe0 [drm]
>
> The warning is followed by a NULL pointer dereference:
>
> BUG: kernel NULL pointer dereference, address: 0000000000000008
>
> RIP:
> __drm_fb_helper_restore_fbdev_mode_unlocked.part.0+0x41/0x80
> [drm_kms_helper]
>
> Call Trace:
> drm_fbdev_client_restore+0xe/0x20 [drm_client_lib]
> drm_client_dev_restore+0x9f/0xc0 [drm]
> drm_release+0xc5/0xe0 [drm]
> __fput+0xdc/0x2b0
> __x64_sys_close+0x39/0x80
> do_syscall_64+0x8d/0x460
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> drm_client_register() adds the DRM client to the device client list
> before invoking the initial hotplug callback. If the hotplug callback
> fails, the client remains registered.
>
> For the fbdev client, a failure during drm_fb_helper_initial_config()
> causes the partially initialized fbdev helper to be cleaned up.
> drm_fb_helper_fini() releases fb_helper->info and leaves it NULL.
>
> The fbdev client therefore remains registered even though there is no
> fully initialized framebuffer device.
>
> Later, when userspace closes the DRM file descriptor, drm_release()
> can invoke the restore callbacks of registered DRM clients:
>
> drm_release()
> drm_client_dev_restore()
> drm_fbdev_client_restore()
> drm_fb_helper_restore_fbdev_mode_unlocked()
>
> drm_fbdev_client_restore() currently restores the fbdev state
> unconditionally. For a partially initialized fbdev client this can
> submit an incomplete modeset state and subsequently access fbdev
> state which has not been initialized, resulting in the warning and
> NULL pointer dereference above.
>
> drm_fbdev_client_unregister() already uses fb_helper->info to
> distinguish a fully probed framebuffer device from a partially
> initialized client.
>
> Use the same condition in drm_fbdev_client_restore() and skip restore
> if no framebuffer device has been successfully initialized.
>
> Fixes: 5d08c44e47b9 ("drm/fbdev: Add memory-agnostic fbdev client")
> Cc: <stable@vger.kernel.org> # v6.13+
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: shechenglong <shechenglong@xfusion.com>
> ---
> Changes in v2:
> - Add the Fixes and stable tags suggested by Thomas Zimmermann.
>
>   drivers/gpu/drm/clients/drm_fbdev_client.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/clients/drm_fbdev_client.c b/drivers/gpu/drm/clients/drm_fbdev_client.c
> index 91d196a397cf..1c16bc1084c4 100644
> --- a/drivers/gpu/drm/clients/drm_fbdev_client.c
> +++ b/drivers/gpu/drm/clients/drm_fbdev_client.c
> @@ -42,6 +42,14 @@ static int drm_fbdev_client_restore(struct drm_client_dev *client, bool force)
>   {
>   	struct drm_fb_helper *fb_helper = drm_fb_helper_from_client(client);
>   
> +	/*
> +	 * The client is registered before the initial fbdev probe.
> +	 * If probing failed, the client remains registered but there
> +	 * is no valid fbdev framebuffer to restore.
> +	 */
> +	if (!fb_helper->info || !fb_helper->fb)
> +		return 0;
> +
>   	drm_fb_helper_restore_fbdev_mode_unlocked(fb_helper, force);
>   
>   	return 0;

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


