Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82C331222;
	Fri, 18 Sep 2026 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736508; cv=none; b=E/OU/IlF4SJUN8J9GdjqN0DobrQm4DQnN/+jEYmf1giTd3evkBF7m5fjSvIf3+82Uk2csXuLMNsltFPrEbCbQdYC/pphwQJZFIdQqfqrlA6PUkP0zuSzMRm9559xQ6yPP2NR3W/glbwdzGt0W2TDn60noELfHDphaKlkTQul+04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736508; c=relaxed/simple;
	bh=A0YCqCerf6OQiNmegnN4ibIcZmildcavxwaSxj7VHRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODi7HKwBw/PiFsTqpGGJadF4uLX3SkgWIHpz7MC4a9IxqJ9Y22+l7VGlh/y5xWb//3ap9PhI+JwdhRdgKUVAVIJmCZvPlVWfdLUvzWtElX9/H4ZoMZRPJ5ep/1FooanrqJC5+XYC+WLutRlCX9K/90ewMCPRZdxNk9RrDDWz0tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTFy3VJ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTFy3VJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055651F00898;
	Fri, 18 Sep 2026 13:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789736506;
	bh=jF0Fqx0D9BN/bx3T4LakfuQqI9yz0xCHFuvGoarFd6Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BTFy3VJ1gOB8D4G66EGthBw7gAJP9TwoZSDgcELlqZlHmEi+zVJwgMyp4pu3iTuYF
	 8jfoGBmhWIQTQo8SbaVKpfLaSIOwZ2tsMbgCfviOH3T9EJ6EMxQyAObWc+T17jNFvv
	 qFDD0YYyiSPx4Se1fJr3ZqgDv1tIsL21qjlwFzd8LVG0q1Yz7WMNgAIXhbx6TRoCxs
	 7J+C7fJmnwePAixORyLBtDzwukDqux8gh9CjzD9BZY9Pvt5cADAySTnlDxgPYUwpVn
	 ig9hj3YxTV0PMZlS2dWv9J9yK7TaaJpNp0YB5oSRvRnXot0WePLXFfCCe1a6J8VG32
	 bxSsI12AfxV8Q==
Message-ID: <e2695249-ea36-4a4e-a5ba-22bb5f7299d6@kernel.org>
Date: Fri, 18 Sep 2026 15:01:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] sched/numa: do not let VMA PID activity gate
 promotion
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 kprateek.nayak@amd.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev,
 kas@kernel.org, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, jannh@google.com, pfalcato@suse.de, osalvador@suse.de,
 hannes@cmpxchg.org, raghavendra.kt@amd.com, stable@vger.kernel.org
References: <20260911001826.2109390-1-gourry@gourry.net>
 <20260911001826.2109390-5-gourry@gourry.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260911001826.2109390-5-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/26 02:18, Gregory Price wrote:
