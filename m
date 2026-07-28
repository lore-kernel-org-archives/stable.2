Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BFE34C134
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254986; cv=none; b=l2gMvXZmc3UgcTJW9eE2zxQNU1kqzxgeL5KWwTguihguWjeptTCGTsDys3omzqEOk7d/iWqtiomu2WesQNUKCVEsMNJ7BJp8wwMTfNsSl/D2iEpfOTx/smrpL3Nn4lrGS6s798KuGDR99loUzOCmGbxcEEvAPbQ2ij8+9LVbMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254986; c=relaxed/simple;
	bh=q6mrCLoh7TTNCGFPKiKdXibBGMULCO0YWhvoUknTgb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4YBlPIPo6dtY30/Tlu9J7mK9bz/jXSIaaFI2S850LYZCqBqoZHcRP09nqky17+gGRfMYURsI/qFu12FTCJS6b+H7mgHKEOvBCC0yxa4t3fFTuTmPNwukvgYqkKKtQIpeDL+XtR35DFeJiVITcW5ovvFiLIZi/VCudEnJCyNUZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Pajv6UVL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Pajv6UVL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32A9E16F2
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 09:09:40 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0EE773FAF5
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 09:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785254984; bh=q6mrCLoh7TTNCGFPKiKdXibBGMULCO0YWhvoUknTgb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pajv6UVLoX2IkxCJsckko62jsW2MjmUqpxkX3J54vmOsKR/d7yEL22bcdtEKiK821
	 QtRvVf4cnFvRQYgoczTHg5egW2lcwPs29u4ktz5pSJdMDEsYulpei0tTjKm+PQnLxq
	 g+/SxPzi6cxgbrYQ0P0MCvXflyzGDLJSRcyezJpo=
Date: Tue, 28 Jul 2026 17:09:29 +0100
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
Subject: Re: [PATCH v2] drm/panthor: skip zero-sized firmware sections
Message-ID: <amjUOezjoGoKSEVA@e142607>
References: <c31aeec2-6336-4dad-93a8-982e3f4c525f@arm.com>
 <20260724172621.63046-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724172621.63046-1-osama.abdelkader@gmail.com>

On Fri, Jul 24, 2026 at 07:26:20PM +0200, Osama Abdelkader wrote:
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

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

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
> -- 
> 2.43.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
