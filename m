Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710115;
	b=m+gw4rDtbdrXX80jR3/wfStoRzTiiwB+I/+krv64COx++nIKVAWPIme80zEufB2G4a/Z
	 IXiGNzJp1O73iaGgOQg2loF/yrhsMTmw5V4fjm2ObLnOsbGMj/Z5UGcdE0d6l1ZbbpAC0
	 8l2eAWbAu9KL/mBOQrgIzqD8jcBYLI+jSZG7hz+SpgQlZQKhyFBMoyFZZyN6jDFJ7Cfft
	 jKQw9NSS1XvGxI4KwW+jnywmjZ+b+S8qHdYy7m5S9oDZmbjx0IkjjzoBDLNZ3Ts79Z+A7
	 MknRVzYwgaV4oOByBDMygiHEVoYIyFIdcbMMlAGIhtua82ETsEmG9KwizO7auXq0Fcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=B+C3HRxsmw6OBtj34ACJP428vkmyaq/nQrWROm8KZkM=;
	b=i4lYGoiwqN/al5CdNbjbnKCQ9AK2M51PlQzDELdwTmIlEc0SWEOqY3IkWOHs1U5pWrUc
	 QVbZpSc09CIQu2FTKaF/QZU7U3envrN3EUi7HGEw/fOQzG61tFP+f4yvtgs9Gz3avuZLU
	 q6bSYe7B4EqyGAk857yAB8FDfx9mvjHFj9g1w6nYX9U0nzfiXxKQ3tYU+IMBrWD5bD80q
	 5KFDRwRmIp6HAueTdycPMh6dVWd0wLFo38wMW/FhEa5623YShIZrk2jRaOG1xLKr5PUwp
	 +sVVbDg/X1Wv1DDlz/1u5dIeDNArfSX9QxNh9XYspxXpxEkg60GLJSvzVbJ8oaYK+sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ursulin.net;
	spf=pass smtp.mailfrom=ursulin.net;
	dkim=pass header.d=ursulin.net header.i=@ursulin.net header.a=rsa-sha256 header.s=google header.b=W4X168YX;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A0606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A4A0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ursulin.net header.i=@ursulin.net header.a=rsa-sha256 header.s=google header.b=W4X168YX
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so6615902f8f.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1795710113; x=1796314913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B+C3HRxsmw6OBtj34ACJP428vkmyaq/nQrWROm8KZkM=;
        b=W4X168YXNDP5PdYgXjKp1aspL/8iBqvfdEjq8QKcc9pC+xuLWRAf24JhKAefMVcghc
         BcWq1+gTNpjDQI4VGdz6zlVU7srdYeg72AeB6G3v/fheMUK5xMo3rkqlCNida/We/KyN
         npw/cySRuq85uGkB+4RmdMRjbsMOvmji1D3ODT3+hxAuaS+t2/s5XNB0c+Qs89Ksjv94
         HKcA9oJY+CHEG2eV1FDI1iX/WYLy3Btu+xZsG4muxzSTX4sHGS5Kh7MpTXKHzZk20AEY
         d/f+0n52NTCIoFa7Y2WBAxgwFhdX9KdXGOTqAqnhwsAVMK2gYBa1Pzm2L+DNuyDNt98l
         NyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710113; x=1796314913;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B+C3HRxsmw6OBtj34ACJP428vkmyaq/nQrWROm8KZkM=;
        b=bYKPizv78JDPmQXbpx3tEOX1qm68Cba1EWmGK92MXk39U91SWdb3d+Rl57CkJvP6xV
         8SeoIu/DmTeex3SYDMhOeLu4R5EFzb7Hw7W2PJi0T23bxuNMRHnY6z+gLpYc5wAhGRK5
         lPYhrIIrex4gFa7QC9dVLrXbjAgBEX955YjOvMivsJf87055tcmRcs/tZ4jT4BwV+KE0
         qU/9mHAlHVve1djN9GcIox4WBup7wLoyJ1cJeT/7gfQKJR/zCNSr94W9DTlQZecZkZQJ
         er8sJodJzNUWPBs511Zniz6a96EgaoGwAXhLOGWWZJ2x7LIPZo8sZAyg7DA6migwt6CY
         l3zQ==
