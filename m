Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410755;
	b=MsaEt1LprOaSgouJUsgKjCG6tb3wFFHYSBkH7DFARnHIqe1Y9YpEvoyXTnETAUuWIyMq
	 W7Em2Vg02x0luAnAFFiXvKOvn/R8k+mfLc/sigqiWbsXgkj4x4qXI9T8RTzD53NDuM5vq
	 JIkwoPilb1BE4b50UKh2RTYszehhjih6i4iFUm1TapXUX4mek64S8I+xM8S/bpXFLXSwv
	 LcKWSqmNVpppIAbaTMhcSsBc1nWzDaSJ6jx3T+pmCK/IfYN5vjdgKFksXCZoGLW0fRNdU
	 e2f+tN8y5TBmdsA6KRXeoMVnYUB8AAKgTTZRhK5GsLS2mxJ0QEsJL7BmbjvBdCqrO4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=VVuhmpTOxkpymn0weSleRGrGxCwyKmh4kNc2qrZbhPg=;
	b=IcNbYgTtJJsZXMOrCWnr6tHj0T4IRLbiQ4AgxMvJId5bHPdYWABPkMkKqS7Y/10Zv0r3
	 6XQY3ESVhyajmmlhIZK8c9gWQTwyMIyhdW7MyiyKO9+z8xzkCP6erXNWtGeb4bOrKC+Pd
	 KzJrkLgND2blSe6Cbben5c63K0wKw/Df6RjeGC87sP4fTm6kKnixraEdwchPwFHVBtD7x
	 k7rFLjbzkgkaL1c3M/b81s6bGPgIf7qVPqwC0YK6OA/f16L7Z+yITu3sdxXCFHo4l0C65
	 zFHre6PGjnu3V8Kb77iscuakzM84+qvs63OeJdy7X3+y9PFC/EGad+BD7USfng2u5DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=nNGvMAIL;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EB6606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46EB6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=nNGvMAIL
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-54f873cbe2aso33098931cf.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794410754; x=1795015554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VVuhmpTOxkpymn0weSleRGrGxCwyKmh4kNc2qrZbhPg=;
        b=nNGvMAILLhIgpSoaRMs9TXupHeAJcVzXWR7e4jlC4QcIAGFon1n43zEsGUnQzyYj4T
         /cqjz2kPZtxEXRtaRzUeNuobDbt1po0n1thnjWj5aBlikM9PiREmxVOKIH5N+qfSNCf2
         1a80QphSH/bW4nH/V1F5fUP0LGuFqRQc4GTK6zZrtcBupN/GF+bvddj3vrPtrwXsq3+3
         alTS32l1WW9pXSSkHhFjvHpoXthbHSBfJnIizENmzz5znt7G1HpmNReXq/1vumc2S97p
         YukMPBPqoMbQgaHGDnd6nJqH2FhAiCxTX4lfAhQmczRTG59MmUjR8YswEsLNeZe/3uii
         eHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410754; x=1795015554;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VVuhmpTOxkpymn0weSleRGrGxCwyKmh4kNc2qrZbhPg=;
        b=KSnFYQBXih/3X3sEXgM9cf6flhFSoyiTMshKg71kPtd5pGyNym/WbwbiyOw+aLXdSb
         7EhexAd6rbzuUR36Pvqna9Oyu1Uzk9PSNVgyJ8wZ3WFFn/kxip6qFwFnHM7hdMo8uTjJ
         wv5qf96s+OV4So9FZ5eEj4KH8mCdcF1yoJZszsnNVVI6yBllP0EMbSKJLsd2QEWEzQ1o
         iQpNovTVKFjXb4+n9KJJOT7qXs9aKWzW958SulxQq5yIzfaI4frzkXfh7bMKzHYZmHzu
         ZLhL2eMWN69KjojEOx/oyKY37rd6jF+/sdgVaYGntc/FSxXdyuav4HX3W3hLGC9eKsxC
         gW8A==
