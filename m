Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824483;
	b=bfn4752NUR1Z+Zp1i2EwX30rY+ZWBcQTlvUNV8KXcp4tHpUksjm3LAdnH49Cpim2oaIm
	 YkkpO5Dt1YQknZTSIifVA648io/O4OHnDL1kDbin2jVKjYP9qaVURzYJ19iUDMxuFVYky
	 LRdwd6KoDiqPn4rnAaM8DjE1dG8I2aQqAqLz4u3izpat6EkuckEm05cpOY8i7N/ULBmKj
	 jb4xqf2FCr1+QKFSfhapNMnfymHVNbHJD3WjhRTmH6RZQ6qHHBlBKWWm59c4Mxo+3T+A4
	 vpIXyFYw1rO1tGvFSCyhJFxW8/EQA9STDzpbNZO0cLN7wok6cq7b0SwyG3VBuKNQWYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824483;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TtB6NVTta0tvsTqH3AzztjW+y0F8Qfmd7U44QxV+Lc4=;
	b=ulqHPcrvhe7Guh2QalssUPnAsxjACxz7meA+ta2KFhQJGeUvdN0n604U8i4EoB+xvEiR
	 h7TIhKjZs7ogdqpdcCXYPJMYZZ1yQISSUrFImThtwGxrixgjXcsGFExu56FKQ3iOrIFWJ
	 s2rTJ90eytqYu6Mlmg9gp4h2jD2LdtyYgT0C3qgdEMKJI4qRwGiK12GWcHtYpfqsVwT4t
	 gWh5J168gDHWA/e/enyvHzv5HJeGfkioktPR3JHe9HZrtLDBPNT8kSvzaAB0h4RKPw4Rg
	 AAkwOUCatmN1jqYK1f929eMOAjVO4aJYppzDaaUK63Xu+oCMwhORCp570xGvtShBY/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZY6mCzKY;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qccX7har;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBCB606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FBCB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZY6mCzKY;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qccX7har
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794824481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TtB6NVTta0tvsTqH3AzztjW+y0F8Qfmd7U44QxV+Lc4=;
	b=ZY6mCzKYslCYVCgoiHSIHDP2myLAx44R4RcbutjRjjKpdhoxsbYjQyMas6Rc1LYlxsML6b
	J4fH+hbHYEOS1gF7M8+S4UlrQD14Fx6Hn3cz4/LAnvHSQiiOMLX0tZKKee6iUWVwzCupAa
	/z6xAqHMwhMO+mM0ETrE3rGz/JkyvDg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-xPBdBKl8O8aUJWpBA8sJ9g-1; Mon, 16 Nov 2026 05:21:20 -0500
X-MC-Unique: xPBdBKl8O8aUJWpBA8sJ9g-1
X-Mimecast-MFC-AGG-ID: xPBdBKl8O8aUJWpBA8sJ9g_1794824479
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-490c1867460so2037821f8f.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794824479; x=1795429279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TtB6NVTta0tvsTqH3AzztjW+y0F8Qfmd7U44QxV+Lc4=;
        b=qccX7harUwf8eiayr+DfzPEQNO8jtBu0G+uJB5TxwXa2l30hixqgX8IQihn/zG3p8r
         HinAWqG7/9eDvncHZIxEd9PMMgvtJgrOL4NpfP8hQO64ilyrx2Q7KErbo5E0+ixYqpoC
         woZDv40aalCfcg9ed56J1SMUDiua7kEyFjc5w0LN7AXS1hV7JYix3yWmMRoIM219PUVK
         g00YxpfaEWiNOFAIX1NK6TlH31PG4Y3p42EujrYRyfFgf+MId6UJP974D5XgG2AUuCtq
         c47WKJNQ0HeL1trBXI/OavSD7hnR09k+Mel8LAeHyqxrlXOZgdfcednP7c3xzBs0RvKq
         9A6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824479; x=1795429279;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TtB6NVTta0tvsTqH3AzztjW+y0F8Qfmd7U44QxV+Lc4=;
        b=vLIbiZ3H7EApi9hKYCHLErjZL117lnbZfI2TsyT3V2KNeJzcrx5g0hocgiMSBxIvby
         O3DMEUpYBF3yTehyHemqOBoY3Ppm+i/uxAlZ/BOLLpTi0Otd8KLRqszWMHhGtqUP3DdD
         cbnpR9NE5XRoTsdwka+ApZwyOhZUC2uCRcsjYKtOoD6kmZkvVyF1N2NjDrlb+R5iPWfm
         3/7scmL6TUF1bHU7P9O7yM5jjkOr2Io6nDt2AxsHHXLQWvQ0oHzjr5LTnrQMMrLYPH8Z
         nODh0yDZU4ZsskO0yEl2IiXegyV/393C171uFTS6pGvYyO0xx0vs+HEk6BQ5223v+0HG
         HLFA==
X-Forwarded-Encrypted: i=1; AL+hErHpDK45UN7QrtitWbp5/Yaz/SKxj9Lnp9LuBUIKzDl0eO9DReAhqwdJl6y2YggzNarorgksjZw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jMBfG3xBiuUQuJnKr2/6s/PRPjZnvKUm2YOSJuImjgWoGA42M
	tXRSxkvio0ZVeuJX4dNvhxKJys1LSORGtQNS7BQ6KiNSaUK31le4q+/kEnf3MKC5OcXO3QVd6Oq
	atxop6/3K/B12rS5ItIBQq7FLNMccwuDu0Nr52auQL8ku8PsYXCebGZibGg==
