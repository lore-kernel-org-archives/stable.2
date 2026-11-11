Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412458;
	b=ugbRtTjnVkGo/NxEGb8mEJZyUMA3Qynff3jy+PedM8oBxfHEQKbYk+G0DpEXvXAX9wng
	 A+wpH7Y81j/gkytCc+ozaQmPbcHbPDbk6DO4GoB5uqQHC/OlmGKP1MYMFLrQhbO//qR4U
	 MsAkASu99DUwSpbMI6x3fVwaZMQ3ZjOle6LY1edvy4O0+J4C2fGzeEBBIrQgssvk1Rh1S
	 nvUKhslnk3uHk68t/HM0TY8HCKhK6EJTgrFaDv29lxZuYYzZ2hg4PPPTIglWNh/pjRNXK
	 tKXq7OUU9DZFiKs8QH3cKYGCGLLHNZEMsIavBaAjx3Qwx81BfcmYRaX876x9KZRURMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412458;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9yO4iRBEsOuH32jlGyQ/kcDjMlOuvsYBA1s1+h7mpqw=;
	b=jYgZ3hVcQ3oUZeCb9n/SyIY8e7Qxu2S65GxSgJDXAGM+AEYvOa9sd6yhJ5Q7p1DFHO0E
	 zthXqZbfDDaWNG+ZFDd2dwnZLUNjXxRLP7VcJiiKME5CgbZzKBNxT0VGwvinKGa7yPHtb
	 vizvJ4PWYwBeOaqN/bNDdihstdO0akzuqMGvysdFusCP2HSVWLK+lroP9ECodmV1+3Xlk
	 QckX07zCQbffFpN0r8L/JE7lQU7QZKXZustMPbeNsT817s/rUBc44VCSc+Bke7ieTKwun
	 x4vggQiLzWS+r4HTCZo892qG7sM4yCzKf3POT1uhxGWVacIf4Igi0vufx0O8132G1cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gUSu2kHQ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hiKOE+VI;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB3E606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CB3E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gUSu2kHQ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hiKOE+VI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794412456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9yO4iRBEsOuH32jlGyQ/kcDjMlOuvsYBA1s1+h7mpqw=;
	b=gUSu2kHQoBGwsfid6Qv8XjXkF2WEbCOG0OeZLNt30hbw2tOnZnBD3sT4eI4Gdo0G+sHIO8
	CllLsSaWcxGrlqQHZtVKgzLaayHeVHqTwW04uYWUQaCoF9Nugmp1w0o3vP5fsLy/loc5gB
	7fKQBKhEEn3XRLRM5bpZixFaC71VpFk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-xdoUcxa7NIKQl8GE_n4gTw-1; Wed, 11 Nov 2026 10:54:14 -0500
X-MC-Unique: xdoUcxa7NIKQl8GE_n4gTw-1
X-Mimecast-MFC-AGG-ID: xdoUcxa7NIKQl8GE_n4gTw_1794412453
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4916d47eeb5so2690965f8f.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794412453; x=1795017253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9yO4iRBEsOuH32jlGyQ/kcDjMlOuvsYBA1s1+h7mpqw=;
        b=hiKOE+VIlxbOcOlW6Xs+bhV4MDSUdNJj6lNYBdYkNH69xwc9iSfRZYyqR7pcSGVcej
         EEcP0okGXd9WXoggo1LTQD1ur2KEqBKSF6BKBBIIczRS41MfIiOYfb/Q3TECGm1AC33g
         acxaxTc+t8FERzKUTxnKL6LcDwV94/ki7XqzzoXMgcwLLPY2tgkCgAaizVvmDNVC14JR
         YovK5EmSA7o+FM4ykQ2tpnVnOXA1/Niyfr/4eNpGPM9bTaJtf7lz2NhewOXTg0z6hpAu
         Bss9OudKo9sHusaHPSJKqdyUQkQrVi9n1Q/4nbn7rWfMu1fbBKm77f3Fj+JGWxFjQH29
         xS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794412453; x=1795017253;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9yO4iRBEsOuH32jlGyQ/kcDjMlOuvsYBA1s1+h7mpqw=;
        b=zFaJDCDy43fdWIRbmBIjohiICjTRM7b0SE+f5qknOsPzrXSTOnfPfJT38z79dcaFGb
         WaqvbdCvp+pN0/8Wb9eCjmiGLZLCaYQTxQqYQo/iwgAw1CdPyhuSOkpjswW6/zVspcwv
         Kc/whzVxT26fQLhdQzLvINXtKTH6Fx2lZFxA5zHRNMauq/rwIJpEMp6WuN0+SVXCUAok
         DqW0YTCjF3fQX48OLMpcDLSp2gcsw6uWl7U3+yEy9WBaUKvC4ERkCci3PRz6kg0EvlLb
         NJy/lGfE2IHfTdTvn3y1Y6T0fTRHINnrupONxmBSN8cvDUy+cHZeztkqYVSecUUAq4/L
         M5TQ==
