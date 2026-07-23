Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC90B13A3F7
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827465; cv=none; b=Nt7mMu5HiLuKM0CVGfTiPmvQk6jUUDb1Fnt9qGLoIlG2b5D42jv7CfVBl2hXccrTM2yY2nyFgp6cygREFuyLlFNcY7eYo/avbG1QdrknP1pcd8VTMqfBztHBTsSWJycivigMDJH1wISYogw9b1WKvMg4FybQSxUgti5IjHjHxuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827465; c=relaxed/simple;
	bh=W58DCtGDT+OKYxEF6L+JE1FWc5uLyuUNKdXSrC8llLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYObsbpPG2TD5Knwd9+YFNCMdyL8NcpNyljt4lpFXI+yXSAsE52DoUezA9qjA+RMm6Q1hc3UfNUMi5X6z6MZDZyNUnbwh3sVh/+0p5TmotZLPO2A3KSNlIHU7t4Q3TooOex5b5/4I4cyh8nJe8RGtjNTwhMZoh3tEsCKgVN2Tww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgGSsxS9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgGSsxS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9AD1F000E9;
	Thu, 23 Jul 2026 17:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784827464;
	bh=SkZnpNKolfSpJf7DyJNw76W6oJIwegsHi1sMOwZmp4c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IgGSsxS92xKwwyDELe27SlH44ljVuNmz8YivTr8xUDYUJ7/oFfL9ejsTtDrWYUP7p
	 O1jOSZgYdObrJ3GDyn2cIBHy2Qw9/Ww73LmYUOCqJ2Kz3wPP5DNSV1GGaM1tOD30dK
	 O2MQXNmQMkjvEoRySZlhet9cBd0lb4WO8QLOXWvJmpigavzOn4ILbFQL9Y6KlKrYFC
	 2xHjawzGIogPTq2lKoN+7UzYp3AvklU3tbPlFybL3+riGJuGPFTuel4oLHMsulWuuK
	 aPp9k3oOJAHD1rqJ1ceQkMYF07jVBXepjv+WXtXW9OXHByxk5eDY27LJeIMq5eK/E3
	 s/bSPDnBcCKRw==
Message-ID: <b664f2f7-5165-4bfc-9ca3-0f22629d7bdc@kernel.org>
Date: Thu, 23 Jul 2026 12:24:22 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix missing DCE check in
 dm_gpureset_toggle_interrupts()
Content-Language: en-US
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, alexander.deucher@amd.com,
 stable@vger.kernel.org, Lu Yao <yaolu@kylinos.cn>
References: <20260723134450.13838-1-sunpeng.li@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260723134450.13838-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/23/26 08:44, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> This line was lost when cping from amd-staging-drm-next to drm-fixes.
> So add it back.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8382cd234981 ("drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_no_lock")
> Reported-by: Lu Yao <yaolu@kylinos.cn>
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9c564cd5edeea..eaf19ec843e87 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3324,7 +3324,8 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
>   		acrtc = get_crtc_by_otg_inst(
>   				adev, state->stream_status[i].primary_otg_inst);
>   
> -		if (acrtc && state->stream_status[i].plane_count != 0) {
> +		if (acrtc && state->stream_status[i].plane_count != 0 &&
> +		    amdgpu_ip_version(adev, DCE_HWIP, 0) == 0) {
>   			irq_source = IRQ_TYPE_PFLIP + acrtc->otg_inst;
>   			rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
>   			if (rc)

