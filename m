Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795773477;
	b=kLhwwjHOPkLqJ/6L6FMDIBjWO4m1u7c++V+kDi9EfldUCUiIP2dUyo5+dEPNb+PS+kEb
	 zhe23iQzpxa6aM+Wm5NQOg3u6KOXlmpSW42kB0rv0EO0eYKFVXzGknmxKB7Tr083rgEVO
	 QG8MTquaOQ2PSFCiP2wOYh6aqbsiar/XfI4XIHUiXQ46QVUCaup5w4mxjGjOycUvSoQjR
	 WEg1MKIx+huc/kqNi+VS8J/rOp7RJZNM76Mc8j8BIgbyZt7vmL17BKJDGjAlMBr1ir8JN
	 xmdNIMttBjCrqeW7mIZSlLUCe9cqfN7j6ldIyd2euiCbvOCaOjumabJdv2GRELzAAKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773477;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=yXj7w+SlMaiRBUZsn6J/bqUjIs54ac3hp9HOdW3R43o=;
	b=zRLcUON+Evhxg5lCRnE3uya8ihACXc5rMErIV5ZZLTQ/6dSmnRCd3RXBWDYfZe8pKLMj
	 PlipIgwBo3ALhibeoxbGsfU5dOWiJCR1DC6O5Nu+L3mqlRsKP6WJd3/Rpx7f3yxYKUk/p
	 u/aPFChKpbdDFdvI4gFJfNsqoINWrYP7Gj0LlcF4fxQrVfIBrWdl+qWL1fPXMpmnI8kSY
	 aWywYWBS6NiA4FiRU2XbWPCY68GMx/q1J80VKQcS5zZ2UvatHfvEEsenPQaSZ1pycqXkq
	 g32342OySy2nG4JnxXY1l0X+eQnCePK1T3cAouUNsT4g5yJp6jELyXBhfEt13GKop4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=NVnPhQ5Q;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A88B606A31C;
	Fri, 27 Nov 2026 09:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A88B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=NVnPhQ5Q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=yXj7w+SlMaiRBUZsn6J/bqUjIs54ac3hp9HOdW3R43o=; t=1795773476; x=2111133476; 
	b=NVnPhQ5QH077flYaRC4aQxFFc47mhP9BDAd9E+E41GXFh7M3L1QtPrqgM8K5b61gK/zI1muMnft
	jAzP8bFg7zApblLxY/ORv+vE9YInGwOFladMcv8/oH99sfy6VOzqVRXTKP4DkXa0wrDuiU9Wm1bBk
	X6bz6r2lgUE/r5LozM7xHBLadUv+jXkHdB5GmKJlEpfkF3EUscerHsoXAw1mapxYy0vKhHKVpzlzO
	dlpGv3oxs6CGQF3UkyiCyXfD+d18S5F8+1WTmlUYytaW0yEd3m0CmEF0EJpGvT3JN8EVn5x/xufeZ
	kriP5W0bEdmmiaU/mHIIH5XX0otELPQ2YNFw==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xWsiC-00000004jyl-3AGZ;
	Fri, 27 Nov 2026 10:57:48 +0100
Message-ID: <71b2506f-8534-468e-881d-1abf8f8224d9@igalia.com>
Date: Fri, 27 Nov 2026 09:57:47 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Hot-fix timestamp misordering
To: Philipp Stanner <phasta@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Chris Wilson <chris@chris-wilson.co.uk>, Luben Tuikov <ltuikov89@gmail.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 stable@vger.kernel.org
References: <20261126172046.2473303-2-phasta@kernel.org>
 <20261126172046.2473303-5-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20261126172046.2473303-5-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 26/11/2026 17:20, Philipp Stanner wrote:
> dma_fence timestamps could so far be written and read without any memory
> ordering, a bug that presumably got overlooked because x86 is strongly
> ordered.
> 
> Hot-fix amdgpu's manual timestamp evaluation until we found a more
> suitable solution for mainline linux.
> 
> Cc: stable@vger.kernel.org
> Fixes: af0b54167009 ("drm/amdgpu: Convert to common fdinfo format v5")

Not sure the fixes target is strictly correct since timestamp access 
goes even further back, but I guess it is good enough for GPU stats.

Please just add some sort of an impact assessment and bug description to 
the commit text. With that:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 2f0349233695..415f23aa08a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -177,11 +177,11 @@ static ktime_t amdgpu_ctx_fence_time(struct dma_fence *fence)
>   
>   	/* When the fence is not even scheduled it can't have spend time */
>   	s_fence = to_drm_sched_fence(fence);
> -	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->scheduled.flags))
> +	if (!test_bit_acquire(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->scheduled.flags))
>   		return ns_to_ktime(0);
>   
>   	/* When it is still running account how much already spend */
> -	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->finished.flags))
> +	if (!test_bit_acquire(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->finished.flags))
>   		return ktime_sub(ktime_get(), s_fence->scheduled.timestamp);
>   
>   	return ktime_sub(s_fence->finished.timestamp,