X-Forwarded-Encrypted: i=1; AL+hErHCqNbzMxsIfyMvA1toEo5NTWNanviNFHW9GbToVGTyXZUl2GgcmwXmsIxpZttElQ60A4CodZY=@vger.kernel.org
X-Gm-Message-State: APuU4Z95BbMY7jPlw0JSgBBs7FnZb4jZ97sWFC0LQfLAVIaXjvA93VYo
	JAQweIsl289yFFxZfoY62OtivxmEyxkkVEFgtD1WcluHDTRAfLfm4qQgKrdcU6fXU8iTdThit9n
	i4N4z+XeD6sLUi24AuKdMe2RihDqli9WV0GeIyfXM4YGDB3ibna9SH6K+TA==
X-Gm-Gg: AYBFou0gauL4rXaCTcAVUg4NtrvMSBwlJShCwacDrBTepw3p72BRxliPH6YUnkiU1wY
	YkkLXLc4wusiEpYszZJoHH8Tb/JwgPLXZsYW1dJz1bJfebWQZXTVXXl91cBW2VQ+fHz0GFIKhsl
	FOQEKwTADsT1x9WUQFt39DYbnP0Gr81em4IGP/IiA5mb2DsAZTcL6JRZQJ5lL0z81ldRdXShZj4
	2cfEJ69zd5rpKFLQ/VWAbidBGHvqVTr5xofyDEpedpSmyqYl/Dh9fZxuP5Lv97xUfwL7qbfPv06
	jeVgqalFW+fm/msm/+/ZUEdjHt9/qPNs4qNSPxAlJTnnqk2xwlV9LNgOoX02i3ukkOnColvBW82
	pdtutnRPOIUtz1Bw13KPcg5nA+NaFMV+t80Q2frc2RUXkGV1J/9tUlVulGq4QKoTLlGjVDUlnb9
	z3C68=
X-Received: by 2002:a05:6000:3ce:b0:48e:2f7e:bdbb with SMTP id ffacd0b85a97d-499c77423e2mr4360023f8f.50.1794412453237;
        Wed, 11 Nov 2026 07:54:13 -0800 (PST)
X-Received: by 2002:a05:6000:3ce:b0:48e:2f7e:bdbb with SMTP id ffacd0b85a97d-499c77423e2mr4359995f8f.50.1794412452846;
        Wed, 11 Nov 2026 07:54:12 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49836b8eb11sm12632851f8f.57.2026.11.11.07.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:54:11 -0800 (PST)
