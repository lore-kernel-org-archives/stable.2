Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792589927;
	b=BxTeFlbtVuvA3G95kZJl7nCw6SamTewZqHpzEelXI6WUToWtgLWoRqL36KmSlGI4uIhR
	 Sgqszw9IQBSKLpwbENU3WhhgKKz2tiHO7XdoyKVEKhSd9HVUTBAD3QmAt2zysRKj0GVZn
	 rVGa+mEIzm7C4oxtst7pyEIzpw4rwYxFGUvQfL0+s3Kw8vabzzMQ/i8zgj22NT0WyEYAX
	 jksdoNcB7WIlNm44idmwBt+mAvsbJ2ppW6+P4tpym07w2Q9W556WAGJ2fA2BTYaj+qQ4H
	 Q2D6hfwOCqhWJ4X7gaeAqDT9mYT6UznBjzqbuYQ5eCr5dAenkE/pq4ws+ZeESEgWVwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792589927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5c03wHQY/A8JbxeL/7g0tRvKNDHudBeP+rG9bb169uk=;
	b=W3tkaBHrcwgsfc5DqNvNUsmhFKm2HjrduQd3Li9U4/3UOFKkPebKuBZquNYX+FxHOkiN
	 t04YiytSbaCtX9uGpLJaj81g+Omr0+UF56yM+/Z1hZXlAI2LgVYdeGX2FiMiJ0e8R1cki
	 3AcT+jxKCJtj9ey9JKTU/o7gp7+gTFoaT8G6k8S70Vqn+YPQI8JzFuWFthk3uMiyJfY9O
	 JgN7gF2fyEsLwLGSvy9Yvymtmg7qVzSnaTCZRZAT8QHoO8mM/biRY0VukdCZUVwJNtNZj
	 /sNlrRzu6FxQJK+FQOmfKFLhrspCu7/lgNJfBvMW5kw/HfRCcJPG48MwOF0OrCmgWSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jXCMSsEE;
	arc=none smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192C1606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 13:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 192C1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jXCMSsEE
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66fca0709caso576634d50.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792589926; x=1793194726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5c03wHQY/A8JbxeL/7g0tRvKNDHudBeP+rG9bb169uk=;
        b=jXCMSsEESFZVjdjzfNi/bSWJKOk17XHYGmVTOCwIqZR8IXFZ6JaIxgj94S01mE6lUN
         kq3GZopQP4XE3Aac2PnfcyXRLRPRbsLLJlSf0T32r8vh0qDFMoYAopIX+TKjG29ZXM4Y
         zSN3qBw5x1XAQ0jrz5EGFddq+djTNyr7mu+NuNf3Ur43I54hi5uxGp5PO8CHc3EHyN2D
         0y82te8fXM447P4Sc40m4ZsRGzrgXJrH0EneZrcrRHAfmJdkkg5hVh0O0HidBJREB09b
         ctxtwOFsO1hWk+J6+BL8H+WgneHn54rwRdrGbnWvyYGAgknwA5yY1RVuSI55SmggxVAX
         8U+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792589926; x=1793194726;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5c03wHQY/A8JbxeL/7g0tRvKNDHudBeP+rG9bb169uk=;
        b=Zu8/r9sNMgTnN2ivk+g8ZiWsRMhIxDvyZSb4rckAcfxohLn5viWDZ0NQNuZ2itx6S8
         7/vEgdkiNJhuCiNrCJmGsrAY2Ote0ZMmPctekHzuLH0TmJXiJAEC2gx3GSBf+OqUPWS5
         QrD68udL4XykHPD/664XNh1+Qu2yxwWPxGoA3hbROH2ylWhaDdbWfF/RZdy3KNmNt0eB
         Erv3w/yd2l63QE65Wnyo40df3i3v2ThWSYRXDk7F8eR8RoRA/vXGxwhq0dowpgEQGGXa
         sfXzD/f4lf94y70xH0o9uScX0Fn9dN99xbIiZOTbAzErJqq7/RecMwr6DTyJGsRArLR8
         nerA==
X-Forwarded-Encrypted: i=1; AKwUvBxhynL2KAdr/ttIF2z+vY+v4IRPAhHaRGNOciAer+VLNJypF9Q3HelVN9v3S2BVzsMSeP+Uzho=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnxIXeaJE2Qdm+CK6Y1ZKgdoHppOYi23+7+DJl1DSwO7LkXwgx
	EBAjcWFpG9WORmFWAf2czSyzSQU/2SOIchfupj9oIGCxHugJyg+ffu5N
