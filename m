Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB88D2D7BF
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 02:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882607; cv=none; b=hn0IbOAZAa6zGYpvTu4BNp14D37Tzp9nXvQmc5Qiaf7YfasoqUF3IgluRALs3/gsb+uHkCPqhkhbukfMbGivOVTPuXG7ArgJUrbAFHIwNlsaarzW5UBdrAPlVHX2bCYHA0Q2fgdfPUl198aZyJT2O7N0im2B9FK3vjjMWJerer0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882607; c=relaxed/simple;
	bh=nO2pAxV1NjTbBofk6R5GgxKO4mimVsO5mJyqelHHsfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITh/5LvK8Iz6TrN9LOOLFVD/U9UKA82YV8bvMl/R/8qSJW3D+hVB09sipI0D5MaE9l3l5iaTEnFbX4uEwdscwVJhuWGstXHBLZQhj2Op2n/2QO0utwTAdJDJizvTi5kNoou47fYX4CWIGF+obRYZZXZeOVH7CiiSP1HhAQg5zzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=QVkekQTg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="QVkekQTg"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d53197d8b5so4284375ad.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 19:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1787882604; x=1788487404; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pTlKUEzQEa7Rn+0hDVYmAqWQKbByFTTyOUa8CoMUQEQ=;
        b=QVkekQTgoNbRC9uuew59k0uwQ0oHBtOdkaltw7xNZjMyMXPZrXmte1gjv1PzEUdaM4
         SJK/eg35ZlclqgecuAODdZMCrKwbZy//4QA2YsI/xftFmM3BP/R8HF9RheCRCzKcFZYb
         pyM09KpI7ok6C93a+RuqeC8mpH5LqC0mBf7vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787882604; x=1788487404;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pTlKUEzQEa7Rn+0hDVYmAqWQKbByFTTyOUa8CoMUQEQ=;
        b=AEGXSVUzIsE3hKtCqR7wod5r0TqeIm2zzguf7gFvwIqMumxxM4fLFacVEKXCOPee2m
         kIH71zw2AtAAMA50CkSsCLtHYZaogWjJZpETjTK5pdd1zxrR6BzUpVAoiY1hmwWBJpV3
         ClCLGEb0FhJGQY+2okqbeFF0vU5M31Jkx2MpuqvxAm6MIEEzk/mfMAj4Pa+cWi0waNPK
         j0pBfEBYc0FsSO6gxGWTTcd72oljRe2MWmOoH9X6lo3bqrSG2NVP6AeAbBbrJcFzkE7C
         x571YNdkXmq82IqMai3vRdh63XBD9DOHOemF454Rrm/6ZstmTS3opjNIcjh2SFEKMqhg
         gOOg==
X-Forwarded-Encrypted: i=1; AHgh+Rpnsq1Ap6KPlesZRLvODpcTvCtHgunoWn/IKOGCwoZO7oV/w9XRhW7BYNsSMtu1nhKHNQBFfYE=@vger.kernel.org
X-Gm-Message-State: AFuF++mnAp+Py8BhgMlkzOytjWP00fD/Yfhtb5OIVg2A0Jpe1NSfEhGs
	oCmVi1OE40aihAl8rmYXZHi6GVq6TDwq0LoStb8OzmFFMIb83lglWJR+IxHunCb9lpc=
X-Gm-Gg: AR+sD12uFKtU8ATzOhG+anAhSX+Eb5HKLRmDQc615XERMHddegZudm7qtUVoERkVi/F
	AbT8+vzjtnhNmP8mneTBnianlQdNO+3WUqxApjuMUsMwgXjH0xTuV8i4yiHq4f365hRGwlp1Rk4
	3JCwymlpKHDuNQEFt6QrM5mLUQLx3bf16IretbtvEaRYxaUzIK/oZ2vyX9TTOSxX/cFhJg+NjkK
	xLGN2pAXIYoXV7vzLknxY3kh8yfvThXRGeI88l/sgC9IUh+drQsKMDplUYCfJ8ORq832eXy0vWe
	hmSA5h84vxQBbzR1bBA+qkRAGFU+ep6+bLnuv1mcemoeHSGljtHmeblS14w0W85WpObfVPl72wh
	hh1EOUEwa7XC93mBOPskbqpdyvEIk5gwo7Q/6aaRzsTk7zUrsjDO2BqVm+n4HAJ6wWXlP631a39
	N3fx/JGrUBTTX8SydEg67QNnwYV9Y5tv8q/ULMbRAXWAN24mU0hgPCCjI4TWluUw7KAbp1cwSuA
	Q==
X-Received: by 2002:a17:902:d484:b0:2c9:bf82:dd11 with SMTP id d9443c01a7336-2d74ddddc11mr64753975ad.7.1787882604255;
        Thu, 27 Aug 2026 19:03:24 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7598c1cb4sm813515ad.81.2026.08.27.19.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 19:03:23 -0700 (PDT)
Date: Fri, 28 Aug 2026 11:03:02 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] accel/rocket: Validate BO handle counts on job
 submission
Message-ID: <apDpz4j2y2_8_pOd@rock-5b-plus>
References: <20260827170608.39511-1-Naixumogu@whut.edu.cn>
 <20260827170608.39511-2-Naixumogu@whut.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827170608.39511-2-Naixumogu@whut.edu.cn>

On Fri, Aug 28, 2026 at 01:06:06AM +0800, MoGGuU wrote:
> The input and output BO handle counts are __u32, while GEM lookup and
> reservation helpers take int counts. A count above INT_MAX, or a combined
> count above INT_MAX, cannot be represented safely at those call sites.
> 
> Reject such counts before looking up the BOs.
> 
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Cc: stable@vger.kernel.org
> Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
> Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>
> ---
>  drivers/accel/rocket/rocket_job.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> index bb77b6bf0f231..7e3d123afc5ad 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -556,6 +556,12 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
>  	if (job->task_count == 0)
>  		return -EINVAL;
>  
> +	/* GEM lookup and reservation helpers take signed object counts. */
> +	if (job->in_bo_handle_count > INT_MAX ||
> +	    job->out_bo_handle_count > INT_MAX ||
> +	    job->in_bo_handle_count > INT_MAX - job->out_bo_handle_count)

I think checking in/out is okay but the sum of in/out would be checked with check_add_overflow()
in rocket_job_push(). But it only caches overflow UINT_MAX because bo_count is u32. It seems that it
would be good to change bo_count to int.
ㅏ

> +		return -EINVAL;
> +
>  	rjob = kzalloc_obj(*rjob);
>  	if (!rjob)
>  		return -ENOMEM;
> -- 
> 2.43.0
> 
