Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548F33EDAA3;
	Thu, 30 Jul 2026 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404961; cv=none; b=tt4aREjPo4UGJwxSld5NYLPcUO8xocuHS3zdkGLl/jzardo/onIMNN7fXnY2n9LZ26hf/Vf7a6IAbL4O1xMMcICFDmPqZMbSpy0iCgKAR2Gblm3luek2MH06uMQ/tt2u6OIqoYX0VVUM44i8w70i+AhMY9nnnt8+AaKlNYel5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404961; c=relaxed/simple;
	bh=Za1Zi5x4E/3lIcCOwvENgOWOmAWtb4nF2bI7UjF97+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxSGEwqnhxsqigVfBXWVGAwl4I3mcANajzHvg9xJBSxVRyns5yueSkikkDIh3D0i8/uzWoMXJT6ZhiGMtShgov9/ClUuA5K0htbmG3AP2htPPyXD/mKbldehVpL1k3Url+nvH+cCAas99/2tAuQYpjV4JF5AeVV7fzyQiyizE+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Kp2Du9Ev; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Kp2Du9Ev"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 976B8204C;
	Thu, 30 Jul 2026 02:49:15 -0700 (PDT)
Received: from [10.1.25.28] (e122027.cambridge.arm.com [10.1.25.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 934EB3F763;
	Thu, 30 Jul 2026 02:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785404959; bh=Za1Zi5x4E/3lIcCOwvENgOWOmAWtb4nF2bI7UjF97+0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kp2Du9Ev6sNCOxPIYC5gX+2xSY61M1TbA9KsNh7A/Fmj4WLLrQh5JNE9gg7+50gz2
	 z2/kTsfGhojxrRK2CBrOy1UNRK+jEF0cWdgQ4OFuWOmBwmIO6z002+3IkEXM8rIcmh
	 JqKsa874bbLakttlgmpnwxcP5n88J9jSeSpUGP/M=
Message-ID: <0beb3ec9-b197-438f-81ff-00051e1112b2@arm.com>
Date: Thu, 30 Jul 2026 10:49:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panthor: skip zero-sized firmware sections
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <c31aeec2-6336-4dad-93a8-982e3f4c525f@arm.com>
 <20260724172621.63046-1-osama.abdelkader@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260724172621.63046-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2026 18:26, Osama Abdelkader wrote:
> panthor_fw_load_section_entry() skips BO creation when the firmware section
> VA range is empty. If such a section is added to the firmware section list,
> section->mem is left as NULL.
> 
> Later reload and unplug paths iterate over all firmware sections and
> dereference section->mem, which can lead to a NULL pointer dereference.
> 
> Zero-sized firmware sections are valid, so accept them as no-op entries but
> skip adding them to the section list.
> 
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

I'll push this to drm-misc-fixes.

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> v2:
> - Accept zero-sized firmware sections as no-op entries instead of rejecting
>   them, as suggested by Steven.
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index a338c4f0a7f5..66d9f5947af0 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -601,8 +601,11 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
>  	if (data_size > section_size) {
>  		drm_err(&ptdev->base, "Firmware corrupted, section data exceeds section size\n");
>  		return -EINVAL;
>  	}
>  
> +	if (!section_size)
> +		return 0;
> +
>  	name_len = iter->size - iter->offset;
>  
>  	section = drmm_kzalloc(&ptdev->base, sizeof(*section), GFP_KERNEL);

