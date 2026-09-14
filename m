Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7764963D1;
	Mon, 14 Sep 2026 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408351; cv=none; b=TynkmEHAIf0R0ppK6XfnNwYQvlGD1MabGociG4sGHc4Homr93F5vSbSsruCsI3GjTvQlY7sqn3gRIoQxc2sVM4s7kWbNL7CoL6oHCaAQCrzlzi8AHXaGTeFt7zNrfb5W32yQZLImPEZOtDDUBsFf7r73H1UCTTn4R3gy7+hIP6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408351; c=relaxed/simple;
	bh=hIGCNT+2LZvL+KWuscB/Q2xFWBHXWCB/eXAyk2v9S9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAP40uT5ma+OmgSVHqAaao/+Bcv3KSiAZh7fGP7rg9hxK3GCXy0XV9tPL76ocmgGKFzqdl6VsC8nvZ2w46wQ0Fuo5KMyakrC0Mh82ObBSP2gYH7KvSZrEPoWzTmsvEZgs7xzbfsWAKeP13wQnUYEgZZEqajNNUagsdV4eR51uXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jzDmawAY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jzDmawAY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=R10hLRJV2usgexCzt27YZIdBumqvqsGh1RvG2sVwRR0=; b=jzDmawAYsN8mzxGnJepLG0vZJ3
	+UyEBewVq7wgQBY7gwIbWS/DBITpIm7O3gfDYQPn9iJJ5ii24Jl0zafskVj0/ta58HSUS32hk3Owl
	EWRM7pJZksJrj6TSGEak97OX9veG13EAvACQKp/lYQJdOneHaQjxGyhtSHcSOXQE+0u3TlnSC8Y88
	mp11V1+dMtZPFUX72tldyUiwCbAjymuYK3lvUPh8BOUTOcPpZJAJIUZBsnOQK3agt48WuSLZNYS+y
	To4v22lwl8zNQ5kmkH/6lUmRiQr5oSxMgo3sNe99A1QHrcH4oqppBxZ5oTe/lo2LI653lilT0p19o
	yjoeISYA==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x6Aqb-0021Rz-Sy; Mon, 14 Sep 2026 19:52:05 +0200
Message-ID: <b8239f0d-e5cb-459e-8ef9-d7691bfc2441@igalia.com>
Date: Mon, 14 Sep 2026 14:51:58 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vc4: drain the hangcheck timer and works on V3D
 unbind
To: Fan Wu <fanwu01@zju.edu.cn>, mripard@kernel.org
Cc: dave.stevenson@raspberrypi.com, kernel-list@raspberrypi.com,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, eric@anholt.net, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260909053509.657074-1-fanwu01@zju.edu.cn>
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
In-Reply-To: <20260909053509.657074-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Fan Wu,

On 09/09/26 02:35, Fan Wu wrote:
> The hangcheck timer, which every submitted job arms and which queues
> reset_work once a job stops making progress, and the job_done_work,
> which the render-done interrupt queues to release completed jobs, are
> never drained at teardown: vc4_irq_disable() cancels only
> overflow_mem_work, and vc4_gem_destroy() runs from the drm-managed
> release, after vc4_v3d_unbind() has already uninstalled the V3D
> interrupt and cleared vc4->v3d.
> 
> A timer still armed by then reads V3D registers through the NULL
> vc4->v3d pointer, and late callbacks run on the vc4_dev embedding
> them after it has been freed.
> 
> Drain them in vc4_v3d_unbind(): shut the hangcheck timer down and
> cancel reset_work before the interrupt is taken down, because
> vc4_irq_reset() in a straggler reset re-enables it, then cancel
> job_done_work once no source is left, before vc4->v3d is cleared.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: d5b1a78a772f ("drm/vc4: Add support for drawing 3D frames.")
> Cc: stable@vger.kernel.org # 6.13+: vc4->gen does not exist on older trees
> Assisted-by: Codex:gpt-5.6
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>   drivers/gpu/drm/vc4/vc4_v3d.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
> index f32410420d3e..11d4df3164b4 100644
> --- a/drivers/gpu/drm/vc4/vc4_v3d.c
> +++ b/drivers/gpu/drm/vc4/vc4_v3d.c
> @@ -9,6 +9,7 @@
>   #include <linux/component.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/timer.h>
>   
>   #include <drm/drm_print.h>
>   
> @@ -497,8 +498,18 @@ static void vc4_v3d_unbind(struct device *dev, struct device *master,
>   	struct drm_device *drm = data;
>   	struct vc4_dev *vc4 = to_vc4_dev(drm);
>   
> +	/* Kill the timer, then reset_work: vc4_irq_reset() re-enables it. */

This comment provides no insight about the code, it's just describing
it.

> +	if (vc4->gen == VC4_GEN_4) {

No need for this guards, as this function only runs on VC4_GEN_4.

> +		timer_shutdown_sync(&vc4->hangcheck.timer);
> +		cancel_work_sync(&vc4->hangcheck.reset_work);
> +	}
> +
>   	vc4_irq_uninstall(drm);
>   
> +	/* Nothing can queue job_done_work any more; drain it. */
> +	if (vc4->gen == VC4_GEN_4)
> +		cancel_work_sync(&vc4->job_done_work);

Check Sashiko's feedback about this.

Best regards,
- Maíra

> +
>   	/* Disable the binner's overflow memory address, so the next
>   	 * driver probe (if any) doesn't try to reuse our old
>   	 * allocation.
> 

