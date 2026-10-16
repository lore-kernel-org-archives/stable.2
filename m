Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481633DD537
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792184991; cv=none; b=bqoQQ7y5/v5p98BOkcxDy1q6WVd+haon7bPAVS7Lb2n1MnGHzPdVxEzG6iMZFPyS9YiGUndrWabJi62hD5dVLTIxz9oNkklpjk92p1U8KHCu47LX+jXqR+EMWRmB/gQ9l9YDUk2WPZSODxs7u2U90x9eyD006MkddWLJ1r1C9FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792184991; c=relaxed/simple;
	bh=T866gN9ytWDgY0fuxIWfToDyoTMPhkGUWXJZyhl3M4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9cKI6PG/DPwMwjPjOyArhzfyq0KISzJS7e15iy5FgmjuwExjWHESkZ86zef1ysfJ+auuuqMoEakoId/eIQzmrIH6O2EmIQYYe3k4/GZGG+/htEOXevWBo28ZK1pnCSnH6BKYBDvW37TcgP+I6E9YV1GucDlLRK7vk9dGFGK7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZvPrumE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFqg+G5x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZvPrumE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFqg+G5x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792184989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0qksnsO83V4fm5WG/41JKqf/QyvNW2rkxwNDprb2Xo=;
	b=XZvPrumE3vmsQGETj9rX36O/HpZZmCdspSawxHN/kZJ4RMNdaEfqCrJhrdf4XOakzMMqu+
	XAPFRuIkfCtIr+cO/Y5inTkvtPqSwGXSszij5mYigEjzjZxeyGOtftwVVaYE8GqoF35iMu
	m+HikPdn0QD4AJj25TU2OZGlQwyB7ZQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-3C_cWdxYM8mutAjE3Oj0UA-1; Fri, 16 Oct 2026 21:09:47 +0000
X-MC-Unique: 3C_cWdxYM8mutAjE3Oj0UA-1
X-Mimecast-MFC-AGG-ID: 3C_cWdxYM8mutAjE3Oj0UA_1792184986
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso2515875e9.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 14:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792184986; x=1792789786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h0qksnsO83V4fm5WG/41JKqf/QyvNW2rkxwNDprb2Xo=;
        b=HFqg+G5xxxsoqSsmQ8R2QLuvkg/PYeqtHAhJlwARpEO0fWF8WwKMsw1O8Yq+5HnQfj
         LMEnrP9PgIBiedtXtR8u9Xib7UIoCJDrmNGreklUsnpiBPc5yatGjX8hKZUJvsg0NwAY
         qkp/DUuKK0DZmTxuEZVR9xCRHsnRCXOOeCokmJTlZHl7rdTKVhbfi/o9Q4kQ9gvO0ODG
         dxmCzNUXPlsx4ksTdxo/kHG0O8BBfLr+OXLMnmoXMbblFdCLP+7hy8kShwrNnwHVUKgc
         yixcnIQp+2+W1xXlWrVRFycHRzp2AicaPgaVGON2+qj2Lr5/LLaaFbPLW18tW+Ev7kcy
         Pdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792184986; x=1792789786;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h0qksnsO83V4fm5WG/41JKqf/QyvNW2rkxwNDprb2Xo=;
        b=dcwi0f5nBdk/Fb3Ic/RTTn4TQOFCkozf3d2h6DYm/RZan12Vu69HXsghOYH7hz0qm9
         /jsOfS0ibmFvf/tpkmrhNWwtHsvm/WngbLmQ/imVIN2PL8C9Jf+wkQ6AVi6j+OvfWZQC
         USffjEhTDTc+KTUEMsbBdHcURS5AFeFp43Qrc//buj1wpulJVwV7rSbrWD/twdzUJKqN
         3COlOOb5io9VC0/7VVfubCksP6lbgfhncs0z25whHxoqVinXut+dle8rhjZwubBEvCJt
         OOKLER+l5/MQvEkU8zqNtnQQ9mDJidxHFxCHd4xy8C7oqFufOiv+b/URkTyeNBfxD0ae
         JZxg==
X-Forwarded-Encrypted: i=1; AKwUvBymMuHn30zrgTrpSC00zZ30W4KiuWvsu9PZ+mK/uuzaMifcY6onizxpAvY6+QTTRdyDBvY6mao=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOrfsLaot67M4orRhwskFo9apOHNEiO4zF28VMK7alBtVLINVz
	9ZI150I0fRFxTil52eIaDl77MCpOrdzV3+1YEcFayeq/lMy/82UW6ey+eY6RED3uVmA/KObTOq0
	se+1F78vHsQlEh9D9w5DltBro21nEpr5kMGspI8LPp36+GRpwn4H3kZjNXg==
