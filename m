Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791238;
	b=CjWuby/5EXloJmiR/kI5OA7IRaq2YXSfPi4Mse2p4vXvlfJijJCJm7J1WxxjQDiVWh0U
	 c9T6EC+571QDu0aMDrWOGD7n5gSyfW1UmE5xIQVT6paw+RBQkp6uKWn307gRwJrnoa5/Z
	 HYFZrPVA92uxqQI2mIwnZGrfUYsHeFaBwdu7rcOl9UhbGRzU8dk4hHQCaK0Odbv7yUiXL
	 89xIMR+NRkHx78ec5dmOCG2CfaUNGPqkOmGxLezqwI7fo3oWSUUGNGg6iSJiMh9vkjrdK
	 uXR/m+kvtqTyBlCuVMJ2Brs1lKaka4gyvQEkJmaoMuj70WIz4b7/3RKA5+n0v4Bt0Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791238;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=7OBRCgBQnDjoyoTud5lcIffP0TY3Gb0y5+6q7d4Ue4E=;
	b=GD5inxSph6U7YuI0Sc1jektT9VijZ1Aisna3LR7ptdloBrKm98tcgerF+h9hr4uNBN2i
	 VgnF92ehOt/lIHU3SSmvmTnEM5sj8kHtMjAWp4UtzbxEHmHzhkNZtbi90NlPB+N+iVhdB
	 aM1y3AOMrzydvvVK3ZDegANegxwzIlL/hM3rkjuEGl61ovi7SeOGumeHRBJ+SVV1AxRh0
	 c4r4eVRDkhB8onP0PAMvMaZ0tqYc/ag5jepGPUD8o2Fcmg0y0cWTb1S0ph1ajOHfZHrbY
	 Zx1/zrlDX6wx5TjqXXf4Y8n/UyyPxenPBqwwpYr0EbBIJveY8KDBJmgAOqCVMrrc39Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=YGTFORqR;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D93F606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 11:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D93F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=YGTFORqR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=7OBRCgBQnDjoyoTud5lcIffP0TY3Gb0y5+6q7d4Ue4E=; t=1793791236; x=2109151236; 
	b=YGTFORqRZ7hz1+/hqNZ1F29GV77SEwu/TfhNDOQzpn4qhAsjeTRHI6v89UJqvWAbnQP9o7+zglg
	VKwRvl1ZoJXDKoovI5K75Yo3FZheYbS5QzeZkJBiRH1RhFVXE44CsApx5okXyfbLeWHTvZvDZlwTS
	ndGJH6wfYoTJ1O3RKhgJ4eHq3CixsVGOTssMsg68tHOTPrdX8qEAJVcoyfRAj5Ifglf58LuEUUkl2
	DeajYHWWOV6JLDEv/Z54I3xWbqjTE7+S2YZDdMKQ3ELtbWUBsvoGgr/5x2FMfrA5lZljKMXZRFMi6
	nJMEIROtFaRz9OCLgBgJALKAKgccaWSY0s6g==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xOZ2X-002CLZ-E2; Wed, 04 Nov 2026 12:20:25 +0100
Message-ID: <e209e3f5-714e-4717-9037-6e47e76a6e72@igalia.com>
Date: Wed, 4 Nov 2026 11:20:24 +0000
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
Subject: Re: [PATCH v2 2/2] drm/sched: Adjust run-queue when changing priority
 at runtime
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 stable@vger.kernel.org
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
 <20261021094227.48034-3-tvrtko.ursulin@igalia.com>
 <84b5777a04dc75c013eb9ac0a44d972cf88db12e.camel@mailbox.org>
 <6e113935-f303-4f49-bc27-e1d85abffa70@igalia.com>
 <72cba5d23a977185696db12ac547174708652bcc.camel@mailbox.org>
 <dd6e0f86-67e8-40c0-bf8a-1948623d0646@igalia.com>
 <6e9a32c633eec28b9d5e539b9e35c00a26ea5bd4.camel@mailbox.org>
 <64e2b65e-afe3-4fc0-8201-03cb72ae5d32@igalia.com>
 <7327af158cb66e6a5ac59e8fee413d569e85115a.camel@mailbox.org>
 <7277f083-2d17-4bed-bdaf-e6c616cc5ec9@igalia.com>
 <b93eef3f44db1cd8018a742a39cba57b67dd1d94.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <b93eef3f44db1cd8018a742a39cba57b67dd1d94.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 04/11/2026 11:04, Philipp Stanner wrote:
> On Wed, 2026-11-04 at 10:43 +0000, Tvrtko Ursulin wrote:
>>
>> On 04/11/2026 08:48, Philipp Stanner wrote:
>>> On Wed, 2026-11-04 at 08:33 +0000, Tvrtko Ursulin wrote:
>>>> I lost you here - what should the comment say?
>>>
>>> Just a "TODO: entity->rq_priority could not be fully removed due to the
>>> partial revert of the CFS scheduling rework. For formal correctness, it
>>> still has to be adjusted here".
>>>
>>> Just so that the reader sees that this is in an intermediate state
>>> right now, and so he's incentivized to git-blame the TODO to find the
>>> associated commits and mailing-list-archives.
>>
>> I would rather not do it in a patch with a Fixes: tag, or actually at
>> all - it feels arbitrary to sprinkle a TODO mentioning future work at a
>> single random place like set_priority(). Could we go with these two as
>> they are and continue from there?
> 
> Help me out here, I don't have the CFS series paged into my mind right
> now:
> 
> Will future callers, after your redesign, make use of
> drm_sched_entity_set_priority()?

Yes it stays, as does entity->priority. It's just that with FAIR 
priority affects the virtual runtime accounting and all entities are in 
a single run queue.

Three step plan would be like this:

1.
With these two fixes we think about making FAIR the default (all known 
bugs sorted).

2.
Then, if it works fine for a kernel release or two, we can remove FIFO 
and RR.

3.
Then, after another release or two we can reapply the final part of the 
original series - replace multiple run-queues with a singleton embedded 
into the scheduler.

2 & 3 could happen together, but lets say a regression is discovered 
between 2 and 3 and there is no other way than bringing back FIFO/RR 
then it is easier if 3 hasn't landed yet since that's the part with 
touches all the drivers (due drm_sched_init_args).

Regards,

Tvrtko

