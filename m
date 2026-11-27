Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795773320;
	b=i4OhyjMgvhc/y7/Ey4GBh3dq3fPuG4FmI0AcLN3iF9/IWv++jQeiPzwVb1WGsQvJFDMj
	 y6sWnzbUMo3Sxm7t3K2Oj9izyrNzcUxd6jQuPRZMfUOfxzYTkp+DPFzrk4P/JD99/jNeT
	 2qPulYsWegSvJhg/FWaD9ij1t45Y7P6b9BWzOZCGjpWKLbqTlnQWUzuLc2FL0QrJVw06x
	 R7rYLl/DXJ763WyuYZzU5zVKQaUQNHV19G8U6xuzKwIIt6tw9EHol4DsNH+7WYmSrKB+b
	 B9+x91giTrCGTsVmar4xRgVcoQWynhnFK9Jwo/aLBlApVJdG729tn+axCgFlAa35tHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773320;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=dTrW+ugQeCUDhYN5x3PZPy/j2Ws0a4l3FCniePr73/o=;
	b=lSv+DbEOYCSAWboe3Owb0uwkN88bKl7zkeku/NDFcqfVO20x2dddJa1jGdVhdGFeIdAq
	 RdVMe4CJT7DmY5vt/AvyJJ2u7Yj+0YkFjDrb+Wz794fuJrDUmKzlAVXNHoul5OlxujGN2
	 otTRFbZozfkIEM3p9KxndjuW1oa4wluiBtfaBwsX+mHylkNJ7Sh4hLooOKt0CfJxnymK7
	 m3rFZGflBiYF+G44V7IykLNpk80t8J5Df3XqWcV8UK3kehuKhelcptfUAgNFotIuNazVI
	 QYgdoaF3YpY1q1igYP3q9eukRAfGdUlSJSBJwsZQdXcysuYmVWd2UVun1NBFp2BRUrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=SnRfAqTi;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A0B606A338;
	Fri, 27 Nov 2026 09:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07A0B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=SnRfAqTi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=dTrW+ugQeCUDhYN5x3PZPy/j2Ws0a4l3FCniePr73/o=; t=1795773318; x=2111133318; 
	b=SnRfAqTiqSZJiQY4+12cRCdtpdSKcKCu9pGQl9t2ajSUN4F9uN6s6wpSW6BO1pWAGxzniFDwB9K
	qJMbg8yjbX/QiESGzuYlByuCZSUt/FJyonb8Ag0UawIApvVbMRz4tBYUVwrCLwXffXMZWoM5GD8zp
	NIiiVdIVLnrbrYqJM8xvpELC+Xakvtd199R+i8zgDGDJsaVGRxkZeS4ZlsWG1LZv2p6a4dk4n/c4G
	8JYH2UJhkrqSlU2T4cE/HA/mvDf7ThOBIWGtZRQteoi7XEJMaiRADqs3z+8XlhuXoEpABP3wndqlR
	RaSH76eWRGApvQm7v5i58tj73YtobedbsZxg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xWsfd-00000004jsI-2PMn;
	Fri, 27 Nov 2026 10:55:09 +0100
Message-ID: <50bf27a3-5475-4bc4-83ee-37312c7e4e1e@igalia.com>
Date: Fri, 27 Nov 2026 09:55:08 +0000
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
Subject: Re: [PATCH 2/3] drm/sched: Hot-fix timestamp misordering
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
 <20261126172046.2473303-4-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20261126172046.2473303-4-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 26/11/2026 17:20, Philipp Stanner wrote:
> dma_fence timestamps could so far be written and read without any memory
> ordering, a bug that presumably got overlooked because x86 is strongly
> ordered.

Perhaps say that this particular patch fixes the store ordering of the 
timestamp overwrite. IIUC at least.

> Hot-fix the scheduler's manual timestamp evaluation until we found a
> more suitable solution for mainline linux.
> 
> Cc: stable@vger.kernel.org
> Fixes: f7fe64ad0f22 ("drm/sched: Split free_job into own work item")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 99252674e266..3d26a48ff1c3 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -928,8 +928,16 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler *sched)
>   		next = list_first_entry_or_null(&sched->pending_list,
>   						typeof(*next), list);
>   		if (next) {
> -			/* make the scheduled timestamp more accurate */
> -			if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
> +			/* Make the scheduled timestamp more accurate.
> +			 *
> +			 * TODO
> +			 * The test_bit_acquire() is a hotfix against timestamp
> +			 * misordering. Replace it with something better.
> +			 *
> +			 * The counter-part of the barrier is located in
> +			 * dma_fence_signal_timestamp_locked().

Instead of more or less duplicating the TODO perhaps putting a link to 
dma_fence_timestamp_locked somehow would be better. Up to you.

> +			 */
> +			if (test_bit_acquire(DMA_FENCE_FLAG_TIMESTAMP_BIT,
>   				     &next->s_fence->scheduled.flags))
>   				next->s_fence->scheduled.timestamp =
>   					dma_fence_timestamp(&job->s_fence->finished);

With the improved commit message:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

