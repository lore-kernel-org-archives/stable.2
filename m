Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582405;
	b=sfZSgcg/ZBmalTCX8NHooIka70bbX1/yWUrXqncBgkkXA51uhJw4Q091j9B2JnxNt0Xf
	 kUNDb2wut9G+5v4ICprfdvOQfqSioCn7fLQKRIt/+I8Wq/4FfDoNup2XaD262Y/MWWRx6
	 Ks06s8NtSJEjqWB5KfJ7V8t3crHSrcwbMe9zgEld6TIQWhlNGGpdB8/sdHC2UZXZewCFh
	 llYn/d7/dmGyiHFf+Nkj2+QxFZq+D1Rr7megAwYb3nYEu3tTd1/Bf9QuXtPgAZQiGxRew
	 4rfCnaJ8+UtDv39u46vaB1hB69L2fokP4/YGRT8AzRQJZmhEgSJ+2FZaoYlwyyuyJfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582405;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2Tp6iQjkfangii/DKRnGc80WH6QKMSA/4QcC/JVtYtI=;
	b=uD2xJmJC21psHog7Pf6OcScWqQsouK0akAMizMAolfe9wrQd3X+Mo6AucoRrpTdaAqt1
	 1DTxHpHYibLA+9iky33BifLFCwb3pMGyiLK/D1smesaatA0cpiVPq/MwxSbaXhI44gGDJ
	 y1hITZPIMCBpx30kLmbyDJbHocqrp4IWr9amAMagn0ToYe2+/s29sLVJoBFueYWKL6U05
	 nlx8Z4MsS83HmIxKOBlygnBEHPMmjEb/aYt/S8DsAhsN2QzRhV8Yw4jml9mnLSl0Mjg2r
	 tnKIskE9iMVsWafzcDK4yec9p8IhA6lOjDuvIOLuOGjX8TzGnOQcMHJSZmuyUNKtm0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TciBMSmE;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ns5S0Tu7;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E861960A6F70
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E861960A6F70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TciBMSmE;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ns5S0Tu7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794582404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Tp6iQjkfangii/DKRnGc80WH6QKMSA/4QcC/JVtYtI=;
	b=TciBMSmE/FFXG9MYsN+ix7zwV6Y6/GUs5mmtdk4MHuNf8la8FlUCTpWUPSiAEpOvvbOcOe
	XjOsiRDLwQu3u7vdeSK/7pE6jiIQjWE4OjHh5/Yv9KTgGj/jTqW1e4pG2TfE86saEgepzz
	FBPEkedIRBc4UF6w6Twyl8zXqj5XgQs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-PixXURTSNVuFLs71II8tNA-1; Fri, 13 Nov 2026 10:06:42 -0500
X-MC-Unique: PixXURTSNVuFLs71II8tNA-1
X-Mimecast-MFC-AGG-ID: PixXURTSNVuFLs71II8tNA_1794582401
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a35db2d6b3so6208815e9.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 07:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794582401; x=1795187201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2Tp6iQjkfangii/DKRnGc80WH6QKMSA/4QcC/JVtYtI=;
        b=ns5S0Tu7MrONZXzIzknq9qO83Czobv4jEAo3Ald3QMyVHS3ISoFwgkL7ShfNZ2GFkE
         0Jk0Fl5u8nkgUaJG9HLkJ1vmAj3Mhf+MuOr3LlU5CRjQsDtNyQ4ro5pnSosiHing3aGj
         CSVsPusCsNEZ+tFBSX+rvrv/WMErUp0AiSLlbKDl0jnduSPaNh1YYWUwETX0vGso1dx7
         5g8Bp2hlHDkXrZhrBqhEtigFDnd5SCvAs9gxkf6YOp0Rhz9P5nI7zdKSQaOo4kh41dG1
         wur3/LJkw8oKkiO+EeTI5cmtNZzHnebHw0cgM1EW8ajBuRPJ2n28z8pNw4gDCd9kXi/V
         54gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794582401; x=1795187201;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Tp6iQjkfangii/DKRnGc80WH6QKMSA/4QcC/JVtYtI=;
        b=bXYzpFPJVw6eLDdfJzxJ1ma5iFQ96xH76KwPcbjUIxnOp2QmdAyRh98T1qcpdPYx+N
         Dggpo8Si+Z6zY2YxjtRHf4FdhbxCMa7zyJoEB/JYMZyoeeK8Qb4ie0GC6kgNVI1D2Y/e
         BQD6pX2YJ9ZfIvX6Qm6lNU7EkSmrG56r3pMxRgjt2pFGMCgnmg9YgPUiWwYYT8rvfckv
         vSYl1eFvPveN14x5e7kXysoCoXr8GtcLtg+AGTigGQ1msl6p7xMGQBpU/kRJ8Li/Kb+L
         CjNqpOsaZLZMZhi1cPfVcbeN8Qanv2KEQuKjht5uZsFX/ZUSLPeJaqVCQlmyem5eZqpx
         T7ZQ==
