Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0533ADB89;
	Fri, 31 Jul 2026 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785483137; cv=none; b=VsnA/xvxIImQ4W3gmtHInA4R6Mc5HciGFswhbz5nqs3U7Rq3JGtr2ySMnQ6LZ7SGqYAVlgn/ghWRq9/MBXwf/iIb6XKjvlvpVkltFuazcnXRSy8sYKWIx3aQybIhlO+H2u0CMlZPkS0iNY8Gjt/ag1jofXlKCxTJ44+0QEZg6UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785483137; c=relaxed/simple;
	bh=8nwexrU4GojqLqHdgsDjR3BOBw10uMNk9zy3a9FhJsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNQXm12Sset8K4qDBrSV54bF/9BtYyOcOlGFE/Nb8iN6+85tMgMFRDjQjP80+hZBy3saf7UomDb/I6wN4oGHMTCtXQe5/01/Um+JrPP0OxSth+6dAIvO53oRFcd3GAqOHxtbh/jpNgRJ06Wwo6PDn4ncpt2M6sNU8kGjvRiCMDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qsC/IMAQ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qsC/IMAQ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31A5520E3;
	Fri, 31 Jul 2026 00:32:11 -0700 (PDT)
Received: from [10.57.87.104] (unknown [10.57.87.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E002A3F7B4;
	Fri, 31 Jul 2026 00:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785483135; bh=8nwexrU4GojqLqHdgsDjR3BOBw10uMNk9zy3a9FhJsY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qsC/IMAQx7/QuBSaJS9n/MUCxlDhQZgCzjZ1yJXCH6FQnCsrX4uWgEdxYSyyqyvKZ
	 9ZlVx9dKEeKQ7oZyNPNkmHwMrs2foBDqi3Kyr7/IUCHnylUUykbsPfgF6EwlQ24jDl
	 MJ1cCyZf1Q6YxDm94CKbdy7xtYF8G5JY1tYms+YU=
Message-ID: <0d6db1e7-3892-423d-b01d-b126dccadd90@arm.com>
Date: Fri, 31 Jul 2026 08:32:09 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: fix firmware control interface bounds checks
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260720134435.13377-1-osama.abdelkader@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260720134435.13377-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/07/2026 14:44, Osama Abdelkader wrote:
> panthor_init_cs_iface() and panthor_init_csg_iface() validate firmware
> control interface offsets with 32-bit arithmetic and the size of the host
> wrapper structures. The offsets are derived from firmware-provided strides,
> so the arithmetic can wrap before the bounds check, and the host wrapper
> size is not the size of the firmware control interface being mapped.
> 
> Use 64-bit arithmetic for the computed offsets and validate against the
> actual firmware control interface structure sizes with subtraction-based
> bounds checks. Also validate that the shared section is large enough for
> the global control interface before using it.
> 
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

As Liviu pointed out some of this seems a bit unlikely, but I don't
disagree with any of the changes, so:

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index eee2bc7e8541..e2fcbd639c3c 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -897,15 +897,16 @@ static int panthor_init_cs_iface(struct panthor_device *ptdev,
>  	struct panthor_fw_csg_iface *csg_iface = panthor_fw_get_csg_iface(ptdev, csg_idx);
>  	struct panthor_fw_cs_iface *cs_iface = &ptdev->fw->iface.streams[csg_idx][cs_idx];
>  	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
> -	u32 iface_offset = CSF_GROUP_CONTROL_OFFSET +
> -			   (csg_idx * glb_iface->control->group_stride) +
> +	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
> +			   ((u64)csg_idx * glb_iface->control->group_stride) +
>  			   CSF_STREAM_CONTROL_OFFSET +
> -			   (cs_idx * csg_iface->control->stream_stride);
> +			   ((u64)cs_idx * csg_iface->control->stream_stride);
>  	struct panthor_fw_cs_iface *first_cs_iface =
>  		panthor_fw_get_cs_iface(ptdev, 0, 0);
>  
> -	if (iface_offset + sizeof(*cs_iface) >= shared_section_sz)
> +	if (iface_offset > shared_section_sz ||
> +	    sizeof(*cs_iface->control) > shared_section_sz - iface_offset)
>  		return -EINVAL;
>  
>  	spin_lock_init(&cs_iface->lock);
>  	cs_iface->control = ptdev->fw->shared_section->mem->kmap + iface_offset;
> @@ -955,11 +956,13 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
>  	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
>  	struct panthor_fw_csg_iface *csg_iface = &ptdev->fw->iface.groups[csg_idx];
>  	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
> -	u32 iface_offset = CSF_GROUP_CONTROL_OFFSET + (csg_idx * glb_iface->control->group_stride);
> +	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
> +			   ((u64)csg_idx * glb_iface->control->group_stride);
>  	unsigned int i;
>  
> -	if (iface_offset + sizeof(*csg_iface) >= shared_section_sz)
> +	if (iface_offset > shared_section_sz ||
> +	    sizeof(*csg_iface->control) > shared_section_sz - iface_offset)
>  		return -EINVAL;
>  
>  	spin_lock_init(&csg_iface->lock);
>  	csg_iface->control = ptdev->fw->shared_section->mem->kmap + iface_offset;
> @@ -1011,12 +1014,16 @@ static u32 panthor_get_instr_features(struct panthor_device *ptdev)
>  static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
>  {
>  	struct panthor_fw_global_iface *glb_iface = &ptdev->fw->iface.global;
> +	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
>  	unsigned int i;
>  
>  	if (!ptdev->fw->shared_section->mem->kmap)
>  		return -EINVAL;
>  
> +	if (sizeof(*glb_iface->control) > shared_section_sz)
> +		return -EINVAL;
> +
>  	spin_lock_init(&glb_iface->lock);
>  	glb_iface->control = ptdev->fw->shared_section->mem->kmap;
>  
>  	if (!glb_iface->control->version) {

