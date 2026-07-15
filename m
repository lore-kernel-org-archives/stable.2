Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB973D5C31
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784158483; cv=none; b=HZMRDQZOFZeEkj+01i1InZBzbJOc9f3zMZAqDoe3ZZjp6SYR7+7ptAx6f5TvimjwUsC0YrEuJdojS/weiMBvk8h8AChrR3+1HhWZcLaBqlepuZHHVeyTXw18b4Nqwy2irlvQe7lgMbznW3oCcWkuVALQ+dZty/VpzfaO54OI7DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784158483; c=relaxed/simple;
	bh=5uBH49bF0l8b+rZr56Du2J22HfwNH0JL70frA6uBY1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxZW7ScLyn/8SFmguxmYcCzZFfGuRzeuPaKg5qDa08bySNaiXZr/5K4kfUw4GoO51MsdirDbPmujjusufrk5AisIa94eB/tTmALvrmu8Si+13OMEgx66O40nmnMBRDhJMRE98ruz/dWJEQ97Eqxd5RqinmnmceZm346tjzzlwwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h1Z0DR0O; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h1Z0DR0O"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2caf228a910so46359775ad.2
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 16:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784158481; x=1784763281;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GXieirGK731dKnqo4Q/8RQmfvuOGtB9/de8gOedyZqE=;
        b=DuzJHycoq4q2NjMiHUge3a2PPQOv2SFKo6o2Pt0vzh5JCVPX/xiPegdyMGGDt7XU6i
         L7Yopuud+kVxU4JhP0BiLZG9C6hy7M0DeGXJAFx0Bc+Xtfedkk5CyViIHor5jF69qlKj
         rRtlz93GwUxJhID57xt4CmfqrbPq4I/1RVfysTb91uwQ7gSNorXtf2N9By0arbMgimae
         5VyPdJgnxOh9lDUJJApge9uuOtWW2pRRuaRkEvfTn4IXijioKdGNxt6RrUU2N2ZzgLNL
         jevK2jvxw4s0I1x4aaq+xHmvIcaIJ7B2yQQgIV/6MQlb8fh7IHlJXutTPFfZrixLMjg6
         Cu3w==
X-Forwarded-Encrypted: i=1; AHgh+RpS2JWWe75/NwMkCs+angjeQNnHmZKP/+fR9CeN3OqFw9wfDAZ3tRJpWbRyrxB8ojcDzxHwicc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNBXvL5fZtDMWewTgUUkRhgshsANWhFsjORHXOk4UPD8yDbogb
	c955+GX2D5KW3WTEskIi5rJ7fJJPe/4difsQu7BkdwpRuYEo90+cthy3HILE51IDYwanK1o7H6z
	QIEjcuaJ8QaOaGqa22fuqwNEax4a5mCwF9vokkPZLPs85yBG2pPzB9qBXsukC6cJjch01ihMdHN
	OGFrb6tFMcKpyHhgUXMNfR5Df2vkDsjggDFpkEZvIShZlnZS8WA7CDJ2x3Kx4+fYFtKPVvZ2r+M
	3zEDa3xQrIhgn4z
X-Gm-Gg: AfdE7ckuKKZOeJpAG7apEoxuzldWWDwqmOPlj3WwdLqvrO3LuMfJkILCi5t+A7WRrIW
	KD8h9g33ycdJqG3SVPe7zUtDLNzEAD7Ik6cz0dtImN9MxJwlyO/P3j8cdiCqHECOwNiY2VERAQD
	bhMgoQ/L1KRZifeMoy71LGPCya6dHVD+L2ZHjXTOofzwdhxPBp4viirNV+WvutDMtiBDRHyGlg+
	HAhrS63Ol15GrNoqEyZxWrHM/2YsEXOaDyclWD1HnovYa3vgzwsc0cC8wHG+GmXgVHY18rMKqOX
	Kmu/iuJFDtMKU+cxzuaPIiOxOqheV8/FV9gd+SnjwmuNw+qmNOnZZeob69Zi3FGirO+UYTRp540
	qOvsPcgYExm89y3PnR9Ng+tMHshV/9jd7jwnph2vl/4mmaxv2BE/GQ+ymdOdHBZyjEl50tYKWku
	4zbLWRg6tM04R/PgVJB0Y/jtnMZKZ4innRmqinRg==
