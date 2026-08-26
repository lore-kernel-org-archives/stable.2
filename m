Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361D642E416
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787754889; cv=none; b=q5Tl1ECrVTPVNPBOQNW8fBLTyoeg7UH8mQqopEQF2z+LDNPBxbhTIHQXZjJu3IZ8OtrIW3PnU3naO6NJr9olsqbTwUVQUCflnPPbZlSpJoiXE60yPjTkPQqNYHuk1beYSk2pqDhN+0XrZfV2mJ1hG8py4sVik6/brkigGdUsZ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787754889; c=relaxed/simple;
	bh=ZzuGnHIAIfA/t8cFWVOgErYASeqF6iVH4G5HnM/IRx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1BACL+SlClgNw4ArlITlXz74IKf16l9aXnHg41jO6bHmOEQquX4cL5mZUQ10YLu8Ml3qJVXrD+UUcwJoQTdlXoKwy6QoW/LOKcyVxP/Hipa13/rO2G5wadL5uC3Cwjm1b3X1qGiu6n9jdsWWuItQay/4Q/NDRsYQB/SKO50dpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=oTAmHFzb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="oTAmHFzb"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1536300a91.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 07:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1787754887; x=1788359687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yn02buzACRQQNaPjkaVeG7aAyIjhQMcWh60YSklrQcY=;
        b=oTAmHFzbXGDggyZIF6m8s5Mdk0HWGy93R19XkbKA+kLC7DYACBhdcwNPW1V08Jnq+J
         ae4Lnt4nDkkZp5WCrp8QRbaQc/1Qr7YbQ5q5zpJ5KZn0Xa6W0OjP8OgtZ7+FiWb539JH
         YihLQex2w3R2+IUlZhcSQO9gK6m7TdzzChyws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787754887; x=1788359687;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yn02buzACRQQNaPjkaVeG7aAyIjhQMcWh60YSklrQcY=;
        b=Qwtvk56UgZH7iDsy4SdNxRumPF9OICxbD9ECnOAJzpc5xddWw9RGMaAErSRQKdT+t1
         Qynh2lUxr0B65W7K9oQuBCkqJ0/Li93S06+0d0EPw7KWb1kcm9y0r/1sHoD255AAudvn
         3uj7V7gj37IEPtpd4GJwB4z8R5b0C8m5Kz9UuFr3hDX70aHnGkHuU14tzeW+pPwsOpPx
         tyV1Z6FjB9Oxqr1QTdlO0PVbQQ1+jXxgpfFFjicpWWLZfd6zMN0NAbaLlAA8ix2z2jTs
         OuJs4lf18n8oHd2ojQx1FfNfmG+KeXJAPDgHzAxXmog4Jy2cYBGXyxZptN9TdAKVJNhd
         Is8w==
X-Forwarded-Encrypted: i=1; AHgh+RofRl+OKQi3SGhVeeRkVLhJlVZc1fJR8UJe3AB7olNBY/wU/7oBr9SdxsoQbWmgKbZKJMPpkQI=@vger.kernel.org
X-Gm-Message-State: AFuF++nnNFeEFyaJF/CnUyn0vKL0Qa5GWcm+qCHi48nV9COVfvcdqLob
	0j2g22imvDiE3WdnLuctivffx2G0ZJzVphRc7hKRAXrqgJBrKdBXeQchUgBN6S2hvN8KxZR6dpB
	aFtRA
X-Gm-Gg: AR+sD12w5j32blKFGD/U1gTorMiZ25r9q+ycBFPetJzYbtq1bQmzKBcGlNUkGnfuOt8
	BKwVxxLFliqMTYvC44TGWXpRtx8i33xPhKZtDQJY0mlAp2brvl32wZvt0Z0Eu9k1GYzLawukC0B
	VEGi3nogThqIN66WgYmHjV7Fd0VCfnVbkXludXwP7ol2fKpLh6wK9Em4Zsl/Tz+tkPK37L0bAjZ
	RVVnp39Ys7CuiVMN3qggEYD7m+bpvjyXuSPt3TBVQ/h2dHjYAvdGWKXQkDscrB6fTlcYIKFaYTr
	Ouki2QxaFuJRJOEc1ELnkRDHoTF6M7fkv6cgmreMxjNiCjXCmiCi4dFgYC54gHoASkGlu4GZGWj
	xGh4Ymq0VABFUWbC3eiNB3q0NDtXG3bjPaDnuEasMfVvJL7/NtfZqFd4mL3mceuyDakIdGxzhyq
	4IAe8UVL5ioCwdjGW9cFWtTP0TeiA9Q82zV99GjQMwlD6l+ogcGwGlgMNNJsY/WLQ=