X-Forwarded-Encrypted: i=1; AL+hErFoH9SjDlYAd+zG2YmBLZUlqk7ZgjRkWbHkHI03LMYY+Naecte18zmnf+F9Vli4qjQkGMTjWcU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Txy1dy0WYY/PeHGtqHNKpoCMQZAThL1+hVX/H2/t8XpGoREuD
	f7xu77lDmT5nB/X+mhVRS+SrjjFE7SvAWkplE6YXp++8y+KHuG710u0YhKwUNgSoTfRmj40HsJj
	sMPnRRwQ=
X-Gm-Gg: AZFdTZfq4RG9Mx7HvHfwaLyryN8mtvD/5D3NvxycX64UprWtzSh7l8+IO7uXi//bAcZ
	dfELpG+HHVrcSgOFwpU8H1FUubaigQZTChlyyATC5TgDr3bstaC8bhvDC/2krr/IHS3gXRCSFjK
	LO7BjsIw2ZflBMlKdXkHDr2G2F3Epbh1npkA/Q+H+2SwY3lIQn3NEtIh38PdJ+Jd5AGUrmBdirW
	ytPBrY9Wp4Y6yQ3DiwD9y6YHKBJdZeo6QXZWkzZfnGfbsKbS3/362JwSTfRjkXTjAJvr1nT0MlL
	T0KaLPmGyv/epJ1bm6/aSxoeFpjOJlsGg3zMNOHtbc7rL/Mk6YzvRYR+uTOygvPUbl0fNl0QoxZ
	T6IEFswb3uWjuo76Nmy1PdDDyLsC+L4/SVAoWqKObvpFpSToE8+A8uBJex79ZIJEDZvyTujRRIl
	FRtkMGPxhpYBMm7BPuYOFYrMQtGcEs+XLS0rdeLoewb05IpBHIGx0/2ruL7xH9mFgbpkneCZyNZ
	yA85tS9aEsBfqDw6iHHeigA0fsIt++22HWH2ZkXuo7VLc/N0hg9DnWwuKxM3T3QFUxJ8gkINQkB
	O3IZ+Z4KrcZCR3YkNs73ZKqvy/e7g8DHKLLzTxAD+WjhZg==
X-Received: by 2002:a05:600c:3ba9:b0:4a2:1050:aff with SMTP id 5b1f17b1804b1-4bb8881c741mr502941925e9.6.1795710113237;
        Thu, 26 Nov 2026 08:21:53 -0800 (PST)
Received: from [192.168.0.116] ([81.79.79.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm574182015e9.2.2026.11.26.08.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 08:21:52 -0800 (PST)
Message-ID: <31feca61-7439-4006-91f3-2dedb3dca27a@ursulin.net>
Date: Thu, 26 Nov 2026 16:21:52 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915: Reject relocation writes to RO userptr
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>
Cc: Zakaria Belkadi <zakaria.belkadi@inria.fr>, stable@vger.kernel.org,
 Matthew Auld <matthew.william.auld@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20261126094444.52858-1-joonas.lahtinen@linux.intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20261126094444.52858-1-joonas.lahtinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 26/11/2026 09:44, Joonas Lahtinen wrote:
> Read-only userptr BOs shouldn't be allowed to have relocation
> addresses written back to them. Enforce that.
> 
> The relocation slow path where this could have happened has been
> in place, reverted and then re-introduced. GPU relocations path
> protected against this via ppGTT flags was also reverted at point.
> 
> There's no legimate use-case for this, so instead of trying to track
> which kernel versions were impacted and which not, just outright
> reject with EFAULT on all kernels with RO userptr support.
> 
> Reported-by: Zakaria Belkadi <zakaria.belkadi@inria.fr>
> Fixes: 0b100760e3e8 ("drm/i915/userptr: Enable read-only support on gen8+")
> Cc: <stable@vger.kernel.org> # v4.19+
> Cc: Matthew Auld <matthew.william.auld@gmail.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> index c41e1b9a40bc..7ed23dc392b8 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -511,6 +511,10 @@ eb_validate_vma(struct i915_execbuffer *eb,
>   	if (unlikely(entry->flags & eb->invalid_flags))
>   		return -EINVAL;
>   
> +	if (unlikely(i915_gem_object_is_readonly(vma->obj) &&
> +		     entry->relocation_count))
> +		return -EFAULT;
> +
>   	if (unlikely(entry->alignment &&
>   		     !is_power_of_2_u64(entry->alignment)))
>   		return -EINVAL;

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

