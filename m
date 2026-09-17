Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765764973A4
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658111; cv=none; b=Va5tLcaHhi8x3LOrKUDJPbfxw1BXQ7lRb2OyLl6wAlsOYkwmgMbvFsRZEQ/xxrFn8lULs2HUKx4eANFPqr8ewhv5o/xt56JYRbf7gd8Z30s8McxZAo593nwy2nM1tEXJ0wtbYI70fOLdjK5YFZMu76dgC9qI0m3uavJZrxCfECQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658111; c=relaxed/simple;
	bh=lj1AArdURKntw/KnF8ugndUqAFz8UXcJI2HmidLS8Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKB8/hurUWmo1LaAQzfhvFW29E3wm7fO1TvIFDJGwySfWAmwlX/cTu9fw6N0ZQeo6o7aSyfvlZkuzmdqvobFsU3MmRtQBQikhyD3wxCTyw8frVk/S2canwVwZlP3vxtwXohOP74UBP2V36UAhM7BvrU1IGk/2XX7QcOv/BiodUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6flIGCj; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6flIGCj"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so852473a91.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789658105; x=1790262905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UlhivK+zlFu4a3uy9GJIwu4Lv0iGdPKrQsjr7JexLOk=;
        b=O6flIGCj9rp24USOjCztpgIJePjlgnwlN8C5DvBkzvIBEKVxVT03prxyQXioWoRk6q
         LHXkmZ/cMLYUhmVJkr/9KxlBGmM9sV2eyyX7pAt8w2GM3KcQ/nJmEImRZxGs4/pRqVzN
         NmpSv6HmEIRENo2jQ0QdgeSVDJDJtlnFYqz4rW30tFRxP/tSb9tQ1zGnmCnvnLa9IhhC
         OHorTofhHEC3Szg9AeosrOMiJn6XHTCyqgvWPTvm71U/SUjM28plNuFUvytsrQeMKmJV
         9lV+XkiXhRDG3e1J+biR3ZCjqOBdeQwVqzZ+JRA5L0TAPfxp9xum1EEpEaxaw1xUaJ0x
         4uzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789658105; x=1790262905;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UlhivK+zlFu4a3uy9GJIwu4Lv0iGdPKrQsjr7JexLOk=;
        b=QnaRuAyIMElzVmH14VxFUv8XpVmlw/zcniYsP27EuwFk9Q8kXxNCBT8cMsxvKse5+X
         yurduyy9tcxZgOONWwF7KJp00mxnZrRaVJYTN5VJUqJPeNLNf0ALvw7XbnNMqpsnMvCA
         KZCuSRnNHlr1fDkUb4LaYmLRzYBbzDYo2xoHiY0VCD3SvRZRnejWdzMfCFZ5pLF8V7S1
         ENcDim2dFE4xYGdles7ii//nRH2DP803EaPnfl+00ZVzwLbVSDKV0o3WruJw1VQG2pFC
         4bubYd8JvH432Hb9Fb+tMWguTlq6tukVyhXf2xKLazxgX4uJ5LTl4QxIJ1m9DcLpGzkz
         Rx9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzshjzlctraaR57pXccJeke3aSqAFhSEFkaF4UvvqQw0cHR6c7yjPLPLFrf5vARlLnEe9V5cYA=@vger.kernel.org
X-Gm-Message-State: AFuF++muaEC/Eh7UWOOg6rz4lIsIfOXJIJua9frl3qfdkPAo1JUPm/0V
	7wqsXq+lmc4eyk93T9lMmJz05/Vh3SgrD+mE9ATYMQyuKoPLSP7+NdbT
X-Gm-Gg: AYBFou0cWt49z+YdljaVSQduCl84gqrwI+jIaFnR8jcWkmZCK8AGtNVwzJwFFETjQkp
	enTe8zYTKrla3fVao7Uggyfi9D7f5QwMvy8bqiHYF9FFQGUJvyPnnEfSpl0BTHJEuGsV0fQUrxu
	q+Iak92ZEi+B32pXo/sygsYdbqbb6jM9MloZsRJBSIyoUMUaEx+KND8KNm1n0vgUYMvPBXUqg77
	C+C/ialTWr/STPVQe/TlQLAfSlNKS9+ky6CMUwJrfoky3krk27CRXIKhMCDRNtUFb6Xtt2LX8sL
	U/iklpiKilBaCEGZRMaxU0Um7qEixdQ5hpAKYu9jFNi15KxotK1neCYfhdBao+qqZUaGWBO655h
	jsGapmIkdZC2dNkFEL6XeAjuKh9k2q5S+dzk25reoEHasTAp5U4DINPZP/vEvwutsi6K5o8YhYs
	RoJ/OKpgcadoNNeNuyEzHHZvHOlaZCvHlf+dULIU3/0d5IgaYWG3LICOpni7hZbS3vIEazqoy/O
	RKIFKrgdDexcDmwMQa0NE5F4se9x21X4lm5LnBo
X-Received: by 2002:a17:90b:3f4f:b0:39e:4c97:ce06 with SMTP id 98e67ed59e1d1-39e4c97cf1bmr761796a91.39.1789658105113;
        Thu, 17 Sep 2026 08:15:05 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:48d2:6852:2cc5:a7b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5af6593sm15799800eec.25.2026.09.17.08.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:15:04 -0700 (PDT)
Date: Thu, 17 Sep 2026 08:15:01 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: dudl@cypress.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Input: cyapa - fix runtime PM leak in
 cyapa_update_rt_suspend_scanrate()
Message-ID: <aqwD1o6J4svIevWW@google.com>
References: <20260916185015.2093520-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916185015.2093520-1-vulab@iscas.ac.cn>

Hi Wentao,

On Wed, Sep 16, 2026 at 06:50:15PM +0000, Wentao Liang wrote:
> pm_runtime_get_sync() unconditionally increments the runtime PM usage
> counter. If mutex_lock_interruptible() is interrupted, the function
> returns without dropping that reference. Add the missing
> pm_runtime_put_sync_autosuspend() call on the error path.
> 
> Fixes: 672865080a8f ("Input: cyapa - add runtime power management support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/input/mouse/cyapa.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
> index 6e0d956617a1..5edf4fdbb373 100644
> --- a/drivers/input/mouse/cyapa.c
> +++ b/drivers/input/mouse/cyapa.c
> @@ -901,8 +901,10 @@ static ssize_t cyapa_update_rt_suspend_scanrate(struct device *dev,
>  	pm_runtime_get_sync(dev);
>  
>  	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
> -	if (error)
> +	if (error) {
> +		pm_runtime_put_sync_autosuspend(dev);

Why does it have to be "sync" variant?

Thanks.

-- 
Dmitry
