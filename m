Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A431364942
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644346; cv=none; b=lhZshY+fcY0EBUp4HRd6pf1M5UQqYqk1GhCs4ipCJEaqYxGYieT6TLYgldmM6XMiXNQcQJUYYQFwbz7w9DtQcEiyWC4svcf+S2P5+zCrdjsejNMRc90dTvZe4DdCF4btx7syuoc2RUajRWZjh3UNrgM6aPcmRSbmLSAjir+Xecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644346; c=relaxed/simple;
	bh=Zu0/EO6c8y86A2VWn55EPlZcegV3WDcl8Om285gaziw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMXpmZ3GX2OPEULiTIv720mKaKCB30WtiRzDaNhquDJ/tTuDuNqVKIGboiBCX4EA0igU+5GWlfeC6M2Hs0KUvgDDJA6r1/EdC+OolhwpRSL4Fz18sLEBF+4LxwX6NUzHlF7IiVoBE/jl171D/LIEOBgDwHNS8D8JVxUsawhQxtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=hFNcZiTY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UlQJhT91; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="hFNcZiTY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UlQJhT91"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EFC6D7A00E9;
	Thu, 17 Sep 2026 07:25:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 17 Sep 2026 07:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789644342; x=1789730742; bh=cgr3r9mJVi
	tJNCwz7QDzseHu8Co6GQWX83aZrSkVS/Y=; b=hFNcZiTYrSNPxRVRyBQvz0R36p
	KTiRUcCbLNmjC4wkeIHE08AWZ36IMXb16dNW8YhZCxV9SmeCg7/A2jIeqsdTQFR+
	CA8MRWvdAkB0tYj47vuF5Vbv2LCPtYUsPJw3xhQDWUgxxYXPrgXGdEe6Ej/SpWPo
	+N/t+FOCi0Vb8L0hptKD5xdOCTiArObHCcub7SHbtZwdDoSQVob8kahXcf8HaVtk
	lMsqTUFCozQRBe9011KOTHNAh97BNU1xHpB/bjrK+68aw7YjGe+k/ktORsEBO6si
	eYRErN/aJA/rDoYDpReITzwdco1IMvUDqWVkA7y4JJXqCn6iUlwo2HbR34IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789644342; x=1789730742; bh=cgr3r9mJVitJNCwz7QDzseHu8Co6GQWX83a
	ZrSkVS/Y=; b=UlQJhT91NO9y8kbaBpFjRSVsABFp2Piqk+44QLNxCk4Lbl1a8RL
	3lTny1kzFCWUkolnQTThrmgiq3meSFQ4LlDXRbRvLQIO5J+itGHBxAGKOCiENzli
	O2/GkY2vOTgyT1YQfKXWYRYWteaB3Lc4KCbF8LqSpelVls8vbnoKoDccffNsuEu1
	dAWXYAK5Cu844lOUvvc0tJQa0gSx3B8znS1OdAIqrjsvLdxfUioVsffXNdkbcCUp
	7uTJ23fY0PSnHkeKT4OBmSalP7nLRdL9Sw9Xlk2cJd7s36YaQ0kgC7uzGjTFu6Ox
	ypIR9OR/TDudvDbX6a1/vwbyK6tdyptP5bg==
X-ME-Sender: <xms:Ns6rajvW0t9dbEgwukaUZOGA7C41XVdtCkQMoV5KpDgfQIuoCioZTQ>
    <xme:Ns6rajtxWIb_IsJ8eakmed0lHr1VR4xEK2KfQM5GVsTbN6-_vMGvlRtSDxaVI9J9s
    auaXOVyCZLTI6P1N2X947xR_39a7FjkFd54HC6ty8Aam3Wgjw>
X-ME-Received: <xmr:Ns6rapksJlBmL9E_DsDySrqQS66s6bTuOhIygbWl_ZLrktPmkszx7oixwNFX>
X-ME-Proxy-Cause: dmFkZTGKUAbpGA2Usp8G9w9Vm/eFwK51YZYoS68TfR1DLcM7QGlaXXpGq8GVARSYFl3LAr
    1VoaT6Rn+1GcbT6hH4TuyTt5RVIEYQMycrA3Er9h/RZQaeOZjiz8iVKokdlbedGv7k3IBI
    Hv8OZ8RZwcxQLD/dcw6NemyzSOdPeGDbodNTWKrcS2qUxQW8XRLQbFYuWRdy5ZuwCGa7KB
    cL2KRBvnjxdEf3DB6j/9ihBZy6yeQp9QcKlOOPHmHD6W5QmqDBLBzlTrMjxf0akT8HU24A
    kQIfAwLiE2PdBZH/4gPUVEGPRUZ3v2J7md5SgbWfB9mn5OOKPcaf9uywjZ7Rc724wd+BiQ
    R5rXK0ESY1Uosy8YTCObRjbBlONUTOme4YglMFWR4oVf+hO/i8oevSTEZ4Oer5om5lVhfz
    yAwtN1OImUapKLiFfb73yh5rpCeMHcQpavpavXCS+zauBG0qzyEo/stTw5koQaFAU2ncwf
    u8mCNr7c7oLB9NGxa04JjYPFBcxOdy4ZTLEMllSl5+a/CxHKIMYJA2TjvkvnWAkjSiRriu
    7iqoLsay6FWS2MvExldfUsGbPFSIsPo0KPDXaUdAm0+aiePh4C/8006WZigoxAN6AVJIFa
    Z88Lu3fXmQ/vSRvU9m39VI2yS0LK0+r0MeTjQGsAMmwt2OmKaQHxBl5i3WFw
