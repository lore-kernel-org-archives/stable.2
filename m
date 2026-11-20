Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180874;
	b=oK0mpgNL/UTZNHhtVfzs3nPmFud1s3HbrvFl97auA5M+Fi6tGbITJWC00+cvYLEb3oir
	 Bd7G/RwwXG+d2WChMqWq+nPkIra6xUShzXAFu2zWVU/8pC86shmymYow4SSkEWNUf9bTQ
	 XQrOXefi8qTroaB7nlyrSamqtJl1KUzklcauGf3S+eCHwqdQ9/k5U4oMCebMTcq0s86ky
	 DapaOHhNuMrydfb2TvkLY11KQKxPMIWhX14dMUvQ/Gk+qJnzuclalYraw4/gHGRHHpxol
	 HNYrsrGGat5czcLImRYWU/PLh58cnCXKC/vwi/M2n+RvWKb9AJbkGsHNDYn4Z3Ygu8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180874;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=FD8qNqxuGkw2ONxsf6uof1ejRB1r6IPhsvDKJD5h66E=;
	b=K89EJ2vdAta/z19ukDYgw4Qyorh3a8qNeJR0UQRkqgZJkUt/Rod0CAa52wtM7dMuOJzO
	 lgrFo4nQLz8IwT1fmtCiGKbvnzubvZ+a42jKqBmJSyMnMvo3FLAScmwM7E0NVZ9bKOH7+
	 lkvpY79e19FyjjczA6GJtfpBVjj3H6AIPOID2tig7lSWvfqUHQO2wLGRfptkxZH4ecikE
	 A3lQydrTGm9T9hCXbnBHIMVQwc+BSivf+6IYxMd9HHkrnUJ0UH8wnvt6qmc3BijbfY3Bc
	 g7yXP983Ag2SaoAKr7qEM0OHwUw6/cQWbwwwFbUjyOuErphbpCzMIsY1z0Y3Rkinj4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=EuWXO8CH;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9B260A2600;
	Fri, 20 Nov 2026 13:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A9B260A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=EuWXO8CH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=FD8qNqxuGkw2ONxsf6uof1ejRB1r6IPhsvDKJD5h66E=; t=1795180871; x=2110540871; 
	b=EuWXO8CHGdI6Q64CZWPMcj0PtP5edRe1NR/uGcRMfz50j1yGoAEmPdVYtiofbCt2K04mK33U41g
	NGxkMl5/s/vOnGxC/9Zo7DbBD526cRf3OKZ2kovgOQWR0Zvctq5dXNtRpDdFeOo61RFz59Y2Hx98K
	JQEJBqZ6cvm6RT7XtDCmzpCSapop3K7vHoSy7laNgXGvF/D2giiJQZVPJTTN8Sc6CKEMkwPuJtQDC
	P+tNPlbr6qQYH/t9wYhBmJsp2lT+41PBLgRIlsVfxiis5tKvryQrd32VGMdG5dW+7EcN8y3rwGF6V
	vCE/FhGPpEPILpFD1M1FNViP0KSX5j63P37g==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xUOY8-00000001siW-2MMt;
	Fri, 20 Nov 2026 14:21:08 +0100
Message-ID: <76156131-651d-450e-ad0d-f29ab8b0aa7f@igalia.com>
Date: Fri, 20 Nov 2026 10:21:04 -0300
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
Subject: Re: [PATCH] drm/v3d: Don't free the core's sg_table when PRIME import
 fails
To: Roy <rongh7426@gmail.com>, mwen@igalia.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261120115840.417741-1-rongh7426@gmail.com>
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
In-Reply-To: <20261120115840.417741-1-rongh7426@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Roy,

This is a duplicate of [1].

[1] 
https://lore.kernel.org/dri-devel/20261119144339.43896-1-tsbol@icloud.com/

Best regards,
- Maíra

On 20/11/26 08:58, Roy wrote:
> When v3d_bo_create_finish() fails in v3d_prime_import_sg_table(), for
> example with -ENOSPC because the V3D address space is full, the object
> is freed with drm_gem_shmem_free(). At that point obj->import_attach is
> not set yet, since drm_gem_prime_import_dev() only sets it after the
> driver callback returns. drm_gem_shmem_release() therefore takes the
> non-imported path and treats shmem->sgt as its own: it unmaps it with
> the V3D device, calls sg_free_table() and kfree()s it.
> 
> That sg_table belongs to drm_gem_prime_import_dev(), which then unmaps
> it again through dma_buf_unmap_attachment_unlocked() on its fail_unmap
> path. The exporter's unmap runs on the freed table, and the kernel
> crashes:
> 
>    Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
>    pc : dma_direct_unmap_sg+0x84/0x260
>    lr : dma_unmap_sg_attrs+0x60/0x148
>    Call trace:
>     dma_direct_unmap_sg+0x84/0x260 (P)
>     dma_unmap_sg_attrs+0x60/0x148
>     drm_gem_unmap_dma_buf+0x38/0x68 [drm]
>     dma_buf_unmap_attachment+0x3c/0xa0
>     dma_buf_unmap_attachment_unlocked+0x58/0x98
>     drm_gem_prime_import_dev+0x1a0/0x1e0 [drm]
>     drm_gem_prime_fd_to_handle+0x1a8/0x280 [drm]
>     drm_prime_fd_to_handle_ioctl+0x40/0x58 [drm]
> 
> Users have hit this on Raspberry Pi 5 with Xorg importing vc4 buffers
> into v3d.
> 
> Clear shmem->sgt before freeing the object, so that only the PRIME core
> unmaps it.
> 
> Tested on a Raspberry Pi 5 running 6.18.39 with a small program that
> exports a vc4 dumb buffer, fills the V3D address space with BOs until
> creation fails with -ENOSPC, then imports the dma-buf into v3d. Without
> this patch the import oopses as above. With it, the import fails
> cleanly with -ENOSPC (60 runs), BO stats stay at zero, and imports
> succeed again once BOs are freed. The fix was tested as an out-of-tree
> v3d module built against 6.18.39; this tree was not built for arm64.
> 
> The bug was found and the fix written with the help of an AI coding
> assistant (Claude); I reproduced and tested it on hardware and reviewed
> the change.
> 
> Fixes: 40609d4820b2 ("drm/v3d: Use the new shmem helpers to reduce driver boilerplate.")
> Cc: stable@vger.kernel.org
> Link: https://github.com/raspberrypi/linux/issues/7504
> Signed-off-by: Roy <rongh7426@gmail.com>
> ---
>   drivers/gpu/drm/v3d/v3d_bo.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
> index db95a2f..d0b672d 100644
> --- a/drivers/gpu/drm/v3d/v3d_bo.c
> +++ b/drivers/gpu/drm/v3d/v3d_bo.c
> @@ -185,6 +185,13 @@ v3d_prime_import_sg_table(struct drm_device *dev,
>   
>   	ret = v3d_bo_create_finish(obj);
>   	if (ret) {
> +		/*
> +		 * The sg_table still belongs to drm_gem_prime_import_dev(),
> +		 * which unmaps it when we return an error. import_attach is
> +		 * not set yet, so drm_gem_shmem_free() would otherwise unmap
> +		 * and free it as if it were ours.
> +		 */
> +		to_v3d_bo(obj)->base.sgt = NULL;
>   		drm_gem_shmem_free(&to_v3d_bo(obj)->base);
>   		return ERR_PTR(ret);
>   	}

