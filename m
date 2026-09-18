Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78953CCFD4;
	Fri, 18 Sep 2026 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734427; cv=none; b=CQY9CDXcI1RHKDddyozCCTqiJQdsGNIyKvsRsHabQbJRk+q1TCuyrO7V9gmYSxCzKdImp766kpZxun5COf1AJ5Vt6ApGD/JRjjcjeXVHfTWj2BkMBYcUsYCiFB2XfBLkShvyMEeWYLIp7P1sQo5c6QPo9hAAeKXg/rW6hJ1LVwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734427; c=relaxed/simple;
	bh=g6n7JZzbjYjZbSWGytSX3bCkePTO6O2V3Ku3mGvGLro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvM6V15qTFO2JknCv9LZ7VPb+aINbImy1e0EdWRE9EL1Kb8W2pEtuI2TtfWj++LooD7KXFApCOhxaZjQTvugLh8AEiBVXzijYd55kY+nt4Lch96GEAJNKSd0x3lGiNGadARB/wBtLelwjX62jFSW0lcYS+axCEf8NUh8SHHEzdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmkN62DE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmkN62DE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BEB1F000FF;
	Fri, 18 Sep 2026 12:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789734425;
	bh=AFolMEjh1z/S0yqQI223cGvAUucHiz1wHTDAi3DJD78=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kmkN62DE5cKaSONPPCbLG8qhpj6R5MJPh0Se463fV5Sp/k0iRT18qNOEdHKXdI1w8
	 bbGQVdhLrmn2K7JxbvytZu9FtADvYJODPOK0DgVMtd9I1U9UQMz81MzGn3j98hjod0
	 uU69N5QObZH40/rmGMa+ecy2P16DM+5vY65M4lmktYCTOLlT7kAKwUsUWyCmVv90xM
	 JvrZMR3IHVm713GrQbKYolMVgg2bm4hICbZ0C3KvrmleqRjQrliGfTIizA0pezXFDS
	 Mi68EliPjpoZuVzSAMTz2XQs0jB9MbCS2L9MHC8S9eH3ma0O7oqfN4mUj+65CpgrUz
	 C6rXBaLo5puaA==
Message-ID: <4d2853c9-edf4-4685-b186-7214ed6abd84@kernel.org>
Date: Fri, 18 Sep 2026 14:26:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm: support promotion-only NUMA hinting scans
To: Gregory Price <gourry@gourry.net>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, nico.pache@linux.dev,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 jannh@google.com, pfalcato@suse.de, osalvador@suse.de, hannes@cmpxchg.org,
 raghavendra.kt@amd.com, stable@vger.kernel.org
References: <20260911001826.2109390-1-gourry@gourry.net>
 <20260911001826.2109390-2-gourry@gourry.net>
 <20260917160328.GM4121339@noisy.programming.kicks-ass.net>
 <aqwRX7Ula6ImRw3c@gourry-fedora-PF4VCD3F>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <aqwRX7Ula6ImRw3c@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/26 18:14, Gregory Price wrote:
> On Thu, Sep 17, 2026 at 06:03:28PM +0200, Peter Zijlstra wrote:
>> On Thu, Sep 10, 2026 at 08:18:23PM -0400, Gregory Price wrote:
>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 8dff37059faf..81359b414947 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -4129,8 +4129,10 @@ static void task_numa_work(struct callback_head *work)
>>>  	unsigned long nr_pte_updates = 0;
>>>  	long pages, virtpages;
>>>  	struct vma_iterator vmi;
>>> +	unsigned int numab_mode = READ_ONCE(sysctl_numa_balancing_mode);
>>
>> This thing sticks out like a sort thumb, does that want to be on top?
>> Typically reverse xmas is preferred and all that.
>>
> 
> oi yeah sorry, should have given this a closer style look.
> 
> will fix it up.
> 
>>>  	bool vma_pids_skipped;
>>>  	bool vma_pids_forced = false;
>>> +	bool promo_only;
>>>  
>>>  	WARN_ON_ONCE(p != container_of(work, struct task_struct, numa_work));
>>>  
>>
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -1237,11 +1237,12 @@ static inline bool vma_is_single_threaded_private(struct vm_area_struct *vma)
>>>  
>>>  #ifdef CONFIG_NUMA_BALANCING
>>>  bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
>>> -		bool is_private_single_threaded);
>>> +		bool is_private_single_threaded, bool promo_only);
>>
>> Two bools rather than updating the existing bool to a flags?
> 
> every time i've added a flag field someone screeches at me, so I tend
> to avoid it now - but i can do that's the preference here.
> 
> Otherwise, i tend to follow rule of 3 for generalizing.

The is_private_single_threaded only exists to repeatedly call
vma_is_single_threaded_private().

Maybe we don't care about that optimization.

So maybe move the vma_is_single_threaded_private() call into
folio_can_map_prot_numa() and avoid one bool entirely ... and then maybe just
pass the cp_flags?

-- 
Cheers,

David
