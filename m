Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7632B443A89
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784112191; cv=none; b=vGVW/IRKvs5j/PQCZbJlDFL1DyewQXPPwd/9NygdjBVm8wJIDnA/+ubqUpmDP9KAhrAuZoRTyCEkH42ZVe3p9hNZbGjnSUzO+cwip4AqvgtDeIzyXwO++5ZzeUR7/lfxFgo2TROSyWVx7KPb2WYuWdC9PHzeuvd95lQ5AiUVf60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784112191; c=relaxed/simple;
	bh=aa3pG2P5vQO0i02r0jp442RpbvJBP4nam9HCCrn4gJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZQ//IiuTrj537mK5g1NwB7JOtLe5gl47BwEoze95BmAuO/uby5q+lT4HVZPzx0fuN1BFPvfCdDKmV0Bzx+HRocFKnDZ0VcgBTdlgw6XtSjE5c8VL4UTcSN7CoqCuAMsI2obo8tLBKywxhh/ZPgk8bxh3Ev6lbAW2DZs5IQVAGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tzV4D2nt; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tzV4D2nt"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E3FA152B
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 03:43:04 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A516F3F7B4
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 03:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784112188; bh=aa3pG2P5vQO0i02r0jp442RpbvJBP4nam9HCCrn4gJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tzV4D2ntNKZizBCRkdanhz4GLwl3FD/OR05G6pilJO1SZoJLkQefgw0Yj/Bl2b698
	 toqtfnsEtBLkzFCKZ1zzfe911bXGNwCC6pmc/LD33RdtmIqd2cYeDy4piGElpId00b
	 WskwrOMhNitsnulBPVvFY3cMO6mcp/MKtQSvifJ4=
Date: Wed, 15 Jul 2026 11:42:54 +0100
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
Subject: Re: [PATCH] drm/panthor: return error on truncated firmware
Message-ID: <aldkLnuKwCx4rc7k@e142607>
References: <20260714163056.22329-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714163056.22329-1-osama.abdelkader@gmail.com>

On Tue, Jul 14, 2026 at 06:30:55PM +0200, Osama Abdelkader wrote:
> panthor_fw_load() detects truncated firmware images, but jumps to the
> common cleanup path without setting ret. If no previous error was recorded,
> the function can return 0 and treat the invalid firmware as successfully
> loaded.
> 
> Set ret to -EINVAL before leaving the truncated-image path.
> 
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for the fix!

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 986151681b24..39fff094ebb5 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -829,6 +829,7 @@ static int panthor_fw_load(struct panthor_device *ptdev)
>  	}
>  
>  	if (hdr.size > iter.size) {
> +		ret = -EINVAL;
>  		drm_err(&ptdev->base, "Firmware image is truncated\n");
>  		goto out;
>  	}
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
