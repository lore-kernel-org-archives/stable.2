Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620764;
	b=eXEGft3QV+bYTkxrDnZmsKumFtMtTUKQB5HJ14JnvEu+nkJ8KbrNQiz9o/Py8aT8TI59
	 Esea7zu+VxiFwH5m1IRHXO6Zn6yJmkF/R8gAwUmrTnzy7CBhd+ogn4NeAEpfsV9FNlJdr
	 dFTRGlOuOfLv6R56IDunCN6SbNh+faaXYKNGjdARpKmPGGZM+fyeZPKP6Z1rxup1TKtN8
	 5Jx1P7Toa6TDGpaJ7MncDEzEIIG8slnRoRU0zDxjcJ4IYWympH0Fbz2nCezS8ntP0mTrA
	 J7AXyzrBiIeB6WpWzVvaeCNO0JxsSm6iblglpZuwaAp8cCGD12JBfK7dgf1KfkliJJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620764;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=qjZmhB0D2gecYmNthDf7uJSiXDSWCePkn63QEElcbko=;
	b=SwL9rkclSumhJYsS/vpKk46V1HL3NYMhJl1a1z8QztXxwxbiJ9qOIEMBr+tCFbq39pV0
	 UgxXbe1+tPzZcdA+uYXQUAgzzpYufT25SaJCC1AG8O4865cF0u90iXDlbr60JZkNWsFwF
	 8GVjZRgw/TvKziULv9RCXu23SPbLmDEqCUl/tl/qrOBtvrs94Mm4eweHxLSV3uC+Iq/xH
	 00E0b7PM8EqghZzx1XT0J274Qbf4kiP+55IK2vvy8ab5bPaOMZTtwe3C/auOUkUAr446l
	 ygskwont9nw9jDtUrXhQw9LFnpadK/bfxNOK4g+OquXLOETO0YW5nsVyNPb00Ag9mAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=j7V2C1fi;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82885606B177
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 11:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82885606B177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=j7V2C1fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=qjZmhB0D2gecYmNthDf7uJSiXDSWCePkn63QEElcbko=; b=j7V2C1fi3CfsAJdVXz2KWQR7aN
	G/XKD0KEH5Mt4dwmpvuTO2eT2a/6z/UxYDQfZu7eoSkclRRS/E7TvBjQ4XqtKk1Aa9WUXPX73P4WE
	EBA80UwV35pOOVwRNvWJ7tHrGvjgYNI3xgjQVHYRCoK3oBfV1Yz1qoIuwpGXbK3VZqao5jaBYPv8R
	hUNctlHjs1EJTXrRvhszfokhboT/OSVvb2vJpLOlc47AmYJBRc5Zu/DtncZuvx/YERyPTMYD9lqKw
	lZlVW02oNjin0eLTjBziQQak7PTan2HIKZingrp+vOpjc+mkEuA/vQAoRf8ZOx/xgO1nuHd/rpTGX
	hH2pM2Zw==;
Received: from [77.26.4.178] (helo=[192.168.50.64])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xNqh3-0005q2-JO; Mon, 02 Nov 2026 12:59:17 +0100
Message-ID: <07e43f0f-40c1-4a87-8ab0-baf46fe50e08@igalia.com>
Date: Mon, 2 Nov 2026 12:58:51 +0100
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
Subject: Re: [PATCH] drm/v3d: Widen cache_clean_lock over the whole L2TCACTL
 sequence
To: Iago Toral <itoral@igalia.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Melissa Wen <mwen@igalia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 stable@vger.kernel.org
References: <20260707200738.659002-2-mcanal@igalia.com>
 <e65137e19a8773a2f760531034481e0df60071d4.camel@igalia.com>
 <f51d745c-c383-4d19-ac51-af9c69a83ba8@igalia.com>
 <a43ba189b507567e8ddd3d958859c14334356c2d.camel@igalia.com>
From: Chema Casanova <jmcasanova@igalia.com>
Content-Language: en-US
In-Reply-To: <a43ba189b507567e8ddd3d958859c14334356c2d.camel@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Maíra, Iago,

Finally, this is not only theoretical. On Raspberry Pi 4 the race
causes order-dependent dEQP-VK failures in robustness *.vert and
buffer_device_address: TMU writes from a job are still in flight when
its fence signals. I reached an equivalent soution to address this issue:

- 51-case robustness list: 41/1000 runs failing → 0/1000
- full robustness vertex list: 7/8 → 0/8
- full buffer_device_address: 3/8 → 0/8

The impact on Pi 5 on GfxBench GL-ES and Vulkan (Aztec, Manhattan, 
T-Rex, Egypt)
stay within ±0.1%, which is run-to-run noise.

Reviewed-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>

