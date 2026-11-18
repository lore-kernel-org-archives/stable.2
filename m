Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795000850;
	b=gfZl75qO8G7TY3Pt+nJUyEzWrwLnznB8D5DBaOjgvxuqUxp6uLAvcOjg/KcO4P2xSzXF
	 dklwFqErg2Kp0ujOJu7eagiT7EBgQZCmURWYS5aB8UD3xJNEQyAqDYN7uy45NbNOqoe6G
	 POT+oW3O5EICpKap/Ie7BEoH+DFfcb/VbfBUpQM/Gjgpf+5QTs/2BClHIvcKCyXehDjuP
	 E7F6vMF8wEitwh371lr0TPgDaoKAJNjknJhrJt+/6DGzX5hqYAboH+Tyr3eoJDUSRNPJV
	 6mq+0y2iSjn0t+KaIX8ctHuBF6sntye5B+m3pgfo2F54bJn8vnOeffbfo+jtMSgM6Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000850;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UYZeLko8ARh+TMZJ/jcaVMaBZpqH4WAJB7a5zPUzakg=;
	b=i8chrzBNO6hKw+/O1nKWAjVHR+nCUUt/5UF0eKUSs/70d25VldxC+msh9hR1dA/6lZXa
	 viRs8PCuvkiq5jaNjqImQL0pG7nktAZUKy7IRLDlb5PJxTRF60izfNKZSha7Ulr0TKECk
	 yvkcn3yjGVVLcE//SETriF2v8hsdqIsLLBjZSDYPAJeKd6AzfshishRH09b33xxe1rrWk
	 JQI++t0nZtaqDhtrLeNSDS5UrhXjddAjffl9V27IhHrSIZIcW0CJEJLTyRJYGABzgAqhX
	 nNPFA79F6P3hZWfHVxYIEiWOYzuWgu6Hre0Vx4FmNN4ZWTc63rPwlZw7kjkEucrw+SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iORFFgFd;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GpL06LLH;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C60606A32C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51C60606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iORFFgFd;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GpL06LLH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795000848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYZeLko8ARh+TMZJ/jcaVMaBZpqH4WAJB7a5zPUzakg=;
	b=iORFFgFd322gO9ZgYGy1IvDR74Gf36yEqNGJxd4+VfnSq0mZFQdnH9+yCpx8U86A6I9LPH
	JpHIUxeOoDT7gA1XSbyb7LQOPjXqz0u8A7H94AuXpi5sYcdLE1YWMFt8IGbXONS1johxXg
	eE2ofvemC7h+RRHZ5H5HchRrYgU04No=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-LacacNv-NVCI4OuEegI3tg-1; Wed, 18 Nov 2026 06:20:47 -0500
X-MC-Unique: LacacNv-NVCI4OuEegI3tg-1
X-Mimecast-MFC-AGG-ID: LacacNv-NVCI4OuEegI3tg_1795000846
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4bb680f0ac4so5384715e9.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 03:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795000846; x=1795605646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UYZeLko8ARh+TMZJ/jcaVMaBZpqH4WAJB7a5zPUzakg=;
        b=GpL06LLH6he6KY83Kswtjf5NHWlqseEgBMeWpf2WQ9het2uamRVdPeeUrDLQVbR8Ox
         Ihmv8Dm7c5v5zBi5IjZccJR6pEt6C5XIvcsNl13QVzxOELXQqg4jacsBtZYJBI82gSnF
         umpvBG6Js4CqPHi0EOoMyzjVGBEfZ6XkWovAbifhSzhGHTl+17Wv8+v/tHqY/zsZJ2kx
         VZsk2YPsYg+VEb1uqA+vP6I1CbgFYe+ZLa4GUU/o/FO+WGBBllgGRvxjlbmuq2UnWK6f
         klwuHSjRZY9jP/SIH2Q7ejD96q1Kv/pVsiZoDEhIrEVyaPJKv5jXtojriGafP4FU/TSI
         BMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795000846; x=1795605646;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UYZeLko8ARh+TMZJ/jcaVMaBZpqH4WAJB7a5zPUzakg=;
        b=esBOzLh9QcA8P9Rgjj9eQ3eZRhdI65DUESse++QH5/g9x0wrouxG0WZoS44E9RxEmA
         Durpx0joZRHabHHFC/26QbSI+oDThMN+5TX+eXwO5786sqh/PMQ+sBgIeE1Q/67AFvEm
         C4qh7NJRSrFxgOqvvTv266YXml+MJsNrrx3C4ZShaCmribjATVKZDufkhv+IRhimAcs4
         Q89KXGSwYfQaTiSTI5yCLbb5M1qw2tQt6z75/XDt4DQmOYXDBDeD72skAaD8Q1PcEDuW
         i7Me6jNA+e/3qRUYxvQm7QwiSyfVxTmw/jZ/g8/LiJkBplecf1AxOcDV5BNU06UQtRDG
         XfgQ==
