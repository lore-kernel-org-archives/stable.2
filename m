Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425861;
	b=hL+vGl/H/3MkTuHe+Gi5XXIrHoS6/2POcV+u8TjLFLs/Yn/oZ/JYwqupsLkL7h2ngMCt
	 i2vDY9PnJqDEzuEIm2NiWBGDQUKB7RQOL7PrmYwG3jRYhou5yK5LwCFZ1/WxMVApRjSBd
	 XnaM8egn/rCnADfobjm1MbF8Nw2rx5OeTXXX1FfYhOdeoAvsTQWUlQreANQv89Y2ccKGF
	 WgUQ7+libAHZjvNgi8XRyGd8XxMD0/1DHUlrsraNRn3JWCWOklRzQcviqIbAAVdFxAEfI
	 0/psRJhhe1HCM+i+SkDQch+1lQlGvwAjfGzwuEUSW+HwH9YWbdcuQ2GES/XFJm2A93Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425861;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Rspamd-Action:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Flag:X-Spam-Score;
	bh=aLbreY+cSFG22Ltqle1KLEkxhV/BXDyA9LZcfExWCOo=;
	b=VZurMJPrZ9jzYFoIaM5WdEa5GnCdkQxEKi377hbkEx0mFtjG/Y08b6kodhjIMmxjDtkm
	 48yIbnYaLhdSzCwh9O62y3IyxFQeF473kY7svV/TnwRYoU6er1f9avia09AG0fqZie5/j
	 KqyydeU78Q3n2IjoAI6Stnpcph8SvOFVRj7s6tGI7qNCkMjRpBEhJ0UcqzYMADp00sk82
	 JPy1QcPW/8w/QBDGAYC/1AJfZvJ915cEDUoK1uKBNQKWUOJtqILd6i6hRSqTJDtjUUJzo
	 VMqcLb+0Ve8UC9/xKvFZffr7a/iPBFn0XoMP/1Mgqnju6FWdadWDbH9zOTIBhYyfBHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=r8LP8w6O;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uqyW45aQ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=r8LP8w6O;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uqyW45aQ;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688EF60724A6
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 16:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 688EF60724A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=r8LP8w6O;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uqyW45aQ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=r8LP8w6O;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uqyW45aQ
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC1E821D11;
	Mon, 19 Oct 2026 16:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792425836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aLbreY+cSFG22Ltqle1KLEkxhV/BXDyA9LZcfExWCOo=;
	b=r8LP8w6OkVtOGYrCF1ciEOAovHtI/vbqdd1PevdXjLKUQUXWcUQnm/CBjX4UL7OwIFeI2y
	vNkRHIowwQ5h7RKiiSuOUyEzEaTyKfn04Pk7g6gQ6U3aIDyXffc1p00JHLVpw0UmqASr4s
	CyRs8GXfX+f4icUlEjqcWWiB6AmkUts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792425836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aLbreY+cSFG22Ltqle1KLEkxhV/BXDyA9LZcfExWCOo=;
	b=uqyW45aQiK7XrSAHqi0N7Tfx+P5pAauu6wRMIXFHJCOtDXkMlhlrJ1BzuGz3VJJ/zB7j2E
	kKOChI+grN3PGGBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r8LP8w6O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uqyW45aQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792425836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aLbreY+cSFG22Ltqle1KLEkxhV/BXDyA9LZcfExWCOo=;
	b=r8LP8w6OkVtOGYrCF1ciEOAovHtI/vbqdd1PevdXjLKUQUXWcUQnm/CBjX4UL7OwIFeI2y
	vNkRHIowwQ5h7RKiiSuOUyEzEaTyKfn04Pk7g6gQ6U3aIDyXffc1p00JHLVpw0UmqASr4s
	CyRs8GXfX+f4icUlEjqcWWiB6AmkUts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792425836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aLbreY+cSFG22Ltqle1KLEkxhV/BXDyA9LZcfExWCOo=;
	b=uqyW45aQiK7XrSAHqi0N7Tfx+P5pAauu6wRMIXFHJCOtDXkMlhlrJ1BzuGz3VJJ/zB7j2E
	kKOChI+grN3PGGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56D40136CC;
	Mon, 19 Oct 2026 16:03:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ndvHCmw/1mp9TwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 19 Oct 2026 16:03:56 +0000