X-Gm-Gg: AZFdTZfIHIXoc93lzRgQKav8BNfHDaNNY7Vo0J6qJHpiIAsABLP3rx1jqG3VS/tAO0t
	rqPo6C66uP6WzKvib1j9d23sVAlO9nzq3YQ28rOsf8oCSgbMjd5FTTRgJzEybWUf9Ma9mrDvTI/
	w+EXD3Ti2E51iJz6QGyFWfA8N+j2rJQTu0gjeVo4AcK708H+I1wiu6Bmp+tud7iZDOgka0C9NKy
	7hc6IE0gCRwVyLZH8Ts2WfP7KBO3a1z6qI5wfonLI6vg7tNOXxqGPOT5IhHxoaZLHZUD7IlvnDv
	546Y5QfQyisEBMc8MtP3LqEnZyz+XJfV1829xu2IdGsQ1CDNfD8MqeqsLQKjZzUg1v90ABxzPYw
	QXxFX4i1bv922N2UXaV2zolkQ6CzkPXTSh074SujrRL9XSVv+q6ywFQRRiEnC2iIGxAL0vdPX3w
	22n3o=
X-Received: by 2002:a05:6000:3108:b0:48d:f9dd:e3de with SMTP id ffacd0b85a97d-49c7353c415mr20874719f8f.45.1794824478820;
        Mon, 16 Nov 2026 02:21:18 -0800 (PST)
X-Received: by 2002:a05:6000:3108:b0:48d:f9dd:e3de with SMTP id ffacd0b85a97d-49c7353c415mr20874640f8f.45.1794824478326;
        Mon, 16 Nov 2026 02:21:18 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60116323sm20991495f8f.32.2026.11.16.02.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:21:16 -0800 (PST)
Date: Mon, 16 Nov 2026 11:21:12 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
	tglx@kernel.org, will@kernel.org, boqun@kernel.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	luca.abeni@santannapisa.it, mathieu.poirier@linaro.org,
	longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, shuah@kernel.org,
	bigeasy@linutronix.de, clrkwllms@kernel.org, parri.andrea@gmail.com,
	m.szyprowski@samsung.com, kayracizmeci@gmail.com,
	weihengqiuu@gmail.com, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 13/29] sched/deadline: Keep departing bandwidth across
 a root domain rebuild
Message-ID: <avrZGPNdCwZMd3B4@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-14-mathieu.desnoyers@efficios.com>
 <avRmoK08LoIeySBL@jlelli-thinkpadt14gen4.remote.csb>
 <c3e7054a-486c-4e5a-a646-eee42e815ce4@efficios.com>
 <20261111161912.GP1779021@noisy.programming.kicks-ass.net>
 <83b2244c-f68a-4af3-9c8f-0fabb4eacbb4@efficios.com>
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
In-Reply-To: <83b2244c-f68a-4af3-9c8f-0fabb4eacbb4@efficios.com>

On 11/11/26 14:19, Mathieu Desnoyers wrote:
> On 2026-11-11 11:19, Peter Zijlstra wrote:
> > On Wed, Nov 11, 2026 at 10:35:17AM -0500, Mathieu Desnoyers wrote:
> > 
> > > Measured in a 64-vCPU guest with sleeping deadline tasks:
> > > 
> > >    tasks    today: rebuild, longest irqs-off    single list, all irqs-off
> > >    1000     0.75ms, under 0.1ms                 0.12ms (0.19ms worst)
> > >    10000    7.4ms, under 0.1ms (0.3ms once)     0.9ms (1.2ms worst)
> > > 
> > > The rebuild itself is 8 times shorter. That comes from updating the
> > > extra_bw of the CPUs once per root domain, not once per task. But the
> > > longest section with interrupts disabled grows with the number of
> > > deadline tasks. I do not think that is a step forward for a real-time
> > > class.
> > 
> > This is domain rebuild? Do we really care about performance there?
> 
> My worry is not performance, but rather the contribution of this
> "iteration on all tasks" on the irqoff latency of the system, which
> is relevant for RT.

My take, of course let's have Peter keep me honest here. :)

> What I don't know:
> 
> 1) is 10k deadline tasks something that we should consider as realistic
>    for sched deadline, or it's way beyond practical scale ?

It doesn't seem a very realistic scale to me. Yes, I've used this kind
of numbers in the (far!) past when running experiments with DEADLINE,
but I can't think of a real workload reaching these numbers.

> 2) is a irqoff latency of 1.2ms (rather than 0.3ms) something which is
>    relevant in terms of irq off latency on a preempt rt kernel, or is it
>    in the noise ?

Very relevant I'd say, but 0.3ms, unfortunately, very relevant already.

> 3) are those domain rebuild expected to happen with a live RT workload,
>    or are those operations expected to never happen on a RT system under
>    real-time constraints ?

In small systems, single workload with few housekeeping CPUs, I would
expect the setup to happen only once before the workload is started. So
no worries here. But we seem to have people interested in consolidating
multiple workloads on big machine by, say, using containers. So, in this
case there are several exclusive root domains each running its own RT
workload. It would be undesirable (to say the least :) that a
reconfiguration of one (or a subset) of such domains could potentially
introduce latencies on all the others.

All that said, I now wonder a couple of things (which can be addressed
separately as an RFC if also Peter agrees we don't need to tackle this
right away):

- The 8x from updating extra_bw once per root domain instead of once per
  task does not look like it needs the big lock? Maybe it's a nice
  improvement we could have on the current scheme as well?

- The deeper issue the scenario above exposes is scope, not lock
  granularity. I wonder if a rebuild really needs to re-count root
  domains whose span and membership did not change. Maybe some kind of
  re-walk of only the domains that actually moved CPUs would shrink the
  scope making reconfiguring one partition a non-event for the others?
  Again, we can think about/tackle this separately if it makes sense.

Thanks!
Juri

