Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794833945;
	b=qG4dssgso7yAsyfteOk3CRH5G8Ih53ANiQkgXSiQkPHyU4cMiQqfQp0kBXL4Tm/sb8MH
	 U9tO/4Qw7Y1GdgdxD0S5YDp0E7cDPcoKAt6sbtuVS2dkDijkZotSRz0HYz84g+oITXS6N
	 Ii/WYTin2xlO/MGdYxuAxphA8pCosa0Di04FHZKod5L/poEzuPfYHl+4wPY/fDInxKMRE
	 UXIyZHR9prUGTYWS7Glad/1Ve/fJGQGUB2gjUAPlgVYjnx4WYGR0FRMZ3M8ZmtVfjOrST
	 TnR7FkT69Mv2HWjGDLW7G7ssGc9Kk9EcOwHg/s72vhAZVykWB2iksW8ePK2L58GzjFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833945;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=staA6FwHbiBwqpCLIDokL/q1H41HZpyazxomLsaJBOs=;
	b=gEttsb461uJi1KF3qwHVCeE5wtLPsqiUXlrBXj5IkpxfwQmhpd6TGNOiOPRGhzUgQ0w/
	 IqcNp0g2O+ovy7OuiPaNq/ZJ3R83mlmrMhUUeBm/DNNEmFDVCJewaQQJ/1WoS14nkQJKD
	 Jw4b74yHVpFSOOxRFq9qHR+MEZohb4nrjx7Atbb0VGWgaQ1b3dPtapSlttsi8+UVpMxsy
	 zvwSARin4TPehuzUq9gndd0tEs2p8B7VLVZqOMiVV/1fvGoV/8sEQBgV6Qv+T9WCTqACg
	 2cg7pp/VnxbfFvW4bRHF64OUTWPwj3xqlGyw/XdK97cyNiJtQFm69G5sHPmMmmLeyxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=h8JqXobE;
	arc=none smtp.remote-ip=95.215.58.3
Received: from mta1.migadu.com (out-3.mta1.migadu.com [95.215.58.3])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F76606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 12:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2F76606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=h8JqXobE
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JQidkp1aImcxYe8L/9R0QpEw0bwKcclDKm8qpqJRAHI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794833942; v=1; x=1795438742;
 b=h8JqXobEkbdAobMtJr0K+EU3DHnHd6SAdiBpXbD+IemPBOvCcyL8aJCYiSTfZr0UY+Gdg2WE
 urGvhOlEKe/Crtt0QD8q63KOmBRQowfJ9yLHU7+Fd5X+c+5LTSHkoe3ZsHMV0qjSnHoGR2zhGld
 TEGy9ugLkmAaVD8xRU6cq25Q=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a7cf24b6a13c472c;
	Mon, 16 Nov 2026 12:59:02 +0000
X-Mizu-Trace-ID: a7cf24b6a13c472c
X-Migadu-Flow: FLOW_OUT
Date: Mon, 16 Nov 2026 21:00:14 +0800
From: Chen Yu <chen.yu@linux.dev>
To: Andrea Righi <arighi@nvidia.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Rik van Riel <riel@surriel.com>, Usama Arif <usama.arif@linux.dev>,
	peterz@infradead.org, mingo@redhat.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, samuelcrossley@gmail.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kas@kernel.org, Arnav Aghav <aghav@meta.com>
Subject: Re: [PATCH] Revert "sched/fair: Add SIS_UTIL support to
 select_idle_capacity()"
Message-ID: <avr-XumgYsrnA6vZ@three-body>
References: <20261113153157.2495664-1-usama.arif@linux.dev>
 <eba9d3df71f3f37bf7a318854a1ab6bf1cfb1981.camel@surriel.com>
 <CAKfTPtCJLci=Yzq6B0-hK5L0m5iQPw1Y0NDQhKEaV6reg-690g@mail.gmail.com>
 <avglp8nnc4u9OCb5@gpd4>
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
In-Reply-To: <avglp8nnc4u9OCb5@gpd4>

