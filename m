Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937DC40098E
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923008; cv=none; b=U2e7y9q9wzfSq6uyoS6o8lWlBILfAiVNq3LWF0YgeNKVutSLuUJ0G/DutIqO6HRsH1raHw7eLCqW7+SH275SxTOLYaaUcU+bhwyGZX88qcSMWnnAiexNZnNQHmQ6QD0N4tyOtQ/d5F7b7hXMzBGDsoD94VuIGKkpuuwsKFKzr+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923008; c=relaxed/simple;
	bh=cAmghhGppToWtHfEqpafMG+DPcIUgKmheEzXiL1IBbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQ/Y8VxCAShAtdyC5GQOCySDXd6NwvTLrfzOSOfD9L5Feghzgq0ejL/Q4BkQpwcGwT6wsGizE3xYaEvZiGu84WJHy4yeNO72535GsZd7QZG7aguvaTrzd46u+dX9l+HEqMdKHzHRrUCo/LSHtytjdyi+1A+DEWMT6+Rzimuyp3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=liUFiY/8; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="liUFiY/8"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC3E716F3
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:43:21 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BDBF23F66F
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785923006; bh=cAmghhGppToWtHfEqpafMG+DPcIUgKmheEzXiL1IBbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=liUFiY/8lVG9nbq9+XD8yhwvAVR17Ex6A02ED6THKhH8kmrAVsQUOjkeI/uEQlZK/
	 QJcCsZ4l27H+fDHkfoosG7JXPCepY9569w6ee84eNND4sT9o99feZVJw0QXJnGi//9
	 p0+FG7S6nAZUCHNs6ZFCzmVXDzjOEQkk5CCoAZVE=
Date: Wed, 5 Aug 2026 10:43:12 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panthor: validate userspace queue count against
 initialized firmware slot count
Message-ID: <anMFsGwrHRpB4hVq@e142607>
References: <20260804160048.174148-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804160048.174148-1-osama.abdelkader@gmail.com>

On Tue, Aug 04, 2026 at 06:00:47PM +0200, Osama Abdelkader wrote:
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

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

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
