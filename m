Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630838;
	b=RrAkM1BfnfwjnLclYqtXWG7yjeGoJytSC8ocEp2tHGrzdYkd5XOjR1sj3ZZiwTV+u1zf
	 Z4Shq5fWGVAvuf/xkIHGmPHpL8lV6nJYhpDpzWl9HyN4lNTocubkOav9ddeom8pIcyerI
	 Yx6+AZovFGEjW2n/eirR3nCbdEzHv8CpuSydn265zEtBW6QPaqupZhvwwtJ25EHFaepiE
	 XHjKMCHmbEie8Rarl/4QbDto93qkwqeAph5++l/UbicxrIG9YcdWzvTjFEY3RF+pTaZ+/
	 wqz16mZkXWR9JLn/pbrzgyxRXvuanFAcx8FPeuzUKHuDP6DWmLfoGuGle7qZh2+OGGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630838;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=jQw5ix+gEQdGpmFbBmDqsmFBc8+v6QKH8bqPjj6E844=;
	b=YLOKQ7QJGSsFEzUKpBZgQjw9DjRthzhXG5uvH1HZt8DX7IZHm34p4UFBTV2I0KuqxKUu
	 b7WEf3v/KxCz95f7+ge55cIHAYHlsbRjDutuQlw0BBX+c5a2IQCA4BBHXNawbLkekKYFQ
	 mcCqxvh3GcN4suCBWTlNuCm2c+zgaXZCHgRacYE0mqb1Pw5ih4DHBpXtEjT82NJsrZpsh
	 rUXXdzfUUeVtzNqV4tN/LZPFlE+CjbIWqSEBvzMAzzThigpuGAi9r30jXD/PCfiVZBXmM
	 UWd+4hlPW0cra8/cjtEkq8cE1UOvGCD6I8VeiGSgTLlx2ZfKHsjC/GnppevQJgCqA5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Y1CBWeCE;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D21606A911
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 14:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4D21606A911
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Y1CBWeCE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=jQw5ix+gEQdGpmFbBmDqsmFBc8+v6QKH8bqPjj6E844=; t=1793630836; x=2108990836; 
	b=Y1CBWeCEv9LIMPxcEGCquWBYUCDvwP9/0IQxgqUjJw+ZnagCrd7LbBLYpkCLLu5hK2nsyPC0Eey
	0rt+CqzbkoJOig9HtUHu/Ny6afdTzogY4tz8RVOp9hbcqI6FRl7BsH+x4DogL0TwY12Qi58EdmCF2
	7RiyZxRodFNpVxanA0aKrf6bgywnAksMOrfQrz4OtU6EEx+Zd06IAkWHd3SweaPsH8/ZeJukOne9W
	Pb3n7Kt+BZL0kiZi8C2WDZoyAYZWdX6Xk13e3Jk/RRZx1bx7VOmMKlUV86nOfzXJS/BAtqQvR71Ky
	OD5k4qEBmi7Q/cocgSr0BE/AoEwUn7LqIT0Q==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xNtJR-000DtQ-LI; Mon, 02 Nov 2026 15:47:05 +0100
Message-ID: <6e113935-f303-4f49-bc27-e1d85abffa70@igalia.com>
Date: Mon, 2 Nov 2026 14:47:04 +0000
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
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <84b5777a04dc75c013eb9ac0a44d972cf88db12e.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 02/11/2026 10:42, Philipp Stanner wrote:
> On Wed, 2026-10-21 at 10:42 +0100, Tvrtko Ursulin wrote:
>> Another consequence of the recent revert of
>> 77a6809f1dc3 ("drm/sched: Remove FIFO and RR and simplify to a single run queue")
>> is that after the revert we need to adjust entity->rq_priority when
>> runtime priority changes are requested.
>>
>> Only amdgpu does that so the impact is minimal.
>>   Also considering dynamic
>> priority changes are largely broken there, due currently broken entity
>> scheduler list handling where the special case of a single scheduler can
>> never change it's run-queue. And coupled with the fact for the rest a two-
>> tier approach of drm_sched_entity_set_priority() and
>> drm_sched_entity_modify_sched() is used, where later directly maps to
>> different hardware queue priority by replacing the set of schedulers
>> completely.
>>
>> Hence the regression is limited to rings which have multiple instances
>> other than compute and graphics, which would be SDMA only, for which I am
>> not sure any userspace actually does dynamic priority changes in the first
>> place.
> 
> I can't fully grasp what the bug actually is. So is it that we forgot
> to adjust the priority in the CFS series, or is it that the partial
> revert made this necessary?

Partial revert makes this necessary, albeit mostly on paper. In reality 
it is complicated. Only amdgpu calls it, plus, for single scheduler IP 
blocks there is not bug because of the "single scheduler special case" 
run-queue cannot change at all (bug I am trying to address in that 
different patch, and which also got re-uncovered due the partial revert 
of the fair series), while in the multiple scheduler case there is no 
bug because amdgpu pairs drm_sched_entity_set_priority() with 
drm_sched_entity_modify_sched(), which actually changes the priority in 
the driver. This leaves SDMA as the only potential place where there can 
be a regression, and there I am not sure those do dynamic priority 
changes from the userspace side in the first place. But theorethicaly, 
from the UAPI point of view, it could be a regression so needs to be fixed.

>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Philipp Stanner <phasta@kernel.org>
>> Cc: <stable@vger.kernel.org> # v7.2+
>> ---
>>   drivers/gpu/drm/scheduler/sched_entity.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>> index e12709b7bd0c..03e68b4102d5 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -456,6 +456,8 @@ void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
>>   {
>>   	spin_lock(&entity->lock);
>>   	entity->priority = priority;
>> +	if (drm_sched_policy != DRM_SCHED_POLICY_FAIR)
>> +		entity->rq_priority = priority;
>>   	spin_unlock(&entity->lock);
> 
> So is there always a bug, or only for FAIR?

With FIFO and RR, on amdgpu, SDMA rings, only if more than one, *if* 
there exists userspace which does dynamic priority changes (calls 
DRM_IOCTL_AMDGPU_SCHED / AMDGPU_SCHED_OP_*_PRIORITY_OVERRIDE) on 
entities using those SDMA engines directly. All clear now? :))

Regards,

Tvrtko

> 
> 
>>   }
>>   EXPORT_SYMBOL(drm_sched_entity_set_priority);

