Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690EC2F7EF9;
	Fri, 24 Jul 2026 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907207; cv=none; b=tN491EF6H8YHfsIXrHffsmc2mwpLI5QsFoGdRjPNdZy6fil8WSChUKVwyRV3iv1bb/xqfjlapZK2KoN9eoEf2SD1I8964SkqRKt8wmj3m3QQJqkLoR25L0r8QgzGNEIf0dBXNZCgpu5gqdpul2ircY2Kil5bD0Q3f8VgGuQJ2MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907207; c=relaxed/simple;
	bh=+o0beotL8y7MpoUYTdG8kGqiQRANLNh8KSu6dK3sUD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sE/w1+UOrAiykCozNUdUZRHdGwteqz6rn5MyqbfCSkHjh6uswrwwOfP8+5aZo0eoH3x/9HCdgoC+9FQq6ZcHoMYRXPoX+1/ffKwBkxL9+OcACuvuGm/l65VVH5hp8h+Lz7/fTgwXRGJ8xy36oLCqU2CDXJI/RqOBBOwEznNdx1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gbdxT7RS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gbdxT7RS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 390781684;
	Fri, 24 Jul 2026 08:33:20 -0700 (PDT)
Received: from [10.1.25.28] (e122027.cambridge.arm.com [10.1.25.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFB333F59E;
	Fri, 24 Jul 2026 08:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784907204; bh=+o0beotL8y7MpoUYTdG8kGqiQRANLNh8KSu6dK3sUD4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gbdxT7RSlMondLOm+8arR7st4y0YBRCP46a33GUv92ekwRouGDhF/xa1SRfsTU602
	 gXlwr8clgVpRAQTbVHZyoyPkg3Ukwp0K1G1mWr3obY/yI3wwhgrkf619misqa/qSqg
	 CRdRPlqJtjKfvf4WpXRznw7wVeAixSOR/yeen1/4=
Message-ID: <2c8bd414-097b-41a9-95e0-87b146ef3f26@arm.com>
Date: Fri, 24 Jul 2026 16:33:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: reject firmware sections with oversized data
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260716143939.21903-1-osama.abdelkader@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260716143939.21903-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/07/2026 15:39, Osama Abdelkader wrote:
> In panthor_fw_load_section_entry(), the data size to copy is calculated
> without validating it against the allocated section_size:
> 
>     section->data.size = hdr.data.end - hdr.data.start;
> 
> If a crafted firmware sets data.size larger than the allocated memory,
> this could cause a heap buffer overflow in panthor_fw_init_section_mem()
> 
>     memcpy(section->mem->kmap, section->data.buf, section->data.size);
> 
> Additionally, if the section->data.size exceeds the BO size, could this
> memset underflow the size calculation, leading to a massive out-of-bounds
> zeroing of kernel memory?
> 
>     memset(section->mem->kmap + section->data.size, 0,
>            panthor_kernel_bo_size(section->mem) - section->data.size);
> 
> Reject section entries whose initial data is larger than the section size.
> 
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

I'll apply this to drm-misc-fixes.

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 986151681b24..a338c4f0a7f5 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -545,6 +545,7 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
>  	struct panthor_fw_binary_section_entry_hdr hdr;
>  	struct panthor_fw_section *section;
>  	u32 section_size;
> +	u32 data_size;
>  	u32 name_len;
>  	int ret;
>  
> @@ -595,6 +596,13 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
>  		return -EINVAL;
>  	}
>  
> +	section_size = hdr.va.end - hdr.va.start;
> +	data_size = hdr.data.end - hdr.data.start;
> +	if (data_size > section_size) {
> +		drm_err(&ptdev->base, "Firmware corrupted, section data exceeds section size\n");
> +		return -EINVAL;
> +	}
> +
>  	name_len = iter->size - iter->offset;
>  
>  	section = drmm_kzalloc(&ptdev->base, sizeof(*section), GFP_KERNEL);
> @@ -603,7 +611,7 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
>  
>  	list_add_tail(&section->node, &ptdev->fw->sections);
>  	section->flags = hdr.flags;
> -	section->data.size = hdr.data.end - hdr.data.start;
> +	section->data.size = data_size;
>  
>  	if (section->data.size > 0) {
>  		void *data = drmm_kmalloc(&ptdev->base, section->data.size, GFP_KERNEL);
> @@ -626,7 +634,6 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
>  		section->name = name;
>  	}
>  
> -	section_size = hdr.va.end - hdr.va.start;
>  	if (section_size) {
>  		u32 cache_mode = hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_MASK;
>  		struct panthor_gem_object *bo;