X-ME-Proxy: <xmx:Ns6raptKMLTJH9Ez_vaHBY8WbtdknqFsjimBW5Y9qZqnrUtb_naA1g>
    <xmx:Ns6raoNOx3_t2DxVP0o_GI0OyOclv-cDrGVGQuHLIcT-mMdIwsmn6w>
    <xmx:Ns6raq1uLU9_tbkLIwjf-AVFF02F6WxnP9KjwOJPYF8V4RuMENHeZA>
    <xmx:Ns6raqx0V57cGj0_znG56vgLhZ2Y3KqdGHbBlTJgocssgeOK0Y1gdw>
    <xmx:Ns6rauj3UhAer_piiSYHCeRdiDGoXSTbGqeOyDJtyg_976B1ll5E7pVh>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 07:25:41 -0400 (EDT)
Date: Thu, 17 Sep 2026 12:22:00 +0100
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Lance Yang <lance.yang@linux.dev>, Oleg Nesterov <oleg@redhat.com>,
	Qian Cai <cai@lca.pw>, SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y 1/2] mm/kmemleak: avoid soft lockup when scanning
 task stacks
Message-ID: <2026091754-violation-overpass-c61d@gregkh>
References: <2026090345-doorpost-concur-ba65@gregkh>
 <20260903183242.1464421-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903183242.1464421-1-sashal@kernel.org>

