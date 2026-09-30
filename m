Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0B037A843;
	Wed, 30 Sep 2026 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783130; cv=none; b=EycPDruLiBC57WrqZfZKcXvbDZLcTRbOicmBZ4k1luHDx4m6+JTKM5eDkUF3ZfadTLH+To3VDsm1FPWKForch+k6YAOooMH2HGhNeNSZLIjnEJQaXscPlu+U7Y+oRKHd/bFrynOR/l1S1jj9zjUQW9LHIVttXkt07Vmj9xXWvP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783130; c=relaxed/simple;
	bh=9fiKbHvHoBtkn+nIT5bE52kZK1Atf9u6tmixiphD12I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUUIkg/kqURtVZoWHlMYzrQCRA5ZlvKUoABhvJ63N32LKZsVF7JWMV0YNyB+GfCoMPFv/Xmoib67IuNaGu6GX5C+gVcHpMy6Q1+yd/X78UPD86NduQg6x/769SWSH4hWMoZqXDzoMTjCeHTa45Y/vpZZl/3LmHxOFfCUtuZ4z/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=uQ2OPCro; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="uQ2OPCro"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90FF0497;
	Wed, 30 Sep 2026 08:45:18 -0700 (PDT)
Received: from [10.57.77.8] (unknown [10.57.77.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 103613F86F;
	Wed, 30 Sep 2026 08:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790783122; bh=9fiKbHvHoBtkn+nIT5bE52kZK1Atf9u6tmixiphD12I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uQ2OPCrouRwrNNLFKXpSVmny1um/RdTy/AdGxVwtnOq7wr40zlJeYLBBW8ZhYCZPZ
	 x4idiyXVJdxjzhf5EyYS3L4N80Yn0m2KJSB9H/M9gaDCO/XfKxMphhThbgr+Q/s8dx
	 HAjxoM72uuR15d2QHlDQXIOqvrRkjaKVeol8+dL4=
Message-ID: <476a6afa-23d4-45e2-816b-e24d524a292c@arm.com>
Date: Wed, 30 Sep 2026 16:45:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: validate userspace queue count against
 initialized firmware slot count
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, sashiko-bot@kernel.org
References: <20260804160048.174148-1-osama.abdelkader@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260804160048.174148-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/08/2026 17:00, Osama Abdelkader wrote:
> In panthor_drv.c:panthor_ioctl_group_create(),
> the queue count is validated against the hardcoded maximum:
> 
> 	if (!args->queues.count || args->queues.count > MAX_CS_PER_CSG)
> 		return -EINVAL;
> 
> However, if the firmware reports fewer slots than MAX_CS_PER_CSG,
> panthor_fw_init_ifaces() will only initialize that smaller number of
> stream interfaces.
> 
> If unprivileged userspace requests more queues than the firmware reported
> (but no more than MAX_CS_PER_CSG), cs_slot_prog_locked() fetches an
> uninitialized stream interface and may crash when dereferencing
> cs_iface->input->ringbuf_base.
> 
> Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
> Cc: stable@vger.kernel.org
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260803141149.68182-1-osama.abdelkader@gmail.com?part=1
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Looks like this one got missed - I'll push it to drm-misc-fixes.

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 5832dccfc093..64749750e6ee 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3673,6 +3673,9 @@ int panthor_group_create(struct panthor_file *pfile,
>  	    hweight64(group_args->tiler_core_mask) < group_args->max_tiler_cores)
>  		return -EINVAL;
>  
> +	if (group_args->queues.count > sched->cs_slot_count)
> +		return -EINVAL;
> +
>  	group = kzalloc_obj(*group);
>  	if (!group)
>  		return -ENOMEM;

