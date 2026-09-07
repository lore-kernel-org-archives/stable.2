Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D29540BCBB
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814867; cv=none; b=i1ehZn1bU6REN+hv5AKooUtfAi0qGju3HpEXwA+dGvM/I4Yj+rQU4mcXqKBhEp2KSwp6IoJzrOhbeDmwekphbmn4BouTiK3n/rjnRCkrgzHUBe2bT9Vr2CL7aRZgdte2jle8cyQBazF2dKgDPY1fjROHvXfvTh2dVxQhEkWOk3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814867; c=relaxed/simple;
	bh=Pfp4fHaGp3DYNoQNsq++Hih2POFfdEHNA9k/g4/DYlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cY8b05PHAUANfUQADwetj5NY9ZCoZiVcLyRscPiL9KW0eVrqRw1j18TBHhPsSDGBe8KVlS2FCUx6nJJJQ2KqwC49Uw8yuEd77pUi2UCUnn6eW0fQRvcsWM3L264rkywTUFsU+uELehDHfn8BpU19TRjl5iLT8kQI5MTuxxq3qTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4srLzoR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eFb3gEgc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4srLzoR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFb3gEgc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788814864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=km54XNA3pesnlH9MUSOEbKUzj91GMmwN/4bvXZLN1Qw=;
	b=E4srLzoRT2lSFcaQysiCLk/7gYWQXXHBWble0pc3yRK0BKbcUWXlkkenZdQBdblXltv429
	aq23hN2ImYmLgJhVNpUkK9ErT/FV8Sa0bc3WYo3Bf/cgSD4jChuPK5MW4huzJs8Xh8G3m2
	v2U/A6AYyGRGC393cggcW25+9qGapb4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-0L_Q23CBM1epNkDaou_gPg-1; Mon, 07 Sep 2026 17:01:02 -0400
X-MC-Unique: 0L_Q23CBM1epNkDaou_gPg-1
X-Mimecast-MFC-AGG-ID: 0L_Q23CBM1epNkDaou_gPg_1788814862
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-485866e0066so2130386f8f.2
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 14:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788814862; x=1789419662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=km54XNA3pesnlH9MUSOEbKUzj91GMmwN/4bvXZLN1Qw=;
        b=eFb3gEgcK3PB9MrfTHHThNcTr92004RvKuJ7uQwqQ3zoZ7OpJ1R7BPd8FvfmFxrl1h
         nExdIw/Pf64APOUElzXVszf8Z/bLMrjDYGro+gxFk3eIKe+kvhj2IB8lSL2BlD+ZIQW/
         sdkg+IjrmSSiahvTjLw32xG2CzD+GoXUxS2jj41mqgvtOOhUOA3AezChvYwsAcck82zI
         R8Qp2eVUoycJOT4nbsMOPyqRJSzwZjPX62S4veWmMlcAj5GMvzgVfhx2lUPn+2YQB2jd
         tEc6d0iHztEydGJgr9YF0mER6V2Nt6x2AB18PD42SQieJO4kg5XA+eKCw5FGTPbEsnwu
         1FIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788814862; x=1789419662;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=km54XNA3pesnlH9MUSOEbKUzj91GMmwN/4bvXZLN1Qw=;
        b=cZeDt6YMMmdIrAQOZjBKFirhjjKV/hZZBKv0Af0kIRRikhufso1jT58xZPNpRxVnde
         q46uLjEeU7Qg9IBZBGQgDHJ+q6fzn4pzXhAef1ZPAbcrER7P8rc5hs+iVHRTRIloZJsz
         7xPsvmRRq8AhQ/BMmOWUagsQqnKnQFwtT6HA9iGPV2aIZE0f+/fJKg4yPXIBl136phlz
         n8ZLZJ4dCasRaJEYYXkMINQT/qFrbQ2HbtojxiqYjl3aeTvnW0OA65fyW+JkeAaILqF3
         FT26SNYJEaOMML+3++f7OPpsKM1cVzzz6+raJBuRjVZKCUtQnvF5TwhMHMKFAjwnMp4O
         I4ag==
