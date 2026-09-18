Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC924A43F0;
	Fri, 18 Sep 2026 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736330; cv=none; b=ok7CTSwqXCU1C7jrVlNZ1ihW0mOmr9Fqu/1eHHhCiXCtBEbo5tuJWZz0v26mf1m/AAJnkdXmbAiZ83JJYTsxmou81fJ4RDnqxslE09FfqVRZ5fTkiripM1ZhsYg0uqYNx6UQvqwbg78aN2fxFNdo6YZtzJ7+H8KXTklh78Hagnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736330; c=relaxed/simple;
	bh=WxqZ61mMuVqMTe5YeTQl+SJ7FZkoLSJJCToLORqgHt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIWodWr5j7jbM+ulSpIpfV9a1TycuSkjjA03u5pieEcC3FnGjuMMoHV64g39MnpPMd0fv8MiJpJMbcsq9/Sr/bnEFfGGs3rE1K1dajVZoqaI/NX7lTutLJXn1HAZbXNwEhYcdAKXxqI3hZ4/IIikP+Zvy+J++ilmylIe7p3pumg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoaTwcqT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoaTwcqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D591F00898;
	Fri, 18 Sep 2026 12:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789736328;
	bh=MXNzm2EBtVrG5YWANXIx1ens6jQokApRm++6DNIyLho=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XoaTwcqT1v0uZ8DLx8mV+oKIzWxyzzPbESClbMZb+aw/KPnSEpJ31OUP/ozP2WJcb
	 zy7hjqz+floTcOOtyMGBZXw8dB8kjN4u4qsdWyGXiSbPBjlGKRmcJWvIyjOBOodau+
	 CnB/Pxxu5IQ4EiCZma5H/vbZW72d8E0c+NwzdYmCOzi8jZ1GO0WXBgdgEay2C9WQbN
	 ODjpt0llCNaevDSr7yaHa1/slFBNMrNf9PIW87u63O7rzDTnlTqJsmn4RSHKoDhcpB
	 zB1BkiIiJtidvLSRa1D69aXsgD/Uz2tsd3aXV1t8llB8RrXXzjZjmqbHZekC4aHQEC
	 EkAk58QZjwjAw==
Message-ID: <0ed3ab3a-80b4-492f-867a-0584441722a9@kernel.org>
Date: Fri, 18 Sep 2026 14:58:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] sched/numa: scan read-only file mappings in
 tiering mode
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
 <20260911001826.2109390-4-gourry@gourry.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260911001826.2109390-4-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/26 02:18, Gregory Price wrote:
> From: "Gregory Price (Meta)" <gourry@gourry.net>
> 
> Commit 4591ce4f2d22 ("sched/numa: Do not trap hinting faults for
> shared libraries") excludes read-only file mappings from NUMA hinting to
> prevent placement bouncing. This also hides hot file folios on slow memory
> from the tiering code.
> 
> Scan these mappings when memory tiering is enabled, but make their scans
> promotion-only. Ordinary NUMA placement retains the existing restriction.
> 
> On a host with 768 GB of DRAM and 256 GB of CXL memory running a roughly
> 430 GB database service, 169 MB of its 185 MB main binary accumulated on
> CXL before this change. Afterwards its tier residency tracked runtime load.
> 
> Fixes: c574bbe91703 ("NUMA balancing: optimize page placement for memory tiering system")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  kernel/sched/fair.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 81359b414947..e636e8de53f1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4061,6 +4061,16 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
>  	p->numa_faults_locality[local] += pages;
>  }
>  
> +/*
> + * Read-only file-backed mappings are expected to be cache replicated between
> + * accessor nodes, so they are not worth sampling for placement.  They can
> + * still strand on the slow tier like anything else.
> + */
> +static bool vma_is_ro_file(struct vm_area_struct *vma)
> +{
> +	return vma->vm_file && (vma->vm_flags & (VM_READ | VM_WRITE)) == VM_READ;


MAP_PRIVATE can easily map a read-only file with write permissions. So the
function name is a bit misleading.

This smells like a helper that should go next to other vma helpers and have
clear semantics.

> +}
> +
>  static void reset_ptenuma_scan(struct task_struct *p)
>  {
>  	/*
> @@ -4220,13 +4230,13 @@ static void task_numa_work(struct callback_head *work)
>  		}
>  
>  		/*
> -		 * Shared library pages mapped by multiple processes are not
> -		 * migrated as it is expected they are cache replicated. Avoid
> -		 * hinting faults in read-only file-backed mappings or the vDSO
> -		 * as migrating the pages will be of marginal benefit.
> +		 * Read-only file-backed folios are poor NUMA placement
> +		 * candidates, but slow-tier folios still need to be scanned for
> +		 * promotion.
>  		 */
>  		if (!vma->vm_mm ||
> -		    (vma->vm_file && (vma->vm_flags & (VM_READ|VM_WRITE)) == (VM_READ))) {
> +		    (vma_is_ro_file(vma) &&
> +		     !(numab_mode & NUMA_BALANCING_MEMORY_TIERING))) {

I'd vote for >80c here and but it into a singe line.

Or just use a magical helper

const bool tiering = numab_mode & NUMA_BALANCING_MEMORY_TIERING;

or sth like that.

>  			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_SHARED_RO);
>  			continue;
>  		}
> @@ -4306,7 +4316,8 @@ static void task_numa_work(struct callback_head *work)
>  			continue;
>  		}
>  
> -		promo_only = !(numab_mode & NUMA_BALANCING_NORMAL);
> +		promo_only = !(numab_mode & NUMA_BALANCING_NORMAL) ||
> +			     vma_is_ro_file(vma);

As I said, maybe that flag could be voided.

-- 
Cheers,

David
