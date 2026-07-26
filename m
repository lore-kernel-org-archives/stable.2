Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396F02BEC52
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785104510; cv=none; b=hK3vn0arxlhUeXTUoudG+nCVdrNFYCpTF1Jni+i3hzCVhKRJ+OiL2oushzddqWe333G9cj/IOZqA8B9gxbZdZ6SlbrrQvOy5nLPUffT7Np4KG2vutWsAOVUuuSsf6UEEWKnttyYI5s/R+1ZPj2s9RfbP+D6VR7EkPyrbSwFaDPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785104510; c=relaxed/simple;
	bh=5SjvGG1G8jyAhCzO8xQNTz6R/LVJ97zZydkjy9hVK5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HhDP0InxomxZDtWwPA9Izm+u8Uui2jqjxojXtvJ0NS4pFLtOUGn5YrEsErYiQ8xqkA0u+4ppwJZuJXa9KMO6cCvIf5ra4dmMJvYqB8zKlPdeZNU6zQ5Di+5qJtzf8vSpvkF4chpFTcIuYSX+k1fIXXMxeyQhVT0ls0WjHkLQPSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3bvXkbF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3bvXkbF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1B61F000E9;
	Sun, 26 Jul 2026 22:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785104508;
	bh=1I8qJ286E4p0EwH+UTVoZyjxFOJHckvdJY1QtYLyOig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=P3bvXkbFJUMngmrkvIMFPL2GfcPcI0Aabv3or8naM7vclDbdiCMPUYjttGagEHD1A
	 wRdAQKALjXWGaZH8zCzvhcx+wcLGVcNoZwiPP5RJDRKG8mq2JWzXGaoA6nXgAsufX2
	 kAk7tUqEUifW1o0yrA+lKAyvvyVvjUv1stw0ozLYbqJCQCYnXbd5XmAwbelPtqv9fe
	 4AeZQfrZgMiW0C4Gls6yEq8o4WrD0OEnfVZkyE/YTCRFJAF+omYvNmDH7QdxTPOrxk
	 8ic32LZkjPdffn4GsPqVAskG7yFwdusikBIvpMNTxwnXjKj74uSUH0hmEbV3Pu39pf
	 MbUCgIZdcICMw==
From: Thomas Gleixner <tglx@kernel.org>
To: Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org,
 jwlee2217@gmail.com, oleg@redhat.com, qw3rtyp0@gmail.com
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y, 6.1.y, 6.6.y] posix-cpu-timers: Prevent UAF
 caused by non-leader exec()
In-Reply-To: <20260726195203.stable-0004@kernel.org>
References: <87ecgqkf54.ffs@fw13> <20260726195203.stable-0004@kernel.org>
Date: Mon, 27 Jul 2026 00:21:45 +0200
Message-ID: <87wluhie86.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jul 26 2026 at 17:24, Sasha Levin wrote:

> Thanks for doing these.  I have queued the 6.12 one, but I would like to
> ask for a v2 of this one before taking 6.6, 6.1 and 5.15.
>
>> @@ -714,7 +781,7 @@ static int posix_cpu_timer_set(struct k_
>>  		 * it as an overrun (thanks to bump_cpu_timer above).
>>  		 */
>>  		unlock_task_sighand(p, &flags);
>> -		goto out;
>> +		return ret;
>>  	}
>
> [...]
>
>> +	if (old)
>> +		old->it_interval = ns_to_timespec64(old_incr);
>> +
> [...]
>> - out:
>> -	rcu_read_unlock();
>> -	if (old)
>> -		old->it_interval = ns_to_timespec64(old_incr);
>
> On these trees that changes user-visible behaviour on the TIMER_RETRY
> path.  Before the patch the "goto out" fell through the shared out:
> label, which filled in old->it_interval; afterwards the early return
> skips it and the assignment only runs on the success path.
>
> Upstream that is harmless because bfa408f03fc7 ("posix-timers: Retrieve
> interval in common timer_settime() code") moved the interval retrieval
> into the common code, but that landed in v6.12 and 6.6, 6.1 and 5.15 do
> not have it.  Their do_timer_settime() sets old_spec64 = NULL before it
> goes back around the retry loop, so a timer_settime() that races timer
> expiry now reports old_value.it_interval == {0,0} instead of the
> previous interval.
>
> Does it make sense?

Yes. Let me look at it tomorrow again with brain awake.
