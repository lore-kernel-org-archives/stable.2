Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404985;
	b=3yQ7it9yVzA619c806PEqsaR10lIitdgQxkj6zdImCRQZGyinWbcLSa29zDksv7UZgd8
	 zsGLNOE2jCFMVkrfVSAdREs1FfijP1UzyAqVbjqAu1Y9HUEks3TkWaVa6wew9AWUEteEB
	 FKzWKv/+ymu0rLdTB22rjjssEynax6D6AZ2VQ/uJjSuVAVT5BjJIF9Vxn1780ZyF468rh
	 9f/eedt8yrvZVAFNN9T5IOJt9l4me7PseE3bsAbeJ+WCNGli27KJuxaoCyl64H5v/ub1X
	 AhAxcR7eh1aq2Ixn3j/lm3NT7LNZubMQBseviNUr1tdNqez79mKHd1723XkXwbisP4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404985;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QrqbGrUeaMzxTtNKFPqZn9l9SynA7oL6rbPLiV4WlNk=;
	b=qjRfaXe1+XVKhnQ3fINrgCuOipEC87P3iZ/iXWFlVQAO0D4qhnzPqKLYJJp8em+w1uda
	 op3zkG2nrT16iTJ1xryqpM0rnTkedADEXbolCHAa+s7dTYl8VUxnw3aWSmuHcnDctDNwt
	 znznE8XMBWcRb+qTiWvvZzhSe8kudMCwZovU9F/+SDRTVzkTnxutp3ZD5XvWTBemN1sFU
	 CZokCqUySeg1PXZWavZzgf9OBjKB8CBvN8cU9Lwk8mk95knx6WEHeapzZ4vvDuj1eYngR
	 4oN2meuAGG7qu5Vq6slUJ22ajmAAGwAr8Qsu1a/lUUqZDB+rpTYsh2LP8wWWBPqGuiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dxa+lxRe;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=i7GQQlT9;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8A4606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A8A4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dxa+lxRe;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=i7GQQlT9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794404983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QrqbGrUeaMzxTtNKFPqZn9l9SynA7oL6rbPLiV4WlNk=;
	b=Dxa+lxReamTY9bp7EcOWVafTkGHpIkIwVWZ4Wk1F/qz2TmtgCHN4s2aeSMcSQG6qw1Yz0f
	aZ3DwhFUVXkGGeOV3MxruAq91CHHk/Iraqsz6LWJctd2/VJQRKiWatJXLBKMUCDxRn+O/F
	vevXgaHOA4MwGrM0tYF81AP8HdhYcDw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-6sdf_gDvMm2Flt5xjJOVgg-1; Wed, 11 Nov 2026 08:49:42 -0500
X-MC-Unique: 6sdf_gDvMm2Flt5xjJOVgg-1
X-Mimecast-MFC-AGG-ID: 6sdf_gDvMm2Flt5xjJOVgg_1794404981
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a20fd059ddso23413725e9.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794404981; x=1795009781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QrqbGrUeaMzxTtNKFPqZn9l9SynA7oL6rbPLiV4WlNk=;
        b=i7GQQlT95Sb7l8iWRKyldHDMVoU8dEQ8LiXnZ/hsSPVTmpVPPFHPcB6HPY4EJj9pXU
         Nyw0+YSthtfLeTFqEMaMCW2lXgBUEMBHGxPVxY3RyRUtE2fccvhNeF+yeloPLamC0ct+
         1tLlBJjv7LjgleRz4OsNRroLTN/NQHrdCy5Vr73XAYrVVO98+580y6l/t5Xx5YglOKkh
         8UMvx9Zwo+ctLLVC8glyZtIIlsb34h51iIjhpJvjDrF1gzLRU2XUgZ3fVtFU/hfcBgCI
         YKvSjo6cy2EUeE5zbOmSB9/OfNnw8+mkIQ/C7gLj+OQw8eK/UY6c9DH7M1WLUopEffRe
         q30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794404981; x=1795009781;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QrqbGrUeaMzxTtNKFPqZn9l9SynA7oL6rbPLiV4WlNk=;
        b=2FVmalxpXl2aKJjEFyaTTchrwACw8fNH1hV7tKmFkObzOm4G/IyQ950lreIlIKlx97
         3RMU9FJY4AAIwu83QTnNJSwJIC0g/QDEME2RJz63n6/F9dR9b8YSpLypVJ8vMvcFwBoG
         CX9A0mrmTuV3vMaHMZQJmOHLJW7kgLyshv4vc6qOnnWdewpgD98ZHd3yvS4zf0Sbkpta
         JzNur8oDDM/oyHZBpGj+RDE4SuT9DQNr3APVGNhRW7AFtOZROkXZY4L+JuVlbIhYWfuR
         U9p7beDFmchvg4+ERs5Nd3TxagUj9vcp96BwJobSjutZG3gYRbS81Ekb4B1ey8J1foAF
         XVag==
X-Forwarded-Encrypted: i=1; AL+hErH+TPofvAz0Yi3XvIBZRwX5Lql5ZIDW2rhyaz8Pyk2TfxAVzvRIh7kyR29wFM9Kwr1rxu/R9Qo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eHaaT1ecf3vPn0xsxsE0ObdzvwSHfARe1a1p3fA1leGuPg7c+
	vvT2mETCyYaBajkZ3jBbKgGkashsCRJI80ui68AMn+5OvgNQBj/zIeuuvzVQhG70L6pucAx2Y/w
	VNRWhiOfu6vzq/APWRwj8IJCbHOiSgT1k9z3UQF9am0Q8HsT44GK/sK+Qow==