X-Forwarded-Encrypted: i=1; AL+hErF9LP3RHN9AINVZvl5HNx4Vroc6/QNer0zZmH1jqZPnH1WEstljhRJiFpBQz2TGvumf1iF3cYo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2KFN0Z2CT1Y9qmHtqYzRvNA7P1WLhEdUKG1buIudjT4rbwgFf
	YWOIWdHeXI+1fZOisugG9s1OVSHvgu4utEqTgn+C7LYZeLpJBHlnI/c3JpLfEk92gN9ZBkKIDAp
	BSlRvhw==
X-Gm-Gg: AYBFou2OBpSOyxFeZYopsW2tNVlu5cwCbZ7Hxj3TqcMLP7BJ2PItisMBurcfWeUXI/L
	gwS28YIJTgRwsh7ezlPEuveziJaGoYYzfLcVgAJW6T3XXN8S6UJhLXlm7RHHqrN7+5BmSiWxsi1
	dv4rgAILI9hS8zXIfSFllRUbeux2RXlTGF8JmwHrmaHwWgomyvraNDXXz4Req2e6VUXD8v9APpc
	RBvmTlDCAM4CSYyy+8ZZhEOOAJZDBBXWejzXVt4YJaPR6ScfDOBO1K+VUy5hTYCZZOavYSjo33U
	gnTNQ65uPUvVti8ErQuRFgV+wJJNzM95hitmu6b/EFrF79MqYutViqgltiXgVoBX+t1LbLA5P/6
	Dr8xzxBxAmdVETHnwTKFmUb1dg4iJFvGqWAy0leznTHqEpVhKGTARwb5PY3JOWFFlLgJrfi7uzx
	9RhlGVgf3OatSbZZSsdaq0D2K0enM86MpNfoazqOC9ytPdpw+meYKDmPX/m0aeZlG6FklBgjryf
	Mv0wYSDhcTnAgTzELBFz27EGvxzLHXN58uqOvfdKYGsZo1ldZA5MEjhvVZ+Ho8mEG9LI8/OzQZm
	js0VT6GxyMZ2dx5fW2Abf6oPlHpoDy53tH/Zb6aa5HzgUXjUmPc=
X-Received: by 2002:ac8:5dd0:0:b0:535:fc2d:b7c2 with SMTP id d75a77b69052e-556c1391522mr40169741cf.33.1794410753989;
        Wed, 11 Nov 2026 07:25:53 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::d355])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b9425c5sm52788841cf.17.2026.11.11.07.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:25:53 -0800 (PST)
Date: Wed, 11 Nov 2026 10:25:50 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb-storage: onetouch: Fix potential use-after-free on
 input failure
Message-ID: <c342c36a-df9f-4bf7-b96a-a4609f128b0e@rowland.harvard.edu>
References: <20261111-e5624093d6-usb-storage@mail.sdu.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-e5624093d6-usb-storage@mail.sdu.edu.cn>

On Wed, Nov 11, 2026 at 08:23:03PM +0800, Guangshuo Li wrote:
> If input_register_device() fails, onetouch_connect_input() frees the
> onetouch state but leaves it installed in ss->extra. USB-storage cleanup
> then calls onetouch_release_input() on the freed state.
> 
> Install the extra state and callbacks only after input registration
> succeeds.
> 
> This issue was found by our static analysis tool under development.
> 
> Fixes: 17efe155253e ("USB: onetouch - handle errors from input_register_device()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/storage/onetouch.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/storage/onetouch.c b/drivers/usb/storage/onetouch.c
> index 49d281f7bef6..e09b3c6b9a6a 100644
> --- a/drivers/usb/storage/onetouch.c
> +++ b/drivers/usb/storage/onetouch.c
> @@ -237,16 +237,16 @@ static int onetouch_connect_input(struct us_data *ss)
>  	onetouch->irq->transfer_dma = onetouch->data_dma;
>  	onetouch->irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
>  
> +	error = input_register_device(onetouch->dev);
> +	if (error)
> +		goto fail3;
> +
>  	ss->extra_destructor = onetouch_release_input;
>  	ss->extra = onetouch;
>  #ifdef CONFIG_PM
>  	ss->suspend_resume_hook = usb_onetouch_pm_hook;
>  #endif
>  
> -	error = input_register_device(onetouch->dev);
> -	if (error)
> -		goto fail3;
> -
>  	return 0;
>  
>   fail3:	usb_free_urb(onetouch->irq);
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> -- 
> 2.43.0
> 
