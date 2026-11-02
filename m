Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630232;
	b=WoWTZcvKdM7z6XXjq4HdclIMv5T2LOTctj193n+/4wEwd9d2V/8imH91/84JQMldXp7J
	 tUVU6dQVvXiyMX62ARLzTAZyfpJjEc0fuyOMvLi1jP9XEQ1E4I2lJUgzH/7isyvQqz7F5
	 qBFxvaxUYX0mlxMaUOzyOD0mUojrcqABC55bgCAECQIlda0uqcH9TAJGUa3uzbxG4aCqE
	 5EZwxupGgbvNUU7soIP3xR4hYzoY5abxK56BZ1BFlOrLAcUdMyGYjSY9L6cobkuRZ+pFC
	 EWeMuKkxBXNET0ddPGTvxcXOOT+/bhpR1JrMkBRa3QkFxc9BW6LK19fTSjLJee5wc+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630232;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=M+QtftQCvQ7UorP2FMYX5X/lRNWLmJ6xnVMXJUAR41I=;
	b=XBKQ+qqdpb+UjUR4t+yPdL+J8vX2vvDuyu4QaBFJyC2QbObkvCyoqi5jBDKoq8CpJ5yM
	 b7E53G+fxqQWB1VyxFstbBvDrpYXwVC67DBgZaGdYOBVHg4BGPZICu1kOW5PrNtr3t/Hw
	 BLajhsyQFkSHSJ/Jwdmzjbg7HZznDMMGVOyS1gFPEi9iK1/xD4yF8o/4OpYmEZ2yfKD0C
	 ROsnf2j8BAEyXjwooGmXthmlCVz67fg5B75XXULKtm7r5Q6UCdMEMTO8ysMIi1tZQ2GsI
	 BDT7sfQCTN9WJ2labDjSVSV/jQXZgLcCG7qDFB6yWdpaHtfCPQHMifqCJeWMqL/nxyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b="EVZO5IN/";
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53428606A336
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 14:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53428606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=EVZO5IN/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=M+QtftQCvQ7UorP2FMYX5X/lRNWLmJ6xnVMXJUAR41I=; t=1793630231; x=2108990231; 
	b=EVZO5IN/dD1frSxenq4Xme0XQns35Mt5qQN1HViqzHcocC1B/wzrI5Bx4wewiIF4qcRtSdaSLiQ
	Kpbdj742dh6GfeWPXobx4v3m2ZD96SyuDca68j6FkkGg3ZON5TvttwCsEwIvJkfsEyC7EkX4Wz6ok
	q1yxdWWthhIg6LPvITr+ng2RhgGRNfdj93iozjkEx82cKm0E2UIf36kkqpbGVG0admDbqCXA4gKJ1
	CEzstrtlZc1hLTwU0mEoVHxBWkoqT1enr/wyQsXX44BRnnF/5amSWGXSjJ2FErPdSsLDi2EH1iUaG
	hP7GSY3xAQ1zawTEE4XoYOE53keLlyuWV0bg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xNt9d-000DMy-13; Mon, 02 Nov 2026 15:36:57 +0100
Message-ID: <b982e952-072a-441a-b2a4-1bed8b8a9705@igalia.com>
Date: Mon, 2 Nov 2026 14:36:56 +0000
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
Subject: Re: [PATCH v2 1/2] drm/sched: Fix out of bounds entity priority check
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 stable@vger.kernel.org
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
 <20261021094227.48034-2-tvrtko.ursulin@igalia.com>
 <45a8324481c367a69f25e8c395ff6784b441a834.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <45a8324481c367a69f25e8c395ff6784b441a834.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 02/11/2026 10:46, Philipp Stanner wrote:
> On Wed, 2026-10-21 at 10:42 +0100, Tvrtko Ursulin wrote:
>> When the out of range priority at entity init time is clamped to the
>> number of run queues in the supplied scheduler the internal run-queue
>> priority needs to be adjusted as well.
>>
>> There is no impact since none of the drivers hit the clamping path, but
>> we still need to address it by moving the entity->rq_priority assignment
>> to after the clamping is done.
>>
>> Note that a lot of this will hopefully get removed once again when the
>> single run-queue simplification lands.
> 
> So this is no existing bug out there, but merely for formal
> correctness?

Yep.

