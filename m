Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9277E3A4F5E
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560967; cv=none; b=nHjLEmiXw2fvSmD8nGdFzvOSy2kjBO+spp2QMW0sEhB8R+E7c/hBCH+1JcOO2te9ua72zdNzutgDzPNoGfMtUhEJZp8AauHyNZ9qvr0sE6kaKoqHWwFnBoHPuOykjXd6JchE2YshRy2CUusMjeodcPCW05iactWP2WZqDVoLSBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560967; c=relaxed/simple;
	bh=vEhnwv/38vYxFyL0JNlZziQ8IisSZnrRiTuYI3n5knc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSXxGW5bI+cKx4KstfCo0aKOxSBGtTBCu7s1aSrJHnX9+CSNPObTyn2IuHVtNW1Ca+kX0EleRqJcrKVWADxTpmLQCdHff4EpGQyV4F50qKjJA2mndj54wzCGM7GCLo5y9IImRz1tFgFsJjdgHD8l1yRyTDPEIA1mLT0MzLDXW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=IyL3MbZw; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="IyL3MbZw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1787560956;
	bh=vEhnwv/38vYxFyL0JNlZziQ8IisSZnrRiTuYI3n5knc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IyL3MbZwRqkcS5vYKckCZwdsEhmc3zISdh+zWDUh+5NR0H4NXCPqdQ4R7/ueTJpJC
	 kPsb5+VQzPmicPkuZ/wJGZC3vU8Fbof9aa7v1ojDZz9iN50oCf9OJgdNxAc+PcRaNo
	 AhWuGJLc23abeH7HMpn+tEhtkwNddcGknLoVVjYJttNyA7jM758A/2lpi9zoJFfybn
	 s7vdpd8LTUU8wKy6aIqE1keVmRp/Kyv9rBH8ZFeeFRPmt29qYe3RiMlgnofdAq3tVh
	 zTfCaC1PYum0QtUsBPXeeKs3T2v1dsmvSqlJiw08lfTLukSiGm27tTqvZhr11nExm8
	 uPOJ3Y4rOTMZA==
Message-ID: <5d715d3e-5b50-4d4f-a313-d79e243d9bce@lankhorst.se>
Date: Mon, 24 Aug 2026 10:44:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/gt: Use signalers_lock to prevent starvation of
 irq_work.
To: Andi Shyti <andi.shyti@kernel.org>
Cc: intel-gfx@lists.freedesktop.org,
 Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, stable@vger.kernel.org,
 Chris Wilson <chris.p.wilson@linux.intel.com>
References: <20260821114508.25669-1-dev@lankhorst.se>
 <aohKIjZZ6Qjy8qGQ@zenone.zhora.eu>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <aohKIjZZ6Qjy8qGQ@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Andi,

On 8/21/26 16:52, Andi Shyti wrote:
> Hi Maarten,
> 
> ...
> 
>> @@ -208,13 +209,13 @@ static void signal_irq_work(struct irq_work *work)
>>  	if (!signal && READ_ONCE(b->irq_armed) && list_empty(&b->signalers))
>>  		intel_breadcrumbs_disarm_irq(b);
>>  
>> -	rcu_read_lock();
>> -	atomic_inc(&b->signaler_active);
>> -	list_for_each_entry_rcu(ce, &b->signalers, signal_link) {
>> +	spin_lock(&b->signalers_lock);
>> +	list_for_each_entry_safe(ce, next, &b->signalers, signal_link) {
> 
> without converting rcu lists to normal lists, can't we simply use
> spinlocks around this for_each to avoid PREEMPT_RT starvation?
> 
>>  		struct i915_request *rq;
>> +		bool release;
>>  
>> -		list_for_each_entry_rcu(rq, &ce->signals, signal_link) {
>> -			bool release;
>> +		spin_lock(&ce->signal_lock);
>> +		while ((rq = list_first_entry_or_null(&ce->signals, typeof(*rq), signal_link))) {
>>  
>>  			if (!__i915_request_is_complete(rq))
>>  				break;
> 
> ...
> 
>> @@ -427,30 +424,87 @@ bool i915_request_enable_breadcrumb(struct i915_request *rq)
>>  		return true;
>>  
>>  	spin_lock(&ce->signal_lock);
>> +	b = READ_ONCE(rq->engine)->breadcrumbs;
>> +
>>  	if (test_bit(I915_FENCE_FLAG_ACTIVE, &rq->fence.flags))
>> -		insert_breadcrumb(rq);
>> +		add_context = insert_breadcrumb(rq, b);
>> +
>> +	if (add_context && spin_trylock(&b->signalers_lock)) {
>> +		add_signaling_context(b, ce);
>> +		spin_unlock(&b->signalers_lock);
>> +		add_context = false;
>> +	}
>>  	spin_unlock(&ce->signal_lock);
>>  
>> +	if (add_context) {
>> +		/*
>> +		 * Fast trylock didn't work, use slow locking.
>> +		 *
>> +		 * Dropping the lock to solve the inversion is safe, since
>> +		 * no race is possible against remove_signaling_context()
>> +		 * without being added as signaling context.
>> +		 */
>> +		spin_lock(&b->signalers_lock);
>> +		spin_lock(&ce->signal_lock);
>> +		add_signaling_context(b, ce);
>> +		spin_unlock(&ce->signal_lock);
>> +		spin_unlock(&b->signalers_lock);
> 
> If I want to be a bit paranoic, a new request can be added in
> between the two locking blocks and "add_context" is not valid
> anymore.

It's completely fine if another request is added as well.
The check we really care about is about ce->signals being empty.

add_context is still valid, since we jumped from 0 to 1 or more requests,
and the context needs to be added to the list of active contexts.

Whether we add the context with a single, or 2 or more requests will not introduce a race.

> add_signaling_context() already checks for ce->signals, but it
> does not check whether ce->signal_link is already linked. Should
> we also check !list_empty(&ce->signal_link)?

I do not think this can happen, since until the context is added to the list
of signaling contexts, no request can be removed from the context's signal list.

Kind regards,
~Maarten Lankhorst