On Thu, Sep 03, 2026 at 02:32:41PM -0400, Sasha Levin wrote:
> From: Breno Leitao <leitao@debian.org>
> 
> [ Upstream commit 5d10d4e19e6daa487f0cd0ea6cba472325de92f9 ]
> 
> Patch series "mm/kmemleak: avoid soft lockup when scanning task", v3.
> 
> kmemleak_scan() scans every task stack under one rcu_read_lock() with no
> reschedule point, which can trip the soft lockup watchdog on hosts with
> very many threads.
> 
> That prints the following message, depending on the workload+host
> configuration:
> 
>       watchdog: BUG: soft lockup - CPU#35 stuck for 22s! [kmemleak:537]
>        scan_block
>        kmemleak_scan
>        kmemleak_scan_thread
>        kthread
> 
> Patch 1 walks the tasks with find_ge_pid() so the scan reschedules between
> tasks
> 
> Patches 2-3 let the scan loops stop early once a scan is interrupted.
> 
> This patch (of 3):
> 
> kmemleak_scan() walks every thread and scans its kernel stack under a
> single rcu_read_lock() with no reschedule point.  On a host with very many
> threads -- amplified by KASAN/lockdep in debug builds -- this loop can hog
> a CPU long enough to trip the soft lockup watchdog:
> 
>   watchdog: BUG: soft lockup - CPU#35 stuck for 22s! [kmemleak:537]
>    scan_block
>    kmemleak_scan
>    kmemleak_scan_thread
>    kthread
> 
> A cond_resched() cannot be added directly: the loop runs inside an RCU
> read-side critical section.
> 
> Walk the tasks one PID at a time with find_ge_pid(), taking the RCU read
> lock only to look up and pin each task.  The stack is then scanned with no
> lock held, so cond_resched() runs between tasks and the scan stops early
> on scan_should_stop().  This follows the next_tgid()/task_seq_get_next()
> iteration pattern and keeps each RCU critical section short.
> 
> Link: https://lore.kernel.org/20260615-kmemleak-stack-resched-v3-0-acecd7d7fd92@debian.org
> Link: https://lore.kernel.org/20260615-kmemleak-stack-resched-v3-1-acecd7d7fd92@debian.org
> Fixes: c4b28963fd79 ("mm/kmemleak: rely on rcu for task stack scanning")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Stable-dep-of: 3541a2b06ecd ("mm/kmemleak: report RCU-tasks quiescent states during the scan")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  mm/kmemleak.c | 91 ++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 68 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 4092f38d3fc84..0dcdddb3c33d8 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1499,22 +1499,25 @@ static int scan_should_stop(void)
>  
>  /*
>   * Scan a memory block (exclusive range) for valid pointers and add those
> - * found to the gray list.
> + * found to the gray list. Return non-zero if the scan was interrupted.
>   */
> -static void scan_block(void *_start, void *_end,
> -		       struct kmemleak_object *scanned)
> +static int scan_block(void *_start, void *_end,
> +		      struct kmemleak_object *scanned)
>  {
>  	unsigned long *ptr;
>  	unsigned long *start = PTR_ALIGN(_start, BYTES_PER_POINTER);
>  	unsigned long *end = _end - (BYTES_PER_POINTER - 1);
>  	unsigned long flags;
> +	int stop = 0;
>  
>  	raw_spin_lock_irqsave(&kmemleak_lock, flags);
>  	for (ptr = start; ptr < end; ptr++) {
>  		unsigned long pointer;
>  
> -		if (scan_should_stop())
> +		if (scan_should_stop()) {
> +			stop = 1;
>  			break;
> +		}
>  
>  		kasan_disable_current();
>  		pointer = *(unsigned long *)kasan_reset_tag((void *)ptr);
> @@ -1524,22 +1527,28 @@ static void scan_block(void *_start, void *_end,
>  		pointer_update_refs(scanned, pointer, OBJECT_PERCPU);
>  	}
>  	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
> +
> +	return stop;
>  }
>  
>  /*
>   * Scan a large memory block in MAX_SCAN_SIZE chunks to reduce the latency.
> + * Return non-zero if the scan was interrupted.
>   */
>  #ifdef CONFIG_SMP
> -static void scan_large_block(void *start, void *end)
> +static int scan_large_block(void *start, void *end)
>  {
>  	void *next;
>  
>  	while (start < end) {
>  		next = min(start + MAX_SCAN_SIZE, end);
> -		scan_block(start, next, NULL);
> +		if (scan_block(start, next, NULL))
> +			return 1;
>  		start = next;
>  		cond_resched();
>  	}
> +
> +	return 0;
>  }
>  #endif
>  
> @@ -1670,6 +1679,43 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
>  	put_object(object);
>  }
>  
> +/*
> + * Scan all task kernel stacks, rescheduling between tasks. Each task is looked
> + * up and pinned within its own RCU read-side section, so no lock is held across
> + * the scan and the walk cannot trip the soft lockup watchdog.
> + */
> +static void kmemleak_scan_task_stacks(void)
> +{
> +	struct pid *pid;
> +	int nr = 1;
> +	int stop = 0;
> +
> +	do {
> +		struct task_struct *p = NULL;
> +
> +		rcu_read_lock();
> +		pid = find_ge_pid(nr, &init_pid_ns);
> +		if (pid) {
> +			nr = pid_nr(pid) + 1;
> +			p = pid_task(pid, PIDTYPE_PID);
> +			if (p)
> +				get_task_struct(p);
> +		}
> +		rcu_read_unlock();
> +
> +		if (p) {
> +			void *stack = try_get_task_stack(p);
> +
> +			if (stack) {
> +				stop = scan_block(stack, stack + THREAD_SIZE, NULL);
> +				put_task_stack(p);
> +			}
> +			put_task_struct(p);
> +		}
> +		cond_resched();
> +	} while (pid && !stop);
> +}
> +
>  /*
>   * Scan data sections and all the referenced memory blocks allocated via the
>   * kernel's standard allocators. This function must be called with the
> @@ -1681,6 +1727,7 @@ static void kmemleak_scan(void)
>  	struct zone *zone;
>  	int __maybe_unused i;
>  	int new_leaks = 0;
> +	int stop = 0;
>  
>  	jiffies_last_scan = jiffies;
>  
> @@ -1724,9 +1771,11 @@ static void kmemleak_scan(void)
>  
>  #ifdef CONFIG_SMP
>  	/* per-cpu sections scanning */
> -	for_each_possible_cpu(i)
> -		scan_large_block(__per_cpu_start + per_cpu_offset(i),
> -				 __per_cpu_end + per_cpu_offset(i));
> +	for_each_possible_cpu(i) {
> +		if (scan_large_block(__per_cpu_start + per_cpu_offset(i),
> +				     __per_cpu_end + per_cpu_offset(i)))
> +			goto scan_gray;
> +	}
>  #endif
>  
>  	/*
> @@ -1753,32 +1802,28 @@ static void kmemleak_scan(void)
>  			/* only scan if page is in use */
>  			if (page_count(page) == 0)
>  				continue;
> -			scan_block(page, page + 1, NULL);
> +			stop = scan_block(page, page + 1, NULL);
> +			if (stop)
> +				break;
>  		}
> +		if (stop)
> +			break;
>  	}
>  	put_online_mems();
> +	if (stop)
> +		goto scan_gray;
>  
>  	/*
>  	 * Scanning the task stacks (may introduce false negatives).
>  	 */
> -	if (kmemleak_stack_scan) {
> -		struct task_struct *p, *g;
> -
> -		rcu_read_lock();
> -		for_each_process_thread(g, p) {
> -			void *stack = try_get_task_stack(p);
> -			if (stack) {
> -				scan_block(stack, stack + THREAD_SIZE, NULL);
> -				put_task_stack(p);
> -			}
> -		}
> -		rcu_read_unlock();
> -	}
> +	if (kmemleak_stack_scan)
> +		kmemleak_scan_task_stacks();
>  
>  	/*
>  	 * Scan the objects already referenced from the sections scanned
>  	 * above.
>  	 */
> +scan_gray:
>  	scan_gray_list();
>  
>  	/*
> -- 
> 2.53.0
> 
> 

Does not apply
