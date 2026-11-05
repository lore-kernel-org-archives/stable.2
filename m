Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867945;
	b=XF1Ue6OeOvlnrxTTg8/niqN41pYBh9xePQDNFZT0XAdYXRcnRV35zdxGF+s5jkuw57C0
	 oLdXNnYuxno8gmhioiEJ0/oy9GLuQSBwCDlCBBjgts6BAysKHt3ycmMhn1biEXB4+/FKv
	 WvcFtSWa/8giGfDkH6s/gxPfbn5rhjeWBq8sdnb8suNwMhUl0FKuK4x84BqiiFnO8d1sr
	 L85OnJcE9vB38XIlITYFturVaPu7/+9XW4JhVQZORbTOP+f+yUyeJOAMMww37P3ji5ter
	 uGNwkyqZoeVsLpGHJptAAWbUu5+A2EDOnB6JqySWw7/Q71ZMMh1zcg/CLsIP1cOiswQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867945;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Flag:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=aFTLKKrCBQr7xwtyiLvR9C19fUp15M24LSDxM9aDz5Q=;
	b=aP8KiWWPmX4T70lhEIJfjliyigrk1Dx3HND1EE3Ve4crHRzZ9QQ7ER2jFXFj5SPkPfj3
	 200tCe0ZGTfxLG5SDz2X92ebQ9OdLyANQlsiuAHBOBHv19w70ims4g2rVV/71JbFAygEA
	 pWBin2p1fzMD0tgPYHypT+t+vG3dDHovyUH4zzJyDIcrVvJGa/e/4QwR+nlHOtQh/jPgr
	 5MRBfmyifrxBb/D77Xf3X9sTDEcxqhHcZMg2k45gsKRli8bt9iQI6q37J86t+QC6tWlFq
	 OJ7uuFeVbMoajTdcW9bqAk3TtfEZkxp76iTuuaF335aVpZ/irtBC7LW9Xk6037cZxZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=B715daTC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kRKWslKR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=B715daTC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kRKWslKR;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FCA606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15FCA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=B715daTC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kRKWslKR;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=B715daTC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kRKWslKR
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7B7EC21FA0;
	Thu,  5 Nov 2026 08:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793867943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aFTLKKrCBQr7xwtyiLvR9C19fUp15M24LSDxM9aDz5Q=;
	b=B715daTC/9PDTXVRg1IfgslK132QtmSUbVeISO/c9onXPILGqJ5ziVZVW47kt2oTjXdrsv
	T8e7PB+8VBXd89wOst5WpCSH0BYiZjPg6uyN1VgEOi9z9dPCHn4xxrLpZ/0/Vtoz9pHi7Q
	2MAbb5trss2xajXFyEeSK/766jGfqPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793867943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aFTLKKrCBQr7xwtyiLvR9C19fUp15M24LSDxM9aDz5Q=;
	b=kRKWslKRnem7jPVCgX0Al9B20KGnPg291QXKoIYfmhE55SuXDR85nVXtGEOeL4U0iKGU/a
	0/p+b327xQZiiDAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793867943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aFTLKKrCBQr7xwtyiLvR9C19fUp15M24LSDxM9aDz5Q=;
	b=B715daTC/9PDTXVRg1IfgslK132QtmSUbVeISO/c9onXPILGqJ5ziVZVW47kt2oTjXdrsv
	T8e7PB+8VBXd89wOst5WpCSH0BYiZjPg6uyN1VgEOi9z9dPCHn4xxrLpZ/0/Vtoz9pHi7Q
	2MAbb5trss2xajXFyEeSK/766jGfqPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793867943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aFTLKKrCBQr7xwtyiLvR9C19fUp15M24LSDxM9aDz5Q=;
	b=kRKWslKRnem7jPVCgX0Al9B20KGnPg291QXKoIYfmhE55SuXDR85nVXtGEOeL4U0iKGU/a
	0/p+b327xQZiiDAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B377133F6;
	Thu,  5 Nov 2026 08:39:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iPbrL6ZA7Gq2OAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 05 Nov 2026 08:39:02 +0000
Message-ID: <d8e647ec-2637-4c72-a7dc-3f020fd83e05@suse.de>
Date: Thu, 5 Nov 2026 09:39:02 +0100
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
 <auioL8zR9O5u4TCF@intel.com> <4212140f-fa07-4f0c-bd3a-0ae3d88b250c@suse.de>
 <aujFSzHEv5pAfHPf@intel.com> <ec9020b5-28bb-45a5-89d7-e64e804769de@suse.de>
 <auoVxgQ0D1-6QEDD@intel.com>
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
In-Reply-To: <auoVxgQ0D1-6QEDD@intel.com>
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,redhat.com,bootlin.com,lists.freedesktop.org,lists.linux.dev,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29

Hi

Am 03.11.26 um 18:11 schrieb Ville Syrjälä:
> On Tue, Nov 03, 2026 at 04:55:34PM +0100, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 02.11.26 um 18:15 schrieb Ville Syrjälä:
>> [...]
>>> But what I'm thinking is:
>> I've ran a lengthy session to explore various solutions.
>>
>>> - stop with the explicit cancel entirely and just rely on the
>>>     timer cancelling itself
>>> - try to start the timer in vblank_enable(), and if that can somehow
>>>     fail because the timer is still running it should be fine because
>>>     the self cancellation should anyway have been aborted
>> Having an old vblank timer still running while enable_vblank sets up a
>> new one can mess up the hrtimer's internal ordering. It's full of subtle
>> bugs, according to my LLM.
> The hrtimer code looks like it's designed to handle this. It
> first removes the old queued timer and then inserts it back
> with the new expire time. And there's also locks in there.

It does, but TBH I'd rather trust the LLM than myself on this matter. 
IIUC the problem happens if hrtimer_start() inserts with a new interval, 
but a concurrent timer function calls hrtimer_forward() with the old 
interval that it has already read from vtimer->interval. And 
hrtimer_forward() doesn't look overly threadsafe.

But I do have a patch series to address the issues. I just need a bit 
more time to clean it up.

Best regards
Thomas

>
>>
>>> - explicitly wait for the timer to have stoppped in drm_vblank_off()
>>>     to make sure the wrong interval can't leak from one mode to
>>>     another
>> I'll soon send out a series implementing this idea.
>>
>> Best regards
>> Thomas
>>
>> -- 
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>> GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


