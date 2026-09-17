Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16420411FAE;
	Thu, 17 Sep 2026 20:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678675; cv=none; b=u0i64EBqJ7uNjl5ShFptldd3ywlZ6P/Nr30BYqc9ISMCCIgHItuk2lgNvEr6pC3MoYlwZCzfKeIj8j6HmbelFd8QLdJTob8UwoB+LzXYvZnanlQlFAIUHQwS3W+4czoiAtrP3UyF2JIs56TCGC3QqA9ayGEv3oQlPs2iYi9geJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678675; c=relaxed/simple;
	bh=m9Eqjq+uWpQw4y6MM5sDSwcNiErvUajNUqfCbK5xGEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bS42/15iNxvOVey2mF4C2tCUMs0N2dAyFoUrOZ0qo0WOwO8CY/Wmxg5b8R8bWzVhcbu/IR757C2qTS2nnoyiYLwv1EKQZLRNnUaoAQAXQnqwLFL7Jo+SNUNQ+MufY0CPiN1/vrL7VYX8mxesDK4GS64scXyg2ljikmeqZ+8fl90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EYpAifWm; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EYpAifWm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=ZjCkgmfnhsr/nRvgJrfgsAtyK/FU0kzhYD9tqIxNJHc=; b=EYpAifWmPhZbrYASxGj3nPTZbf
	YDnpBq5yJx6NSwLFO/irqjcLAdwZ2+utaODd8dzZZ0tPMyAf6Z8Xq9k4hrydRnUi5FnH2YcHUJVL3
	EqglfTr3w8y7M4Q9Th5WFVsmilF43Zt0yf7n268BPpCkm9xr4hgQBxGQQxRXIui97GDwQpCT7nDvz
	zyCiJMMQCSULW+hOIaSy58hJsIhUeNj8U129nT1fVus1sL2VFcM1Bj+HEgTTY0yN/HPDzE30bh22X
	AaqhoA9MpkKeVTjGw3138C1MWjXy9dlauIws6HngKqEO04DwJ9EcL5TX9/QsVkhDBfx6xAddhO4Ac
	bkGUbI9A==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x7JAt-003eL1-W4; Thu, 17 Sep 2026 22:57:44 +0200
Message-ID: <7bd0f461-1b1d-416e-a68c-c0389b04f325@igalia.com>
Date: Thu, 17 Sep 2026 17:57:39 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: Fix perfmon reference leak in
 v3d_perfmon_set_global_ioctl()
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@gmail.com
Cc: cgmeiner@igalia.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, mwen@igalia.com, simona@ffwll.ch, tzimmermann@suse.de,
 stable@vger.kernel.org
References: <20260916183100.2092174-1-vulab@iscas.ac.cn>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20260916183100.2092174-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Wentao,

On 16/09/26 15:31, Wentao Liang wrote:
> v3d_perfmon_find() takes a reference to the perfmon which the ioctl
> transfers to the global pointer on success.  The error paths are
> missing this transfer: clearing the global perfmon while none is set,
> and setting a global perfmon when one is already configured both
> return without dropping the reference.  Release it on both paths.
> 
> Fixes: c6eabbab359c ("drm/v3d: Add DRM_IOCTL_V3D_PERFMON_SET_GLOBAL")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Already addressed in [1].

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6bf7e2affc6e62da7add393d7f352d4040f5bc27

Best regards,
- Maíra

> ---
>   drivers/gpu/drm/v3d/v3d_perfmon.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
> index 8e0249580bba..12bb1b087fa9 100644
> --- a/drivers/gpu/drm/v3d/v3d_perfmon.c
> +++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
> @@ -461,16 +461,20 @@ int v3d_perfmon_set_global_ioctl(struct drm_device *dev, void *data,
>   
>   	/* If the request is to clear the global performance monitor */
>   	if (req->flags & DRM_V3D_PERFMON_CLEAR_GLOBAL) {
> -		if (!v3d->global_perfmon)
> +		if (!v3d->global_perfmon) {
> +			v3d_perfmon_put(perfmon);
>   			return -EINVAL;
> +		}
>   
>   		xchg(&v3d->global_perfmon, NULL);
>   
>   		return 0;
>   	}
>   
> -	if (cmpxchg(&v3d->global_perfmon, NULL, perfmon))
> +	if (cmpxchg(&v3d->global_perfmon, NULL, perfmon)) {
> +		v3d_perfmon_put(perfmon);
>   		return -EBUSY;
> +	}
>   
>   	return 0;
>   }

