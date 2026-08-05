Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7123BD05;
	Wed,  5 Aug 2026 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916313; cv=none; b=t5uOpb8sg7Lb04eyAo4OPzkkl/ghuYfRvpq745thxCoKqW/k+G/+InSqi29DP0vjGTQnV+Qx/lS9BX9jwmnt4dCIttILuK+knZ/qwsi0jLBgZMgr3itysyViYG60fTfiENUnLf9mcOaL35F3CySbnYFfJFt61YNWiADzqEZ0v4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916313; c=relaxed/simple;
	bh=QciaFh05jOBkomG66aF5U+QkT0AqJFGre6Qg0gdCucQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGrKbKP+H8Bf34IeOZRNMYSiz+4Nycntm2phaiOMHVLxT/xxJfPwYHBGFYXMjx1niSaDlNWTPQYTelP0WMF+ijLcTswNBLprNS4OAOppPF428tWzOp1LcJ3Uybpo02QVJRigWfO2XzoAgBFN47WjMVtmgeyxtSpjEZPD+RGIbTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SJrGqsYT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SJrGqsYT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785916310;
	bh=QciaFh05jOBkomG66aF5U+QkT0AqJFGre6Qg0gdCucQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SJrGqsYThemKc0cMGie1NU+F5vXfw2dY+4VE6GofaLCz6Is948yHX9ZQ22Kdj288K
	 E8tqgz4vpt8JqCLyhzy1f1Q/6uIdHlIATnhOsREeFmSwnQoOgBFtuOFJUISPtCq/GI
	 Fj4nc4LXUOn7sBI2LhSFEe8AYXr12fe4zQHzhHyuz+imKJ88SIBf0Z3v2hJez5v2la
	 3fbu+4kO3fdsT8z4McdwF+Qd8xrzqylQA7fjRxOeJMe3PuXDz7gk12Xh50KgVVaUt5
	 aO8N7HAQ43BRtQs60vhqFcczT9sGVwkmstt2Tz8ovuQ6KTwHFmhCRWOQr+LxXQwdOM
	 UgWyZF6+LOKxA==
Received: from fedora-21.home (unknown [100.64.0.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7593117E025E;
	Wed, 05 Aug 2026 09:51:49 +0200 (CEST)
Date: Wed, 5 Aug 2026 09:51:45 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Heiko Stuebner
 <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panthor: validate userspace queue count against
 initialized firmware slot count
Message-ID: <20260805095145.147e8192@fedora-21.home>
In-Reply-To: <20260804160048.174148-1-osama.abdelkader@gmail.com>
References: <20260804160048.174148-1-osama.abdelkader@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Aug 2026 18:00:47 +0200
Osama Abdelkader <osama.abdelkader@gmail.com> wrote:

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

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

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

