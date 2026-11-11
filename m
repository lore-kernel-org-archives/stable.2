Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.244
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437378;
	b=IE9MREnq/htRvzX8mnZccgjLwzj98mkp4Gnhi16X6YAD2U/C9ThP611NwVp2IGIzCmRk
	 drWrw3TaZsypZEvijK2cAWSQNhp1ZGpNw5vvW3gh+jRr/GymYD24gE8NNFD76UPjim58y
	 nis6b9YsY0QUbw4z9w9UN59ulrxqiROl6LWNw42PqIElp50F9eZwEoewqmN/BFMI6WU5/
	 AMjeogeYU58KaTrcYakrOmMc7/MKxrLz4fo5uI0R7n1ObLu7mzy6ijSOlBtwjdjwOmCl7
	 d0tTlHkmViYyUHcV9/vOJGB/VWt2MDw8qZafOD3F2DKG43DZNM6kafoKDvLUAfOaumg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437378;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=vQue7jLFUdSGesUi+3B7mc2JziPrIDnIULtffQJGgvg=;
	b=LgZCIVcQesNZkyzc5eelCHSJONsxuizbmmkiCEkCKA4+RE1iPVFmQ3dksp6t3tw7khpU
	 lbCC/LfcPbYexj2ElBIJQoL61CTv2g9K17pySV+WaIbZYrgiTHgWv8yccisXr7LDuu1Rz
	 13IXPiFV38atsO1MSMOr4NfvqgcAlBONkXkVgDbv+eI+BNU+mdmvg9ScqZIRrQbcQtNfD
	 CcUG5HZGQSBcHJQQHI6eq59tbaaR4LE2gMfMm6wL49iCUwTbkADjudl06KmPOWbQVaGHt
	 4EJimxjJU5V/w6VCC2whqAqhVIVuxaUWj5lNDec5S520QjF29JH8LO6W2l47tDBmXhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NGOjZg1k;
	arc=none smtp.remote-ip=91.218.175.244
Received: from mta0.migadu.com (out-244.mta0.migadu.com [91.218.175.244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E1A606A338
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04E1A606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NGOjZg1k
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TJQVUzglty5DBhKdqOJX7Uq+2tUl+AilQ8bRBeO+zoU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794437375; v=1; x=1795042175;
 b=NGOjZg1kEgy3pz8LKNVfq9xcU6WU08nFKlG0U3hFRV46SsAguTFXlvwzbAckX2UtQ8gBRTcm
 NMTDlX+JyjqrDjKcEJHtHyM1cfA9R1d8DeBSRuQjVllwxhNvPrnGRHsVvVN6RZZ+md/YzcF2nYp
 uImjB4h8am86aMNefRqQVhlo=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7aea4d3fde09893e;
	Wed, 11 Nov 2026 22:49:34 +0000
X-Mizu-Trace-ID: 7aea4d3fde09893e
X-Migadu-Flow: FLOW_OUT
Message-ID: <aa4c71b6-f81d-4544-96fa-ed54e78b0de1@linux.dev>
Date: Wed, 11 Nov 2026 22:49:34 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>,
 Chris Mason <mason@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Mark Brown <broonie@kernel.org>,
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/11/2026 18:13, Lorenzo Stoakes (ARM) wrote:
> The OOM killer can quickly trigger again after having selected a
> victim. That victim might not have freed its memory yet, but its mm will
> be marked MMF_OOM_SKIP by this point, so the OOM killer will ignore it.
> 
> This can cause the OOM killer to kill an innocent process when the first
> might have freed enough memory to relieve the memory pressure.
> 
> Fix the issue by freeing the memory before marking the mm MMF_OOM_SKIP.
> 
> Note that the task which calls mmput() might not be the victim - if it
> took a reference on the mm (e.g. ptrace), it may hold the last reference
> and release it when it calls mmput().
> 
> Therefore we cannot rely on current to tell whether the mm belongs to an
> OOM victim. Instead, partially revert commit b3541d912a84 ("mm: delete
> unused MMF_OOM_VICTIM flag") to reinstate MMF_OOM_VICTIM, which
> mark_oom_victim() sets on the victim's mm, and check that.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: bf3980c85212 ("mm: drop oom code from exit_mmap")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---

Makes sense, it will free an OOM victim’s pages before setting MMF_OOM_SKIP,
avoiding unnecessary additional kills.

Acked-by: Usama Arif <usama.arif@linux.dev>

>  include/linux/mm_types.h | 2 ++
>  include/linux/oom.h      | 9 +++++++++
>  mm/mmap.c                | 9 ++++++++-
>  mm/oom_kill.c            | 4 +++-
>  4 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 1ed35d258d2e..09e63ff12b04 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -2030,6 +2030,8 @@ enum {
>  #define MMF_TOPDOWN		31	/* mm searches top down by default */
>  #define MMF_TOPDOWN_MASK	BIT(MMF_TOPDOWN)
>  
> +#define MMF_OOM_VICTIM		32	/* mm is the oom victim */
> +
>  #define MMF_INIT_LEGACY_MASK	(MMF_DUMP_FILTER_MASK |\
>  				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
>  				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 00da05d227e6..a9390cb70541 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -76,6 +76,15 @@ static inline bool tsk_is_oom_victim(struct task_struct * tsk)
>  	return tsk->signal->oom_mm;
>  }
>  
> +/*
> + * Use this helper if tsk->mm != mm and the victim mm needs a special
> + * handling. This is guaranteed to stay true after once set.
> + */
> +static inline bool mm_is_oom_victim(struct mm_struct *mm)
> +{
> +	return mm_flags_test(MMF_OOM_VICTIM, mm);
> +}
> +
>  /*
>   * Checks whether a page fault on the given mm is still reliable.
>   * This is no longer true if the oom reaper started to reap the
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7618e72766a5..4cb18b217048 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1313,11 +1313,18 @@ void exit_mmap(struct mm_struct *mm)
>  	/* update_hiwater_rss(mm) here? but nobody should be looking */
>  	/* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
>  	unmap_vmas(&tlb, &unmap);
> +
> +	/*
> +	 * Free the memory before marking MMF_OOM_SKIP so a re-triggered OOM
> +	 * killer will only skip this mm if it's already freed all it can.
> +	 */
> +	if (mm_is_oom_victim(mm))
> +		tlb_flush_mmu(&tlb);
>  	mmap_read_unlock(mm);
>  
>  	/*
>  	 * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
> -	 * because the memory has been already freed.
> +	 * because the memory has been already unmapped.
>  	 */
>  	mm_flags_set(MMF_OOM_SKIP, mm);
>  	mmap_write_lock(mm);
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 5d48bd862c27..9de57a23893c 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -752,8 +752,10 @@ static void mark_oom_victim(struct task_struct *tsk)
>  		return;
>  
>  	/* oom_mm is bound to the signal struct life time. */
> -	if (!cmpxchg(&tsk->signal->oom_mm, NULL, mm))
> +	if (!cmpxchg(&tsk->signal->oom_mm, NULL, mm)) {
>  		mmgrab(tsk->signal->oom_mm);
> +		mm_flags_set(MMF_OOM_VICTIM, mm);
> +	}
>  
>  	/*
>  	 * Make sure that the process is woken up from uninterruptible sleep
> 