X-Gm-Gg: AYBFou3jVRRe58tnXt7Wnn3TbOqg0ikp9NgS+GAyQSOmAYpL7YnUfq6FwG8tdbgIYGK
	eB+cc/+B3COsnwDdYNoOhZswfnS7LrzksRXskHWGGkoYNsQdELUgM/ujOlvqxmY06DxUTz2D5Ht
	ukCclkIHES1pWX1eoI5NzrULgN0ztNKDx3FQH7DkGvxcaTrZVVSTSRnAWVkT4Cppb0WtKi0hWDL
	3BqQFFZJj41W/7degaNXXtldauEmEJuDfBEsXxGUAa+pFsItrW6y+PwVPoO63nQXFhQCRoY0J8f
	ClQtK2rM1QlbDRYtIsiBEpQ9UyUH9v++jQXu+ho68EWX1KwqM9R0fKU9s5wm2s2qaG9efaZMA1Z
	EvHV5XSQhjnej5jIyP8dJKG1wljnqx0XUBC0ORerP6uvz2f1H6JUruc45bQAnHir4LLEd4CzP6y
	jpPyE=
X-Received: by 2002:a05:600c:6308:b0:4a7:b304:253e with SMTP id 5b1f17b1804b1-4ba09381867mr49914065e9.22.1794404981065;
        Wed, 11 Nov 2026 05:49:41 -0800 (PST)
X-Received: by 2002:a05:600c:6308:b0:4a7:b304:253e with SMTP id 5b1f17b1804b1-4ba09381867mr49913635e9.22.1794404980722;
        Wed, 11 Nov 2026 05:49:40 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fe2f09sm159753605e9.4.2026.11.11.05.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:49:40 -0800 (PST)
Date: Wed, 11 Nov 2026 14:49:37 +0100
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
Subject: Re: [PATCH v5 14/29] sched/deadline: Fix this_bw when a task is
 changed during a remote wakeup
Message-ID: <avRycWTxtUr9gug6@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-15-mathieu.desnoyers@efficios.com>
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
In-Reply-To: <20261108185406.1549770-15-mathieu.desnoyers@efficios.com>

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> The this_bw of a runqueue is the bandwidth of the deadline tasks
> assigned to it, running or not. GRUB uses it to compute the inactive
> utilization of the runqueue. When a task wakes up on another CPU,
> migrate_task_rq_dl() takes its bandwidth off the old runqueue. The
> enqueue adds it to the new one.
> 
> Between these two steps, no runqueue counts the bandwidth.
> try_to_wake_up() can leave the enqueue to the wake list of the new CPU,
> and return before it runs. task_cpu() already points at the new CPU. A
> change of the task in that window gets this_bw wrong.
> 
> In this example, T is a deadline task that blocks on CPU 0. A timer
> wakes it up there, and try_to_wake_up() picks CPU 1. S, on CPU 2,
> changes the bandwidth of T from "old bw" to "new bw":
> 
>   CPU 0                               CPU 1                       CPU 2
>   T blocks
>   this_bw of CPU 0 counts T
>   <timer> try_to_wake_up(T)
>     set_task_cpu(T, 1)
>       migrate_task_rq_dl()
>         sub_rq_bw(): CPU 0 drops T
>     T on the wake list of CPU 1
>     return
>                                                                   S: sched_setattr(T)
>                                                                     task_rq_lock(T): CPU 1
>                                                                     T is not queued
>                                                                     dl_change_utilization()
>                                                                       this_bw of CPU 1:
>                                                                       - old bw + new bw
>                                       sched_ttwu_pending()
>                                         enqueue_task_dl(T)
>                                           task_contending()
>                                             add_rq_bw():
>                                             this_bw of CPU 1:
>                                             + new bw
> 
> CPU 1 then counts the new bandwidth twice, less the old one. Repeated,
> this makes this_bw drift until it underflows. If T left the class in
> that window, switched_from_dl() would take its bandwidth off CPU 1 the
> same way. A task that enters the class in that window would be counted
> twice, by switched_to_dl() and by the enqueue.
> 
> This needs a wakeup that moves the task, so a root domain of more than
> one CPU, with busy CPUs. CONFIG_SCHED_PROXY_EXEC=y makes such wakeups
> more common. In testing, a task sleeps and wakes in a busy two-CPU
> partition root, and another CPU changes its runtime. The kernel warns
> within a second in each of 8 VMs:
> 
>   WARNING: kernel/sched/deadline.c:352 at dl_rq_change_utilization+0x71/0x2e0, CPU#0: wake_race/109
>    __sub_rq_bw(): this_bw underflow
>   WARNING: kernel/sched/deadline.c:316 at task_contending+0x244/0x260, CPU#6: swapper/6/0
>    __add_running_bw(): running_bw overflow
> 
> Fix this with a new bit, dl_bw_oncpu, that tells whether a runqueue
> counts the bandwidth of the task. add_rq_bw() adds the bandwidth only if
> no runqueue counts it. sub_rq_bw() takes it off only if one does.
> dl_change_utilization() does nothing while no runqueue counts the
> bandwidth. The enqueue adds the new one.
> 
> With this patch, none of the 8 VMs warns. deadline_bw_test, added later
> in this series, tests this in params_waking and random_mix. The Sashiko
> AI review of the first posting found the double count, and a bit that
> the first version of this patch left set.
> 
> Fixes: 8fd27231c330 ("sched/deadline: Track the "total rq utilization" too")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

