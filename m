Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8876A3F164E;
	Thu,  1 Oct 2026 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851505; cv=none; b=FP96T5M61uCLzLDDahZx3r82DMeJQAFPF5JN0FkT0K+uZwdZudnUq/1wGj8wVmyk7j4cCuGiCJC6j8jrK+vrzPbcWFUN/0Gv2Jil4YbZh9s4F56uU2qZaqgTiQ2qPeMLvMitpoqyxneUNwtmu58ksjB7RgM/cwWrZbZ0MwGYN6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851505; c=relaxed/simple;
	bh=or3zDAVnoMEjDac7Yd8t7AgkXnX/RGI9otXPhSVH6xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EncXkl237OjLG3t2T5EkiQp2rCHC0C5uJpSJ7Q2NeJ38wXbs9gtiWpD2bSejF2RwAsV5NG4Qo5erxHvMfw+eZDnvN/WcqtC9G16G8Q+hr2UGT5DKaDSY427/8EHdAhxjI9doipIc24fwvyrNd8BekVWG1ZREZsLetXXYihqkNng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXyYcsq9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXyYcsq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC961F00898;
	Thu,  1 Oct 2026 10:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851504;
	bh=xS811ek91+cRnLcRHo+xdG9TRcDiTFjS6kYimGRgBZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AXyYcsq9/FFTDLVDfuaLhYscCqLUFDph4zsoXj5QTlmOADNMX51iD0SkOytpuf5MO
	 On7NZDhoFLjM6CWVW2gzFEcvlQfJlOxXWG7tWYqM47OAMu7KAyTJd7YFvQOmfAC17f
	 pUVold2MOFnaPPOqct7QNwYVg+o854Z573vOoPA2MqB1mA056rQO7/yQCAetpOVFcR
	 DU96bxWqJMrGQzyE+IpFrPq0TBmt2WYo1ugFcGZcDcEtbALPfyGcbim8nxi0gLfM37
	 GlcYsri4WfmEBwTtjSQrTwwgvb8pzlnlZMraSyWbadX19Qf1ifbAwyTUxBkutck3ZK
	 jzOuD2flcr5bw==
Message-ID: <e1728faa-5d50-48af-8ba0-5098be9124eb@kernel.org>
Date: Thu, 1 Oct 2026 12:44:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] sched/numa: separate VMA placement from scan
 continuation
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
 kas@kernel.org, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 ying.huang@linux.alibaba.com, matthew.brost@intel.com, byungchul@sk.com,
 apopple@nvidia.com, jannh@google.com, pfalcato@suse.de, hannes@cmpxchg.org,
 shy828301@gmail.com, osalvador@suse.de, raghavendra.kt@amd.com,
 stable@vger.kernel.org
References: <20260930112206.205083-1-gourry@gourry.net>
 <20260930112206.205083-5-gourry@gourry.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260930112206.205083-5-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/26 13:22, Gregory Price wrote:
> From: "Gregory Price (Meta)" <gourry@gourry.net>
> 
> vma_is_accessed() returns true both when a VMA needs placement
> (east-west) sampling and when a VMA is already mid-scan across
> multiple scan windows.
> 
> Callers cannot distinguish placement eligibility from scan progress.
> 
> Rename the helper to vma_needs_placement_scan() and handle continuation
> state in task_numa_work(). Record whether an in-progress VMA scan is
> promotion-only so a scan resumed in a later scan window finishes with
> the policy it started with. The zeroed initial state places no
> restriction, so a resumed scan that finds freshly allocated NUMAB state
> falls back to the default policy.
> 
> This separation allows PID-inactive VMAs to be scanned for promotion
> without treating scan continuation as evidence of placement eligibility.
> It is a prerequisite for the following fix and must accompany it when
> backported.
> 
> Fixes: fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  include/linux/mm_types.h |  6 ++++++
>  kernel/sched/fair.c      | 40 ++++++++++++++++++++++++----------------
>  2 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 1bd3ca7bfff2..d0ac21d02c47 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -803,6 +803,12 @@ struct vma_numab_state {
>  	 * A VMA is not eligible for scanning if prev_scan_seq == numa_scan_seq
>  	 */
>  	int prev_scan_seq;
> +
> +	/*
> +	 * The in-progress scan of this VMA is promotion-only.
> +	 * Resumed scans finish with the policy they started with.
> +	 */
> +	bool promo_only;
>  };
>  
>  #ifdef __HAVE_PFNMAP_TRACKING
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ab9afd3ad49b..3b30786ded3b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4082,7 +4082,8 @@ static void reset_ptenuma_scan(struct task_struct *p)
>  	p->mm->numa_scan_offset = 0;
>  }
>  
> -static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
> +static bool vma_needs_placement_scan(struct mm_struct *mm,
> +		struct vm_area_struct *vma)

mm can be had from vma->vm_mm, so likely sufficient to only pass the vma?

Apart from that this looks much clearer to me

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
