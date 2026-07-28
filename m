Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2BB3E025C
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251590; cv=none; b=pZSIrjQ5TW0y/O9+TFKD/CImaMtdeP0j4qJE/jGEyyR0Efi3n/MRhLe9T/5JGyreT9LnHaXUv7a9aQo3U2Z8VfmoSzgSaFZONWrSg2h0u7r8dfpZpM4lL5B5Ac1Nk0WWDsY68Us4+KSburKvJViR4B1oqZzp/PJ1c0fJ1u68YCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251590; c=relaxed/simple;
	bh=dNUDuI1pWJWA0MvVa+UypasPomGd1aQYtrd9nXUXhlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLh4FF7SQpKTNESVvw6R2r9CDyUICpdjTl3XfJUVz1EmHkO4C3FzEPbm8kOIkyxqG+9hHryJ/cGVx6RHRIhUyH7PQVES94b61CJpE22Jis4Nx0PpX+auY5KFjfj+YKWCNTmbKgIlF97txMMPwZ27iZQeRRTbiq8UlTGpbA+KYN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jEoux06S; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jEoux06S"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0D3E1A9A
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 08:13:03 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C53C03F66F
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785251588; bh=dNUDuI1pWJWA0MvVa+UypasPomGd1aQYtrd9nXUXhlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jEoux06SqgVb6TlqtVd9uSlRl8ZJJJegTAgKUe2mVWUcpvxoSuVLOoOPBD8aS0Gkw
	 WOz5S6XWD7Exd/LiNPREN9h+L7W1S6LmIQSp3g+p1AvcvqFBBCoR+WOAgGprZLIWK+
	 TtLqtUbifZsfB4NrKlGtp9T3cfBG9MNJcua5gg4M=
Date: Tue, 28 Jul 2026 16:12:53 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: fix firmware control interface bounds checks
Message-ID: <amjG9WVZrb6v92_h@e142607>
References: <20260720134435.13377-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720134435.13377-1-osama.abdelkader@gmail.com>

On Mon, Jul 20, 2026 at 03:44:35PM +0200, Osama Abdelkader wrote:
> panthor_init_cs_iface() and panthor_init_csg_iface() validate firmware
> control interface offsets with 32-bit arithmetic and the size of the host
> wrapper structures. The offsets are derived from firmware-provided strides,
> so the arithmetic can wrap before the bounds check, and the host wrapper
> size is not the size of the firmware control interface being mapped.

How can the offsets wrap with the firmware-provided strides? It's not like
the firmware provides arbitrarily large strides.

> 
> Use 64-bit arithmetic for the computed offsets and validate against the
> actual firmware control interface structure sizes with subtraction-based
> bounds checks. Also validate that the shared section is large enough for
> the global control interface before using it.
> 
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
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
> -- 
> 2.43.0
> 

I'm OK with the general content of the patch, so:

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu


-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
