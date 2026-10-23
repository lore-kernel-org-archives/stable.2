Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747952;
	b=iWAwGITuIcot6YPwgz94cIqg2AXNidIRrHeTRGmyASSuh6JhYWzN6OCArk6TkIodZ2KF
	 y2wdehKUjD4939fdOlDU31zwIrTpSxYVC3haTZ14gE5uQ2cCezYbBgNz3b8Y+MVrcCfX6
	 uIJ5GofEBpAjSh1LX0pLeGvmlqJpaVz2OGa90D1DqhV2vdXc8fu1AKj6fHiRvbDPUxkP2
	 vrJzpeAWHXUKM57yiiTzlyqWxRZh3+gF00TUYioaYjsfopJfO+/lLKPJoYRenGxI5kI3I
	 +VuRDmmYrRIk/7raiVnH/DEW1rN4SwvEoOeQfZkiQowcuyXqZRrb8X5kQVzozeuO+1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747952;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=sdHlSasst88Y6O9qgimO0tovKSQmsl8c6RQ8dmFcUYc=;
	b=WSOd/dtTPkzIF4XB/hP9Q0dSRWoK21MGFX6lt+CmTqonNtPhTbF+FrDfGQt7r9jlPhL5
	 NJQBSn+sZ30jis1ePTRRFRUZUPncHpNQvuampdH/gVCRzppk4w6WhgTqPb2MzBKeUlynj
	 F/hs6GTJD03vG405DokcEDZKd5hnaF1Vn4y1Aia9tHKUG6/WTR3USiVHhRkujXROBO5eJ
	 N2rvTzQ0mMbGtuBxMNp5IT4yBWXulBYPh0ZRfhQhI+14uSBcMuYH2dzcpxqn4jZZwJHPJ
	 pVu+0v1AFblJaOC5gnXPRZQX36rOROr+DvN7hxKuwEE8SXtl7l1xGNS/sg8lIhQacIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cVLb65GJ;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B565606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B565606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cVLb65GJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792747952; x=1824283952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yBFryrDc6gJNld0Q93K4y576EnkuaK82ETZwMZ1QqNA=;
  b=cVLb65GJ/bIpMTyNHMFvztt8thgT3lUmLe2v33YW5OWo1N1K0cBPq1V/
   UzSCOMk68EMJKf7loIDDEtV9/x4IXVCB206Iw9B2GnW7hdjIHUn0Lj5M+
   QN+sm/sVPohmLSLKkvPlYLaWaTVdNVo2E+TXgVcyhVdk5rbmVI+HASiWi
   uv8lpWnjnDGsBD6VIA86KLk+3Jitg0hiPqIG3GORv/uxILpZVlaGwTI0+
   G2a1kMw5Vq5tqti9XKkF6Gj3Ie5BscKgHhCsaDH+OkTp9XYU23PJNWoYG
   tK4r8hVEX9XDQ1npev1XedDB5V4TgohF3VGvAI5RQARiBbXmotgWGDg34
   Q==;
X-CSE-ConnectionGUID: NWhQgQjkSXWg8vavrWrdTw==
X-CSE-MsgGUID: AtRNbRMaRjaOEW1/i9qJpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1401572"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1401572"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 02:32:29 -0700
X-CSE-ConnectionGUID: 5kZcco+QRfqQgDijM7RtiQ==
X-CSE-MsgGUID: b32kVHmORaSJdVmq9ZdlGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3709696"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO [10.245.244.145]) ([10.245.244.145])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 02:32:28 -0700
Message-ID: <3c39fc90-de66-44a6-936e-06a69219f7af@intel.com>
Date: Fri, 23 Oct 2026 10:32:25 +0100
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
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
References: <20261022174058.226432-4-matthew.auld@intel.com>
 <20261022174058.226432-5-matthew.auld@intel.com>
 <45831f6088cde19e2885cbbde52574da8a595e18.camel@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <45831f6088cde19e2885cbbde52574da8a595e18.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 22/10/2026 19:29, Thomas Hellström wrote:
