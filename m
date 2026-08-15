Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876761E5714;
	Sat, 15 Aug 2026 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786806985; cv=none; b=o0OxofXoDLqILd3ewnlvpdqEcHucxltX2psxzsJacVJFZL2tLst5pUSFbZWFMYxxeNE3r+ORVCdevoSn/YrpfOLuuHZ3/F7yscJUa3/C5Wng0y2bYDARKVzV4NxNgwzASQADnE9zRUh5vQF54uwlZRO9IhPuFd9qctQm1Y0e/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786806985; c=relaxed/simple;
	bh=F9QYqbsvZf5/ggz0FlN8Lv+AnzqjwMRDM5S8vsuV9II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gg45f3wR8ocUSepSAbVPUecQBX+2zWw+T2zeeuPvPylAt2qu7cWhrnJL/NfKD9XivbcaAHzGCbApifw6l4xKI47a3PNIk08APEslfhr8O8EGtq/yhGJ78/bzuulhBPv8hLdaNRV4cythco/UhE5oFv2BZCPipLZ0IOKGuoNr2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ooKve6ri; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ooKve6ri"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=BT1PQRgDY6LsRJiLr0BOvEd+PSiUcaqmtoLoKVWWQ6E=; b=ooKve6ri/QK+c03MvnxJjjDdDl
	y8pXvKChogq2FLD7tn3owbB3/2dU+wauO0AqpN6hQSkf4OwDKa0TtNzmOwk20aTNGxsHTgKktnQWv
	SyzeackmQoLiR73lobIjLeqxEyIx2xpyuOAqTDyvXL2gt2NO4nPCg14HOy+r4T6WFy0ClGyn6ESpS
	5l1tdan/lPoAy3M03pKFcyO+DlLJaFA1fT2ZqNzLwKdP7RNl9RgJBrh3jAJMKwllKdms6L0DBERbY
	Lnz5T30IDW0rkoABUC4nyTLCQLAme7r8wx8eHccFqTiKalFaZnUAjur/Ws9sco16pbOB87+cUzAR2
	3fsDXKyw==;
Received: from [179.105.94.163] (helo=[192.168.0.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wvG6z-002cBY-G8; Sat, 15 Aug 2026 17:15:53 +0200
Message-ID: <cdfaab3c-89b4-470b-aae4-d16f7aaf18ea@igalia.com>
Date: Sat, 15 Aug 2026 12:15:46 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: Fix NULL pointer dereference in CPU job cleanup
To: Karl Mehltretter <kmehltretter@gmail.com>, Melissa Wen <mwen@igalia.com>
Cc: Iago Toral Quiroga <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260815145914.84154-1-kmehltretter@gmail.com>
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
In-Reply-To: <20260815145914.84154-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Karl,

Thank you for your contribution! Unfortunately, this issue is already
addressed in drm-misc-next.

Best regards,
- Maíra

On 15/08/26 11:59, Karl Mehltretter wrote:
> v3d_submit_cpu_ioctl() allocates cpu_job before initializing its embedded
> drm_sched_job. If extension parsing fails, no CPU job extension is
> supplied, or the BO count is invalid, it jumps to fail before
> v3d_job_init().
> v3d_job_cleanup() then calls drm_sched_job_cleanup() with a NULL s_fence,
> causing a NULL pointer dereference.
> 
> An empty DRM_IOCTL_V3D_SUBMIT_CPU (flags == 0) is sufficient to trigger it.
> 
> Deallocate the job and clear the pointer on these paths, matching the
> existing handling when v3d_job_init() fails.
> 
> v3d_job_deallocate() frees only the top-level job. If extension parsing
> already allocated query or indirect-CSD state, that state still leaks on
> these error paths, turning the former oops into a repeatable leak.
> Fixing this safely is more involved and beyond the scope of this fix. This
> patch therefore addresses only the crash.
> 
> Fixes: aafc1a2bea674 ("drm/v3d: Add a CPU job submission")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Tested on a Raspberry Pi 400: the unpatched kernel oopses on flags=0; with
> this patch the ioctl returns -EINVAL without an oops.
> 
>   drivers/gpu/drm/v3d/v3d_submit.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index 7682b24f13ec5..304950ba42a38 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -1313,6 +1313,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
>   		ret = v3d_get_extensions(file_priv, args->extensions, &se, cpu_job);
>   		if (ret) {
>   			drm_dbg(dev, "Failed to get extensions.\n");
> +			v3d_job_deallocate((void *)&cpu_job);
>   			goto fail;
>   		}
>   	}
> @@ -1321,12 +1322,14 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
>   	if (!cpu_job->job_type) {
>   		drm_dbg(dev, "CPU job must have a CPU job user extension.\n");
>   		ret = -EINVAL;
> +		v3d_job_deallocate((void *)&cpu_job);
>   		goto fail;
>   	}
>   
>   	if (args->bo_handle_count != cpu_job_bo_handle_count[cpu_job->job_type]) {
>   		drm_dbg(dev, "This CPU job was not submitted with the proper number of BOs.\n");
>   		ret = -EINVAL;
> +		v3d_job_deallocate((void *)&cpu_job);
>   		goto fail;
>   	}
>   