> From: "Gregory Price (Meta)" <gourry@gourry.net>
> 
> Commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
> skips VMAs without recent PID activity. Since only NUMA hint faults record
> that activity, the filter can suppress the fault needed to promote hot
> slow-tier memory.
> 
> In tiering mode, scan PID-inactive VMAs using promotion-only scans.
> Reevaluate this choice whenever the scanner visits a VMA and pass it with
> each protection walk.
> 
> Record socket-placement scans in prev_placement_scan_seq. Promotion-only
> scans still update prev_scan_seq, but no longer postpone the starvation
> fallback for placement scans.
> 
> On a host with 768 GB of DRAM and 256 GB of CXL memory running two roughly
> 430 GB database workloads, a large shmem VMA occupied each scan while 2,537
> other VMAs covering 84 GB were skipped as inactive. A hot 20 GB hash table
> remained entirely on CXL before this change and was split evenly between
> DRAM and CXL afterwards.
> 
> Fixes: fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  include/linux/mm_types.h |  7 ++++++
>  kernel/sched/fair.c      | 48 ++++++++++++++++++++++++++--------------
>  2 files changed, 39 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5413bd10fff2..9f042d6ad465 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -803,6 +803,13 @@ struct vma_numab_state {
>  	 * A VMA is not eligible for scanning if prev_scan_seq == numa_scan_seq
>  	 */
>  	int prev_scan_seq;
> +
> +	/*
> +	 * MM scan sequence ID when the VMA was last scanned for placement.
> +	 * The starvation horizon in vma_is_accessed() counts against this, so
> +	 * promotion-only scans cannot postpone placement indefinitely.
> +	 */
> +	int prev_placement_scan_seq;
>  };
>  
>  #ifdef __HAVE_PFNMAP_TRACKING
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e636e8de53f1..6d1da13a2ef5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4085,6 +4085,10 @@ static void reset_ptenuma_scan(struct task_struct *p)
>  	p->mm->numa_scan_offset = 0;
>  }
>  
> +/*
> + * Decide whether this VMA should be sampled for NUMA placement.  In addition
> + * to recent accesses, periodically allow a scan to avoid starvation.
> + */
>  static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
>  {
>  	unsigned long pids;
> @@ -4101,22 +4105,13 @@ static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
>  	if (test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids))
>  		return true;
>  
> -	/*
> -	 * Complete a scan that has already started regardless of PID access, or
> -	 * some VMAs may never be scanned in multi-threaded applications:
> -	 */
> -	if (mm->numa_scan_offset > vma->vm_start) {
> -		trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_IGNORE_PID);
> -		return true;
> -	}
> -
>  	/*
>  	 * This vma has not been accessed for a while, and if the number
>  	 * the threads in the same process is low, which means no other
>  	 * threads can help scan this vma, force a vma scan.
>  	 */
>  	if (READ_ONCE(mm->numa_scan_seq) >
> -	   (vma->numab_state->prev_scan_seq + get_nr_threads(current)))
> +	   (vma->numab_state->prev_placement_scan_seq + get_nr_threads(current)))
>  		return true;
>  
>  	return false;
> @@ -4142,7 +4137,7 @@ static void task_numa_work(struct callback_head *work)
>  	unsigned int numab_mode = READ_ONCE(sysctl_numa_balancing_mode);
>  	bool vma_pids_skipped;
>  	bool vma_pids_forced = false;
> -	bool promo_only;
> +	bool accessed, scan_started, promo_only;
>  
>  	WARN_ON_ONCE(p != container_of(work, struct task_struct, numa_work));
>  
> @@ -4278,6 +4273,7 @@ static void task_numa_work(struct callback_head *work)
>  			 * first scan:
>  			 */
>  			 vma->numab_state->prev_scan_seq = mm->numa_scan_seq - 1;
> +			 vma->numab_state->prev_placement_scan_seq = mm->numa_scan_seq - 1;
>  		}
>  
>  		/*
> @@ -4307,17 +4303,30 @@ static void task_numa_work(struct callback_head *work)
>  		}
>  
>  		/*
> -		 * Do not scan the VMA if task has not accessed it, unless no other
> -		 * VMA candidate exists.
> +		 * The PID filter must not gate promotion.  Scan PID-inactive
> +		 * VMAs in tiering mode using promotion-only scans.
>  		 */
> -		if (!vma_pids_forced && !vma_is_accessed(mm, vma)) {
> +		accessed = vma_is_accessed(mm, vma);
> +		scan_started = mm->numa_scan_offset > vma->vm_start;
> +
> +		if (!vma_pids_forced && !accessed && !scan_started &&
> +		    !(numab_mode & NUMA_BALANCING_MEMORY_TIERING)) {
>  			vma_pids_skipped = true;
>  			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_PID_INACTIVE);
>  			continue;
>  		}
> +		if (!vma_pids_forced && !accessed &&
> +		    !(numab_mode & NUMA_BALANCING_MEMORY_TIERING) &&
> +		    scan_started)
> +			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_IGNORE_PID);
>  
> +		/*
> +		 * In combined mode, only VMAs the task uses need placement
> +		 * samples. Without tiering, every VMA reaching here does.
> +		 */
>  		promo_only = !(numab_mode & NUMA_BALANCING_NORMAL) ||
> -			     vma_is_ro_file(vma);
> +			     ((numab_mode & NUMA_BALANCING_MEMORY_TIERING) &&
> +			      !accessed) || vma_is_ro_file(vma);
>  
>  		do {
>  			start = max(start, vma->vm_start);
> @@ -4345,8 +4354,15 @@ static void task_numa_work(struct callback_head *work)
>  			cond_resched();
>  		} while (end != vma->vm_end);
>  
> -		/* VMA scan is complete, do not scan until next sequence. */
> +		/*
> +		 * VMA scan is complete, do not scan until next sequence.  A
> +		 * promotion-only scan reached the end of the VMA but did not
> +		 * sample placement, so it does not count towards the starvation
> +		 * horizon in vma_is_accessed().
> +		 */
>  		vma->numab_state->prev_scan_seq = mm->numa_scan_seq;
> +		if (!promo_only)
> +			vma->numab_state->prev_placement_scan_seq = mm->numa_scan_seq;


This is all rather ... messy. I mean, just look at that promo_only() computation ...

There must be a cleaner way ;)
-- 
Cheers,

David
