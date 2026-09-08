Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB735013A3;
	Tue,  8 Sep 2026 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860529; cv=none; b=VFt4W6SrF9aGzN9P5g8mXv/ydXLBWS7qOrWsdmeeRbpAyyKORo9v2slld9fC/fcX8xOL9CxQ0HknV7fuZvy2phJGDAD9ZH2blg/Kj78k5y+gfaaGZ9qJuv7DM9dFwfw9byLlvTqKxo63p1GWFapJrJ3JTHcdtR0Qj+ycbkZy7po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860529; c=relaxed/simple;
	bh=QfaJJbUig+Vtvdufb+3QBQtvUcq3o2KuI3k7hgHZmfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMT+IfMKwvupEW/OPHsAApbFL2TMR8piFpxHHQWNFb0+uBNWCB9nbGiwgfjYMsX31hqeB1wfJTP38hJ197J3TCee5TfqXfomJ0XtwBNbBXnlge0boBUza/YoeQcJD4F+9Ic4NJTsGFX4r3gJAMBvPRwv/+7UR2V+h+8UwP2Tcns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jx4ZFGVv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S1DEt1Ez; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i+MfMNfL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YL1YhHWR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jx4ZFGVv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S1DEt1Ez";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i+MfMNfL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YL1YhHWR"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7906A219CF;
	Tue,  8 Sep 2026 09:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788860521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=knOVHim3X4XNp/FSUMqy2ub0CSiLA2rjajB+xRZ1zo8=;
	b=jx4ZFGVv/81HUV6b3rbSvVTDyyxWDbrdU4Xanw4lf/d4ErBEyfFRgxdjxg8DRNJSu1Yo9F
	AHr8OrX2rlVfXqBz0Wy5bTW2Gs8dAV5YsaID7pF1W5JdYPfXeBgQS+YGsxgcpGeOz+11jR
	tVut9muBwrwIeFuhcNastBFURvU1X6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788860521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=knOVHim3X4XNp/FSUMqy2ub0CSiLA2rjajB+xRZ1zo8=;
	b=S1DEt1EzlTZBUuk0qWQDGNTNdRDNwR7NdqmEmo6CsHA2rfIuNkG7YdO4Y68x2EVEwwOt9+
	BpWwQwSowKP39pCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788860517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=knOVHim3X4XNp/FSUMqy2ub0CSiLA2rjajB+xRZ1zo8=;
	b=i+MfMNfL8rf/C2OQmLat7T5vbTVrbIaChvIMv6/CsT+dwqp89COrDwRjM8juPoWR44jKTJ
	cSuj57/Mdyw4sPRg+0Pa3I26UGMz/RQJ2IJo2j3Qp99cB+5Osys+8XcNzQtpkvAVwMbhMw
	qkgyLE3/OKRGAkKHJGcILvHXjoTvTXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788860517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=knOVHim3X4XNp/FSUMqy2ub0CSiLA2rjajB+xRZ1zo8=;
	b=YL1YhHWRD3ZausxTW246PKckJ82bndPxDQaeIn1HlvHSZuhP3PTi8ZUGDdJkboQIiYno1p
	CAkJa1kxF7B2RHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1E0F1347F;
	Tue,  8 Sep 2026 09:41:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2Ui3NWTYn2p9ZwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 08 Sep 2026 09:41:56 +0000
Message-ID: <d3e13d97-72c4-4a14-8de2-b509ef3e8759@suse.de>
Date: Tue, 8 Sep 2026 11:41:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/fb-dma-helper: Add
 drm_fb_dma_get_gem_clipped_addr()
To: Chen-Yu Tsai <wenst@chromium.org>, Liu Ying <victor.liu@nxp.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-sunxi@lists.linux.dev, imx@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260908090745.1089143-1-wenst@chromium.org>
 <20260908090745.1089143-2-wenst@chromium.org>
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
In-Reply-To: <20260908090745.1089143-2-wenst@chromium.org>
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
	FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,lists.linux.dev,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,chromium.org:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid]

Hi