X-Received: by 2002:a17:90b:4e88:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-3966d3e1aa7mr17670746a91.9.1787754887451;
        Wed, 26 Aug 2026 07:34:47 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a57396sm4760198a91.13.2026.08.26.07.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 07:34:47 -0700 (PDT)
Date: Wed, 26 Aug 2026 23:34:34 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] accel/rocket: Fix job submit error handling
Message-ID: <ao706o8ReDs-IXqf@rock-5b-plus>
References: <20260813142059.151644-1-Naixumogu@whut.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813142059.151644-1-Naixumogu@whut.edu.cn>

On Thu, Aug 13, 2026 at 10:20:59PM +0800, MoGGuU wrote:
> Several error paths in the job submission path can be triggered by
> unprivileged userspace through malformed DRM_ROCKET_SUBMIT requests.

I think it would be better to split this per fix.
And I've tested this patch, it works.


> 
> First, the input and output BO handle counts are __u32, but GEM lookup and
> reservation helpers take int counts.  Values outside the signed range can
> become negative.  A combined count above INT_MAX can also overflow at the
> call sites.  Reject counts that cannot be represented safely before looking
> up the BOs.
> 
> Second, rocket_job_push() arms the scheduler job before collecting its
> implicit dependencies.  Dependency collection can fail with -ENOMEM, but
> drm_sched_job_arm() is a point of no return.  An armed job must be pushed;
> it must not be aborted with drm_sched_job_cleanup().  Collect dependencies
> before taking the scheduler lock and arming the job.  Only operations that
> cannot fail remain after arm().
> 
> Finally, rocket_ioctl_submit() discards each job's return value and reports
> success even when every job fails.  Return the first error
> and stop submitting the remaining jobs.  Jobs queued before an error remain
> queued, giving the ioctl ordered partial-submit semantics.
> 
> Tested on RK3588 with zero task counts, invalid task pointers, invalid BO
> handles, and oversized BO counts.  The requests returned the expected error
> codes without warnings or errors in the kernel log.
> 
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Cc: stable@vger.kernel.org
> Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>
> ---
>  drivers/accel/rocket/rocket_job.c | 34 +++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> index bb77b6bf0..c42bbf486 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -206,21 +206,20 @@ static int rocket_job_push(struct rocket_job *job)
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
> -
>  		job->inference_done_fence = dma_fence_get(&job->base.s_fence->finished);
> -
> -		ret = rocket_acquire_object_fences(job->in_bos, job->in_bo_count, &job->base, false);
> -		if (ret)
> -			goto err_unlock;
> -
> -		ret = rocket_acquire_object_fences(job->out_bos, job->out_bo_count, &job->base, true);
> -		if (ret)
> -			goto err_unlock;
> -
>  		kref_get(&job->refcount); /* put by scheduler job completion */
> -
>  		drm_sched_entity_push_job(&job->base);
>  	}
>  
> @@ -556,6 +555,12 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
>  	if (job->task_count == 0)
>  		return -EINVAL;
>  
> +	/* GEM lookup and reservation helpers take signed object counts. */
> +	if (job->in_bo_handle_count > INT_MAX ||
> +	    job->out_bo_handle_count > INT_MAX ||
> +	    job->in_bo_handle_count > INT_MAX - job->out_bo_handle_count)
> +		return -EINVAL;
> +
>  	rjob = kzalloc_obj(*rjob);
>  	if (!rjob)
>  		return -ENOMEM;
> @@ -639,8 +644,11 @@ int rocket_ioctl_submit(struct drm_device *dev, void *data, struct drm_file *fil
>  	}
>  
>  
> -	for (i = 0; i < args->job_count; i++)
> -		rocket_ioctl_submit_job(dev, file, &jobs[i]);
> +	for (i = 0; i < args->job_count; i++) {
> +		ret = rocket_ioctl_submit_job(dev, file, &jobs[i]);
> +		if (ret)
> +			goto exit;
> +	}
>  
>  exit:
>  	kvfree(jobs);
> 
> base-commit: d85a5e9dfb42449d9f37b0ddc6ec30b129f481ce
> -- 
> 2.43.0
> 

Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
