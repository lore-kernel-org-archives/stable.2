Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D91E3CA49C
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 05:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896066; cv=none; b=MjKyTI8a/uTquhWJhy7xqVEjoUkneFytzawBGzhadUfXYBLYa+hezDnG9Q8Ir0W3mSBCeoyu3DKupAUPhEGX/cw72fENDuU3Q2bZmpDp7lI81wSe+OlcSeVPo+UEysPofyR/HaDeyVzer2Zd3+0LM/+Eq0QOdVEEyfRfzbvY34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896066; c=relaxed/simple;
	bh=/Z9wNHZIwyW+w88vEhoqsRCl3N9CQ+qcixTfXkLqC2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3Ezl30qkvWw73CbLk/uc9bHQgdpAGoxhkNO+qI51iUYTPt1TUYx241NNDszK6132lzUyxzhmL68sTZk0BR8rLM21dFfiXcXJI0eqmzu7jhll/VgRWeIXL0hQkq4E678Tc9X/fxCmQ8dsBD+159VSFWA17I5drElI49Ts6dVt/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=BRdXGL2T; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="BRdXGL2T"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso750530a91.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 22:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1787896064; x=1788500864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Zt5PXljQJqHa8ejgOjMYryQAjVgVBZDMdimKNGAGng=;
        b=BRdXGL2TV+OK0BzMETDaVEysVnMgoNJvQv+z6exLF3Cc7RHePwNkJaH4IXGkIm7S6q
         kOixfkVE/bEV1iFwehjo+5Yt1vn0dAdLjbAxmlB5RD91CZotAy8DlYPLHIXhyZXCO+2s
         ffzDaCQ6c8hgmZVWzg5QsRErcb5yFxWxOVdoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787896064; x=1788500864;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Zt5PXljQJqHa8ejgOjMYryQAjVgVBZDMdimKNGAGng=;
        b=q1CBPszLabAKq67qHUHNe/X6ab5btPcNt0wdAb8AgYKQwJ+RkOBhItlrS4nf/LA3n4
         B5/eSXSdoM/jp+qEny0h8pSK/lo1UEXny3qcgCFJYBRdMevlzMRr/CHr/dgSdQWOcpHi
         A00sOayrcTwV65wxZX+ddjjE8r6WR8fEfBRVcrZg8i9OrQK3RXecmEkUYFbXdHbnFeRf
         f/dIJg4qxKYT+ntPNnQE4MZO90svyTn2KryQNsu6kSPElMtof42vEe0YsbguEuvntzUz
         0KLGQROFialMOH8nKrfFayNcYIuqOBKhlPGDlRtIm9uciQEOAYB3H+RqcCOBioDX2cL6
         UWQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq72wfBHnJO6xFH2ykPPEqhc4Ra1tv1YoaYf1JjPr4AL87y0v2c8h9+6ww6VibsVM1ntMcVH9o=@vger.kernel.org
X-Gm-Message-State: AFuF++mm95fQVEovtdtIgVOGpfTqaNaKp6OjGjG9FcwT2LGlnJPDQAKe
	YibXCBJPmCqk7WL0Dp+R5LHLnR9U6WGUKuEn+2zg5MlrcCidVKqQtK5GhcPILNkLeRE=
X-Gm-Gg: AR+sD11lEgz9mXndbvecvd+ypfsg7ZMnUl+HOoAKHcoYgyhN4WUKz6ejXkFgOfCH8kW
	Q5sBQ18HlXqMtx2Hst5VNzlvhhf3RGnb5mhVsnmMQh7dy4mK2jXPwcMHcZPYRlMmYjkMQNyavjw
	4GbS16DSsyu7YHJBoYBYYE8HaE+GOGjauyzSahzJiN6As48VhX+BvXcESwAiiiT0QT3lkHG+YDg
	8a9KE8oCuRt5qeZ0Qmu+V/q0/OuEvKRxT6Wviz9rOSqHgS1kxm7g2t5F/AO4c4quCb45XiQh42X
	XmL75fKDDpZCOAwIOc1G0sALSny/3+j3NI+JinfolBkfvlQHEIn5SuwukCtzxVU4f9xYY7uZCPb
	G1YVDkRpCXFsoudXQCSj+kXt+/QvQXyzfESmirjh9uxIrMrWJjHdldzaCNldUEO1IFizA+yDCCs
	F4B7NnPBR4c3SkoAs/3Qit/cGNw0amidpoHEb/aQmKtNikB6qDH5Sc2sFc/TU8tIs=
X-Received: by 2002:a17:90b:37cc:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-396d0d92d0amr9519889a91.1.1787896064320;
        Thu, 27 Aug 2026 22:47:44 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b1992e05sm5740448a91.15.2026.08.27.22.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 22:47:43 -0700 (PDT)
Date: Fri, 28 Aug 2026 14:47:29 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] accel/rocket: Propagate job submission errors
Message-ID: <apEguR4JBTEvsHds@rock-5b-plus>
References: <20260828050805.38548-1-Naixumogu@whut.edu.cn>
 <20260828050805.38548-4-Naixumogu@whut.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828050805.38548-4-Naixumogu@whut.edu.cn>

On Fri, Aug 28, 2026 at 01:08:05PM +0800, MoGGuU wrote:
> rocket_ioctl_submit() discards each job's return value and reports success
> even when every job fails.
> 
> Return the first error and stop submitting the remaining jobs. Jobs queued
> before an error remain queued, giving the ioctl ordered partial-submit
> semantics.
> 
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Cc: stable@vger.kernel.org

I'm afraid that this patch changes userspace API. After this patch, userspace
programs get an error on submit. So it seems that the stable tag should be
dropped.

> Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
> Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>
> ---
>  drivers/accel/rocket/rocket_job.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> index b55e12aecfe64..8f1bdf4a57f20 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -646,8 +646,11 @@ int rocket_ioctl_submit(struct drm_device *dev, void *data, struct drm_file *fil
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
> -- 
> 2.43.0
> 

Reviewed-by: Sidong Yang <sidong.yang@furiosa.ai>
