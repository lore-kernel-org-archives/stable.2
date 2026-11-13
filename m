Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585459;
	b=QThf+gJCLRnEgN9h9FjnBm9RNmq1wcLat6tJQAZTpIzvZVzD6vMkHP0FMSFDTgZiH9uw
	 WayeNdyyVFwa5HgbI2sCYYoC0UqI+zKnpxchcUvdzD4LSfAPs5X/4kTF9+gdZa5jlROEi
	 HpwjH3FgkowWcW6JvDq8JApciAWGvFwj7ZE0VJP3R+m1V2l8/hSJ3n+agb/FVKW7Sa6lX
	 qDIZub8Y4MsmyJo6f5yW/+3R2P7oYloEYkCtT4QhzSHw+bFv66V+4KZRapBY1djzZ7QNZ
	 DBONDfJDrJ1ZQAWzKp38Ak82SGnAo+n63JSVLv2pqC0U9WvWNIfZQXDGcsxb3eTNdJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585459;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OLPlzBmIGcwx65jSMq2uJ6Gd3E4PNgtasDmsnHDmw6c=;
	b=zs9+Xxygx9IiGOTExclnMwLSPO2Zq+V4gGnSKP+BT7Np1d9rV96D7l6DcEl5Wa48/TC/
	 5GW7WZTS0fxakwR7CxXjclPCk773atjOPnIJFqgsu65og9yA8HIvT217VkQ81vck6H55j
	 2X5TkhUado8IwbJmiwiYWsAvd606qeykfgS4JeuyWGPaVkf92dHF7DaXUZ4fEL+btI4PH
	 eXUdbPWu6V500NAMSQl2LlJ9OpfAJzthuqVx6LuCdn2DnuV2XecBN+OEEPfMsOHisayiw
	 O/2jcY5PI5iVPgY1i85AOA8eTncynhMaqLfuC3qno1HSpd7x8fn1YoNJJN5riLleylg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cUgkH5lQ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=P8JhzZpU;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C960A6F53
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 814C960A6F53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cUgkH5lQ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=P8JhzZpU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794585457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OLPlzBmIGcwx65jSMq2uJ6Gd3E4PNgtasDmsnHDmw6c=;
	b=cUgkH5lQd0TfeL5EclaMb97wObG4AfqU5bVDReD6iqAsh6aZZQRhtwMtAFYextD8T0on4N
	fuNzKvGuz6OnTjGqiSq2cfmYXh0CswhsH76ziTJQS3eMGcfFiCEt30XskN8ujQ7i12FUeb
	dw1/xulrX+abOvxreNTF2Vwwroj03PA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-kTZ-NxIVO8WkYFhjCZfVoQ-1; Fri, 13 Nov 2026 10:57:35 -0500
X-MC-Unique: kTZ-NxIVO8WkYFhjCZfVoQ-1
X-Mimecast-MFC-AGG-ID: kTZ-NxIVO8WkYFhjCZfVoQ_1794585454
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4903fc8537aso663803f8f.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 07:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794585454; x=1795190254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OLPlzBmIGcwx65jSMq2uJ6Gd3E4PNgtasDmsnHDmw6c=;
        b=P8JhzZpUkTOzDQ4ODmJlWq9olowdwxwlVSFdM2DvBI7aQR1Zr8KlAvqaIMvyd+HWCX
         i10udXX9k4NWB2b1UBy7Fvrt10klAqOdnCzfewpIiSgfr1CtyNIls3XtDRuBQQVJhoEx
         g1pxYycHTW5g4vcSIBLJ86WFsSGbdObQac8ruq36xUk95BQcHD3fJphvmxBbwFlYc1hM
         OzW5tw3X+60fDaSxTrhMfkfzA22jds8fZasaQLQ8hqbQVE2j2FwZOA64XXLe2TgJgDkx
         Esnb9MA7D1+gdAeIyM7fqcSr+CwZs57C21Jjd6Y2vTORU7PsZsYNcCcba0AizVXRJrkN
         PR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585454; x=1795190254;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OLPlzBmIGcwx65jSMq2uJ6Gd3E4PNgtasDmsnHDmw6c=;
        b=ymy6YRURBJq9N+AKFE0kABAUqH6ip81a2ERu7FORTjXIMuT8hiij5tXwVZrZddDLA+
         Ymw8GR37MvpV+uuvP+bU1Ke3KVlsyLN3IHbQnjYQram+875Y+VbLLpt7APlxMC5KRB/7
         fc9AbzJsX2mV60GpFc2E/t8m7TtsaLlOVcVFwNayiE3VBN2zZ5RNj2z94rD/Y6nPZlAu
         38M+ycuhJOsOZBzmem/pvfE2LiGo/FMZh4afoj236T3JEWYVf+PABMeUFD3H51I2Y0ur
         O2f5i5yEFOlu3bDMImpK2BMQoiVvBHIkI2H2LYknHWOn6QVR0CO/R1ONMulfDgtFBgPo
         1+Sg==
