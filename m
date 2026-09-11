Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC79470440
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118331; cv=none; b=ngHbXTnTWB9k6dElJlNue1Ep9nUGIG6WuJDl0ienATOz/qrP//utXwv4mtS3mHTVTtgl/3xT7SCmM3M0/qK5Hvzvw/Qsqxz9bQkGAnFbwxE/w6yJxf94YKtJMyumLjjqKCPYK+WrTbZh+YQbnV3WhOiPtHt/mc9T12e/WgQf6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118331; c=relaxed/simple;
	bh=W3CnjFgzRRUBkYWVEiIzOX00m4Fj1pgIzeS2VYILrOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=km8JTGPMyIbTQOOjnz19ROgz+AEt04BuuwscPwBwV6486no6lsqoQJ+n2lxi7MbQTCZCrzUgvuZU/o925GouvsN8qzF7r3HAnyu0FUuvVpIGUi9FtY2iDYUKV4kGZFcY/+2m09c39xkVQWyxt0VqwGCxlNr9n1tN1/WyuP0jA24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YulDvYgT; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YulDvYgT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=Zly2zTIZMRgDdeHeFEYmS6HpsGyK48gMov9dQgVv400=; b=YulDvYgTXeVcRxyIC8WDXpMsTD
	T5cqsUQy5nXzCZXVUqFK7n7UFAKewUFwO3w2ZYn8eL+TApG2Daba8+Hod+oXLMKDOdzUooiMG4pTz
	qkrRBF/bLaektdIQT26rkPDPMDOC7Rn1rs1QhAzDH016vIioQwzBJIQZLE0PosoywQTBi8j2onNXN
	d2sUrurcV17UCLQ55adDfoZsaa9uaOL22OeHSuIlHnU7QPEFYVa0QfV8HukDRYoxbc6YAV1++fpPA
	NHOrdSqgrwGJRD8FMRNTn3fd8VUdNvInQuhIe9XFKaH7wXW34GFXHeK+fVwxwOUmMMhNNfoat44MZ
	x2LV+fxQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x4xOw-000b31-AJ; Fri, 11 Sep 2026 11:18:30 +0200
Message-ID: <35456574-5fc6-4270-85f9-940201998116@igalia.com>
Date: Fri, 11 Sep 2026 10:18:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Do not restore unsaved virtual runtime
To: phasta@kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Luke.Wildhardt@proton.me,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, stable@vger.kernel.org
References: <20260907130527.52530-1-tvrtko.ursulin@igalia.com>
 <ad1382b98d5c6cb258658e8e85156a0ccd8dd7cf.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <ad1382b98d5c6cb258658e8e85156a0ccd8dd7cf.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/09/2026 09:56, Philipp Stanner wrote:
> On Mon, 2026-09-07 at 14:05 +0100, Tvrtko Ursulin wrote:
>> Prevent pushing a new job to an entity seeing it being the first in the
>> queue, and hence entering the drm_sched_rq_add_entity() path, if the pop
>> side in drm_sched_entity_pop_job() has de-queued the job but not yet
>> updated the saved virtual time.
> 
> I think I don't fully get the bug from that message. The bug (is it
> even one?) you address is the performance bottleneck for CFS under high
> load, right?

Not high load but a race condition between the save and restore of 
virtual time when entities enter/leave a run queue.

> Anyways, I think I got a better idea:
> 
>>
>> We do this by pulling the locked sections out to encompass both the queue
>> push/pop and corresponding rbtree management.
> 
> So basically you move for locking the spsc-queue, the lockless queue
> which is usually used with the locks next to it anyways. That's cool
> stuff. I've suggested this for a while already
> 
> https://docs.kernel.org/gpu/todo.html#replace-the-lockless-queue-with-a-locked-list
> 
> So from a maintainability perspective, it would be far cooler if you go
> down this road one step further and kill the spsc_queue for good,
> replacing it with a fully locked list. AFAIR Christian and Danilo also
> have agreed to this.

I am happy to work on that just that a) I thought some time back you 
said someone from RedHat will tackle it, and b) lets please not gate 
this bugfix on that.
> 
> […]
> 
>> @@ -343,16 +340,17 @@ drm_sched_rq_next_rr_ts(struct drm_sched_rq *rq,
>>    */
>>   void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
>>   {
>> +	struct drm_sched_rq *rq = entity->rq;
>>   	struct drm_sched_job *next_job;
>> -	struct drm_sched_rq *rq;
>> +
>> +	lockdep_assert_held(&entity->lock);
> 
> btw. I think it *reads* a bit safer if the rq initalization happens
> below the lockdep assertion. Also might make the diff nicer.

It makes not practical difference but sure, I agree it reads better so I 
can respin once you clarify if you are blocking the bugfix until the 
spsc removal or what.

Regards,

Tvrtko
