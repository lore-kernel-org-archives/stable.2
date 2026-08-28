Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09613C3F41
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 05:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895986; cv=none; b=TPd6+oPQ3x44eq8B0CsglRImIUjyb0gA1HFNJU9Kvutuvuhc6fFcZwNJid6wZiECCS8yjHWGE6s1YQnYvbqXQWXDyi/IosqM0iyLeI69nR24ThUX2OQObGdAhjac2GJc8Be2HZijJamRoutPJ2fX6rlombTPqmg3uXsKOYhyKPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895986; c=relaxed/simple;
	bh=zEj9yrKql4gNFNSV5IhGyFHK9/jxyfJe9mV8S0UekMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGPpbXYvAReVs/Gv6eJgttx7rd8ntaNP5TND9Zah+RfNskp3E7hMQ6QHOeOTEi9aYXmxErj7S6BUC1bH/NgfdVhlTnRVBIQWY5v/bDOIUw+FVoS3DgH0P6d8JLZKcJx0Jddm3j3qLmRE3+AS26pkHLteG+CUF7pd1lJoTYCL7Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=j5ASGV8C; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="j5ASGV8C"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-855d2bfae95so1011614b3a.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 22:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1787895984; x=1788500784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yZvPrH9nbFYHNhZAMmF6wqS3Ks98wuR+oIcktCYDIEA=;
        b=j5ASGV8Cg/5TjQ3PT2lDd7YTBx41vQUg+F8AUNZ3JhcLcZtnFz9X1gE+ptCTwqvxHV
         51ddnjCqN76dp2ouy9U/YGDpp8FWG+A1R5k/ASfOy5wO8dvY5PEkwoq36d9ojNZhCEvR
         Ee1wmjKjkr3nFZwU9NmOIWU9BMPwv9Ubbysqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787895984; x=1788500784;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yZvPrH9nbFYHNhZAMmF6wqS3Ks98wuR+oIcktCYDIEA=;
        b=jtEjmRFU7nsflYGgbK1eoZH4LsTnV9PkSm0i+M4LtQY9uSLrSHcojIisoSYTwqzztB
         kqsKUdkLPxs1XZDKJtYC8yDulKQOD+WzGnV2lUEaPOo/1QioSbfWraiEUTiLrH532lr5
         xQ7pxAI1QRSEiFuCmc3nkMEM/9hPDgSmyL/pONbWyAlc+WIyK/fw5EJTT2hot1jrQ0ki
         /6wdYUs8C/VTdU2SBYi6P1eKpi00U0jwJoKkVbBRG5qy1JFvRh8crx2Yv+GwGp1/pa16
         8ibHAYhSYhjq7QdrN/cfXhbflTbwX9Wo7D/x5ybLSiLq1nFD1MTxeMHjmUvqtVDqo0XH
         v6ig==
X-Forwarded-Encrypted: i=1; AHgh+Rr2wSTQEA1Naarr6IEObIuTxrBu9NPwi2tNV36d0W6brSzbLJPEU+aW72QKRRV0WMd3pp1VTcA=@vger.kernel.org
X-Gm-Message-State: AFuF++k6QdkbrN/VM4N4rgQF8IM+Sd2S3CU6sZrdEdwY0I2w0hEvmslS
	q7ULuv5eHl+KhEd493BrhzRLCV8pMogWbvcL6B1KR7foHw8+QhyqbCyxrWU28VsbSJw=
X-Gm-Gg: AR+sD12cT5Fb8H6o+dIib4McUNPqAettaDsNJ0uz6xl58mbwpDDcJF8Ljh6IgpaY/Iz
	t55p1or+wb9yUaXfOaYlr3mHjwufEfswh9aODh7Dlv+BE/ULgO05usyWR4CSwyUNtx0gCpzVSoF
	1hgw8KSfY5zXAXsSgmVcsyNiM3AU6ImpeTCDfNKx+bGvXqeVdjm8f1J9rRFgzVCyxoaEjqg9iKM
	3cscfI58KK2yPiS8HK19gEUT+Uh7upA6QKB8mE64p2sVro3uRb1DIMw9+pSXr3MyhFMj0Q9bUL6
	PoZVaOuriGkCF5+iNDRSpV4x5EBInttJVfuO1yPPbgUXnZdPyTQ3+GsXch23hLbrzesgQPS0Iz4
	hT5k9JTXrHRlv0zU9t0O0XokClLyK6MSzJAGIYeQ/TNN5Um9CKu/vZxosnnvtraM73tex88VANQ
	e0PJmuO8bO2x+AMlppiOGgIwh9ldI0uIwflK4CGdFXKCKObmtyRFByNMVTkYctMek=
X-Received: by 2002:a05:6a20:7fa3:b0:3bf:b7e8:68ab with SMTP id adf61e73a8af0-3d0f43b6581mr14032383637.2.1787895984063;
        Thu, 27 Aug 2026 22:46:24 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f32f656dsm225735a12.5.2026.08.27.22.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 22:46:23 -0700 (PDT)
Date: Fri, 28 Aug 2026 14:46:16 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] accel/rocket: Collect job dependencies before
 arming
Message-ID: <apEggyjyM9yCqg4A@rock-5b-plus>
References: <20260828050805.38548-1-Naixumogu@whut.edu.cn>
 <20260828050805.38548-3-Naixumogu@whut.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828050805.38548-3-Naixumogu@whut.edu.cn>

On Fri, Aug 28, 2026 at 01:08:04PM +0800, MoGGuU wrote:
> rocket_job_push() arms the scheduler job before collecting its implicit
> dependencies. Dependency collection can fail with -ENOMEM, but an armed
> job must be pushed and must not be aborted with drm_sched_job_cleanup().
> 
> Collect dependencies before taking the scheduler lock and arming the job.
> Only operations that cannot fail remain after drm_sched_job_arm().
> 
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Cc: stable@vger.kernel.org
> Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
> Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>
> ---
>  drivers/accel/rocket/rocket_job.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> index e6052d1973afa..b55e12aecfe64 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -206,19 +206,21 @@ static int rocket_job_push(struct rocket_job *job)
>  	if (ret)
>  		goto err;
>  
> +	ret = rocket_acquire_object_fences(job->in_bos, job->in_bo_count,
> +					   &job->base, false);
> +	if (ret)
> +		goto err_unlock;
> +
> +	ret = rocket_acquire_object_fences(job->out_bos, job->out_bo_count,
> +					   &job->base, true);
> +	if (ret)
> +		goto err_unlock;
> +
>  	scoped_guard(mutex, &rdev->sched_lock) {
>  		drm_sched_job_arm(&job->base);
>  
>  		job->inference_done_fence = dma_fence_get(&job->base.s_fence->finished);
>  
> -		ret = rocket_acquire_object_fences(job->in_bos, job->in_bo_count, &job->base, false);
> -		if (ret)
> -			goto err_unlock;
> -
> -		ret = rocket_acquire_object_fences(job->out_bos, job->out_bo_count, &job->base, true);
> -		if (ret)
> -			goto err_unlock;
> -
>  		kref_get(&job->refcount); /* put by scheduler job completion */
>  
>  		drm_sched_entity_push_job(&job->base);
> -- 
> 2.43.0
> 

Reviewed-by: Sidong Yang <sidong.ynag@furiosa.ai>
