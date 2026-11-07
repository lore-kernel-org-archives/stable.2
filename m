Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093633;
	b=GOOHFO8HqgrhRk2MbLZg7GfyqoDUOhUpq2nqGiZ9TQ4aonDizE+GPlTPOczSfx5vzMnf
	 uHqd6o+vEo4bOQOn3efin9OwOi+537bERwQoNEEIJIkgthCWpB+t0h06S8DgoZM+ldKM0
	 E5vIhbE74FHf6BpHp3HFfD7Qy9VTBZnm6sLiLrRg3xDnmMgb0/1flrYd4qbKBsWzKCh1w
	 O9OsPwnORmg+eopSFQItrqQMGCynL8I3IP1R03cxH0q+dWT90P3GA5NBFpxH5BHy9HKPq
	 ztBVpkByzgaFL69UceyhvJJmg6J0xWIp+rNEaJOz9kC1mkEbaw8deEqok/OdfYmC/dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093633;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=xcmpMNGz7eyK+lXGlaOSZ/2QQJ95UcMqOj2WRM+Lnvc=;
	b=Yd4XDeA4utAvEUNJ/t1uvNBCJUMA7GizNOQNQ1YVgHOKaalk9BBf0Pzzlxxs3h5QsQeN
	 gJ10j3mKlU4BLmlVfYNGwMfPXDg9LqvTGoZEvsW9y5VfIFcIt0z6VgRlWHNiDPQQGtaKt
	 ruInv3dXhZnxQUhQhqzu4sC592YeC6xp6RRMYUsW6mghFs2xNcpA0zYmHPyWzb1OUqdM/
	 pSGCiat7ILJnQkMagUkm71skTR8HcbRNGwA37Nv/NHEuv8q1x1Ij3wM+tUn5JTtRuQ2lI
	 XACgLuYT6c5Wd0MRtfm0o26hWBDoT8oqEJvJ29L4+m9KsAOSvXfEQhlWRQMq3sCVJKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=a10M04vL;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6450606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6450606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=a10M04vL
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA9C81576
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 15:20:27 -0800 (PST)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 926723F632
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 15:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794093630; bh=LvtX4LYTtVJ3xplPgpoL256Ueeg2nGyQJZY5/7RQcls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a10M04vLO60Xe5muXXLlccR1FvlB2VCqIlhdqZsnQcVMVtxAyBO/obqYnGalxZ5kn
	 Mo6FcmrAExycSF2hcPQMMTP7db8FmQVEOXJEoILzZ543S1VA38RMOlZB6VpT8LUVO5
	 HPfg8smT72fh9sQXXdYF40ynJUxyM0YGnNkHYDus=
Date: Sat, 7 Nov 2026 23:20:25 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Sasha Levin <sashal@kernel.org>
Cc: osama.abdelkader@gmail.com, sashiko-bot@kernel.org,
	steven.price@arm.com, boris.brezillon@collabora.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] drm/panthor: validate userspace queue
 count against initialized firmware slot count" failed to apply to 7.3-stable
 tree
Message-ID: <au-yOWK6i0hD6u2S@e142607>
References: <20261107050350-failed-7.3-00d4e932258f@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261107050350-failed-7.3-00d4e932258f@kernel.org>

On Sat, Nov 07, 2026 at 05:03:50AM -0500, Sasha Levin wrote:
> The patch below does not apply to the 7.3-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
> git checkout FETCH_HEAD
> git cherry-pick -x 00d4e932258fc5f2ace62daac307bd903ee400f5
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050350-failed-7.3-00d4e932258f@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'
> 
> Thanks,
> Sasha

Hi Sasha,

The reason patch fails to apply is because it's already in that tree under
commit ec86c43dcfff68eab4db9bdafcd3e2b16e342e18. Steven merged the patch
through drm-misc-fixes while I was at XDC, not knowing that I've also merged
the patch through drm-misc-next. Hence the two commit SHAs for the same code.

Best regards,
Liviu


> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 00d4e932258fc5f2ace62daac307bd903ee400f5 Mon Sep 17 00:00:00 2001
> From: Osama Abdelkader <osama.abdelkader@gmail.com>
> Date: Tue, 4 Aug 2026 18:00:47 +0200
> Subject: [PATCH] drm/panthor: validate userspace queue count against
>  initialized firmware slot count
> 
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
> Reviewed-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Link: https://patch.msgid.link/20260804160048.174148-1-osama.abdelkader@gmail.com
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index ac6aee554820e..0493858e55d76 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3652,6 +3652,9 @@ int panthor_group_create(struct panthor_file *pfile,
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
> 2.53.0
> 
> 
> 
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
