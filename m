Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638108;
	b=D6IwX8ohV7Ye35ScCntVwo6ngK7iWayYP9HzmHzjVaNKMzqteBzWHiZ6G8L5JWZP0daB
	 d1tNJT50b5rT18QVz46bqm+tTe7Kn334xq1rHlHHXhCytHy+5S50ajXvI9xrid9Z4cIqf
	 AA3fnUz+Q5oKQ/3nmrneYjSwJCYwEJSrGYkhPdlY6PJWheq2aYuIxkBG6uOYTJMrTEq17
	 f2wbAc+YlYVb3ph0zbsvT4DRWsNB0nfYoDxveopC4DVXincNwyWl71EfKe3Kcvn5Hanbg
	 0CypiXFiuaDfD8AjonyttGiCtQIqFzFS0hAJvSu0RAkTTnSCPAd8kIlS6zT2TSBktLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638108;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Flag:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=s2SsEbFBgJaO9Jkmo+11Kl5ydWU1vOHQ5eCoJdpnSFM=;
	b=lFayFnusgXt2ym0s4hHZ2jK593/6gJuAi12WbUduS9JSrGwwF/rDdEsvBwOv0neGZzSh
	 kWAJWihOofxlZVCGTBJyLT7XTOt6Ot2FGSTuMOZU2ZcFpf2OQ9HAuxKxF3I4H3SCFhxRe
	 /g00ERvG9UOT/4yEr0e4jLdZmP+74as/pSi3hphoY8SCaNYXqjkz1tw2IUfRdTt4MGopW
	 tQi9lnCG8SFp4lSi2yBRTENLm33lm8EB2RZSlcUBfkU/anvZOVnOszn1jDsGS6buBsOQG
	 RoI3kAdJJObsRr6O9A62noHo1Qo+SGm7vNnoB9COljLlvMsbu2vH7GWjektssw4Xvsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=02nQqflh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GwcSGu1H;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MNBhQREX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aUbDg4gK;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52FA606B1F6
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B52FA606B1F6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=02nQqflh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GwcSGu1H;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MNBhQREX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aUbDg4gK
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F4292202B;
	Mon,  2 Nov 2026 16:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793638105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s2SsEbFBgJaO9Jkmo+11Kl5ydWU1vOHQ5eCoJdpnSFM=;
	b=02nQqflhIL2tyzXPE/ieje49qERwo8sAiJEG7oWVVufg+aPKvRN7n3OEnWvbv/B4IUIWiC
	geLX8hSyJ+4kek5OGMYddofr6Tao5xtPwQHkb34Mx5EAjtFosqg15y8J+VSCG7utl7zfxw
	z28GC8aMNd0nXINQbWC8rw1Ezn2XgpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793638105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s2SsEbFBgJaO9Jkmo+11Kl5ydWU1vOHQ5eCoJdpnSFM=;
	b=GwcSGu1HEwIpPPFDsRXsrj8mvXbodhyh+sq92ZFFGcgBdBS0FB3R0JNk1GPffir7OziXta
	HOq+1FXczPwgJzBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793638104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s2SsEbFBgJaO9Jkmo+11Kl5ydWU1vOHQ5eCoJdpnSFM=;
	b=MNBhQREXmZ9dH0LOn4imoP2vAQDtZhcnQsL0hbHwZYyeyU9wr6PFT82Jemb/Mn6C/RVQLK
	Cazah5smMSv29m8TOFXxzJBNKoxrW/wfnARz8RmIj4qPlvWxJcvqN4I2ddnqiRZdeJl3mA
	2tYA6GY4DRMeWrePyOBkfXTro52T9No=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793638104;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s2SsEbFBgJaO9Jkmo+11Kl5ydWU1vOHQ5eCoJdpnSFM=;
	b=aUbDg4gKIKZz/M1a3wNTXwMuN9r418R+iAPP1r8WycjozWF12slYyTh4F287xbO19aqLnz
	/4HT3KlurFDdnnCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EF75134B8;
	Mon,  2 Nov 2026 16:48:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R+UfN9e+6GquTgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Nov 2026 16:48:24 +0000
Message-ID: <4212140f-fa07-4f0c-bd3a-0ae3d88b250c@suse.de>
Date: Mon, 2 Nov 2026 17:48:23 +0100
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
Subject: Re: [PATCH] drm/vblank: Restart enabling vblank timer on possible
 deadlock
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, javierm@redhat.com, louis.chauvet@bootlin.com,
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 stable@vger.kernel.org
References: <20261102143919.1672293-1-tzimmermann@suse.de>
 <auioL8zR9O5u4TCF@intel.com>
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
In-Reply-To: <auioL8zR9O5u4TCF@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.com:url,intel.com:email,suse.de:email,ffwll.ch:email,bootlin.com:email,bootlin.com:url,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,redhat.com,bootlin.com,lists.freedesktop.org,lists.linux.dev,vger.kernel.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,lists.freedesktop.org:email,intel.com:email,ffwll.ch:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,bootlin.com:email,bootlin.com:url]
X-Spam-Score: -13.29

Hi

