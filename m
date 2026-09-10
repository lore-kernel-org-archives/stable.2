Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D619548EC63
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056432; cv=none; b=WiQ1qvgsMkCk5AUwAELApsg5QO+lNI9kl/BNcG12CnLa9zITC2aO+t2cazHSzWCD48f8lzCuW/sp2AoaE7cgAvmyr7QaRkCF9nylz6Ig37Rku16zxsLVYz3BFcDdwpzwa5qj/RD3l23Nh1qMuPXIbHAYCg/ltdB6EN0srfTJLUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056432; c=relaxed/simple;
	bh=ZAa8H43N9tNV0wev6/gCfq1RFPq29JfINhtmvCkDHUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Es8TfZJR/OmQH9AuDN6Qki1Va+bzd+Fkqf3eC7mVPRcAzSlGu7rAMnGhDKCuHscFQvgYT1rJksRy2/HPHfb/XTtKc7XEDq8nyQCI7dONtecmhLGW+4FN+GN5zudz3DjYbT+czYY1PEACDu8Qq6JYwyNj8rIVt45MSHMxFI0mBGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D36TpPcS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D36TpPcS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso158565e9.0
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789056429; x=1789661229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9dX7P2+0UXjBFLbwcIRVQxDJqxLq0XE6y5aklSGH0fI=;
        b=D36TpPcSqeQ/+oPFfr8OPGqkOYQPSWaqGqE/HGtybg1nEgxQO85KwI0FEl4FF713al
         lPnh+xKBF6mUc4z+N+cpZgr/q28HdQuGxUfyyJuEtS+OsNlZe1SwBMDu27xNrOP/0vZh
         yvNnWvmqP7dPsVVR6cY1lJHhjDs4XPXaTH4cMJNMGv/KZ7wD2vDxrgQEHYmndcSxcwZg
         CiLgyS5cEWFiqaoVlApo/rkmV6fZQ8LnsrD45RiHkqZUOPjtSvsRV4jtQbJ590KqQH0U
         KscNuwSNsMPcWWvVRaDA6AV91O7WC3boVqUBxF5+fkHLcSvnroxMmUphMvqbXufohurD
         skgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789056429; x=1789661229;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9dX7P2+0UXjBFLbwcIRVQxDJqxLq0XE6y5aklSGH0fI=;
        b=Aujd3bZY1TqLzxVhJu9wDssPVTIjryHlpdvbmXFeOxVAn3o4DqIUUAV91EUgrF3Tm2
         lzqZVuMgNC7o3wfNd7sGHS8SqYDt6nIDnrAY1ov1G7MAvRSUjEbKUg3C7YWLlxIt5TbI
         RLjR+QsJpKOf3VOiQ2Dpenlmnpupo6IBb1qdmMiVXaFQr1gRlUglEnPaYIZxjKpTht9i
         81LBCvwK3HI++AUfgwH+se3aDKaqKkUZm5L1CiRfSofrjLvEfTQinxzfZKpxdVj2mPm3
         yX3kty0nQmmhvj91dAPrkQ6PUEa8phdNWAd7U+Kkn4n3CfVzC1MmZ2LoRNEIYZ3XXxUR
         SU6A==
X-Forwarded-Encrypted: i=1; AKwUvBwrOfUMLhoVo5NAJHIRLIbDXaDepHOZ4nGq+uXEQErXYCHJEa0iEA7FwedtvBLJlt3bAczh8Yk=@vger.kernel.org
X-Gm-Message-State: AFuF++m7+TeeLMaehd2E1dDTtnDS8PLMS0QTQfSfzpK7YSZhooJLVnRi
	njRzi09b+4vnTFLfSLuOvcvyI62HzAko5VTFbR5F/GItsWh83A/EWbRb
X-Gm-Gg: AYBFou3Z6B+mYkIpk9pHeotvIwPl4nwtMiqs8lkj2IuOy+5bWyAcPspH+qwJO9okSGg
	ZsgtByVU/BxWrklQ9OwMYlimp8P6Sl6hXla5AbMuIBM9/iwnB94Drx6MY4UGVnfSk7CNMeUt1Vy
	rC+Apvd6vCR1AQ93s02yJKCrU9+a8oPNzAUf9QwGgO0zfU4DkHVZha1ji9ZudTQVwZLNIjv/WXp
	u9VGMfFmS8j0Xz7WbKElr2QkR14bBvQx4rj6QZuv22fWubDuzRHGtPDV/d/mmqm50p+PgBvm/fv
	PgFUFKKpC5mFG+mrBVbkitBBC25te1l3bGCcArKE+6W2znN2EXWAU6tlciDvmE7EaxTN1XCXD2d
	ZJhm/FcrAu6YtDGIOBA+mDNAhJzsDIxCrG48fZoj8FjGT5fmMQcCfAeIgiCQoP1+pGqdzcNra2O
	pp/cytRjvzWTSNeGJDWJFUntgeQ49hKKkPITYlaS9+TWFOUk6Ilh+anJQvevS9ROBTaBxmhCQwW
	f7B/aOfwHwTD84uO4IO
