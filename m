Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC3239D3D3
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836556; cv=none; b=dWSa0rToZtpI2Iq1SpcbR0OksSogLZoPZ1rC27BhrzqCWmt6xYhFUuWND4F65Jwrx08AmjrqS6GZ9lIXZ598WCInMmHUd+2O6gQj2fDGbNrs1wA/upfVjWgfex1S8iy2L8wKCiZZBx6bRBxclIAP1sc95xGVeWMG+88jjtDF5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836556; c=relaxed/simple;
	bh=ZdyatGhhfIDZBt5oxwwFwiUioc+MByhcY6XOYDpK5jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0j2JUFWTqYS+qnUxlc1JHdMxl3Gf3VtUR4Fl+MvV/xZm9BE99ycaB44opeZ0zMFN9+1KiwsBeHS4WkXPCdTOZ+vLkoMtMCOt2gcRYpzZYMKHw/Qx2yDBN6qjCUVFFXvjkhUTqe0ak4qzrrAVt72POguO2A3HsMZimwKydr7/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ruw+6Sg9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ruw+6Sg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C441F000E9;
	Thu, 23 Jul 2026 19:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784836554;
	bh=IstEdE1mm1dk1YzWfKusFzYmF4ElNOCGCSBmMFJzhy0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ruw+6Sg9OdFRZZaEtH/etwesJQv/HcdWyKLRuCms6ZdfwH1lkUDcNeCTBSM1RoYi7
	 KdsH87S9BNa6dTXFqNyF9e3/GhTtBiYQBI1j5N7tDl3Q0WrviyvtB9Q4EPOT7S7hh4
	 nkPWpfvN8q516k74uPeJ1fz52r9WIyA79JWwm1KPCMTaQOzKuSUaKpmev4BKtLehAZ
	 3mriP/10pjtCn/8Em4K4o+7I7sG4RwOYsYevWQ1861rFwvG1eE8yeFMICc9ZwFz70p
	 tJ85D92CnUZBCzVbF72eUaLqSxFPNjfA2vBpB8eJ7/8zHGQxOPT+gmBnUcXzTLPpZL
	 RC9JJ0iIA7FUw==
Message-ID: <85f87f21-d04a-4d27-ae4c-9e0cd64517fe@kernel.org>
Date: Thu, 23 Jul 2026 14:55:53 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix flip-done timeouts on mode1 reset
Content-Language: en-US
To: Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, alexander.deucher@amd.com, stable@vger.kernel.org
References: <20260723180159.52121-1-sunpeng.li@amd.com>
 <66071e47-2743-48ab-bb3c-8a8ae4ec199d@kernel.org>
 <476574f8-3bd5-4fc5-832f-e94fe1685870@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <476574f8-3bd5-4fc5-832f-e94fe1685870@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/23/26 14:47, Leo Li wrote:
> 
> 
> On 2026-07-23 15:18, Mario Limonciello wrote:
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> index 05d6915f9a6b0..079d4ccc88da6 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> @@ -287,10 +287,19 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
>>>         * is enabled. On DCE, vupdate is only needed in VRR mode.
>>>         */
>>>        if (amdgpu_ip_version(adev, DCE_HWIP, 0) != 0) {
>>> -        rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, enable);
>>> +        if (enable) {
>>> +            rc = amdgpu_irq_get(adev, &adev->vupdate_irq, irq_type);
>>> +            drm_dbg_vbl(crtc->dev, "Get vupdate_irq ret=%d\n", rc);
>>> +        } else {
>>> +            rc = amdgpu_irq_put(adev, &adev->vupdate_irq, irq_type);
>>> +            drm_dbg_vbl(crtc->dev, "Put vupdate_irq ret=%d\n", rc);
>>> +        }
>>
>> For completeness in error handling, shouldn't you pass up the return code on non-zero?  It looks like it could pass up to DRM core then.
> 
> It's not shown in the context here, but the rc is passed up later:
> https://elixir.bootlin.com/linux/v7.2-rc4/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c#L295
> 
> - Leo
> 
Ah got it, thanks.  No concerns.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

>>
>>>        } else if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
>>>            if (enable) {
>>> -            /* vblank irq on -> Only need vupdate irq in vrr mode */
>>> +            /* vblank irq on -> Only need vupdate irq in vrr mode
>>> +             * Not ref-counted since we need explicit enable/disable
>>> +             * for DCE VRR handling
>>> +             */
>>>                if (amdgpu_dm_crtc_vrr_active(acrtc_state))
>>>                    rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, true);
>>>            } else {
> 

