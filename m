Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E337187E;
	Fri, 18 Sep 2026 06:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713695; cv=none; b=pt7G6myc9xbNCbyF0Kmw+u/MT7brrYpoRzBZkCAsMJnxfZO1+qOOClKBoDdoNbuC4+3uJYN5nHMb32/4/72Pk1A73Vzc7GyFe4wcGh0zQvJV5leChyfFYtQh4N+2N/q7+XnL8fu78uvmBDkB/KodH1DaUEl1LJis1Dzzn9d9V2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713695; c=relaxed/simple;
	bh=kjeuaa3Q+fHs5mn9hD+3EAR+inif7PQgQP1pmTU0wtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9qvnGh/MspOAZBdWxD1Fwxb2ksWzMBo0CIU39l3KkDONh0Vo/eF0lU0AHG6xiJRlP7YXXrdm9GzklnWh3mbJcIJKSdBWsZBSRWTOyOBd4VvsLGlObGY9g21sEhu+Fzoernj/gJ38Ocyz0ItITPEzJoE+itFtc+7hgZ6Joopz2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S9MeC+28; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DBgrYLub; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cxZDoLDw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+33nvk6y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S9MeC+28";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DBgrYLub";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cxZDoLDw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+33nvk6y"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB91920076;
	Fri, 18 Sep 2026 06:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789713685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=E4aMe0GJ96p6HPIq399xjyNj4CpzMJPBPTO2ADDjNbo=;
	b=S9MeC+28J642e2hRaCqLspYlC91Tk1XfdjcPqYddWoD52hLGjI8GJbuZPHd5DdzU4jVEEs
	t7PMOVrM+EI+SxUKy45yApTJ4K9oOInusDa8ZUat/hSG0Uwy6jO6aApLXyFEQDu6KiBOWL
	8t+A2H8m0NI7pJQMH/JbFO6S+MV5gM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789713685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=E4aMe0GJ96p6HPIq399xjyNj4CpzMJPBPTO2ADDjNbo=;
	b=DBgrYLubd32wZoAB6Bdm+SKli1u1bj8JBOr2hyzw71eVQcP15cfUPB/XYVJIeVOW6TuK3j
	3qQaZvLSIbKjd4Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789713681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=E4aMe0GJ96p6HPIq399xjyNj4CpzMJPBPTO2ADDjNbo=;
	b=cxZDoLDwchEjBFUNYtKPAnU5SWzNt7WIbwebJcji4hLjbsHF9KED6esvARIrYBMh+BlvbL
	asaK7K9Ih2cBX5aW2QxaDJqgSTBFnIu9hWxHq/L604imvO8Iyzd9m/+bewiA/zgwICukqa
	Fzr/pOz9efN3H9CclpG9MTK5uA/oB74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789713681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=E4aMe0GJ96p6HPIq399xjyNj4CpzMJPBPTO2ADDjNbo=;
	b=+33nvk6yqW+ekNFMWmbW8VQrIspkGhLOMOphm17lfacABCQXbl6hE0of2kYsoM6HtsEYmO
	sS2NJTL7I7CrIlAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3590D1348F;
	Fri, 18 Sep 2026 06:41:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CuiXMxDdrGqsfwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 18 Sep 2026 06:41:21 +0000
Message-ID: <f7fa4c4c-bc59-4822-94bb-6e9d68f8f0ca@suse.de>
Date: Fri, 18 Sep 2026 08:41:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v2 1/5] drm: Split framebuffer pixel offset
 calculation from drm_fb_dma_get_gem_addr()
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Liu Ying <victor.liu@nxp.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-sunxi@lists.linux.dev,
 imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260916033327.3054126-1-wenst@chromium.org>
 <20260916033327.3054126-2-wenst@chromium.org>
 <f6ace486-70d8-4e81-89cb-e9d55ad9ac8b@suse.de>
 <CAGXv+5ErgWVNtnRiW+QA7+Mzh=W_Y+HGL_iRa1fOaXCYSoAwMA@mail.gmail.com>
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
In-Reply-To: <CAGXv+5ErgWVNtnRiW+QA7+Mzh=W_Y+HGL_iRa1fOaXCYSoAwMA@mail.gmail.com>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,oss.nxp.com,pengutronix.de,kernel.org,sholland.org,linux.intel.com,gmail.com,ffwll.ch,lists.linux.dev,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.com:url,imap1.dmz-prg2.suse.org:helo]