X-Gm-Gg: AYBFou1ugVzNNgCoikq2a2uLR0zEBqu4Fi/Z4QGr8jltWPBJHk1Fr0MSuk1ehhhLqtR
	YEBIbgP5g/WcaMG11IgpEmdqvr5HMJzU8Aldr8KZ4T3kFqg9TyOe7iT6dzPwQcYAaxN3nAxuf27
	pMe4XY1DkTWr+evJw19ZyU3EbH/0Y+F77VsFmKPKGi1bH3IclLYyKhK+Dkcpsm/S+SmwZAS2XYT
	GqCveReqIqUCR+SIpVx/9uUrPrt0fVxoJbg8bfr647db1KTYfgxXBN6Czc5voMGEbzLoKTs3EM3
	ED4vD9DBg07OFWUGtDkfTfI0LB4fEBy8PdWs9Ff8me4BYqfxWbcBj6iJzcmvR35DxFORRDO+xnd
	w6ieZEMbgA+x7lZBXrB91dgmlJKfkBIWZxlQIILqAxUW16ZQ=
X-Received: by 2002:a05:600c:6217:b0:49e:7c8c:361d with SMTP id 5b1f17b1804b1-4a1d7600654mr22701045e9.22.1792184986453;
        Fri, 16 Oct 2026 14:09:46 -0700 (PDT)
X-Received: by 2002:a05:600c:6217:b0:49e:7c8c:361d with SMTP id 5b1f17b1804b1-4a1d7600654mr22700745e9.22.1792184986118;
        Fri, 16 Oct 2026 14:09:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9? ([2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cca26dc8sm57458935e9.3.2026.10.16.14.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 14:09:43 -0700 (PDT)
Message-ID: <8e525023-dc47-416e-a3fe-c5e6c5660ca5@redhat.com>
Date: Fri, 16 Oct 2026 23:09:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/panic: Fix kmsg screen hang on a long log line
To: Devin Wittmayer <lucid_duck@justthetip.ca>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 luyuantao <luyuantao01@163.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261016052722.60051-1-lucid_duck@justthetip.ca>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20261016052722.60051-1-lucid_duck@justthetip.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/26 07:27, Devin Wittmayer wrote:
> The kmsg panic screen reads the log back one chunk at a time. A record
> that does not fit in a chunk comes back empty without moving on, so the
> screen asks for it again forever and the panic never finishes. Every
> oops logs the list of loaded modules, and on my machine that list does
> not fit.
> 
> Read into a buffer the size printk formats one record into, and stop if
> a read still comes back empty.

Thanks for investigating this issue.
That looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

I'm sorry, I probably forgot to push [1], so I will push both patches 
next week if no other comments.

[1] https://lore.kernel.org/all/20260126100732.365-1-luyuantao01@163.com/

Best regards,

-- 

Jocelyn
> 
> Fixes: 54034bebb22f ("drm/panic: Add a kmsg panic screen")
> Cc: stable@vger.kernel.org
> Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
> ---
> I usually work on Wi-Fi drivers, so this is new ground for me. While I
> was testing a fix for a Wi-Fi driver crash, my test machine froze after
> the crash where it should have rebooted, and stayed that way until I
> power cycled it. Working out why led me here.
> 
> To reproduce, with the kmsg screen and panic=10 on a display driver with
> panic support, as root:
> 
>    printf "%600s\n" "" | tr ' ' x > /dev/kmsg
>    echo c > /proc/sysrq-trigger
> 
> Before this patch the panic never gets to its reboot.
> 
> QEMU, 10 runs each, on drm-misc-fixes and drm-misc-next (bochs) and
> 6.12.113 (simpledrm):
> 
>                                       before    after
>    one 600 char line                  hangs     reboots
>    same, then 400 short lines         hangs     reboots
>    one record of 300 short lines      hangs     reboots
>    oops with 24 modules loaded        hangs     reboots
>    plain panic                        reboots   reboots
> 
> amdgpu, 2 runs each, Arch's source and config, before and after:
> 
>    6.18.52, the two commands above    hangs     reboots
>    6.18.52, one record of 300 lines   hangs     reboots
>    6.18.52, oops                      hangs     reboots
>    7.2.6, kmsg screen set, oops       hangs     reboots
> 
> luyuantao's patch [1] stops reading once the screen is full, so it only
> helps the second row. With both on drm-misc-fixes, every row reboots.
> 
> The buffer is shared, like the QR code buffers; a panic only draws from
> one CPU. In drm-misc-next this code is in drm_panic_helper.c, where the
> same change was tested.
> 
> [1] https://lore.kernel.org/all/20260126100732.365-1-luyuantao01@163.com/
> 
>   drivers/gpu/drm/drm_panic.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index e576c4791861d..29b1487de7ae0 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -556,7 +556,8 @@ static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
>   	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
>   	struct drm_rect r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
>   	struct kmsg_dump_iter iter;
> -	char kmsg_buf[512];
> +	/* the size printk formats one record into, too big for the stack */
> +	static char kmsg_buf[2048];
>   	size_t kmsg_len;
>   	struct drm_panic_line line;
>   	int yoffset;
> @@ -574,6 +575,10 @@ static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
>   		char *start;
>   		char *end;
>   
> +		/* a record that does not fit comes back empty, every time */
> +		if (!kmsg_len)
> +			break;
> +
>   		/* ignore terminating NUL and newline */
>   		start = kmsg_buf + kmsg_len - 2;
>   		end = kmsg_buf + kmsg_len - 1;
> 
> base-commit: 324fac81f365fc123247f9c8a52cb66ebd93b5e5

