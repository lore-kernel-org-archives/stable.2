Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194606;
	b=1Ckprf2spzn4uU+v84WMNpJ6cqhVZApzrT8SJvf5jg1H2ewTrt5usmBRCfZqSnyiEg+0
	 Hyv/FOWCnYE3f/TPDukIw2Izr9M4W2b0NHCVSKILkLb9WGM3dAu3S64ZoZ5crZr5BIC7j
	 bv4ez2Et0IpSuAbxo7LmskNuj8KDnmej/y5xjVbimIXJaW6yZ1e0bgekkGql9y+l3jF0m
	 tnSREaVuwdWZ+AvI2naR/S+cS71vmmhh9OY2xVKr6yeH1IwsVlm9EZAD8tr73lUolc8OM
	 5Hr//h5CkBCsa44JSennNU6KlLlfGdY8q/6I4bEPCDOS33WuQOiN9xP8Lnb2g5oKIhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194606;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=J6EcKPCt+KfAzvCKSl56m3Ot7NS7Ub9tU52adEj4q9U=;
	b=cwPbpicHIrJTOCqvDXlNihG2Jij1P23QNlcdfSnkDM8csuFQkLTjlq7rYTEaMJIqEXFM
	 U7kYmclSjAIfXJ4sSR8E/HsNC0NjRm6ql4h8dp5Yr1RjJv7SVX+aFSMH0ad6S3io9pymU
	 /sc7IWjPelwtAJON6swmdztq7h1t7v3dNJhJh2cMXoi+DfSVksrcHK5WIMD1RyRwwvuqP
	 Z7Zv3GSYxbvY+ILoPv20kdjt8PW1tavStWnJ4PWD8Tl5Fq+ae5KC0o4x4+nfJFzaJMSKi
	 0yjrYpGiSE4VPHoiE90XMGIVM1D8tYZamc3s64qzUsY8AOFew27CPBVZcTn/4oCgchQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IaWKzCbo;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=r9LlN0Uo;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9108760A2613
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 17:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9108760A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IaWKzCbo;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=r9LlN0Uo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795194604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J6EcKPCt+KfAzvCKSl56m3Ot7NS7Ub9tU52adEj4q9U=;
	b=IaWKzCboaIVzaO1T4dKi0eSuCGRQOx5ceeNhIx6+D0CXrEA/7SEDhcOW6Ya1vo77WS+5LN
	Qh778po0KOMt/V8Fgu4NK77nkDJ9fZw5WADlWMoBsmCm8WXM2gAeX3B8HIGPjGOvnPUafz
	NEZLICJZojWWHwu1tnOlURfbWKde6KY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-eL-yUpsIOTuVTo8gf2wwUg-1; Fri, 20 Nov 2026 17:10:02 +0000
X-MC-Unique: eL-yUpsIOTuVTo8gf2wwUg-1
X-Mimecast-MFC-AGG-ID: eL-yUpsIOTuVTo8gf2wwUg_1795194601
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-492b5408dedso646643f8f.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795194601; x=1795799401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J6EcKPCt+KfAzvCKSl56m3Ot7NS7Ub9tU52adEj4q9U=;
        b=r9LlN0UoZvF9GDkpYCcqm6LjKUkYUPlIUhYbV+2nG23t13IitrM77sx9dR2h2ecVz+
         abNFMQY5z0ZWDmErm6eL2+in1XEOkKO0FD4aYLkemOPz01k0PlYEIcSVGh7syv73ecGc
         eoEVuYyHoOQAlBs5kajQeh9v3tGqnnyIr30p7h7H0hsqJ/cuh43bal8Xn5tviFjOjMtb
         W46DFR4ER8AsRUDkYOUqHXEpiiv8bwRPzs+NxeQJG2Icb5Blb6xFUWs0s6MAJ1M1htZL
         ABd28WOx+pTw4CL3/d6mNO9aTVj84dxenvj4CDZIUTu79di1S02UxbDs3aCxh1PFbCYZ
         1/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795194601; x=1795799401;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J6EcKPCt+KfAzvCKSl56m3Ot7NS7Ub9tU52adEj4q9U=;
        b=ycfQYb4IjOd5oKI/ocWvzU53GQuzbjYz2sIKzk/79vD7NfIKWkCVYiAfNtA677dFSM
         OfErAvWW4C7gaeHLaVRLtVqzOVazYaPGIwebn/Y9gVxm6R8FE15hkRBT3LA/xlHgbFIM
         YXf/J+ytEE4AhV/lcoytnMzDfShUzxanTLeCOR5wNVa05q+mn7qQcDwZyAW4KBK2RiHK
         LSyO0bGln2i5LNEfvA9Z4s0ZEKUftLOXIhzgzEsDuJM2d03mXLPP0HbZbrBi0YsgKBQb
         ZspcR9k8FZ8yxHWOPvn/WhdzdvIUIKV8ASEfmBbkazu+RKFyeJUO5BG9TQTRy38o1mYS
         iXmA==
X-Gm-Message-State: APuU4Z+i3ot4ylDyWGUDI1ChiRECrAV5zdCgVKn9fxP26hsvGEDUs9D/
	cPoU75HMkeJo2ER6dNJG98YmnmcXsJvMGxhjxzmhmCcMf5K/YeEkdN9fcH+ndATOg0Y3wkD2Be9
	gRTsPRl3AgkDnmRxSb/yTYQaQCLeBTzr5b2MLzgkved28Ks9CGMfEfQhUFg==