Am 02.11.26 um 16:11 schrieb Ville Syrjälä:
> On Mon, Nov 02, 2026 at 03:38:52PM +0100, Thomas Zimmermann wrote:
>> Return -EDEADLK when trying to cancel a running hrtimer as part of
>> enable_vblank(). Reacquire vblank_time_lock and try again.
>>
>> The vblank helper drm_vblank_disable_and_save() and the vblank IRQ
>> handler hold the spin lock vblank_time_lock at some point. This
>> can result in a deadlock if vblank timer's disable code in
>> drm_crtc_vblank_cancel_timer() calls hrtimer_cancel() directly: the
>> helper wais for the timer function to complete and the timer function
>> waits for the helper to release vblank.time_lock.
>>
>> drm_crtc_vblank_cancel_timer() works around this problem by calling
>> hrtimer_try_to_cancel() instead. For re-enabling the vblank timer,
>> drm_crtc_vblank_start_timer() must wait for the vblank timer to stop.
>> It runs into the same deadlock problem while waiting for the timer
>> function to complete.
>>
>> The solution to this problem is to release and reacquire the spin
>> lock vblank_time_lock if hrtimer_try_to_cancel() signals a running
>> timer function. Releasing the lock allows for the timer function to
>> make progress.
>>
>> Signal the possible deadlock with -EDEADLK and perform the necessary
>> steps. No other driver uses -EDEADLK in their enable_vblank, so the
>> change should not interfere.
>>
>> Tested with bochs on qemu.
>>
>> Closes: https://lore.kernel.org/dri-devel/20260914111129.300691F00898@smtp.kernel.org/
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Louis Chauvet <louis.chauvet@bootlin.com>
>> Cc: Javier Martinez Canillas <javierm@redhat.com>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Simona Vetter <simona@ffwll.ch>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard <mripard@kernel.org>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: <stable@vger.kernel.org> # v6.19+
>> ---
>> I also tried to move hrtimer_cancel() out of the critical section. The
>> result was fairly fragile. So returning an error and re-acquiring the
>> lock was the easier solution.
>> ---
>>   drivers/gpu/drm/drm_vblank.c | 21 +++++++++++++++------
>>   1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
>> index 5162250e8813..135efde86298 100644
>> --- a/drivers/gpu/drm/drm_vblank.c
>> +++ b/drivers/gpu/drm/drm_vblank.c
>> @@ -1182,10 +1182,12 @@ static int __enable_vblank(struct drm_device *dev, unsigned int pipe)
>>   static int drm_vblank_enable(struct drm_device *dev, unsigned int pipe)
>>   {
>>   	struct drm_vblank_crtc *vblank = drm_vblank_crtc(dev, pipe);
>> -	int ret = 0;
>> +	int ret;
>>   
>>   	assert_spin_locked(&dev->vbl_lock);
>>   
>> +retry:
>> +	ret = 0;
>>   	spin_lock(&dev->vblank_time_lock);
>>   
>>   	if (!vblank->enabled) {
>> @@ -1199,7 +1201,11 @@ static int drm_vblank_enable(struct drm_device *dev, unsigned int pipe)
>>   		ret = __enable_vblank(dev, pipe);
>>   		drm_dbg_core(dev, "enabling vblank on crtc %u, ret: %d\n",
>>   			     pipe, ret);
>> -		if (ret) {
>> +		if (ret == -EDEADLK) {
>> +			spin_unlock(&dev->vblank_time_lock);
>> +			cpu_relax();
>> +			goto retry;
>> +		} else if (ret) {
>>   			atomic_dec(&vblank->refcount);
>>   		} else {
>>   			drm_update_vblank_count(dev, pipe, 0);
>> @@ -2232,11 +2238,14 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
>>   			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>>   	} else {
>>   		/*
>> -		 * Timer should not be active. If it is, wait for the
>> -		 * previous cancel operations to finish.
>> +		 * Timer should not be running. If it is, signal cancellation
>> +		 * again and restart to release locks.
>>   		 */
>> -		while (hrtimer_active(&vtimer->timer))
>> -			hrtimer_try_to_cancel(&vtimer->timer);
> Why do you even have to cancel the timer here? Just let it run?

We ran hrtimer_try_to_cancel() in drm_crtc_vblank_cancel_timer() to 
remove the vblank timer. When we later come here, we need to know if the 
timer has meanwhile been fully canceled. Hence we need at least one call 
to hrtimer_try_to_cancel() even if the timer is in some bogus state 
where it should not be active. The loop here was nonsense and could 
deadlock. In the new code, we still need that call to 
hrtimer_try_to_cancel() to detect the possible deadlock.

I'm not confident that we can set up the hrtimer with new values while 
it is in this half-canceled state, can we?


>
>> +		if (hrtimer_try_to_cancel(&vtimer->timer) == -1) {
>> +			scoped_guard(spinlock_irqsave, &vtimer->interval_lock)
>> +				vtimer->interval = 0;
> Does this interval_lock serve some actual purpose? Looks like it's just
> protecting a single variable, and there are no read-modify-writes
> happening to it that I can see.

Setting vtimer->interval to zero will signal any non-canceled timer to 
cancel itself immediately. [1]  Either hrtimer_try_to_cancel() is 
successful or the next run of the timer function will cacnel itself.  We 
do this because we cannot cancel the timer directl with hrtimer_cancel() 
due to the possible deadlock.

[1] 
https://elixir.bootlin.com/linux/v7.3/source/drivers/gpu/drm/drm_vblank.c#L2191

Best regards
Thomas


>
>> +			return -EDEADLK;
>> +		}
>>   	}
>>   
>>   	drm_calc_timestamping_constants(crtc, &crtc->mode);
>> -- 
>> 2.56.0

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


