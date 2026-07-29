Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F671DA23;
	Wed, 29 Jul 2026 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338123; cv=none; b=Kfxac34ruiCWbR8+OQyAQjet+4tNRceNIg/4KfK6jAxEs0L/zaNwIOGEkMIYdE2pN3JHsJMvdjaOUt1hrpiUxGprziOvaR6uijlf+k83/Y0BDmS2ZS75OnLC2ZoiJxJAxVYr7yLqdyw4AECbE2P1nLxHwzmcPYvhKtqvlf+D9SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338123; c=relaxed/simple;
	bh=CPFdNH+tk0hD8BapufMSerUii6drip63LAtDN7QslUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDHZ8npHNUDG/QckMqcnUTmGYbdfLE5/raOS+cIGjFDjk7bYyFF+Vi51c7gf6AiEtM6rzALT8ENixyXYnZTghX8eGG8TBWv1/37te4GllzCu9ZWMIWvSzHa9SC3KrGHaDigaQ691u+6c8XYahCkE4QVod7hBwQ0rgS2Y3I0WYxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=J4ytwFsG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="J4ytwFsG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A9231684;
	Wed, 29 Jul 2026 08:15:16 -0700 (PDT)
Received: from [10.57.87.210] (unknown [10.57.87.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 383AF3F763;
	Wed, 29 Jul 2026 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785338120; bh=CPFdNH+tk0hD8BapufMSerUii6drip63LAtDN7QslUw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J4ytwFsGQ01y2LZYOh7FPczFETL0UNRsiyHnDkI3OKK3UJGzphgeBWwiPK/wowtrr
	 oGbidGhT4wmpfg76hOnOVNHI1Xgt1A4epC61K09f1P73wmzkHZw4ctnjB4SOR9ec4k
	 Gzr+qOhnnxGJeAZiWwJrxVTCYAVHWhbdQMTuWrgo=
Message-ID: <445ea3c7-9fa8-4653-90cf-2c815347f83c@arm.com>
Date: Wed, 29 Jul 2026 16:15:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: validate firmware interface structure sizes
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260720114918.15973-1-osama.abdelkader@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260720114918.15973-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/07/2026 12:49, Osama Abdelkader wrote:
> iface_fw_to_cpu_addr() only checks that the firmware-provided MCU virtual
> address points inside the shared section. The returned pointer is later
> used as a full firmware interface structure, so accepting an address near
> the end of the shared section can still lead to out-of-bounds accesses.
> 
> Pass the expected object size to iface_fw_to_cpu_addr() and reject ranges
> that do not fit entirely in the shared section.
> 
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

I'll push this to drm-misc-fixes.

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 30 ++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 9d0e1fafdce2..eee2bc7e8541 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -870,18 +870,24 @@ static int panthor_fw_load(struct panthor_device *ptdev)
>   * iface_fw_to_cpu_addr() - Turn an MCU address into a CPU address
>   * @ptdev: Device.
>   * @mcu_va: MCU address.
> + * @size: Size of the object pointed to by @mcu_va.
>   *
> - * Return: NULL if the address is not part of the shared section, non-NULL otherwise.
> + * Return: NULL if the object is not part of the shared section, non-NULL otherwise.
>   */
> -static void *iface_fw_to_cpu_addr(struct panthor_device *ptdev, u32 mcu_va)
> +static void *iface_fw_to_cpu_addr(struct panthor_device *ptdev, u32 mcu_va, size_t size)
>  {
>  	u64 shared_mem_start = panthor_kernel_bo_gpuva(ptdev->fw->shared_section->mem);
> -	u64 shared_mem_end = shared_mem_start +
> -			     panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
> -	if (mcu_va < shared_mem_start || mcu_va >= shared_mem_end)
> +	size_t shared_mem_size = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
> +	u64 offset;
> +
> +	if (mcu_va < shared_mem_start)
> +		return NULL;
> +
> +	offset = mcu_va - shared_mem_start;
> +	if (offset > shared_mem_size || size > shared_mem_size - offset)
>  		return NULL;
>  
> -	return ptdev->fw->shared_section->mem->kmap + (mcu_va - shared_mem_start);
> +	return ptdev->fw->shared_section->mem->kmap + offset;
>  }
>  
>  static int panthor_init_cs_iface(struct panthor_device *ptdev,
> @@ -906,8 +912,10 @@ static int panthor_init_cs_iface(struct panthor_device *ptdev,
>  
>  	spin_lock_init(&cs_iface->lock);
>  	cs_iface->control = ptdev->fw->shared_section->mem->kmap + iface_offset;
> -	cs_iface->input = iface_fw_to_cpu_addr(ptdev, cs_iface->control->input_va);
> -	cs_iface->output = iface_fw_to_cpu_addr(ptdev, cs_iface->control->output_va);
> +	cs_iface->input = iface_fw_to_cpu_addr(ptdev, cs_iface->control->input_va,
> +					       sizeof(*cs_iface->input));
> +	cs_iface->output = iface_fw_to_cpu_addr(ptdev, cs_iface->control->output_va,
> +						sizeof(*cs_iface->output));
>  
>  	if (!cs_iface->input || !cs_iface->output) {
>  		drm_err(&ptdev->base, "Invalid stream control interface input/output VA");
> @@ -957,8 +965,10 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
>  
>  	spin_lock_init(&csg_iface->lock);
>  	csg_iface->control = ptdev->fw->shared_section->mem->kmap + iface_offset;
> -	csg_iface->input = iface_fw_to_cpu_addr(ptdev, csg_iface->control->input_va);
> -	csg_iface->output = iface_fw_to_cpu_addr(ptdev, csg_iface->control->output_va);
> +	csg_iface->input = iface_fw_to_cpu_addr(ptdev, csg_iface->control->input_va,
> +						sizeof(*csg_iface->input));
> +	csg_iface->output = iface_fw_to_cpu_addr(ptdev, csg_iface->control->output_va,
> +						 sizeof(*csg_iface->output));
>  
>  	if (csg_iface->control->stream_num < MIN_CS_PER_CSG ||
>  	    csg_iface->control->stream_num > MAX_CS_PER_CSG)
> @@ -1015,8 +1025,10 @@ static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
>  		return -EINVAL;
>  	}
>  
> -	glb_iface->input = iface_fw_to_cpu_addr(ptdev, glb_iface->control->input_va);
> -	glb_iface->output = iface_fw_to_cpu_addr(ptdev, glb_iface->control->output_va);
> +	glb_iface->input = iface_fw_to_cpu_addr(ptdev, glb_iface->control->input_va,
> +						sizeof(*glb_iface->input));
> +	glb_iface->output = iface_fw_to_cpu_addr(ptdev, glb_iface->control->output_va,
> +						 sizeof(*glb_iface->output));
>  	if (!glb_iface->input || !glb_iface->output) {
>  		drm_err(&ptdev->base, "Invalid global control interface input/output VA");
>  		return -EINVAL;