X-Forwarded-Encrypted: i=1; AKwUvBx7z/hr6tD4p92l8F2j4uAs+QxV21tKIf3g+NEl5dhfGmKrl/d1LaA5VsBuZELh31owytSmpEI=@vger.kernel.org
X-Gm-Message-State: AFuF++nOy80Wkw9HUrNCiiM4h3cotaYNLUYfhGaxrnZAJKM6TxYHztZ3
	+m6GKnm8XpGgkvruP9+4OMsaROictGQYi7tqcVUZa0GkwLaIm3wXYshSi9hpZsMqPVWD7HjUvcK
	hWen6NwPtDY4+0mgi6UloY8SfE5/cI+d2VGs8W+nWWRfHTVn7UR5EdXNjHA==
X-Gm-Gg: AYBFou0QisQ+MWso1XBwss30g0LY1LaYQ/CPgWwbzPY8zqa/kYZc7yN6O6KXFSt2ac7
	E9U3MzU4mLAvSAj6SiHg6ayB0G7KX0KvEDTqE3EnI2njGt2orPQQ6/eZVTxb91xGtRIvk4Maz9Q
	hIBWJwGY3XCUuz2ObfQaldn1fzXr2h/lQjeotrbe86yo11dlOXhFSdoc9HFH6bxthLg/D/hda0g
	Gn0DqEnY1K1inDpQo+KhDOoPpPa35lNA3Z1S8Cr+YblrQKZmb5UZH9LgoVVzMwyM575pVVRknes
	rdj4maamLfiPee+7sQWp6nFUTSxY4TXv91GMkyv9ew99E3Z9aewAqGE9E9NhGAUDCPYTxRnpF9J
	NDcaLKikAY31o9FHfjrjLHFgWKNjoq4375soUE8Z8Y4hJcfVW
X-Received: by 2002:a05:600d:8649:10b0:49c:fa20:cc0a with SMTP id 5b1f17b1804b1-49cfa20cd58mr167275235e9.33.1788814861734;
        Mon, 07 Sep 2026 14:01:01 -0700 (PDT)
X-Received: by 2002:a05:600d:8649:10b0:49c:fa20:cc0a with SMTP id 5b1f17b1804b1-49cfa20cd58mr167274945e9.33.1788814861409;
        Mon, 07 Sep 2026 14:01:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9? ([2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cefsm458086515e9.5.2026.09.07.14.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 14:01:00 -0700 (PDT)
Message-ID: <b34807ad-6390-4804-ba29-43a407b3d9fb@redhat.com>
Date: Mon, 7 Sep 2026 23:00:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] drm/panic: Do not use un-escaped URL as format
 string
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, geert@linux-m68k.org, rdunlap@infradead.org
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, stable@vger.kernel.org
References: <20260902121930.597222-1-tzimmermann@suse.de>
 <20260902121930.597222-2-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260902121930.597222-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/26 14:13, Thomas Zimmermann wrote:
> Replace the direct use of DRM_PANIC_SCREEN_QR_CODE_URL in snprintf()
> with a %s conversion specifier. Avoids a possible vulnerabilty from
> a crafted URL string.
> 
> As the attacker needs to control the kernel at the Kconfig level, the
> potential for an exploit is likely low.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: cb5164ac43d0 ("drm/panic: Add a QR code panic screen")
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.12+
> ---
>   drivers/gpu/drm/drm_panic.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index e576c4791861..ba21df4be338 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -658,7 +658,8 @@ static int drm_panic_get_qr_code_url(u8 **qr_image)
>   	char *kmsg;
>   	int max_qr_data_size, url_len;
>   
> -	url_len = snprintf(url, sizeof(url), CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL "?a=%s&v=%s&z=",
> +	url_len = snprintf(url, sizeof(url), "%s?a=%s&v=%s&z=",
> +			   CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL,
>   			   utsname()->machine, utsname()->release);
>   
>   	max_qr_data_size = drm_panic_qr_max_data_size(panic_qr_version, url_len);

