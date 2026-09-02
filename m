Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CB4412294;
	Wed,  2 Sep 2026 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342849; cv=none; b=n0D6rQ0bijjQ3fodMkudfsuCIq9yz90GqpirPnPq0Q1SNLmLkzSmWpTEnq9V81k5LVBS0p+BWs8+mopBetm6oFccAcl+RfRKN57cClMSyiBvQq8hE4FnRpd5yi8ZQKFYku3ecLzlaQsRvIZ2A2bWTq+GgXPEV1K0tFmkZKJizHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342849; c=relaxed/simple;
	bh=PGg9lP2Vu2JapsC19KC0peT6vj8SXd2YgVh9w2vIyeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4eShJqs/Oq8xGYOrK2PmjlhFm89KS93ZNzsmvsRZ0mGyrAM2INpnnN63pYmmrGEou9i4iAulOSgSThiaWRMTPnCnsoQhZOo+/t/6NMHLhxMdhcxL5ZPMBRh9pxPxcmxUTQNeJfFpwMJtCcNbxwDWZZRNO/QPs5KX5VKSVGzpEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DzYsR1Xm; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DzYsR1Xm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=jD7P48a+Ai8p/nM8j7bf7oiECWwi/PGlJzuPNjEbk7c=; b=DzYsR1Xmhlnyn2jTCLSQs8b2NB
	NA481BIqHhs8o3F6IJHvs9UkcLaOa2+LlUA9CnYkJhN0a0rUgKWDDuWpqTD+/UDf3yrs07gK0Zi49
	T59+cyQ2VRyPEvWo0rJHR4CpdwqON18Zx9/Uu5UBdudijsnUydI9WrpJ73J/KdRc/rusKCc2UkAan
	TjBw84AvxLobwNLTTMGaamvuOb3tKpJ/mfjOK35PacVmwNYpvZkthGpRd/UiwrNwLNBCVfzkH0x9C
	1xIj9DETwp8kwF2PaQjY0Cjy0Rq4awiJd0abWF/RdJisBMLylnQeiaGhbtv3c01erAEmB1/ePmhus
	oaFmkHHA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x1hee-00DNgY-S5; Wed, 02 Sep 2026 11:53:16 +0200
Message-ID: <3c2a131b-af05-4aef-bf5f-4742ceab2170@igalia.com>
Date: Wed, 2 Sep 2026 10:53:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/qxl: fix use-after-free and NULL pointer deref
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 devel@lists.crash-utility.osci.io
Cc: Gemini <gemini@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Dave Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 stable@vger.kernel.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260828085136.128561-1-jirislaby@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260828085136.128561-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 28/08/2026 09:51, Jiri Slaby (SUSE) wrote:
> When allocating a `qxl_release` structure with `kmalloc()`, the underlying
> memory contained uninitialized garbage. Specifically, `release->base.flags`
> (part of the embedded `dma_fence`) was not cleared.
> 
> This garbage in `base.flags` caused helper functions such as
> `dma_fence_was_initialized()` to return true even for releases where the
> fence was never actually initialized (e.g. via `dma_fence_init()`).
> 
> Consequently, during release cleanup in `qxl_release_free()`, the driver
> attempted to put/free an uninitialized `dma_fence`, leading to refcount
> underflows (`refcount_t: underflow; use-after-free`) and subsequent NULL
> pointer dereferences in `dma_fence_signal_timestamp_locked()`.
> 
> Fix this by switching from `kmalloc()` to `kzalloc_obj()` in
> `qxl_release_alloc()`, ensuring all fields (including embedded fence
> flags) are properly zero-initialized upon allocation, and remove
> redundant explicit zero-initializations.
> 
> The dumps in question:
>   refcount_t: underflow; use-after-free.
>   WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90, CPU#0: kworker/0:0/1534
>   Modules linked in: af_packet nft_fib_inet ...
>   CPU: 0 UID: 0 PID: 1534 Comm: kworker/0:0 Not tainted 7.1.3-1-default #1 PREEMPT(full) openSUSE Tumbleweed  b041a6527f6e58424f4cd3de0fade8d408b378fd
>   ...
>   RIP: 0010:refcount_warn_saturate+0x59/0x90
>   ...
>   Call Trace:
>    <TASK>
>    qxl_release_free+0xee/0xf0 [qxl d93e9381353e619799d56790f5f8dda6cce491f6]
>    qxl_garbage_collect+0xd1/0x1b0 [qxl d93e9381353e619799d56790f5f8dda6cce491f6]
>    process_one_work+0x19e/0x3a0
>   ...
> 
> And then of course:
>   BUG: kernel NULL pointer dereference, address: 0000000000000028
>   ...
>   RIP: 0010:dma_fence_signal_timestamp_locked+0x32/0x120
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Assisted-by: Gemini <gemini@google.com> # only commit log
> Fixes: 2bcbc706dfa0 ("dma-buf: add dma_fence_was_initialized function v2")
> Closes: https://bugzilla.suse.com/show_bug.cgi?id=1271081
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: stable@vger.kernel.org
> ---
> Cc: virtualization@lists.linux.dev
> Cc: spice-devel@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> 
> [v2] use kzalloc_obj() instead of bare kzalloc()
> ---
>   drivers/gpu/drm/qxl/qxl_release.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
> index 06979d0e8a9f..07dc6eafe6f7 100644
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -89,17 +89,13 @@ qxl_release_alloc(struct qxl_device *qdev, int type,
>   {
>   	struct qxl_release *release;
>   	int handle;
> -	size_t size = sizeof(*release);
>   
> -	release = kmalloc(size, GFP_KERNEL);
> +	release = kzalloc_obj(*release);
>   	if (!release) {
>   		DRM_ERROR("Out of memory\n");
>   		return -ENOMEM;
>   	}
> -	release->base.ops = NULL;
>   	release->type = type;
> -	release->release_offset = 0;
> -	release->surface_release_id = 0;
>   	INIT_LIST_HEAD(&release->bos);
>   
>   	idr_preload(GFP_KERNEL);

Looks plausible on a superficial look, albeit fragile. I am not sure why 
qxl_release_alloc wasn't calling dma_fence_init in the first place?

Regards,

Tvrtko