Date: Wed, 11 Nov 2026 16:54:09 +0100
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
Message-ID: <avSPoSnNATnwZ8cS@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-17-mathieu.desnoyers@efficios.com>
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
In-Reply-To: <20261108185406.1549770-17-mathieu.desnoyers@efficios.com>

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> Admission, moves and releases of a deadline task's bandwidth find the
> root domain that counts it from the CPU the task is on. That CPU can be
> in another root domain. Two cases show it.
> 
> Commit 7f51412a415d ("sched/deadline: Fix bandwidth check/update when
> migrating tasks between exclusive cpusets") moves a deadline task's
> bandwidth in two halves. cpuset_can_attach() reserves it in the
> destination. set_cpus_allowed_dl() frees it in the root domain of the
> task's runqueue. Both halves now move nothing when that root domain
> overlaps the destination. But a sleeping task stays on the CPU it last
> ran on. So a sleeping task moved to a partition and back leaves its
> bandwidth in the partition:
> 
>   admin                                       task T
> 
>   makes P a partition root of CPU 3
>     CPU 3 is now in root domain B
>     CPUs 0-2 are in root domain A
>                                               sched_setattr(SCHED_DEADLINE)
>                                                 A: total_bw += bw of T
>                                               runs on CPU 0, then sleeps
>   echo T > P/cgroup.procs
>     cpuset_can_attach()
>       dl_task_needs_bw_move(): true,
>       A does not overlap P
>       B: total_bw += bw of T
>     set_cpus_allowed_dl()
>       dl_task_needs_bw_move(): true
>       A: total_bw -= bw of T
>                                               still asleep on CPU 0
>   echo T > cgroup.procs of the root cgroup
>     cpuset_can_attach()
>       dl_task_needs_bw_move(): false,
>       A overlaps the root cpuset
>     set_cpus_allowed_dl()
>       dl_task_needs_bw_move(): false
>   kill -9 T
>                                               wakes up on a CPU of A
>                                               exits
>                                                 A: total_bw -= bw of T
> 
> B keeps the bandwidth of T. A does not count T while T is in A, so A
> admits beyond its capacity. When T exits, A loses the bandwidth of T a
> second time. Its total_bw can underflow.
> 
> A rebuild of the accounting counts a task in the root domain of its
> cpuset. With admission control off, a task can be pinned to one CPU.
> When that CPU goes offline, it joins the default root domain, and the
> release takes the bandwidth from there. The root domain of the cpuset
> keeps it until the next rebuild.
> 
> The first case was reproduced on v7.4-rc1. The second was reproduced
> with the earlier patches of this series. Without "sched/deadline:
> Release the bandwidth of a task that leaves the class asleep", nothing
> releases the bandwidth of that sleeping task.
> 
> Fix this by recording, in dl_bw_cpu, a CPU of the root domain that
> counts the bandwidth. Each site that counts it sets the record. Each
> release or move reads it, and the release clears it. A move skips a
> bandwidth of 0, so sched_dl_overflow() does not use its record. The
> move_zero_bw case of deadline_bw_test, added later in this series, tests
> this. The record replaces dl_departed_cpu. If dl_bw_gen shows that a
> rebuild dropped the bandwidth, nothing is taken back.
> 
> A move now leaves out a sugov kthread and a task boosted into the class
> with no bandwidth of its own. The rebuild leaves them out too: no root
> domain counts theirs. A move would take a sugov kthread's bandwidth
> from a root domain that never held it.
> 
> Weiheng Qiu reported the moved sleeper, and Juri Lelli analysed it. His
> fix, linked below, took the first active CPU of the task's mask. A mask
> can have none during CPU hotplug. Tip dropped the fix after a sugov
> kthread hit its BUG_ON() there. The Sashiko AI reviews of this series
> found the other cases.
> 
> Reported-by: Weiheng Qiu <weihengqiuu@gmail.com>
> Closes: https://lore.kernel.org/all/14508cb2-805f-41ac-9f6b-bfd7c3d7cb1c@gmail.com/
> Link: https://lore.kernel.org/all/20261103-b4-sched-dl-bw-fixes-v1-1-dd761fe005b4@redhat.com/
> Fixes: 7f51412a415d ("sched/deadline: Fix bandwidth check/update when migrating tasks between exclusive cpusets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

...

> @@ -3541,17 +3570,29 @@ static void set_cpus_allowed_dl(struct task_struct *p,
>  	 * domain (see cpuset_can_attach()).
>  	 */
>  	if (dl_task_needs_bw_move(p, ctx->new_mask)) {
> -		struct dl_bw *src_dl_b;
> +		unsigned int src_cpu = dl_task_root_domain_cpu(p);
> +		struct dl_bw *src_dl_b = &cpu_rq(src_cpu)->rd->dl_bw;
> +		unsigned int cpu;
>  
> -		src_dl_b = dl_bw_of(cpu_of(rq));
>  		/*
>  		 * We now free resources of the root_domain we are migrating
>  		 * off. In the worst case, sched_setattr() may temporary fail
> -		 * until we complete the update.
> +		 * until we complete the update. A rebuild that dropped the
> +		 * bandwidth of @p leaves nothing to free.
> +		 */
> +		if (p->dl.dl_bw_gen == dl_bw_gen) {

So, this is not guarded by dl_departed_lock, but then this gets fixed in
later patches?

> +			raw_spin_lock(&src_dl_b->lock);
> +			__dl_sub(src_dl_b, p->dl.dl_bw, dl_bw_cpus(src_cpu));
> +			raw_spin_unlock(&src_dl_b->lock);
> +		}

...

> @@ -4189,6 +4245,23 @@ int sched_dl_overflow(struct task_struct *p, int policy,
>  	if (new_bw == p->dl.dl_bw && task_has_dl_policy(p))
>  		return 0;
>  
> +	/*
> +	 * Change the bandwidth of a deadline task where it is counted: in
> +	 * the root domain of the CPU recorded with it. A task moved asleep
> +	 * has not run there yet, so the CPU it is on can be elsewhere. No
> +	 * bandwidth is counted if a rebuild dropped it, or if the task
> +	 * enters the class. A runtime below about a millionth of the period
> +	 * gives a bandwidth of 0. It counts for nothing, and no move updates
                    ^^^
Ah right, quite cryptic corner case buried in this comment. :)

This is the 1024ns/2s of the test. Which indeed gets dl_bw 0. Don't
think it's a huge deal from a theory/practice pov as to actually make an
impact we probably need quite a lot of these admitted (fork bomb style).
But it's still weird :P. Not sure if we want to impose a min of 1 dl_bw
for these. If it actually complicates the accounting (for no good
returns) or not.

> +	 * its record. In these three cases, the root domain of the CPU the
> +	 * task is on takes the new bandwidth. The caller holds cpuset_mutex,
> +	 * or dl_accounting_mutex without cpusets, so no rebuild runs
> +	 * meanwhile.
> +	 */
> +	counted = task_has_dl_policy(p) && p->dl.dl_bw_cpu >= 0 &&
> +		  p->dl.dl_bw_gen == dl_bw_gen;
> +	cpu = counted && p->dl.dl_bw ? p->dl.dl_bw_cpu : task_cpu(p);
> +	dl_b = dl_bw_of(cpu);
> +

Thanks,
Juri