> Hi, Matt
> 
> On Thu, 2026-10-22 at 18:41 +0100, Matthew Auld wrote:
>> Large BO clears and copies in xe_migrate_clear() and
>> xe_migrate_copy()
>> are split into multiple passes, each needing a batchbuffer from the
>> fixed size kernel bb pool. Once the pool fills up, __xe_sa_bo_new()
>> waits interruptibly for space, so a pending signal (e.g. Xorg's 5ms
>> SIGALRM smart-scheduler timer) makes it fail mid-loop with -
>> ERESTARTSYS.
>> The partial progress is then thrown away and the restarted ioctl
>> starts
>> again from byte 0, including the memory allocation, which can
>> livelock
>> if the signal arrives faster than the whole operation completes. In
>> the
>> shrinker path the same error also aborts the shrinker walk, even
>> though
>> ctx->interruptible is false.
>>
>> Being interruptible here doesn't seem to buy much anyway: on error
>> the loop already waits uninterruptibly for all submitted passes
>> before
>> returning. So just make the suballocator waits uninterruptible,
>> matching
>> amdgpu and radeon. The other users (page reclaim from a kworker, and
>> the
>> GuC buffer cache) shouldn't really see any meaningful change.
> 
> This is a deviation from the "make all waits possible interruptible".
> One might argue that user-space that interrupts kernel work with a 5ms
> time only to restart it again and again is not well-behaving and
> continously shoots itself in the foot.

Maybe. This is the xserver, so I assume this is very old and not some 
new thing. I feel like even in this situation the kernel should be able 
to make some forward progress in the ioctl.

> 
> Given our pipelining abilities, isn't there a risk that we delay signal
> delivery with up to 10s?

At least for the copy/clear, it looks like there is already an 
uninterruptible wait on the err path if fence != NULL, which we trigger 
on a signal.

> 
> In the worst case, is there a way we can periodically at least check
> for pending signals or perhaps increase the sa bo size so that it
> doesn't block on a single large buffer?

Other idea is to expose the intr, and then maybe plumb down the 
ctx->interruptible somehow, which would then cover the shrinker case and 
maybe other places like that which explicitly asked for that? For the 
clear case (gem_create) maybe we check if the fence != NULL first and 
then set intr accordingly? If we have a pending signal it would bail if 
we have not started GPU clearing yet, but if we have started then we try 
to finish? The error path will currently do an uninterruptible wait 
anyway, and that one could be a lot worse for a big buffer, since it 
drains ALL prior jobs, instead of just waiting for the oldest bb. And 
here it might be that we got right to the tail end of the clears but we 
got a signal, so we throw away all of that work.

Increasing the sa bo is also an option (maybe both). Although I guess 
there will likely still be something too big, and I guess we might still 
see issues if the pool is still busy with other pending work?

> 
> /Thomas
> 
>>
>> Assisted-by: LLM
>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9644
>> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
>> GPUs")
>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.12+
>> ---
>>   drivers/gpu/drm/xe/xe_sa.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_sa.c b/drivers/gpu/drm/xe/xe_sa.c
>> index f32045f40b7a..d9c2b28b08c2 100644
>> --- a/drivers/gpu/drm/xe/xe_sa.c
>> +++ b/drivers/gpu/drm/xe/xe_sa.c
>> @@ -165,7 +165,8 @@ void xe_sa_bo_sync_shadow(struct drm_suballoc
>> *sa_bo)
>>    * @size: number of bytes we want to suballocate
>>    * @gfp: gfp flags used for memory allocation. Typically GFP_KERNEL.
>>    *
>> - * Try to make a suballocation of size @size.
>> + * Try to make a suballocation of size @size. Any waits for space
>> are
>> + * uninterruptible.
>>    *
>>    * Return: a &drm_suballoc, or an ERR_PTR.
>>    */
>> @@ -178,7 +179,7 @@ struct drm_suballoc *__xe_sa_bo_new(struct
>> xe_sa_manager *sa_manager, u32 size,
>>   	if (size > sa_manager->base.size)
>>   		return ERR_PTR(-ENOBUFS);
>>   
>> -	return drm_suballoc_new(&sa_manager->base, size, gfp, true,
>> 0);
>> +	return drm_suballoc_new(&sa_manager->base, size, gfp, false,
>> 0);
>>   }
>>   
>>   /**