El 16/7/26 a las 7:52, Iago Toral escribió:
> Thanks, if we don't see any impact on performance on Pi5, this is:
>
> Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
>
>
> El mié, 15-07-2026 a las 10:46 -0300, Maíra Canal escribió:
>> Hi Iago,
>>
>> On 15/07/26 03:16, Iago Toral wrote:
>>> Hi Maíra,
>>>
>>> has this change fixed anything?
>> Not real bug, just the theoretical race-condition between
>> v3d_clean_caches() and v3d_flush_l2t().
>>
>>> Also, I believe that GFXH-1897 is exclusive to Pi4. Have you tested
>>> if
>>> this change has any visible performance impact on Pi5?
>> I'll test it, however I don't imagine it would have a impact, as the
>> race condition should be rare enough. We would need a CACHE_CLEAN job
>> running simultaneously to v3d_invalidate_caches().
>>
>> One thing I believe it might be possible is to skip a flush if a
>> flush
>> is already happening, but it would be a micro-optimization.
>>
>> Best regards,
>> - Maíra
>>
>>> Iago
>>>
>>>
>>> El mar, 07-07-2026 a las 17:05 -0300, Maíra Canal escribió:
>>>> v3d_clean_caches() and v3d_flush_l2t() both write the single
>>>> L2TCACTL
>>>> register and poll its status bits. The mutex cache_clean_lock
>>>> exists
>>>> to
>>>> serialize them, but v3d_clean_caches() only took the lock around
>>>> its
>>>> final
>>>> FLM_CLEAN write.
>>>>
>>>> These functions run concurrently: v3d_flush_l2t() is issued from
>>>> the
>>>> BIN/RENDER/CSD invalidate path while v3d_clean_caches() runs from
>>>> the
>>>> CACHE_CLEAN queue, and each queue's scheduler uses its own
>>>> ordered
>>>> workqueue, so their run_job callbacks execute in parallel.
>>>>
>>>> Because clean locked only its final write, a concurrent flush can
>>>> write
>>>> L2TCACTL during clean's unlocked phase. Both use non read-modify-
>>>> write
>>>> writes to the one register, so whichever lands last wins: clean's
>>>> TMUWCF
>>>> write can land on the flush's in-flight L2TFLS invalidate,
>>>> triggering
>>>> the
>>>> GFXH-1897 hazard of writing L2TCACTL while a flush is pending.
>>>>
>>>> Hold cache_clean_lock across the entire L2TCACTL access sequence
>>>> so
>>>> it
>>>> is fully mutually exclusive with v3d_flush_l2t(), which already
>>>> takes
>>>> the
>>>> lock around its own write.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: abf888b03a98 ("drm/v3d: Wait for pending L2T flush before
>>>> cleaning caches")
>>>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>>>> ---
>>>>    drivers/gpu/drm/v3d/v3d_gem.c | 5 ++---
>>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c
>>>> b/drivers/gpu/drm/v3d/v3d_gem.c
>>>> index c43d9af41374..e597b6fd47c4 100644
>>>> --- a/drivers/gpu/drm/v3d/v3d_gem.c
>>>> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
>>>> @@ -204,6 +204,8 @@ v3d_clean_caches(struct v3d_dev *v3d)
>>>>    	struct drm_device *dev = &v3d->drm;
>>>>    	int core = 0;
>>>>    
>>>> +	guard(mutex)(&v3d->cache_clean_lock);
>>>> +
>>>>    	trace_v3d_cache_clean_begin(dev);
>>>>    
>>>>    	/* GFXH-1897: Ensure pending flushes complete before
>>>> writing
>>>> L2TCACTL */
>>>> @@ -220,7 +222,6 @@ v3d_clean_caches(struct v3d_dev *v3d)
>>>>    		drm_err(dev, "Timeout waiting for TMU write
>>>> combiner
>>>> flush\n");
>>>>    	}
>>>>    
>>>> -	mutex_lock(&v3d->cache_clean_lock);
>>>>    	V3D_CORE_WRITE(core, V3D_CTL_L2TCACTL,
>>>>    		       V3D_L2TCACTL_L2TFLS |
>>>>    		       V3D_SET_FIELD(V3D_L2TCACTL_FLM_CLEAN,
>>>> V3D_L2TCACTL_FLM));
>>>> @@ -230,8 +231,6 @@ v3d_clean_caches(struct v3d_dev *v3d)
>>>>    		drm_err(dev, "Timeout waiting for L2T clean\n");
>>>>    	}
>>>>    
>>>> -	mutex_unlock(&v3d->cache_clean_lock);
>>>> -
>>>>    	trace_v3d_cache_clean_end(dev);
>>>>    }
>>>>    
>>
