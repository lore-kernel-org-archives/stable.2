Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB13D381E84;
	Tue, 15 Sep 2026 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460333; cv=none; b=VZ3l3GtzjkIgBrYIPRHkL/Tl93bqkMsxaYQmgf5kvqZl/+xh5qMLCKEg6g0MomVQJDuLlmG0ezg+BpVYab6KjrCR2Zz4WAJV0xFC904si4VBfgReNpjGAOgm62aYL8gAAu1c/OWwFXqsU/b2iQNcgGEnBj4Ie4YhGypOsZTwP8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460333; c=relaxed/simple;
	bh=PIQgQghBsdueE4dgI9dfM2FWfe/BnEQPM83C2rqyNVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WsznBv+1fqrA52g1Q83nbomDrhHdoNaFe3NnG2W5LB+9oCVRMJUvifWkvj+gHm7WNrcespnrhJ3GGiJhXbLXpQOclyfj761SE5FEQsBUyW1dTgmBK17chzMXZYze3JjsoK48q0DqgUUIMzsfDZZ3Dp2qyKRze6ivap5JhoXW/Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WS4K5MdW; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WS4K5MdW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=YHezNuYRWZyHUSt4x8zAvLSNvRUq401od9PQb2feT/s=; b=WS4K5MdWs0E9Z8kIFU8fAegauX
	59XxyMclv+z+kSRbsHuwY8aMZkgK2kOrbvHWxHuk5FqaCnTnI7SYJfxs0+A2vM/xoBA9uMN38idg6
	BlTgzm0fmC98cNpfij+VBfPOzsNvXt8xWH5aRPmFQNz0iBjMFkMDFlnegDrmyAjBDXFaZtreOpBcF
	zQ8s4utRgMsNcEgGpa50G6kiwnLwcDGJsg7YmBbDt2qHsV57lkeEgQtVHcOZd5cJq10GRDN5NJQWC
	h4IsEPIQQpSPNO3BgVi7m1UdHcVoDQOlH9rwz1xRTS3cSwU4R24VixBOzygy2Dfil+lh/bgx+DSlY
	A5ZqnZww==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x6ON1-002JiF-2E; Tue, 15 Sep 2026 10:18:26 +0200
Message-ID: <ce2dfef7-9e8a-4ea0-9a21-3498ac66b73a@igalia.com>
Date: Tue, 15 Sep 2026 09:18:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/drm_crtc: ensure dma_fence_ops remain valid
 during device unbind
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Sean Paul <seanpaul@chromium.org>,
 Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>,
 kernel-team@android.com, Simona Vetter <simona.vetter@ffwll.ch>,
 stable@vger.kernel.org
References: <20260721-linux-drm_crtc_fix2-v3-0-afa8c71506e6@linaro.org>
 <20260721-linux-drm_crtc_fix2-v3-1-afa8c71506e6@linaro.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260721-linux-drm_crtc_fix2-v3-1-afa8c71506e6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 21/07/2026 09:21, André Draszik wrote:
> In [1], sashiko reported the following issue:
> 
> === snip ===
> Looking at how these fences are managed, drm_crtc_create_fence()
> creates a dma_fence without taking a reference to the drm_device or
> drm_crtc. Because the sync_file framework exposes this fence to
> userspace, the fence can outlive the CRTC.
> 
> The dma_fence contract requires that data accessed by dma_fence_ops
> (like get_driver_name) must remain valid for an RCU grace period after
> the fence is signaled. However, drm_crtc_cleanup() and the subsequent
> freeing of the device do not wait for an RCU grace period via
> synchronize_rcu().
> 
> If userspace calls ioctl(SYNC_IOC_FILE_INFO) concurrently with a device
> hot-unplug:
> 
> CPU1 (Userspace)
> sync_file_get_name()
>    ops = rcu_dereference(fence->ops);
>    if (!dma_fence_test_signaled_flag())
>      // Preempted or delayed here
> 
> CPU2 (Driver Teardown)
> Signals the fence (setting fence->ops = NULL)
> Destroys and frees the CRTC without waiting for an RCU grace period
> 
> CPU1 (Resumes)
>    ops->get_driver_name(fence) -> drm_crtc_fence_get_driver_name()
>    crtc = fence_to_crtc(fence); // Casts to the freed CRTC
>    return crtc->dev->driver->name; // Use-after-free
> 
> ...
> 
> Does the CRTC or DRM device need to be kept alive for the RCU grace
> period, or should the fence hold a proper reference to prevent the
> use-after-free when get_driver_name() and get_timeline_name() access
> the freed CRTC structure?
> === snap ===
> 
> I believe this to be a correct observation and this patch implements
> the suggestion of waiting for an RCU grace period before proceeding
> with destruction of the drm_crtc, so that get_driver_name() and
> get_timeline_name() can still work.

Presumably these fence are exportable via syncobj and/or sync file? If 
so, your analysis seems correct to me. Fix as well looks it works to 
close the vulnerability, but the part I cannot help with, and which will 
need someone more familiar with the CRTC code and the associated object 
lifetimes, is to comment on whether a RCU delay in drm_crtc_cleanup() is 
acceptable or it must be made async one way or the other.

Regards,

Tvrtko

> Link: https://sashiko.dev/#/patchset/20260618-linux-drm_crtc_fix2-v1-1-c03e77b36f34@linaro.org?part=1
> Fixes: 6d6003c4b613 ("drm/fence: add fence timeline to drm_crtc")
> Cc: stable@vger.kernel.org
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> 
> ---
> v3:
> - Philipp: update kerneldoc, add Fixes:
> 
> v2: new patch
> ---
>   drivers/gpu/drm/drm_crtc.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index 63ead8ba6756..e8e80c936852 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -493,14 +493,23 @@ EXPORT_SYMBOL(__drmm_crtc_alloc_with_planes);
>    * drm_crtc_cleanup - Clean up the core crtc usage
>    * @crtc: CRTC to cleanup
>    *
> - * This function cleans up @crtc and removes it from the DRM mode setting
> - * core. Note that the function does *not* free the crtc structure itself,
> - * this is the responsibility of the caller.
> + * This function cleans up @crtc and removes it from the DRM mode setting core,
> + * after first waiting an RCU grace period to ensure @crtc->dev can safely be
> + * dereferenced by our dma_fence_ops.
> + *
> + * Note that the function does *not* free the crtc structure itself, this is the
> + * responsibility of the caller.
>    */
>   void drm_crtc_cleanup(struct drm_crtc *crtc)
>   {
>   	struct drm_device *dev = crtc->dev;
>   
> +	/* Ensure our dma_fence_ops remain valid for an RCU grace period after
> +	 * the fence is signaled. This is necessary because our dma_fence_ops
> +	 * dereference crtc->dev.
> +	 */
> +	synchronize_rcu();
> +
>   	/* Note that the crtc_list is considered to be static; should we
>   	 * remove the drm_crtc at runtime we would have to decrement all
>   	 * the indices on the drm_crtc after us in the crtc_list.
> 

