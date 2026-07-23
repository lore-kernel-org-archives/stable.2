Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1442B4908AB
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 19:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834296; cv=none; b=Ev0/ErFzqRMtqgqRax/MokqDUGaYp8It+FwPTazaxodiI39u+s+lqlik2Ey+G3KEBFLyFSkTMT7JuuRlh4N24Id8rwY0VITR2vPETLy+o+LOo/AQXO1k3uxBHqmNyMcKNOF4kmDpdTT/5eMf16/PmKFJmMarVysWmg5GLeinluA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834296; c=relaxed/simple;
	bh=SxhHNamMYTYhpFB8hMQsw64Q2QTp0FnSyrh5fI3suMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ze8mUabpUTyWWgSVwiRN7qTUt3rqJri3sSbnQNu4Dc3WZYd2cWBz4jle4frNrpQvm3PRkE6o+uKK2G93AkS/hW/jKIcN9iwadRqVLkEgUTBvJu9XLUfH5R85cdjRxghINqv0VcCGe7YGApkn5vuiPPT90asOJAIeDEAKqtwpQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAmdzf0+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAmdzf0+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4397F1F000E9;
	Thu, 23 Jul 2026 19:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784834294;
	bh=km/hZgafDxvQG+dMay7Hhcwk8CdfB98TFy88ccWShY4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GAmdzf0+cvKE1gAmkXAWk8B+zn+Ib7HkfIwtz5PxLcatnSgMPYKyUD6QqjEIOuTiC
	 kMMN65vnxEYHLJsm4Bx4k1Lujv7bPxwEwqNQB09p+WT9zkeETHVOjmpedNtaVpRXcj
	 aRXEnRnMpr1ByqvBZ32k689sCEVPlguOODMetlhe/UYZInHT5UoaDXNEscTC1BLLsE
	 p/xgSc6OWm3HbGtZX6qzKsfkyVuNLq7n0rHarxLNWHu2O6q1rOsdC62eGomNvpwMJz
	 y1FNxqrR8j3m6scxvaHcAer3gLB0RiZtwW+zirgs7bWnXaOVak+Xg19ORPTKspdoTN
	 8VcNCWusyHEtw==
Message-ID: <66071e47-2743-48ab-bb3c-8a8ae4ec199d@kernel.org>
Date: Thu, 23 Jul 2026 14:18:13 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix flip-done timeouts on mode1 reset
Content-Language: en-US
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, alexander.deucher@amd.com, stable@vger.kernel.org
References: <20260723180159.52121-1-sunpeng.li@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260723180159.52121-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/23/26 13:01, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> The vblank on/off callbacks mixed use of amdgpu_irq_get/put() and
> amdgpu_dm_crtc_set_vupdate_irq() to enable and disable IRQs.
> 
> With get/put, base driver will callback into DC to disable IRQs when
> refcount == 0. With set_vupdate_irq(), DC is called directly to disable
> IRQs, bypassing base driver's refcount tracking.
> 
> During gpu reset, base driver can restore IRQs via
> amdgpu_irq_gpu_reset_resume_helper() > amdgpu_irq_update(). So if
> get/put() is not used (i.e. refcount == 0), then vupdate_irq will be
> disabled.
> 
> This is problematic if DRM requests vblank on before amdgpu_irq_update()
> is called: drm_vblank_on() > set_vupdate_irq() enables vupdate_irq, but
> the refcount is still 0. gpu_reset_resume_helper() > irq_update() then
> immediately disables it, thus leading to flip done timeouts.
> 
> This is made worse on DCN since VUPDATE_NO_LOCK is the only IRQ enabled.
> Prior to 8382cd234981, a combination of GRPH_FLIP and VSTARTUP IRQs were
> used, and they used get/put(). This explains why 8382cd234981 exposed
> this issue.
> 
> Fix by using get/put() instead of set_vupdate_irq(). DCE is unchanged,
> since it relies on unbalanced enable/disable calls based on VRR status,
> and hence requires direct set_vupdate_irq(). Plus, it also uses
> GRPH_FLIP and VLINE IRQs, which are properly tracked by get/put().
> 
> Cc: stable@vger.kernel.org
> Fixes: 8382cd234981 ("drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_no_lock")
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c  | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 05d6915f9a6b0..079d4ccc88da6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -287,10 +287,19 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
>   	 * is enabled. On DCE, vupdate is only needed in VRR mode.
>   	 */
>   	if (amdgpu_ip_version(adev, DCE_HWIP, 0) != 0) {
> -		rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, enable);
> +		if (enable) {
> +			rc = amdgpu_irq_get(adev, &adev->vupdate_irq, irq_type);
> +			drm_dbg_vbl(crtc->dev, "Get vupdate_irq ret=%d\n", rc);
> +		} else {
> +			rc = amdgpu_irq_put(adev, &adev->vupdate_irq, irq_type);
> +			drm_dbg_vbl(crtc->dev, "Put vupdate_irq ret=%d\n", rc);
> +		}

For completeness in error handling, shouldn't you pass up the return 
code on non-zero?  It looks like it could pass up to DRM core then.

>   	} else if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
>   		if (enable) {
> -			/* vblank irq on -> Only need vupdate irq in vrr mode */
> +			/* vblank irq on -> Only need vupdate irq in vrr mode
> +			 * Not ref-counted since we need explicit enable/disable
> +			 * for DCE VRR handling
> +			 */
>   			if (amdgpu_dm_crtc_vrr_active(acrtc_state))
>   				rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, true);
>   		} else {