X-Forwarded-Encrypted: i=1; AL+hErFa5C9SwATnvFHHebjKwNhMvm3Wchexy+TptysR29oeZUq+eYl8OF3ItjI2Q8daaKEP+UvIXZk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RZm85Axe7ZIfc/1AU4YMXbozfvqdaZ7yKpNipwwDZYZq4Aw6U
	tZwFq/KCymhasyb4x8vAICYtC5PznxsRUh65ImHf92SByBgu+ETyBmJFqSVFCH9kLim2KGn8djZ
	dR/R0fihV37XGVJ6L5TgbKzEWBxy9+omHurlmgax88T00fQfTH8z1ayoLPw==
X-Gm-Gg: AYBFou3iVI71XsFRFquZoNdj1D4pTRqj+mIhacDtXR3tHKD+zFI3Nvvh7tbiSpdoxuH
	BIaumyqiz8t372WprSTsOEAJu0dIsS8KSd/poaaU8rqw8BsuKy2OWTUhsPN4n4YkmEWYZVp2ugJ
	QmDE3nXzWQJEMbPFyQXcoYB9NZtwlTyTk7JcBLBRgLU+z4pGwVASfbMM8ewPFFk3hvc6RI3TKBF
	ljNxsd7EpF5enOTyUKjAJ6ocKVmMFgYKIpwKa2VQy8aKDZSbXkG6KNZoG0mMSRnrhLo7JUTf4FF
	89dnY6lMn4FsVo90wQqlm5iiUl1ek7G8z7SpMFh+T3N66XWQwJ0RlfDW1V6T5ZD7J2MEfy6iFdd
	k0OeFODxMhkhxRicK6zhE+nSTtDXJMarLVuOOcCxYLOlCCNfmo86xp5TAHDKlpcmJcJ1jMqPR7E
	4G+Eo=
X-Received: by 2002:a05:6000:2613:b0:48e:3085:7cf0 with SMTP id ffacd0b85a97d-49c7467b551mr5465773f8f.51.1794585454094;
        Fri, 13 Nov 2026 07:57:34 -0800 (PST)
X-Received: by 2002:a05:6000:2613:b0:48e:3085:7cf0 with SMTP id ffacd0b85a97d-49c7467b551mr5465726f8f.51.1794585453647;
        Fri, 13 Nov 2026 07:57:33 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60116323sm5776550f8f.32.2026.11.13.07.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:57:32 -0800 (PST)
Date: Fri, 13 Nov 2026 16:57:29 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, tglx@kernel.org, will@kernel.org,
	boqun@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	kprateek.nayak@amd.com, luca.abeni@santannapisa.it,
	mathieu.poirier@linaro.org, longman@redhat.com,
	ridong.chen@linux.dev, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, shuah@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, parri.andrea@gmail.com,
	m.szyprowski@samsung.com, kayracizmeci@gmail.com,
	weihengqiuu@gmail.com, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 20/29] cgroup/cpuset: Give back the bandwidth an
 attach did not move
Message-ID: <avczaaXEh_xUhxpa@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-21-mathieu.desnoyers@efficios.com>
 <avWEta7b9X4K6hF7@jlelli-thinkpadt14gen4.remote.csb>
 <e21aaf40-b929-444c-b707-3200e21d7301@efficios.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e21aaf40-b929-444c-b707-3200e21d7301@efficios.com>

On 13/11/26 08:12, Mathieu Desnoyers wrote:

...

> Three new patches keep a deadline task in the root domain that counts
> its bandwidth:
> - Where a CPU is picked for the task, a CPU of that root domain is
>   tried first. This covers a CPU offline, a mask change, a wakeup and
>   a rebuild.
> - A CPU offline fails with EBUSY if it takes the last CPU the task has
>   in that root domain.
> - A write to cpuset.cpus fails with EBUSY if it leaves the task no CPU
>   in that root domain. cpuset makes a partition root that would do the
>   same invalid.

Makes sense to me.

> The bandwidth of a task then goes to another root domain only by a
> cpuset attach, which asks for room.
> 
> With admission control off, nothing is refused, and patch 23 still
> moves the bandwidth. So an administrator gets past a refusal by writing
> -1 to sched_rt_runtime_us. The two refusals are new behaviour for
> user-space. I would like your opinion on them, and on whether that knob
> is enough or a dedicated one is wanted.

I believe we already have (maybe broken in-kernel) EBUSY on trying to
hotplug last cpu with bw standing?

About a potential dedicate knob, Sebastian is proposing it as well [1],
so maybe it's time we move to that. Need to sync with him I guess. :)

Thanks,
Juri

1 - https://lore.kernel.org/lkml/20261113-sched_dl-v3-5-a76ffa1cdeee@linutronix.de/