X-Received: by 2002:a17:902:f548:b0:2c9:97a7:3278 with SMTP id d9443c01a7336-2cf03d55d5emr40135165ad.41.1784158480771;
        Wed, 15 Jul 2026 16:34:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2cf0fff65a8sm1857785ad.1.2026.07.15.16.34.40
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2026 16:34:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1d137a68so134873161cf.3
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 16:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784158479; x=1784763279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GXieirGK731dKnqo4Q/8RQmfvuOGtB9/de8gOedyZqE=;
        b=h1Z0DR0OQlKRxN3552qD2hkYLY6b6TFqt6gxyfyJwYxnwdDkSGlwF5hIzgXRnG6pZY
         Bdp43atrdpYMjV//f3XPt4Un6Q5MRCxNTMwC0pWnOQvl0MYmO0ast6hFWwOKWgwdOm8k
         zNNC4bxuSfQXv2rtzcbbNC0iLEvhDFJFi+68U=
X-Forwarded-Encrypted: i=1; AHgh+RqEcR27SjOnWfc7POxOp3qRZ+n/P8sq+54Ti3l713DoMInlMgPsIfQSKWggHyrO/MfTRUf3Xas=@vger.kernel.org
X-Received: by 2002:ac8:5d50:0:b0:51c:bc76:dae0 with SMTP id d75a77b69052e-51e4f0bb49dmr50595711cf.57.1784158479429;
        Wed, 15 Jul 2026 16:34:39 -0700 (PDT)
X-Received: by 2002:ac8:5d50:0:b0:51c:bc76:dae0 with SMTP id d75a77b69052e-51e4f0bb49dmr50595521cf.57.1784158478967;
        Wed, 15 Jul 2026 16:34:38 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-904116650b7sm183978416d6.8.2026.07.15.16.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 16:34:38 -0700 (PDT)
Message-ID: <2df4713f-bf61-40de-a43f-5079e3b5d5fa@broadcom.com>
Date: Wed, 15 Jul 2026 16:39:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vmwgfx: uninstall the IRQ before freeing the command
 buffer manager on unload
To: Fan Wu <fanwu01@zju.edu.cn>, Zack Rusin <zack.rusin@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260714094511.2960308-1-fanwu01@zju.edu.cn>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20260714094511.2960308-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 7/14/26 2:45 AM, Fan Wu wrote:
> vmw_driver_unload() frees the command buffer manager before uninstalling
> the device IRQ. vmw_release_device_late() -> vmw_cmdbuf_man_destroy()
> frees the manager, while the threaded handler vmw_thread_fn(), released
> only later by vmw_irq_uninstall() -> free_irq(), dereferences
> dev_priv->cman without a NULL guard and is the sole producer of
> schedule_work(&man->work), whose worker vmw_cmdbuf_work_func() recovers
> the manager via container_of(). dev_priv->cman is never NULLed on the
> unload path, so a handler woken in the window between kfree(man) and
> free_irq() runs against freed memory and can re-arm man->work after the
> manager's cancel_work_sync() has already returned.
> 
> Reorder the unload path to drain pending fences, then uninstall the IRQ,
> and only then free the manager: free_irq() guarantees the threaded
> handler has exited before kfree(man). vmw_fence_fifo_down() is called
> explicitly before the IRQ uninstall so its dma_fence waits are signalled
> by the still-live threaded handler (vmw_fences_update() in
> vmw_thread_fn()); uninstalling the IRQ first could force pending fence
> waits to time out at VMW_FENCE_WAIT_TIMEOUT. vmw_release_device_late()
> is left unchanged because it is shared with the hibernation path; its
> existing call to vmw_fence_fifo_down() runs against an empty fence list
> after the explicit drain above.
> 
> Fixes: ef369904aaf7 ("drm/vmwgfx: Move irq bottom half processing to threads")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> index 599052d07ae88af2f5775f968fe1e7046a3efe4e..dbe02fe8d8571587733d6f002436bf18dac1887a 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -1181,10 +1181,11 @@
>  	vmw_devcaps_destroy(dev_priv);
>  	vmw_vram_manager_fini(dev_priv);
>  	ttm_device_fini(&dev_priv->bdev);
> -	vmw_release_device_late(dev_priv);
> -	vmw_fence_manager_takedown(dev_priv->fman);
> +	vmw_fence_fifo_down(dev_priv->fman);
>  	if (dev_priv->capabilities & SVGA_CAP_IRQMASK)
>  		vmw_irq_uninstall(&dev_priv->drm);
> +	vmw_release_device_late(dev_priv);
> +	vmw_fence_manager_takedown(dev_priv->fman);
> 
>  	ttm_object_device_release(&dev_priv->tdev);
> 
> --
> 2.39.5
> 

With this patch we would miss any command buffer processing done on the svga
device in the window between irq_uninstall and vmw_cmdbuf_man_destroy(), so it's
better to leave the takedown order as is.
If you want to address the case where a thread_fn awoken by an earlier irq is
scheduled before irq_uinstall but after vmw_cmdbuf_man_destroy(), then just add checks
to vmw_thread_fn(), though I'm not sure if that case is even possible since the
command buffer contexts should already be taken down at that point.


-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
