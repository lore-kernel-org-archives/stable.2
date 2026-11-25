Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624013;
	b=PrTgWargBG+GtRk+Lza3xyTkh0lmCjGlfbh/gDWsjBBgCHOL8heAIjAG85PG6XG3Eazh
	 4dOCUSjIf8XA6DwXQDmAqivAwh5ZsTUleKS9T87j41niuzXELVAs/zXbZspSTwO9k5F2N
	 RIuhL2BoPa6mysvNrR5s6H12if2fM6TYm9rt5oOoQE1YlA+SPpG24KvkBas7UVEDrDg6P
	 7D3mW3KI+piNxZDgQ8FahU4Xs7IepeX2JuU59Xc9aMjVJLwFwX5RoEKu+DdZbXg5ZLMew
	 7/G4cIKXerHLaiGLM6OzRR4P68X2xoVD6nu5ATwMPqNoQeyeHGxzpGI/MuH99vkpUOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624013;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=aqU5GUv3UOguGDBfqtHU0eElPeNBh4Z3YYKUq63ZJO0=;
	b=ebJcGwRHZxWF2CCefmBTg5WFlXHBaNa2fPj/sdXCPgfwu+svYyX3S3GozIij0RNMrwpq
	 fOM+j2+tTkW05rsUaM4XdAehQo1LWgAE9ME5s/rx/aUbeoZ/rrCEPV2W9lPs05q3rNpZ+
	 Tgntc8ggDmX5EKjSDNQB2XHFyQFnRfuSnA3xMcwic5qsNLqU5ZEGoI7EZHoRzIqtV3dyu
	 +qX9GjMWrdwHT1FB4zJ7dYHab7jUmQO9dFhwDoLWwHSCAa6iHQCrRUr4R8XZQewv7Yoh+
	 333IBkGMz48l6X635kdqvj1aUnSuvZuIsvZ71b+PCFj3JIQ2yj0i42mJaYyT2p90oIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=RNyH7uPb;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25963606A323;
	Wed, 25 Nov 2026 16:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25963606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=RNyH7uPb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=aqU5GUv3UOguGDBfqtHU0eElPeNBh4Z3YYKUq63ZJO0=; t=1795624011; x=2110984011; 
	b=RNyH7uPb/HYO0IKd4jdomFxNiL6j7IXZ2sNpf1WNSN0lwctcXClC0AX9bXCjh7NXZJOWbByBTSG
	YYErL/oBLSZMBA+SYcaWgoIEBD+QkEHDrko8Zmhr12TpmmLTQDIMy0rJRb4B/5eXhZvYu5rDp8pUp
	JJsls5pMaV3ZJOX7okDRfsL74UN5vLM5C+pUbgpRnxIASd9jR4dO7ltSH2/r54RS0KkcHlwq7iwXr
	vrQ7DiWXcDsMmixdsVTYJFWNzekLsN5fBdKufoBx4/zIIqmG206SBMMbU6k7bzRzxeJJPEt+yF42a
	fOFmyztJALym8oCL6TGu+A/ygcxwqYz+rbYw==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xWFpQ-000000042Li-1woQ;
	Wed, 25 Nov 2026 17:26:40 +0100
Message-ID: <397703c2-787a-4742-9b30-385030177187@igalia.com>
Date: Wed, 25 Nov 2026 16:26:38 +0000
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
Subject: Re: [PATCH 2/3] dma-buf: dma-fence: Add
 dma_fence_overwrite_timestamp()
To: phasta@kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Chris Wilson <chris@chris-wilson.co.uk>, Danilo Krummrich <dakr@kernel.org>,
 Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, Yunxiang Li <Yunxiang.Li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261119131830.2535266-2-phasta@kernel.org>
 <20261119131830.2535266-4-phasta@kernel.org>
 <a8fe714b-6d26-4777-8b9c-4299ecdc3f44@amd.com>
 <d53b0e41ca767a2acb1f6ee29344567f34385d8c.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <d53b0e41ca767a2acb1f6ee29344567f34385d8c.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 20/11/2026 10:01, Philipp Stanner wrote:
> On Fri, 2026-11-20 at 10:38 +0100, Christian König wrote:
>> On 11/19/26 14:18, Philipp Stanner wrote:
>>> A fence's timestamp is just an opportunistic data point for debugging
>>> information etc. drm_sched, for example, uses the timestamps for its
>>> scheduling algorithms.
>>>
>>> In rare situations it can make sense to allow users to overwrite a
>>> timestamp with a more accurate value. This is relatively harmless since
>>> the timestamp has no meaning for the implementation itself.
>>>
>>> Add dma_fence_overwrite_timestamp().
>>
>> I think that this is a very bad idea since it gives the impression
>> that overwriting the timestamp on a fence is ok.
>>
>> That was only done on the scheduled dma-fence because nobody cares
>> about that time in the uAPI. For all other cases that can blow up.
>>
>> I would rather come up with a clean approach for the scheduler to
>> track the spend time per entity which would make that hack completely
>> superfluous.
> 
> Yes, I agree.
> 
> The *one* feature we would have needed in C is a public-private system.
> With structs in APIs it's often completely undefined what the user can
> and cannot touch.
> 
> That led to API ossification. Just look at drm_sched, where we now
> cannot trivially change API internals anymore because external parties
> conveniently use this or that.
> 
>> IIRC Tvrtko already created patches for that, I'm just not sure if
>> they were ever committed.
> 
> I suppose it should be somewhat easy to track that data in
> drm_sched_fence.
> 
> Maybe Tvrtko can point me to his ideas so I can take a look.

Not sure that I have any patches in this area. What I am trying to come 
up with in the background is a solution for amdgpu overaccounting due 
scheduler not being able to know what hw resources are shared, for 
example normal and high priority rings sharing the same execution units. 
But that is orthogonal.

For this particular bug I think we can do something different and that 
is to stop touching the dma-fence and just track the interesting 
timestamps in the drm_sched_fence itself. I can have a go in the next 
few days to see if using the existing job_list_list and/or the workqueue 
serialization makes this really simple.

Tvrtko