X-Forwarded-Encrypted: i=1; AL+hErEEIpoCphpDNGLNum5L/1Yo79s8LgP+TSyZCFyQmqtvGdcEOIHVD26g4xGLRMUgKiSsTqWjreY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WDPhuQids0pKfcb+5+c2AI0VYHgxvRT3cQUznhSkls1hn/PEp
	mgWwBtmBgGfBBriB94dCsa/A+LLIC65dGFvCg3TjHU17G6O2DdCZ6xhE7jW5qqvRoWUCsvSCw+1
	WbwUlozUL+Exiw3pkeXsB/m+6MByo5Ubs45dxwkV3VpFZ2fFbyHKMqaDSJw==
X-Gm-Gg: AYBFou0Xmr2AsBftITr6LE4pID/JY1wstO/UQXYl+3+18kYrQ0rr3Jf9Abv+nFN/E8l
	C2rKRmqu6ZZZiWCVi7c28aLrFYOtNggwhwHXyJbqWHamL42m2Hwh/Z6X4r6FuYhV+FV8HnivkYW
	KFx1s83/P2viYee9sDrHLZhQ6aUIy24Q2fVEw0oV8aOLYeLwzwxaUNbfbifk2Ba6B2QKh0/f637
	owZjh8DaBMqxpAbnVAiWEPmwS/9itRAAYlXAWAWhsxslX85w+pWP8xdURGJCtnzKgyfFPkbqxCX
	Zd15t67I14YiYW3njwGIHXpYkQIsyi/bv7NvAta5M7PdoUZjC7cUiM6z+l+gwWjTH0grvfGgXOj
	quR2q8/IEjcDGrc2d/Q3benjXfSDPFuo9+I7cA3+mO4TTNNBB00Irxtk9Lgl6h0L2URVCc7tDVH
	kdMgg=
X-Received: by 2002:a05:600c:8b02:b0:4bb:6752:8400 with SMTP id 5b1f17b1804b1-4bb7da1b48dmr39551865e9.17.1795000845950;
        Wed, 18 Nov 2026 03:20:45 -0800 (PST)
X-Received: by 2002:a05:600c:8b02:b0:4bb:6752:8400 with SMTP id 5b1f17b1804b1-4bb7da1b48dmr39551335e9.17.1795000845561;
        Wed, 18 Nov 2026 03:20:45 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78418853sm195748985e9.8.2026.11.18.03.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:20:44 -0800 (PST)
Date: Wed, 18 Nov 2026 12:20:41 +0100
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
Subject: Re: [PATCH v7 04/40] sched/deadline: Do not divide by zero active
 CPUs of a root domain
Message-ID: <av2KCeKAnXAi6saN@jlelli-thinkpadt14gen4.remote.csb>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <31f723a7dab4d58045cc60fac0fea09ea1841c7b.1794922146.git.mathieu.desnoyers@efficios.com>
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
In-Reply-To: <31f723a7dab4d58045cc60fac0fea09ea1841c7b.1794922146.git.mathieu.desnoyers@efficios.com>

Hello,

On 17/11/26 09:10, Mathieu Desnoyers wrote:
> __dl_sub() and __dl_add() divide by their cpus argument. Most callers
> pass dl_bw_cpus(), the number of active CPUs of a root domain. That
> number can be 0, and the division then traps.
> 
> Commit daec57983670 ("sched/deadline: Reclaim bandwidth not used by dl
> tasks") added extra_bw, the bandwidth that deadline tasks can reclaim
> on a runqueue. A change of a root domain's total_bw is spread over the
> extra_bw of its active CPUs.
> 
> During hotplug, a CPU sits in the default root domain, which can then
> have no active CPU. This lasts from the rebuild in
> sched_cpu_deactivate() to the offline, and from the online to
> sched_cpu_activate(). A debugfs write to the runtime or period of its
> fair or ext server divides there. A write of the current value passes
> admission in the window. In 8-CPU VMs of v7.4-rc2, a loop of such writes
> oopses at the first offline and online:
> 
>   Oops: divide error: 0000 [#1] SMP NOPTI
>   RIP: 0010:dl_server_apply_params+0x335/0x380
>   Call Trace:
>    sched_server_write_common.isra.0+0x1c0/0x260
>    full_proxy_write+0x58/0x90
>    vfs_write+0xcb/0x550
> 
> By reading, two other paths would divide by zero:
> - inactive_task_timer(), for a task that left SCHED_DEADLINE or died,
>   if its CPU went offline.
> - sched_setattr(SCHED_DEADLINE) on a task asleep on an offline CPU,
>   with admission control off.
> 
> Fix this by changing total_bw alone when the root domain has no active
> CPU.
> 
> With this patch, the reproducer survives 20 rounds with no warning.
> 
> Fixes: daec57983670 ("sched/deadline: Reclaim bandwidth not used by dl tasks")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: stable@vger.kernel.org
> ---

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

