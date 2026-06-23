Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8C3C584E
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205018; cv=none; b=prD1zFclMuvTLpqsMQLQwEYhZB7d8miaZXGA9d7XRUSyPJJBMdbHjRx2bvu0+MhLve//L+jGKqHzDrZ0ISVDEZ5z7D2PlLVwwEK73+T4RQtrP3NDKFT71hMeoYJVbGzm3mB1MA2GIsqBlgvNH0aNtji5qlewa8Vc8W4f3zqsiWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205018; c=relaxed/simple;
	bh=QNHtK1HmYLGWut5Lk/dx4QruEmeCpYCTh4Syvg2FqqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHRRFbRlt71beS1zR64eTRvK7IKGyRHfggSi82TmGsL+K3MGzpGcVdo3bolN1GPV8xgaNtYDBKyOpynsYHv6Z/KGKI0NWR9bFZBTq6jmSzXZq1E+lkrZdWyn7+Jr/z+DKTGcjJ2EskTbfppuXwpfjvqNqF8KoFYJ3Wg3mWZDJT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TmjYq+ts; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lsn2SiHQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TmjYq+ts; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lsn2SiHQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TmjYq+ts";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lsn2SiHQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TmjYq+ts";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lsn2SiHQ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2CABD75D4C;
	Tue, 23 Jun 2026 08:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782205008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3RnNK/GtLp3yp0QwhGJnVLwz7l0WW2gZlBt7s+tpRA8=;
	b=TmjYq+tseDuvJkUDRHS2u3LY5GKULsmXtLNv8U1lvVm9gE1EelXBCn7c8tMxRlDTzGNIsN
	fS+OcHetSS86eKfNMqkqoECbfArLYF8WjgpFdzg41i6cziPv5pKp8t56gtJCWNJL5FZD6o
	6pWxvSz0XiK27Ov6kBddPGuSfqC+E78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782205008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3RnNK/GtLp3yp0QwhGJnVLwz7l0WW2gZlBt7s+tpRA8=;
	b=lsn2SiHQlvXURtjNi5fhhPG/M1Tv7glmuVLazcX+NKRUtJ2ODPyMmBRAdkJ/pE/tzxvWiv
	/111/012Kqq44RAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782205008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3RnNK/GtLp3yp0QwhGJnVLwz7l0WW2gZlBt7s+tpRA8=;
	b=TmjYq+tseDuvJkUDRHS2u3LY5GKULsmXtLNv8U1lvVm9gE1EelXBCn7c8tMxRlDTzGNIsN
	fS+OcHetSS86eKfNMqkqoECbfArLYF8WjgpFdzg41i6cziPv5pKp8t56gtJCWNJL5FZD6o
	6pWxvSz0XiK27Ov6kBddPGuSfqC+E78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782205008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3RnNK/GtLp3yp0QwhGJnVLwz7l0WW2gZlBt7s+tpRA8=;
	b=lsn2SiHQlvXURtjNi5fhhPG/M1Tv7glmuVLazcX+NKRUtJ2ODPyMmBRAdkJ/pE/tzxvWiv
	/111/012Kqq44RAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5220779A8;
	Tue, 23 Jun 2026 08:56:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nbXcMU9KOmq0ZgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 23 Jun 2026 08:56:47 +0000
Message-ID: <32644b7a-c09d-4c81-913d-53d2fc2e2950@suse.de>
Date: Tue, 23 Jun 2026 10:56:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] drm/sysfb: simpledrm: Improve stride validation
To: Thierry Reding <treding@nvidia.com>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, rayyan@ansari.sh,
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 stable@vger.kernel.org
References: <20260622132433.722823-1-tzimmermann@suse.de>
 <20260622132433.722823-5-tzimmermann@suse.de> <ajld8iWQ9iLwBen8@orome>
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
In-Reply-To: <ajld8iWQ9iLwBen8@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ansari.sh,lists.freedesktop.org,lists.linux.dev,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,nvidia.com:email,suse.com:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

Hi

Am 22.06.26 um 18:10 schrieb Thierry Reding:
> On Mon, Jun 22, 2026 at 03:19:38PM +0200, Thomas Zimmermann wrote:
>> Validate the computed stride against the maximum value INT_MAX.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Fixes: 7bfa5c7b28d6 ("drm/simpledrm: Compute linestride with drm_format_info_min_pitch()")
>> Cc: <stable@vger.kernel.org> # v6.1+
>> ---
>>   drivers/gpu/drm/sysfb/simpledrm.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
> Ugh... I have a hard time imagining that we'd ever exceed INT_MAX here,
> but I guess better safe than sorry?

Yeah. The idea of these patches is to harden the driver against all kind 
of nonsense the firmware might give it. With patch 1 that limits the 
width to 2^16, I don't think it's possible to exceed a pitch of INT_MAX, 
but let's check anyway.

Best regards
Thomas

>
> Reviewed-by: Thierry Reding <treding@nvidia.com>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