Message-ID: <8e91baa4-1ca5-43b8-bb04-9b5e3630bc2b@suse.de>
Date: Mon, 19 Oct 2026 18:03:55 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/hyperv: add a parameter to disable the vblank timer
To: Lanfeng Wei <xlfylawarthur@gmail.com>
Cc: airlied@gmail.com, decui@microsoft.com, dri-devel@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 longli@microsoft.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 regressions@lists.linux.dev, simona@ffwll.ch, ssengar@linux.microsoft.com,
 stable@vger.kernel.org
References: <c238f4ff-d5d8-4a9a-8773-793bd9056c9b@suse.de>
 <20261019154121.6257-1-xlfylawarthur@gmail.com>
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
In-Reply-To: <20261019154121.6257-1-xlfylawarthur@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CC1E821D11
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,lists.freedesktop.org,vger.kernel.org,linux.intel.com,kernel.org,lists.linux.dev,ffwll.ch,linux.microsoft.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.50

Hi

Am 19.10.26 um 17:40 schrieb Lanfeng Wei:
> Hi Thomas,
>
>> Yeah, what's the cause of it? Switching off features does not fix any
>> bugs or improve the status quo.
> You are right that the module parameter is only a workaround for users
> affected; it does not fix the underlying scheduling problem.
>
> The cause is that the synthetic vblank timer is used to pace completion
> of atomic updates triggered by dirtyfb, in addition to providing
> synthetic vblank events. In Xorg's software-cursor path, pointer motion
> damages the primary framebuffer and the damage is instantly submitted
> via DRM_IOCTL_MODE_DIRTYFB. The Hyper-V dirtyfb path performs a
> synchronous atomic commit, and with the vblank timer enabled that commit
> can wait for the next simulated vblank. Under continuous pointer motion,
> these commits dominate the update path and delay normal client updates,
> resulting in sever frame-rate drops.
>
> This particular regression results from the combination of the blocking
> dirtyfb path, synthetic vblank pacing, and the absence of a Linux DRM
> cursor plane in Hyper-V. While the Hyper-V video protocol does have a
> hardware-cursor command path, the upstream hyperv_drm driver currently
> exposes only a primary plane. Cursor plane support was deferred during
> the initial upstreaming [1]. Without a cursor plane, Xorg has to fall
> back to software cursor-rendering path and it competes with periodic
> graphical updates on the primary plane.
>
> So the proper long-term fix could be adding cursor plane support in the
> Hyper-V DRM driver, which may take some time. Providing that the stated
> purpose of the offending commit is to rate-limit display updates, while
> its current implementation regresses the existing software-cursor path,
> I think adding a switch or reverting the commit until the requested
> features in the driver is ready, is a reasonable short-term fix.

The problem is that module parameters are impossible to remove in 
practice. Once in place, someone always depends on it. They also 
increase the number of states to test.  Avoiding them is usually a good 
idea. Especially as workarounds for bug or regressions.


I'm not familiar with the Hyper-V protocol, so I have a question. Why is 
it hard to implement cursors? From the link at [1], I assume that cursor 
support was left out because the simple-kms pipeline did not support 
cursor planes. This has long been resolved: the simple-kms pipeline is 
gone and hyperv_drm runs on the regular DRM framework.  Unless there's 
anything special with the Hyper-V protocol, cursor-plane support should 
be do-able in a single patch. [^1]

Best regards
Thomas

[^1] See 
https://elixir.bootlin.com/linux/v7.2.11/source/drivers/gpu/drm/ast/ast_cursor.c 
for an example of how this looks. Most of it is hardware-related, but 
hyperv would likely be similar in concept.

>
>> We had another fix for a problem with vblank timers:
>>
>> https://lore.kernel.org/dri-devel/20260914110004.211027-1-tzimmermann@suse.de/
>>
>> Did you validate that this fix is unrelated?
> Yes I tested that fix and confirmed that it is irrelevant. It solves
> issues with excessively long frame durations, however this problem is
> found in normal frame updates (in my case 60Hz / 16.7 ms per frame, way
> below INT_MAX).
>
> Best regards,
>
> Lanfeng Wei
>
> [1] https://lore.kernel.org/dri-devel/20200622110623.113546-1-drawat.floss@gmail.com/

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


