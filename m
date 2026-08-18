Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487373E1D0D;
	Tue, 18 Aug 2026 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787048865; cv=none; b=Oc7tnN/94lGnZ1PTLDonjXe5pK+SshxptyFxFZyo62OzBQEUqtHVSKzeNM4jBQDPFaJe7DKOc5x81rPG3mHeAtyWFOFTsayyLThKsFNxqELITNUjXnljLYZBDP2uMqhgjMzES2ToAz3ycYcGaC6UZtbmtDEws/PsfPcTafMssqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787048865; c=relaxed/simple;
	bh=GXgGPEmG2nAL/3V0alBc6f1p3PlfxdbLnEePsmCZkAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1yvbEl1/1CSS4OXRuQmxK9z0hwV8ECDGBJz1RvqpJ3bk1WKlfMcDtBhzjlnHShwlzJK9n7ztx7cEyzxsB3wxSJs+LbMnZ+zboPc6MaYYAcwRJTHX8K43RsRKlUv9yM+eUYev9ka9Pppkelbqbp1Oqe0JltM+aGU2crIRuE9Opk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PnOcOqT1; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PnOcOqT1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=RNau7PoN9jPuhQBuyRX+TK9/M06EXITtJzuKcbQ4VNc=; b=PnOcOqT15LymYMz8g9fk1the1M
	Yc7CVJF3ixz4P3eyghLuh7xnMP4OdkPrYWI08/3r05/5qGp9jBQnbKqLt9ZDsEjFCr8x8iyBLpRFu
	V5FJqkG+999vnqPaP+tChlXte6Rqyo99YCD6akQv8nNpme79LqRFO6YX77t3zEVDDJhlP7+wxQWub
	1poC8yV64Y9beW0DAKXyhZdV+/jTbPtQ3EcJle06pyh7JWN6N/SDCURHlD36LdPuxY3Dtz8CYFBBN
	xiXqTRDa0ahl5zUw+KggbtnY8b0rLrzzUBzZwdehY06lo1Obfsuvi4AbUycXQNx8Q938HR0VRimV9
	SZl25gPA==;
Received: from [31.4.136.12] (helo=[192.168.1.126])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wwH2K-005ZCb-4a; Tue, 18 Aug 2026 12:27:16 +0200
Message-ID: <83e32ca0-56c9-4d3c-b337-a7c01199b4e1@igalia.com>
Date: Tue, 18 Aug 2026 12:27:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: Fix drm_crtc_commit leak if signaled when
 PAGE_FLIP_EVENT is used
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, stable@vger.kernel.org, Leo Li <sunpeng.li@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
References: <20260727-drm_crtc_atomic_commit_leak-v1-1-23d9948a9d7c@igalia.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260727-drm_crtc_atomic_commit_leak-v1-1-23d9948a9d7c@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/07/2026 22:45, Thadeu Lima de Souza Cascardo wrote:
> Commit 1c6ceeee6ebb ("drm/atomic: Fix memleak on ERESTARTSYS during
> non-blocking commits") fixed a very similar issue when the event was
> allocated by drm_atomic_helper_setup_commit() itself.
>
> However, if the event is allocated in prepare_signaling(), it will also be
> set to NULL in complete_signaling(), which prevents drm_crtc_commit from
> being put in __drm_atomic_helper_crtc_destroy_state().
>
> Dropping the reference when the event is set to NULL at
> complete_signaling() fixes the leak.
>
> The leak can be reproduced by sending a signal to the thread using
> DRM_MODE_PAGE_FLIP_EVENT and using a sw_sync fence to cause the atomic
> ioctl to block at drm_atomic_helper_wait_for_fences(). It happened both
> with amdgpu and vkms.

Nice catch!

- Do you have a reproducer or is there an IGT test that triggers this issue?

- cc'ing Leo and Harry as well because they worked on the similar issue 
and must be interested in it.

- I think it should point to stable # v4.11+ as in commit 1c6ceeee6ebb

Reviewed-by: Melissa Wen <mwen@igalia.com>

Thanks!

>
> Fixes: 24835e442f28 ("drm: reference count event->completion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>   drivers/gpu/drm/drm_atomic_uapi.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index e997917819e8..7b951af5ab32 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1563,6 +1563,8 @@ static void complete_signaling(struct drm_device *dev,
>   		 * to prevent a double free in drm_atomic_commit_clear.
>   		 */
>   		if (event && (event->base.fence || event->base.file_priv)) {
> +			if (crtc_state->commit && crtc_state->commit->abort_completion)
> +				drm_crtc_commit_put(crtc_state->commit);
>   			drm_event_cancel_free(dev, &event->base);
>   			crtc_state->event = NULL;
>   		}
>
> ---
> base-commit: d5efb1e1b1d7cd27c642654042f80d19a7ba3caf
> change-id: 20260727-drm_crtc_atomic_commit_leak-4de5e75162b3
>
> Best regards,
> --
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>