Hi

Am 18.09.26 um 06:16 schrieb Chen-Yu Tsai:
> On Thu, Sep 17, 2026 at 11:20 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Hi
>>
>> Am 16.09.26 um 05:33 schrieb Chen-Yu Tsai:
>>> Currently drm_fb_dma_get_gem_addr() calculates the offset into the
>>> framebuffer memory for the framebuffer's unclipped source coordinates,
>>> adds that to the framebuffer's backing storage, and returns the result.
>>>
>>> We are about to add a variant that uses the clipped source coordinates,
>>> so there is already some reuse of code. However, calculating the data
>>> offset for a given pixel is not specific to the DMA FB helpers. The
>>> offset is only related to the framebuffer.
>>>
>>> Split out the offset calculation into a new framebuffer helper so that
>>> non-DMA users can also reuse the same code.
>>>
>>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Cc: <stable@vger.kernel.org> # dependency for next patch
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>> ---
>>> Changes since v1:
>>> - New patch
>>> ---
>>>    drivers/gpu/drm/drm_fb_dma_helper.c | 28 ++----------------
>>>    drivers/gpu/drm/drm_framebuffer.c   | 45 +++++++++++++++++++++++++++++
>>>    include/drm/drm_framebuffer.h       |  3 ++
>>>    3 files changed, 51 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_fb_dma_helper.c
>>> index fd71969d2fb1..ab0f37d8a5ff 100644
>>> --- a/drivers/gpu/drm/drm_fb_dma_helper.c
>>> +++ b/drivers/gpu/drm/drm_fb_dma_helper.c
>>> @@ -75,36 +75,14 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
>>>                                   unsigned int plane)
>>>    {
>>>        struct drm_gem_dma_object *obj;
>>> -     dma_addr_t dma_addr;
>>> -     u8 h_div = 1, v_div = 1;
>>> -     u32 block_w = drm_format_info_block_width(fb->format, plane);
>>> -     u32 block_h = drm_format_info_block_height(fb->format, plane);
>>> -     u32 block_size = fb->format->char_per_block[plane];
>>> -     u32 sample_x;
>>> -     u32 sample_y;
>>> -     u32 block_start_y;
>>> -     u32 num_hblocks;
>>>
>>>        obj = drm_fb_dma_get_gem_obj(fb, plane);
>>>        if (!obj)
>>>                return 0;
>>>
>>> -     dma_addr = obj->dma_addr + fb->offsets[plane];
>>> -
>>> -     if (plane > 0) {
>>> -             h_div = fb->format->hsub;
>>> -             v_div = fb->format->vsub;
>>> -     }
>>> -
>>> -     sample_x = (state->src_x >> 16) / h_div;
>>> -     sample_y = (state->src_y >> 16) / v_div;
>>> -     block_start_y = (sample_y / block_h) * block_h;
>>> -     num_hblocks = sample_x / block_w;
>>> -
>>> -     dma_addr += fb->pitches[plane] * block_start_y;
>>> -     dma_addr += block_size * num_hblocks;
>>> -
>>> -     return dma_addr;
>>> +     return obj->dma_addr + drm_framebuffer_get_block_offset(fb, plane,
>>> +                                                             state->src_x >> 16,
>>> +                                                             state->src_y >> 16);
>>>    }
>>>    EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_addr);
>>>
>>> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
>>> index d32aceb6ca9b..9e1231162047 100644
>>> --- a/drivers/gpu/drm/drm_framebuffer.c
>>> +++ b/drivers/gpu/drm/drm_framebuffer.c
>>> @@ -1208,6 +1208,51 @@ void drm_framebuffer_print_info(struct drm_printer *p, unsigned int indent,
>>>        }
>>>    }
>>>
>>> +/**
>>> + * drm_framebuffer_get_block_offset() - Get offset to start of pixel block for
>>> + * the given framebuffer and coordinates.
>>> + * @fb: The framebuffer
>>> + * @plane: Which plane
>>> + * @x: x coordinate for pixel
>>> + * @y: y coordinate for pixel
>>> + *
>>> + * This function will usually be called from the PLANE callback functions,
>>> + * or from one of the helpers that calculates the framebuffer's DMA address.
>>> + *
>>> + * Return: offset from start of framebuffer to start of pixel block
>>> + */
>>> +u32 drm_framebuffer_get_block_offset(struct drm_framebuffer *fb, unsigned int plane,
>>> +                                  unsigned int x, unsigned int y)
>> Better use u64 as return type.
> To avoid overflow? Not sure who would use crazy large framebuffers, but
> doesn't hurt to play it safe.