X-Forwarded-Encrypted: i=1; AL+hErEys39eNg+2Xrq2nCm5zg1owLqbwnAwJuwWwTAcJSTmRrsG+cQX1GfEOaqCf5DkvAzoX19eKZ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z92mmGXX2NmMr1v8/om2+K7X6AIuk8F/w3HfOQwFhmqgSn9OPSd
	RS8l1LK3kSzsB1nf5raAgRl3cclFaKBKI4hRXzXoy3HUN+hQsPQ5DWUXehTu87p97zOWJW0FM8k
	i2JWQPiE5xJxLMBlXHpDVqlBeqo0oSQMe5H/eYwndFvwH9SBfH5FYOwUnug==
X-Gm-Gg: AYBFou1WZuO4oRMdpzjHg/4o0MYXODo+5Ao86++plGqdBP29dwYvHs1oVIL4qn3Z5Ho
	o2HrbRjb42PuwqCdxtxTQbEdEvWL94CQxJE6PovItGCJn0d7lacVxRzn2znSiVXrId8CgEqFIcw
	QDB0OUngiD0w2AHhG6/JHulwSghe1cv222fiq/et1FR2mIYJmjwGy3zlxwNnvNy6ja9OaqvM4z9
	WwzOdtGTHR6l0dG2u4B57buUcAtI2sUSD/d3YThbl0V6b7B3+ozkkdsiY3keVsYiO/dm4WpthMC
	N73kMHIx4A5EVxjwb8AEmANKp0yGeYsojCkcAHSleWCzKBz+PR+CFiuGOvwARNdacHjryY3bNVR
	kfF5J5G2ZiHhqH8rEw9KUBt4XOm+Zgh/dlVWdg0EiiUzZs7o2lmeH7i+zpyH69+kB66MyXFf44A
	WGgW8=
X-Received: by 2002:a05:600c:a30e:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4bb55a5d63fmr51094585e9.11.1794582401497;
        Fri, 13 Nov 2026 07:06:41 -0800 (PST)
X-Received: by 2002:a05:600c:a30e:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4bb55a5d63fmr51093885e9.11.1794582401031;
        Fri, 13 Nov 2026 07:06:41 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5d2872edsm20774755e9.12.2026.11.13.07.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:06:39 -0800 (PST)
Date: Fri, 13 Nov 2026 16:06:37 +0100
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
Subject: Re: [PATCH v5 16/29] sched/deadline: Record the root domain holding
 a task's bandwidth
Message-ID: <avcnfTqZzNGLlbHk@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-17-mathieu.desnoyers@efficios.com>
 <avSPoSnNATnwZ8cS@jlelli-thinkpadt14gen4.remote.csb>
 <7459ff0d-d8e1-4fe4-b2de-4b4f06be9bb9@efficios.com>
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
In-Reply-To: <7459ff0d-d8e1-4fe4-b2de-4b4f06be9bb9@efficios.com>

On 13/11/26 08:33, Mathieu Desnoyers wrote:
> Hi Juri,
> 
> > > +           if (p->dl.dl_bw_gen == dl_bw_gen) {
> > 
> > So, this is not guarded by dl_departed_lock, but then this gets fixed in
> > later patches?
> 
> Yes, but only as a side effect, and the patch should not rely on it.
> 
> dl_bw_gen changes in a rebuild, which holds cpuset_mutex. From patch 18
> on, set_cpus_allowed_dl() reaches this test only from cpuset_attach(),
> which holds cpuset_mutex too. At this patch, from reading, other
> callers still reach it without cpuset_mutex: select_fallback_rq(), and
> sched_setaffinity() with admission control off. A rebuild can then
> change dl_bw_gen between the test and the __dl_sub().
> 
> The planned next version takes dl_departed_lock around the test and the
> update of the record, from this patch on.
> 
> > > +    * enters the class. A runtime below about a millionth of the period
> > > +    * gives a bandwidth of 0. It counts for nothing, and no move updates
> > 
> > Ah right, quite cryptic corner case buried in this comment. :)
> > 
> > This is the 1024ns/2s of the test. Which indeed gets dl_bw 0. Don't
> > think it's a huge deal from a theory/practice pov as to actually make an
> > impact we probably need quite a lot of these admitted (fork bomb style).
> > But it's still weird :P. Not sure if we want to impose a min of 1 dl_bw
> > for these. If it actually complicates the accounting (for no good
> > returns) or not.
> 
> I agree that it is odd. I left it as it is upstream. The accounting
> needs no special case for it beyond this comment: a bandwidth of 0 is
> added and removed like any other. The case move_zero_bw of
> deadline_bw_test covers it.
> 
> A minimum of 1 would change what sched_setattr() admits, by one
> millionth of a CPU for each such task. I would rather not do that in a
> series of fixes. I can send it as a separate patch afterwards if you
> want it.

Makes sense, thanks.

