Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45313E51DE;
	Fri, 25 Sep 2026 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333729; cv=none; b=DX02jrbdD4UrpzvzH4ZcSfdc4S4s4zK4omf9sLw26H7+aA6WvVeZyoF9J1RUOLxiL3MuJycosmrMjIFZ5grs1FEp5bdgAMAjedZw/71LgjcIYoJ5+qD8BiQkffQJTWHN6IclcSe1xX8IWTHxUkFhhl2l1k6oHcRhCTB8OqjNi50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333729; c=relaxed/simple;
	bh=90oCiblxcmMKki320b5oH8g1qw2hyPccBSLwPjfnkIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFeDrPFBGybRew0xJYUROnmwCATsN7VX5q/4HCybOJeWUPQrCUbbdt0NFBqyJp9xNmXyK+t2D0h6itytaCcnjZc5noPRLrQvO54yoijkh2JV5UnwWDt9G8UyuBv9KqGcm9v0ifJKYaWRhU69QD/gW12tXNyNR3SQXE+rmyrCcHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=konjO3sD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="konjO3sD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3820D1F000FF;
	Fri, 25 Sep 2026 10:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790333722;
	bh=ATppPA08cbrd3rkkrcMCwx3kOQ21INX+r6Ut92RHrGc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=konjO3sD23vveaJBinGM0SJByCg78KytyAQj8Pht9Dv5oz1t2mIBzNIe/XRlEdNJX
	 XnpYp27AgOerWofLyjYuQe4vlt30/DNLVeUbBBdPvonILl3DS1TXLEzSRF4EbYgTFS
	 mauWH0jz4ZCRYic2poGKUz4ee2pfoawHcb/fOhaunODCqLpsf9fbmfGTMa3MG1YlJV
	 Cm5/yDYv/IWyPnQ5MPTBmWji5IYL783VGrNjFn3Hb5FT/BVw0zf0xLxYVsWmKKJOWD
	 U23iyusaUTu7lwNj+0RdCqBlMpkDq370R2ueOlaYwhirmA41+ru+ohVYwOhqf0paF1
	 cWczDrPzDVMjw==
Message-ID: <ad99014e-3714-45a5-ad23-aa7fe72745cb@kernel.org>
Date: Fri, 25 Sep 2026 12:55:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] sched/numa: scan PID-inactive VMAs for promotion
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
 apopple@nvidia.com, jannh@google.com, pfalcato@suse.de, hannes@cmpxchg.org,
 shy828301@gmail.com, raghavendra.kt@amd.com, stable@vger.kernel.org
References: <20260922182928.2199090-1-gourry@gourry.net>
 <20260922182928.2199090-6-gourry@gourry.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260922182928.2199090-6-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 20:29, Gregory Price wrote:
> From: "Gregory Price (Meta)" <gourry@gourry.net>
> 
> Commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic") skips
> VMAs without recent PID activity. Since only NUMA hint faults record
> that activity, the filter can suppress the fault needed to promote hot
> slow-tier memory.
> 
> Let memory tiering bypass the PID scan filter. In combined mode, use the
> placement decision to restrict top-tier sampling to VMAs that need it,
> while inactive VMAs still receive promotion-only scans.
> 
> Track the last completed placement scan separately from scans of any
> kind. Promotion-only scans still update prev_scan_seq, but do not
> advance the placement-starvation horizon.
> 
> On a host with 768 GB of DRAM and 256 GB of CXL memory, one large shmem
> VMA consumed most scanning activity, while 2,537 other VMAs covering
> 84 GB were skipped as inactive. One stand-out result: a hot 20 GB hash
> table ended up trapped entirely on CXL and drove CXL bandwidth
> utilization beyond sustainable levels - resulting in a large regression.
> 
> With this series, the hot hash table ends up split evenly between DRAM
> and CXL, tier residency tracked runtime load, and CXL bandwidth
> utilization drops from 45GB/s (maxed) to 5-10GB/s, while DRAM bandwidth
> utilization increases from ~200GB/s to 250GB/s+, resulting in major
> throughput improvements for the database workload.
> 
> Fixes: fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
> Cc: stable@vger.kernel.org
> Assisted-by: OpenAI:gpt-5
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  include/linux/mm_types.h |  7 +++++++
>  kernel/sched/fair.c      | 26 +++++++++++++++++++++-----
>  2 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index fd35db969bc94..dcca3ead9db59 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -804,6 +804,13 @@ struct vma_numab_state {
>  	 */
>  	int prev_scan_seq;
>  
> +	/*
> +	 * MM scan sequence ID when the VMA was last scanned for placement.
> +	 * The starvation horizon in vma_needs_placement_scan() counts against
> +	 * this, so promotion-only scans cannot postpone placement indefinitely.
> +	 */
> +	int prev_placement_scan_seq;
> +
>  	/* Preserve placement-scan eligibility during an in-progress scan. */
>  	bool placement_scan;
>  };
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a2849e72c4e26..412c72084a63d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4097,7 +4097,7 @@ static bool vma_needs_placement_scan(struct mm_struct *mm,
>  	 * threads can help scan this vma, force a vma scan.
>  	 */
>  	if (READ_ONCE(mm->numa_scan_seq) >
> -	   (vma->numab_state->prev_scan_seq + get_nr_threads(current)))
> +	   (vma->numab_state->prev_placement_scan_seq + get_nr_threads(current)))
>  		return true;
>  
>  	return false;
> @@ -4267,7 +4267,8 @@ static void task_numa_work(struct callback_head *work)
>  			 * to prevent VMAs being skipped prematurely on the
>  			 * first scan:
>  			 */
> -			 vma->numab_state->prev_scan_seq = mm->numa_scan_seq - 1;
> +			vma->numab_state->prev_scan_seq = mm->numa_scan_seq - 1;
> +			vma->numab_state->prev_placement_scan_seq = mm->numa_scan_seq - 1;
>  		}
>  
>  		/*
> @@ -4300,10 +4301,13 @@ static void task_numa_work(struct callback_head *work)
>  		 * Do not scan the VMA if a task has not accessed it, unless no other
>  		 * VMA candidate exists. If a scan is already in-progress, finish it,
>  		 * but track continuation separately from starting a new one.
> +		 *
> +		 * The PID filter must not gate promotion. Allow PID-inactive VMAs
> +		 * to proceed when memory tiering is enabled.
>  		 */
>  		placement_due = vma_needs_placement_scan(mm, vma);
>  		scan_started = mm->numa_scan_offset > vma->vm_start;
> -		pid_scan_allowed = vma_pids_forced || placement_due;
> +		pid_scan_allowed = tiering || vma_pids_forced || placement_due;
>  
>  		if (!pid_scan_allowed) {
>  			if (scan_started) {
> @@ -4315,10 +4319,16 @@ static void task_numa_work(struct callback_head *work)
>  			}
>  		}
>  
> -		/* Keep scan policy stable while processing a VMA in chunks.*/
> +		/*
> +		 * Keep scan policy stable while processing a VMA in chunks.
> +		 * A fault in one chunk can make a VMA placement-eligible. Keep a
> +		 * promotion-only decision sticky for the rest of a partial scan.
> +		 */
>  		placement_scan &= numab_mode & NUMA_BALANCING_NORMAL;
>  		if (scan_started)
>  			placement_scan &= vma->numab_state->placement_scan;
> +		else if (tiering)
> +			placement_scan &= placement_due;

Same comment. Apart from that LGTM.

-- 
Cheers,

David
