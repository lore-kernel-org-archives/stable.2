Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE5B4F68C8
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895017; cv=none; b=JoHzAEUIKlwvbXCSDHhxL9SHzfv46/jQwJ2D/UMXjwTn30+v0IZX5pnvMOypq/uRvIdxI0V6NY8fbIZLZI5GlkSPa+7dtSxEdpRcCMxrYWDC2l89NqJQz/Un3ci9/pCfIUlMMRGXgdC5rwxi2SWmVyvYzEb1I1IPrtuaL1TIXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895017; c=relaxed/simple;
	bh=4tDSexQf2fi/8v5u8iOE1sYKrQ2ZjTNNwBwAriwHXRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsGVaqxMSWaVqJD2xXjr/ZQTUKZqcxliNsLwMAx+VNb74aZrJmv+Jxno+Fgfkjgxad4ziKymrQhbLDmdpYFqST4yGJ0biotEJ2df9ZMAyOHbG6KW8ZnATpnZpL0hOK0RcSzB+f+KtWDJIefYW/d2Yw0uD/I8jcBOWJ56UETImC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gCdRYnWE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gCdRYnWE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791895016; x=1823431016;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4tDSexQf2fi/8v5u8iOE1sYKrQ2ZjTNNwBwAriwHXRg=;
  b=gCdRYnWE4c5/gV1O/K4x9Co665nh6KrDeB55ZkuXBWAOLQDCnzwYqB9q
   6d5cVZO+qf5LHpzbOoecxbQAEc9XB5HW6OnQ3y+z2VoRtpd5bC2dW9pNY
   14dDKOsaCcYPm7KgjLpkL86hxg41GpwMUTn2IxKwuKaVS+bgKtN517kws
   av9+apfnIE4KJOsW8e+RbC90ESFZs7DuDMM97tQMrUyvSVx41FrMoQHLM
   R+lTWo4Ff6T5qkGqS2LX8JYzk3vX+5KvvDL54LqnxALmWo3kpkHiio2Cc
   ePbctVEYeBO8ZSX1Jp2ZL6M0BwvVwIDmekb+mRbFbUn7xFvLeoTUYqz07
   Q==;
X-CSE-ConnectionGUID: DIdI7nP1SQmBqNiKm0MYwg==
X-CSE-MsgGUID: M/88OhtmTBy532kC1NMfGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="622399"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="622399"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 05:36:55 -0700
X-CSE-ConnectionGUID: LpKqYIAaRTy8kJvFR73giA==
X-CSE-MsgGUID: lxyKQ9l2STqk9kwSwFK27A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1081418"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.245.122]) ([10.245.245.122])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 05:36:54 -0700
Message-ID: <b025d829-0911-4b38-8a6b-8ddf5cbcd897@intel.com>
Date: Tue, 13 Oct 2026 13:36:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/xe: skip p2p for suspected display buffers
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20261007153605.1743626-5-matthew.auld@intel.com>
 <20261007153605.1743626-8-matthew.auld@intel.com>
 <2c6a97ac21c5ef161dbac279f9b971f383b6b944.camel@linux.intel.com>
 <dbabed4e-468d-4ecf-b295-f5d8c9c4b263@intel.com>
 <bc2f4d82-5a8e-4d1b-a921-ee819ca5cac2@amd.com>
 <992d57f0-7327-4c36-adf7-6dd72137fe73@intel.com>
 <31f7eb68-6dfa-4ea7-93a4-d4897fbe6a74@intel.com>
 <3579864a-0283-4f92-b895-5cf399c2ee69@amd.com>
 <16cfde6b-8881-4ffe-8068-9530286da72a@intel.com>
 <1a852df2-c2a4-48bb-84de-cdd4b98b95bb@amd.com>
 <d493d4d1-96d5-4194-bbae-5c1e5d54d91a@intel.com>
 <5545db90-3365-4d75-9fc0-77dda42b7000@intel.com>
 <2fcd10d5-c1f9-47be-9a68-422f9bbd6837@amd.com>
 <8d0eb215394e7a285813fe87def6bee358063431.camel@linux.intel.com>
 <f570087d-9d67-4199-b5db-959741379835@amd.com>
 <9ba9558a85e3df1bf50db7a2265ecb99d746cf9c.camel@linux.intel.com>
 <9a77cde3-641f-45b0-8c30-69184c0f1a4d@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <9a77cde3-641f-45b0-8c30-69184c0f1a4d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/10/2026 12:45, Christian König wrote:
> On 10/13/26 12:16, Thomas Hellström wrote:
>> On Tue, 2026-10-13 at 11:55 +0200, Christian König wrote:
>>> On 10/13/26 11:18, Thomas Hellström wrote:
>>> ...
>>>>>>>>>>>> Ideas on how do that? Could we do something like
>>>>>>>>>>>> allow_peer2peer = false in
>>>>>>>>>>>> amdgpu_gem_prime_import() if
>>>>>>>>>>>> this is an APU device, or further check if the
>>>>>>>>>>>> exporter
>>>>>>>>>>>> side is not amdgpu, like APU + Xe?
>>>>>>>>>>>
>>>>>>>>>>> For example:
>>>>>>>>>>> https://gitlab.freedesktop.org/mwa/kernel/-/ commit/7
>>>>>>>>>>> ec86
>>>>>>>>>>> c68b42655b4bb85ee90af434a617e7bec8c
>>>>>>>>>>>
>>>>>>>>>>> Is that something you would accept?
>>>>>>>>>>
>>>>>>>>>> No, you misunderstood me. Enabling P2P is perfectly
>>>>>>>>>> fine
>>>>>>>>>> for APUs and mandatory for a couple of customer
>>>>>>>>>> projects.
>>>>>>>>>>
>>>>>>>>>> The buffer should just be rejected from scanout in the
>>>>>>>>>> display code and on the AMDGPU side we already do that
>>>>>>>>>> if
>>>>>>>>>> I'm not completely mistaken.
>>>>>>>>>
>>>>>>>>> Reporter confirmed seeing the issue in windowed mode
>>>>>>>>> also. So
>>>>>>>>> I don't think it's just a case of rejecting from scanout?
>>>>>>>>
>>>>>>>> Then I don't understand what the problem is.
>>>>>>>>
>>>>>>>> When the dGPU renders and the iGPU displays you have only
>>>>>>>> two
>>>>>>>> possibilities, either the dGPU pushes the frames over the
>>>>>>>> bus
>>>>>>>> or the iGPU pulls the frames over the bus. Both should be
>>>>>>>> equaly slow or fast, so what exactly is the expectation
>>>>>>>> here?
>>>>>>>
>>>>>>> I assume the AMD APU/iGPU is sampling/reading from the p2p
>>>>>>> window
>>>>>>> buffer every frame.
>>>>>
>>>>> That is not possible. The HW can't do this and because of this we
>>>>> should have a check for that in the DAL/DC code.
>>>>>
>>>> Couldn't the issue be that the compositor, running on the amd iGPU
>>>> blits from the dma-buf rather than scans out from it? And the
>>>> scanout
>>>> is not the shared buffer at all?
>>>
>>> Yeah that is possible, but that should only happen when there is some
>>> change.
>>>
>>> When the iGPU reads the buffer only once then that isn't really
>>> problematic, it's actually exactly what should happen.
>>>
>>> It only becomes problematic when the buffer is read multiple times to
>>> construct multiple frames, either because the compositor does
>>> something unexpected or we really start to scanout from the buffer.
>>
>> But in windowed mode (and perhaps even fullscreen?) the compositor
>> blits repeatedly over PCI each frame from the dma-buf?
> 
> It usually doesn't.
> 
> In fullscreen mode using the buffer directly for scanout in an atomic commit should be rejected by the kernel because the HW can't do this.
> 
> The fallback path then copies the buffer content to a locally allocated buffer exactly once and then display that new buffer.
> 
> I'm not 100% sure what happens in windowed mode for the specific compositor the end user is using. What could be is that when the compositor gets buffers from multiple applications that it composes multiple times over PCIe, but it is unlikely that this will cause problems. You would need something like game/test running on dGPU and glxgears without vblank sync on the iGPU.
> 
> AMD uses basically exactly that setup in the Tesla infotainment system for example and it works perfectly fine there.
> 
> I have not the slightest idea what's going wrong here.

My rough mental model here (could be waaaay wrong), is that dgpu is 
constantly rendering into a private VRAM buffer, and then copying that 
to a linear buffer which is the window buffer exported to the 
compositor. Display is plugged into the igpu. DRI_PRIME=1 is used for 
the game (like GravityMark) to the do rendering on the dgpu.

In windowed mode, every frame the compositor needs to somehow sample the 
exported window/texture from a shader, like in mutter. In this flow the 
igpu is still using native buffer for the actual scanout.

That exported window buffer is using a flexible placement, so it could 
technically go in VRAM or system memory. But I don't think p2p was on 
the bingo cards here for Intel. So if you suddenly negotiate p2p instead 
of moving it, it now stays in VRAM. So igpu is now constantly reading 
over pcie every frame, which is extremely slow it seems, for the user.

Other thing is that when I tried to repro this locally, I used xe igpu + 
xe dgpu, and manually forcing p2p in the kernel. When I traced it with 
bpf I just see the private VRAM buffer sitting there, and the exported 
window buffer as system memory. So no p2p. There was also no ping-pong, 
so it must mean that the exported window buffer is NOT flexible 
placement in this multi-GPU setup.

So it could potentially be specific to some cross-driver flow with 
OpenGL, like with amd + intel, where you can end up with the flexible 
placement for the exported window buffer on some multi-GPU setups. Not 
100% sure though.

> 
> Regards,
> Christian.
> 
> 
> 
>>
>> /Thomas
>>
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> /Thomas
>>>>
>>>>
> 