X-Received: by 2002:a05:600c:64c6:b0:49c:fa20:cc02 with SMTP id 5b1f17b1804b1-49cfa20ccaemr391623755e9.25.1789056427375;
        Thu, 10 Sep 2026 09:07:07 -0700 (PDT)
Received: from [192.168.178.84] ([134.19.60.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fce7a7sm304986225e9.4.2026.09.10.09.07.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2026 09:07:06 -0700 (PDT)
Message-ID: <e0d0c87a-7502-48cf-9d64-f383edbbacb9@gmail.com>
Date: Thu, 10 Sep 2026 18:07:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: apply the swapout bulk_move fix to the intended
 condition
To: Vadim Nikitushkin <bub4z0r@gmail.com>, thomas.hellstrom@linux.intel.com
Cc: ray.huang@amd.com, matthew.auld@intel.com, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, skainsworth@gmail.com, alexander.deucher@amd.com,
 bernardomagri21@gmail.com
References: <853fb020-592b-4f85-a9b5-a522aca6a29e@amd.com>
 <20260910143451.65853-1-bub4z0r@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20260910143451.65853-1-bub4z0r@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vadim,

On 9/10/26 16:34, Vadim Nikitushkin wrote:
> Commit 3db7d7d58341 ("drm/ttm: fix swapped-out resources never leaving
> their bulk_move range") landed in drm-misc-fixes with its one-line
> change applied to the wrong "if": the "if (ret)" after
> ttm_resource_try_charge() in ttm_bo_alloc_at_place() became
> "if (ret > 0)", while the "if (!ret)" after ttm_tt_swapout() in
> ttm_bo_swapout_cb() that the patch targeted was left untouched.
> 
> ttm_resource_try_charge() returns 0 or a negative error code, so with
> "ret > 0" a failed dmem cgroup charge no longer fails the allocation.
> Restore that check and apply the intended change: ttm_tt_swapout()
> returns the number of pages swapped out on success, so the bulk_move
> removal must run for ret > 0.
> 
> Fixes: 3db7d7d58341 ("drm/ttm: fix swapped-out resources never leaving their bulk_move range")
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Vadim Nikitushkin <bub4z0r@gmail.com>
> ---
> Christian, the commit in drm-misc-fixes (3db7d7d58341) ended up with the
> change applied to the try_charge condition at line 532 instead of the
> swapout one at line 1434; the resulting tree still has "if (!ret)" in
> ttm_bo_swapout_cb(). This is a fix-up on top of 3db7d7d58341 since
> drm-misc-fixes does not rebase. Sorry for the noise.

Mea culpa.

AMDs mail servers convert incoming mail to a different encoding which prevents the patch from applying cleanly (yeah everybody knows how braindead that is).

Usually I pick up patches from patchwork now, but this time I though I could apply the one liner manually.

Well long story short that didn't worked the way it should.

I've just reviewed and pushed this patch to drm-misc-fixes as well.

Thanks a lot for helping out here.

Sorry,
Christian.

> 
>  drivers/gpu/drm/ttm/ttm_bo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index a12af5b..9b85b5f 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -532,7 +532,7 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
>                 ret = ttm_resource_try_charge(bo, place, &alloc_state->charge_pool,
>                                               force_space ? &alloc_state->limit_pool
>                                                           : NULL);
> -               if (ret > 0) {
> +               if (ret) {
>                         /*
>                          * -EAGAIN means the charge failed, which we treat
>                          * like an allocation failure. Therefore, return an
> @@ -1434,7 +1434,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
> 
>         if (ttm_tt_is_populated(tt)) {
>                 ret = ttm_tt_swapout(bdev, tt, swapout_walk->gfp_flags);
> -               if (!ret) {
> +               if (ret > 0) {
>                         spin_lock(&bdev->lru_lock);
>                         ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
>                         ttm_resource_move_to_lru_tail(bo->resource);
> --
> 2.53.0
> 