Am 08.09.26 um 11:07 schrieb Chen-Yu Tsai:
> drm_fb_dma_get_gem_addr() returns the DMA address to the "unclipped"
> framebuffer. However some display drivers want the "clipped" framebuffer
> instead, as they are also using the clipped coordinates to program the
> hardware.
>
> Some of these drivers are open-coding drm_fb_dma_get_gem_addr() with
> the source coordinates replaced, while others have been incorrectly
> converted to using drm_fb_dma_get_gem_addr(), which would end up
> causing incorrect parts of the framebuffer to be displayed if it were
> somehow clipped.
>
> Add drm_fb_dma_get_gem_clipped_addr(), a "clipped" version of
> drm_fb_dma_get_gem_addr() for these drivers to use.
>
> Cc: <stable@vger.kernel.org> # dependency for next patch
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   drivers/gpu/drm/drm_fb_dma_helper.c | 63 +++++++++++++++++++++--------
>   include/drm/drm_fb_dma_helper.h     |  4 ++
>   2 files changed, 51 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_fb_dma_helper.c
> index fd71969d2fb1..a260e7cd5667 100644
> --- a/drivers/gpu/drm/drm_fb_dma_helper.c
> +++ b/drivers/gpu/drm/drm_fb_dma_helper.c
> @@ -59,20 +59,10 @@ struct drm_gem_dma_object *drm_fb_dma_get_gem_obj(struct drm_framebuffer *fb,
>   }
>   EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_obj);
>   
> -/**
> - * drm_fb_dma_get_gem_addr() - Get DMA (bus) address for framebuffer, for pixel
> - * formats where values are grouped in blocks this will get you the beginning of
> - * the block
> - * @fb: The framebuffer
> - * @state: Which state of drm plane
> - * @plane: Which plane
> - * Return the DMA GEM address for given framebuffer.
> - *
> - * This function will usually be called from the PLANE callback functions.
> - */
> -dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
> -				   struct drm_plane_state *state,
> -				   unsigned int plane)
> +static dma_addr_t _drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
> +					   unsigned int plane,
> +					   unsigned int x,
> +					   unsigned int y)
>   {
>   	struct drm_gem_dma_object *obj;
>   	dma_addr_t dma_addr;
> @@ -96,8 +86,8 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
>   		v_div = fb->format->vsub;
>   	}
>   
> -	sample_x = (state->src_x >> 16) / h_div;
> -	sample_y = (state->src_y >> 16) / v_div;
> +	sample_x = x / h_div;
> +	sample_y = y / v_div;
>   	block_start_y = (sample_y / block_h) * block_h;
>   	num_hblocks = sample_x / block_w;

The current code already mixes up responsibilities of the involved 
modules. It's a good opportunity to improve that. I think there should 
be a block-offset helper for the framebuffer. That function will return 
the byte offset of a pixel's block from the beginning of the framebuffer 
plane.

/* in drm_framebuffer.{c,h} */
u32 drm_framebuffer_get_block_offset(struct drm_framebuffer *fb, plane, 
x, y)
{
     /* here goes the current offset calculation from the gem-dma code */
}

In the GEM-DMA code, you can then write your helpers like this

drm_fb_dma_get_gem_addr(...)
{
     obj = drm_fb_dma_get_gem_ob(fb)

     offset = drm_framebuffer_get_block_offset(obj->base, state->src_x, 
state->src_y)

     dma_addr = obj->dma_addr + offset;

     return dma_addr
}

_get_clipped_gem_addr()
{
     /* likewise */
}

This better structures the responsibility. It also works for other GEM 
code besides GEM-DMA.

Best regards
Thomas


>   
> @@ -106,8 +96,49 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
>   
>   	return dma_addr;
>   }
> +
> +/**
> + * drm_fb_dma_get_gem_addr() - Get DMA (bus) address for unclipped framebuffer,
> + * for pixel formats where values are grouped in blocks this will get you the
> + * beginning of the block
> + * @fb: The framebuffer
> + * @state: Which state of drm plane
> + * @plane: Which plane
> + *
> + * This function will usually be called from the PLANE callback functions.
> + *
> + * Return: GEM DMA address for given framebuffer, unclipped.
> + */
> +dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
> +				   struct drm_plane_state *state,
> +				   unsigned int plane)
> +{
> +	return _drm_fb_dma_get_gem_addr(fb, plane, state->src_x >> 16,
> +					state->src_y >> 16);
> +}
>   EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_addr);
>   
> +/**
> + * drm_fb_dma_get_gem_clipped_addr() - Get DMA (bus) address for clipped
> + * framebuffer, for pixel formats where values are grouped in blocks this
> + * will get you the beginning of the block
> + * @fb: The framebuffer
> + * @state: Which state of drm plane
> + * @plane: Which plane
> + *
> + * This function will usually be called from the PLANE callback functions.
> + *
> + * Return: GEM DMA address for given framebuffer, clipped.
> + */
> +dma_addr_t drm_fb_dma_get_gem_clipped_addr(struct drm_framebuffer *fb,
> +					   struct drm_plane_state *state,
> +					   unsigned int plane)
> +{
> +	return _drm_fb_dma_get_gem_addr(fb, plane, state->src.x1 >> 16,
> +					state->src.y1 >> 16);
> +}
> +EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_clipped_addr);
> +
>   /**
>    * drm_fb_dma_sync_non_coherent - Sync GEM object to non-coherent backing
>    *	memory
> diff --git a/include/drm/drm_fb_dma_helper.h b/include/drm/drm_fb_dma_helper.h
> index c950732c6d36..b2a0bd7ef9d0 100644
> --- a/include/drm/drm_fb_dma_helper.h
> +++ b/include/drm/drm_fb_dma_helper.h
> @@ -17,6 +17,10 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
>   				   struct drm_plane_state *state,
>   				   unsigned int plane);
>   
> +dma_addr_t drm_fb_dma_get_gem_clipped_addr(struct drm_framebuffer *fb,
> +					   struct drm_plane_state *state,
> +					   unsigned int plane);
> +
>   void drm_fb_dma_sync_non_coherent(struct drm_device *drm,
>   				  struct drm_plane_state *old_state,
>   				  struct drm_plane_state *state);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