X-Gm-Gg: AZFdTZedw/r3kWPzWgIhDRIPEc8rAOq00exMwlBkBkJoIUCQCDqL94LONyAg1PmP0lr
	DLLWdQpCJkdZ1e5H4jxY/cqVjpjFgD/uD100HbAL70DFGCGXB/PM1zisPAcqWAd8brgIO3ldh9U
	tJ8wpO4zM7o2NjXuPqjb3Bp0jkXR3OD2deb6q2csVBSkL1WEum69kcpoXgNnM0wLyFdnrzSXwfX
	BO/LNQ7c9SZOgxHi86R3OMI92VwHb3bhI2etsv4whD4g1uWFLa8sc41cTDtQNomfbFGVaK35B5B
	ihbAhw1BceVyJl7JRP3ppjc8GRU1g7/naLUfoU6yL4jN8S90M/Wmmc+cX39cNwacnTtQKQEPg/a
	h8sQ99kc/ei91/S8XaKz/mso1xdtCosn42DWQVcrDXOxXIJeCexMgS74uoOIMzoXbJqtWVwm7Rc
	BenSI=
X-Received: by 2002:adf:e010:0:10b0:4a7:518f:bea6 with SMTP id ffacd0b85a97d-4abb3a4d2b1mr5619852f8f.28.1795194601129;
        Fri, 20 Nov 2026 09:10:01 -0800 (PST)
X-Received: by 2002:adf:e010:0:10b0:4a7:518f:bea6 with SMTP id ffacd0b85a97d-4abb3a4d2b1mr5619795f8f.28.1795194600653;
        Fri, 20 Nov 2026 09:10:00 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a680483sm6652201f8f.28.2026.11.20.09.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:10:00 -0800 (PST)
Date: Fri, 20 Nov 2026 18:09:58 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Florent Carli <fcarli@gmail.com>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-rt-users@vger.kernel.org
Subject: Re: [REGRESSION] 6.12.y, 6.18.y: fair server runs SCHED_OTHER ahead
 of SCHED_FIFO on an idle CPU (fixed in 6.19)
Message-ID: <awB-5usPb2QZXt37@jlelli-thinkpadt14gen4.remote.csb>
References: <CAJuRqcD2=42CTQk2PSHofSmt+=H=qKT-x-ZXD76TwVshaepBAw@mail.gmail.com>
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
In-Reply-To: <CAJuRqcD2=42CTQk2PSHofSmt+=H=qKT-x-ZXD76TwVshaepBAw@mail.gmail.com>

Hello,

On 20/11/26 16:09, Florent Carli wrote:

...

> On 6.12.y and 6.18.y, I see it run SCHED_OTHER tasks ahead of RT tasks
> on a CPU where nothing starves.

...

> The fix went into 6.19:
> 
>   e636ffb9e31b ("sched/deadline: Fix dl_server time accounting")
>   f5a538c07df2 ("sched/deadline: Fix dl_server stop condition")
>   1e0a2ba7afb1 ("sched: Provide idle_rq() helper")
>   ca1e8eede4fc ("sched/deadline: Fix server stopping with runnable tasks")
> 
> None of them carries a stable tag, and only 1e0a2ba7afb1 applies
> cleanly to 6.12.y or 6.18.y.

Thanks for the detailed report and the reproducer, much appreciated.

I had a look and I agree with your analysis. Comparing v6.19 with the
current stable heads (6.12.118 and 6.18.64), these four are the only
dl_server changes not yet in either branch. The other dl_server fixes
from that period (including 115135422562 "Fix 'stuck' dl_server" and
the two "revised wakeup rule" follow-ups) are already in stable.

On applying them: with git am (no -3) I get exactly what you report,
on both 6.18.15 and 6.18.64: only 1e0a2ba7afb1 applies on its own. The
rejects are context only, though (upstream refactors around the
sched_class callbacks that stable doesn't carry), and a 3-way merge
takes care of them. With git cherry-pick, applying them in order:

 - 6.18.y: all four apply cleanly, and the result matches upstream.

 - 6.12.y: e636ffb9e31b and f5a538c07df2 apply cleanly.
   ca1e8eede4fc only has a context conflict in dl_server_start() and
   1e0a2ba7afb1 needs a adaptation.

So I'm in favor of taking these for 6.18.y and 6.12.y. 6.18.y should
go first, so that 6.12.y never carries the fix without the newer
stable branch also having it.

For 6.18.y, since the commits cherry-pick cleanly, it might be enough
to ask the stable team to pick them by SHA.

For 6.12.y, could you then send your backport, rebased on the current
head? Please Cc Peter and Gabriele on both requests, since they authored
the commits and myself.

It would also help if you could rerun your numbers (latency and the
starvation check) on current 6.18.y (64), as 6.18.15 is quite a bit
older and a few dl_server fixes went in since. I tried to reproduce on a
local VM, but I think my system was too noisy to see what you reported.

Until then, setting fair_server runtime to 0 on the isolated CPUs is
a reasonable workaround. Just keep in mind that it removes starvation
protection for all fair tasks on those CPUs (kworkers included).

Thanks,
Juri

