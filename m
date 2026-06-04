Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6C32FFDD6
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585117; cv=none; b=KbmTUpVF4+fk7eEpYsrUpSwKkr6gdVwvnXX/W5EZicYv9iB0dRk41YhmVVjgefcwOUrTcTs2/Cx+KDdZ+xFbpJaOdYlhlniHcm5NPkoFtqol+6xOYvEqhwgCEIS2zrC4Ls6S/ILc9El/YYNf6rReGkrUFaRsqrbgvkSSK8nLHZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585117; c=relaxed/simple;
	bh=ho3mFtENVxPp81Nr4w7HlLYKVzcAggMZjvbU/Fe6ntQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/smdndEVcS8JZ319sar3+bP5r+fcPe160sp9CijENVa6aP1wyFCIN9EWv9tkn4rrr2jXyFg1SfNdiBr2YoHe59j3Ezj9Wc9RZ9weR9XAjBE3CZTKtsJKhSSBYASZZWC9L0qDErPU8tpyXYdjjq0jef73B8UNMiSZ+5qtSRzy18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qMXD7kD1; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qMXD7kD1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j7fxTOrqGGU4wTlAGC+uGWS2Ojx6JI0WmyJBDwJN/xo=; b=qMXD7kD1BEU//9abjjCr3kVJaE
	xBl9ebUoGRUSUQNdO3OtZavUWfqa6azdHov16ijaTPOYptL/oCcBXWJEafxCdSns9BcLpACB2EDtM
	88+KyyX7bKKNEMKhFcVw1aCWA+IKtEVd4WXspUZA0OVdMqyzVokWjGSWtvc2clntZ9Ig8jKE1pIR3
	WH8oVBOzbNvIMHIjSqZMnuhrGvfS275gMtdYHsyGAL8xz0eO2oSGJYG2O8c7qrE0/bSRW+TzVN7uj
	wdKW0uHYviu+cbjSYI9VZMMPZZ8VkXGE9PojBxEGiE6LFYasGCfhC4jJiLAutmMPnutab3e7mP1Ix
	8LxitHkg==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wV9Wg-00CgMr-2z; Thu, 04 Jun 2026 16:58:30 +0200
Message-ID: <f3ed61d4-fcdb-41f4-b64b-ecf81a1ff8d0@igalia.com>
Date: Thu, 4 Jun 2026 11:58:25 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/v3d: Fix global performance monitor reference
 counting
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
References: <20260531-v3d-perfmon-lifetime-v2-0-60ed4485a203@igalia.com>
 <20260531-v3d-perfmon-lifetime-v2-1-60ed4485a203@igalia.com>
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
In-Reply-To: <20260531-v3d-perfmon-lifetime-v2-1-60ed4485a203@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/05/26 17:18, Maíra Canal wrote:
> In the SET_GLOBAL ioctl, v3d_perfmon_find() bumps the reference count on
> the perfmon it returns, but v3d_perfmon_set_global_ioctl() and
> v3d_perfmon_delete() fail to release that reference on several paths:
> 
>    1. v3d_perfmon_set_global_ioctl() leaks the reference on its error
>       paths.
> 
>    2. CLEAR_GLOBAL leaks both the find reference and the reference
>       previously stashed in v3d->global_perfmon by the SET_GLOBAL ioctl
>       that configured it.
> 
>    3. Destroying a perfmon that is the current global perfmon leaks the
>       reference stashed by the SET_GLOBAL ioctl.
> 
> Release each of these references explicitly.
> 
> Cc: stable@vger.kernel.org
> Fixes: c6eabbab359c ("drm/v3d: Add DRM_IOCTL_V3D_PERFMON_SET_GLOBAL")
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/v3d/v3d_perfmon.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 

Applied to drm/misc/kernel.git (drm-misc-fixes).

The rest of the patches must to wait for its dependencies to land.

Thanks for the review, Iago!

Best Regards,
- Maíra