On Sat, Nov 14, 2026 at 10:11:03AM +0100, Andrea Righi wrote:
> Date: Sat, 14 Nov 2026 10:11:03 +0100
> From: Andrea Righi <arighi@nvidia.com>
> To: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Rik van Riel <riel@surriel.com>, Usama Arif <usama.arif@linux.dev>,
>  peterz@infradead.org, mingo@redhat.com, kprateek.nayak@amd.com,
>  juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
>  bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
>  samuelcrossley@gmail.com, linux-kernel@vger.kernel.org,
>  stable@vger.kernel.org, kas@kernel.org, Arnav Aghav <aghav@meta.com>
> Subject: Re: [PATCH] Revert "sched/fair: Add SIS_UTIL support to
>  select_idle_capacity()"
> 
> On Sat, Nov 14, 2026 at 09:18:30AM +0100, Vincent Guittot wrote:
> > On Fri, 13 Nov 2026 at 20:32, Rik van Riel <riel@surriel.com> wrote:
> > >
> > > On Fri, 2026-11-13 at 07:31 -0800, Usama Arif wrote:
> > > >
> > > > On a 72-CPU NVIDIA grace arm64 server, small reported capacity
> > > > differences
> > > > (1013-1024) within the single LLC activate asymmetric selection. Both
> > > > the reference and affected kernels were observed with a zero scan
> > > > hint. The reference kernel ignored it and still searched the domain.
> > > > A latency-sensitive, wakeup-heavy production workload saw its
> > > > reported
> > > > minute p50 latencies average 129 ms on the reference kernel and 223
> > > > ms
> > > > on the affected kernel.
> > > >
> > > > Disabling SIS_UTIL reduced the aggregate involuntary context switch
> > > > rate of worker main threads from 71.6k/s to 13.3k/s; re-enabling it
> > > > raised the rate to 73.7k/s.
> > >
> > > Afaik, the asymmetrical selection is supposed
> > > to solve a very specific problem: when a task
> > > requires X amount of CPU capacity to run, we
> > > try to avoid scheduling it on a CPU that has
> > > only a fraction of X available.
> > >
> > > This creates the issue that a task that appears
> > > to "need" exactly X, because it's been running
> > > on a CPU with full available capacity, ends up
> > > not being scheduled at all when the available
> > > idle core has X-3% available capacity, because
> > > that CPU happens to spend 3% of its time handling
> > > interrupts, or running something else.
> > 
> > The task will be scheduled on this idle cpu/core of (X-3% capacity) if
> > no other idle CPU with X capacity is available.
> > The selection in select_idle_capacity is:
> > - Idle core with enough capacity
> > - Idle core with enough capacity but doesn't fullfill uclamp_min
> > - Idle core that doesn't fit
> > - Idle CPU with enough capacity
> > - Idle CPU with enough capacity but doesn't fullfill uclamp_min
> > - Idle CPU that doesn't fit
> 
> Right, and when the scan budget is exhausted select_idle_capacity()
> returns the best idle candidate found so far, even if it doesn't fit.
> 
> However, in the zero-budget case, we return before examining any
> candidates in the scan domain. Relaxing the capacity-fit rule inside
> that scan wouldn't change the outcome, because we never reach that
> check.
> 
> Maybe Rik's suggestion could instead help with the earlier checks in
> select_idle_sibling()? Accepting an idle target, previous or recently
> used CPU whose capacity is "close enough" could avoid reaching the
> zero-budget bailout.
> 
> The tradeoff is that we'd accept a potentially weaker CPU immediately,
> without searching for a better one.
>

Do you something similar to cluster wakeup, give the wakeup a second chance to find an idle
CPU in the LLC. I suppose what you suggested is:

 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 470ba0dc6719..d1f3b179013e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9141,6 +9141,24 @@ static inline bool asym_fits_cpu(unsigned long util,
 	return true;
 }
 
+static int asym_idle_retry(struct task_struct *p, int prev, int target,
+			   int recent)
+{
+	if (choose_idle_cpu(target, p))
+		return target;
+
+	if (prev != target && cpus_share_cache(prev, target) &&
+	    choose_idle_cpu(prev, p))
+		return prev;
+
+	if (recent != prev && recent != target &&
+	    cpus_share_cache(recent, target) &&
+	    choose_idle_cpu(recent, p))
+		return recent;
+
+	return target;
+}
+
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
@@ -9149,7 +9167,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	bool has_idle_core = false;
 	struct sched_domain *sd;
 	unsigned long task_util, util_min, util_max;
-	int i, recent_used_cpu, prev_aff = -1;
+	int i, recent_used_cpu, recent, prev_aff = -1;
 
 	/*
 	 * On asymmetric system, update task utilization because we will check
@@ -9206,6 +9224,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 
 	/* Check a recently used CPU as a potential idle candidate: */
 	recent_used_cpu = p->recent_used_cpu;
+	recent = recent_used_cpu;
 	p->recent_used_cpu = prev;
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
@@ -9244,7 +9263,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 				target = i;
 				goto select_smt_priority;
 			}
-			return target;
+			return asym_idle_retry(p, prev, target, recent);
 		}
 	}
 
-- 
2.43.0

 
> Thanks,
> -Andrea
> 
> > 
> > >
> > > In that situation, it will be better to run the
> > > task on the CPU with 97% capacity right now,
> > > than to not run the task until a CPU frees up
> > > later.
> > >
> > > Things like SMT and power-driven hardware
> > > scaling complicate the matter further, because
> > > we simply cannot see the full amount of capacity
> > > that is available on each CPU.
> > >
> > > That makes me wonder if we should simply accept
> > > any CPU that's "close enough to X" when dealing
> > > with asymmetrical placement.
> > >
> > > Say, anything that's above 3/4 of the capacity
> > > of X would be considered good enough to run the task.
> > >
> > > That still prevents us from placing a CPU intensive
> > > task on a little core in a big.LITTLE system, or
> > > from placing a task on a CPU that spends 80% of its
> > > time handling interrupts, but it will allow a task
> > > to run right now, when the capacity imbalance is small.
> > >
> > > Does that make sense, or am I forgetting something
> > > important?
> > >
> > > --
> > > All Rights Reversed.
