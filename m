Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56A33C98BF
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 05:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895917; cv=none; b=SqaygFqTU28XGLsVMctki/g/DKdV8I8F04YLtyBhqwXHbgW5lSneIdTpkcjHjIS3cL1ye+TePFFajCjwbIOYcktomN43/ESqPo8uX60zaEeWCmN/g6WLYCGAg0gIiBAcnYDiPsPcPvaN3hxfbEZE7io241RU+d/vTLWduGzACQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895917; c=relaxed/simple;
	bh=GUotgCHYkagED1ZiL9XiH/9TVtTNLBsH2gIVijoFfPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aV8PchV90Yhiw1J1dGyh7oVUwj9F9NbbbLXY919hc4MGk5vxLHCjq8m6iTVwfAN13ZmylE7ti/uWB44huyqbzneSIzRDcjNYRPASjqMtHBkMCqdtTb9KNxR7c3ZxxrlWwZFbdVFJD0tJoUaCuR/oH+lSMZktgk/jj5J6p+H7AGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=H6paxxgy; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="H6paxxgy"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3966791a6eeso930373a91.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 22:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1787895914; x=1788500714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mfUcgIwCJiYcPweMkIb+GXJK0j3pn/tPAjbOK4olTtY=;
        b=H6paxxgySAlIcQ3OTwznY+DSy8/j+Akq7SE4TbqM3tbLpWXqisIlygSRztqAHvTVj0
         CX/os0eavA+xYWqvsziVJ6t4NYw8ShG78PmiuEvahcULaFDMUsh8lqDuuqzLlro0bzDK
         ynQDktWqcppF479KWdZ77twQoiqb37TSsh7Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787895914; x=1788500714;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mfUcgIwCJiYcPweMkIb+GXJK0j3pn/tPAjbOK4olTtY=;
        b=os1Dy0OTMVy8ofqP/bVXku/aB1ecIniDSyC8okRJavk6VxrMVSQx184OOuLlyEWZxe
         LeP7MT7HP3ENdbkSvnv8BaxGD5CI+jL2vqRzwE0FEmon6AUem/j4fqO+ae5RIfUWjhzy
         JGP6ePbGM1Otdl6hxKXwSBHRjTY308M1+N+ab9iq0Ys1H0fjNsa5NlEPnmmoOKyGgYhX
         KNczHr4iLlftqMdakQoh9DYmmUVQsueEv3F6ycOZ4+Duj5vhDmma1fnvaqMOUzIcVv3H
         lmMXsBlqrJcNcUip5CLr2wcu5XalRmUosvvZZDRy8a1HRPQ6ed20bgFIupcvQctsvuNk
         haEQ==
X-Forwarded-Encrypted: i=1; AHgh+RrxMZxjSt9kZsYtYSdPbfJHFHG3DvOZS27myksJbXREoWUX4sJf68MG6zLI4tvaIIa9BKUjcmA=@vger.kernel.org
X-Gm-Message-State: AFuF++mAvd5uhPHoOC7XzX9u1y4Q0meTB4ZG8MpiWtKPSVnvEU6xTnE7
	Z5Z++0SzzJfhcYP3BHMrwhWwKnxkpH+oyxmqGGIDzbQkDBDhRg7pxrgibkR5u3vYOnQ=
X-Gm-Gg: AR+sD12aUqPZJ9+xSPI4iA/kqg2s2fPQ1qSiO6EyVLfQsUzGUMZNUq6tA2l770SicxF
	tCmWNtUvG/igCvoIf5sDSl4Lub9JYIg+gSzZxWpyBg+RiI9r7GC8xgNCs5NK/Ytg23c61DFpvyA
	UGtj852t0cVHMDe3RzMfZlaGOTvocyKPqyNqdzsGJCDULrVruAV/2xFUVj518neW07X1QRkn/AQ
	pLVEPbBDw5LiTfg/ecQvbpyDq4GML3InxaRKiXx46i1IHpGdmU9dvcZp34QaXrJrqLmmuf1Inio
	EsY44KwZ/90OW5ORT15KcWCvLQ9kJhGIQTw3lxvVYPyqgRlnl8XD1qCuKE1RGloYF+4zGTyBpAy
	t3WEu8R57MGT+59uGmH7Mx5kbCmyxZ3N9yKuW6XsqGherHjxu9Lo1SSNwBuPBJBIbTTOqInKtzG
	SbBlKbx8N4KvCokMoS5YEtxzPbDP/lJ05tmyIQmOfDfGPggmcSWN+8m/gqg5JSIRE=
X-Received: by 2002:a17:90b:380c:b0:38e:2524:724f with SMTP id 98e67ed59e1d1-396d0ef3c2cmr8708512a91.12.1787895913751;
        Thu, 27 Aug 2026 22:45:13 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396dda368e6sm1107298a91.4.2026.08.27.22.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 22:45:13 -0700 (PDT)
Date: Fri, 28 Aug 2026 14:44:52 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] accel/rocket: Validate BO handle counts on job
 submission
Message-ID: <apEfoHtWdtSkSW3s@rock-5b-plus>
References: <20260828050805.38548-1-Naixumogu@whut.edu.cn>
 <20260828050805.38548-2-Naixumogu@whut.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828050805.38548-2-Naixumogu@whut.edu.cn>

On Fri, Aug 28, 2026 at 01:08:03PM +0800, MoGGuU wrote:
> The input and output BO handle counts are __u32, while GEM lookup and
> reservation helpers take int counts. A count above INT_MAX cannot be
> represented safely by the GEM lookup helper.
> 
> Reject each count above INT_MAX before looking up the BOs.
> 
> rocket_job_push() already uses check_add_overflow() for the combined count,
> but stores the result in u32, so it only detects unsigned wraparound. Store
> the result in int so sums above INT_MAX are rejected before the count is
> passed to the reservation helpers.
> 
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Cc: stable@vger.kernel.org
> Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
> Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>
> ---
>  drivers/accel/rocket/rocket_job.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> index bb77b6bf0f231..e6052d1973afa 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -190,7 +190,7 @@ static int rocket_job_push(struct rocket_job *job)
>  	struct rocket_device *rdev = job->rdev;
>  	struct drm_gem_object **bos;
>  	struct ww_acquire_ctx acquire_ctx;
> -	u32 bo_count;
> +	int bo_count;
>  	int ret = 0;
>  
>  	if (check_add_overflow(job->in_bo_count, job->out_bo_count, &bo_count))
> @@ -556,6 +556,11 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
>  	if (job->task_count == 0)
>  		return -EINVAL;
>  
> +	/* GEM lookup takes a signed object count. */
> +	if (job->in_bo_handle_count > INT_MAX ||
> +	    job->out_bo_handle_count > INT_MAX)
> +		return -EINVAL;
> +
>  	rjob = kzalloc_obj(*rjob);
>  	if (!rjob)
>  		return -ENOMEM;
> -- 
> 2.43.0
> 

Looks good now, thanks.

Reviewed-by: Sidong Yang <sidong.yang@furiosa.ai>