I'd be worried about a malicious user space that tries to access OOB.

Apart from that, we use u64 for other framebuffer-related sizes like 
pitch calculations or dma addresses. Using u64 here would keep that 
consistent.


>
>>> +{
>>> +     u8 h_div = 1, v_div = 1;
>>> +     u32 block_w = drm_format_info_block_width(fb->format, plane);
>>> +     u32 block_h = drm_format_info_block_height(fb->format, plane);
>>> +     u32 block_size = fb->format->char_per_block[plane];
>>> +     u32 sample_x;
>>> +     u32 sample_y;
>>> +     u32 block_start_y;
>>> +     u32 num_hblocks;
>>> +     u32 offset;
>>> +
>>> +     offset = fb->offsets[plane];
>>> +
>>> +     if (plane > 0) {
>>> +             h_div = fb->format->hsub;
>>> +             v_div = fb->format->vsub;
>>> +     }
>>> +
>>> +     sample_x = x / h_div;
>>> +     sample_y = y / v_div;
>>> +     block_start_y = (sample_y / block_h) * block_h;
>>> +     num_hblocks = sample_x / block_w;
>>> +
>>> +     offset += fb->pitches[plane] * block_start_y;
>>> +     offset += block_size * num_hblocks;
>> User space controls the values in fb->offsets and fb->pitches.  I'm not
>> sure how well they have been validated already at this point. Did you
>> investigate this?
> It wouldn't be worse than before, since this changes is purely code movement.
>
> There are minimal sanity checks done by drm_internal_framebuffer_create()
> in framebuffer_check(), such as offset overflow or pitch size too small,
> but that's about it. It would be up to individual drivers to perform more
> checks that match their hardware limitations.

Right, makes sense. Looking through the framebuffer validation, a 
buffer-size check could be done in framebuffer_check().  But that's 
another patch series.


>
> What sort of issues are you thinking about?

Again, I'm thinking of malicious user space that crafts these values to 
force an OOB access.

Best regards
Thomas


>
>
> ChenYu
>
>> Best regards
>> Thomas
>>
>>
>>> +
>>> +     return offset;
>>> +}
>>> +EXPORT_SYMBOL(drm_framebuffer_get_block_offset);
>>> +
>>>    #ifdef CONFIG_DEBUG_FS
>>>    static int drm_framebuffer_info(struct seq_file *m, void *data)
>>>    {
>>> diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuffer.h
>>> index 38b24fc8978d..c07aea1cc59f 100644
>>> --- a/include/drm/drm_framebuffer.h
>>> +++ b/include/drm/drm_framebuffer.h
>>> @@ -220,6 +220,9 @@ void drm_framebuffer_remove(struct drm_framebuffer *fb);
>>>    void drm_framebuffer_cleanup(struct drm_framebuffer *fb);
>>>    void drm_framebuffer_unregister_private(struct drm_framebuffer *fb);
>>>
>>> +u32 drm_framebuffer_get_block_offset(struct drm_framebuffer *fb, unsigned int plane,
>>> +                                  unsigned int x, unsigned int y);
>>> +
>>>    /**
>>>     * drm_framebuffer_get - acquire a framebuffer reference
>>>     * @fb: DRM framebuffer
>> --
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>> GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)
>>
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


