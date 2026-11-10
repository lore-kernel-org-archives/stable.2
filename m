Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316743;
	b=0rOKqA9ZLmbdJ7a9+EBlJhO05eEY4/OIS0te/unHcnvJ4FEi9fgj8EA3v2jXZsF6Tr8e
	 vV+S8+RPiXoOOnd/udMrkKNHbNP6BhAAmLeJHmpKqa/XPwrUIq7F1Zy9lEurVVJg60/pE
	 CMva/XSdUKxQ5QDoBQoJPTd8onEcKAM9DawjpuYzdn/ppmKA0I+P2XqDHQvg2hRMu1q7G
	 7u7/ROxnSFG39zDVobh+KuxnmCBS63HXCUREAedniqZJCMuFtYR8+vZ3o3puw3MXhDAFM
	 M8MjcmOi87XD6G8N/tfk0Vi+mRG9tlrrQHdW1ExY6V9JGHz3OwqX8GEbRriEMI1FD7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316743;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uCK3DWsW5brHcg2UrNGkrWpwotXCDgVLqXuyjt+/CDE=;
	b=u4glAT4VKufBB5vUZNVvxtz3jkpUkLkvBgZCh9ggkyGDvDk/ZdoW2QWPXDVs49foK6nY
	 eN044/p4SRStdWCFsWpGLkI8Sg0tOoV/YALj+z246XDrRJ3FJ7Di5Y9kr9OSNkYeLAoPA
	 N69NPeoOUIWR6egG+miQxCvbjDpKvSXrN6HoyI8wDQQyHJl/9quTO//xqoQCHLQkAztGg
	 eddi6yLgLqBVmK8uAZVgOa2y7twIf50z2VDQ2mvcLIOtACBWKzdb8tsC3rUjpX1A3TnvZ
	 wbQTt+si3YJZ0eImonjB0uYXcOhVIPV/8PEo/9HamwIF0gsgE4z28XQqVcDWrtIQjhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=irgaFATm;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NJBumCqO;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8205E6073B27
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8205E6073B27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=irgaFATm;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NJBumCqO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794316741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCK3DWsW5brHcg2UrNGkrWpwotXCDgVLqXuyjt+/CDE=;
	b=irgaFATmW7i1hwv7tnQawh/3pf72iYXWNzzBFUG4GwABRgi4cWvnnVUWHqGxmVB1+Zxf/C
	JFmvivtNpbaYBp31o00Ocumigrzrv9NFgLBiA7rR5cRpPQsRwEULeoylbAW3T0lXCWmdhN
	7fkptwwoTKXEVJE267g4+/IZufv7a68=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-eI9YupnfOciQk0YZx16lpg-1; Tue, 10 Nov 2026 08:18:59 -0500
X-MC-Unique: eI9YupnfOciQk0YZx16lpg-1
X-Mimecast-MFC-AGG-ID: eI9YupnfOciQk0YZx16lpg_1794316739
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a318cd95e8so17944945e9.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794316738; x=1794921538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uCK3DWsW5brHcg2UrNGkrWpwotXCDgVLqXuyjt+/CDE=;
        b=NJBumCqObc+eY0/qBEhU38pm05rcyolsQTZaUxXYVbxPwYBwCJwgF439lA4PENvlqD
         pjbGMLTs7j7UAK/YKXJpwEVRutWKUeoT41AmWGs/Vyyrr4Nrluqjp/ABJoym1rR0KvAx
         C3FilF0Um11cWyOieP6xJ9SY9Ug1aIar8o+GABHy8F+edd6bL1FD8JXwhDpRmGEyj4/a
         X+/WaYCoX6G6Xbz/AuZj7bFeeX83EMfzxsRuY+fFPaJFTmlzEiWr8rqHKD/g63FOSSlm
         lxQQhnEfA9k1dKR8I6Ye9ii0obYsM/PC12Mh7oS7KagG8H21tbvnBMNt2PbFaDNcqt2t
         zs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316738; x=1794921538;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uCK3DWsW5brHcg2UrNGkrWpwotXCDgVLqXuyjt+/CDE=;
        b=LKK2ntXNSZ1Iv93i0utb/ci7R1vVcGnNoca0FDh0FdszSMvS+ZfYM2yXsehGAn15ea
         q0hQfmq3tRpilirXigm96GwIREPLGJUFG8sU/gJUW4YxmSBq7fflr+QS5UTX0x8ZoEPS
         0FWBQZ5hHngER/j638iHPOv3PUX2+hSgwAPNZlSz9FbOqq1vEfvZHs/yt8YCyG2ylSda
         ECgy6svbb+2gIJGeo3jpvlLka81FWj0QuBd2yG8YlGbC4zlAuC5l9PlQyJooxHJcvu8c
         x/JekVMdEoNWnKGGEi+VDI2QDayeRpchauOHljz90qe4tK0H/A2XvHuhqUB3kNJ/14p/
         fkKg==
