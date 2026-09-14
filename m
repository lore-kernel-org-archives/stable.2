Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74624908BE;
	Mon, 14 Sep 2026 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789407311; cv=none; b=Dhbv1+aO5pRugs9TFkJUV2VG+fY1wHIt+t6IY907HoQI+hPxNDNqe9RrvdMH/V3aBjLPFWRpGO5e4mXCHsj36Ik4arMSr/lcjEnTLFu60KvZM1Im/zHVypq/VSnPCupIkbowaJ5zp0T/UGfHEJbmaOYthAzNXDpb4CbT2SRDJEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789407311; c=relaxed/simple;
	bh=yA0xjPmbWso9PL4zhMVJecfESEqBadcWXFQAEM8YhAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEv78vV3Vo4xuUQfabAX+0D1yLZ1jggwFCkoQi0JZgulZRfFJoicLyFZT2gJO47nmUWHUSWN0GzMnrfwueobSrRrHDJDtskqaSKXAi5VxzlNkMYqKHsXRuGcYoaoJIHeLgE97d2hRXrytOc9tZ/vYAvORf+qYE3wNhZByqtvo18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sY3vF3wP; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sY3vF3wP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=qDVSXqIm/ZZ7NqZ7O46ll556+WfE6c0OGZaZTBmNtws=; b=sY3vF3wPMfV24E7Dcni58ZXMe3
	ibRgguOwwLQcKEQ9HKgwLdG1ruIx/1aKEdVd8inZyLeSRuR7x3TuLWHJ8DRgJcZI4Nj/fZgvcq54q
	9iKpAyphvZsmC/48vIGUoVX5yBZrOfwsP6VD8wZseeqKt08rHwEzDZPTRy4xrWDvBURku0FBVCjVg
	7dQkU6P+t2WBudH700oWI7gb9iI8lxXDcMp6Voa52PeMMmcus6Iu63I6H/kHw0id++gY9cE1AdfHe
	5BCRkTk1MbfSj/W+j7m1LQeDmDyu+11lB+sf029bSaUWOFVtp7F3YhVSi8bZgI10O4+UlRcW9iDj/
	fqigvzsw==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x6AZt-00214e-Ga; Mon, 14 Sep 2026 19:34:49 +0200
Message-ID: <c1388b5f-9077-4161-8fd8-3b8ebf24fbde@igalia.com>
Date: Mon, 14 Sep 2026 14:34:41 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vc4: Hold a GEM reference while purging userspace BOs
To: Kazuki Hanai <hnkz.64@gmail.com>, mripard@kernel.org,
 dave.stevenson@raspberrypi.com
Cc: kernel-list@raspberrypi.com, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, eric@anholt.net,
 bbrezillon@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260830130700.680041-1-hnkz.64@gmail.com>
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
In-Reply-To: <20260830130700.680041-1-hnkz.64@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kazuki,

On 30/08/26 10:07, Kazuki Hanai wrote:
> vc4_bo_userspace_cache_purge() removes a BO from the purgeable list and
> then drops the list lock before taking the BO madvise lock. A concurrent
> final GEM put can therefore release the BO while the purge path still
> holds only a raw pointer.
> 
> Acquire a non-zero GEM reference while the purgeable list lock still
> protects the lookup. If final release has already started, drop the list
> lock so the release path can remove the entry and retry. Put the temporary
> reference after dropping the madvise lock to avoid recursing into final
> release while that lock is held.
> 
> Fixes: b9f19259b84d ("drm/vc4: Add the DRM_IOCTL_VC4_GEM_MADVISE ioctl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
> ---
>   drivers/gpu/drm/vc4/vc4_bo.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
> index 49ea2ed0996b4..5289e69f3345f 100644
> --- a/drivers/gpu/drm/vc4/vc4_bo.c
> +++ b/drivers/gpu/drm/vc4/vc4_bo.c
> @@ -319,6 +319,19 @@ static void vc4_bo_userspace_cache_purge(struct drm_device *dev)
>   		struct drm_gem_object *obj = &bo->base.base;
>   		size_t purged_size = 0;
>   
> +		/*
> +		 * The last GEM reference can be dropped concurrently. Its free
> +		 * callback removes the BO from this list before releasing it, so
> +		 * the list lock makes an unless-zero get safe. Never carry only a
> +		 * raw list pointer across the lock drop below.
> +		 */
> +		if (!kref_get_unless_zero(&obj->refcount)) {
> +			mutex_unlock(&vc4->purgeable.lock);
> +			cond_resched();
> +			mutex_lock(&vc4->purgeable.lock);
> +			continue;
> +		}

Hum, your fix doesn't look correct to me. First, I don't understand why
you are using something like cond_resched() here. Next, with this
approach, the BO with refcount=0 will never be removed from the list.

> +
>   		vc4_bo_remove_from_purgeable_pool_locked(bo);

What you could do instead is calling:

if (!kref_get_unless_zero(&obj->refcount))
       continue;

here.

Best regards,
- Maíra

>   
>   		/* Release the purgeable lock while we're purging the BO so
> @@ -345,6 +358,7 @@ static void vc4_bo_userspace_cache_purge(struct drm_device *dev)
>   			vc4_bo_purge(obj);
>   		}
>   		mutex_unlock(&bo->madv_lock);
> +		drm_gem_object_put(obj);
>   		mutex_lock(&vc4->purgeable.lock);
>   
>   		if (purged_size) {

