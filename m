Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104940;
	b=tsIMK0WqRKJo345zEwGwn3o24BBGtscYUYiimPhIggOjWwSeVn9o9jzcVhGQxmkqK58R
	 33P3S2kz1epULf+eut8Rf6xqADmYOK7RL0rU6a+/RKEEHwzB9PwhXSJ3qzL62yRyTwDiD
	 I1ckdtyUgYVIaDWsBPAzAPUOyXi2z/cJbAF5NN4z6PV1Zn9ZK2CzRDSq5wwsoSZhy9dYj
	 SrAXKkJfl2fUN/2s6nNW9x2fBRAcEhJG2y2A9ZDFVFfNSVnvjldu/gfNhwGelfGrjlKAq
	 JoLdf8Va7WjuaaTJcWdIjKfrUkYenQpCpv+CyJ2K3Ns09MiLhlI5Dam104CgU39lbEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104940;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=PiV4t28T1jdg2chdhmmFYFRc+kPf1uvncvGOZbGDjx8=;
	b=JVJO3dtqJkNRgvVLX3a/+yXYUJJD9rthF+qS8S+ZwSkkD4XW1b/WBCl/+PKwhqhGDSAY
	 NS/teo6pgeYHcNfllaTcBYEHf8AdlPXFhjyYxfUr02SivR7X5yMdPhIGVnApOA4aqiaDR
	 PGg1AMhHmN+bDZRJlRAuGKSvKduj1dRiRGEvjMCwx/kJHZp/UY38jvT04dcbIAoh5/7II
	 ZRZsGZI0wv9pUSf1JGuf/kNxXrClEVTcxvvzrPwLYNb5zR8DpEe67lyDgeilInnRexO1E
	 BROe7hgiWjyIJfLeV59P7w3ZXQ9xSD/zr7KjtZ7wI3DMo9q8hzpAOH+r6oUKGFpIvvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EofktGYX;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BB8606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 12:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3BB8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EofktGYX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793104939; x=1824640939;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=NMEa5vWU4ZlNJLykssghl9O3s6Ml6pgdhRGqV7VPbts=;
  b=EofktGYXXZJqhklz0WdIAtoHHhE+ceb17RN3HF0G98bNdt0bXPhQaA8S
   RVe21M1VpOr/jh7rVrYJCKpsKlMe7tEakjLi3GXJRqSr+2aUHABKzvGjQ
   B7Ju6GOEQtV8sO42o5a/UDLnPZX8zEkF8SRlPhcbez8ViVTHiA0za+DfE
   eJXRndLM44lOMsI7+63OkikLnHACbFXYJAe90BrKyilG9tE/fqbun2r//
   +/HmQ1ZqM34W6uvqDgS7vViUN755l0yGxIzxG+OBEzmE4qPPyRgA3csjP
   9obz5J6R6abVLTI8juxcJvvQiu3Oq2LQHweimuqLl+Dy3N7zbdfsgJ6Hv
   g==;
X-CSE-ConnectionGUID: mfDZuxc7SnG3GscuwqkPyg==
X-CSE-MsgGUID: uQmK6GGMTRem+P9d0a2ahw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1790040"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1790040"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:42:18 -0700
X-CSE-ConnectionGUID: dSeO7xJfQMOp0jxELMjmdw==
X-CSE-MsgGUID: QgWc/OjfSbaLYded+0PQLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4556012"
Received: from abityuts-desk1.ger.corp.intel.com (HELO [10.245.244.18]) ([10.245.244.18])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:42:16 -0700
Message-ID: <bfb62b44-5fcb-4a41-8dc8-c917d9687d28@intel.com>
Date: Tue, 27 Oct 2026 12:42:13 +0000
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
Subject: Re: [PATCH 1/2] drm/xe/sa: make suballocator waits uninterruptible
From: Matthew Auld <matthew.auld@intel.com>
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
References: <20261022174058.226432-4-matthew.auld@intel.com>
 <20261022174058.226432-5-matthew.auld@intel.com>
 <45831f6088cde19e2885cbbde52574da8a595e18.camel@linux.intel.com>
 <3c39fc90-de66-44a6-936e-06a69219f7af@intel.com>
