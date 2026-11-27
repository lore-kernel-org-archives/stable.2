Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795772653;
	b=wBl1cV5p5qpg9AK+tf69Ix00o7fL0AnhC/iojEc4o0ExYc2kqM6/usdnM59sE4f9fH+e
	 ti23uKQTe23sDHkC1kSkWsWbo2ppdmN3Vs+MUde41ATrBewfxlKd1jkBZXMFiGwuv4Svq
	 LdyPJF8E1FotxPTizDDZ4XVRfu+5dsoDHAXJ2OnCNEnAfNnZeByV8HUf7mWWH3PBPpPpN
	 +ag8WHaO+0wJPXN89fG1P9CJURCLegfBJkl2LzHTeyRY5E6xvb04W8R0EbNU5BmIGn2F7
	 gloqI6D19jUP63puuSoBkbDJSSaaiS9dBMox1dgeTrVCXOK1e9KOxjrWYxiOwhFZ6UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772653;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=YS6RQcF5xRu5MqtlX1y7izCl88BcWh1ymA2UFCjdAF0=;
	b=i693M/hkdpp66QnTUPteWwtaB1E9hoiQ3BvwHODE/NlJX8IsBX7is3vtn0GjGlf7ItlR
	 ggD7JLpPQRRRfsAblPrZVlLaKR9MHZwixK9PB8apoxg5HNx7fDeUIarEr9li5x/iFDe71
	 /8jBGRtzchs8m+nRcoPk7gBmmrRtIOx/rAG170+1P3QaKAMwfwiZ/68mVI5zezC+R2Was
	 W4F3Ixn+FNmdNM5xkaRnO1XFPBBscduH6ZnESMKIPS7qIMGPjC5OM1aM1yiytQytdjKMZ
	 P08gfN1Zo93LeAH3Ai1ncup2A8ksR8JABsHxLUsFmbt1IDVAdZcquucaoX1dGtOCQ8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=mTaVJDFk;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57746606A31C;
	Fri, 27 Nov 2026 09:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57746606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=mTaVJDFk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=YS6RQcF5xRu5MqtlX1y7izCl88BcWh1ymA2UFCjdAF0=; t=1795772651; x=2111132651; 
	b=mTaVJDFkShjJKh8dsc83+dB7u4y/zPTLXP9z7Se6FV72xEQQohtEkgsUXsaqd5BAtUaILZabqKf
	CeB1c9ywCEuVVtdSYaW4CoJtabs59YnHDTjmFciAexZ/qUKc+RcfMXR6y/Uh0OTt1833yIMaLdBes
	rWd2ujoZnDIR2UX/GDsePAbbzOcGmKwMF7zSnZOyCdNdvVjbMbQ9vmSd3vz6wpvhLuqlgqxNrNc+v
	aNvgSq0vzO/5O/COFmNkzastTVoTLfcF+qh4z0bQx3djz2DWYG9GguqWlKph9R+G1pIouCiNt6CVt
	BvF32oW56wrh/zR1hEFvbCezBgqNKL0qbsiw==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xWsUo-00000004jhB-2KyE;
	Fri, 27 Nov 2026 10:43:58 +0100
Message-ID: <d01bbab4-9741-462a-bf98-0d4eacec48e8@igalia.com>
Date: Fri, 27 Nov 2026 09:43:56 +0000
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
Subject: Re: [PATCH 1/3] dma-buf: dma-fence: Hot-fix timestamp misordering
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
 <20261126172046.2473303-3-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20261126172046.2473303-3-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 26/11/2026 17:20, Philipp Stanner wrote:
> fence timestamps can be written and read without any memory ordering
> since, presumably, forever. This can cause real bugs, other than false
> accounting, for parties whose algorithms depend on the timestamp.
> 
> Hot-fix the problem for now so that it can be backported until we found
> a suitable way forward for mainline.
> 
> Cc: stable@vger.kernel.org
> Fixes: 76250f2b743b ("dma-buf/fence: Avoid use of uninitialised timestamp")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   drivers/dma-buf/dma-fence.c | 9 +++++++++
>   include/linux/dma-fence.h   | 8 ++++++--
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index bd58688b81a7..8a842fc8168f 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -378,6 +378,15 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>   	list_replace(&fence->cb_list, &cb_list);
>   
>   	fence->timestamp = timestamp;
> +	/*
> +	 * TODO:
> +	 * This is a temporary hotfix to prevent misordering until we
> +	 * can completely remove the TIMESTAMP bit.
> +	 *
> +	 * The counterpart of this barrier are the test_bit_acquire()s in
> +	 * dma_fence_timestamp().
> +	 */
> +	smp_mb__before_atomic();
>   	set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
>   
>   	list_for_each_entry_safe(cur, tmp, &cb_list, node) {
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index 64330bf52561..6b16095e8521 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -715,10 +715,14 @@ static inline void dma_fence_set_error(struct dma_fence *fence,
>    */
>   static inline ktime_t dma_fence_timestamp(struct dma_fence *fence)
>   {
> -	if (WARN_ON(!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
> +	/*
> +	 * The test_bit_acquire() calls order against the
> +	 * smp_mb__before_atomic() in dma_fence_signal_timestamp_locked().
> +	 */
> +	if (WARN_ON(!test_bit_acquire(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
>   		return ktime_get();

This one I think could stay as is since there is no point to have two 
barriers in sequence.

>   
> -	while (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
> +	while (!test_bit_acquire(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
>   		cpu_relax();
>   
>   	return fence->timestamp;

The rest looks good to me.

I would also probably expand the commit message to actually explain what 
practical bugs and races the patch on its own fixes. Which would be all 
callers of dma_fence_timestamp, right? AFAIU they are all vulnerable to 
observing missing/torn timestamp on weakly ordered architectures.

Regards,

Tvrtko

