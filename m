Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA2D358D27
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 05:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896258; cv=none; b=pW2HhunnjEKbPBG7jrSc+nkDUCK1Ku6mu6B386TSaJZiOTr4tgsLue70rSsyrzguXNHyIqtQebYj51nvKvHYfjwyQP5tpCd+nt7v2Q0T0qshExpfKknyPbe3rXPR7Yaw1is/wHgCKRAGg6ti/4ovt+fRBCIs/Cx424n9vc1T99k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896258; c=relaxed/simple;
	bh=Nw3oewzCt8XW/7eO8oiogBlbbeVU9OECZ3MdfUUt33Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0s+0jS5G8EJVDG1aEQReAu9cZbnl87Bk4ToD6k5CwHZHdvpD3Wo7FvT92h0Wleq30hMQYhRfJrMAs9tHsSg3YlcEFNjpmyw4P1L4Hu2y7Ypa5nlY4PO7URCqoFOWBQM6O4Q2oETFwBElQthBNepyXChLLIU0AKZKC99s2oGr/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=AuiazvN6; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="AuiazvN6"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so788642a91.2
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 22:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1787896257; x=1788501057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LpkQSACoNhXcxF8SalSGxWUmZp7l1S5RyOE6epy4FMk=;
        b=AuiazvN6wUGERoJdOVNbgq8vCpShIlAvLai5dJeOTItWxgwdHWUO9wMe7UGJjCG1WX
         bZ2B7q2Hf7LeuAXZuViFayl1WJbnmL15ZJfWJK72zzcbvuumJ3y2eRQERtwqab0NuWq4
         VVZIJjOj39o7wkpt+4dVnNsSGbjDsegafYUBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787896257; x=1788501057;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LpkQSACoNhXcxF8SalSGxWUmZp7l1S5RyOE6epy4FMk=;
        b=WGh/CqLIKh0p/wgNC37Zt/LW8mJmThpjYKkqCtO98kUGV0kbRYkjvgeCaAnLS4+jvx
         O293eHjFqoiIhowKR2T3jZlWru31QAs8kHIitB5Nln204us7SMxC1S2WdgWQSylN07MT
         kut+0hHTjTCGe866O+bgnuaF/VdvoHagI3TrOojwtFDMTp4YCiZCkoO2iEnLRROg4FAi
         LIy/W6Kii7H63WRhNnBaLwb0sU/SiVzif2gWgedazl369nzzVztpuBWGBn9jILNkZeG0
         s6vLp4K9d/DoFEwiX56HmYG45BpEdXxvbmfYUuGyF//6FozIR1YlCyxqUrXPUD5KQo9H
         IwqQ==
X-Forwarded-Encrypted: i=1; AHgh+RpcNoZJi1qbzw6vlOaOz6Ts1nUWzFt5t2hjX+snEhmt2X2dt7c0di8gt6yKeELCLihvih6jvWA=@vger.kernel.org
X-Gm-Message-State: AFuF++nOF8u62Wb8e/xEvn6WliisCILZg7oP2YmIs75LZ6+FSTGY8l6a
	o7LD6ugKMq8K11M/6+XWeh/etRe1Hv5AcO3qfKW9gC9vD6/PFXLjBtzWL3Z1VwymL60=
X-Gm-Gg: AR+sD11BJtmneg61hq5t3ZZPdV2A6PO4n1jvYpOiKF26XbmGWnVPYValCEbnop092OP
	U5M3wddt6nrLvTi2j2w03G6jFY470rqDKs1MV6uyiJTPARVfQ5UPbKSiK8605cRcFsZjnmOeeEQ
	QNQs+akKG5fdqKEfZM6kCo1SJgdi4YV5tkAzCgaXNCxcynvqEnPIYIeFhvloza0eERcxNpGUmhJ
	b9I61tsXr7YhaUNAejebFQaWPYyfj1Myv+ALr65Rp9kiesvRKu14wWEFOv/wC918rHrspCS3I1o
	9UKuzoBcgIx38YL4wbqihG26owo75FrX5/beyDoM2XhJEOeYf+ddsZHjiVDXRbYF28V8pt4AYOK
	Rx4iK0PEYkOhKBVi4y8slaM3NkToEyXlGZMEVa975RowKHEUCqW2B4fm5QC8cwkirPrTIEA2sRm
	zSYndHDSk90Tg3mBn2zTfxwwN55HULytaj15wCyHVpSJDPg7eLH4xi9yquF9Jo4Q==
X-Received: by 2002:a17:90b:3ec1:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-396d0f2dcd8mr6908508a91.10.1787896256905;
        Thu, 27 Aug 2026 22:50:56 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc07777sm1228032a91.12.2026.08.27.22.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 22:50:56 -0700 (PDT)
Date: Fri, 28 Aug 2026 14:50:42 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] accel/rocket: Collect job dependencies before
 arming
Message-ID: <apEhmia-SLEe-39S@rock-5b-plus>
References: <20260828050805.38548-1-Naixumogu@whut.edu.cn>
 <20260828050805.38548-3-Naixumogu@whut.edu.cn>
 <apEggyjyM9yCqg4A@rock-5b-plus>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apEggyjyM9yCqg4A@rock-5b-plus>

On Fri, Aug 28, 2026 at 02:46:16PM +0900, Sidong Yang wrote:
> On Fri, Aug 28, 2026 at 01:08:04PM +0800, MoGGuU wrote:
> > rocket_job_push() arms the scheduler job before collecting its implicit
> > dependencies. Dependency collection can fail with -ENOMEM, but an armed
> > job must be pushed and must not be aborted with drm_sched_job_cleanup().
> > 
> > Collect dependencies before taking the scheduler lock and arming the job.
> > Only operations that cannot fail remain after drm_sched_job_arm().
> > 
> > Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> > Cc: stable@vger.kernel.org
> > Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
> > Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>
> > ---
> >  drivers/accel/rocket/rocket_job.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> > index e6052d1973afa..b55e12aecfe64 100644
> > --- a/drivers/accel/rocket/rocket_job.c
> > +++ b/drivers/accel/rocket/rocket_job.c
> > @@ -206,19 +206,21 @@ static int rocket_job_push(struct rocket_job *job)
> >  	if (ret)
> >  		goto err;
> >  
> > +	ret = rocket_acquire_object_fences(job->in_bos, job->in_bo_count,
> > +					   &job->base, false);
> > +	if (ret)
> > +		goto err_unlock;
> > +
> > +	ret = rocket_acquire_object_fences(job->out_bos, job->out_bo_count,
> > +					   &job->base, true);
> > +	if (ret)
> > +		goto err_unlock;
> > +
> >  	scoped_guard(mutex, &rdev->sched_lock) {
> >  		drm_sched_job_arm(&job->base);
> >  
> >  		job->inference_done_fence = dma_fence_get(&job->base.s_fence->finished);
> >  
> > -		ret = rocket_acquire_object_fences(job->in_bos, job->in_bo_count, &job->base, false);
> > -		if (ret)
> > -			goto err_unlock;
> > -
> > -		ret = rocket_acquire_object_fences(job->out_bos, job->out_bo_count, &job->base, true);
> > -		if (ret)
> > -			goto err_unlock;
> > -
> >  		kref_get(&job->refcount); /* put by scheduler job completion */
> >  
> >  		drm_sched_entity_push_job(&job->base);
> > -- 
> > 2.43.0
> > 
> 
> Reviewed-by: Sidong Yang <sidong.ynag@furiosa.ai>

Sorry, I typo'd my address in the previous mail. It should be:

Reviewed-by: Sidong Yang <sidong.yang@furiosa.ai>