Content-Language: en-GB
In-Reply-To: <3c39fc90-de66-44a6-936e-06a69219f7af@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/10/2026 10:32, Matthew Auld wrote:
> Hi,
> 
> On 22/10/2026 19:29, Thomas Hellström wrote:
>> Hi, Matt
>>
>> On Thu, 2026-10-22 at 18:41 +0100, Matthew Auld wrote:
>>> Large BO clears and copies in xe_migrate_clear() and
>>> xe_migrate_copy()
>>> are split into multiple passes, each needing a batchbuffer from the
>>> fixed size kernel bb pool. Once the pool fills up, __xe_sa_bo_new()
>>> waits interruptibly for space, so a pending signal (e.g. Xorg's 5ms
>>> SIGALRM smart-scheduler timer) makes it fail mid-loop with -
>>> ERESTARTSYS.
>>> The partial progress is then thrown away and the restarted ioctl
>>> starts
>>> again from byte 0, including the memory allocation, which can
>>> livelock
>>> if the signal arrives faster than the whole operation completes. In
>>> the
>>> shrinker path the same error also aborts the shrinker walk, even
>>> though
>>> ctx->interruptible is false.
>>>
>>> Being interruptible here doesn't seem to buy much anyway: on error
>>> the loop already waits uninterruptibly for all submitted passes
>>> before
>>> returning. So just make the suballocator waits uninterruptible,
>>> matching
>>> amdgpu and radeon. The other users (page reclaim from a kworker, and
>>> the
>>> GuC buffer cache) shouldn't really see any meaningful change.
>>
>> This is a deviation from the "make all waits possible interruptible".
>> One might argue that user-space that interrupts kernel work with a 5ms
>> time only to restart it again and again is not well-behaving and
>> continously shoots itself in the foot.
> 
> Maybe. This is the xserver, so I assume this is very old and not some 
> new thing. I feel like even in this situation the kernel should be able 
> to make some forward progress in the ioctl.
> 
>>
>> Given our pipelining abilities, isn't there a risk that we delay signal
>> delivery with up to 10s?
> 
> At least for the copy/clear, it looks like there is already an 
> uninterruptible wait on the err path if fence != NULL, which we trigger 
> on a signal.
> 
>>
>> In the worst case, is there a way we can periodically at least check
>> for pending signals or perhaps increase the sa bo size so that it
>> doesn't block on a single large buffer?
> 
> Other idea is to expose the intr, and then maybe plumb down the ctx- 
>  >interruptible somehow, which would then cover the shrinker case and 
> maybe other places like that which explicitly asked for that? For the 
> clear case (gem_create) maybe we check if the fence != NULL first and 
> then set intr accordingly? If we have a pending signal it would bail if 
> we have not started GPU clearing yet, but if we have started then we try 
> to finish? The error path will currently do an uninterruptible wait 
> anyway, and that one could be a lot worse for a big buffer, since it 
> drains ALL prior jobs, instead of just waiting for the oldest bb. And 
> here it might be that we got right to the tail end of the clears but we 
> got a signal, so we throw away all of that work.
> 
> Increasing the sa bo is also an option (maybe both). Although I guess 
> there will likely still be something too big, and I guess we might still 
> see issues if the pool is still busy with other pending work?

Some more thoughts. Since Matt nuked the vm_bind GPU path, I don't think 
there is much contention on the reserved bcs any more since there is 
just one migrate queue (?), so maybe we can also:

1. Bump the VRAM clear + identity path. 8M is maybe very pessimistic 
now? Maybe we could push a lot more work per MEM_SET + page mode here? 
This could also give more perf, with a lot fewer jobs for 1G+ buffers. I 
have seen llama.py with 5G+ gemma model use 1G+ buffer on my BMG, for 
example.

2. Maybe also pack more work per-bb, at least for identity? Each new bb 
eats up a bunch of padding for pre-fetch etc.

> 
>>
>> /Thomas
>>
>>>
>>> Assisted-by: LLM
>>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9644
>>> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
>>> GPUs")
>>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: <stable@vger.kernel.org> # v6.12+
>>> ---
>>>   drivers/gpu/drm/xe/xe_sa.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_sa.c b/drivers/gpu/drm/xe/xe_sa.c
>>> index f32045f40b7a..d9c2b28b08c2 100644
>>> --- a/drivers/gpu/drm/xe/xe_sa.c
>>> +++ b/drivers/gpu/drm/xe/xe_sa.c
>>> @@ -165,7 +165,8 @@ void xe_sa_bo_sync_shadow(struct drm_suballoc
>>> *sa_bo)
>>>    * @size: number of bytes we want to suballocate
>>>    * @gfp: gfp flags used for memory allocation. Typically GFP_KERNEL.
>>>    *
>>> - * Try to make a suballocation of size @size.
>>> + * Try to make a suballocation of size @size. Any waits for space
>>> are
>>> + * uninterruptible.
>>>    *
>>>    * Return: a &drm_suballoc, or an ERR_PTR.
>>>    */
>>> @@ -178,7 +179,7 @@ struct drm_suballoc *__xe_sa_bo_new(struct
>>> xe_sa_manager *sa_manager, u32 size,
>>>       if (size > sa_manager->base.size)
>>>           return ERR_PTR(-ENOBUFS);
>>> -    return drm_suballoc_new(&sa_manager->base, size, gfp, true,
>>> 0);
>>> +    return drm_suballoc_new(&sa_manager->base, size, gfp, false,
>>> 0);
>>>   }
>>>   /**
> 