>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Philipp Stanner <phasta@kernel.org>
>> Cc: <stable@vger.kernel.org> # v7.2+
>> ---
>>   drivers/gpu/drm/scheduler/sched_entity.c | 27 +++++++++++-------------
>>   1 file changed, 12 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>> index 7be0387bac3c..e12709b7bd0c 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -130,10 +130,7 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
>>   
>>   	INIT_LIST_HEAD(&entity->list);
>>   	entity->guilty = guilty;
>> -	entity->priority = priority;
>>   	entity->last_user = current->group_leader;
>> -	entity->rq_priority = drm_sched_policy == DRM_SCHED_POLICY_FAIR ?
>> -			      DRM_SCHED_PRIORITY_KERNEL : priority;
>>   	entity->num_sched_list = num_sched_list;
>>   	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
>>   	RB_CLEAR_NODE(&entity->rb_tree_node);
>> @@ -144,25 +141,25 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
>>   		 * not to do this and to fix their DRM calling order.
>>   		 */
>>   		pr_warn("%s: called with uninitialized scheduler\n", __func__);
>> -	} else {
>> -		enum drm_sched_priority p = entity->priority;
>> -
>> +	} else if (priority >= sched_list[0]->num_user_rqs) {
>>   		/*
>>   		 * The "priority" of an entity cannot exceed the number of
>>   		 * run-queues of a scheduler. Protect against num_rqs being 0,
>>   		 * by converting to signed. Choose the lowest priority
>>   		 * available.
>>   		 */
>> -		if (p >= sched_list[0]->num_user_rqs) {
>> -			dev_err(sched_list[0]->dev, "entity with out-of-bounds priority:%u num_user_rqs:%u\n",
>> -				p, sched_list[0]->num_user_rqs);
>> -			p = max_t(s32,
>> -				  (s32)sched_list[0]->num_user_rqs - 1,
>> -				  (s32)DRM_SCHED_PRIORITY_KERNEL);
>> -			entity->priority = p;
>> -		}
>> +		dev_err(sched_list[0]->dev, "entity with out-of-bounds priority:%u num_user_rqs:%u\n",
>> +			priority, sched_list[0]->num_user_rqs);
>> +		priority = max_t(s32,
>> +				 (s32)sched_list[0]->num_user_rqs - 1,
>> +				 (s32)DRM_SCHED_PRIORITY_KERNEL);
>> +	}
>> +
>> +	entity->priority = priority;
>> +	entity->rq_priority = drm_sched_policy == DRM_SCHED_POLICY_FAIR ?
>> +			      DRM_SCHED_PRIORITY_KERNEL : priority;
> 
> I guess my main question regarding the code is why you moved those
> lines?
> 
>> +	if (sched_list[0]->sched_rq)
> 
> Couldn't that remain in a terminating `else`, reducing the git churn?

It could; the minimal diff would be:

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c 
b/drivers/gpu/drm/scheduler/sched_entity.c
index 7be0387bac3c..0dec0d22c997 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -160,6 +160,8 @@ int drm_sched_entity_init(struct drm_sched_entity 
*entity,
                                   (s32)sched_list[0]->num_user_rqs - 1,
                                   (s32)DRM_SCHED_PRIORITY_KERNEL);
                         entity->priority = p;
+                       entity->rq_priority = drm_sched_policy == 
DRM_SCHED_POLICY_FAIR ?
+                                             DRM_SCHED_PRIORITY_KERNEL 
: priority;
                 }
                 entity->rq = sched_list[0]->sched_rq[entity->rq_priority];
         }

But that leaves the "ugly" sequence of assigning prio back and forth, 
and even adds more ugliness to it by repeating the drm_sched_policy 
conditional:

	entity->priority = priority;
...
	entity->rq_priority = drm_sched_policy == DRM_SCHED_POLICY_FAIR ?
			      DRM_SCHED_PRIORITY_KERNEL : priority;
...
	} else {
		enum drm_sched_priority p = entity->priority;
...
		if (p >= sched_list[0]->num_user_rqs) {
...
			entity->priority = p;
+                       entity->rq_priority = drm_sched_policy == 
DRM_SCHED_POLICY_FAIR ?
+                                             DRM_SCHED_PRIORITY_KERNEL : p;

So I thought we can tidy in up in one go and end up with a completely 
streamlined and localised:

	} else if (priority >= sched_list[0]->num_user_rqs) {
...
		priority = max_t(s32,
				 (s32)sched_list[0]->num_user_rqs - 1,
				 (s32)DRM_SCHED_PRIORITY_KERNEL);
...
	entity->priority = priority;
	entity->rq_priority = drm_sched_policy == DRM_SCHED_POLICY_FAIR ?
			      DRM_SCHED_PRIORITY_KERNEL : priority;

I don't think there was any churn to this area so backporting shouldn't 
be a problem.

Regards,

Tvrtko

> 
>>   		entity->rq = sched_list[0]->sched_rq[entity->rq_priority];
>> -	}
>>   
>>   	init_completion(&entity->entity_idle);
>>   