X-Forwarded-Encrypted: i=1; AL+hErFero5goGCP7ceq5gsgR7D+it77wqYLrEeSxQpopUfRP1SFzu90rkgTvWBscOquDy6EytGtelQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qELjt6oL83SjzNbhu31z4qVsz9Pxn1haZv1GyZbvSFT+SdAM8
	xsL977ha8WjCjFdLDrbIQ8RNSwrXVG+BaSaeSNSBNxPZsP9H7Ovez8IIkx0mge7CSEV2z/M4ai6
	46UHkloaJygj//HBC6dIDTgs71HQZc2DBvOOuMdEPakinovUD3wPEhfMU9Q==
X-Gm-Gg: AYBFou0wg0Epa4mNYxWdNZDzfsAMnImEVSYCtKQuUwzB6WRXs4YiQgvTG4rVM1qnHKk
	QXZzrFIO9Rm9ziW+Z0puS1c8+Ff66Bs9PwOHwzbOJxkPQ9yGRCC1wGY6nawWHo0CqyqezlbnhxD
	xht80MWqtY3f+alKMEfdxjmet1JgBnwKrZySOWV+t68JR6JgbIsLVU+g/4lb96suDQp090VM8LQ
	PqrcWeezQkc3M0ewwt3n2e+CZegvuvYpYvqu6/HSxk5Q5kp/Vx7txQMTqh3uAxE9WdWy9ZxGWfD
	oCNznMvywYLu2pjyI8u92dz+5x5FOluRjj/f6duCHdF2v4l60VI+164/7dpuSBZaR5uwaA+w7i2
	pbnC3j3n6TiahZ1Q8CCRGoa3yaPE5E9yKnIivRPAz/U7Z4wYoo8g8xdc0ZYcLPiPD2g7xQw1Jc7
	VCfDI=
X-Received: by 2002:a05:600c:870e:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4ba0234267amr43353495e9.8.1794316738369;
        Tue, 10 Nov 2026 05:18:58 -0800 (PST)
X-Received: by 2002:a05:600c:870e:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4ba0234267amr43352395e9.8.1794316737684;
        Tue, 10 Nov 2026 05:18:57 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0236f03esm49827465e9.3.2026.11.10.05.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:18:57 -0800 (PST)
Date: Tue, 10 Nov 2026 14:18:54 +0100
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
Subject: Re: [PATCH v5 09/29] sched/deadline: Reset the deadline and the
 runtime with the parameters
Message-ID: <avMZvuEdV8ua36jy@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-10-mathieu.desnoyers@efficios.com>
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
In-Reply-To: <20261108185406.1549770-10-mathieu.desnoyers@efficios.com>

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> A task that leaves SCHED_DEADLINE keeps its parameters until its 0-lag
> time, so that leaving and coming back gains nothing. Commit 209a0cbda7a0
> ("sched/deadline: Improve the tracking of active utilization") moved
> their reset to that time. Before it, the replenishment timer did the
> reset at the deadline. So a task back after the reset found its
> deadline passed, and started a new period. But __dl_clear_params()
> resets neither the deadline nor the runtime.
> 
> Now a task back after its 0-lag time can be enqueued on its old
> deadline and runtime. With runtime left, its 0-lag time comes before
> its deadline. Back before that deadline, it would first spend the runtime
> of the reservation it gave back. Back after it, a constrained task
> would be throttled until its old period ends. "sched/deadline: Do not
> lose a throttled task switched out and back" moves the deadline of a
> throttled task on. This widens the window before the deadline to about
> a period.
> 
> A task with no parameters of its own, boosted by a deadline waiter,
> keeps the donor's deadline and runtime after its deboost. If it then
> enters SCHED_DEADLINE before that deadline, it runs on the donor's
> runtime. On v7.4-rc1, a task of 10ms per 100ms ran 40ms of its first
> period.
> 
> Fix this by resetting the deadline and the runtime in
> __dl_clear_params(), and in switched_from_dl() at the deboost of a task
> with no parameters. The next enqueue then starts a new period.
> 
> The Sashiko AI review found the first case in the second posting of
> this series, and the deboost in the third. The deboost_resets_period
> case of deadline_bw_test, added later in this series, tests the
> deboost.
> 
> Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

Nit below, other than that

Acked-by: Juri Lelli <juri.lelli@redhat.com>

>  kernel/sched/deadline.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index cf24d2df6bfc..cc43c5eeae51 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3573,6 +3573,16 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
>  	if (task_on_rq_queued(p) && p->dl.dl_runtime)
>  		task_non_contending(&p->dl, false);
>  
> +	/*
> +	 * A task with no parameters of its own was boosted into the class.
> +	 * Its deadline and runtime are the donor's. Reset them, so that its
> +	 * next entry into the class starts a new period.
> +	 */
> +	if (!p->dl.dl_runtime) {
> +		p->dl.deadline = 0;
> +		p->dl.runtime = 0;
> +	}
> +
>  	/*
>  	 * In case a task is setscheduled out from SCHED_DEADLINE we need to
>  	 * keep track of that on its cpuset (for correct bandwidth tracking).
> @@ -3999,6 +4009,9 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se)

Think we want to update the comment that comes with this function (as it
now clears also dynamic parameters).

>  	dl_se->dl_bw			= 0;
>  	dl_se->dl_density		= 0;
>  
> +	dl_se->deadline			= 0;
> +	dl_se->runtime			= 0;
> +

Thanks,
Juri