X-Gm-Gg: AYBFou3bRxYJJ89u1RhWqg9vYq7N0B7W5ldTr5qyJiQu97PH9JVE6YuE/xynsWM+16W
	ck/spLTezh1EdWHJ2k/Nt7oKHaKhEWw7vPcFmKBaXsJSssLFLFw6Q0dJ+P/4eu1zAHChFXItV2y
	zIMWv89BfS1fKBfVI7Pqfj+vNXOXbvalztuusVpLWb74KOomhhmXFgovdseSr2tleVReExgOHJ/
	f8FfeOBILd4mKnTnUx5QLfsuMMbLT2fNN8bM20+55M7U0Nq8k5QUtg6u4whu2itSiODZgFF0Lpv
	Sk/s5SD6EmQsCFO/mBWrtv2IiWpmEafkx9FQkdeLmznNWX+6WSVD4iGuY4sZYfb6C8ZCekW81/J
	o8mUdYYusqfAzXuhOM6pyEB+3FPrKXTlLSwvxIk2GsxH/KCPUHI37A1ZOn3TY2I5n+mWU00u24E
	gJu/p0llcgDG85iSYLfuoTDl524QFjHmTUS88bYrolmEUtCT32pG1ryRlP8QtRbZR0eW5wPLJCb
	Cps4arZK3XnbGF4f7si5IfbrWIjXGQo3+A6GCl8SGPswmtE3eUfBYnSBQcJKjDxOjZwIUeGvy6G
	8zDbFAHGf362xmksqGYUXRr9PoOgXgoFY2OJFHO8Ss26oTA4ymuHn1zFYR65sw==
X-Received: by 2002:a05:690e:d8b:b0:679:bf13:c01a with SMTP id 956f58d0204a3-67a0ddf103fmr945125d50.0.1792589925959;
        Wed, 21 Oct 2026 06:38:45 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a0e501c01sm1052477d50.15.2026.10.21.06.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:38:45 -0700 (PDT)
Date: Wed, 21 Oct 2026 08:38:37 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, hare@suse.de, dwagner@suse.de, frederic@kernel.org,
	tj@kernel.org, sean@ashe.io, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] blk-mq: dispatch kworker to housekeeping CPU when
 hctx cpumask is empty
Message-ID: <atjAXSTH2aRligiA@fedora-laptop>
References: <20261016052203.489760-1-atomlin@atomlin.com>
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
In-Reply-To: <20261016052203.489760-1-atomlin@atomlin.com>

On Fri, Oct 16, 2026 at 01:22:03AM -0400, Aaron Tomlin wrote:
> Commit a46c27026da1 ("blk-mq: don't schedule block kworker on isolated
> CPUs") excluded isolated CPUs from hctx->cpumask to prevent worker
> threads from executing block work on isolated CPUs. When all CPUs mapped
> to a hardware queue are isolated (i.e. blk_mq_hctx_empty_cpumask(hctx)
> evaluates to true), blk_mq_hctx_next_cpu() returns WORK_CPU_UNBOUND with
> the intention of offloading execution.
> 
> However, kblockd_workqueue is allocated as a per-CPU workqueue
> (WQ_PERCPU). When WORK_CPU_UNBOUND is queued on a per-CPU workqueue, the
> workqueue core resolves the target CPU via raw_smp_processor_id().
> Consequently, if a task executing on an isolated CPU submits I/O and
> triggers an asynchronous queue dispatch with zero delay (e.g. upon
> hardware queue congestion, tag/resource exhaustion returning
> BLK_STS_RESOURCE, or plugging), &hctx->run_work is queued directly onto
> the local isolated CPU's worker pool. This causes the local per-CPU
> high-priority kworker (e.g. "kworker/6:1H-kblockd") to be scheduled on
> the isolated CPU. In real-time environments, an active SCHED_FIFO workload
> will starve this SCHED_NORMAL worker, causing hardware dispatch to stall,
> in addition to introducing unwanted latency jitter on nohz_full cores,
> thereby defeating the original objective of commit a46c27026da1.
> 
> Introduce blk_mq_hctx_unbound_cpu() to select an online housekeeping CPU
> from housekeeping_cpumask(HK_TYPE_DOMAIN) via
> cpumask_any_and_distribute() when executing on an isolated CPU, and
> otherwise fall back to WORK_CPU_UNBOUND. Use this helper across the
> unbound fallback paths in blk_mq_hctx_next_cpu()
> 
> This ensures that:
>     1.  When executing on an isolated CPU, deferred queue work is
>         cleanly offloaded to an online housekeeping CPU across single-queue
>         devices, hardware queues with empty cpumasks, and offline CPU
>         fallback paths.
> 
>     2.  The per-CPU high-priority kworker on the isolated CPU is not
>         scheduled, avoiding priority inversion and latency jitter.
> 
>     3.  When executing on a non-isolated CPU, WORK_CPU_UNBOUND is
>         preserved, maintaining optimal local execution with zero CPU
>         bouncing.
> 
> Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")

The current code follows behavior of schedule_work() and other related
wq APIs. If you think it is wrong, care to fix schedule_work() too,
otherwise it confuses people, IMHO.


Thanks,
Ming
